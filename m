Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B20E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXghC-0006RC-3v; Tue, 14 Jan 2025 08:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tXgh9-0006Qn-Mi
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tXgh6-0002MA-VB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736860255;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGHHBmOGpsuBsX8OZWLFpO4tzTq+JjwuPT2l6nduU/o=;
 b=DEOk8YwZEV4fCSnMqM25CLdMBJVRORsE6xpnEDArgTwnBsCX6Xbxnn5KmmTbZ054EJRikm
 6CzEwsRu85FgBkDqL1ysk29spiVVdaEOxAzp/z7xuOFNSwETZ1NrHMA+Or+NbFFlKFMdDL
 eCLO5PkFSeUYLcePnADYyJnv2M1eJAU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-QexzhuxaPIGukuYxY01GhA-1; Tue,
 14 Jan 2025 08:10:52 -0500
X-MC-Unique: QexzhuxaPIGukuYxY01GhA-1
X-Mimecast-MFC-AGG-ID: QexzhuxaPIGukuYxY01GhA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 674681956053; Tue, 14 Jan 2025 13:10:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CC8D19560AD; Tue, 14 Jan 2025 13:10:44 +0000 (UTC)
Date: Tue, 14 Jan 2025 13:10:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 34/60] i386/tdx: implement tdx_cpu_realizefn()
Message-ID: <Z4ZiUcMpDpBCHEc6@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-35-xiaoyao.li@intel.com>
 <82b74218-f790-4300-ab3b-9c41de1f96b8@redhat.com>
 <2bedfcda-c2e7-4e5b-87a7-9352dfe28286@intel.com>
 <44627917-a848-4a86-bddb-20151ecfd39a@redhat.com>
 <Z1td_BZPlZ5G9Zaq@iweiny-mobl>
 <8d56ba39-ce9e-4afb-abd1-25cb393214a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d56ba39-ce9e-4afb-abd1-25cb393214a5@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 14, 2025 at 04:52:07PM +0800, Xiaoyao Li wrote:
> On 12/13/2024 6:04 AM, Ira Weiny wrote:
> > On Tue, Nov 05, 2024 at 12:53:25PM +0100, Paolo Bonzini wrote:
> > > On 11/5/24 12:38, Xiaoyao Li wrote:
> > > > On 11/5/2024 6:06 PM, Paolo Bonzini wrote:
> > > > > On 11/5/24 07:23, Xiaoyao Li wrote:
> > > > > > +static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
> > > > > > +                              Error **errp)
> > > > > > +{
> > > > > > +    X86CPU *cpu = X86_CPU(cs);
> > > > > > +    uint32_t host_phys_bits = host_cpu_phys_bits();
> > > > > > +
> > > > > > +    if (!cpu->phys_bits) {
> > > > > > +        cpu->phys_bits = host_phys_bits;
> > > > > > +    } else if (cpu->phys_bits != host_phys_bits) {
> > > > > > +        error_setg(errp, "TDX only supports host physical bits (%u)",
> > > > > > +                   host_phys_bits);

If keeping this check in next version of the patches, for improved debugging,
can you include both values here eg something like

error_setg(errp, "TDX requires guest CPU physical bits (%u) "
                 "to match host CPU physical bits (%u)",
                 cpu->phys_bits, host_phys_bits);



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


