Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE03BCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnMG-000143-Dl; Wed, 03 Sep 2025 09:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnM9-00010T-IK
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:16:57 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnM7-00040e-Ac
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:16:57 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b0454d63802so326861466b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756905414; x=1757510214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4Ssw/aQbyaX/npzn93JXksfRtTwVGqKUbdSkgfy46Y=;
 b=x5SAjtIU9Wf2oZ38v3A+EIBWNVMEAUWwEt4nlbJOKmx3k4MZUS5YUCyZAvaS7+AgfO
 Br7jPtawpEDPeKKVMOcWp0heEmEqUB/J99/A2OvgN+FrcylH4UDYtdI/1xqJDdJ3PXUp
 YnpGSh4SZX+6P2ETOCoS7DowijL9Bep2urJbkddTAUh+HL9x96M/Q/hmYd0XVh0KpU/F
 k+RJxG9Uzd5fsgRAsmzsjyypboWtXE94b0gj80mrpzTIF4RDqVYB5bSYCbngQtKVW7dz
 o6DKB1nxjz72uop/waw6qlv4N3Za1qEDkEXsKpeNXSEiDUNjx6yPI4Mgv3X05Duy+5Wx
 PKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756905414; x=1757510214;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4Ssw/aQbyaX/npzn93JXksfRtTwVGqKUbdSkgfy46Y=;
 b=NAuOpoFX6zJOR5QUgt14OjRhp/R2fJ9un8koLCiDDZ2yVLJdWxneFTrttZGDZ49gxa
 5bzCpRssJiIvy6LEZDyAj6U4yTxev1HxMZVzhpOvOuXarWezEif6JEubweHsH1CrNhZt
 6rtiIA5jOynFjDg2+MGEi+DTybgzrpzQKiPV5KkG3MAYKVIMGmykh2abDvJVCwfEqdwh
 eDRoW3/v/FHsG+GG2003ZFNnCxxQsH9HGfW5Inga4DEOxl8LH+WcFSXlA3R9NAv19P5N
 q3NoLWoXnJ7L2RLc/2x/mNr6nR/PkX5UtgEX3sdL6gD3l5GACfPexP0KYOgaGDK4pcwN
 UOhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoYrRJV+li7AHan61e1aSmSuZEPaJ9IXpKkHdu4ICD3ZELRWn8K8zwyRkk9vcP4L0hF701zrqXeDPZ@nongnu.org
X-Gm-Message-State: AOJu0YxSam1HYgMu8gsioWZcm8xqHuuny1iYaZ3EJGHpZqnTfshHW8Lm
 1iNpOG5kzUFyT37ucknFGtknY9GIyqGjRJcZNGPs1pu3iWrgzp4Ot+D2UeiMHVvMS+Q=
X-Gm-Gg: ASbGnctBuld2OHuFPSM1DHTFbxa7PHcWWhaojTrKcoIyI86zk/R1+3F32DsJtHBJySc
 vNuXo1TNNtrYa7O6bcmEsDZSa4lALZyQ6Qcz7nBR81pXjIDh+x5v8iinKx6WISTyOxmYAvWc5nA
 NZjamoO+Ibbp6qkdaNpxt/oKLMZtpL8cNoMmirfQyV48EM/JBgMVW1fwSrlUQMr7IVc9ydxogxZ
 fJ/LMkHBVJ0qxUpdQKQYwdAXFFl2BsCK7upICRCUmBVeNpQE07IWs9l+X6/ulooHrZ29w75oMUj
 YQCt9d254lmb0jw1rMq6soqUhP7idkC/nVOWQbK4hznxaJoehy7b1hGzNTY7tExmbjPT93HygcS
 GEBfbxeW1BCUmmSVHuWGp+CEaLuXDcoPNZZlUNs3FEC9yMnCpm24j2pMivu63aJkcKWvvXkk=
X-Google-Smtp-Source: AGHT+IEPXrsfpfGG1Qr5DawBZLNrEFS1sUmsay9ObR89KwqZnSWGBVpHm9atdMP1DSumRmmhtnzGJA==
X-Received: by 2002:a17:907:72ce:b0:b04:61aa:6adc with SMTP id
 a640c23a62f3a-b0461aa6b6fmr369280966b.7.1756905413541; 
 Wed, 03 Sep 2025 06:16:53 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0431832a98sm695475966b.80.2025.09.03.06.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:16:53 -0700 (PDT)
Message-ID: <fedefa11-2338-4e39-9148-6d53854bb5e5@linaro.org>
Date: Wed, 3 Sep 2025 15:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] target/loongarch: Add common API
 loongarch_tlb_search_cb()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-8-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-8-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> Common API loongarch_tlb_search_cb() is added here to search TLB entry
> with specified address.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 006fe1b207..fc853f6e80 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -207,18 +207,16 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
>    * field in tlb entry contains bit[47:13], so need adjust.
>    * virt_vpn = vaddr[47:13]
>    */
> -static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
> -                                 int *index)
> +static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
> +                                    int *index, int asid, tlb_match func)

Name the parameter csr_asid, then

>   {
>       LoongArchTLB *tlb;
>       uint16_t csr_asid, tlb_asid, stlb_idx;
>       uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
>       int i, compare_shift;
>       uint64_t vpn, tlb_vppn;
> -    tlb_match func;
>   
> -    func = tlb_match_any;
> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> +    csr_asid = asid;

this is unnecessary.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

