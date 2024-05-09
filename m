Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03488C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 14:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s54Uh-0001Fm-OM; Thu, 09 May 2024 10:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s54Ue-0001Ap-9Q
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s54Ub-0006gt-RI
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715263888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MwDf4z2qPk9gIInCEQqfGV/TxXqVFqrdl4H4xc+6TvM=;
 b=Fk7oUK3OM9DBaM30wBGf39++PnCvDZ8SfAYMZWNAXw3d8H6r+C8WKNTtZHSgi6YYo7uKX8
 QAOEkLBur6uFJ0UxYN2sb5S+nK8VSGeLFS0Z+2kFWCf8/c/XWgrU/oAZayGNuqpkRhB29T
 WPe/an5b6T/g1m1s3z5mmZv2ugFPsW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yXt33DdxN3G2tAfz5FD_og-1; Thu, 09 May 2024 10:11:22 -0400
X-MC-Unique: yXt33DdxN3G2tAfz5FD_og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F806800656;
 Thu,  9 May 2024 14:11:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62ADC403BF6F;
 Thu,  9 May 2024 14:11:17 +0000 (UTC)
Date: Thu, 9 May 2024 15:11:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, weijiang.yang@intel.com,
 philmd@linaro.org, dwmw@amazon.co.uk, paul@xen.org,
 joao.m.martins@oracle.com, qemu-devel@nongnu.org,
 mtosatti@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, yang.zhong@intel.com,
 jing2.liu@intel.com, vkuznets@redhat.com, michael.roth@amd.com,
 wei.huang2@amd.com, bdas@redhat.com, eduardo@habkost.net,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3] target/i386: Fix CPUID encoding of Fn8000001E_ECX
Message-ID: <ZjzZgmt-UMFsGjvZ@redhat.com>
References: <20240102231738.46553-1-babu.moger@amd.com>
 <0ee4b0a8293188a53970a2b0e4f4ef713425055e.1714757834.git.babu.moger@amd.com>
 <89911cf2-7048-4571-a39a-8fa44d7efcda@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89911cf2-7048-4571-a39a-8fa44d7efcda@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 09, 2024 at 04:54:16PM +0300, Michael Tokarev wrote:
> 03.05.2024 20:46, Babu Moger wrote:
> > Observed the following failure while booting the SEV-SNP guest and the
> > guest fails to boot with the smp parameters:
> > "-smp 192,sockets=1,dies=12,cores=8,threads=2".
> > 
> > qemu-system-x86_64: sev_snp_launch_update: SNP_LAUNCH_UPDATE ret=-5 fw_error=22 'Invalid parameter'
> > qemu-system-x86_64: SEV-SNP: CPUID validation failed for function 0x8000001e, index: 0x0.
> > provided: eax:0x00000000, ebx: 0x00000100, ecx: 0x00000b00, edx: 0x00000000
> > expected: eax:0x00000000, ebx: 0x00000100, ecx: 0x00000300, edx: 0x00000000
> > qemu-system-x86_64: SEV-SNP: failed update CPUID page
> ...
> > Cc: qemu-stable@nongnu.org
> > Fixes: 31ada106d891 ("Simplify CPUID_8000_001E for AMD")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > v3:
> >    Rebased to the latest tree.
> >    Updated the pc_compat_9_0 for the new flag.
> 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 08c7de416f..46235466d7 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -81,6 +81,7 @@
> >   GlobalProperty pc_compat_9_0[] = {
> >       { TYPE_X86_CPU, "guest-phys-bits", "0" },
> >       { "sev-guest", "legacy-vm-type", "true" },
> > +    { TYPE_X86_CPU, "legacy-multi-node", "on" },
> >   };
> 
> Should this legacy-multi-node property be added to previous
> machine types when applying to stable?  How about stable-8.2
> and stable-7.2?

machine types are considered to express a fixed guest ABI
once part of a QEMU release. Given that we should not be
changing existing machine types in stable branches.

In theory we could create new "bug fix" machine types in stable
branches. To support live migration, we would then need to also
add those same stable branch "bug fix" machine type versions in
all future QEMU versions. This is generally not worth the hassle
of exploding the number of machine types.

If you backport the patch, minus the machine type, then users
can still get the fix but they'll need to manually set the
property to enable it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


