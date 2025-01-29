Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8D1C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxAI-0005ZL-TF; Tue, 28 Jan 2025 20:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxA6-0005YD-TE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:46:42 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx9w-0004wD-E4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:46:30 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso10834983a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738115186; x=1738719986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IUMK1/iUxrWwKKmFyLlAzclrpwSPUz2EOVSYR54k1HA=;
 b=CqkT/SI0khQgLNNO2xedhZQwi80VngxXxk98pThrEWnDCiw7KNLNzkdJts7y2Uxfgl
 6zwn5ehNoaYsTOq7Zq4wimVtFhQZoRtid/tDIm3gpGaUwh7q0py5QSDfEap/hd8HWDQz
 pk5C6FzhOhY9jZ61E7Lg21i3NVdrktynOqFWvckmisZTvCFHT9bUDxD2mTXXw28LZWjM
 yUIG82WDHv9BduI3QtbUD2Az/ZAKcZtgckb12ZMopFeRlhQGM0qjudVqho6v0V0V1fG8
 z+EA4zFZoTMkXUO0smKQSPq0pV3PA+eWUM7nObVH5sY1JSvQWn6+EpupPpSIixf3eQbm
 KijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115186; x=1738719986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IUMK1/iUxrWwKKmFyLlAzclrpwSPUz2EOVSYR54k1HA=;
 b=NcMcasJzzaoiMlDBdMpmpTQ9yDQTUt7RcuY+yrcjJvBTFbJNU8z9nsfrppf1jTmzRz
 9zUB8EP1+Lh3f4jwZ2Q/Nf0NJXEYQyUCLsJMt3d42ArD8dESsbAj3yxK2uc1XJF5gZ4d
 q3eqKWEFL0Hvh9yxe9HXHgTkIdr9QlJaMLhDDma6fW7bT6XETBJi4LSNWWAUjTq7jaTv
 74i7omV1JSXBU2ovSPd+fGs9kciqjt2jD7Wb1gkQCeRBgFtAhAvXG0KUp7AahubDIgWP
 +tDZHYDP9KJ27+1ChkJNMBbME30JhR2JQeSMSNl6mJ97Yg4YE0okGi5q5K0zYMg4RINd
 DVpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8RO9ccqU3JPLQmrd0V1SDBupkalpr5/3pusnH8LnYNWxmiP026flb4Xrsim3pQXOfUPPPIoWmCCSX@nongnu.org
X-Gm-Message-State: AOJu0Yw5cH7zYKtQzbKdfbFpxiy4xuoIgTSC/dz0q7vtCfXW76B31LYK
 7EP0ExLFm3gyjUbTdwUGvmG8Llp2w15X+cM/1crZOwdaam5c9DR91Mon7aCLbVQ=
X-Gm-Gg: ASbGncvnHq1E1mNyKYEHy5j9GCN86Av/j0ceGMAPTUES0/umdqlZ22VyuG9IAGbFDJd
 1eQ3CXOEL/zVBbGSMEvONlvUal3y6NaizTWb8P1E1MzZWP4rhsggMkfVNUHTYotreVS64ba/Szp
 8QOBVAXm8zk9Pv0ISwS51pfU1C0GKKZFB/w+1lZQQU4+J87eOgGDVKabGb6ah9Pa6kpk95l6Mfz
 fZMCoxQ/NmhKWolattPQqJRQz3rLCzBb49wgGXSEm1g7vkGJ/fslv83BIkHt/jVO5yyT76NXzDN
 o7/ifckXLVOWoDkToNWaX0bSblO0vUEEd7tCKY641k5JaN+JAfdLfZxTjg==
X-Google-Smtp-Source: AGHT+IExEz6Ttpnx8J0DHt60mq4Eft9njrDER0xKgPAQGfnlpv8AvueDQR1V0fcA2po7SvTNf1bE8A==
X-Received: by 2002:a05:6a00:3a1d:b0:725:f1ca:fd75 with SMTP id
 d2e1a72fcca58-72fd0bbe3d0mr2175512b3a.2.1738115186589; 
 Tue, 28 Jan 2025 17:46:26 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6d22e4sm10045986b3a.83.2025.01.28.17.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 17:46:26 -0800 (PST)
Message-ID: <a401a106-9fb4-4853-bd54-e26e79be7183@linaro.org>
Date: Tue, 28 Jan 2025 17:46:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/hppa: Add instruction decoding for mfdiag and
 mtdiag
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-3-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128224817.24715-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 1/28/25 14:45, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add 32- and 64-bit instruction decoding of the mfdiag and mtdiag
> instructions which modify the diagnose registers.
> 
> diag_getshadowregs_pa2() and diag_putshadowregs_pa2() were added in
> commit 3bdf20819e68 based on some analysis of ODE code, but now they
> conflict with the generic mfdiag/mtdiag instructions. I believe the
> former analysis was wrong, so remove them again. Note that all diag
> instructions are badly documented, so most things are based on reverse
> engineering and thus may be wrong.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 3bdf20819e68 ("target/hppa: Add diag instructions to set/restore shadow registers")
> ---
>   target/hppa/insns.decode |  6 ++++--
>   target/hppa/translate.c  | 22 ++++++++++++++++------
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 71074a64c1..4eaac750ea 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -644,10 +644,12 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
>       # For 32-bit PA-7300LC (PCX-L2)
>       diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
>       diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
> +    diag_mfdiag             000101 dr:5  rt:5   0000 0110 0000 0000
> +    diag_mtdiag             000101 dr:5  r1:5   0001 0110 0000 0000
>   
>       # For 64-bit PA8700 (PCX-W2)
> -    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
> -    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
> +    diag_mfdiag             000101 dr:5  0 0000 0000 1000 101  rt:5
> +    diag_mtdiag             000101 dr:5  r1:5   0001 1000 0100 0000

Remove diag_get/putshadowregs_pa2 as a separate patch.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

