Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E40C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhtB-0002Kl-Nh; Sat, 25 Jan 2025 10:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbht9-0002KS-Ih
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:15:59 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbht7-0002WC-Ch
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:15:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21680814d42so50544515ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818156; x=1738422956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFzmCZmoFVK0LaM46uQpwauQ8B9Cuucm4bw6K+131GM=;
 b=iwkeWmUli+Rgmlt/A1BG1+ZTrfNHpGc6PnMBoVqjtMdZmSZOkg5PR8fb+mmbRtdMer
 rh+bWEPT1EFCpFLrCNfxLcV4vvC3i31Cq9rxeZWelv/tUEmBAqeSjWixl4yuIcX2ZHNh
 qnLV5XiaMj9RLqVqRT7b+L04dOSago3xE5otLmsZtwYQ9z30Ymzf4mw6lxkXSILLJfQv
 bY3ESsulgloZAiocTsAqz0Ons13YB8QSTH8AF1ulKEW51AnR4O/DwAxsApCJT5tKd12k
 cFmSdMZsgXdNahRFdEipLwo9WXN56uJ5E/JP7qDH8elEqrM/tOOp/ewEbeEkMNFe1ij2
 s49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818156; x=1738422956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFzmCZmoFVK0LaM46uQpwauQ8B9Cuucm4bw6K+131GM=;
 b=wfLpJKnbWqRh/GwuOF9YYQoRJkdKXEiMU0t2EecJR79H2bZxQlgriMmCGSPbZPHip6
 NNx7JoOWgfgMpXM8eN8vPKvkOOo8akJsUJ87E9QNo2L3x+Shdba1rDBYzoseGKlhz1Sj
 vA6f6htBG3W1MVYMYooZT/PCRwpjT2aZB2wZ5C0GwQOa54Mu5F+aYB4IJvig1Xt+epBX
 UT59galQEwEQrY2GEDEBYKwRVicMLGtC0akYb3Xk/KzSpJ1+dVVmM8yDxlc4C8qbVcnh
 h5b7gd0zz//XSCFEqlxJ/X6Os/MPQ92K3nvwha4kyt3GJDBdir7YDetm3iqNm3HywrIg
 UNsQ==
X-Gm-Message-State: AOJu0YwmpIc/YLZ/rgbdMe+674WL2q1DNWYw6r7/s80NB9YPlhhHtV2l
 6XepVjL+lXt9+t1+oBn2Hg2iKQayVFIUOoyHppUEUQzI9N60rOYOow61qfkyGMmP80I9+xHXcZl
 3
X-Gm-Gg: ASbGncsvZxqgBsfnUWfNR09e+jz6hsImoZ3QPJhbg2F2ra8l0UWNP9hNau2v0UUKfaA
 /WdXcwJpDo9EwZxT4c5aBKzZtve5mqKTG+e9CjQ0vv4g8wmD0GCGO9QIqjiIuSApAhNCq5o4TUf
 82WInqEaB2MubI0B5hosJ7tLy0RAZbEQicCfniERCLeEKn7SUNGDkQlokTiTlg/Y59ISj+Qcsdq
 IQkzxRNLzA+1hiuf7nUxdrOs0MWsUjk32i6Wm4/T9rMGV3gQb3tv/8qVkCSXA4t8xQ90bsk6kge
 Yt8Yw4sWlGjqLHIuuStCGQ==
X-Google-Smtp-Source: AGHT+IFP/JI3S10GaY0pc69IdqCH//XwT2lXyB35dkuxWj4QkHUC8glfkE5ZoygZ61X+yWMRzwlVrg==
X-Received: by 2002:a17:902:f706:b0:216:282d:c67b with SMTP id
 d9443c01a7336-21c355c4287mr579775735ad.35.1737818155778; 
 Sat, 25 Jan 2025 07:15:55 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac495d565aasm3346458a12.49.2025.01.25.07.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:15:55 -0800 (PST)
Message-ID: <05ed4583-704a-492c-896a-71bbd4a63a12@linaro.org>
Date: Sat, 25 Jan 2025 07:15:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/76] target/arm: Use vfp.fp_status_a64 in A64-only
 helper functions
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> @@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
>        */
>       bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
>   
> -    *statusp = env->vfp.fp_status;
> +    *statusp = env->vfp.fp_status_a64;
>       set_default_nan_mode(true, statusp);
>   
>       if (ebf) {

Is this really correct?  !ebf includes aa32.


r~

