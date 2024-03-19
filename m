Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C0BCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbnK-0000HS-9Y; Tue, 19 Mar 2024 11:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbnH-0000G4-Ch
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:54:27 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbnF-0007Jl-T7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c6+YQSrVzJEHFcTR2XAainkmIJ+OocO8c/hhIsAr110=; b=PcD0A+yqegnFFaO1c0AzrSQWE5
 RFnWYno2xyvCsAMSnldeROsOsdeTlDbv92NThzvqWoBW8uFFdzk82zrR+o89ZlrGOwNAs++OFCjYg
 Gp7E4rS1if5Aw39YSVTXo9qlqQTzj5zimbhtaqCqJt9BfPZFMhpPNb1IIEpvALosefWM=;
Date: Tue, 19 Mar 2024 16:54:56 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 3/8] target/microblaze: Widen vaddr in
 mmu_translate()
Message-ID: <frhhtwrswxniz7idl3mpzyboovcsjtokxtg5s4nykjq5wskv7i@2j3bffyyowgg>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-4-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/03/24, Philippe Mathieu-Daudé wrote:
> Use 'vaddr' type for virtual addresses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/mmu.h | 2 +-
>  target/microblaze/mmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 1068bd2d52..2aca39c923 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -86,7 +86,7 @@ typedef struct {
>  } MicroBlazeMMULookup;
>  
>  unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
> +                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
>  uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
>  void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
>  void mmu_init(MicroBlazeMMU *mmu);
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 234006634e..eb7c683020 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -75,7 +75,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
>  
>  /* rw - 0 = read, 1 = write, 2 = fetch.  */
>  unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
> +                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
>  {
>      MicroBlazeMMU *mmu = &cpu->env.mmu;
>      unsigned int i, hit = 0;
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

