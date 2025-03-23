Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E7FC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSuo-0007A6-Bn; Sun, 23 Mar 2025 17:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSun-00079j-03
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:31:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSuk-0007K6-Ew
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:31:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso1964879f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765483; x=1743370283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sRwd7RmwggkweD2ePZ0RirS1G5jCrzA7oIe9IjbDHSQ=;
 b=x5uOxEI+FWQ10eHLJqizjIGKPXLzrRc+smTUlRivuvUGSAep0GXY9HPbTaEBytxIJF
 0Rrhfcenj48ydTACQsKkMk7A1hRASkBHe7Y8smDEuXGvMeSwNrNjxfmMJ78cFvr9q4dp
 WIxROpgMlTCU4z7G5c+7BAEJFsxqrMuRXu9PhdAJkEee2i8zRAURQ8cjgyG9rkrs+9eU
 Bd9Cw9ZM5y0ZhfuMlT+k08d367ESMy5XbNPB/c2my/tyxWdisFKH2cgP57jXxi6G5I1I
 LN4/okaji8t4B4nE1TZrRFgOVLpxc8cJvbAJQRAPfGLPhBP43CeLMTJiZEBiUSuWTHhj
 f6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765483; x=1743370283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRwd7RmwggkweD2ePZ0RirS1G5jCrzA7oIe9IjbDHSQ=;
 b=L/bBCy/aON+OaCY23t+C/O8FQHQJOD2BI7hqKNqBwqy8MDWiTNKh42OjFcfvgt2td3
 PDe61OvRwmbjrV+k1QNLLsCJAn5pmJyoLaUekanmaCN4fqBCZlCRerrUbBvhsejrLAJe
 e/MTfo27K7KN1OgkatOoKi+SCw+g6mt02fwtQ10IjAvMV31OjEJ2GNyAG/3RR9SxXe1A
 Wds2g83FkI21xiviLNH61lHNP8Qu6qL9CiMtUNN1vKG2kt+HVIgxwzwkDcrPNUzwf7dG
 C/rtN1heJb+t738T/Iq+MzkSWPCQ01cvuF0G/SrXEeFVBuHITwp27wof1hLEHqiQ/FfM
 wF4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtk9HjzGc+O9RyZ84ZcDbiLgSKTq5CV1v9TlpLC5clfpqAJJFg7jJnH0dl1BzrXPogFgmNu+SjD7R7@nongnu.org
X-Gm-Message-State: AOJu0Yweo1W7DtNr1pJEGKb6rlhe6fySm2OSLvKF+wQI1sVe2DU1MTtM
 8kN1FNzJeLiMSQUNpW21B8bgb18MwGaemDRaFZ+6T34yXS2PtA7FRT9KFYTditpYdVmCaHXbpfZ
 Z
X-Gm-Gg: ASbGncsqdlqY3zNc/ovXxDaDXOeVV+gSyk5K6dzkzXE7mB320IHV4+oYvAXPcMZNkur
 PvgJ+ujgKJEsgmOSq/jZakuFNDYWz/2jNs4obUpiQ7pK6IR4TFr9Bw57KNWBL/QiO/zGcmKWz5z
 n8Y2icgI7my0g/XG8l/MBCTQ7i0iLhwue5b1YyFF1hfHTI6P8WhZ4EC2eZdLvMAM2h+s79pedMC
 lCdthGrJMiHLVee68BP3Y5WvTmyN6DyMl+tz8DDl7psHh+q8rhx5QCKGmuIvKIZqXLYQWlypKpH
 5XySX1YUlZa3qv78xb6jVlmlWQQC8eM6moPYDVCVmZqDPF8/j0mm2yURTz3i+XcrPlUQ5uOUX09
 uoemk+0hq73FW2c6Dig==
X-Google-Smtp-Source: AGHT+IGWeM+qiytXMXhk7Z3wUhJP8vVAZtdJwq21Mr74dHhRavEY2X49g5FKikU2zqvoEQZab3L1dw==
X-Received: by 2002:a05:6000:2d10:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-3997f92dbebmr5874157f8f.36.1742765482917; 
 Sun, 23 Mar 2025 14:31:22 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceae03sm102548265e9.8.2025.03.23.14.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:31:22 -0700 (PDT)
Message-ID: <c27e8c2d-c7a0-4521-8dae-34068fb42263@linaro.org>
Date: Sun, 23 Mar 2025 22:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/avr: Use do_stb in avr_cpu_do_interrupt
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 23/3/25 18:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/helper.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


