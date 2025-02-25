Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F73C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxAv-0003Wm-0K; Tue, 25 Feb 2025 10:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmxAu-0003Wc-0c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:48:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmxAs-0000Dy-3G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:48:47 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-221057b6ac4so111884255ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740498524; x=1741103324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZOYGpApU5Gr/3rv0fOQPuFK1dmXFYXo78q6Z3WHyj2E=;
 b=qz33G+alrLN2kLsjN6ezg2WM1X1Iujbi6Ib+deWxPxbneBtyWx4bFtnxUejhCXspSa
 IAt3bfWPTkPi6uJToXyNvU4RTcqe03JD2b8RRfhaqN7Pu7JTtsAHMCIr+FRKjitFYqp9
 hcEaFJfLavBoAgHCsSsOQdsV3p0AOZeV+aqsGaSiw1V5n/i0iXLqnF4CB/o1Pp3zjB6C
 eP9roq1Idd/5mwbGDEQqIx1eXfRPGnr7njXSYPgXKvgqUzH+foWbg8oG+ROwrkjUWkxP
 DtUGLdOMKSH0F8A498TGZhUAXYyp5e/DX058zL2qk28aFqv9ckiLGaYV5OnqvOdL0JIY
 0q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740498524; x=1741103324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOYGpApU5Gr/3rv0fOQPuFK1dmXFYXo78q6Z3WHyj2E=;
 b=Plx2VT3s6Gt5QwrFbLitIUwlg55FqBmdymo5qC352m7ZZ+VSy6B1be2H4fYyO7P88b
 dgw5icnLdYMp1TZHS9F8U8PDSy9FzR1mUmExFa2RZB97RRRUGK0olzhFS+X/qodqnOa/
 gTybNwK3PCpIBh9SrZ2zUmmhSZw6xUrs3RNSpsD/is0qufiDoBK1VEm1mOENuGz4Jv9s
 Jag2FHrWXLQMypnxwsFj2cfPrljCvmffGasnLOvPvDOHQHtJEgITDD1jlF2eLMFQHg+a
 k6aOf2QWhKLTw0gr69dRJSIhEtHgg2bHyWo3gkcxhYfO3t3vUVWMu7fnc/USAkz2q3sV
 Q7+g==
X-Gm-Message-State: AOJu0YwsJHq/Xyof4moQCWMzyobvTIYk9unsw2A3P4qSTl87tful07mU
 G61fYeWuFwiMFag/USeJcF4ViW1pqcm7OGtQBd+dQA+b57A5QwYmt4w4wbfPoJy235ze5U+OjLl
 C
X-Gm-Gg: ASbGncsnGiCdhSqgqFIvDOzou7JxjRtDU3qUIi/OBZfXVyab2L6RgPmHZLsy0rPU5v1
 zpCaKf+NG6uPqbORTeUgnLzjJJ2AbRDAWvJmNYWr4eBS0EYZYkiNgpS1+93/76TI5ZStEgGd/16
 yeOeL71xwgg8he+MA3aFdZ6bU4gX9fn1ESEGk99NE2BRSFHcjoS8+LyscuGOaruOpkPNIk3TWfN
 kN7ChN+Roy7taV1UMT6DPgjLPAQEFYJZ3JbsvmFm8h9lWa6dlC9WjdSvlGGPdZXb7gZQmeQnXSk
 Nt8GMnN/Bqai2jmTbQbRd+UmPeon/saSVJLAzANt+rFIsqfNORmzOI3MBcjm+4b9olsRHia29l5
 bSs2CZsk=
X-Google-Smtp-Source: AGHT+IEXXaAiwSkYNbrlBeRcSk9aB6CYm+JX4L1531hmNiLixhZBEyRjpUY71vgvg+Lq3Y1q4hHcVg==
X-Received: by 2002:a17:90b:5148:b0:2ee:c9b6:4c42 with SMTP id
 98e67ed59e1d1-2fce86cf0ebmr32072033a91.16.1740498524089; 
 Tue, 25 Feb 2025 07:48:44 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe6a3dcceesm1719376a91.19.2025.02.25.07.48.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 07:48:43 -0800 (PST)
Message-ID: <46132d25-e765-42f0-9dbc-05260a055f71@linaro.org>
Date: Tue, 25 Feb 2025 07:48:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: add support for the AARCH64 ILP32 ABI
To: qemu-devel@nongnu.org
References: <CGME20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8@eucas1p1.samsung.com>
 <20250225124418.3530474-1-m.szyprowski@samsung.com>
 <CAFEAcA_MJ5YwLi04Be+n1TCKuQmU+3fgAznvzpPonJw0FHqH3w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_MJ5YwLi04Be+n1TCKuQmU+3fgAznvzpPonJw0FHqH3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/25/25 04:58, Peter Maydell wrote:
> On Tue, 25 Feb 2025 at 12:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> This patch adds support for the AARCH64 ILP32 ABI [1] to the QEMU
>> linux-user AARCH64 port.
>>
>> The ILP32 ABI was initially developed quite some time ago [2] to
>> facilitate porting legacy code to the new AARCH64 architecture. However,
>> it appears that most legacy code is still used as ARMv7 (ARM 32-bit)
>> binaries, running on ARM 64-bit CPUs through the 32-bit EL0 compatibility
>> feature of those CPUs. As a result, the ILP32 ABI has not been widely
>> adopted.
> 
> Firm "no" on adding this to the QEMU linux-user mode emulation
> until/unless the ILP32 ABI is supported in mainline Linux
> kernels, I'm afraid (which I do not expect it ever will be).

The partial support for aarch64 ilp32 that was added to glibc is being removed now.  It 
brought up the conversation about removing ilp32 support from gcc + binutils in the next 
gcc development cycle.


r~

