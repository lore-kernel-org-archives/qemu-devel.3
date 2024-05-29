Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB5C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCmW-0002Gt-3H; Wed, 29 May 2024 02:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCmU-0002Fw-6U
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:27:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCmS-0005vh-Lj
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:27:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so179344466b.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964043; x=1717568843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPpsvwIIM/9rhJtSqKc0KQFiyKVA/H6AMru5rb7zErE=;
 b=pbvnAn//hEFunF5Z1vCtOuichJSH2XUSyTxaAhb+fMK8IBfOiqee/ulGJrYyuEyG9i
 1F9r+1/m40djs2QCT6wZE/nHQbYLm78Szc0CMS0rYNPGXPo0Rzz1pTrDXLqOHkjxrK35
 JfxGcbNgs5P5aA1v1yttJltFLuC/BijdpaJJn7Kw+o64wamIfNMxZ+zDXCsZf8bH7EE8
 g+xSURVgmLxg7HnP6v8dVC7TVdEPp0XRIF+GkypL4sYKv7gRdIgu723xy0i5mGLttL7U
 XUJgaKmzjNFFxIKNB9gHOd02ziE+V4+/kRXZULezTES7+4tQv6uap6Qrf510bL16u4R4
 BaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964043; x=1717568843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPpsvwIIM/9rhJtSqKc0KQFiyKVA/H6AMru5rb7zErE=;
 b=HInDvvFXzzqapopK+d852PS1YO8p/pJIFs2GVBn10EyFdLPMqNR58cn6RXVNIjRjX1
 B405C5nWDsbfeC9cPD9nhoAvZMI8dJUhAdJdCEfPRHnoUxSLiJSpVkqrDppzHcrwbclZ
 p8WrVBkYAQcoIN771UUrL6ZpWLoevVMC5xbhHbgwZ07yUN/5wWVuieWDIu7gzLyvvNYT
 4dZpKwj1iuU/xgmHknTT31Ipc1qUlCe6Q0WaPh0J9p0qNnioKoLaQ+kDs9gRxe4NmEmu
 NR/O1TIIIeNt0ObiolusVFRJIwUiJPaCiER9qORvY4vgCzumxYtTb/vOO2T06C9XYuVD
 1xjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5zK3LWYc3L/WgAz0SiYRenxrho0UysZfZOiyEZY1LvFnm4N+rZdzzIaMoz5+aCxG87sWivvbfWmpSjEYtde1OvbdFEyg=
X-Gm-Message-State: AOJu0YyOsLJ1AkCeRbCaOB4ld8ubEaWjU6e+J+hZEAyzvlOccoOc0XBh
 fLhcJjCtOj+nloBp59b57T4HRuaOzHG6na6XGNzq3MNvAY/1PSyxE88Cpn82H8s=
X-Google-Smtp-Source: AGHT+IFs98FdTZGkXttf9aGjEnJQxjJEhUAhbqLbmeNxEMiuBbckShJkOtFX3BkFIK36OBREyQueyQ==
X-Received: by 2002:a17:907:984c:b0:a62:a63c:18f0 with SMTP id
 a640c23a62f3a-a62a63c1a10mr756880366b.1.1716964042967; 
 Tue, 28 May 2024 23:27:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a635b2b7cdcsm83720266b.139.2024.05.28.23.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:27:22 -0700 (PDT)
Message-ID: <c22df582-735c-457e-a9aa-cd931e0beadf@linaro.org>
Date: Wed, 29 May 2024 08:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/misc: Create STM32L4x5 SYSCFG clock
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Damien Hedde
 <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc@lmichel.fr>, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-2-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240523194441.21036-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/5/24 21:41, Inès Varhol wrote:
> This commit creates a clock in STM32L4x5 SYSCFG and wires it up to the
> corresponding clock from STM32L4x5 RCC.
> 
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   include/hw/misc/stm32l4x5_syscfg.h |  1 +
>   hw/arm/stm32l4x5_soc.c             |  2 ++
>   hw/misc/stm32l4x5_syscfg.c         | 19 +++++++++++++++++--
>   3 files changed, 20 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


