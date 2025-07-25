Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5239EC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOZH-0004fe-Ei; Fri, 25 Jul 2025 15:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufOXX-0003i4-Ky
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 15:57:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufOXV-0006f5-SC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 15:57:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so23970495ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753473428; x=1754078228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IREOmwh89Lrtq9C39xX4b+SduxmbKAtg1Au1nyYJrB4=;
 b=qHN7aXs62E+coTJt6OAdtY2eCJcj1tVRy0qGQBqc1QziEwue/LTliIZ23fIHto7WM+
 ERGaD/tgHW1cjcWWt+4whb0lx1L08Xb9v1bh1KHrWCTLJ4uh1fYs0dFlS5O+0VfgF1X0
 NDobOR9kIsUYWujDnMxx5jzfsblAeRETiRgYBsz2ATx78Qt21iyGTNM1MmwsDYcpjR6j
 Fo7+Zd09SBqVEjfHYBe6tsITr2EVzKkIO4k+Uz76ypDzZT0unMGv9FtWrDvxKsWU+Xoz
 bklJl9duk00Cr3YmhpvPz+HlGSTDnams2LL1jm/AAfrNiBA0zeQPSI+Rle72J7oXaZoP
 M+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753473428; x=1754078228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IREOmwh89Lrtq9C39xX4b+SduxmbKAtg1Au1nyYJrB4=;
 b=pIXSBrKxaNq8piQHYye+HrrbCbNWsfS6xlc/0ryxWzt8YldDjfy/KRApcC2D269YKp
 Mo7AqOEliUP9aPqQ+RyRpfrtXAbnRBBvYCLoBtnwlvdeuz817CZQ/gpGXy4sGFsYDsLv
 1YhsfucJGI7l1ms9NUToTArGeYbYIqVkLvStT4V3lWAktQoJNjijv487R/5qnrzZFa2O
 keixNTOymY65tEKDI/Cg7NoKeCgTf5JWbflzlEMGua2djHmm8n6lfj0BzoQekE4G+fpy
 BBNDCcbTq2q8mQKUBo5pJhmU6XXbE6OS0F7gX5HCDHHeYUr26lPwoK8wFmmTLznxTneM
 uHWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsMWis5GGCpZFzyz3dRuESxQmPJx/HOcUJszYRrHh334V3723d6VuAC78Cs+Z+H+Kflq6K4SsVBoeo@nongnu.org
X-Gm-Message-State: AOJu0YxA2Y3LHnksMrqd9I5aYIK+sD1wokoWMMohUXHf7JYhI8dzpJhq
 pGBm4VIx9v2npOarUSgqRJ9QD2Mi7aCS8tXfG7cxj1wzUiLSPAMcD4ETvqPf/dFOzjc=
X-Gm-Gg: ASbGncvBNtV7lfqOauKmRbAQr8bKAjIayzPIlSdUhL9pIZ3zUZvNJyRsF+QWAvFQbyZ
 WsJ/jjZwxXAMFbnCqadfw8nbzafQrKVyWY0dwo9j0r3Ur7zQerKDq5PrgOKFnMin1rRA1vrVkkG
 XIu+0fHTZcCrebmyXQIFBIttFHYGmYE8n1DhtmWVMHbu0mT79RuT1pefyCMT/SlJGjGtDT6AzNT
 2ZBs7WDREUqKk+zd+qyThyjMp14xzQeaQVmvwdGgMOw5HR4sTlflIordmaNBVo6Km7PNq+maNEi
 pgAhCbnUVyZcOQec+jP6jjDeg8OWr3B3BAwMYFD3svEh3CBsDOE0x/+ugqJzj7qHGP/xDTO/Z5V
 NOIC0f11rpyjnMMCwDRmSaNPKK4S8qDkC0Rn4QdMByz/0qDHPjHpD2nn0IqlJRNcQyxGa99ifI4
 Y4Mw==
X-Google-Smtp-Source: AGHT+IFEKdaUPgqfbBYz2gsowoxt0J9WxLUy69UwBnu4JM4GMcduNllaeCTUGSDc6pQqQ4qL3qCLvA==
X-Received: by 2002:a17:902:db0e:b0:235:c973:ba20 with SMTP id
 d9443c01a7336-23fb314746cmr54802475ad.49.1753473428096; 
 Fri, 25 Jul 2025 12:57:08 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe5714cesm3245295ad.197.2025.07.25.12.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 12:57:07 -0700 (PDT)
Message-ID: <45eee7e5-061d-4483-883d-744ef8e0e3b3@linaro.org>
Date: Fri, 25 Jul 2025 09:57:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1 v2 05/14] docs/user: expand section on threading
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
 <20250725154517.3523095-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725154517.3523095-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/25/25 05:45, Alex Bennée wrote:
> Potentially too many weasel words when describing atomic and memory
> order issues.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    -/we are limit/we limit/
>    - use QEMU -user-mode process instead of guest
> ---
>   docs/user/main.rst | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

