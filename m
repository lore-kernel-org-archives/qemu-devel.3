Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE3FD44167
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQ9m-0003M4-HA; Tue, 19 Nov 2024 10:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDQ9j-0003Ld-1y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:28:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDQ9h-0007Yv-4N
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:28:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so9947995e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732030119; x=1732634919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEfaf0cMtrgW+nFl0WK/VZe44yL9DrBEcge5+uMMHQI=;
 b=qDYGxqMGvTKds6dyB2pOfDFtbPK8jS4+oyjiOZKsfKvMSJwMDE3EX+ly5vMrPyUVTw
 mjmrO9RztBVdlLYtIMs4v0tlPMcWIO8eTNJI2K/+31YomPJJtmqbXAf9L8jTeCs8icYJ
 ab0MSRPG9dxq/gPgcY6OILfV/tZ/KgegORjOKsCtM9u5sw0PmLO0BqzmnOxH31GRxXft
 mpz8A7JMmCPccRE6H655eFToFDIFuJK8z3e9JcoYPzoHIaVyZogKbVWQov/pedi3TWuf
 5RaOhVEUXS2S9ZvVVSeluStKWCAAfoSO9DO4gpiRWpM4Q8AtEFVTT7wxwQmaMU0F7rLX
 Lx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732030119; x=1732634919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bEfaf0cMtrgW+nFl0WK/VZe44yL9DrBEcge5+uMMHQI=;
 b=STfzSmI58c5y4q85oUKsTrBLFnfw/UUp4A4Rv0oBXunAzTiVR4yrphW8h5pPuRpbu8
 m6OJw6+X/c5Cyp4y955KBE/tbA4mcN7kNpCL6yNicUaPDMDFFYjoMK0allr7lElV6hgN
 wAq9hv4yBQxeIRijLYNMIwHeutI/45USQGUP0TEkbWiP2FgvmH96QaRzIN4h+vphwzXd
 0tlQ3zd7u8pv49iBj949g31X4JqJK6FjqW6k/q63xp8etdcH5H71JNfQ9KrN5F64nIAL
 y51WsZj2q6JRC2NRvMFZWEQlV+aRHaolMe7hW1vn9RP87bd+4ByN2RKikor4bYBsOgbR
 jYbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdtOX5nEdKwDzFTmwXslcHXK4m4fLj1qpCsA/LBaQn1QyJWJ1/qdfL+J/Q0gg6VILRrX/HcpU+ACP4@nongnu.org
X-Gm-Message-State: AOJu0YzxQGOSfzeE8yTa7/jWCyaEylGYL6z53njBYfq0D/+bSgBroRAm
 F4j7z8Wgy1mbmw1xRBgjnGRG4LtkrEQtgqhSC4YFh5dB740OScn6QlNJ7GDy7B8/NXP9BXOk+fv
 ty6E=
X-Google-Smtp-Source: AGHT+IF8XeOdqzBWZQzv+nN4pcx8Gp3TnIKJGSkM1kfxPrQjcfajlsfTRBtmOsuWZu4Hstq8qEdt6w==
X-Received: by 2002:a05:600c:1c83:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-432df71afacmr133998855e9.7.1732030119401; 
 Tue, 19 Nov 2024 07:28:39 -0800 (PST)
Received: from [192.168.69.197] (sto95-h01-176-184-18-155.dsl.sta.abo.bbox.fr.
 [176.184.18.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab806e1sm202290875e9.20.2024.11.19.07.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 07:28:38 -0800 (PST)
Message-ID: <7eb32fc0-ca20-4384-bbe8-81007438ff2e@linaro.org>
Date: Tue, 19 Nov 2024 16:28:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] arm: Remove tacoma-bmc machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>
References: <20241119071352.515790-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241119071352.515790-1-clg@redhat.com>
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

On 19/11/24 08:13, Cédric Le Goater wrote:
> Removal was scheduled for 10.0. Use the rainier-bmc machine or the
> ast2600-evb as a replacement.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/about/deprecated.rst       |  8 --------
>   docs/about/removed-features.rst | 10 ++++++++++
>   docs/system/arm/aspeed.rst      |  1 -
>   hw/arm/aspeed.c                 | 28 ----------------------------
>   4 files changed, 10 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


