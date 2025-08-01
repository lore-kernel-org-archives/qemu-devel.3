Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13057C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhk2s-0000rd-6i; Fri, 01 Aug 2025 03:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhk1j-0007wk-Sg
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 03:18:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhk1h-000260-TC
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 03:18:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2403ca0313aso11167085ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 00:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754032679; x=1754637479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QKQKvSewcXV7uD24UjryNWdWohOoIxOTZCtF0UcUmMY=;
 b=enNNLn1VOvqj1rxPoY6V+SesZEdzwj2evTDpNv2uhWyaPLw9PPbgVIv16GuptMtZon
 oXpcMnPjzmWGzw6ureos1blIztxvbZOBoOsDS57oZOaqwGBC7RK5AU0uSy2pmvq/vMDb
 yqp/fb3jVxDkYD/5TmwFsB6+QxXxc/RzBwW/rTQ/iIWU7EUWEhptJhRY32/kJ8wPEdEk
 B0t4bDZ25lQo3dSVb3BMIesEXybvknEhY2UcUk+RFibQ9R1H1afo7QLRfJ5jRSo+nJXI
 618tUys7cgk3ME2oOsSTNRekCjBdiO/T9KyEuBoFmIziPY7HaD6eDk1x299YeT/vgJej
 7Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754032679; x=1754637479;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKQKvSewcXV7uD24UjryNWdWohOoIxOTZCtF0UcUmMY=;
 b=AX77CPrRBB2NeSKuxOYUYo0WnzOEbcELWG9V5GpBhZR2wbv+yHiBQ+CEvClXg0vrjL
 +N7iU4Io1ZvI5antPk6DX/zZ2+u+7gm0iE3Wos44sHp/gT2TjObncun6Ez98OvdvJKQl
 5WKM+BfkM+5rgVk0aw7p+E7Nt/MPo3LMRfhkJL8kY+LDssRYm/rGywaSdldTRlKNYlyQ
 /6vWCRVurmXGpqszi/YlELfZ3z5qkRAPqPiv0wH6wr3ni+9TrXc42zUOHdt0jcA2bKXI
 hVuEajq6VornjKGauqXINOHQslvDdeNYvSkhFXCqKALYQXy/VBdj1utZupBFwr5nCb5d
 2lxA==
X-Gm-Message-State: AOJu0YwDOwpIs5pdkaHciaVIeCcoqSHJ4IBc7W0xiN0dAZTK9ANW/bK8
 Z2LBpbD5uqsHdT70O97R5jSL8nouqrgW4IXg7CpdW3F7zJv1dXhtZS8wmQV8u+ipIXJaHVBSxFY
 KBiEZtIw=
X-Gm-Gg: ASbGncsqRYcowoQS+oBCXH5ls7V5x4q6k+IMdjx96+tTSrld64hbuwgNeEGL8bxHpVL
 VdHIBMhp9QmLA++hCU6Qf8dbmir356Q3kJ2J8v5oYIvntynqz8gw1Nu0c/6hfWzVsiwdL/pxLIA
 04PTJPdJQ8M0BM3r9kR3INSNgyrh/98gcznu0dYkRv/+8PrMvsbuduFQa4hrV5ElT/kcbk2hW4e
 MjZFI5ACf/uS5WgaSVzhkZ4eClu9e1cDhOGeyjA+YAIkhpkIktKSGtdTqy/PIy7yOcQDcMbuBdY
 9Drx/SF5hT4QAATl1R9se3Dwtg6A0qRGnBiR5tLlBouD0RG0ccJ3LwgXic5P9nZq6sAVY7lCN1M
 sBK35dJrZjWo1F05RXAsX+8vtGMv+tpxcnq46ww//
X-Google-Smtp-Source: AGHT+IGg+ov5iBoqCnQpXuhAMQBvio5KYa4HnRBaXmzYfF9Nea2q4il8Nn+eUfgsbeCKMQy3tr7laQ==
X-Received: by 2002:a17:903:22c7:b0:240:96be:9117 with SMTP id
 d9443c01a7336-2422a432b95mr26583675ad.1.1754032679297; 
 Fri, 01 Aug 2025 00:17:59 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef8204sm35394115ad.34.2025.08.01.00.17.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 00:17:58 -0700 (PDT)
