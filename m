Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D669CC02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFe-000566-9Y; Tue, 14 Jan 2025 06:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFd-00055A-FQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFb-0005Ox-RS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso8967483a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854706; x=1737459506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi+ukBCOErHL45ERN6Ib1p4GgIF2LltQZlgS/5QMd38=;
 b=P0Vy8EKQn2DNVqUaENaXxrd4w37jYc+W8hpJUP/poGho6O447IMG/rc9TD1g/B3Wtv
 SbW6Gpf9NSAE0bpxggJHmYMOgjxB5hUIoaobWKEc477zOYCaMG8p50gdMs1sx0BxU4/L
 jqIhZA5qdpJ11OjmaegT3JXvgS3vbZMr19r/sWyiTS2BnjCbhUtTHpFoZwnmpG2b5wK9
 zSp6G1DAuksQ0Nd5vEk8mG1QQ1y4LdZqNuWJfR92Hbersv2XvjMIPNSE31EKhpdmDjx+
 Zncg+2FVvxduuDsVe3u86vF+elfRgS7w1l3oMfT81yWWyL/qkKVuSGt0Xrz0F8vHUxgf
 zfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854706; x=1737459506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi+ukBCOErHL45ERN6Ib1p4GgIF2LltQZlgS/5QMd38=;
 b=pJR4QNS4a/aGZBfhs+7mBNQMmKWrQHgJ91R9MvF2bUF1NL5tvjEjM91aMyUj7LWeap
 f42gChM74wh8lZQDT7xckGkX87CQDZLaH3pR0T8/A66P1SPKLBMMdUdjQrvRcuJYOFvv
 bZQN3jlbr7QkDcywAp4eRtz8iGpqMuh6aPvSWWiUTfW4vjDdDQ/v+SSA7Kd4Br/qveK0
 89dEmVM4Q8uliKMs15af6SrH6eg4gkwr/LZDo6eWW2GRwmxxVn7PYV66GZ0WnsKBWv9T
 XQtXJKt3dOd8wvGv4GoSNrnY9umV+EVp6gI/7WCKseeNHgZopdEY9RtQAMScfYqMm5Tk
 CnOQ==
X-Gm-Message-State: AOJu0Yxf6zDNeQSr/XaiU+V/qQuZpjBxRgVilOnpu73BRGUzsXx4kvWd
 /+LsTrD0Hbwju+lO/yNUoijWwpd/hbZkoFD9qDV+6cjfWtcBjUvY1ItyDSbilQE=
X-Gm-Gg: ASbGncs3lHgfe9HzbgTlDo3zt8WPjSbmY/k7zcpAtfkaBX8jLHEt2S6vqJhOuiJg0Tp
 XxYGVcY225OU+ZHUtO/UzxCIVLxLCzdUXIQxZLF3KpeNB7HvOSgEs/JisJO+Vl/nvfDt9xzAV/T
 zGs5vCoTFnQ4HMbdNf4042qTDXbduKeGLYgWVQi+0q5Fs+NcVZ6S2bq7kPutMuQ6FtBbjvNDyzG
 qhgbI08QcN9NLn1q1p/IInKhDZ9LQIvNHowIzDEJuKvRpob4A5XdFw=
X-Google-Smtp-Source: AGHT+IErM1tlIZTvq4ZNTn0gF3vXT/XwiZNqXiD6pGnxLcF7SPv/i3SsQtFz9nEYCbd2nxDHpHP0vA==
X-Received: by 2002:a05:6402:270d:b0:5d9:ad1:dafc with SMTP id
 4fb4d7f45d1cf-5d972e639famr55412470a12.25.1736854705994; 
 Tue, 14 Jan 2025 03:38:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90da8b2sm618578866b.44.2025.01.14.03.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 686115F945;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 07/37] semihosting/meson: Build config.o and console.o once
Date: Tue, 14 Jan 2025 11:37:51 +0000
Message-Id: <20250114113821.768750-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

config.c and console.c don't use any target specific
headers anymore, move them from specific_ss[] to
system_ss[] so they are built once, but will also be
linked once, removing global symbol clash in a single
QEMU binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/meson.build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 34933e5a19..86f5004bed 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -4,13 +4,16 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
 ))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'config.c',
-  'console.c',
   'uaccess.c',
 ))
 
 common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+  'config.c',
+  'console.c',
+), if_false: files(
+  'stubs-system.c',
+))
 
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.39.5


