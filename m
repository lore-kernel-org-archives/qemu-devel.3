Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11D6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3blA-0007rJ-Lh; Sun, 05 May 2024 09:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1s3bl7-0007qh-H9; Sun, 05 May 2024 09:18:29 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1s3bl5-0004Wf-5i; Sun, 05 May 2024 09:18:29 -0400
Received: from [192.168.106.118]
 (dynamic-095-118-089-140.95.118.pool.telefonica.de [95.118.89.140])
 by csgraf.de (Postfix) with ESMTPSA id 4193660805E3;
 Sun,  5 May 2024 15:18:20 +0200 (CEST)
Message-ID: <f0c19830-d4e0-4585-b960-7dd3fa1a3c76@csgraf.de>
Date: Sun, 5 May 2024 15:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug
 System registers
To: Zenghui Yu <zenghui.yu@linux.dev>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, wanghaibin.wang@huawei.com
References: <20240503153453.54389-1-zenghui.yu@linux.dev>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20240503153453.54389-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
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


On 03.05.24 19:34, Zenghui Yu wrote:
> We wrongly encoded ID_AA64PFR1_EL1 using {3,0,0,4,2} in hvf_sreg_match[] so
> we fail to get the expected ARMCPRegInfo from cp_regs hash table with the
> wrong key.
>
> Fix it with the correct encoding {3,0,0,4,1}. With that fixed, the Linux
> guest can properly detect FEAT_SSBS2 on my M1 HW.
>
> All DBG{B,W}{V,C}R_EL1 registers are also wrongly encoded with op0 == 14.
> It happens to work because HVF_SYSREG(CRn, CRm, 14, op1, op2) equals to
> HVF_SYSREG(CRn, CRm, 2, op1, op2), by definition. But we shouldn't rely on
> it.
>
> Fixes: a1477da3ddeb ("hvf: Add Apple Silicon support")
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>


Nice catch! Did you find them only because of functional issues or have 
you taken an automated pass somehow to validate the sysreg definitions 
are correct?

Reviewed-by: Alexander Graf <agraf@csgraf.de>


Alex



