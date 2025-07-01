Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBECC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYFf-0003Ib-CV; Tue, 01 Jul 2025 06:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1uWYFd-0003HU-I6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:30:09 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1uWYFb-0001ck-7v
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:30:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A15FB21163;
 Tue,  1 Jul 2025 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751365801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSHpEF/hCkdltG2+QQ7SlzxN6CetMtqI1VSURHAnGtI=;
 b=zmc3avIjoYm2Ns9WkZr4avJXu/TGgomLeM0ciW1/SGgcNWnoOMd7FD3G4NVzYazDl2YcRG
 hYv+TKfbXiSS+X6nBayeHIz5LKbpPV2E/6EmJ/3UK59ZbcnXTMH/8sbAVP6c7neU4WQE4/
 kF1cM8SLm/jgA82PuwhAQjUXF0/67bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751365801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSHpEF/hCkdltG2+QQ7SlzxN6CetMtqI1VSURHAnGtI=;
 b=rl3wfl8gvW7941eN1SzYJ4yM0XYax0rFdL3KusTinIBU3izBe6YG1QN3/R1E1w2n2Aduxq
 CdyoHGy2haeLIFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751365801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSHpEF/hCkdltG2+QQ7SlzxN6CetMtqI1VSURHAnGtI=;
 b=zmc3avIjoYm2Ns9WkZr4avJXu/TGgomLeM0ciW1/SGgcNWnoOMd7FD3G4NVzYazDl2YcRG
 hYv+TKfbXiSS+X6nBayeHIz5LKbpPV2E/6EmJ/3UK59ZbcnXTMH/8sbAVP6c7neU4WQE4/
 kF1cM8SLm/jgA82PuwhAQjUXF0/67bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751365801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSHpEF/hCkdltG2+QQ7SlzxN6CetMtqI1VSURHAnGtI=;
 b=rl3wfl8gvW7941eN1SzYJ4yM0XYax0rFdL3KusTinIBU3izBe6YG1QN3/R1E1w2n2Aduxq
 CdyoHGy2haeLIFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D48B1364B;
 Tue,  1 Jul 2025 10:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HL0MCKm4Y2hfQQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Tue, 01 Jul 2025 10:30:01 +0000
Message-ID: <46c39b19-f92f-4f20-9390-35d84291715f@suse.de>
Date: Tue, 1 Jul 2025 12:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Rename host_cpu_instance_init() to
 apply_host_vendor()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
References: <20250701075738.3451873-1-xiaoyao.li@intel.com>
 <20250701075738.3451873-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20250701075738.3451873-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 intel.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello Xiaoyao,

I did not find a better name at the time. The meaning of 'host' there has nothing to do with the cpu type called "host",
but rather identifies common code between kvm and hvf, which both use the host cpuid(), See accel_uses_host_cpuid(), host_cpuid(), host_cpu_vendor_fms().

Maybe the right way is to split the code in two files,

one dealing with these functions common between hvf and kvm,
and one file that implements the "host" cpu type.

I am concerned that "apply_host_vendor" would need to be renamed again if more code will need to be added that is common in the initialization of hvf and kvm.

I am not sure what could be a better name for the function host_cpu_instance_init(),
but maybe its name would not confuse so much anymore if it is contained in a file that specifically includes this common code,
excluding all "host" cpu type related code.

Bye,

Claudio


On 7/1/25 09:57, Xiaoyao Li wrote:
> The name of host_cpu_instance_init is really confusing. It misleads
> people to think it as the .instance_init() callback of "host" x86 cpu
> type.
> 
> Rename it to match what it does and move the xcc->model check to
> callers since it's better to let host-cpu.c concentrate only on the host
> related functionalities.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/host-cpu.c    | 12 ++++--------
>  target/i386/host-cpu.h    |  2 +-
>  target/i386/hvf/hvf-cpu.c |  5 ++++-
>  target/i386/kvm/kvm-cpu.c |  4 ++--
>  4 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 383c42d4ae3d..c86b8227b974 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -127,16 +127,12 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
>      }
>  }
>  
> -void host_cpu_instance_init(X86CPU *cpu)
> +void apply_host_vendor(X86CPU *cpu)
>  {
> -    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
> +    char vendor[CPUID_VENDOR_SZ + 1];
>  
> -    if (xcc->model) {
> -        char vendor[CPUID_VENDOR_SZ + 1];
> -
> -        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
> -        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
> -    }
> +    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
> +    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
>  }
>  
>  void host_cpu_max_instance_init(X86CPU *cpu)
> diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
> index b97ec01c9bec..779f0f2f4123 100644
> --- a/target/i386/host-cpu.h
> +++ b/target/i386/host-cpu.h
> @@ -11,7 +11,7 @@
>  #define HOST_CPU_H
>  
>  uint32_t host_cpu_phys_bits(void);
> -void host_cpu_instance_init(X86CPU *cpu);
> +void apply_host_vendor(X86CPU *cpu);
>  void host_cpu_max_instance_init(X86CPU *cpu);
>  bool host_cpu_realizefn(CPUState *cs, Error **errp);
>  
> diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
> index dfdda701268e..16647482aba0 100644
> --- a/target/i386/hvf/hvf-cpu.c
> +++ b/target/i386/hvf/hvf-cpu.c
> @@ -61,8 +61,11 @@ static void hvf_cpu_xsave_init(void)
>  static void hvf_cpu_instance_init(CPUState *cs)
>  {
>      X86CPU *cpu = X86_CPU(cs);
> +    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>  
> -    host_cpu_instance_init(cpu);
> +    if (xcc->model) {
> +        apply_host_vendor(cpu);
> +    }
>  
>      /* Special cases not set in the X86CPUDefinition structs: */
>      /* TODO: in-kernel irqchip for hvf */
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 6df92dc6d703..99e4357d5efe 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -202,9 +202,9 @@ static void kvm_cpu_instance_init(CPUState *cs)
>      X86CPU *cpu = X86_CPU(cs);
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>  
> -    host_cpu_instance_init(cpu);
> -
>      if (xcc->model) {
> +        apply_host_vendor(cpu);
> +
>          /* only applies to builtin_x86_defs cpus */
>          if (!kvm_irqchip_in_kernel()) {
>              x86_cpu_change_kvm_default("x2apic", "off");


