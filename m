Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224DDF459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGLm-00070T-7L; Fri, 10 Apr 2026 14:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wBGLk-0006zZ-44
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:13:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wBGLi-00065r-BJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:12:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4FF65BD39;
 Fri, 10 Apr 2026 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775844775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sq5mrRmxNo2gmVRRcSHuDwbjArE3r3RaPPpBn5fIRyQ=;
 b=AqehyiATV2nVX8A76iXsl2tVJj/d2ZeAsxdTpfpmrX0s5N+AJro5PXOVeAEclozrL2fO6F
 OD+eXChYkY0Yhkkhmhf7POK6Uj53tda+5nlW8sSjlKmWq2CUZLtkbjzDzRIfIKVekZJPR5
 Iw7ZOaSBcDu5Mk/20u8AOYEnPkhXGiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775844775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sq5mrRmxNo2gmVRRcSHuDwbjArE3r3RaPPpBn5fIRyQ=;
 b=825lTzhoSjXi+2/lrQ86qhbPXd1D/vGYyWgaGBaMkL2cGSruEOiUKfsYXwOtRV3KMDDT+U
 eQyeHvuI5S7faSBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wsx7Cg0i;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ldrwdy99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775844774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sq5mrRmxNo2gmVRRcSHuDwbjArE3r3RaPPpBn5fIRyQ=;
 b=Wsx7Cg0i7WAfnbyZHS50BnlZYI7whtbrFAUctsE28Hvw2OHiG9CHz+fgQL2p3h6B+COZcj
 25vuoYJJ9ENs23+mwvf+Njho08AVfvDYCB9Lduk5QHYc/Cegn9F4oA/fqcACy/mSyU/j6A
 eFPtP66AN4rT0p7tBN4j8oZqVlkyaQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775844774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sq5mrRmxNo2gmVRRcSHuDwbjArE3r3RaPPpBn5fIRyQ=;
 b=Ldrwdy99OPsU47vmPQs81WiH8WFA60qbLReiXqvrZWBobBewkeVIlC/JuTP2K7BlRZMFo9
 tLzBftFYwEeIN+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C9084A0B2;
 Fri, 10 Apr 2026 18:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mfnfBKY92WlMRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Apr 2026 18:12:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: anisinha@redhat.com, pbonzini@redhat.com, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, peter.maydell@linaro.org
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
In-Reply-To: <20260409161042.55281-1-harshpb@linux.ibm.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
Date: Fri, 10 Apr 2026 15:12:51 -0300
Message-ID: <87qzomznto.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.ibm.com,linaro.org];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C4FF65BD39
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Harsh Prateek Bora <harshpb@linux.ibm.com> writes:

> When kvm_cpu_exec() returns EXCP_HLT due to kvm_arch_process_async_events()
> returning true, it was returning before releasing the BQL (Big QEMU Lock).
> This caused a lock imbalance where the vCPU thread would loop back to
> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>
> The issue manifests as boot hangs on PowerPC pseries machines with multiple
> vCPUs, where secondary vCPUs with start-powered-off=true remain halted and
> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration held
> the BQL, preventing other operations from proceeding.
>

AFAIU, with halted=1, the thread should be waiting at the
qemu_process_cpu_events() qemu_cond_wait invocation which will release
the BQL during the wait.

What is your irqchip setting? on/off/split? Aren't you just hitting the
early return at do_kvm_irqchip_create()? The refactoring from commit
98884e0cc1 ("accel/kvm: add changes required to support KVM VM file
descriptor change") made it so a few lines that would have been skipped
are now executed.

In this case, probably kvm_halt_in_kernel_allowed=true is making
cpu_thread_is_idle() return false and skip the wait at
qemu_process_cpu_events().

> The fix has two parts:
>
> 1. In kvm_cpu_exec() (kvm-all.c):
>    Release the BQL before returning EXCP_HLT in the early return path,
>    matching the behavior of the normal execution path where bql_unlock()
>    is called before entering the main KVM execution loop.
>
> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>    Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
>    loop expects to hold the BQL when calling kvm_cpu_exec() again.
>
> This ensures proper BQL lock/unlock pairing:
> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
> - Next iteration has BQL held as expected
>
> This is a regression introduced by commit 98884e0cc1 ("accel/kvm: add
> changes required to support KVM VM file descriptor change") which
> refactored kvm_irqchip_create() and changed the initialization timing,
> exposing this lock imbalance issue.
>
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  accel/kvm/kvm-accel-ops.c | 4 ++++
>  accel/kvm/kvm-all.c       | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549..d684fd0840 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>  
>          if (cpu_can_run(cpu)) {
>              r = kvm_cpu_exec(cpu);
> +            if (r == EXCP_HLT) {
> +                /* kvm_cpu_exec() released BQL, re-acquire for next iteration */
> +                bql_lock();
> +            }
>              if (r == EXCP_DEBUG) {
>                  cpu_handle_guest_debug(cpu);
>              }
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..00b8018664 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>      trace_kvm_cpu_exec();
>  
>      if (kvm_arch_process_async_events(cpu)) {
> +        bql_unlock();
>          return EXCP_HLT;
>      }

