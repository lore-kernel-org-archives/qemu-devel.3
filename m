Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E645ACD3426
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 00:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skY07-000682-Rq; Sat, 31 Aug 2024 19:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skY05-00064X-HA
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 19:59:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skY04-0005xQ-2P
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 19:59:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7141d7b270dso2450905b3a.2
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2024 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725148761; x=1725753561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1C+IsaVHKuVb0BZ7RT7CeXQOGgCh8DSHYYCo+ATWA7g=;
 b=SHkSdhJ2cRMDxCPZwIir9DkC0ZvwrUBjc6HpT6TgsiV9U4nieC7Hz4XX03VZs5PzRw
 YXLjphxmWYE4a1JYOPOW9etlc5WmyoUWX0haJFBQbOoz3vxrXWFWXtkLM+k/pTBwIDDV
 CptwmdxXMCxWnmru+Rs6bP4z6ZGsYcko3Q4Ymy/V8nugeQMV5Ue7J2g9NgIUPU2R3K6b
 ZiNw+A3UQCAMvmMxaDU8ZtEycYYks0DO+wP3vjGs54cPlyAVmH4X7NRQFeSMRy/4YmY2
 emJLOXCjs64w2MSBJ/LQWF13kmKG+SyQ0FxFH/3MdAW8jHMV9dVJQUU/Tp/J/HkLwVwN
 Pe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725148761; x=1725753561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1C+IsaVHKuVb0BZ7RT7CeXQOGgCh8DSHYYCo+ATWA7g=;
 b=SaK2PSNlsP7J13Bl1JZVnE9vSmRVGBzM0qRTDS9MTNxAb9JGCNrpwbnbkO5wsmX7XB
 y0a1C5+G3uh34aqOlxZm5U/goc6S06ZS68TMMlJfx4ztjxrK+wAC66ZpF4Wqmh/ogGkr
 UTzpCvA13hH9jdtglrbN1iuMRFVLCoCXvVsunX4qnnzKqVrKoSo6mm0R9B/bRlGm7hHs
 2aL7+PKgbmwa+AEB2+eFObmE2gLDiBRJrILSFVMtNVllxOeC+B77uyGtek9mRcCS9BTC
 rihuyFw3Oaw83YQsUUo5vfwZlcx3WmP3CQFw683eDqfT+AJNiE9SjtLb2rgpcmGBCneF
 2W9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ekrfwgQKBR19aQSwOqkP8sT4oKwUleq8bvh/lI/jotxrJ7i5coieRS+R7zmjBWMioTl5fvmSMoPk@nongnu.org
X-Gm-Message-State: AOJu0Yzj2oMgo2ougSz3ptlLPprx/T9FfD2a4iydxG0P7iwtiAO+zEGM
 YBVC9s1mGjc7Kj7IwkmstinVkp2GUP7UnPr81E2/s9kaBB3XpnR/NP3WWWq73kQ=
X-Google-Smtp-Source: AGHT+IHHVaazqiC+4xe8vhuia00xeSDdvvNTGSEIOgQlpgTaK5j6mR+zGZl2Nf0LX+xdDZbzgsYAYQ==
X-Received: by 2002:a05:6a20:c78f:b0:1c4:82fa:a5a4 with SMTP id
 adf61e73a8af0-1ced6088166mr1331373637.18.1725148761223; 
 Sat, 31 Aug 2024 16:59:21 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:20ac:c3e2:72e0:bdb8?
 ([2001:8004:5170:1fd8:20ac:c3e2:72e0:bdb8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205155452ecsm45201015ad.219.2024.08.31.16.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2024 16:59:20 -0700 (PDT)
Message-ID: <6b3305c3-2f23-47d0-949e-a3e562f49cbb@linaro.org>
Date: Sun, 1 Sep 2024 09:59:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] tcg/op-gvec: Fix iteration step in 32-bit
 operation
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-2-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/30/24 16:15, LIU Zhiwei wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> The loop in the 32-bit case of the vector compare operation
> was incorrectly incrementing by 8 bytes per iteration instead
> of 4 bytes. This caused the function to process only half of
> the intended elements.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Fixes: 9622c697d1 (tcg: Add gvec compare with immediate and scalar operand)
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/tcg-op-gvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 0308732d9b..78ee1ced80 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -3939,7 +3939,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
>           uint32_t i;
>   
>           tcg_gen_extrl_i64_i32(t1, c);
> -        for (i = 0; i < oprsz; i += 8) {
> +        for (i = 0; i < oprsz; i += 4) {
>               tcg_gen_ld_i32(t0, tcg_env, aofs + i);
>               tcg_gen_negsetcond_i32(cond, t0, t0, t1);
>               tcg_gen_st_i32(t0, tcg_env, dofs + i);


