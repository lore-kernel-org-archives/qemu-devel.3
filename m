Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB95E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdpH-0001Kt-O9; Tue, 17 Dec 2024 15:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdp7-0001CA-EG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:05:43 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdoz-0006DS-B5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:05:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216401de828so46163885ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734465931; x=1735070731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uoUVJ+PcDP3iK8lONWU7UAsm/rU20/X8xBIOfh7Yz74=;
 b=XbAchHkA5AyQBVsfsdl9eVO11Fd0rGmk99VR36OR58EFmC09b8S+T3GGCUCkVuu6Z/
 JrGvSrh5XqRxXmadhTw+JmeN8+FfXhNSC3FQT/8XRijXT5e7rCUtYJFGcPlULdL4ajX8
 7gtJlZE3ZRLnRVEO8Jp8kGJiv2IgcKrxXoxw18sge0Ws01oGuItjKGYqJJd37r+6tKFp
 8HFA1RB2CT/slwptE5XPa4otUa+NQN82NT5n10JncAN3Nh65s11/sq43WGu0DRJ6oF9g
 Ek6fYxUhYep6O+pTSNOKlvIx11voDEKf6K+exiTDprjEuU91bPCnClpVE0xJAvLaduAv
 ETlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465931; x=1735070731;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uoUVJ+PcDP3iK8lONWU7UAsm/rU20/X8xBIOfh7Yz74=;
 b=fnuWw7lhdRJMG09v2thHPHOtM6MLynXjcl08W/ul+yXeBLG2usSJcVkFEEceSlZVac
 DtCaIpdGitJgtrsms3TQKVAnla4ErkBANylDqpixIdlYjxlU/6eB5L4pY+W4FXFKExPV
 PWswPY9j8HD9h+6wCql8gKAWE2hi9KpomXOQ0XMZkd37RTqJV+z81xyRLewsUr1oaqlO
 gVP5qmteq/VHS7OSudwForUtvLxNfPQjFFQ9ZMID06tcVvVtexRA1vBIoAy3d2IL08PT
 /udnCitzfH+pzhxhSpgp5kTurZ0HohQZOwwvfy7BqG69+lAE2grG0C8oEJtUNd0MfNKf
 pKZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWihDCDYXUwUUEujFGcm1s/l6Jnxj+Mcn7d18IrvIhRoh8sjjrpVa/gVC7TddlkLV2XoboHaDtWaz/7@nongnu.org
X-Gm-Message-State: AOJu0Yy7lJ8bi8Rktnwymfbq8l1S4WFX8trM+niXUKGe33SedfkVGFwL
 Xee+gEYGWDGlEpgK8DrDUmIpQg8rQJ/zQntPxxAEyq9xz7mt9E1IcvduFVVjn1w=
X-Gm-Gg: ASbGnctyMDYhN6vz8xzLXIfqAPZ4FIc3LVnesuE7JmQwRO1vGNkfhnY0zKl6GJq12Vf
 I5yvgtfAkEqXFnU0lcadEqW2XuQPoPWvYhbWhhhFkdIeW7DsTKsY/fYPw4GUqoWTYB+170/h0K+
 rI/ri5dAZlWIg1Q1CpKafcDoxcGnxSEnvBNmYKiEdCCbrur8QihwEwacEX/2U2uI+RHIw05E2WN
 hUc4cxbBWei3Y2C2y0oxFUua6dDM354ZAIZAf7fuySjhx45Q+vSvqkh0LheumxEqRFcMg==
X-Google-Smtp-Source: AGHT+IH4KoF/ufdamWQY04quAJLxOAXe+/DLpFwc9hpRSP+certdclgYfBiLdUHf84XkizXHVe6AbQ==
X-Received: by 2002:a17:903:124e:b0:205:4721:19c with SMTP id
 d9443c01a7336-218d7243bf6mr1581185ad.37.1734465931572; 
 Tue, 17 Dec 2024 12:05:31 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcc165sm63393805ad.88.2024.12.17.12.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:05:31 -0800 (PST)
Message-ID: <12dd8220-f3cb-455d-b181-feac62b8d0ae@linaro.org>
Date: Tue, 17 Dec 2024 12:05:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/46] tcg/optimize: Use finish_folding in fold_addsub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3f2f351bae..135b14974f 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1292,7 +1292,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
>           op->args[4] = arg_new_constant(ctx, bl);
>           op->args[5] = arg_new_constant(ctx, bh);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_add2(OptContext *ctx, TCGOp *op)

Any reason to separate this patch from previous one?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


