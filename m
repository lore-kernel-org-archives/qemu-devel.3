Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15036C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 01:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB0Dy-0003VI-Kz; Sun, 27 Sep 2026 21:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xB0Dw-0003Uc-0J; Sun, 27 Sep 2026 21:32:08 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xB0Dt-00038u-65; Sun, 27 Sep 2026 21:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1790559096; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=U0EqrEyYIKV/PVkNVjCYC9ipTeKn0LMg4/zi3+y+2iI=;
 b=fvb8VbxeVxGhKnjWeKqphIQuBy3PI0hx+iXUrK5uY9NIHrPGnR4X3cj9ZXclx4srLegQNR3vHGdO3Np9PFpaKKWJjHNT70b+V/gfpdTQmbwqnNnni9qfKxkAtqi8991/uvgTpfFuqqdvLcGHnOcGeVtcvFmj7fsW38/lxXnodg0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0XBgzOIl_1790559094; 
Received: from 30.166.64.215(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XBgzOIl_1790559094 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 28 Sep 2026 09:31:35 +0800
Message-ID: <a95fe98a-d15e-473d-bcf4-366920788a93@linux.alibaba.com>
Date: Mon, 28 Sep 2026 09:31:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] target/riscv: Clear virtualization mode on reset
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-13-5da5159a0c64@linux.alibaba.com>
 <ba8f5a00-1da4-4f09-a45f-6666ae0d73fe@oss.qualcomm.com>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <ba8f5a00-1da4-4f09-a45f-6666ae0d73fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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


在 2026/9/26 00:45, Daniel Henrique Barboza 写道:
>
>
> On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
>> Reset enters M-mode without clearing virt_enabled, leaving an invalid
>> M-mode, V=1 state after a reset from virtual mode. Clear virt_enabled
>> alongside the privilege reset.
>>
>
> This one is quite old.
>
> Fixes: dc5bd18fa5 ("RISC-V CPU Core Definition")
>
>
Hi Daniel,

Thanks. I traced the virtualization state back to:

Fixes: ef6bb7b62682 ("target/riscv: Add the virtulisation mode")

That commit introduced env->virt and its helpers without resetting
the new state. dc5bd18fa5 predates the virtualization state, so I
think ef6bb7b62682 is a more precise reference.

Thanks,
Tiancheng

>
>> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> ---
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
>
>
>>   target/riscv/cpu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 
>> 5fff9d745e9b36d9cbd30f166ec91b5165e5f497..f60d7cca1e2f0008b09b1055c5cdeed3ec4ad1d3 
>> 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -980,6 +980,7 @@ static void riscv_cpu_reset_hold(Object *obj, 
>> ResetType type)
>>   #ifndef CONFIG_USER_ONLY
>>       env->misa_mxl = mcc->def->misa_mxl_max;
>>       env->priv = PRV_M;
>> +    env->virt_enabled = false;
>>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>>       if (env->misa_mxl > MXL_RV32) {
>>           /*
>>

