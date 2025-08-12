Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858CDC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uls1k-0006YS-IP; Tue, 12 Aug 2025 12:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uls1f-0006Xc-Py
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:39:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uls1Z-0004io-GG
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:39:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a11a138faso5380655e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755016732; x=1755621532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8tkPG/H8Cj0L/lr5rRmVlEhyoG0XyR0AWHi7zgqu58=;
 b=CagitsFcDxbRxwV9TnVbvc0pMWmFb4RpkfFNL6VZY7iRDdrIPRaTqTI4ACxXmedx6t
 32yHbhinQV/7wOy+Qf2or8ibOBQWWMA31pSyI/Rvwm8ZY9vZAoi4knciQ1mni9D4X/if
 8dU1uD8OfjELpqDfnvE6Qo2L8cFao/I8Egcl+tVL7CIs852QY01g52k2RpqtR1hiecUt
 6hY5W7kW+9zcc1xxNve/xUdeyjYj+hZ+dFpXtiW8c+zgx9Fga5FR6FswCAuydweJLGyq
 t5Imd8/885ACt1pDqp5h+RVumDj7B0Oy1qCjOOQnaO8SF6095twA6G6/hk0wn3ucHSl9
 zNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755016732; x=1755621532;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D8tkPG/H8Cj0L/lr5rRmVlEhyoG0XyR0AWHi7zgqu58=;
 b=Hd1+2W9Pj0oZiQQ6oH268JgmXWraxJH5Ekcl9YcesUZNgUCHBR9GElg9/ePezpcHSj
 DvFOs7cTuUOyZQqyor/CjOFT1onP4iW0o7pfyGQxgGUO8BTyYJA6oWiG+zDfAMLNid0a
 UHHLsxidufn/QAfZtPCJ+XuIZgCcvWKOk1oi0bQdo5CumBlX3Gsy2XQFjYQrr7M77LVc
 g6oGff6ch1L44EXcIUhaLE/rBMik5JDdgrwpOzqjNYkoPhwZ/oEBG4EABjCN5/U8Rtt8
 6cUGYRVvbWIIOCpp96O4i9kt1uRIJTtsZTWkqeiRcXBbCigXjAaGqnL60d9FBeRwktiS
 NHBg==
X-Gm-Message-State: AOJu0Yy5pYDf6qjyn3/zTPap4fnflZkiFAyT+2KtgtG3Swz4H1fZuEMG
 i+R9jjCsswr2ezxUyDCYX7K90AKrdYz5sw07dYqa02u4sk1ie7Am8kIKrpmfOfa1o5bJjA+K9Su
 gKnK8OZY=
X-Gm-Gg: ASbGncuGlhrm1+wmiqGqHtgHIf7Q443R1eQ8WzQkHocIjnsiu+3zM2xA3yuDWezRMqH
 Bxdf6pCyEUCvK7E1Rxg6jgz6MyG+Rjxs6vJ3/vPAJD/dqudYDSTANZ3nf6LZ7RQPSv3xIdVb0qi
 ecA7iT1aVDeKAiHK0+wViEmCsK7a8muzPLz42HxTOuIglGQ5fW50VkpZPBYTnUhsK8Jxcta3V5d
 C5j+gtv1RQGW8/rgaaXVJkHOKzAhLMPtX1s77BX8PuAZbas2of5sFb7dPj6hr/m3gqX74yh2zat
 AsdguLK6cuxsnCDzH+4BrX0nrEMxEijPiQ6inw/gl3Td3ajyN1QJP/GAGo2CX/rPemR1JfLsF9m
 lTku0zrd4ZckYqSVdcrBpxck=
X-Google-Smtp-Source: AGHT+IFCFXfqKX/Ge92GGZsk4hQX7ngv7QaiZoFpsteMnYoNunBMHApP8yrCZXLtZ1Jqh6IAn+8HGQ==
X-Received: by 2002:a05:600c:3542:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45a15b5c8d3mr5258935e9.30.1755016731665; 
 Tue, 12 Aug 2025 09:38:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48105csm45105312f8f.64.2025.08.12.09.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:38:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC89F5F7F3;
 Tue, 12 Aug 2025 17:38:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH-for-10.1 RESEND RESEND v2 2/3] tests/functional: Test
 SPI-SD adapter without SD card connected
In-Reply-To: <20250812140415.70153-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 12 Aug 2025 16:04:14
 +0200")
References: <20250812140415.70153-1-philmd@linaro.org>
 <20250812140415.70153-3-philmd@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 12 Aug 2025 17:38:49 +0100
Message-ID: <877bz8a412.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> SPI-SD adapter should be usable, even without any SD card
> wired. Refactor test_riscv64_sifive_u_mmc_spi() to make it
> more generic and add another test, inspired by this report:
> https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@r=
oeck-us.net/
>
> Inspired-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

