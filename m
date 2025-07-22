Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51218C83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueAy0-0007yg-S2; Tue, 22 Jul 2025 07:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueAxw-0007qd-Nm
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueAxt-0003wJ-TF
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753182917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mt8jXBBN3/FYmXBz7vV+NEqaPPHu8BExBrX0Pgzpuc0=;
 b=IV2AaMYKpgjbaLmYnwli+FyD/4ZU5FGhMepnKrZppQh23pW50zs+t8p2RQ4kNrbyHcsmV5
 O46sLZYA0zb8MV58zHiqm7fL6MotsnIbRuRboaneiW5p71YSVcoX9vWsnl/erAjk298xIh
 7zOf0m7cJ2AzQS6cGL79EpyTeVP08Q0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-2pTsa4eXMcO-_W4FgJzQLQ-1; Tue,
 22 Jul 2025 07:15:13 -0400
X-MC-Unique: 2pTsa4eXMcO-_W4FgJzQLQ-1
X-Mimecast-MFC-AGG-ID: 2pTsa4eXMcO-_W4FgJzQLQ_1753182912
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DB11800C3F; Tue, 22 Jul 2025 11:15:11 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FB3E180035E; Tue, 22 Jul 2025 11:15:09 +0000 (UTC)
Date: Tue, 22 Jul 2025 12:15:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Mathias Krause <minipli@grsecurity.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] i386/kvm: Disable hypercall patching quirk by default
Message-ID: <aH9yuVcUJQc4_-vP@redhat.com>
References: <20250619194204.1089048-1-minipli@grsecurity.net>
 <41a5767e-42d7-4877-9bc8-aa8eca6dd3e3@intel.com>
 <b8336828-ce72-4567-82df-b91d3670e26c@grsecurity.net>
 <3f58125c-183f-49e0-813e-d4cb1be724e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f58125c-183f-49e0-813e-d4cb1be724e8@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 22, 2025 at 06:27:45PM +0800, Xiaoyao Li wrote:
> On 7/22/2025 5:21 PM, Mathias Krause wrote:
> > On 22.07.25 05:45, Xiaoyao Li wrote:
> > > On 6/20/2025 3:42 AM, Mathias Krause wrote:
> > > > KVM has a weird behaviour when a guest executes VMCALL on an AMD system
> > > > or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
> > > > exception (#UD) as they are just the wrong instruction for the CPU
> > > > given. But instead of forwarding the exception to the guest, KVM tries
> > > > to patch the guest instruction to match the host's actual hypercall
> > > > instruction. That is doomed to fail as read-only code is rather the
> > > > standard these days. But, instead of letting go the patching attempt and
> > > > falling back to #UD injection, KVM injects the page fault instead.
> > > > 
> > > > That's wrong on multiple levels. Not only isn't that a valid exception
> > > > to be generated by these instructions, confusing attempts to handle
> > > > them. It also destroys guest state by doing so, namely the value of CR2.
> > > > 
> > > > Sean attempted to fix that in KVM[1] but the patch was never applied.
> > > > 
> > > > Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
> > > > conceptually be disabled. Paolo even called out to add this very
> > > > functionality to disable the quirk in QEMU[3]. So lets just do it.
> > > > 
> > > > A new property 'hypercall-patching=on|off' is added, for the very
> > > > unlikely case that there are setups that really need the patching.
> > > > However, these would be vulnerable to memory corruption attacks freely
> > > > overwriting code as they please. So, my guess is, there are exactly 0
> > > > systems out there requiring this quirk.
> > > 
> > > The default behavior is patching the hypercall for many years.
> > > 
> > > If you desire to change the default behavior, please at least keep it
> > > unchanged for old machine version. i.e., introduce compat_property,
> > > which sets KVMState->hypercall_patching_enabled to true.
> > 
> > Well, the thing is, KVM's patching is done with the effective
> > permissions of the guest which means, if the code in question isn't
> > writable from the guest's point of view, KVM's attempt to modify it will
> > fail. This failure isn't transparent for the guest as it sees a #PF
> > instead of a #UD, and that's what I'm trying to fix by disabling the quirk.
> > 
> > The hypercall patching was introduced in Linux commit 7aa81cc04781
> > ("KVM: Refactor hypercall infrastructure (v3)") in v2.6.25. Until then
> > it was based on a dedicated hypercall page that was handled by KVM to
> > use the proper instruction of the KVM module in use (VMX or SVM).
> > 
> > Patching code was fine back then, but the introduction of DEBUG_RO_DATA
> > made the patching attempts fail and, ultimately, lead to Paolo handle
> > this with commit c1118b3602c2 ("x86: kvm: use alternatives for VMCALL
> > vs. VMMCALL if kernel text is read-only").
> > 
> > However, his change still doesn't account for the cross-vendor live
> > migration case (Intel<->AMD), which will still be broken, causing the
> > before mentioned bogus #PF, which will just lead to misleading Oops
> > reports, confusing the poor souls, trying to make sense of it.
> > 
> > IMHO, there is no valid reason for still having the patching in place as
> > the .text of non-ancient kernel's  will be write-protected, making
> > patching attempts fail. And, as they fail with a #PF instead of #UD, the
> > guest cannot even handle them appropriately, as there was no memory
> > write attempt from its point of view. Therefore the default should be to
> > disable it, IMO. This won't prevent guests making use of the wrong
> > instruction from trapping, but, at least, now they'll get the correct
> > exception vector and can handle it appropriately.
> 
> But you don't accout for the case that guest kernel is built without
> CONFIG_STRICT_KERNEL_RWX enabled, or without CONFIG_DEBUG_RO_DATA, or for
> whatever reason the guest's text is not readonly, and the VM needs to be
> migrated among different vendors (Intel <-> AMD).
> 
> Before this patch, the above usecase works well. But with this patch, the
> guest will gets #UD after migrated to different vendors.
> 
> I heard from some small CSPs that they do want to the ability to live
> migrate VMs among Intel and AMD host.

Usually CSPs don't have full control over what their customers
are running as a guest. If their customers are running mainstream
modern guest OS, CONFIG_STRICT_KERNEL_RWX is pretty likely to be
set, so presumably migration between Intel & AMD will not work
and this isn't making it worse ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


