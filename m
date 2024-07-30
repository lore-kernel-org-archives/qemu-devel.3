Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2308C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpR2-000509-F3; Tue, 30 Jul 2024 12:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYpR0-0004s7-7c
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:10:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYpQy-0001Zi-JC
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:10:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so29278645e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355843; x=1722960643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TN6QY+/iFgfvaowPM1QWeg53CmJThz9YF6yOF5vbYkc=;
 b=Qhnio1EXsuGTmzyKo8veec9nLGNHSRE5DZ5d7i3FT+5/6p0O83/qcBpQckUEYA6YRe
 BdZJmAFEPMgLmqvjn10Is52uGOuaG1lbfClNNX/YwuIuPLz0f2lg4vwqirHaAzGHU7PX
 uHO2YYn4qWZszmgycIO46EQ38HCC3nA2cpNlmFyXvRcZCDlwmDwb6fZ2NzzFHlMD5Rnp
 4KCq27A7b8U39VWASFFB8FAN3ZfNGi7obe5w8XBaJw3s6NcMeHGHr3JuBNbpNRPWvuVb
 N3k0Pa0GJCmBDkWPIVVb3bgzT5Ks90s7r5X/z8ZBrP8r03QPHyCOSPiXHVr3PeuCLLb8
 +qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355843; x=1722960643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TN6QY+/iFgfvaowPM1QWeg53CmJThz9YF6yOF5vbYkc=;
 b=Y4Wb/sHnB+ZPlD0fx2EZ4ONdmA55eep4w814sps2YNw1A+KWs+DN4iXMeRdiXDRv6e
 T2dAnBUv2o6mmRi5qwPYz0sD+BGqcp/PGJzFz8k1UZeO85QpuSiknV91MdC0roKOiUU4
 orPBUWWstk5BLX40T8b1Fpe8KRN4ftm5oziUFtr7DzQ/f889AgNDOdXBCnMC4bfjbhZL
 oIPKtuzi+1HFltE+n1qNUkAtBCxZUNt2vKUkdtTbz/s6ywOYnvKI7yFFQaVX8F+8Yy4Q
 G/xoTObRVm3ZZ9Wk/rY+zesdENo51HPNLtMF3kOKGzcWHB5pKmDnXiNbqGA+9oviCupW
 tmlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrfeTDdhRQv9EGNmagdc0R5+ryMNzO+yuRXUOSuIdURreDRd7kuhRbu4P1fF5VoL9eNP7ptyGTiXeM@nongnu.org
X-Gm-Message-State: AOJu0Yx9N8zahp6kO9WopPXA1oryYX5fBYSThqhSmNQ1xaxbN6OsWkJj
 bE423khJ0LVt2JkAYPJDMc5L4zqScOQOq/BWnawBIqf3/JVAriX1fJF8dILfJbg=
X-Google-Smtp-Source: AGHT+IFn8KpRkQZpd6pK4oggJmm7AoU0y6Gu6zp54TOqTbJndg56uNDGJhUS5B/M9nGW/nYZMzUaOQ==
X-Received: by 2002:a5d:5988:0:b0:36b:8f4c:71d4 with SMTP id
 ffacd0b85a97d-36b8f4c724fmr1863998f8f.28.1722355842779; 
 Tue, 30 Jul 2024 09:10:42 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b8f7073fbsm1689147f8f.6.2024.07.30.09.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 09:10:41 -0700 (PDT)
Message-ID: <41007968-c67d-4e92-814f-2ba555e66a20@linaro.org>
Date: Tue, 30 Jul 2024 18:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] qemu/osdep: Move close_all_open_fds() to
 oslib-posix
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-2-cleger@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730122437.1749603-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/7/24 14:24, Clément Léger wrote:
> Move close_all_open_fds() in oslib-posix, rename it
> qemu_close_all_open_fds() and export it.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   include/qemu/osdep.h    |  7 +++++++
>   system/async-teardown.c | 37 +------------------------------------
>   util/oslib-posix.c      | 34 ++++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


