Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F24BC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 22:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tksFx-0005Zb-6o; Wed, 19 Feb 2025 17:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tksFu-0005ZE-9f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 17:09:22 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tksFs-0006zh-Oy
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 17:09:22 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so469938a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 14:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740002958; x=1740607758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StL5FUz3pPnu6kWNTtozbmoxH5T49l2PWsBX8xanR44=;
 b=c7nobQy6fA4yYl1Jk4rAUA1vxOsf57bzRUKeQc0seG2ZlKoGXExOUR05iDN+LMTBNR
 lGxiIld37/uHwGaLWDmMD9TBqQf7h+VMsKTN2kjfNyA34sVzBb8fe47sqvj+8QoSFGhb
 UZsqK6ENAQvscV3ywlRerE5v7r9q94ggzPtaQmCz4Yr8KJP2HUg/ms+PAJuLAsyE4+/0
 eNjDn5CUwQHPn+HS9zUuV2MnxMxTmDGNZLcpg+vJOppspns+/X9FVotlNL9jcyi9I7xM
 nDLDCg/xi9WS1HQXN4nMC7vJLqs0SLoocdvAdblimrcE88tGK867zcxjUf1lQskn9Gia
 1cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740002958; x=1740607758;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=StL5FUz3pPnu6kWNTtozbmoxH5T49l2PWsBX8xanR44=;
 b=W64VT9vd6KCfOZRKw1m47tootzN0CJd828sF9FPf6W35h1GP8V9VawbCTtpKez6aa8
 1kyvAlutlb2TBM5iM1YwbkPHZCUAkSZrDwHMqBWbwnAgaJ/qlS8B0qA1xi24LGsLRPnr
 12uADaZbqGbbpriBxg/POjSir6gWsOQp9UC1SiyugxLbVjR99EFH/0y3yJ2nZn6Y7ypR
 KtKJ0V7ynPglYLNucE0uB6LCB0dPaU3bwvCGdYUFbZp1PKeWR3tVchBV7YBajhcYjnIZ
 8pximlUUqwz+jd65M9kcN0w0WG+dFJk3JTMZCsJOgzBAPBMEZlPwkpteo0UBJYvNqI0a
 iGAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi699mGHYqjV9mUhie/gWTCJrAMNiM45pWP1JtrZ9Rrzo44e3K0xWdAQdxMRzYlDlRelmsLSPTtJRB@nongnu.org
X-Gm-Message-State: AOJu0YwTLggTn/cN17F/MZOh2s8ubjQU9p8xPvb+SHE90hKUjTJtgYAW
 gcl5UbRf3DJgzReviP9e8nWXtHXelgIRHqUcAbAK85zCKFJbilYBVxAUHfbyX8E=
X-Gm-Gg: ASbGncsxsXITmchA2HxOzFB5wKjeygfPnDauiTzz+etS9014R6yxmrL9fAGxNuZcc1w
 xfwTntGcbbNadZN1T3pggcNLWVGO2zVUDOIr4Z1iQQTtFXxmZnd/OaAYypZ1mEmTzTi3g5DKZcZ
 kW066LdzxhFOvAue3f0/w4ZmtNCh60UkGnf2mSGF1NsReRJ1/IsFK32icgixrRj+S0qJgiohowk
 3JoTgOOHDLrBVyFCZm7y2Y5ujAnf1Gr4wjVKKOO4n+9vFHsdQwv8WOEzTG7koVm9ZuzIDhQ0HRQ
 0RnizCiXDFE/Pc2cAA==
X-Google-Smtp-Source: AGHT+IFfwgDp/tENUPUnyRCsXyXE2U9GwUhUj9nyeXjDDgpPvPk1nl9tv/t30M9wHhoRSgal4RmeYA==
X-Received: by 2002:a17:907:2d0b:b0:ab7:b7e:65c3 with SMTP id
 a640c23a62f3a-abb70aa62abmr1998563166b.17.1740002957972; 
 Wed, 19 Feb 2025 14:09:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9cee79fasm642128266b.129.2025.02.19.14.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 14:09:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A10B5F760;
 Wed, 19 Feb 2025 22:09:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,  Rayhan Faizel
 <rayhan.faizel@gmail.com>,  Luc Michel <luc.michel@amd.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Magnus Damm <magnus.damm@gmail.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 3/9] hw/char/pl011: Improve RX flow tracing events
In-Reply-To: <20250219210841.94797-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 19 Feb 2025 22:08:35
 +0100")
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-4-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 19 Feb 2025 22:09:16 +0000
Message-ID: <87ikp5k2nn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Log FIFO use (availability and depth).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

