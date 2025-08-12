Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58324CA0EDA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliRT-0000TK-SO; Tue, 12 Aug 2025 02:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliRN-0000Nc-FP
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:24:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliRJ-0007As-Ic
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:24:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so4097005f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979887; x=1755584687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Skp3Sj8ffOqN+1Y0U2M8nclHLhT4M40r5fxgnYMTLgw=;
 b=Aq4Av5j2Dr4A/pxLFGtGBsOIAnJAjlLznSENlJ7Os+Mb8KGuADaS01A75YerGKnQk+
 e276EQQ/10tYvcPbu++dTTu8so4Dxj7bjHS703WD4X05sKFi3mhiYjrJUqK3H3O6YB6Z
 RqnZNBfo/OGHs7o7c8bhL4fNEg+6AJ1HTQrjLWMLnjIR4Rp+soa1uJ3SmhP17G2pOAsU
 2cTcYAf2crBTfjGXcTdx/mQaCc1wfAgcQ8TDOSVJDklEHyUo0BVaizblZ+GDmx3ewunF
 zMkkNjAZ4achJmQ3TtNMJwjgeDdUo+uMNQWV5+TiTy5tff3T4VwpdurzpRcsmu2YyFE/
 H5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979887; x=1755584687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Skp3Sj8ffOqN+1Y0U2M8nclHLhT4M40r5fxgnYMTLgw=;
 b=catzeusZFpyLuf9p6o75mtRwERjJGO5Z6a5isvdp7Nc00ksS+vJc/jk1p62rCF9fJ6
 Ri4V2yR6uyGhrB62U1Woe74ZT4qP9dpCjN71wg6SojZRYj6nry4hOEBEB+ShPfCacnHT
 gB2Ows3mwQriogZzVo9Fpm5YluZVjbBjWRemZvD52SrWJgevw7RuD4wENkXO3o2L8/9C
 lVBb/CB/Wrt6VarwzJz/obpdSjxqtYJHj/VbFK9LIuW6FHF5R76NQkMhAWLMpV/3js5i
 X7tTDr/IjaTzBsuLikWYRIusceNNPK5O2cqVvlGcYB5h5gCXfZJzG+7MWbNOLC0WXHgk
 cNFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBJGUPcpxgaE+UTip0aa3Dfi8Si4up1A1s/Us7W8eor/1NRTZt+o0YwhljlsuqF8QtNVECidojpsDX@nongnu.org
X-Gm-Message-State: AOJu0YwGuNRF9r2VVLO0Y6dOuaRIDNMXCm6E/x6uEESgnXXuL7vkKUrG
 S3Jo3dTCN9MJy5GbFoP0nmeQ7ZwOUYmnmNQKT6lfBeXDnmZOs0cKBRSCTpYRK/6vm3E=
X-Gm-Gg: ASbGncuXqibic1nGOa62fIs7tNtiL42QMMg++lyMAb8VwlXbmorsPKNK7hxJptF8k4k
 jlKQIbO1LRCm29n699Vt+Ti8ScuN7ZinSY10WlF6Y5qpja5imWa2/7/mKyLpzgPEktXBHXa5B+B
 05ShMJW8E3KLxSpnDgQ5LcfVVp73gGsJjazKpJZFk8CknH+wWfqqkxiGjk/QBdQk0Cbq/G023Sx
 Vn1Yg72sJt6CsN5K9UDFRLD9kOsT/t1/6enLJz7a8gtgyGzgwoWB/Uapty9pvlxXyYwNc00jzIo
 7RsZ3d9JW3UbNkuDHUnbzjTlVpF40Rh4KrnCrDLodn+t6KAPMQzuAR8t0Tqk3b67E8rxHJDJVg+
 IyvWefEs6nyuMMv9IffaIApU7qSiglINzq6rnAXdRNO1DT9FWymL6HaQGbHFMt2SdmA==
X-Google-Smtp-Source: AGHT+IEs8aaZPvoxHfE1VsVs5vBYqasR45I6HRqYWENtLGXMoSDPYTRpi5WI0CWMe5R+mehXJSy3XQ==
X-Received: by 2002:a05:6000:250a:b0:3b8:ffd3:7a7a with SMTP id
 ffacd0b85a97d-3b900b4db0emr11013056f8f.16.1754979887022; 
 Mon, 11 Aug 2025 23:24:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8f8b1bc81sm20903068f8f.69.2025.08.11.23.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:24:46 -0700 (PDT)
Message-ID: <4d6df871-bbe2-435a-89d3-a1784320c45b@linaro.org>
Date: Tue, 12 Aug 2025 08:24:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/85] target/arm: Do not migrate env->exception
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 3/8/25 01:28, Richard Henderson wrote:
> These are not architectural state, only placeholders
> between identifying the exception and delivering it.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/machine.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 6986915bee..8dbeca2867 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1085,9 +1085,9 @@ const VMStateDescription vmstate_arm_cpu = {
>           VMSTATE_UINT64(env.exclusive_val, ARMCPU),
>           VMSTATE_UINT64(env.exclusive_high, ARMCPU),
>           VMSTATE_UNUSED(sizeof(uint64_t)),
> -        VMSTATE_UINT32(env.exception.syndrome, ARMCPU),
> -        VMSTATE_UINT32(env.exception.fsr, ARMCPU),
> -        VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
> +        VMSTATE_UNUSED(sizeof(uint32_t)),
> +        VMSTATE_UNUSED(sizeof(uint32_t)),
> +        VMSTATE_UNUSED(sizeof(uint64_t)),

Alternatively 4 + 4 + 8 or sizeof() + sizeof() + sizeof().

>           VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
>           VMSTATE_TIMER_PTR(gt_timer[GTIMER_VIRT], ARMCPU),
>           {
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


