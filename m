Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B0FC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 07:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMIK-0003TE-Vf; Tue, 03 Jun 2025 03:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMII-0003Lw-CR
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:42:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMIG-0002HH-Hm
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:42:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso44864435e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748936562; x=1749541362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxN0g6akjZ29HginSej/lLgAbMKoGS7g8ruTJ0dclR8=;
 b=iDV9dDJY1wqgY4/VPBxpzEoJ5iPyzSft9URNNxct1Hu4ARS6G4wSUtRxfmtP/KjNl8
 NeAsCpQsaN7FiG+IftrVdiAuhkCA/3LsbCehehBLQDNaNXTqWUDTGqWcLgLd85A0KZLs
 FxE2mmNQ+FIN/abQJgGg+TP8ftt6WPUtPhCSKXGzL89Cg+KXfTYh6qCV0j1nHjuBOFzw
 +2BUGNszkDtBrFg2KvlYGjSWFJ96SDYIbjZdOm9eYNqmwnaBlIg/cHIAOs28OMeOLUZn
 LGEcVDF8BldcpPI6Axt7ZPB5J/ydm3/JX4o16plQBPwyZjOxCsKaF3X9uXTFPJQX3paQ
 JN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748936562; x=1749541362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxN0g6akjZ29HginSej/lLgAbMKoGS7g8ruTJ0dclR8=;
 b=cz/i6af8KEGaeAgwahSSJtdM9Q1FT/RNG5cAOimcIwMXGOBtncsfM0YMvOK3WVf0+3
 xqvHWSwBGjv+J5V+qo/M+oaQJhbijTLaB2QsAIAw8s4+fq5Q8CpWt7yjTT2meXbbv7OS
 xuBfdcI8MYA1iNBjgOunKURuBHsc162ft6F2I2VqLmvxZYYusxKgYnvzrJmesJmRb1FL
 gnXV055oEqZ1BhP09oBbJTMKPnBpDE67doVsomKcDQYCxz+rj8/wt82TTIeOJSZdpUdH
 nS39H6Zjnqi4Hx+ywdQElEZ8sjnKbl/NnCobfxn+mS4vnjUJWh/S4js+TyzkgB6mjvl2
 NUwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+jhc6BtCXjDx3DRWVxyI1W58ZozXGeD6pWo33PLteFUC/HWP3JSJDGTNTbQQO8TA7NhrmqdKZAGE@nongnu.org
X-Gm-Message-State: AOJu0YyXPlnTxZOuUDcJOZYPmPPa8KNISlEdBS2RruI70hv1IzHv8DkR
 HgxE66aXx19dMOlQAyXXJgHkYXnWjToeTnt2gZLMhjBNAjzT58zkQZU9hNYV3RkKY6KgOpUh+0w
 hFAgzjCU=
X-Gm-Gg: ASbGncu0kRcEYSq03izZhJmsEk+U1lyYWRTxjbT73RbGT6d81HgGZRQ8rrL1G2rEEDM
 yj+yDkwfNlb7ILmxshSD9iwPmp3aPq5DeOhYqfvcvZ91bxj6oeFIYtBwIFk/qgRUIL4rt563FKu
 sXQXLDsbLCIZtu7zgoTLNU/3BCDd+P/qKLloN9F9R/hjyknf9NCdx1gOtpxa13NojzcmtdMRhYm
 r8DwfE3QoDAjIHNmRCWzFeaZeZXY6tz42yhtTQhuGK7lE+qsEvDeAw8Ffuxq3phwzAnnKY7IeZa
 1aWJEH7IJfrWF0wHCqPDlEDMT4AXDaDkPjT3+l+DrLpZ2xd8Ul1PfNJSxriDdyKkP5JCVFIC72S
 ZsBCThvZo73n6Fbgq+OEg
X-Google-Smtp-Source: AGHT+IGVHzTnFxUHI0E8Vp71cxSbVL/6QqWYw3/7yPsmC3uWhhUBlOk52OHNanLxLZw4yNuqvObe7Q==
X-Received: by 2002:a05:600c:8b34:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-4511ecc2a30mr105446825e9.13.1748936562524; 
 Tue, 03 Jun 2025 00:42:42 -0700 (PDT)
Received: from [192.168.1.127] (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012adesm152136035e9.36.2025.06.03.00.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 00:42:42 -0700 (PDT)
Message-ID: <be345a4b-cfb3-4e97-b09f-b21e5dcb6a43@linaro.org>
Date: Tue, 3 Jun 2025 08:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250603024847.350568-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250603024847.350568-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/3/25 03:48, Song Gao wrote:
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
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..cadc00e75e 100644
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
> @@ -3570,8 +3570,7 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>           }
>           break;
>       default:
> -        generate_exception(ctx, EXCCODE_INE);
> -        g_assert_not_reached();
> +        data = -1;
>       }
>       return data;
>   }
> @@ -3579,7 +3578,12 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>   {
>       int sel, vece;
> -    uint64_t value;
> +    uint64_t value = vldi_get_value(ctx, a->imm);
> +
> +    if (value == -1){
> +        generate_exception(ctx, EXCCODE_INE);
> +        return true;
> +    }

Incorrect.  -1 is a valid return value for several modes.


r~

