Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5CFCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSh6q-00020e-LJ; Thu, 28 May 2026 16:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSh6o-0001zv-SW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:13:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSh6m-000808-Rq
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:13:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so69720695e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999215; x=1780604015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IajTlBHwPTt/Tp1vL2OQG0W56LP4BolHd4GcTegZ2v0=;
 b=FBBCx4WpDNxNll9thhaV0DBFiZoKJ4BkTxDcqqXcG4XxMDBmqW3px0SjMABmOLugsW
 1w7Si73u/jskITws8HtJ2TbwVF5F1MoSbjJBx3zzE7ozNLsvmrCdvfpCuStdjrFmaNfs
 7o3op4fk1JaHVbBkYCv0POuh7RaIIsezZt+3GcptfEDiGZVneeGGb03Rm0obRDMmx7+Q
 yM+Z+h+jYBTGpOojVRYsun7xFpMvyD5CJBml9I9mz51J78pbMmkuhGapHiB738G+sz8N
 R401dfTbmvKJzbjNnlTJPBqCmgJcNYAbrjeD+/qwklkLdDJxCok3l47QpM+o7LOp6VPF
 xzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999215; x=1780604015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IajTlBHwPTt/Tp1vL2OQG0W56LP4BolHd4GcTegZ2v0=;
 b=Sk3pQe8XLeQK8k+RXACGeZGVMqEowp0sp+lpn0NjZp63VhkWx7zgWrwY2XM8pxIoQe
 buPHFG9LnoRCVkMzO1hkB5+XxII9d8CE0j/UIkAi/14o28Ekjfc5QRCQjAWKFs18mmSd
 WQu44y225z0nWBJRQkUnhuMF/3Hf8/ZskpNkV18MosqeGNjbYeeeHp8tRD83TlOKft29
 oZjnfHShlWrassZhxFe6F0LHJRvubOJz8/3URBjkshZEqVJpWuB0gOzS4dKgLQWD8yJq
 OYo5xNF6R50PlJHUD+0Kegp1kXTOj24iPI5ck/K1M8jaOfXKuuhp1dFhhjXHda0DTGTD
 b//Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lGb2ZMs/iWoGmeQQQTldJd2zgQLu7BiK2VzC+8mULpTEGst5hcKOAaTOXORlOjMdugKWdh/coGBsT@nongnu.org
X-Gm-Message-State: AOJu0Yw54fp5TOEqFYRBA9QrrnsozWmapMgVwZxF2HgfUq26ItJfJG2n
 8zvDB+sKtpoE+0wlelgtrha3+t5760umVgTptFzhYe1+M4NHJ2a/J3x1vbzwdFcA6J8=
X-Gm-Gg: Acq92OEpeSGGKtXaT/nEWawmppYVCueKWRmIG/kGq7IF3No6+sMXUJ0dAeP9qc8btOt
 2a/hArXphyzXJj+lbtzWmgzYttxQfgoPEx+cA6xttCSUbbdaj8Vz36B3NSnPh6ki1+nkUYdVacE
 fIstKe1NDoEwUmIX4BtDP3QvYyHNkYymxJyg+bpZXpkulnBunVVCpdJ1VBdT11kfPgId2ZzsB1b
 xWKaTOgtCh8+bNu2IKyiZrs4jWTLpivUD9caZTv4j5sZ8SfSMNwQ2rPBtA19KLTrRyu3jpY+6BW
 j5MHKOQ4gX3RAkUtSnkd28AToO/lp2cocYsX+lHl7K94/QVlNyaj2oIQjcTXDOpKSKCFrmuin4m
 aJTsn5+VBMrwFBcKOZyWkXnYoOxY1FF6zmS8yEn8VhghucdGR+0nWEZnRhVmzKuTFuRabnMTyxr
 1DJdbi8QiKFdbUeosQXUSchBg5TjceoL3+/PyLhgdgnCMZ0o8XJcwCzhz+rjSMu52x00fc7FMXY
 M6i
