Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411FAC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Mxh-0000oo-Eg; Fri, 25 Apr 2025 13:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u8Mxf-0000o0-E3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:35:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u8Mxc-00052D-NE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:35:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zkg1D1Ljtz6L5f1;
 Sat, 26 Apr 2025 01:33:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C7E41402E9;
 Sat, 26 Apr 2025 01:35:26 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Apr
 2025 19:35:26 +0200
Date: Fri, 25 Apr 2025 18:35:24 +0100
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE
 to slow flags
Message-ID: <20250425183524.00000b28@huawei.com>
In-Reply-To: <20250422192819.302784-67-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-67-richard.henderson@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 22 Apr 2025 12:26:55 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> Recover two bits from the inline flags.


Hi Richard,

Early days but something (I'm fairly sure in this patch) is tripping up my favourite
TCG corner case of running code out of MMIO memory (interleaved CXL memory).

Only seeing it on arm64 tests so far which isn't upstream yet..
(guess what I was getting ready to post today)

Back trace is:

#0  0x0000555555fd4296 in cpu_atomic_fetch_andq_le_mmu (env=0x555557ee19b0, addr=18442241572520067072, val=18446744073701163007, oi=8244, retaddr=<optimized out>) at ../../accel/tcg/atomic_template.h:140
#1  0x00007fffb6894125 in code_gen_buffer ()
#2  0x0000555555fc4c46 in cpu_tb_exec (cpu=cpu@entry=0x555557ededf0, itb=itb@entry=0x7fffb6894000 <code_gen_buffer+200511443>, tb_exit=tb_exit@entry=0x7ffff4bfb744) at ../../accel/tcg/cpu-exec.c:455
#3  0x0000555555fc51c2 in cpu_loop_exec_tb (tb_exit=0x7ffff4bfb744, last_tb=<synthetic pointer>, pc=<optimized out>, tb=0x7fffb6894000 <code_gen_buffer+200511443>, cpu=0x555557ededf0) at ../../accel/tcg/cpu-exec.c:904
#4  cpu_exec_loop (cpu=cpu@entry=0x555557ededf0, sc=sc@entry=0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1018
#5  0x0000555555fc58f1 in cpu_exec_setjmp (cpu=cpu@entry=0x555557ededf0, sc=sc@entry=0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1035
#6  0x0000555555fc5f6c in cpu_exec (cpu=cpu@entry=0x555557ededf0) at ../../accel/tcg/cpu-exec.c:1061 
#7  0x0000555556146ac3 in tcg_cpu_exec (cpu=cpu@entry=0x555557ededf0) at ../../accel/tcg/tcg-accel-ops.c:81
#8  0x0000555556146ee3 in mttcg_cpu_thread_fn (arg=arg@entry=0x555557ededf0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
#9  0x00005555561f6450 in qemu_thread_start (args=0x555557f8f430) at ../../util/qemu-thread-posix.c:541
#10 0x00007ffff7750aa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
#11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78  

I haven't pushed out the rebased tree yet making this a truly awful bug report.

The pull request you sent with this in wasn't bisectable so this was a bit of a guessing
game. I see the seg fault only after this patch.

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/tlb-flags.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
> index a0e51a4b37..54a6bae768 100644
> --- a/include/exec/tlb-flags.h
> +++ b/include/exec/tlb-flags.h
> @@ -53,20 +53,15 @@
>   * contain the page physical address.
>   */
>  #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
> -/* Set if TLB entry is an IO callback.  */
> -#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
> -/* Set if TLB entry writes ignored.  */
> -#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
>  /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
> -#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
> +#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
>  
>  /*
>   * Use this mask to check interception with an alignment mask
>   * in a TCG backend.
>   */
>  #define TLB_FLAGS_MASK \
> -    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
> -    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
> +    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
>  
>  /*
>   * Flags stored in CPUTLBEntryFull.slow_flags[x].
> @@ -78,8 +73,14 @@
>  #define TLB_WATCHPOINT       (1 << 1)
>  /* Set if TLB entry requires aligned accesses.  */
>  #define TLB_CHECK_ALIGNED    (1 << 2)
> +/* Set if TLB entry writes ignored.  */
> +#define TLB_DISCARD_WRITE    (1 << 3)
> +/* Set if TLB entry is an IO callback.  */
> +#define TLB_MMIO             (1 << 4)
>  
> -#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
> +#define TLB_SLOW_FLAGS_MASK \
> +    (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
> +     TLB_DISCARD_WRITE | TLB_MMIO)
>  
>  /* The two sets of flags must not overlap. */
>  QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);


