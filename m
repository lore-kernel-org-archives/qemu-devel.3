Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55779D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzV5-0003hZ-A4; Sun, 28 Dec 2025 17:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzV2-0003h8-Pp
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:44:32 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzV1-0001kO-C5
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:44:32 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6432842cafdso7512082d50.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961870; x=1767566670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lBpjjAD4OOIiY87ZbMT7Co0OYKZoAfQiReuhuGmvHPk=;
 b=dl+Z8r5wjEPUTi7mH+VTydOm9edvfrN47gEkLddQeUq33pOqUZs/GBfddOaEcDWce4
 FelTRj9dGTODrwiEjf7YlUErMA3oS98hk+ljN67QVwfj9PFItwKxR5lbrVYGy6EAq5/q
 +ZHa7MKcLl6bSzASJJosEsNA1Oy+j/T7CMsPXJUz03rNAfORkpB58x1LekGj+FmIeX2J
 V95AGZyrRGPaAlbDpiqP5ldWjmPTKj/7USNHLbWXDpkCwvbyqJysVvJGPIRBRkAAZ43z
 s8rNrk0lKWop0TZNZSv4STc2Xbyl9uSze1Dk4+fWvCYlzsQFVUU3s5/6IzakgxigDwJO
 /1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961870; x=1767566670;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBpjjAD4OOIiY87ZbMT7Co0OYKZoAfQiReuhuGmvHPk=;
 b=P1S9FepH5rNyjobDck6E376VXQIq6wsi62s+qmS7NgomDloU0WkDpnafeK5fAivUjY
 XRPYChItV9HCY/9AFRss1rg/BaB3rrS3oyt/zwM2lgvTBKdl1LKNPfNt1MlSwqa5hexs
 mya6ECjzSfbCbr1wwLPB6/PnDU/MHh0XfvnFBxivvDe51ExPX3iIGvtXNULIFTNoHBdX
 hjLmjD2wSkvi41ft+FrUzjgHDCRMUX/utWs6bjS3uRM9n3xDIvQ1sUayEa1TWanTKYB5
 7woA+pJqYA9TjgfZzYYR4p3uwixCS0cX2xFU4xzjPYtl0wYz101bK4HxBE4W1FUReynb
 v+XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQxJQNjYPIBCsQWKUPZlsNCecNaY5n6qS+0u+RM13wSthV8OF654vLmZOfQGW+EXukdyOlGWUoL1Xv@nongnu.org
X-Gm-Message-State: AOJu0Yzk15C9Vzd6y51EcUi6tiaWot68PCHIjyTrtnXd+16vEpz5YZ2a
 wt+MNRghcLlfRJAPPEo4P68vecLJe3BlnneduSx561CWGNUFdc/EajxoSJ1spqQBVD8=
X-Gm-Gg: AY/fxX7mHdSToSRex00+xIC4GhEPt+e3xqZCJcX1czYAUWIfCjrFqdgScOBw6QR5epk
 q2sgb/VLXi3JOQ1Z0lvQjUCYuo+e7dGuluNJ1WXQhOq3bT6FBDMoeUPbMv22cAX9/Z9FTjSrpJZ
 e7sOsDQvzSVTPau94RVIovKRLgyZ0ngOIzZjMf/kc/SQYNDGc32abkWt4BCfhpdmyz4pGnDFlxo
 Fse4HxDWUgjBnHuzr5S71W42m5rJ5EbJxS6DXTcrGEbbfVA5iRm/JWkvmGaMNegi/uj8Nly1sdF
 u/SKW1y+mN5lIrAFjaoxGU/NitQlzWEWZpDfsnDxax3zcHtCy/ZqawubmGL0TB55YNuUR5n1KLG
 EgzttrNN9yn52Ju3Wl+aTjMpUkP6qnQ6tXdzJKbqM0g4NJVjhHgAWxcxxHYv1UL1onF2SsFwbJM
 303x1ggKBs8ENizW7+D5rWiibiOaSE/wUN6Z9IhcOKdc+59HWnjucd
X-Google-Smtp-Source: AGHT+IG/7IhlgbwWrqvhfAu+d/ZrbwhKsLq24bc3JzhCOBKUYKxKUWAAm3CovK+Jj01qNro/c8dutg==
X-Received: by 2002:a05:690e:128a:b0:646:7064:368 with SMTP id
 956f58d0204a3-64670640415mr21202904d50.53.1766961870234; 
 Sun, 28 Dec 2025 14:44:30 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb4377c99sm109479877b3.3.2025.12.28.14.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:44:29 -0800 (PST)
Message-ID: <8bb6d557-70ac-4f07-ac99-207d6ec3fc16@linaro.org>
Date: Mon, 29 Dec 2025 09:44:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs/targets: Forbid TriCore to use legacy native
 endianness API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20251218213229.61854-1-philmd@linaro.org>
 <20251218213229.61854-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218213229.61854-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb136.google.com
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

On 12/19/25 08:32, Philippe Mathieu-Daudé wrote:
> The qemu-system-tricore binary is buildable without a single
> use of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/tricore-softmmu.mak | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
> index 63e040ccc2b..781ce49a62f 100644
> --- a/configs/targets/tricore-softmmu.mak
> +++ b/configs/targets/tricore-softmmu.mak
> @@ -1,3 +1,2 @@
>   TARGET_ARCH=tricore
> -TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
>   TARGET_LONG_BITS=32

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

