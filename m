Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC1BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Qzq-0005Sv-QB; Wed, 08 Oct 2025 06:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6Qzo-0005SY-Ak
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:02:08 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6Qzl-0001ue-VG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Htazs/JZxM3GGnLR/wPsHz+Rozn0+4MWDmX6Ucd3uz4=; b=d6OeQ1os8mTjqPS
 DKMIU25dSbGrZEToipJR2fLouCZ/gWdzwDboT28PkTUF2enVrEBLoppXMZMLbQaWTIFXEn1gaQCuk
 HsGLycuPYFTmaOUY6ldPJisSha9YwN4ggyvW7NmxAECv8a0gLtbC60veZnfHEl5cVU5q/TUyNR+s1
 0c=;
Date: Wed, 8 Oct 2025 12:04:36 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 1/5] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
Message-ID: <vywllpnlej3sjlf7yyejoshohqgt7ia5sei4ww3hh247afphvh@amdby265c2di>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008060129.87579-2-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/10/25, Philippe Mathieu-Daudé wrote:
> cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
> a vaddr type for its address argument since commit 7510454e3e7
> ("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/mmu.h | 2 +-
>  target/microblaze/mmu.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 1068bd2d52b..2aca39c923b 100644
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
> index 8703ff5c657..db24cb399ce 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -78,7 +78,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
>  
>  /* rw - 0 = read, 1 = write, 2 = fetch.  */
>  unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
> +                           vaddr vaddr, MMUAccessType rw, int mmu_idx)

`vaddr vaddr` looks a bit awkward, but very nitty and not like it really matters.

Reviewed-by: Anton Johansson <anjo@rev.ng>

