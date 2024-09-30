Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE319CE8348
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGm8-0000Ge-Nd; Mon, 30 Sep 2024 09:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1svGm6-0000Cp-13; Mon, 30 Sep 2024 09:49:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1svGm3-00046g-5C; Mon, 30 Sep 2024 09:49:16 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C86F24E6010;
 Mon, 30 Sep 2024 15:49:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RX47F4wOcNe1; Mon, 30 Sep 2024 15:49:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D1D184E6004; Mon, 30 Sep 2024 15:49:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CF6F7757B27;
 Mon, 30 Sep 2024 15:49:08 +0200 (CEST)
Date: Mon, 30 Sep 2024 15:49:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 2/3] hw/ppc/sam460ex: Replace tswap32() by stl_endian_p()
In-Reply-To: <20240930125323.54671-3-philmd@linaro.org>
Message-ID: <cb4ef447-11e5-bdb2-d433-12ffdba6bb4c@eik.bme.hu>
References: <20240930125323.54671-1-philmd@linaro.org>
 <20240930125323.54671-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-664777791-1727704148=:41097"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-664777791-1727704148=:41097
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 30 Sep 2024, Philippe Mathieu-Daudé wrote:
> Replace the target-specific tswap32() call by stl_endian_p()
> which does the same but takes the endianness as argument, thus
> is target-agnostic.
> Get the vCPU endianness calling ppc_cpu_is_big_endian().
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/ppc/sam460ex.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 8dc75fb9f0..6257ddbec6 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -248,10 +248,11 @@ static void mmubooke_create_initial_mapping(CPUPPCState *env,
> static void main_cpu_reset(void *opaque)
> {
>     PowerPCCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
>     CPUPPCState *env = &cpu->env;
>     struct boot_info *bi = env->load_info;
>
> -    cpu_reset(CPU(cpu));
> +    cpu_reset(cs);
>
>     /* either we have a kernel to boot or we jump to U-Boot */
>     if (bi->entry != UBOOT_ENTRY) {
> @@ -261,7 +262,7 @@ static void main_cpu_reset(void *opaque)
>
>         /* Create a mapping for the kernel.  */
>         mmubooke_create_initial_mapping(env, 0, 0);
> -        env->gpr[6] = tswap32(EPAPR_MAGIC);
> +        stl_endian_p(ppc_cpu_is_big_endian(cs), &env->gpr[6], EPAPR_MAGIC);

I think this slightly changes behaviour even if getting the same result. 
The ppc_cpu_is_big_endian() checks the CPU bit for current mode while 
previously tswap32 only checks for host endianness vs. big endian which is 
the default mode for PPC which is what the CPU is in during boot where 
this data is used. So even with checking the bit it'd be the same but the 
check is not needed. I think you could/should just have hard coded big 
endian here to preserve the current behaviour.

(There were some discussion a while back if this EPAPR_MAGIC is correct or 
needed at all but preserving current behaviour is a good enough for now.)

Regards,
BALATON Zoltan

>         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
>
>     } else {
>
--3866299591-664777791-1727704148=:41097--

