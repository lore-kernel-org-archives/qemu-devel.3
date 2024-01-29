Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A9C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 21:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUZQJ-0000ge-SR; Mon, 29 Jan 2024 16:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rUZQH-0000ba-GX; Mon, 29 Jan 2024 16:44:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rUZQF-0001Pd-BU; Mon, 29 Jan 2024 16:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=veI10lYyuYNbseN0HhfyLzNbmfkodDIhyCjJhQPlH4U=; b=sXNtKQt2HGf1xe43EsfKGmaW55
 ac4WFljyRTE0azonz4LSccRbxcXyJgrZpkMnDFH0CqTOkYYpOgU34rfsrPigJfIP62K6F3z2cQR7o
 wH0Ing9tnMyhdYEP2M/o/FJyqs4JsDd+W27RhnTz32bDPUpRJwJ59k2Tpucy9Sd3svnRwLTpyymAG
 mE9QnmCfSrxmdIPJ8QUCIHrFvVUy7PRwsfBxZde/8HPSGpv7RGh6nfugA6izWNF1QzsMKkkHyA2GC
 sP2jx86ysth7BHP9pL9V6XURtIJcMAZhyy8wP1rjs1AJpwa2K06Nm8eDuWe047BKrKNBQJIxiG/sq
 HeTCvtow3Cmqd4njg6hAXkQB7ohvf2m27c5TkMKjfJOyMC3hScCZW+8m0bTTg7lVM7JdwcXfzmxCJ
 6hZb7mjLdRWDcWZyvsivnsDSndBqMcojQoY2c25spXeMk2HuBJWzbXd3HzsSkwmb/lLgLQBp/Pwis
 Wk87k3EGsBbNqib+/3thgRa2utHHNCidTq9XJRJvvX2xeib3EZoufQP/IvED7yKMVvosrkpNfzYGf
 egL9Jr6BCIJjzadXZQJtuZgziA7Pvl4v4MJngQDzIx8eVa/NALgY46WxLox8kMERjGsivxZ3sfndv
 ObMFnq+9ILoW4NlbhcEzskSa33aJ44tpFTOwVk37k=;
Received: from [2a00:23c4:8bb2:a00:c9b9:c424:5b7e:9d9f]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rUZPY-0004mf-A5; Mon, 29 Jan 2024 21:43:28 +0000
Message-ID: <140c63fc-f99c-41f3-b96c-5f9d88fa82ba@ilande.co.uk>
Date: Mon, 29 Jan 2024 21:43:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-24-philmd@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240126220407.95022-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:a00:c9b9:c424:5b7e:9d9f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 23/23] target/sparc: Prefer fast cpu_env() over slower
 CPU QOM cast macro
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/01/2024 22:04, Philippe Mathieu-Daudé wrote:

> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.c          | 14 ++++----------
>   target/sparc/gdbstub.c      |  3 +--
>   target/sparc/int32_helper.c |  3 +--
>   target/sparc/int64_helper.c |  3 +--
>   target/sparc/ldst_helper.c  |  6 ++----
>   target/sparc/mmu_helper.c   | 15 +++++----------
>   target/sparc/translate.c    |  3 +--
>   7 files changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index befa7fc4eb..a53c200d8b 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -83,8 +83,7 @@ static void sparc_cpu_reset_hold(Object *obj)
>   static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
>       if (interrupt_request & CPU_INTERRUPT_HARD) {
> -        SPARCCPU *cpu = SPARC_CPU(cs);
> -        CPUSPARCState *env = &cpu->env;
> +        CPUSPARCState *env = cpu_env(cs);
>   
>           if (cpu_interrupts_enabled(env) && env->interrupt_index > 0) {
>               int pil = env->interrupt_index & 0xf;
> @@ -613,8 +612,7 @@ static void cpu_print_cc(FILE *f, uint32_t cc)
>   
>   static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       int i, x;
>   
>       qemu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
> @@ -711,11 +709,8 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
>   
>   static bool sparc_cpu_has_work(CPUState *cs)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> -
>       return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> -           cpu_interrupts_enabled(env);
> +           cpu_interrupts_enabled(cpu_env(cs));
>   }
>   
>   static char *sparc_cpu_type_name(const char *cpu_model)
> @@ -749,8 +744,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
>       CPUState *cs = CPU(dev);
>       SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
> -    SPARCCPU *cpu = SPARC_CPU(dev);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>   
>   #if defined(CONFIG_USER_ONLY)
>       /* We are emulating the kernel, which will trap and emulate float128. */
> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index a1c8fdc4d5..5257c49a0d 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -29,8 +29,7 @@
>   
>   int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>   
>       if (n < 8) {
>           /* g0..g7 */
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index 058dd712b5..6b7d65b031 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -99,8 +99,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>   
>   void sparc_cpu_do_interrupt(CPUState *cs)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       int cwp, intno = cs->exception_index;
>   
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
> diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
> index 27df9dba89..bd14c7a0db 100644
> --- a/target/sparc/int64_helper.c
> +++ b/target/sparc/int64_helper.c
> @@ -130,8 +130,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>   
>   void sparc_cpu_do_interrupt(CPUState *cs)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       int intno = cs->exception_index;
>       trap_state *tsptr;
>   
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 09066d5487..203441bfb2 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -421,8 +421,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
>                                     bool is_write, bool is_exec, int is_asi,
>                                     unsigned size, uintptr_t retaddr)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       int fault_type;
>   
>   #ifdef DEBUG_UNASSIGNED
> @@ -483,8 +482,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
>                                     bool is_write, bool is_exec, int is_asi,
>                                     unsigned size, uintptr_t retaddr)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>   
>   #ifdef DEBUG_UNASSIGNED
>       printf("Unassigned mem access to " HWADDR_FMT_plx " from " TARGET_FMT_lx
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 453498c670..a05ee22315 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -206,8 +206,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                           MMUAccessType access_type, int mmu_idx,
>                           bool probe, uintptr_t retaddr)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       CPUTLBEntryFull full = {};
>       target_ulong vaddr;
>       int error_code = 0, access_index;
> @@ -391,8 +390,7 @@ void dump_mmu(CPUSPARCState *env)
>   int sparc_cpu_memory_rw_debug(CPUState *cs, vaddr address,
>                                 uint8_t *buf, int len, bool is_write)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       target_ulong addr = address;
>       int i;
>       int len1;
> @@ -759,8 +757,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                           MMUAccessType access_type, int mmu_idx,
>                           bool probe, uintptr_t retaddr)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       CPUTLBEntryFull full = {};
>       int error_code = 0, access_index;
>   
> @@ -898,8 +895,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
>   
>   hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       hwaddr phys_addr;
>       int mmu_idx = cpu_mmu_index(env, false);
>   
> @@ -916,8 +912,7 @@ G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 int mmu_idx,
>                                                 uintptr_t retaddr)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>   
>   #ifdef TARGET_SPARC64
>       env->dmmu.sfsr = build_sfsr(env, mmu_idx, access_type);
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 9387299559..412b7d1b66 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -5406,8 +5406,7 @@ void sparc_restore_state_to_opc(CPUState *cs,
>                                   const TranslationBlock *tb,
>                                   const uint64_t *data)
>   {
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    CPUSPARCState *env = &cpu->env;
> +    CPUSPARCState *env = cpu_env(cs);
>       target_ulong pc = data[0];
>       target_ulong npc = data[1];
>   

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


