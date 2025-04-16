Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC7FC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Fe-00056h-34; Wed, 16 Apr 2025 15:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58FS-0004xQ-An
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:16:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58FP-0006Ez-Un
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:16:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2264aefc45dso756845ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830994; x=1745435794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1WegXKxVDx2IXkYJ5P6MvbL5SnrvVIuFMpmp31Xss84=;
 b=w6GVNxRjvbI0zKN9XKKhy1HnD82nfpuePHwgUnEwDJ+EFUK5Igwo31zp80kYcrdbSP
 mVAW3rbBQ7z07ZDxkjv8aSg4GZu79dJLIbJ5yy4aW69czJ6B6+9Vee4WB1ML/hQInMoy
 zRrAw1nrr+kRJA7opq4cglCXyQThMP2Lc0K3xGy66YyaZwPDLi2Tz4Tyxc8VbnGKBWO+
 jpzEfH2O0un8dZMleDVdd1Ne1vM9t0CNkX3CBJFRkSD7A4ANThleHfl2Zmbym+V7D7M1
 Bs66iwWktad4Oz9JEBM0FaVuhLFm3YJJkd2284h7FK0xdtDmcs62YwSc3gG+PG3P56b7
 Un6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830994; x=1745435794;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WegXKxVDx2IXkYJ5P6MvbL5SnrvVIuFMpmp31Xss84=;
 b=fVcrPVAj1w47aNuO0q2fwC22q9/JQMvIZT263NDjstuDz3IJzElf/O5VHWmTJroR6+
 GoQRaCyQGbbKUxcta7V8Wz4g1kRBzDbNjTw8C5XYW5ziKGzCxBfdhem0LRbwlrBMjoB+
 9tuzBUFwrEgTRJzfpZSLrnRIREHk1gxTOObx5hJ/PuC76AJiyObfIfxlZpNVUUkJ47nz
 k3hcSo8M6VRHXgAdmGKy3bRNHHDrsvDKGffSe99lShoViKT7oahfuyKz12IqvPulLUFD
 regFXH1/1uTKupHc6zVDDsR8q6IcxtcgP0DPbaQ5XL6mFXtumHbki6jLklODTF6lUlmZ
 QWMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAD2mb0kM+0NR3+4Jvrp2H9mtG5jOrA/rS8JvaDLmdy53GzMkN7EQE1Jc4+Ly451IYw2MDU5hXGeaJ@nongnu.org
X-Gm-Message-State: AOJu0YxuF3oHuRwy07k9udaMXVkryCpQMNrsY3mMSOAWWk+MI+qFs4xy
 JN/PmHmhUrbbWVmKHAJbZhxcceoNUWOjjlHEIz20mQsmECnsHvU2SUzSeA1oxhw=
X-Gm-Gg: ASbGncuqhI4bA8+RqMvts7p4ku71E8NOtNXH1JTNRBrP4skumrb+b51tPcKjD6W7xUl
 3ZJFwENpkIekfgfHcR0cGBU+BFx+yWpEIGObJ9vfBslJzBJBveJKKrU61sEO3BNOyMQYDM6wVA5
 wKqnPwNOyFLk7Y1o3JJZbdZgtZjioXolrHj8a3qX8vH7SSLMge0p3ZTPmRvZ72Q5pBeWLvLqFFD
 NwbsFZ7dHNu155Skexz9pLfE0lLOlRnBzDhCgxKIg3+1WUl1vi4q8azww5wBUwSX7Lz+otoFVMu
 KnCMEVpSiodNeibUFx6J7e0UFMvKB8lET2LYunZaL9ld0YgEeRW5OA==
X-Google-Smtp-Source: AGHT+IHZNx237Sjics6iTRUn1DWT4izGdZBvKmxLkU0xJr2vQGY2adIueU325ilmFULkuWZeSFUxkw==
X-Received: by 2002:a17:902:d546:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22c3597429emr49256805ad.39.1744830993969; 
 Wed, 16 Apr 2025 12:16:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198c0bsm10692516b3a.23.2025.04.16.12.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:16:33 -0700 (PDT)
Message-ID: <a5ad9f83-de73-4e75-9234-9b55580a2fa6@linaro.org>
Date: Wed, 16 Apr 2025 12:16:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 140/163] tcg/s390: Add TCG_CT_CONST_N32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-141-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-141-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> We were using S32 | U32 for add2/sub2.  But the ALGFI and SLGFI
> insns that implement this both have uint32_t immediates.
> This makes the composite range balanced and
> enables use of -0xffffffff ... -0x80000001.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-con-set.h | 2 +-
>   tcg/s390x/tcg-target-con-str.h | 1 +
>   tcg/s390x/tcg-target.c.inc     | 8 ++++++--
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
> index 78f06e3e52..f5d3878070 100644
> --- a/tcg/s390x/tcg-target-con-set.h
> +++ b/tcg/s390x/tcg-target-con-set.h
> @@ -44,4 +44,4 @@ C_O2_I2(o, m, 0, r)
>   C_O2_I2(o, m, r, r)
>   C_O2_I3(o, m, 0, 1, r)
>   C_N1_O1_I4(r, r, 0, 1, ri, r)
> -C_N1_O1_I4(r, r, 0, 1, rJU, r)
> +C_N1_O1_I4(r, r, 0, 1, rUV, r)
> diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
> index 3e574e0662..636a38a168 100644
> --- a/tcg/s390x/tcg-target-con-str.h
> +++ b/tcg/s390x/tcg-target-con-str.h
> @@ -24,4 +24,5 @@ CONST('M', TCG_CT_CONST_M1)
>   CONST('N', TCG_CT_CONST_INV)
>   CONST('R', TCG_CT_CONST_INVRISBG)
>   CONST('U', TCG_CT_CONST_U32)
> +CONST('V', TCG_CT_CONST_N32)
>   CONST('Z', TCG_CT_CONST_ZERO)
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index e262876614..9b28083945 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -43,6 +43,7 @@
>   #define TCG_CT_CONST_INVRISBG   (1 << 14)
>   #define TCG_CT_CONST_CMP        (1 << 15)
>   #define TCG_CT_CONST_M1         (1 << 16)
> +#define TCG_CT_CONST_N32        (1 << 17)
>   
>   #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 16)
>   #define ALL_VECTOR_REGS      MAKE_64BIT_MASK(32, 32)
> @@ -613,7 +614,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
>       if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
>           return true;
>       }
> -    if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
> +    if ((ct & TCG_CT_CONST_U32) && uval <= UINT32_MAX) {
> +        return true;
> +    }
> +    if ((ct & TCG_CT_CONST_N32) && -uval <= UINT32_MAX) {
>           return true;
>       }
>       if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
> @@ -3548,7 +3552,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_add2_i64:
>       case INDEX_op_sub2_i64:
> -        return C_N1_O1_I4(r, r, 0, 1, rJU, r);
> +        return C_N1_O1_I4(r, r, 0, 1, rUV, r);
>   
>       case INDEX_op_st_vec:
>           return C_O0_I2(v, r);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