X-Received: by 2002:a05:600c:6a84:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-4909c087135mr94915e9.13.1779999214757; 
 Thu, 28 May 2026 13:13:34 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092654d10sm59928175e9.6.2026.05.28.13.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:13:33 -0700 (PDT)
Message-ID: <ea220eb7-5fca-4510-a784-81226a0f5e29@linaro.org>
Date: Thu, 28 May 2026 22:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/12] target/riscv: Assert PTE.N/PBMT bits are not
 expected on RV32
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-4-philmd@linaro.org>
 <200e1664-a690-4fe7-bda3-074da046e311@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <200e1664-a690-4fe7-bda3-074da046e311@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28/5/26 22:01, Daniel Henrique Barboza wrote:
> 
> 
> On 5/27/2026 5:13 PM, Philippe Mathieu-Daudé wrote:
>> PTE_N and PTE_PBMT are undefined on RV64, assert we are not
>> under RV32.
>>
> 
> I didn't find this info in the RV priv ISA.  Can you please quote the
> except it in the commit msg?
> 
> Maybe you meant "undefined on RV32"?

Yes :)

>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/cpu_helper.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 17305e1bb75..f86bfdb32e7 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1490,6 +1490,7 @@ static int get_physical_address(CPURISCVState 
>> *env, hwaddr *physical,
>>           return TRANSLATE_FAIL;
>>       }
>>       if (!pbmte && (pte & PTE_PBMT)) {
>> +        assert(riscv_cpu_sxl(env) != MXL_RV32);
> 
> 
> What I understood from the RV priv ISA w.r.t PTE_PMBT is that it doesn't
> have much to do with SXLEN/riscv_cpu_sxl().  PTE_PBMT is a bits 62|61 field
> that determine override mem attributes when we have the 'svpbmt' extension
> enabled.  'svpbmt' is dependent on satp_mode sv39 or greater, which happens
> to be riscv64 only.
> 
> I didn't see any restrictions of SXLEN=32 in the 'svpbmt' chapter in the
> RISC-V ISA, e.g. PTE_PMBT set to a non-zero val and SXLEN=32 seems to be
> a valid combo - a riscv64 target running sv39+ can use svpbmt to override
> PTE properties in a SXLEN=32 context.

It was hard to figure that out by myself.


> Now, PTE_PBMT is not writable when MXLEN=32 (i.e. riscv_cpu_mxl() == 
> MXL_RV32),
> and maybe this is what you're trying to do.

Yes.

>  In this case the assert might
> be justifiable, although we just landed a recent fix in Alistair's tree
> that disables svpbmt for riscv32 entirely, and this also means that
> PTE_PBMT won't ever be set.  But if the assert (with MXL, not SXL) would 
> give
> some sort of guarantee aside from the bit being set, by all means go ahead.

I'll wait to see that merged before revisiting. This patch is not
required for this series, I was trying to make sense of this huge
function while reviewing it.

>>           /* Reserved without Svpbmt. */
>>           qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
>>                         "and Svpbmt extension is disabled: "
>> @@ -1643,6 +1644,7 @@ static int get_physical_address(CPURISCVState 
>> *env, hwaddr *physical,
>>       target_ulong vpn = addr >> PGSHIFT;
>>       if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
>> +        assert(riscv_cpu_sxl(env) != MXL_RV32);
> 
> 
> All the stuff I said above happens to be applicable for PTE_N.  This is 
> a bit
> that indicates if the PTE represents a "naturally aligned power-of-2" 
> range,
> or NAPOT range, and this is specified by another extension called 
> 'svnapot'.
> This extension is also sv39+ exclusive, which means riscv64 exclusive, 
> and it
> doesn't seem to have any restrictions with SXLEN=32.

OK. Let's discard this patch :)

> 
> 
> Thanks,
> Daniel
> 
>>           napot_bits = ctzl(ppn) + 1;
>>           if ((i != (levels - 1)) || (napot_bits != 4)) {
>>               return TRANSLATE_FAIL;
> 


