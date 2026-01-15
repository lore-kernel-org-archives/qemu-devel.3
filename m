Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38624D4114A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 09:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJQm-0008So-Gv; Thu, 15 Jan 2026 04:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgJQl-0008Ok-7i
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgJQj-0004n7-2w
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768468451;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tRCtOZRH24BNw/tByfOLyvdY/+/BDJeMSH+11WTiQw=;
 b=PoxoRkWEkr+6WsJl99qjwj8GGCmbM0NEpgJe70+2fXeqtrLY/DY7brUJxLSzahuGj/sSuj
 YcmlpcYFkCt/ZuA2AKQfIdlXLqd+lIHBE927DMwbrb6AaJQf+uTfFmBVlbotHznhVLNjSn
 fMsSd3A/WqcWaA71n2kY2zu7DZOqhpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ZDOmuGvGNFW1e0Q_QMu6sQ-1; Thu, 15 Jan 2026 04:14:09 -0500
X-MC-Unique: ZDOmuGvGNFW1e0Q_QMu6sQ-1
X-Mimecast-MFC-AGG-ID: ZDOmuGvGNFW1e0Q_QMu6sQ_1768468449
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso3493195e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 01:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768468448; x=1769073248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tRCtOZRH24BNw/tByfOLyvdY/+/BDJeMSH+11WTiQw=;
 b=XxSaC4ldyugz/l2f4tPF+f5bUiYeO62ofnMkSirZM88jAKVxEF43NEi+bOPMdsy2vb
 x5J3Kr68QASpSc0NYOn0hCQIsTHTcm762g/gWnXGSdVkBASXH6hdJxkfisADLOixyLN8
 qNgXdcyb1jUZyYHSuarLM21gJGjjQWvJyLNRQbE5e8PQwXGcUl2lUDdvCeaRUpT2EYQx
 RrXK6FkvjYAaftAgiQ8GLbILYHLhnSjgv6ln0xhKzzs26mlHs1gqfh8hE9ysPm8ALt9t
 hpCDUXELmbuSbwoKK4y7RPpIxfcTc+aw8wLGaBpWSPms51DMsAzm7NJqTP54jTD10yO0
 h8PA==
X-Gm-Message-State: AOJu0YyCspukdiDoFBHDD9KeGjSXpuYXfrYXolqrCRN8l44IB2hSBYUt
 OKZ5q8Bq0Q59wF4jSpzUYm3kraKWKHcfJjIDf9zKWxauXe1wFQQSoz6jdrJOsQibz6zrPMj8TNB
 4c2dSAOFNrTk0pDBRV3KJ27DlLtJirJ2kobZrAfE8RqR8iw1PKwiO5b7o
X-Gm-Gg: AY/fxX6RVGVQc+FPiT+83Mayn6hEdZD8eNO6+v+T8KKv8dvh10ofv5TMDatfQuufk1d
 dtRN/XWkwTP3doy8Bi0A7cwr7upY7HgWkYa7CqzOtHL8lsKv6eg2pTcy1ESqPCaJScpEW+wGRBl
 s1fmHq52/GLTjvbTOauOchCWVPA3AvqtJT/L8wlGqZLWjZlMnPIm+pxO2ZUpM+DXHYOctC+hKLf
 NTes+3bXN0RhpE941CzoJATUPtNShhrM+oCSCrutbUC4odpuGMcBOt4rU40s0L5XfsMng8AE/fO
 C3RJs9zHUtHL5C63zMlr7ULoCbOThgf6uMuhHMwbkBpwYZ2LibYzl3IVZ0Uo+m1pykU4UhOjdUv
 CKDrjYRlurxkqfHxvIVZ534jT9LElKCZ6H7pHsZ4F+r7B37JUIpoPb4ZRuQ==
X-Received: by 2002:a05:600c:4f13:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-4801c2fb3d3mr7387655e9.20.1768468448472; 
 Thu, 15 Jan 2026 01:14:08 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-4801c2fb3d3mr7387305e9.20.1768468448057; 
 Thu, 15 Jan 2026 01:14:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b26764fsm36018985e9.12.2026.01.15.01.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 01:14:07 -0800 (PST)
