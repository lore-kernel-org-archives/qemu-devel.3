Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DEFC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB5TK-00086K-TI; Mon, 28 Sep 2026 03:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xB5T2-00085s-Hw; Mon, 28 Sep 2026 03:08:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xB5Sz-0001Hu-Ou; Mon, 28 Sep 2026 03:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790579276; bh=fSJLKEOBr/iSPrScGAKTVLLKPKX8wzKkfhF/at39Gr4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=H1fn5hwdTwHxIyfRVmEBQXtU1RG02gT78ih4xH+50/sbv0zhuoklT6gGYhG82ZCKe
 vTSRm5ExJ7JWbZuoIDJuU6CIQEPliEdSsfOUMiNhle8h639a1VkBUFxPzXlLXU5AZq
 4VSrtzY2qj669yZYmpuUp1HYKmCVk9nw3rpct4bxbJ2VdVMeb/zqex4KFf5U5nkvgU
 aibHdbm8znaDCsSnAhm/U/b5M9NUG/ijwwSKiHg8kMoUFMPsyxWaaOy7I63fz8VN/g
 pOO8c+3H/uRKTxiEJUEtDRZxdt3/kEiffS03u34sOA2W8MQ1Iw72ws3bs75CWX9maK
 sFQSJ3/oDNnFQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 635C81D8FA8;
 Mon, 28 Sep 2026 10:07:56 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4E19843353C;
 Mon, 28 Sep 2026 10:07:56 +0300 (MSK)
Message-ID: <17ec6357-7f1b-44f0-8433-f4ed491c4926@tls.msk.ru>
Date: Mon, 28 Sep 2026 10:07:56 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [Stable-11.1.2 v2 64/92] linux-user/riscv: invalidate
 reservations after stores
To: Rick <rick@sloservers.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
 <20260927104821.196183-8-mjt@tls.msk.ru>
 <9dd3c99c-5f57-43b6-b591-84e10b425443@sloservers.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <9dd3c99c-5f57-43b6-b591-84e10b425443@sloservers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 9/28/26 05:59, Rick wrote:
> On 9/27/2026 3:47 AM, Michael Tokarev wrote:
>  > From: wangyang <wangyang25@otcaix.iscas.ac.cn>
>  >
>  > In linux-user parallel execution, AMO and ordinary integer stores do not
>  > invalidate load reservations held by another hart.
> [...]
>  > Use the existing EXCP_ATOMIC path to re-execute LR, SC, AMO, and ordinary
>  > integer store instructions in a serial context.
> [...]
> 
> Please hold this patch out of 11.1.2. It makes riscv64 user-mode
> emulation much slower, and multi-threaded guests can stall.

Thank you for letting me know!  I removed this change from
the queue now.

> Once a guest has a second thread (CF_PARALLEL), gen_store() exits
> through EXCP_ATOMIC on every ordinary integer store, so each store
> stops all other vCPUs (cpu_exec_step_atomic -> start_exclusive).
> LR, SC and AMOs take the same path. In addition, every store,
> single-threaded or not, calls helper_riscv_invalidate_reservations(),
> which walks all CPUs.
> 
> xz compressing 2 MB at -6, without and with the patch:
> 
>                  without patch    with patch
>    xz -T1        5 s              122 s   (identical output)
>    xz -T8        1 s              no output after 600 s
> 
> Measured with bsd-user on a FreeBSD 15.1/amd64 host running a FreeBSD
> riscv64 userland. The only difference between the two builds is
> reverting 5089493e45. The code involved is target/riscv under
> CONFIG_USER_ONLY, which linux-user shares, but I have not measured
> linux-user yet. I found this today while investigating riscv64 hangs
> in bsd-user.
> 
> I'm not disputing the correctness fix for work item 4149 (a same-value
> store by another hart must break an LR reservation), only the cost of
> serializing every store to get it. That issue was found by a synthetic
> test, while this regression hits ordinary multi-threaded programs, so
> I'd suggest leaving the patch out of stable until master has a cheaper
> approach.
Thank you!

/mjt