Message-ID: <befc0bd9-6bdb-4a9b-8676-d8bf35a34c07@linaro.org>
Date: Fri, 1 Aug 2025 17:17:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 03/11] hw/sd/sdcard: Propagate response size to
 sd_response_r*_make()
To: qemu-devel@nongnu.org
References: <20250731212807.2706-1-philmd@linaro.org>
 <20250731212807.2706-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731212807.2706-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/1/25 07:27, Philippe Mathieu-Daudé wrote:
> All sd_response_r*_make() fill the @response buffer. Now that
> sd_do_command() knows the buffer size, propagate it to the
> response fillers and assert for any overflow.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1d88aee38d5..22bdb4ca3ab 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -729,34 +729,52 @@ static int sd_req_crc_validate(SDRequest *req)
>       return sd_crc7(buffer, 5) != req->crc;  /* TODO */
>   }
>   
> -static void sd_response_r1_make(SDState *sd, uint8_t *response)
> +static size_t sd_response_r1_make(SDState *sd, uint8_t *response, size_t respsz)
>   {
> +    size_t rsplen = 4;
> +
> +    assert(respsz >= 4);
>       stl_be_p(response, sd->card_status);
>   
>       /* Clear the "clear on read" status bits */
>       sd->card_status &= ~CARD_STATUS_C;
> +
> +    return rsplen;
>   }
>   
> -static void sd_response_r3_make(SDState *sd, uint8_t *response)
> +static size_t sd_response_r3_make(SDState *sd, uint8_t *response, size_t respsz)
>   {
> +    size_t rsplen = 4;
> +
> +    assert(respsz >= rsplen);
>       stl_be_p(response, sd->ocr & ACMD41_R3_MASK);
> +
> +    return rsplen;
>   }
>   
> -static void sd_response_r6_make(SDState *sd, uint8_t *response)
> +static size_t sd_response_r6_make(SDState *sd, uint8_t *response, size_t respsz)
>   {
>       uint16_t status;
>   
> +    assert(respsz >= 4);
>       status = ((sd->card_status >> 8) & 0xc000) |
>                ((sd->card_status >> 6) & 0x2000) |
>                 (sd->card_status & 0x1fff);
>       sd->card_status &= ~(CARD_STATUS_C & 0xc81fff);
>       stw_be_p(response + 0, sd->rca);
>       stw_be_p(response + 2, status);
> +
> +    return 4;
>   }
>   
> -static void sd_response_r7_make(SDState *sd, uint8_t *response)
> +static size_t sd_response_r7_make(SDState *sd, uint8_t *response, size_t respsz)
>   {
> +    size_t rsplen = 4;
> +
> +    assert(respsz >= rsplen);
>       stl_be_p(response, sd->vhs);
> +
> +    return rsplen;
>   }
>   
>   static uint32_t sd_blk_len(SDState *sd)
> @@ -2207,33 +2225,31 @@ send_response:
>       switch (rtype) {
>       case sd_r1:
>       case sd_r1b:
> -        sd_response_r1_make(sd, response);
> -        rsplen = 4;
> +        rsplen = sd_response_r1_make(sd, response, respsz);
>           break;
>   
>       case sd_r2_i:
> +        assert(respsz >= 16);
>           memcpy(response, sd->cid, sizeof(sd->cid));
>           rsplen = 16;
>           break;
>   
>       case sd_r2_s:
> +        assert(respsz >= 16);
>           memcpy(response, sd->csd, sizeof(sd->csd));
>           rsplen = 16;
>           break;
>   
>       case sd_r3:
> -        sd_response_r3_make(sd, response);
> -        rsplen = 4;
> +        rsplen = sd_response_r3_make(sd, response, respsz);
>           break;
>   
>       case sd_r6:
> -        sd_response_r6_make(sd, response);
> -        rsplen = 4;
> +        rsplen = sd_response_r6_make(sd, response, respsz);
>           break;
>   
>       case sd_r7:
> -        sd_response_r7_make(sd, response);
> -        rsplen = 4;
> +        rsplen = sd_response_r7_make(sd, response, respsz);
>           break;
>   
>       case sd_r0:

I'm not keen on this, with constants and assertions scattered across 5 functions.


r~

