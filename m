Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3C2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 05:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4BoQ-0002PA-Bv; Thu, 02 Oct 2025 01:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4BoO-0002M4-5g
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:25:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4BoF-00026z-Bn
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:25:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so357157f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 22:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759382689; x=1759987489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xg3otllxG4rymDGijtowW+qsP9iIOj8h/65wdaLwtZA=;
 b=B3KkGEIUc+ClRUvy2XoJbrKbwIUwzeo2uCYCO3k2eFfXsdZzcPLFe+brPaOCpKyRui
 4KxcDty1KDQFoYrYJTVF7dgAKKppX2l0XvVNh1JAA0JQ0VbXIyMA3OmrfcWjrsa6E0D8
 8L1XphDF0mY2pDNvlw2HNoFnPdmNpN2VpPFaw3v6e+6EXSHvKePL4+bPmLwDWA4elgQB
 Etw40EXNEiGf8oa/y3KyP2HGsfZfWk1OUjOMufhBmEF0XQOkHLKIcXcAHnw9/W0tnjM4
 EToKsP56Z31yJ0JXSh2UQ2/q1NP0KcsehP66uEQ3sk5YB1urZ7Tjr6As4ObYPd2099g4
 /DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759382689; x=1759987489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xg3otllxG4rymDGijtowW+qsP9iIOj8h/65wdaLwtZA=;
 b=hQWzURB4zazGNuN3CudxAASOGFkYv8iHC4zHIHapExUT0XzzA2Mt8Vj81S+0M1avyO
 QAjsd+4Vq0GuOf8+QQoMmpbU4krP4O0brSS0hiSTOZuxGZM8CpqJCNPSfcLD0TGkxqpN
 yMkPxMzVUh0e/7Xhse19R2hsG09axuSUrpLippdRXLAkjDGHWR9z6KHnFPluqIpVcKJd
 iqKbzCIJNsl0iBRTt2T2aCaTlNVSGKSFR16x15e742/VzajaJkvnRGwKzfC9IJoucEBk
 EpL5Bor+tzww1cpTNlZAskcxsTlCqziAYEKYhSMFQeOD0SvIXVuFEanHHjq6LVgOVhIG
 n+AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkEr50+cS2XL+9I4uvaWByL3CWy+j7JHkMF6mBI7gLYwioLywUmAgza6rem6QLeVXqHQb8282OwJf+@nongnu.org
X-Gm-Message-State: AOJu0YyBrtCqr8vETdJvTbtujlClQOiAjxv01cYsWY9Se53sg375brOi
 KGgk8kYjgD+iCuGlgbZSUXJDpbGSe/Vrcl33K0DQ4HtFA2s11BPuRkKfcKmBl4rqd+q1PG2FBnQ
 6OmnXZnOCyQ==
X-Gm-Gg: ASbGncvImiezMtwiqaIes6uIfZUvMs4h0KDHyzKmB4zZg2H4N4PMNGamvKb1jj+2kkN
 Pq6cBIipNg8n/QFphsf35oIw89n0ulgAyg++44UMS8ApSmtu4i0uoDx5VI13+Lt6c+V3DpYJuum
 RQU7YKs3WgHsbXKse7ewNNhfPPBAiVGbk3MAqn7a0GDdMdTVm5xO2OSlh2xGqL1NjYqQ2dZQpPS
 RBV3sp5jPQQ0ioVmxOK7CGsgjDkseGANv0lmssTeuKc7T1abuwItnAIYvYsj+8DmXJlvB3egamq
 82V9If+rrhR1AfXZXSD7hffIXac8JxtdnChA6eFUMKFdv3TZsZL73bFPKGBKmY2VGPFmCnS5KMg
 GKtsiUSbwIfPS0GCJnkajP8j7gjwCA9ui0o1b3tJbVzD6M0CP2qN4d2OhQqMWJN1oxpblikfXLb
 MufRwReS7EmCfYTVV6hg==
X-Google-Smtp-Source: AGHT+IGQj0t3+HooTq0+/8lXDgfF+cjdwCuLZh24cgVD3fdYH/wTzqLYWBamoifTpBD4sPxMC3rnuQ==
X-Received: by 2002:a05:6000:240a:b0:3e7:6197:9947 with SMTP id
 ffacd0b85a97d-42557a15b6fmr4465216f8f.53.1759382689249; 
 Wed, 01 Oct 2025 22:24:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f083asm1940991f8f.43.2025.10.01.22.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 22:24:48 -0700 (PDT)
Message-ID: <27b71637-b71d-40a1-adbc-799898db594c@linaro.org>
Date: Thu, 2 Oct 2025 07:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] tests/lcitool: bump custom runner packages to Ubuntu
 24.04
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-arm@nongnu.org
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001170947.2769296-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/10/25 19:09, Alex Bennée wrote:
> In anticipation of new runners lets move to a newer Ubuntu LTS.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/ci/setup/gitlab-runner.yml                   |  2 +-
>   scripts/ci/setup/ubuntu/build-environment.yml        | 12 ++++++------
>   ...tu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} |  4 +++-
>   ...ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} |  4 +++-
>   tests/lcitool/refresh                                |  4 ++--
>   5 files changed, 15 insertions(+), 11 deletions(-)
>   rename scripts/ci/setup/ubuntu/{ubuntu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} (96%)
>   rename scripts/ci/setup/ubuntu/{ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} (96%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


