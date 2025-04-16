Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F09FC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57xT-0000mU-1q; Wed, 16 Apr 2025 14:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57x8-0000Fg-KR
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57x6-00038w-Nc
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2295d78b45cso463035ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829859; x=1745434659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mOFuZMBF8eRuW5UCgGK/C1+OwKpL/E6cKEN0LBNOTD8=;
 b=vPtf+KdTYA9LLqq8Ug/FF5bPjpGlCHgFVDfoUyY/JqAYUhxYnzqUor0x3jpB1ZUeo3
 XPNHOrYlIVRiXqk58GmyRurMY011CRIE3a7HmnJw9URYXkC8BllL6Wt+JdW+MxF4oyis
 udVoncB035+sKE3ZtdmzJlNezvB4J5Ibz4VfiW1Yw/au+83dMihdxTE1ZYEh3LowClFQ
 fvYOAHD82oae3jpBeH3qdYGbsmA4e4dnRe5UnQ3iVPBeauBc7RYoRg6zjqwjeUJghgup
 q8FXmglZhmlpF9iPsTimkLjHO+4EYn0RalqnP0vKWBR6nm48yXt3kylBOmS4GkzhmGDW
 +u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829859; x=1745434659;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOFuZMBF8eRuW5UCgGK/C1+OwKpL/E6cKEN0LBNOTD8=;
 b=pronRyYgUxquBDuczShOH4E+bofOJys0/Szo7qc7WZEi0UGqY/4r6fcK9y4Ul6kppz
 4exjoCmtLOaKm3wq0RaOe75Nd87fZM1ZpCr1p5saDAxluuzBrmQqtXAMI4PRrLAzsgDq
 TCeB0EfcVEvnAFzSDKzuvOy0YwjRu6blgcATrcNnsWSiXgk4xbuVBoA3e1cRJz7mDviz
 kRMKgsGK4U3Lp6nd+v2/m4+BaIRN16c6n5m9UU6wxdrUWtTMceHxGBFVRgf6MREbeGZ9
 pkJXWCVeUBMKa57yh6m9OokF4I6t+bHBQRUKI6W1iY+ZPh+jRmPJFHRB3fb7PDanoE4S
 0UQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+rYNy+Uk9SGgYstJ57En9DWOMQN0nImyezU4enI0XHU131yTqUiPo735wDoomZhGcwy9vFOKH2m7+@nongnu.org
X-Gm-Message-State: AOJu0YylJ0fYwkZ84x9YkAGBbC4s19o4zD+E8n8uu4eNHYAfJpHfpjfp
 AbgltNhX7iXd4d/zcnyk++eY3pWKPt7m8WRrBAfzGt7tMYtCGH0PbPZuh1ffaPw=
X-Gm-Gg: ASbGncsvqGVFOcajYuHoczglPYk1RiGIcn5l4PFA59Rzcbw23Ui7uX6oQPd0+XmEjKb
 RHqPNuIgxdJtmqVH0hbCBRkQxIkIjQxzHt/3OEmtxmgwppZNNpFj20yIgPV84gonuVuxfh8OBN+
 Ga6A/aOfQDlOSVV+dKraAloQcWkJHSWkFrmTVnVXBnA/UfGGkaNDJrkjARdZDEnZResuiKTWSTA
 K6BPGuS/3Wk+H2dGtCHlJvnTK4qHUUJBUVXfNd7uQH1V7eraatD08Udsji/n25Eg1nEuygEUuip
 aZI1l15gmtMOb50Pdc26IjdgzZhOSTbp7h0hywFJKX1/N1/2I4/q/Q==
X-Google-Smtp-Source: AGHT+IEUGCjWbOuJ3JEMrOfbkVzfyXmcr01PcalhHxvvA2/DwjRLOXdjlZaDo/0yua7Jet1Ao5brzw==
X-Received: by 2002:a17:902:e849:b0:220:e1e6:4472 with SMTP id
 d9443c01a7336-22c358dc2fdmr39634445ad.13.1744829859230; 
 Wed, 16 Apr 2025 11:57:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33faac7asm17847225ad.137.2025.04.16.11.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:57:38 -0700 (PDT)
Message-ID: <3d11f22d-1f6a-4f42-9a1b-c713e5a2d739@linaro.org>
Date: Wed, 16 Apr 2025 11:57:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 119/163] tcg/i386: Honor carry_live in tcg_out_movi
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-120-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-120-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
> Do not clobber flags if they're live.  Required in order
> to perform register allocation on add/sub carry opcodes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 04e31cae12..8e0ccbc722 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1092,7 +1092,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type,
>   {
>       tcg_target_long diff;
>   
> -    if (arg == 0) {
> +    if (arg == 0 && !s->carry_live) {
>           tgen_arithr(s, ARITH_XOR, ret, ret);
>           return;
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


