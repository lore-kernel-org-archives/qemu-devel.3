Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A997C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRcW-0001ra-JO; Tue, 20 Feb 2024 10:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRc9-0001rI-4N
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:00:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRc7-0002pO-Bd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708441253;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BP1/D9T5lLOOldU147z4jqqUyEgTgRB4h3BUUOmlTD4=;
 b=bm7cuf+Ao+ENvItoGRsVp5x4OIN18092ZnxOD9iorZszI/vl3zcFP1PTpek5pT7q9zIwEy
 48Rb5DkC2piiK9rbdaBB9ncaMuApXG3pmmctuphFNPWGZhuv4VaViOnLmCOZ7JZkkXNqJ0
 y/1n0FETIqZuafoU7qF9ojSsHzkacXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-o4lo3kIAP2KkyvzoareXFg-1; Tue,
 20 Feb 2024 10:00:45 -0500
X-MC-Unique: o4lo3kIAP2KkyvzoareXFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E4F6280A9A2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 15:00:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4B3C185C0;
 Tue, 20 Feb 2024 15:00:42 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:00:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZdS-mEbSVZqw0tQY@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
 <Zbf8hradcHeeEXae@redhat.com> <CZ9YLSITF57Y.2WGV9XEFH7755@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZ9YLSITF57Y.2WGV9XEFH7755@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 03:00:56PM +0100, Anthony Harivel wrote:
> Daniel P. Berrangé, Jan 29, 2024 at 20:29:
> > On Thu, Jan 25, 2024 at 08:22:14AM +0100, Anthony Harivel wrote:
> > > diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
> > > new file mode 100644
> > > index 000000000000..04d27c198fc0
> > > --- /dev/null
> > > +++ b/docs/specs/rapl-msr.rst
> > > @@ -0,0 +1,133 @@
> > > +================
> > > +RAPL MSR support
> > > +================
> >
> > > +
> > > +Current Limitations
> > > +-------------------
> > > +
> > > +- Works only on Intel host CPUs because AMD CPUs are using different MSR
> > > +  addresses.
> >
> > The privileged helper program is validating an allow list of MSRs.
> >
> > If those MSRs are only correct on Intel hosts, then the validation
> > is incomplete, and it could be allowing unprivileged processes on
> > AMD hosts to access forbidden MSRS whose address happen to clash
> > with the Intel RAPL MSRs.
> >
> > IOW, the privileged helper needs to call cpuid() and validate that
> > the current host vendor is Intel.
> >
> > I suspect we also need a feature check of some kind to validate
> > that the intel processor supports this features, since old ones
> > definitely didn't, and we shouldn't assume all future ones will
> > either.
> >
> 
> To validate that the processor supports the RAPL feature I propose
> to check this on the Host:
> 
> $ cat /sys/class/powercap/intel-rapl/enabled
> 1
> 
> 
> The only down side is that INTEL RAPL drivers needs to be
> mounted then. We don't need it because we directly read the MSRs.

Awkward. I've looked around in the kernel drivers and didn't uncover
any better option than this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


