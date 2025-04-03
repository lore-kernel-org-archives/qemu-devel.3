Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E42C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 08:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0FfW-0001Oz-Sn; Thu, 03 Apr 2025 04:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u0FfT-0001OV-QP
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 04:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u0FfQ-0001I8-Uu
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 04:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743667874;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw5MDRBHqeo6dcp58yChqmXZDDdCUU9CrG94rPdi9i4=;
 b=dH/IU/l6tPJNwAFJ073LLXGncQypblzGlpuIm90gJxXFyzBt75BxFtuj9pYyW/gKJn2xvQ
 7kjZjggzf2jhvFnY5BOD0DuGnY8iN+d4TaGAFpyEtH4KlqBS1d//9K+TOTLJBTAuSzo0Wm
 yq36KfB72cs46x9Ub1DveixT4lPcTME=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-f5YhcdsaMBGO9gkLDIruJw-1; Thu,
 03 Apr 2025 04:11:10 -0400
X-MC-Unique: f5YhcdsaMBGO9gkLDIruJw-1
X-Mimecast-MFC-AGG-ID: f5YhcdsaMBGO9gkLDIruJw_1743667869
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4DAB195605E; Thu,  3 Apr 2025 08:11:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8653A1954B01; Thu,  3 Apr 2025 08:10:59 +0000 (UTC)
Date: Thu, 3 Apr 2025 09:10:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 49/65] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Message-ID: <Z-5Ces2kGrB67aPw@redhat.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-50-xiaoyao.li@intel.com>
 <Zv7dtghi20DZ9ozz@redhat.com>
 <0e15f14b-cd63-4ec4-8232-a5c0a96ba31d@intel.com>
 <Z-1cm6cEwNGs9NEu@redhat.com>
 <a3a8ed8d-9994-42c9-ba3b-ef59d6977ce6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3a8ed8d-9994-42c9-ba3b-ef59d6977ce6@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 03, 2025 at 03:28:43PM +0800, Xiaoyao Li wrote:
> On 4/2/2025 11:49 PM, Daniel P. Berrangé wrote:
> > On Wed, Apr 02, 2025 at 11:26:11PM +0800, Xiaoyao Li wrote:
> > > 
> > > I guess the raw mode was introduced due to the design was changed to let
> > > guest kernel to forward to TD report to host QGS via TDVMCALL instead of
> > > guest application communicates with host QGS via vsock, and Linux TD guest
> > > driver doesn't integrate any QGS protocol but just forward the raw TD report
> > > data to KVM.
> > > 
> > > > IMHO, QEMU should be made to pack & unpack the TDX report from
> > > > the guest into the GET_QUOTE_REQ / GET_QUOTE_RESP messages, and
> > > > this "raw" mode should be removed to QGS as it is inherantly
> > > > dangerous to have this magic protocol overloading.
> > > 
> > > There is no enforcement that the input data of TDVMCALL.GetQuote is the raw
> > > data of TD report. It is just the current Linux tdx-guest driver of tsm
> > > implementation send the raw data. For other TDX OS, or third-party driver,
> > > they might encapsulate the raw TD report data with QGS message header. For
> > > such cases, if QEMU adds another layer of package, it leads to the wrong
> > > result.
> > 
> > If I look at the GHCI spec
> > 
> >    https://cdrdv2-public.intel.com/726790/TDX%20Guest-Hypervisor%20Communication%20Interface_1.0_344426_006%20-%2020230311.pdf
> > 
> > In "3.3 TDG.VP.VMCALL<GetQuote>", it indicates the parameter is a
> > "TDREPORT_STRUCT". IOW, it doesn't look valid to allow the guest to
> > send arbitrary other data as QGS protocol messages.
> 
> In table 3-7, the description of R12 is
> 
>   Shared GPA as input - the memory contains a TDREPORT_STRUCT.
>   The same buffer is used as output - the memory contains a TD Quote.
> 
> table 3-10, describes the detailed format of the shared GPA:
> 
> starting from offset 24 bytes, it is the "Data"
> 
>   On input, the data filled by TD with input length. The data should
>   include TDREPORT_STRUCT. TD should zeroize the remaining buffer to
>   avoid information leak if size of shared GPA (R13) > Input Length.
> 
> It uses the word "contains" and "include", but without "only". So it is not
> clear to me.
> 
> I will work with internal attestation folks to make it clearer that who (TD
> guest or host VMM) is responsible to encapsulate the raw TDERPORT_STRCUT
> with QGS MSG protocol, and update the spec accordingly.

To be clear, my strong preference is that the spec be updated to only
permit the raw TDREPORT_STRUCT.

IMHO allowing arbitrary QGS MSGs would be a significant host security
weakness, as it exposes a huge amount of the QGS codebase to direct
attack from the guest. QEMU needs to be able to block that attack
vector. Without that, the benefit/value of shuffling of TDREPORTs via
the GetQuote hypercall is largely eliminated, and might as well have
just exposed QGS over VSOCK.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


