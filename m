Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4276CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVO1-0000cv-Jk; Fri, 05 Jun 2026 10:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVVNy-0000bs-Ly
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:18:58 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVVNs-0000Oh-O7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:18:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BAD36B37B;
 Fri,  5 Jun 2026 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780669131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/2vtSOVVlfj9Agh7xSvbB4JlaTvw+8qJ6jd6ubSUFs=;
 b=twdh3Ycpj7sLpdtQLNHPHPVYHRUwWYN1ERYSFlfNpWLlvkLA0KIVdpLoe+MqfZC/jHHPEi
 5SE6qz9q2Bvzo0cFjHwu6nSBqwAIGKnsT9bajMWc+7xmiGk/J0UXb99XLLwsr3D3/TSBGB
 J/SDEZQTpO9cTGYPpaFksAMMdoKOlEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780669131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/2vtSOVVlfj9Agh7xSvbB4JlaTvw+8qJ6jd6ubSUFs=;
 b=aje03b7Tic9FXztzOMcuo43pteJhJBSxjuxEKffB7FLclGTddFvkuRMLl45UMwpOdWgC4h
 iEz7USw1rOPyxoBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780669130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/2vtSOVVlfj9Agh7xSvbB4JlaTvw+8qJ6jd6ubSUFs=;
 b=bcgFYDsRcdd4pV0+YmhAxW/uDp5Zcs7qceR0wzqMJwd42pu3lPWjhVye3JBFczNNKRMtlr
 SvtwPECY1mW0JAOryguTiNqljlgj5a3SvO9dnAXlWKXTM1fdx7lVCA2YvPplLOU7MSVRJ+
 W07L3Mm5GJByLf+7UCMMO/KfM6fRlfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780669130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/2vtSOVVlfj9Agh7xSvbB4JlaTvw+8qJ6jd6ubSUFs=;
 b=0lw9JYz+L3a9x9UBe4lLhhiA+BVjxe5ZjhtALZqx7G20eElpexJpOeoySxzKsIT4sOZDN4
 6AUznHoM01SKqzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969AF779A8;
 Fri,  5 Jun 2026 14:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9ancGcnaImqhRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jun 2026 14:18:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, Sandipan Das
 <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang
 <dongli.zhang@oracle.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide
 Chen <zide.chen@intel.com>
Subject: Re: [PATCH v4 1/6] target/i386: Don't save/restore
 PERF_GLOBAL_OVF_CTRL MSRs
In-Reply-To: <20260604025546.19378-2-zide.chen@intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
 <20260604025546.19378-2-zide.chen@intel.com>
Date: Fri, 05 Jun 2026 11:18:47 -0300
Message-ID: <87ik7x6pfc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email, intel.com:email, oracle.com:email,
 suse.de:email, suse.de:mid, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Zide Chen <zide.chen@intel.com> writes:

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
> are write-only MSRs and reads always return zero.
>
> Saving and restoring these MSRs is therefore unnecessary.  Replace
> VMSTATE_UINT64 with VMSTATE_UNUSED in the VMStateDescription to ignore
> env.msr_global_ovf_ctrl during migration.  This avoids the need to bump
> version_id and does not introduce any migration incompatibility.
>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Fixes: e587632c228e ("target/i386/kvm: support perfmon-v2 for reset")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V3:
> - Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR as well.
> ---
>  target/i386/cpu.h     |  3 ---
>  target/i386/kvm/kvm.c | 10 ----------
>  target/i386/machine.c |  4 ++--
>  3 files changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6b500737c3be..ff44487d0b6d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -507,11 +507,9 @@ typedef enum X86Seg {
>  #define MSR_CORE_PERF_FIXED_CTR_CTRL    0x38d
>  #define MSR_CORE_PERF_GLOBAL_STATUS     0x38e
>  #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
>  
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS       0xc0000300
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL          0xc0000301
> -#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR   0xc0000302
>  
>  #define MSR_K7_EVNTSEL0                 0xc0010000
>  #define MSR_K7_PERFCTR0                 0xc0010004
> @@ -2104,7 +2102,6 @@ typedef struct CPUArchState {
>      uint64_t msr_fixed_ctr_ctrl;
>      uint64_t msr_global_ctrl;
>      uint64_t msr_global_status;
> -    uint64_t msr_global_ovf_ctrl;
>      uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
>      uint64_t msr_gp_counters[MAX_GP_COUNTERS];
>      uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a29f757c168a..1ac1803e8a2e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4290,8 +4290,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
>              if (pmu_version > 1) {
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
>                                    env->msr_global_status);
> -                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
> -                                  env->msr_global_ovf_ctrl);

Assuming there's no weird nested virtualization scenario and combination
of migration, resets and context-switching between L1/L2 that implicitly
relies on this (effective) clearing of the MSR to work properly.

Reviewed-by: Fabiano Rosas <farosas@suse.de>


