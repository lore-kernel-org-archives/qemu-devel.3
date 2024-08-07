Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A58BC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbqIt-0007Dq-BW; Wed, 07 Aug 2024 19:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbqIj-0006yn-U3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:42:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbqIh-0000Ql-DC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:42:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so4382425ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723074157; x=1723678957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Cpov3Q9VOuZfZ+mIJ/vv5cCCUpH64dhPti2NThS674=;
 b=PXrCsBSRYfbXCw2dS8ZTVJP0NGwlCimhc9CR/qwUDZ/IBXamHiRmPExInOiOmwIY7o
 es4yxa0Q3Jt3WzZxlB9IZQDnAiMdoebldMvP7loizlvDaHUnATjGgY9SX25+ritKpj66
 Y97mrx2jrGQ3WaIEz73AdMZZ61Uuq0xhi1ZaGtnPJOng5p+g42PTsRgvX34/gsXTJjh+
 ijkd5cDTSRxiFrj2Tpsi5xdo+tVGzmaRfzeRYW9/TFcS5FHzCk2hh+o8ITVp9tKeNIz6
 6Z8FHmTrXq5hxVgRJiDXA7NnFTlpw6JLhqa+J4PtxtR/+04SIp+8OwE8LOAzxLebjeow
 W3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723074157; x=1723678957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Cpov3Q9VOuZfZ+mIJ/vv5cCCUpH64dhPti2NThS674=;
 b=klGsw9UiDF6oRCDkzvANP/lrLa1sQI2JAtgqhzrB0AZIu8e7IIuyXB6H0P469crpMm
 VxIbE/gbKXeaJance45yo5niQ6DW2Hnic1sDQO+T5dEQidN8KVERzVdZSrjyPLOR6GQY
 sheelvbJMGKyBRHuDx35H2EkzyF+yvPuYMbGE5An+Kyq1yAX6QgjkSmJ9fZh0MitnLWk
 j6eIJyFzgmQfBkxJ+9PwdNj7izO3BdhIOCGzy0GpswLRhKJsihkXw8FM3SdXHd/9nJyP
 XLn6JQIr09d4Gc3myQe9U9h7+Tn3/X1B5NC4xq15zzFC65eJhIasaknIyKj+5mHcuDDN
 C/Ew==
X-Gm-Message-State: AOJu0Ywd9dfoPXhbFklzO9HqOOQ00qG7WfSAzsX7Q534UhWhsOcbuxxp
 tetI0m21BwacWNGWvyxdO9sNpPhoFdx3QtUOP78YfsSDwab+fse+lgaAVUlo6LG3z2D09kZgLJ2
 chX0=
X-Google-Smtp-Source: AGHT+IHl+lfAE/SQMtBod7ADf2Fk5pLxM1mWoy9NZFnajfBENgut3i3LTkDJGbVeV58ZJWRvR06jHg==
X-Received: by 2002:a17:902:d502:b0:1fd:a942:154d with SMTP id
 d9443c01a7336-20095249e25mr2903255ad.22.1723074157067; 
 Wed, 07 Aug 2024 16:42:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59060045sm111864545ad.147.2024.08.07.16.42.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 16:42:36 -0700 (PDT)
Message-ID: <7c327df7-167c-4f08-b835-b08f8aea975a@linaro.org>
Date: Thu, 8 Aug 2024 09:42:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 3/4] hw/ssi/pnv_spi: Return early in transfer()
To: qemu-devel@nongnu.org
References: <20240807202804.56038-1-philmd@linaro.org>
 <20240807202804.56038-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807202804.56038-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/8/24 06:28, Philippe Mathieu-Daudé wrote:
> Return early to simplify next commit.
> No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ssi/pnv_spi.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 13a47f07e7..05e6afc11e 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -217,6 +217,9 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>       PnvXferBuffer *rsp_payload = NULL;
>   
>       rsp_payload = pnv_spi_xfer_buffer_new();

this uses g_malloc0

> +    if (!rsp_payload) {
> +        return;
> +    }

so this will never fail.

>       for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
>           tx = 0;
>           for (int i = 0; i < s->transfer_len; i++) {
> @@ -235,9 +238,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>                       (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
>           }
>       }
> -    if (rsp_payload != NULL) {
> -        spi_response(s, s->N1_bits, rsp_payload);
> -    }
> +    spi_response(s, s->N1_bits, rsp_payload);
>   }

The cleanup could simply be this hunk.


r~

