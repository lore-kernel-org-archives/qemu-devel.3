Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FF7C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiN-0006dD-Bs; Tue, 04 Mar 2025 17:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah9-0005SV-Fn
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:07 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah3-0006Y8-IP
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:55 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abf3cf3d142so560515166b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127092; x=1741731892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuyU4RtfkAy5FahNVVdqaLuFf5A6JqdgckTnQGTYpas=;
 b=iScA6Wu3v6BkZNKj3kuwjituD0sCmEm8SpnGQz0fwETsT3RqvNBV9bdCEcLrBf9CVr
 oVxmJ8FzoWdpZs05lGER3dMwH6LtUgHaD/Ec+t7wNjNeP8IIbIQyJ3EliQzT/5fJLK6S
 KShn76e+He03svR1Sxp9kd8sKn9FyS1s5zxeucxHSX8unnaOmxTLt4KS3OKsnkOd07w8
 BLlhILoZsyCpQ9XGEzgzdw33JYhIKctuVtyzrErybOdFmo9lthTxZQX3bt+waX0TPmZ9
 JT6pMl82DOSUZ5iwu/iOvbzqhXNPT1pHgZtvw+hHvH1TIUWTymOR5Lpq2cAQYr1KmxDC
 lJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127092; x=1741731892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuyU4RtfkAy5FahNVVdqaLuFf5A6JqdgckTnQGTYpas=;
 b=deCZ5igRqYM1LkNMD/2IAGLtFVA+A+2jZNV2XRAXYjcerAUgAulbJdxn1i5+ymwN6J
 AxYsopd1j/sacxu2TG9uneB6eRAvYx9n7mAiCSTMXOvQJOtXz4PqJI1FmW7grLB2iDL4
 I6e0aQf/VGPeBzJLifpulAapRU6HIFKIAp8n7Jiey8f78K+sR+Fv4dH/vpaBgfK0Ew+h
 crEfj+NBrTfJ0deJSzrGuGmkTolCFg4x33nr+eckiIiKym+mNy6bDt3Jvy+4Dc23XHci
 bguCGm95/5oOEbT9bk6XCo/x7oolg/JprtuihY3reXiINYb/r7I7sLtvbMm112cQNM1z
 B0xw==
X-Gm-Message-State: AOJu0YxCDp0YERvedVkBWEIOtRQzEEue3i4E69t6SDifs35f6y7kObor
 kcmIFd2SXyzGuwOE5boclRPkSQlciZlPmmVGsociBnmjwMsYzu/YvYSPiBOQK3U=
X-Gm-Gg: ASbGncscrINrIwpbam08YmYPMVUnPtEr2DyEKnJOaC2mQ1guWPvtsMtGzpYHSpG9xfq
 ZVUa0rYqP1Zj3ig1ah0tZnQIHFcC9nmqFD1RhShPCRwv3pWzHl4NW2rVDIfO4XUWaYeZ7kunsdR
 UExLJSk+rtHZfDtAWoiv4G8DTdIuioezyIirgBDvfM4ZM5LyNpfKDu7JntN/AfEH9HjivhcWmSn
 9ClGsQEeGPQ9pdXe7N6qVdVMDgoMwMGT4qZXWQS6jvf+W5FY7kipO1JvlJcJ9ZnXLf0qwqjnphj
 cbC08irqWROWhYdUkIV7gIprAQeTpy0c9uphXLzdEE0IB0w=
X-Google-Smtp-Source: AGHT+IEVLCEN/rLy4cpvUeLBVb/6bdRMFtZpvRF2Uc9DK8BNd2cq3G13uMTgXXkEs1Qed2XBBtl3ew==
X-Received: by 2002:a05:6402:1e91:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5e59f39d009mr1618069a12.2.1741127091776; 
 Tue, 04 Mar 2025 14:24:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1ea7dd823sm234374866b.109.2025.03.04.14.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B70BB5FE31;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 13/32] tests/tcg: mark test-vma as a linux-only test
Date: Tue,  4 Mar 2025 22:24:20 +0000
Message-Id: <20250304222439.2035603-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

The main multiarch tests should compile for any POSIX system, however
test-vma's usage of MAP_NORESERVE makes it a linux-only test. Simply
moving the source file is enough for the build logic to skip on BSD's.

Message-Id: <20250226140343.3907080-12-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/{ => linux}/test-vma.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/multiarch/{ => linux}/test-vma.c (100%)

diff --git a/tests/tcg/multiarch/test-vma.c b/tests/tcg/multiarch/linux/test-vma.c
similarity index 100%
rename from tests/tcg/multiarch/test-vma.c
rename to tests/tcg/multiarch/linux/test-vma.c
-- 
2.39.5


