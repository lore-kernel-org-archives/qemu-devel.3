Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4093E7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 00:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS3Jy-000090-4o; Sun, 29 Dec 2024 19:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tS3Jw-00008k-30
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 19:07:44 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tS3Ju-0004Cf-Cl
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 19:07:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163b0c09afso108644945ad.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 16:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735517261; x=1736122061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T4FW542Y22l+omY8LguPDCyzAQ8g2PLTOnvaWrpQFmQ=;
 b=pFJ7ETu3qzDHeTRNxHTz4Ks5rf/F7W1R4oQGlhnijXBtlG/3yfDU6uO8HgEx6AADg8
 UHp8Q4aUvYlPa0hDVEiEV1Sd5ldK+ThKsSOk4GWI4Z3/J/aIht+C+/Sgf+/5+KYia7RI
 zzAkA/eppkcErr1wJtoNjjDafQlU0coUFE9Kjp0nZXXccTjP391/FUndrmI7xK1oxlyw
 4BKQMgekCOKhLB6l7I5HMwHfTF3BpfyxnChZoqVi9gh4rTUDAY1hCdjOdrkuNFSi1n1Z
 9wMyZ1tH/E25eMLEpUSWR5sA58wzD+qq+J2dGD8jPfUij270R0CbQ6AV9BD1dpn1pnF9
 /gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735517261; x=1736122061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4FW542Y22l+omY8LguPDCyzAQ8g2PLTOnvaWrpQFmQ=;
 b=m/xsQon6sajk3Fv7NiymjwV/YPXBDEw+UlFCimOGGYrEDtCvl4ElcRXLQbNSytLJaf
 S5Ztg5O0yAVNWVvwAos8Yh9iiTuA4mscdDCNscQiQamyeqdtnAJQQgaS3H6lc8jy3RkJ
 uIW7FcRCNoOUgc4yuTC+PcpLtUqkCgAsgQzfOV8rRK6HGBjY2dXOs9a8ijWs4vOfBz/f
 n1isRUZx0vyHHWYmHs/U4rnwL4H8gSGw9qhk2w4fTM5lBpUxcIeMCQfAniJyuqVVm7uJ
 U28EM5n6d0LrAKuBbgOKoURgkzPI3/IM0zF6hLSAzUc3Smtwpi2EUY/FMbP/5FHfnlea
 +3Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfPrvIuy4qECDmLM8XPWLyaX4thN6MWEANx91kpAUviPRT7mFX32ezKBXpTO2LYKwKAtcVKk4x35A+@nongnu.org
X-Gm-Message-State: AOJu0Yy1tTz7hVHDdP/oJorszE36TLJXrevaP+cwJIfis3dmCR5tHlFK
 g6127/G5g0q/d3m2QUM4PkudpvxoGg96ONIHFG3MoDtLJNRmoiwqPc1Kn+Cn5zA=
X-Gm-Gg: ASbGncutoNSHZFAsYLGPaBXyhm5DLndQBHgsH5KCEMSiqU6tp7rC9mLFuIPbB7U89Y7
 UulHHL31dkF9bRLz+aMLhkWBmzrER3Xkb4HGk5NCAYYjrpEFluD18ZntKLpQa0aDlbTMbhD5U+N
 9UBUae2uVOkEigyPibFOKGtsdbhs+2e1C1Cz9McvuPED6+IoHEAKgcpJJjzABVIwMK/MBBwOWrN
 rU0kwCldKTzHbEWTkGqSlJwARUN3Rz49iZAfNoUskV1WjZ+1ZPasooxn8YztQbVHH030Ojyv2jo
 hzajPsTZw89Ig7cTEM87WYHqFbMqucoaMTKlRZI=
X-Google-Smtp-Source: AGHT+IGHVI9ScJJlJnFTPunGnu0no+BSsKl+vt2U1SzjSoG9hh6CMM+Nd/NF+5fRMvp7yJctzQbzjw==
X-Received: by 2002:a17:902:d48b:b0:216:7d22:f69 with SMTP id
 d9443c01a7336-219e6f262c4mr384431095ad.50.1735517260811; 
 Sun, 29 Dec 2024 16:07:40 -0800 (PST)
Received: from [192.168.132.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4431sm168136565ad.147.2024.12.29.16.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 16:07:40 -0800 (PST)
Message-ID: <7bddee32-6f03-4429-b385-0f8d8369f46c@linaro.org>
Date: Sun, 29 Dec 2024 16:07:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hppa: Speed up hppa_is_pa20()
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20241229234154.32250-1-deller@kernel.org>
 <20241229234154.32250-3-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241229234154.32250-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/29/24 15:41, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Although the hppa_is_pa20() helper is costly due to string comparisons
> in object_dynamic_cast(), it is called quite often during memory lookups
> and at each start of a block of instruction translations.
> Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
> CPU creation and store the result in the is_pa20 of struct CPUArchState.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> v3:
> - use !!object_dynamic_cast()
> - typo fix in commit message
>    (feedback by Philippe Mathieu-Daudé)
> 
> v2:
> - moved init to hppa_cpu_initfn() and is_pa20 to end of CPUArchState struct
>    (feedback by Richard Henderson)
> ---
>   target/hppa/cpu.c | 1 +
>   target/hppa/cpu.h | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

