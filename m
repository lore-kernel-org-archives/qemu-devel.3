Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B59C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNB2-0006vz-V3; Tue, 03 Jun 2025 04:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMNB1-0006vX-Ao
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:39:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMNAy-0000kI-8L
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:39:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so3121097f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748939954; x=1749544754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Amxoytx7Q/MFSs92zgZ8wbv2ethU8a8vCVUCdQg9Cqs=;
 b=k6gjVVN6PEKvJhVdjtC2VUIB4H6kLDMTORNsV0Cqir7eBFoa3uNE6QT2ie+99QxDMi
 npCBGihjscwxkrs6U8nScysCph7zVySewX3WBwWY2iYG4RnMoMxDi+eDDXdCqCbY8rEx
 5szrNOj+yNI6Mvkyxvvo/ezAAeQSZ0m6QMUIYszDT81paUqoHdFJ0LpLTdblinMV+Kcn
 SMMUdw8orMlS/ucxWtDpY8oEVI+t7qiazAjrZoorp1nI3G1mdowQ4NkxB1ldq+reBe2Q
 14EZYOM/NDvEw3J1/DPO3udOg/rmX2fYIG6GWINpPIvzur2M7ghMh9+dIgGIMYjyLPZ3
 f0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748939954; x=1749544754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Amxoytx7Q/MFSs92zgZ8wbv2ethU8a8vCVUCdQg9Cqs=;
 b=odi7UykSbI4ardjbXHQaLEBZFJL//fCWlDOS9yPce/Uhsp8Js4GnlQMV/ooiwUnBci
 o46GtgHh6s2neUW1jG7N1p0eP2U/x941oTysYEhqPA7DBs6hah91TZlGx0UDjorLrHiR
 V82yvo7WxRtzQi3YixzcEk4ZQn2LfkB+1gTygjEu20w0lZnEQB5o/VzfOGHG3SOU1cDh
 yeL1mzVdCv+uXUf4AbbE5lFnioCDZ1thJZTvSFop9+MavA6LK1qgvExQHIUr4g9nK3QQ
 rYe72tvgALQRDYw5iMzNNU3kYrktHAg9mM0B5REJ//eCufn4m2gw/4KQMG9ntynDMq+v
 6h2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4njUGefXyLhbF/lplbPQbY1OTEEOa7HkG+jeLSdQnPGnKchMJyMpL70/j/mTFHPhSS9dYVHCrqYWD@nongnu.org
X-Gm-Message-State: AOJu0Yw9uD7GAF8Yk+z6lzdotWwuyHy1HRVP+K7iEfN9Bb56LuY6aeeG
 +ZWRVK8Q4jT32+KySElBMsscfpVwtIUmQkCOs9XKFI/9wvgzVsNjpuQtIdCL9pUwNZM=
X-Gm-Gg: ASbGncvFdTKTH/knyffgraHT/ihaWSc5y5kTXHslnmVUHlGwGIGh5L/+dFv5ITKKA4R
 XXFDbfkcY3HjMqyh9A7x0SQbx5mqH+2Evodi86cP2So7aco4JLk7gaoJYRwXlXswup28KrBofNn
 83SIXR9L4PKRKo1N7XT2VUjrwIO/CN8krV1IG0xHdlpo7Z1MLt18CBX7axOVZPOHad6AvAUEiNj
 1fR3rIng7YAe56ygKq+dHah/OORbpuG0GNIOwRmFRWZc3Ujsko48oLBKYNNp6/tgv2oeQxWE8vU
 9gF2rR0xgbCz/EP0yK4I9ewT11DkDTFvSPcU22VLBicmNBN1Yw+nDFswIfmVx6iqDpRbphoxJGD
 SjvajrIBZCsCIvb7/EXhm
X-Google-Smtp-Source: AGHT+IE2wq1hFwGpjOf658t9nJ6JZdBAXQCXhDtTNEWYfXlgl+qVFYUxcZ0kHXEegcXmHOVx7pUOeA==
X-Received: by 2002:a05:6000:40e1:b0:3a4:f661:c3e2 with SMTP id
 ffacd0b85a97d-3a4fe3a8127mr8510212f8f.55.1748939953760; 
 Tue, 03 Jun 2025 01:39:13 -0700 (PDT)
Received: from [192.168.1.127] (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa23f4sm158721725e9.14.2025.06.03.01.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 01:39:13 -0700 (PDT)
Message-ID: <1402c3b9-60a4-4696-9b30-acec25df6859@linaro.org>
Date: Tue, 3 Jun 2025 09:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250603081127.353730-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250603081127.353730-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 6/3/25 09:11, Song Gao wrote:
> on qemu we got an aborted error
> **
> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Aborted (core dumped)
> bu on 3A600/3A5000 we got a "Illegal instruction" error.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..f8ff4fa18c 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   {
>       int mode;
> -    uint64_t data, t;
> +    uint64_t data = 0, t;
>   
>       /*
>        * imm bit [11:8] is mode, mode value is 0-12.
> @@ -3569,18 +3569,24 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>               data = (t1 << 54) | (t0 << 48);
>           }
>           break;
> -    default:
> -        generate_exception(ctx, EXCCODE_INE);
> -        g_assert_not_reached();

Drop the generate_exception, but keep the assert.
It really is no longer reachable because of check_vldi_mode().

>       }
>       return data;
>   }
>   
> +static bool check_vldi_mode(arg_vldi *a)
> +{
> +   return (a->imm >>8 & 0xf) > 12 ? false : true;

Never use ?: with true/false.  Just use the proper boolean expression:

     return ((a->imm >> 8) & 0xf) <= 12;


r~

