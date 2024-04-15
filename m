Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF968C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 07:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwGse-0004Lp-GB; Mon, 15 Apr 2024 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwGsb-0004Kd-IF
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 03:35:53 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwGsY-0003bb-MM
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 03:35:52 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so32266701fa.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713166547; x=1713771347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRUAnlKiaRRwzf0wfbwa43E1iCK7RwwFAsvsJo8rp3Y=;
 b=n/9hWh981wUWsp90QOd2Qb3rDyhHoLeKV8pEvKUtm1iyaW0eF52b+efbUBhxkK1ilX
 qwjyk/1Ay8Kbo3P6AbdHnpnGNvos277l866LRcJTmd8AW3RnI59fuAP/CHRX23mbkJry
 rt+xustBH5AijunQSFWiVSe3Q2VCTSBj0r+A92FzYtGmyLoPLLWF6TgEVnC0uDgGOgde
 xC3CZMe6EfgtH0cavz5JagubQVn3fmguTwwyxsbDv0Ui/8XWXjNzpsJBsEn/gWMq4nqU
 HH96fWAV38wcPZG9RBxypuitdfoRGc6vFq14bqGLDFzmMTjc6ojmQB5Mo8DpWLPX0Y7O
 E+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713166547; x=1713771347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRUAnlKiaRRwzf0wfbwa43E1iCK7RwwFAsvsJo8rp3Y=;
 b=Ra9LsIbeOJtQcdO2sGWkfrd+PHegz/jfPB1NSIrplsZHJVVJrw4JcZYednRspDqUVI
 NHzHzUO0Y/KgiKBE0eNTgY+fkV8TCLnXsu+B8kUEFKTaRiXyLGVSCIz0yg9/46fW9GvE
 SkNQgaKx1wbXD0Y7l+AwcrsHsJnx2bPrtg0iEoWtB/H5NKDYtS44XZ/9hXiFrXsCobDw
 s43pkbMCoEhhtIAGfNfSjfLcmpR681w+OBRL9aPu0L1zd/2b04t+aHF9++CQUVBbJ2rs
 /zjUGHd+0IBlWwXvCP8aFIDsvuMCSg3Mu/ITcDLTfjxeQpQBGlaQaWG+YPA0KsW/mVXf
 alsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo/8xWGi15Ap42XjUWdJF6oCBTTalXucv9refLvQfYwDRtuowaO+ncoIRUKR5JqGJGR+yjLcucQ1YgPg7V3RSko1jOvPQ=
X-Gm-Message-State: AOJu0Yyj20/3qNxk9HJ/NGHMs64WLxvsyQHqHlZRO+1fn1MuzmyHL/iv
 vgkdzk9Mwk2Byu66rtoEv7fmMnK47DWSNteiwJuhgU5u2XPJDllm9ZQPlXZ6wDA=
X-Google-Smtp-Source: AGHT+IHyQK8L5pwFW3e5m2nLNwOUaOwJmq7Y/+T+/JrcHIJ+MeegCQaB/K1Jr4iNG6lJBOsAo03NHA==
X-Received: by 2002:a2e:99c6:0:b0:2d8:74c6:c44c with SMTP id
 l6-20020a2e99c6000000b002d874c6c44cmr5044349ljj.46.1713166547395; 
 Mon, 15 Apr 2024 00:35:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a5d680d000000b003433bf6651dsm11310911wru.75.2024.04.15.00.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 00:35:46 -0700 (PDT)
Message-ID: <af647bac-d0b7-4382-b762-5ba055411872@linaro.org>
Date: Mon, 15 Apr 2024 09:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-block@nongnu.org,
 Ninad Palsule <ninad@linux.ibm.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20240414173349.31194-1-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414173349.31194-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 14/4/24 19:28, Inès Varhol wrote:
> The messages for assertions using hexadecimal numbers will be
> easier to understand with `g_assert_cmphex`.
> 
> Cases changed : "cmpuint.*0x", "cmpuint.*<<"
> 
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/aspeed_fsi-test.c          |  20 ++--
>   tests/qtest/cmsdk-apb-dualtimer-test.c |   2 +-
>   tests/qtest/cmsdk-apb-watchdog-test.c  |   2 +-
>   tests/qtest/erst-test.c                |   2 +-
>   tests/qtest/ivshmem-test.c             |  10 +-
>   tests/qtest/libqos/ahci.c              |   4 +-
>   tests/qtest/microbit-test.c            |  46 ++++-----
>   tests/qtest/sse-timer-test.c           |   4 +-
>   tests/qtest/stm32l4x5_exti-test.c      | 138 ++++++++++++-------------
>   tests/qtest/stm32l4x5_syscfg-test.c    |  74 ++++++-------
>   10 files changed, 151 insertions(+), 151 deletions(-)

Thanks for the generic cleanup!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


