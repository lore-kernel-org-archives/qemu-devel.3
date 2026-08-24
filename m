Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43DFC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyZTm-0006vm-RH; Mon, 24 Aug 2026 14:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyZTj-0006ul-Uj; Mon, 24 Aug 2026 14:33:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyZTh-0003Fz-PE; Mon, 24 Aug 2026 14:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787596340; bh=SoKjRAusZxztZBTzlbQ36SaVyqq6PmCqcNBqI8DPcOU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fcDv/gA8s5uzVz+JwjeQpznSxkgpBpM4YdsefHBumYLBujYUHRescDuJpztacNA1b
 LD86+HKbE3SMKE37WeLzsF1lDE5U1WCuGhLR+ittA9JWZxsrnGej7t9Wj5yPu/BDd6
 flbmbIEMP0qEr/mOTIgrHqjDFpCm7OWy5d9cKSriDxwtpEq9bqeOQEijrJAelJDK63
 +t9yhNcUHpqxF5mE2NtuR/8dFtq/TZo+iRlNv9YNGeContMh0tyZdzlamejXxTqUi6
 7FSSFoNHShQezHqVs1RwN+1mJ0ykQZX2WhBlVfyoP6Ygoy5pbR2R1NvtDJSSvYSRQv
 jE8H/TyNAsrtw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE8EF1CDFE9;
 Mon, 24 Aug 2026 21:32:20 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85363415AA4;
 Mon, 24 Aug 2026 21:32:56 +0300 (MSK)
Message-ID: <ebbb40fc-9dd3-4088-9960-65f00ca26aea@tls.msk.ru>
Date: Mon, 24 Aug 2026 21:32:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix PC sync in trans_sspopchk for CFI
 exception handling
To: A-Shehab <ahshehab24@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260730181852.1622-1-ahshehab24@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260730181852.1622-1-ahshehab24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/30/26 21:18, A-Shehab wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> Move gen_update_pc call before conditional logic to ensure consistent
> PC state regardless of execution path.
> 
> Previously, the host instructions generated to update the cpu_pc were
> only executed in the failure path when shadow stack validation failed.
> This created inconsistent PC synchronization.
> 
> This inconsistency caused issues in CF_PCREL mode where subsequent
> instructions calculated wrong relative offsets from stale pc_save
> values, and could lead to incorrect exception return addresses.
> 
> This fix ensures PC is always synchronized before any helper that
> might raise an exception, maintaining consistent translator state
> across all execution paths.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4118
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [ahshehab: rebased on current master; file moved to
>   target/riscv/tcg/insn_trans/ and the ssp load is now 64-bit wide]
> Tested-by: A-Shehab <ahshehab24@gmail.com>
> Signed-off-by: A-Shehab <ahshehab24@gmail.com>

I'm applying this to the current qemu stable series.
In 11.0.x and 10.0.x, it is the original version of this patch
(though maybe it is more productive to pick up other changes in
this area to older stable branches and apply this change as-is).

Please let me know if I shouldn't pick it up.

Thanks,

/mjt

