Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4A2D0EE14
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNyiz-0002Aw-V1; Tue, 25 Nov 2025 14:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNyiw-00027R-JK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:29:14 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNyit-0003lY-1F
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:29:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2953ad5517dso71092005ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764098949; x=1764703749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A6sN/uQ+4XPNEXBbjU7wm5XqFLM56AhdQHyyrI9cKJk=;
 b=NNvVOzIc4d4O8KMqUmYZMLscnmega981H/QjK+cE39WcxglZW6PbjxrS3x7R49/Iqk
 mTo0AQUvwed9D9nHv4+gAM0zcLzrDewvqYS3dA9X3R44UY2RZSa1d09wXXOJEGTE4T5U
 M2kwZ+Su9UymmTXR5SmSCknzTXWzGhXYfl84fMJW5E4WCQfQrXeCXLM8BQ9eYnICr4lP
 I83k7a/CLdRTxWRnTO260xNZfr5CjYXBLijd9OVh6HAztsbBUs2Q+7vQYBaRzH0r0ly2
 iNjecHmPSOPGizcrZmtO1pbSm8Bg78Nwjc6XAgloQpjYpzgx0J0B2iVf6M6W/3Lyhyvb
 Nu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764098949; x=1764703749;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6sN/uQ+4XPNEXBbjU7wm5XqFLM56AhdQHyyrI9cKJk=;
 b=uAfQnLwDf07N5lzfW/KCfcF7Wc2Rp4rz83C3bQBuUVzJtpPzZwV+s4LxYYaAdfW0xk
 GPM+iyaS0iCl3Ix776RCYOaRFNP9vH3eHfBNx/FrjE1r66xS6WJY9Ube+uCRQV4+6CPp
 GG/a27i2quX3F2Pjs1YslTUPGeBif/8cPZlif5qN+nj3GUJGgSHSR3BV7oaAAWJgLItU
 Kph2Vlo4xHOdZLlLMOCk1O54R/zq5PmMncNHpYpMTOPCLR5WZM0LvU9FJm1ONcSwgCIW
 62O6eyZtODC6Sxb8NSJQyWbQBJRLDVKvnoYp3O4+RtrnbOQLsq/QRT730nSN7+UqFWBT
 bukA==
X-Gm-Message-State: AOJu0YxD7sVsIqmmZOPSXmHE4MRXn0/5Bhxkw/DM2+no39FjACam5zZ/
 C3hkvHimXXtgyaNbn6Gm21bcf36U421diFVGporPlMSlx4g77Awp7YKAmzfjG8JLrmA=
X-Gm-Gg: ASbGnctmGxuzb83TJ9EsPeZ+ME+RUTaCX6ZE5tb261FQfHiJk6C51pWhmtQ2M1RC/Fv
 3lY2OzQbGLQGCxwIYCRRyNZ5AtVFTFhQBaImO5Feo/2UjuiMur+C2m1q0az8TQ1ibQY4RPSv3m/
 3gLU5xqnVRtWH4KlQXkVJFDXfl7DBrMweFYUUGK0/5yyCP1ekHgyQvkVkQfvO1iou1/ypX+Y5FH
 TNpZoDEIHtRLvXvtRB6uuAPoEbLnHENYPsVqkiUSmVa0FUZrA0LYeHCdETSr3tEObnPBIb97Aqf
 icVGjKGmnDZGLeFAcXnrfv50Q7Zdb9d6GKp5VFVx9KRciZnwwXw85J9Z8dmpF91FCGvZKrv3ypc
 Dh8u3CqCfMP/lTybbW3dGYxEBWVnDEyOTCFuZ03yNHF+GiL6kxoNslu4etJmcHvlYGuZcaRtAPe
 acwavv+uBKoWJl+efUc0fmQXGrqJbc0afUPaQxA5XCsYB1WlIAsQ==
X-Google-Smtp-Source: AGHT+IEdbHY2l19aw+bG8uzstYTlcXxDzgEZc0sDUDZEuS1p0N/CEAVk/CkeQvqogTT4uhGUMdK7rw==
X-Received: by 2002:a17:903:2342:b0:298:970:b24a with SMTP id
 d9443c01a7336-29bab2fe6c8mr40846925ad.58.1764098949413; 
 Tue, 25 Nov 2025 11:29:09 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b2809b6sm175097495ad.76.2025.11.25.11.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 11:29:08 -0800 (PST)
Message-ID: <5c9ed281-978d-461a-9e16-0ac8994246cb@linaro.org>
Date: Tue, 25 Nov 2025 11:29:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251125161648.259321-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251125161648.259321-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/25/25 08:16, Kevin Wolf wrote:
> The following changes since commit de074358e99b8eb5076d3efa267e44c292c90e3e:
> 
>    Merge tag 'pull-target-arm-20251124' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-24 09:03:12 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 59a1cf0cd31597d2f6e2c18dc400a1de8427d47d:
> 
>    iotests: add Linux loop device image creation test (2025-11-25 15:26:22 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Image creation: Honour pwrite_zeroes_alignment for zeroing first sector
> - block-backend: Fix race (causing a crash) when resuming queued requests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

