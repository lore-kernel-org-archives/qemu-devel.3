Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCEFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qeC-0001xR-2H; Tue, 30 Apr 2024 12:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s1qe9-0001ww-Lr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s1qe7-0005Mp-OY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34d0aa589a4so1645535f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714495677; x=1715100477; darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gkIQ267nvYf/ERCHKUNUMSvISDvAspB8i+k6G7ljsdc=;
 b=iOW+o5jXr+1pW8+CLu5FgRcwxJLmfS2EBDG4TtEd4UGuyAgBvPHtLQswq6Jo2riyD+
 c5WnLPgqq2jshrHToXfC8ZHwh2eEWxIqtIk3Ijly/gSScYeXTPLG5DJB0JlyFDjX82Z+
 d2ikJRuXtgXVmCw9jNWflKu7HKR/p8MRJfkeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495677; x=1715100477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkIQ267nvYf/ERCHKUNUMSvISDvAspB8i+k6G7ljsdc=;
 b=lVUpdbE3nr48wx1mTgXiDxSLiLTv5B0L/3WjfJxmgyLc50OQFoDsXFGfCmAi755Hhx
 8Lx7P/Lj1zJJ57iCNxZuLSa8Bw6Ywi+50OUR5GY6YsoSfYDhHgevMwQ04h8gucIiS6BX
 mIKAv4s9ozXt/quSIy55G4hv73HjYdRUwG8SF4MVeEOX3k+dB9g0SiS1Mu7bTwdv0rUl
 OyfeTIJSWndDg+6oKTKX87Q8w5UWd75HIzHMtjpFVPk89Ogc0ZUA+qhXpmiGW4Everei
 5HQg5/oxKCv2KSoXCWNa5Gb88mxIxWNGHttdwngxWpCyMQmROe0J9y5vSxfAlF0UKQPJ
 rRLQ==
X-Gm-Message-State: AOJu0YyqE2vSVYAhp+t/TQY+K+o+qawdu5nywEz3qzmegVNY11jVzAyu
 5vyjZN9m5Qa0TJr+TD5i1y+LCen6ataiogPOoVBOwZwjNogn7cO3yqHE/UQ2IsThjst4QQMMah+
 EyiM=
X-Google-Smtp-Source: AGHT+IFLG0YqlwzcSClbhqPLlhjBZMF7GsQGOQ2fItavzkqGjvdyFB4N89eUNoSUBYWDCeJSNQxS7w==
X-Received: by 2002:a5d:614f:0:b0:345:be70:191c with SMTP id
 y15-20020a5d614f000000b00345be70191cmr161859wrt.37.1714495676884; 
 Tue, 30 Apr 2024 09:47:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com
 ([176.201.29.105]) by smtp.gmail.com with ESMTPSA id
 d24-20020adfa418000000b0034ca8cdc594sm9057503wra.76.2024.04.30.09.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:47:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, michael@amarulasolutions.com,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h is
 missing
Date: Tue, 30 Apr 2024 18:47:52 +0200
Message-ID: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=dario.binacchi@amarulasolutions.com;
 helo=mail-wr1-x431.google.com
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

The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
always provided by the libc (uClibc). The patch disables its compilation
in case the header is not available.

The patch is based on a suggestion from Paolo Bonzini, which you can
find at the following link.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2021-03/msg00492.html
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 tests/fp/meson.build | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 114b4b483ea7..0e1237be54ed 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -126,12 +126,14 @@ test('fp-test-mulAdd', fptest,
            ['f16_mulAdd', 'f32_mulAdd', 'f64_mulAdd', 'f128_mulAdd'],
      suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'], timeout: 180)
 
-executable(
-  'fp-bench',
-  ['fp-bench.c', '../../fpu/softfloat.c'],
-  dependencies: [qemuutil, libtestfloat, libsoftfloat],
-  c_args: fpcflags,
-)
+if cc.has_header('fenv.h')
+  executable(
+    'fp-bench',
+    ['fp-bench.c', '../../fpu/softfloat.c'],
+    dependencies: [qemuutil, libtestfloat, libsoftfloat],
+    c_args: fpcflags,
+  )
+endif
 
 fptestlog2 = executable(
   'fp-test-log2',
-- 
2.43.0