Message-ID: <9f780549-8d03-4761-a2c0-32e85d245a0d@redhat.com>
Date: Thu, 15 Jan 2026 10:14:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 2/7] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-3-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251224034647.2596434-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 12/24/25 4:46 AM, Tao Tang wrote:
> Switch STE/CD bitfield definitions and accessors to the
> 'hw/registerfields.h' REG/FIELD API.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  include/hw/arm/smmuv3-common.h | 169 +++++++++++++++++++++++----------
>  1 file changed, 120 insertions(+), 49 deletions(-)
>
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 9da817f41a..b6da2fd62c 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -11,6 +11,8 @@
>  #ifndef HW_ARM_SMMUV3_COMMON_H
>  #define HW_ARM_SMMUV3_COMMON_H
>  
> +#include "hw/registerfields.h"
> +
>  /* Configuration Data */
>  
>  /* STE Level 1 Descriptor */
> @@ -35,63 +37,132 @@ typedef struct CD {
>  
>  /* STE fields */
>  
> -#define STE_VALID(x)   extract32((x)->word[0], 0, 1)
> +REG32(STE_0, 0)
> +    FIELD(STE_0, VALID, 0, 1)
> +    FIELD(STE_0, CONFIG, 1, 3)
> +    FIELD(STE_0, S1FMT, 4, 2)
> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
> +REG32(STE_1, 4)
> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
not related to your patch, but shouldn't it be 24 instead of 16
> +    FIELD(STE_1, S1CDMAX, 27, 5)
> +REG32(STE_2, 8)
> +    FIELD(STE_2, S1STALLD, 27, 1)
> +    FIELD(STE_2, EATS, 28, 2)
> +    FIELD(STE_2, STRW, 30, 2)
> +REG32(STE_4, 16)
> +    FIELD(STE_4, S2VMID, 0, 16)
> +REG32(STE_5, 20)
> +    FIELD(STE_5, S2T0SZ, 0, 6)
> +    FIELD(STE_5, S2SL0, 6, 2)
> +    FIELD(STE_5, S2TG, 14, 2)
> +    FIELD(STE_5, S2PS, 16, 3)
> +    FIELD(STE_5, S2AA64, 19, 1)
> +    FIELD(STE_5, S2ENDI, 20, 1)
> +    FIELD(STE_5, S2AFFD, 21, 1)
> +    FIELD(STE_5, S2HD, 23, 1)
> +    FIELD(STE_5, S2HA, 24, 1)
> +    FIELD(STE_5, S2S, 25, 1)
> +    FIELD(STE_5, S2R, 26, 1)
> +REG32(STE_6, 24)
> +    FIELD(STE_6, S2TTB_LO, 4, 28)
> +REG32(STE_7, 28)
> +    FIELD(STE_7, S2TTB_HI, 0, 16)
same here?
> +
> +/* Get STE fields */
> +#define STE_VALID(x)      FIELD_EX32((x)->word[0], STE_0, VALID)
> +#define STE_CONFIG(x)     FIELD_EX32((x)->word[0], STE_0, CONFIG)
> +#define STE_S1FMT(x)      FIELD_EX32((x)->word[0], STE_0, S1FMT)
> +#define STE_CTXPTR(x)                                               \
> +    (((uint64_t)FIELD_EX32((x)->word[0], STE_0, CTXPTR_LO) << 6) |  \
> +     ((uint64_t)FIELD_EX32((x)->word[1], STE_1, CTXPTR_HI) << 32))
> +#define STE_S1CDMAX(x)    FIELD_EX32((x)->word[1], STE_1, S1CDMAX)
> +#define STE_S1STALLD(x)   FIELD_EX32((x)->word[2], STE_2, S1STALLD)
> +#define STE_EATS(x)       FIELD_EX32((x)->word[2], STE_2, EATS)
> +#define STE_STRW(x)       FIELD_EX32((x)->word[2], STE_2, STRW)
> +#define STE_S2VMID(x)     FIELD_EX32((x)->word[4], STE_4, S2VMID)
> +#define STE_S2T0SZ(x)     FIELD_EX32((x)->word[5], STE_5, S2T0SZ)
> +#define STE_S2SL0(x)      FIELD_EX32((x)->word[5], STE_5, S2SL0)
> +#define STE_S2TG(x)       FIELD_EX32((x)->word[5], STE_5, S2TG)
> +#define STE_S2PS(x)       FIELD_EX32((x)->word[5], STE_5, S2PS)
> +#define STE_S2AA64(x)     FIELD_EX32((x)->word[5], STE_5, S2AA64)
> +#define STE_S2ENDI(x)     FIELD_EX32((x)->word[5], STE_5, S2ENDI)
> +#define STE_S2AFFD(x)     FIELD_EX32((x)->word[5], STE_5, S2AFFD)
> +#define STE_S2HD(x)       FIELD_EX32((x)->word[5], STE_5, S2HD)
> +#define STE_S2HA(x)       FIELD_EX32((x)->word[5], STE_5, S2HA)
> +#define STE_S2S(x)        FIELD_EX32((x)->word[5], STE_5, S2S)
> +#define STE_S2R(x)        FIELD_EX32((x)->word[5], STE_5, S2R)
> +#define STE_S2TTB(x)                                                \
> +    (((uint64_t)FIELD_EX32((x)->word[6], STE_6, S2TTB_LO) << 4) |   \
> +     ((uint64_t)FIELD_EX32((x)->word[7], STE_7, S2TTB_HI) << 32))
>  
> -#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
>  #define STE_CFG_S1_ENABLED(config) (config & 0x1)
>  #define STE_CFG_S2_ENABLED(config) (config & 0x2)
>  #define STE_CFG_ABORT(config)      (!(config & 0x4))
>  #define STE_CFG_BYPASS(config)     (config == 0x4)
>  
> -#define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
> -#define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
> -#define STE_S1STALLD(x)    extract32((x)->word[2], 27, 1)
> -#define STE_EATS(x)        extract32((x)->word[2], 28, 2)
> -#define STE_STRW(x)        extract32((x)->word[2], 30, 2)
> -#define STE_S2VMID(x)      extract32((x)->word[4], 0 , 16)
> -#define STE_S2T0SZ(x)      extract32((x)->word[5], 0 , 6)
> -#define STE_S2SL0(x)       extract32((x)->word[5], 6 , 2)
> -#define STE_S2TG(x)        extract32((x)->word[5], 14, 2)
> -#define STE_S2PS(x)        extract32((x)->word[5], 16, 3)
> -#define STE_S2AA64(x)      extract32((x)->word[5], 19, 1)
> -#define STE_S2ENDI(x)      extract32((x)->word[5], 20, 1)
> -#define STE_S2AFFD(x)      extract32((x)->word[5], 21, 1)
> -#define STE_S2HD(x)        extract32((x)->word[5], 23, 1)
> -#define STE_S2HA(x)        extract32((x)->word[5], 24, 1)
> -#define STE_S2S(x)         extract32((x)->word[5], 25, 1)
> -#define STE_S2R(x)         extract32((x)->word[5], 26, 1)
> -
> -#define STE_CTXPTR(x)                                   \
> -    ((extract64((x)->word[1], 0, 16) << 32) |           \
> -     ((x)->word[0] & 0xffffffc0))
> -
> -#define STE_S2TTB(x)                                    \
> -    ((extract64((x)->word[7], 0, 16) << 32) |           \
> -     ((x)->word[6] & 0xfffffff0))
> -
>  /* CD fields */
>  
> -#define CD_VALID(x)   extract32((x)->word[0], 31, 1)
> -#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
> -#define CD_TTB(x, sel)                                          \
> -    ((extract64((x)->word[(sel) * 2 + 3], 0, 19) << 32) |       \
> -     ((x)->word[(sel) * 2 + 2] & ~0xfULL))
> -
> -#define CD_HAD(x, sel)   extract32((x)->word[(sel) * 2 + 2], 1, 1)
> -
> -#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
> -#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
> -#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
> -#define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
> -#define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
> -#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
> -#define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
> -#define CD_HD(x)         extract32((x)->word[1], 10 , 1)
> -#define CD_HA(x)         extract32((x)->word[1], 11 , 1)
> -#define CD_S(x)          extract32((x)->word[1], 12, 1)
> -#define CD_R(x)          extract32((x)->word[1], 13, 1)
> -#define CD_A(x)          extract32((x)->word[1], 14, 1)
> -#define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
> +REG32(CD_0, 0)
> +    FIELD(CD_0, TSZ0, 0, 6)
> +    FIELD(CD_0, TG0, 6, 2)
> +    FIELD(CD_0, EPD0, 14, 1)
> +    FIELD(CD_0, ENDI, 15, 1)
> +    FIELD(CD_0, TSZ1, 16, 6)
> +    FIELD(CD_0, TG1, 22, 2)
> +    FIELD(CD_0, EPD1, 30, 1)
> +    FIELD(CD_0, VALID, 31, 1)
> +REG32(CD_1, 4)
> +    FIELD(CD_1, IPS, 0, 3)
> +    FIELD(CD_1, AFFD, 3, 1)
> +    FIELD(CD_1, TBI, 6, 2)
> +    FIELD(CD_1, AARCH64, 9, 1)
> +    FIELD(CD_1, HD, 10, 1)
> +    FIELD(CD_1, HA, 11, 1)
> +    FIELD(CD_1, S, 12, 1)
> +    FIELD(CD_1, R, 13, 1)
> +    FIELD(CD_1, A, 14, 1)
> +    FIELD(CD_1, ASID, 16, 16)
> +REG32(CD_2, 8)
> +    FIELD(CD_2, HAD0, 1, 1)
> +    FIELD(CD_2, TTB0_LO, 4, 28)
> +REG32(CD_3, 12)
> +    FIELD(CD_3, TTB0_HI, 0, 19)
I think it is 24 now
> +REG32(CD_4, 16)
> +    FIELD(CD_4, HAD1, 1, 1)
> +    FIELD(CD_4, TTB1_LO, 4, 28)
> +REG32(CD_5, 20)
> +    FIELD(CD_5, TTB1_HI, 0, 19)
same
> +
> +/* Get CD fields */
> +#define CD_TSZ(x, sel)   ((sel) ?          \
> +    FIELD_EX32((x)->word[0], CD_0, TSZ1) : \
> +    FIELD_EX32((x)->word[0], CD_0, TSZ0))
> +#define CD_TG(x, sel)    ((sel) ?          \
> +    FIELD_EX32((x)->word[0], CD_0, TG1) :  \
> +    FIELD_EX32((x)->word[0], CD_0, TG0))
> +#define CD_EPD(x, sel)   ((sel) ?          \
> +    FIELD_EX32((x)->word[0], CD_0, EPD1) : \
> +    FIELD_EX32((x)->word[0], CD_0, EPD0))
> +#define CD_ENDI(x)       FIELD_EX32((x)->word[0], CD_0, ENDI)
> +#define CD_VALID(x)      FIELD_EX32((x)->word[0], CD_0, VALID)
> +#define CD_IPS(x)        FIELD_EX32((x)->word[1], CD_1, IPS)
> +#define CD_AFFD(x)       FIELD_EX32((x)->word[1], CD_1, AFFD)
> +#define CD_TBI(x)        FIELD_EX32((x)->word[1], CD_1, TBI)
> +#define CD_AARCH64(x)    FIELD_EX32((x)->word[1], CD_1, AARCH64)
> +#define CD_HD(x)         FIELD_EX32((x)->word[1], CD_1, HD)
> +#define CD_HA(x)         FIELD_EX32((x)->word[1], CD_1, HA)
> +#define CD_S(x)          FIELD_EX32((x)->word[1], CD_1, S)
> +#define CD_R(x)          FIELD_EX32((x)->word[1], CD_1, R)
> +#define CD_A(x)          FIELD_EX32((x)->word[1], CD_1, A)
> +#define CD_ASID(x)       FIELD_EX32((x)->word[1], CD_1, ASID)
> +#define CD_HAD(x, sel)   ((sel) ?                                         \
> +    FIELD_EX32((x)->word[4], CD_4, HAD1) :                                \
> +    FIELD_EX32((x)->word[2], CD_2, HAD0))
> +#define CD_TTB(x, sel)                                                    \
> +    ((sel) ? (((uint64_t)FIELD_EX32((x)->word[5], CD_5, TTB1_HI) << 32) | \
> +              ((uint64_t)FIELD_EX32((x)->word[4], CD_4, TTB1_LO) << 4)) : \
> +             (((uint64_t)FIELD_EX32((x)->word[3], CD_3, TTB0_HI) << 32) | \
> +              ((uint64_t)FIELD_EX32((x)->word[2], CD_2, TTB0_LO) << 4)))
>  
>  /* MMIO Registers */
>  
Otherwise looks good to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


