Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B110E9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1r7-00047u-HF; Sun, 28 Dec 2025 20:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1r5-000475-3c
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:15:27 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1r2-0000qj-M4
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:15:26 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso6997034b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970923; x=1767575723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/i18/yK8No4n5AJ7jUqbcaCmwbalEFzuwcmebfMGqw=;
 b=NbuX0xnxnp+ctcb5Vy5EmxXhKqPPpbPbuHqCVujDW+06wPDfI8LcCGyoD7URs1d7vD
 KTh82eZiPcPzDqyolw3p03CiLAdD4kE86HU8EBcYVUPbOulxxNm4PmD1si3egLwA0RWy
 I/SFIRIJoueMi21S+Eqj2BiHI84I7qPymfZ5ZehyCUao54HyJIOouqAZBgono3Bw9hRN
 IXWS0/a9Zp7dXlQ9Ko1mQMCR86xfrdUFsNAU4qZmcAgkhKOSB0vRImG5noufowTwO/vI
 ULivnbE3nUqAPw5za7inkkHArFZ3plvt+dk0GjH6OrdVVz3Feld5gHVRkRviihZZlFvB
 jaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970923; x=1767575723;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/i18/yK8No4n5AJ7jUqbcaCmwbalEFzuwcmebfMGqw=;
 b=Ra0sK/G8q21gYoIYhFzg/qAhMYg2NwJlVyUrxqhzZbnMHc6wOEecMLJ4wQZZlJj43O
 GB5ynlg12RXFTncL/qPbutfAc/D2cNAHok7OJMsCcrH6SMCWJNkC2LAZYr83oXwXQQxH
 ZLjdr1OJeeGnR3RG1pU9Ysjm8AW3q78GkFalETzlpQEO84V4ZHIyzlwK34+p4nOkI2l5
 WU/MBu5EZw8NVUuxjF7zfXCNfU/17Ocuhq1fSvxmv9jyulVqya/dfqDs75X7oSxm+Njv
 38KBk/WdBBn720D36w769cjMbFjzn21cO1pRmT1fkk41RmT1QP0SnuMy9K54W9FdMd4t
 OSNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVffuqLuk5vE4wwfv+ZWL0VlzmUqCKEYNUNpG6wuWe9qN31nV4lZmSIWlZ83EmmytWrf9h7cxncbRd5@nongnu.org
X-Gm-Message-State: AOJu0Yx6KO8M8E+ESXelLoGwblUcM2+rn54BJyCHK9IyiPfd8+8B3L9S
 yIedHpM1RVT+bkBCvu2qM+kxeul1ty/nFo3t9wLHh8y6f9nZmvf2V2NKR73uWN1FE4U=
X-Gm-Gg: AY/fxX7UcjXGrANTzgQFTAWPn9r6WssH1I8c6LgCZGJaALK2ZsLd+xBKQ2g2y3NXjIe
 U4AbhL8m6C+Txi/D+t7vX10lECJZKIe/ZMALEjTCC4wwO6ZL7N3X911vhd+UT6Caq6wCeb/tClc
 TpoVWYL/CdEeyrqIP/8i8P32OlhaZdaQHZYhY9TAhSha6AJuIrKJb+vUnlw4nGmg0tvquGUS+qY
 zG7J3Vt/Hq+K9Zk5YV1XcHhWf5IBK71LffM6gkhwLz3mO6qaJWB2YwfE4x1SjVT3XcjLYv3qW1M
 tAHpBGJMht2NXFq8Lly/vSMOEnil1vOuhm5pYVGwHdtm2xxgkbSH1MV5zeKg+Fnjc/qDIo48K5Q
 HuNLoQGKzhaRrDfO0hpNdXZiUO9JUduJuvZrvRu/zhqkdw6Fsi6/ykGmB25N5iiTt2QlARLfPHu
 oRd3aLtmyiU7XpmNLfmAf06Y3ciKChkMuDuOVASAB4RdISj6vgpqUI8wAyDi+qQCieGjbGfKsWN
 IPj2TO3
X-Google-Smtp-Source: AGHT+IFWoxGnMuAqaOStw4phw5yXvG7g4X1CyY5DsJkTVJECuQ8SpaM4D5B/bULfC9QPQ5GCleRPkQ==
X-Received: by 2002:a05:6a20:2450:b0:363:b975:2d80 with SMTP id
 adf61e73a8af0-376a77f0cfdmr26421390637.13.1766970922912; 
 Sun, 28 Dec 2025 17:15:22 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c130sm23789407a12.3.2025.12.28.17.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:15:22 -0800 (PST)
Message-ID: <a5839e8d-522f-4b2b-8e86-b81326b4d7fb@linaro.org>
Date: Mon, 29 Dec 2025 12:15:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/25] tests/qtest: Remove unnecessary 'qemu/bswap.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-24-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> None of these files use API declared in "qemu/bswap.h",
> remove the unnecessary inclusion.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/qtest/pnv-xive2-common.h     | 1 -
>   tests/qtest/aspeed_smc-test.c      | 1 -
>   tests/qtest/ast2700-smc-test.c     | 1 -
>   tests/qtest/libqos/fw_cfg.c        | 1 -
>   tests/qtest/libqos/i2c-omap.c      | 1 -
>   tests/qtest/pnv-spi-seeprom-test.c | 1 -
>   tests/qtest/vmcoreinfo-test.c      | 1 -
>   7 files changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

