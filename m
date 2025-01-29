Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14B8C0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC4i-0007Mr-9l; Wed, 29 Jan 2025 12:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC4g-0007Ls-Sl
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:02 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC4e-0003zD-Fi
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:02 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso5999683f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172519; x=1738777319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LrpGivpVVhBsLSaDKvJeTWsm4K1qXpGHcCFrHrLYbg=;
 b=QwX35n+2bbaTHomHIvsIKUMYv3h26Tnyeua/qAJddXPAZ5VG+UzV1rsYtAGR73Qi8J
 OQpHtg6jMtl/6Do7475qNasI9bV8egHW46VTG2iYashbtUVg01yhsuymO5g2LT9iM3wL
 L5sUfPTVpmzSMT8VpVUoVow4nerp/xRO3MLxMm1hJLNgnjC7gov312CKJq7FIeOsD8QM
 pAedxUU/bVC+aci8byQ71mxzJJrE1tSoCj1Jz39wzVRuDrSpdOIaW/cbruJtfoimE0tL
 snZr75UH1HVtSKXCWosbXhm1qNDb077/TMGPqNCFP5mfvcJ1wtmy+/k9Nh1slcKyye5+
 bqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172519; x=1738777319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1LrpGivpVVhBsLSaDKvJeTWsm4K1qXpGHcCFrHrLYbg=;
 b=CddU2g3Dbhnu7aK4QSmFJSdOKET3jnC3RdDTqZAiXmcT4NgSzRHlK5nJqFAdlPLB4i
 8VDQaX+WI+F0KxJw8d31+Dtct3GbqUwTqVLpoecY3N75suarZWlu9F8ASTtjvlTxFPvc
 g4+FXPoWkRMaKIcWhmP9bhe8AYggQsg50l4izuQI2EfZPIWsJcU+qnWamzMQk0cptW8Y
 YtkfxAVsoutmLXYIrz3YmV0OaQ4pa6uX1jCCfeBNWCbRcn7/teQu9zYincXF6EpY/SWT
 bpIgZqAOwnDsdhexBL5U92nmrNqIwCLT4E6ZjiTX0RNUQPg08vnEH7W7QGEB7dFPhC8/
 UXPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmuaQkGlEnzhQrLz0U0+k5RUgxqNiuQD1NaHiWwUD0SRbZRAsK7sewCA7Voa8LHSz/fQDmH4RK6pPU@nongnu.org
X-Gm-Message-State: AOJu0YwzcdRb3KfoQPg27vTszOacxO5cJJB/ApIf1NiIVd+IW2PegMit
 O5pbH4e/kvgJs3HLpeCwHwkuvSR3HYCL8O/mTJCTykXy6CLbr+gKKbCa1XYRqT0=
X-Gm-Gg: ASbGncuQ2D51NtZzQfnnG1UI79E53QYWLjri7BCfl+2bbyQ6NM0dSgrzNw3KdpnIVW/
 Fya6c7UxqNr983c5nqOw+oxYmWpZK6taTOYvu4lWyAnTauVM2S5sXRxYqE+ogKfMsNzcA2Vj011
 /cIhmIU5orx6T85s8QuEKdf4DbslYUNLhB64B7Qe5S2uXZy/ucK0ZYXRgVkFChgu0FW8BbME6Rl
 XV9DohUjPYYftGKh4FxaAEWuAMJeaOqMaOYZ/NWHrbsMyG7DchG3Ey6GxPR4+GSfxvz+SVUBivD
 0eesNVFPq/hMbLbxprvZUZTiBUnlUXX6ssGh2Soo7LRGmih2NYX4CHhnw+c=
X-Google-Smtp-Source: AGHT+IFkeDLbIKNduO1vuy6KoxTLZ5Utn+CWY+cJbryGN+yq4IjmQZxgIC99YYb+iHFG+mMTG8zSSA==
X-Received: by 2002:a5d:5986:0:b0:385:ec6e:e87a with SMTP id
 ffacd0b85a97d-38c520904ebmr3598556f8f.43.1738172519115; 
 Wed, 29 Jan 2025 09:41:59 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2b1d9sm29422665e9.21.2025.01.29.09.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:41:58 -0800 (PST)
Message-ID: <43e9150c-da96-4c59-9791-44c3d042a8f1@linaro.org>
Date: Wed, 29 Jan 2025 18:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/34] target/arm: Rename FPST_FPCR_A32 to FPST_A32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     |  6 ++--
>   target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
>   2 files changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


