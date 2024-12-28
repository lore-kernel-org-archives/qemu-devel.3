Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2FDE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 11:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRUo2-00040R-Sj; Sat, 28 Dec 2024 06:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tRUo1-0003xn-CQ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 06:16:29 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tRUnz-0001pq-IP
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 06:16:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 999554E6004;
 Sat, 28 Dec 2024 12:16:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BoPfu1_qQbF6; Sat, 28 Dec 2024 12:16:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AB89A4E6030; Sat, 28 Dec 2024 12:16:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A9964746F60;
 Sat, 28 Dec 2024 12:16:17 +0100 (CET)
Date: Sat, 28 Dec 2024 12:16:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@kernel.org>
cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/hppa: Speed up hppa_is_pa20()
In-Reply-To: <Z2-nWcZ5l6oklIZW@p100>
Message-ID: <8150fda8-7f13-75d6-57cf-e2099b14ff33@eik.bme.hu>
References: <Z2-nWcZ5l6oklIZW@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sat, 28 Dec 2024, Helge Deller wrote:
> Although the hppa_is_pa20() helper is costly due to string comparisms in
> object_dynamic_cast(), it is called quite often during memory lookups
> and at each start of a block of instruction translations.
> Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
> CPU creation and store the result in the is_pa20 of struct CPUArchState.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index a31dc32a9f..08ac1ec068 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -281,6 +281,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>     /* Create CPUs.  */
>     for (unsigned int i = 0; i < smp_cpus; i++) {
>         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
> +        cpu[i]->env.is_pa20 = object_dynamic_cast(OBJECT(cpu[i]), TYPE_HPPA64_CPU);
>     }
>
>     /*
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index e45ba50a59..c37a701f44 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -208,6 +208,7 @@ typedef struct CPUArchState {
>     uint64_t fr[32];
>     uint64_t sr[8];          /* stored shifted into place for gva */
>
> +    bool is_pa20;
>     uint32_t psw;            /* All psw bits except the following:  */
>     uint32_t psw_xb;         /* X and B, in their normal positions */
>     target_ulong psw_n;      /* boolean */
> @@ -294,7 +295,7 @@ struct HPPACPUClass {
>
> static inline bool hppa_is_pa20(CPUHPPAState *env)
> {
> -    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
> +    return env->is_pa20;
> }

Now this function name is longer than what it extends to so maybe it would 
be simpler to drop the inline function and use env->is_pa20 directly 
where it's needed? Is there a reason to keep the function?

Regards,
BALATON Zoltan

>
> static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
>
>

