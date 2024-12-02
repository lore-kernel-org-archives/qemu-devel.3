Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A9BD78304
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3he-0005yM-5E; Mon, 02 Dec 2024 05:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI3hZ-0005xr-Uo
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:30:49 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI3hY-000383-GI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:30:49 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53dd9e853ccso3953494e87.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733135446; x=1733740246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/IRVUx1Y+cadwWp3ns/yVfkL2W2wSjxjO2lE/CD0rTI=;
 b=J+I5s9fYqUKUMXu1UbxkD2kCxhvGhHMcWKr5ymLIEwAgBj9GU5mBRYA3E6kJKtV+I/
 In9VTBvwyunNujLy5uYBs5OsEGckD93ZhpG/zDkQhUK8tFPDdFj1YTjHjBL5mqYpKyd8
 hVZ9bYa1q4j/tUJ3Cftulg3GL6gma5gqE0uQMmD1qfVauyQjORiKJ/+bBIooA1sTYMPO
 Rkq3i/akfFyvgcPmHt73F5o7muW4IKwiOpOcnco5vdoPoUrhUefVPTidNDBb1DJtUfYX
 bSp4b+qUEfjUw+ZXiiS+r+3k0Xsa1In2OgS/50ozXhN6kLhWVfVwRyvG84OwIJftKKOG
 7KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733135446; x=1733740246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/IRVUx1Y+cadwWp3ns/yVfkL2W2wSjxjO2lE/CD0rTI=;
 b=VgnxszePkdj6LKyegw95/EMteFjsEqUwmR8sFXhkEyKCHBiMledxOv3ECB1Thn1Leh
 P77iNNcjlzwvrrgtJhzHB4+sbXp3dsGB2dh/IOX1I+vbp4D+HmU0zmbjdNEIuipZ9CZ5
 jjqbyauCXBwwy30EhrDpfxKKLqNIiTkjWFNIspo9+Ua81jwIC2uDUvp4UYxBM0wg1hSS
 fkPr2l/qEnPJSpLMu591xzkc0616m4BZidEtGDePDXR6oyk9Wp2TuqODFghQrl5SzJpX
 2BDKg/mqMOI+jaFA9+RGNvPOflkZHVwa0VVIfgt4rvxYJVJey6kyT/S4A/sWFXqZnlAq
 femA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlaJYFWaQwpsIbwnO55UazPzOP0Z9TbgfCPaXvxIZLH67BA/R5sB9b/MoifgUJgKf2uf8zMpX+5ri3@nongnu.org
X-Gm-Message-State: AOJu0YwjeyVZs4tx3zD4fLYJ51/BCJcOKJMG5iV8flSrG9QtXfzTuijZ
 oP5pE3pE73tdX/VSp0syF3S02P/0lk/XJ3SpqsolzQrJTTJ4RAxWmFaI8Eib2aM=
X-Gm-Gg: ASbGnctL3hiZo0ZzyXl/8XUjyjDiQ0Mp7IEcOvwadF0CILC27tZi2nlPTEH8SuqGEdb
 7w3BdRGvWvP+bOvm9XY1Wci2GrGmuQhh73+l4mSZGy3MJK9QHON31xmUkMqdbXr+OSjSlFrlPZ2
 3DCwgalbu2dpuhWFwb+SBQTRcuC2/c6WFN1U6T5Z12Z7fnJAFeYBUcrK1xT6ii1b9ki4Z/rEK8o
 8P9YenX9sqw+RXLPV3DFQIX/47pjPIMjw69l9NiPyitVWaXllqXR4vv0+RxYMBDJRUgZHmwNSMw
 cqME3V5llw==
X-Google-Smtp-Source: AGHT+IGMuW0csg0MDrqc0pdxVS9uwqsm2KzDSSwOcEf8++DWYFCSx0Jx/aveKhkVJI5y0CYo8SxaiQ==
X-Received: by 2002:a05:6512:b98:b0:53d:a2e2:5877 with SMTP id
 2adb3069b0e04-53df00aa157mr12148806e87.5.1733135446256; 
 Mon, 02 Dec 2024 02:30:46 -0800 (PST)
Received: from [192.168.77.213] (51.22.205.77.rev.sfr.net. [77.205.22.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc9707sm149265505e9.25.2024.12.02.02.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:30:45 -0800 (PST)
Message-ID: <7f53bd67-2302-46a6-9d98-2b52939165c4@linaro.org>
Date: Mon, 2 Dec 2024 11:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/67] target/arm: Convert PACGA to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Remove disas_data_proc_2src, as this was the last insn
> decoded by that function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 65 ++++++----------------------------
>   target/arm/tcg/a64.decode      |  2 ++
>   2 files changed, 13 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


