Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8431FE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 14:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMaT-0003Jp-V3; Thu, 02 Jan 2025 09:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTMaR-0003JW-P2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 09:54:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTMaQ-0003dy-91
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 09:54:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so163342445ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735829648; x=1736434448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVkqJTaLW6XmRme1wzrjIaLJFvZnJrcUASbE0mfyV8A=;
 b=nJu+BxXjKn9y8JX7NYno4gTCurMH8YNIcYge3iPWriqHryzzrTOrN/GLnBB/NIYHrz
 YVsIoCr2kFpGRKDEXcLL4R83L+OOfIonM+cY1E2ZFKlpF983N1FkSHXzRHo0CL9WCk5y
 fuGSOLcrm+q5i3IXMU3FUmdJXkiZ8IWg8lapIX7l8DxAObtkUY+REShpfcifOA+qhvSu
 n1RQ1i+8/L5Lxw7q7Obd+4JmCLNRWSrU7PlWahUGxZf/f+SxZ/oOrUMdob9H9yndRtT1
 I1s/hriu0XuuxRRQAJT65Tr6glz1rSFWHvl89ORwhNormvhh2csNRfzyqNSng5MlkPoX
 NBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735829648; x=1736434448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVkqJTaLW6XmRme1wzrjIaLJFvZnJrcUASbE0mfyV8A=;
 b=h5XTIdo80XB7V0WYS8UYl2gTpjoHgDLOIJdLlM5SGZFmS4cDYgncJWHt92E2Y4cv9l
 AgV8qDwGilW9cmnn9ZcNf4FxbWJoZX1BwNwqN5jTyhaXd/Fxb1Z3siKZHub0nllYZ2hX
 tifFA2LM4TF1XmIif+PHLEQSA9zyYuFo4TS6W/nGDlGX9bpdtKscoT7v6kZ4MvEGv0MP
 Mk/dzd/3KiJ3BGBvcFyAwLL4NRX9P5NEQLKTmmoCzg81+yU1wFn1szrcP8dJTkAkTUc0
 QWKPRqMK2Wka4xxG8i8AX8qOK1r/7PHJ13b3w94+Z9P3VBrEQSCKW74l7bX1raW2X/Sj
 VP+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Drf4Ev47ZjpACMHm0cTFQhlJVGfqbZF/5O0714nVz24dwuZdwHdA097/B+1OIY2O1zG3Rw8vRchs@nongnu.org
X-Gm-Message-State: AOJu0YyWQApvcSPs/OUsH8xQK/fSU6GE3tVM+2JL8nHIPpVUbWU89hr1
 Y8P4AebmnXZ9Rh3/rSCexfNPrC0RCa65XzEnkzoHSiK1f9ElVlbMsEO1TLmrHIU=
X-Gm-Gg: ASbGncvKSo1chrnEgFZ4B/tf8VIEci2oA8DkfWURCeRk7nI5ViVMBTQwFO2H7SyZOxp
 eyJty1IUjGmaHI0pv4lh8vlj2cAxvc2KK9oLzdXx3LI6e2kfy0DKKVxr0AZbeRkB/3xhapju2tb
 JWh+9ZzgT7oG5aa6SQhQlseVhsOs2CqHRJJxdSr/flPYWhWZeQIAXoaIZRZbHn1b72r6KJ9eSyG
 qIX8ZekROHX1l8BK/S4I6Xzb9tPHWEU6Q/69gbeq2pVABxKp9G4QWl0PEDkQPHg6IaxMyo=
X-Google-Smtp-Source: AGHT+IG5Kz9d26jxYQml7M2gAc76en9Q7dtBBwVdHQsZz2+OjhOvG1DE1IHLr/d/0eGm3nD3rksQ5Q==
X-Received: by 2002:a05:6a20:6a08:b0:1e0:d0b9:9a90 with SMTP id
 adf61e73a8af0-1e5c6f15f19mr80329653637.13.1735829648375; 
 Thu, 02 Jan 2025 06:54:08 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b229c48fsm18943597a12.26.2025.01.02.06.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 06:54:07 -0800 (PST)
Message-ID: <f9e8c228-fbaa-4453-97b1-434d22dfd36a@linaro.org>
Date: Thu, 2 Jan 2025 06:54:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] tests: Add functional tests for HPPA machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250102100340.43014-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102100340.43014-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/2/25 02:03, Philippe Mathieu-Daudé wrote:
> Since v5:
> - Correct boot-serial-test machine name for stable (th_huth)
> 
> Philippe Mathieu-Daudé (2):
>    tests/qtest/boot-serial-test: Correct HPPA machine name
>    tests: Add functional tests for HPPA machines
> 
>   MAINTAINERS                           |  1 +
>   tests/qtest/boot-serial-test.c        |  2 --
>   tests/functional/meson.build          |  4 +++
>   tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
>   tests/qtest/meson.build               |  2 +-
>   5 files changed, 41 insertions(+), 3 deletions(-)
>   create mode 100755 tests/functional/test_hppa_seabios.py
> 
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

