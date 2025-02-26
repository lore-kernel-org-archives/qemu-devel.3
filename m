Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4497C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1c-0001Ts-QS; Wed, 26 Feb 2025 09:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI12-00016y-RK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI10-0005k2-Pp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso59961515e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578637; x=1741183437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFWFW+6NZINw/m6MJHmphcH27lcvn4J7lC5PnXB+pFU=;
 b=I6p8pIubtOVnxywNO/PCIbwzhz4XKSey/Z0JkZE4pUR/3/6FnbjGsYgNzcySRKmZk2
 l+AjyS5z25UU+U0piA218WI1xleApIIwOpdPeaLadCJLTKAXI9dpEGH5ZAV9jTayi/Ea
 UUQrwovMYB3yHx3fu8SDtQuOg4E8rglkK80FGRT3nk5g3BGYK4TBAclSrooEgbLmLXCW
 CsYLj3XQiv52a4iWBQ/6Mg+vCYRbEw5EXicxiy9IY6y9zMh8aU97MUo0dt5/Fsud8OaA
 elY7uU8NaPtS2Zee6EAR6EzivR1SzfniSc8jLthFV1bvABXaDLZbAqkyswwJ47l0zyZL
 aKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578637; x=1741183437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFWFW+6NZINw/m6MJHmphcH27lcvn4J7lC5PnXB+pFU=;
 b=ifjb//gPIGSbK9QDHElfRXQq74qsRbZO9pcesDFeFb849SfQYwsQhb5VIP+TY4h1Y3
 WYxG5sWaI5bGG6Y/qWWcrZdPIxuqKt5D0SclFUw08ilQj+HhtLSg8NRGuul/GYLcy+2Q
 NvhLS9GZoh0huv0pF4K5G9tu6YAZLtv3Q0VikBn2lPYVuG/qR0epVsMIVbDbkPR6OCYc
 UcF+W0JRI8xlay47uHsffIXKbrM3YoZ9AVMeMUhxAQBQbMjKQbKGcDUuaECbXrVn5ZUJ
 aUF9/VigsDMQw/x9a5J8jCgeGdJrTR2p87sb3ypaUOdHj5COjeGbZipYrffOx5AjDinu
 IQAg==
X-Gm-Message-State: AOJu0YxCvOjIGv78liEDiTs5ylgCukEzXz+dAma4RFHjSWnk1RqrQsd1
 6dTiFPdLXD2WK9iW7kttu4HXsy5MsVIkrqglplz+GWrgWaQ4CB4gOwtA7CDNXxw=
X-Gm-Gg: ASbGncsYZMzVzv83vA4bYNULHiDaqcnhQ6zAxcpOUZTCWnAqsN0VvcUeveSj0nbfn5+
 rjofJ0nSdQlr8tCnRznrgrTHZHoQZmjVRjQkHJyH3q0v7eSkqZq8+RZrArLy0ioE0vpLcuvab4/
 mzCtp0lQDx5v7hU9xnbD9rW9gsyzCNEqg+a91am6bc88O3FYmjCM1HLB8Qt9pPkvGlw2hU7ks23
 TKEUhHdX4FeVNVMGxcu+x6WONGHkLIku8MrsOk+EsMEiGdkXbFvZiQghMQgQNUI+bw1F6PucxL3
 iGikU0FnAjpNlr+aKqLWAWjeuDVL
X-Google-Smtp-Source: AGHT+IGcdCq0tB08QxeQfbH5w4GggS22UnqKtdKDnlGcLyAdYb6uH4jtxUtcFfwjwrl+Umq0sa8jqQ==
X-Received: by 2002:a05:600c:4f0d:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43ab90155acmr28424875e9.19.1740578636993; 
 Wed, 26 Feb 2025 06:03:56 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab2cb1063sm33002425e9.2.2025.02.26.06.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E0DF603D2;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 11/25] tests/tcg: mark test-vma as a linux-only test
Date: Wed, 26 Feb 2025 14:03:29 +0000
Message-Id: <20250226140343.3907080-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


