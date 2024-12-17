Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FCE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeSe-0006SP-TG; Tue, 17 Dec 2024 15:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeSW-0006Fi-K9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:46:26 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeSN-0004W4-CC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:46:24 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72909c459c4so3976396b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468372; x=1735073172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q32Sc+siPrmVcNmMrBJrHl4BphwmUvDC101YBxvWtd0=;
 b=E6FE+YU8FheAGuMvZ7faIN5rFwIreRraA3/YF1WlRTkpihySaSCW7nNpRw5zcKcigG
 1SWtW8JJDmwmGt/7X0HWoHaSjqXSxLA3vr0TA3p39a/0LYt7jlYh20ZhNcOz0aKZgGw+
 9sKfOFa1lTVyyajL6YwgI2nSXpAerRKNAODzzMfSH9MNrpGbqP7cE3HVWV8S3n9jsVTc
 iPs04qN/Nx7B6VPAM+BUnR/Jii8HA2Y4l90rq+KEVzqymGaRKdmv4YG69FerQIIDh3ms
 5g2ZPIjqnD5p9H+zCRi8/A/R571mi1LRtK+1YQ5W/lYVUVFx8ziVWfP2n5p+5sOvH1qi
 pEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468372; x=1735073172;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q32Sc+siPrmVcNmMrBJrHl4BphwmUvDC101YBxvWtd0=;
 b=swY5Uwjze8u640cEHRjKwzF+JzX04mxrMs/btCPJG2mCtq0JGqO52BVPKo3IKSVj1P
 vFxHvKOv3Yd7stn5+9CzKuPNPQNpoLqYktKmNi4lsWK89heT/qrtSO0DPr03WREYzq/s
 NyNAQsb57w51oipAwJSJnySCcwsf+yp+wO8KhFxQJdqujPPsmFEJH+v4UXARuTSmrp+p
 8pgjQvlPpLL225zdxd4ya65fs74dVh84Oa4p2geBpUg/gtKAnvIADum62QVhr+YnT9QC
 seaQKQt+5Z8DfvzsjFs1ZXJpuUsJW9qg+O1HLkWkWBg6s/BGWOpL3fkOaQ9bYU3+YlMU
 vlXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3BUlQe/uotlBmwwkm0lmG8WNZdl7w0v5dCjxUDMS5vwUbZ+kW/Olyo/+WfeJtvW3KIYzkLN6Ko1OK@nongnu.org
X-Gm-Message-State: AOJu0YyFCdlYJZkkaYBm14i3PO/gfYpS1zN1fcNXNm40LtgoN657AMcj
 jgaPcQ0OzUFYIZIK68iW9IL8riw4KddwvL370K9ZzW9jur2QChNgQu3OT7A2mAI=
X-Gm-Gg: ASbGncuSiRkeFygXLoV4CimVSGoLPH4QLSejls0J7Dj7fpQh5TEFnBvPuc7rLFCkSbn
 O7yLMl6MC97CjaaFjRhrYO6PxwJ9HQM9Zg8tCQZbxLQxQFE9iv2kMKZW9bD2m9JP9CGlAKnmSCK
 ZwRlTO+WUa1nCjetfAVbzKA9x2IiXypS5ck2kjcpxDh+Wplt6iBnlFi9eLA5+ANqu6ELixFdaVs
 tQbNcs5nWkrxTubwPULeCyzUY3i1hinyPV3/NS9zctF9WWo+2YaoQlwt2FKfn9vbWAtcg==
X-Google-Smtp-Source: AGHT+IEgZOIV9IAL/R49ipXXZjIx84iCI6ggvDqGWIzE3+IWu/wfUJs6Da29lYVvidWYAbknghbM8A==
X-Received: by 2002:a05:6a20:1589:b0:1e1:ab51:f531 with SMTP id
 adf61e73a8af0-1e5b48227c5mr772016637.22.1734468372684; 
 Tue, 17 Dec 2024 12:46:12 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c14ad4sm6134613a12.57.2024.12.17.12.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:46:12 -0800 (PST)
Message-ID: <ae30f8fd-d4d1-49b9-bf29-ad7fcdd02b6c@linaro.org>
Date: Tue, 17 Dec 2024 12:46:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/46] tcg/optimize: Use finish_folding as default in
 tcg_optimize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-44-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 12/10/24 07:23, Richard Henderson wrote:
> All non-default cases now finish folding within each function.
> Do the same with the default case and assert it is done after.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 24ec14f476..94e942e1cf 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -3085,11 +3085,9 @@ void tcg_optimize(TCGContext *s)
>               done = true;
>               break;
>           default:
> +            done = finish_folding(&ctx, op);
>               break;
>           }
> -
> -        if (!done) {
> -            finish_folding(&ctx, op);
> -        }
> +        tcg_debug_assert(done);
>       }
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


