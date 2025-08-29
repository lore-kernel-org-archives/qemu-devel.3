Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72496CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9Y-0004Qt-Og; Sat, 30 Aug 2025 11:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uruBX-0003nc-9J
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:10:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uruBV-0002Hm-1B
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:10:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so7913045e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455006; x=1757059806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LAric2XYbKMEbt/AJajkapCtK7bDeXmebiBkZGrU6s=;
 b=W3PKeVkkA4n3tX/e3cNJvQjAM/eXMKNlfViz37PjCw6tAnyruNzf6gTBPpuSBNVXpG
 wDKJS5xx4w1b4feIcceIPlqcTbg7Q+Y/YlXA+yR3UBl8LSbWNuQ95z92BhbhoxbKudae
 thmwNBlfcFQl20grDqC32NXCRvsjCzYWKJgzRpWqUBfUT7wJeZDH2ziMICvTbaWKTP8X
 MESq/Y798V6L3JHuw2otpOz7hc2gPI1hn4J1dQeVNia5NKys++dpETsF91J6cAbDcRFF
 VhIX+9KWyd51t++Vft/KPZPjx5ac3mZlZLX5g9rdOJ+gKK0dMODeLnIcCDi9oxso35Xi
 +P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455006; x=1757059806;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3LAric2XYbKMEbt/AJajkapCtK7bDeXmebiBkZGrU6s=;
 b=Td0XKGinV8b0Ow7PW5wmGPZteOWYxe4iPWGx03TzJRc1EdW8FuA/5MSx5DhYgA2Fzx
 A8aO59OGIT6mHGaZFg94xcfV1X5lBr+HiEmKteX/UZ+og9eDX81VAohUV0vXMOXXdG8e
 pvDNfKMPtcpffUWMOM28I6I59Yv6H5Xev2YFZ8YKXfxizwMFcAnL9qWRV1zbzcrfpya+
 x5LMRtrLBR0TUJvPomeg8kRmfRF4fxRnlMYBOlevOvY0GoZX3sQ3TySGeppbL83fkLZx
 NT3KG8pGsZvA/uYGaOgts6Ti7rTViztQZT8uIpIQwczSG6hrdYRvv1YeQPG9OW9gPSUA
 Hpiw==
X-Gm-Message-State: AOJu0YwTsRyiWiclS2O0RTxIMFi7HJ3UuGKnG20v6imQ+/BLHhqrAVZj
 lPshpd82LQKQWQk1sYoRitj3WKDtHI8Mcz2jovSg9W5XJq2Agz9zTS/S8yAs5+Vt6ro=
X-Gm-Gg: ASbGncsA3xZJlt6WNYYAFwngJA0g4GU6dLBH5X8i/i7M0SVlPSicEREiPjuXBM3fmS4
 S2MeK4WFXDR9HIlDSaLw43TkyvDiXRkbbzKili8GO+c/zEID7YxxYqrdMpO7QQBma46QQSauBD2
 hpYg5Hza6vjtpZczQJmH+CApDu9BBwTUmTiFVrL9mUlJO60SD1vXOaSOCq4OGNLM2dWqx5M/ToV
 Im2sLBVn8WSb+Z7jM1orW/OsEd0dYmqVx8tnbv5G2E8pBQyW1EKxuBx2MElWUtHPyq1DEjYeR0s
 lYucUPsWgEUJ75jx5coFKhCuXJ02SoFODc6u2De+gYQBA3dI76WPziLv8s3laNFqiU1wnbWH6pu
 nWOyUgxoOIyKLTMEfW1eRqZyYIEm7IeL2Iba9t1WbDf3P
X-Google-Smtp-Source: AGHT+IG3KzGTlWjJYDmnmwZUwT3jqgug6r9Rgg0bim9ME2QCqwRycZ13ueUgzwRqHDJ5UOkULyA5xA==
X-Received: by 2002:a05:600c:154c:b0:45b:6269:d25b with SMTP id
 5b1f17b1804b1-45b67440939mr106240185e9.37.1756455006125; 
 Fri, 29 Aug 2025 01:10:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a5asm2348078f8f.55.2025.08.29.01.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:10:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B8BB5F80C;
 Fri, 29 Aug 2025 09:10:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Warner Losh <imp@bsdimp.com>,  Kyle Evans
 <kevans@freebsd.org>,  Laurent Vivier <laurent@vivier.eu>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] linux-user: Drop deprecated -p option
In-Reply-To: <20250828162012.3307647-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 28 Aug 2025 17:20:12 +0100")
References: <20250828162012.3307647-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 29 Aug 2025 09:10:04 +0100
Message-ID: <87qzwuy2eb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The user-mode '-p' option has been deprecated since 9.0 and
> doesn't do anything except emit a warning. We are well past
> our minimum deprecation period, so drop the option.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

