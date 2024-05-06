Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CD3C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 17:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s42U6-00033D-90; Mon, 06 May 2024 13:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1s42Ty-000322-KO
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:50:38 -0400
Received: from smtp-bc0b.mail.infomaniak.ch ([2001:1600:7:10::bc0b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1s42Ts-0004uP-1E
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:50:32 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VY87s1JrnzP8k;
 Mon,  6 May 2024 19:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
 s=20191114; t=1715017816;
 bh=FeafhCaExu57qsacTj62dWRUdrBXKjPBuLT9vOLipXU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mGwJTwDHmCYyRVABfvivVlR645+s55YE3ikqtGU8J06uhEpc53bUE7Ls8lVECmSJY
 ZoGZR6nkUaCWIF86rf6UUOQ30vsnFTU+oyKVa5juk1cYq6aZPMMxOD7Adtf6s6Qe8Z
 /vj4j5MGtH+BC89lqOLDnwO6/+q161VQ+b28m63o=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VY87p5F0GzB95; Mon,  6 May 2024 19:50:14 +0200 (CEST)
Date: Mon, 6 May 2024 19:50:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>,
 Angelina Vu <angelinavu@linux.microsoft.com>,
 Anna Trikalinou <atrikalinou@microsoft.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>, Forrest Yuan Yu <yuanyu@google.com>, 
 James Gowans <jgowans@amazon.com>, James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>, 
 =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>, 
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>, 
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, 
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
Message-ID: <20240506.ohwe7eewu0oB@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjTuqV-AxQQRWwUW@google.com>
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=2001:1600:7:10::bc0b;
 envelope-from=mic@digikod.net; helo=smtp-bc0b.mail.infomaniak.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 03, 2024 at 07:03:21AM GMT, Sean Christopherson wrote:
> On Fri, May 03, 2024, Mickaël Salaün wrote:
> > Add an interface for user space to be notified about guests' Heki policy
> > and related violations.
> > 
> > Extend the KVM_ENABLE_CAP IOCTL with KVM_CAP_HEKI_CONFIGURE and
> > KVM_CAP_HEKI_DENIAL. Each one takes a bitmask as first argument that can
> > contains KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4. The
> > returned value is the bitmask of known Heki exit reasons, for now:
> > KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4.
> > 
> > If KVM_CAP_HEKI_CONFIGURE is set, a VM exit will be triggered for each
> > KVM_HC_LOCK_CR_UPDATE hypercalls according to the requested control
> > register. This enables to enlighten the VMM with the guest
> > auto-restrictions.
> > 
> > If KVM_CAP_HEKI_DENIAL is set, a VM exit will be triggered for each
> > pinned CR violation. This enables the VMM to react to a policy
> > violation.
> > 
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Wanpeng Li <wanpengli@tencent.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20240503131910.307630-4-mic@digikod.net
> > ---
> > 
> > Changes since v1:
> > * New patch. Making user space aware of Heki properties was requested by
> >   Sean Christopherson.
> 
> No, I suggested having userspace _control_ the pinning[*], not merely be notified
> of pinning.
> 
>  : IMO, manipulation of protections, both for memory (this patch) and CPU state
>  : (control registers in the next patch) should come from userspace.  I have no
>  : objection to KVM providing plumbing if necessary, but I think userspace needs to
>  : to have full control over the actual state.
>  : 
>  : One of the things that caused Intel's control register pinning series to stall
>  : out was how to handle edge cases like kexec() and reboot.  Deferring to userspace
>  : means the kernel doesn't need to define policy, e.g. when to unprotect memory,
>  : and avoids questions like "should userspace be able to overwrite pinned control
>  : registers".
>  : 
>  : And like the confidential VM use case, keeping userspace in the loop is a big
>  : beneifit, e.g. the guest can't circumvent protections by coercing userspace into
>  : writing to protected memory.
> 
> I stand by that suggestion, because I don't see a sane way to handle things like
> kexec() and reboot without having a _much_ more sophisticated policy than would
> ever be acceptable in KVM.
> 
> I think that can be done without KVM having any awareness of CR pinning whatsoever.
> E.g. userspace just needs to ability to intercept CR writes and inject #GPs.  Off
> the cuff, I suspect the uAPI could look very similar to MSR filtering.  E.g. I bet
> userspace could enforce MSR pinning without any new KVM uAPI at all.
> 
> [*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com

OK, I had concern about the control not directly coming from the guest,
especially in the case of pKVM and confidential computing, but I get you
point.  It should indeed be quite similar to the MSR filtering on the
userspace side, except that we need another interface for the guest to
request such change (i.e. self-protection).

Would it be OK to keep this new KVM_HC_LOCK_CR_UPDATE hypercall but
forward the request to userspace with a VM exit instead?  That would
also enable userspace to get the request and directly configure the CR
pinning with the same VM exit.

