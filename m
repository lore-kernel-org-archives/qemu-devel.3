Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388AFC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2e-0000DZ-Ba; Wed, 02 Jul 2025 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2a-000068-1C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2W-00032I-97
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a522224582so3502376f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453406; x=1752058206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk0FNmkluSOyigMHJWnPKlXjmy4Hc5fY1wkF0CxDkc8=;
 b=lm7/ArpdIhfImUFzGEruT7daUs7M0ycSR456O5J9+LSziXXg6t2lPnT9+djQN6Asbs
 ARYqOd69TJ7UjNKaGkUIXmR9WcNP/oI1o7wfsnX5kYOHliH3slUWOeFydNwf1k/2mMHm
 qglUH/1HNCqQrq5qXmFuUbS8i8Rl24flWNgxRNDMzulhMwp5QS4yoNuUwYfF/SVcPT1a
 0NbKij7B/W5QXT9nnkPagCXaN17bpbbU6+06XxSUxwnUDw+OkHkFehBrwhzcP5e2QIEa
 oFz9jHcxT5NPg1M2QDSu1sO6K6ddUh9XWdGsJNZbCbpFGXTbMQ7F6D7q0nGWpTbLykNs
 f1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453406; x=1752058206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rk0FNmkluSOyigMHJWnPKlXjmy4Hc5fY1wkF0CxDkc8=;
 b=iin8r/AoaaQ3wN+lNLUn7beDPCfIAdK8rNpI7BJN+VkSxts2ViI2tkw+en7+TnO4Ww
 2DOfykl5YQRFziu2uFJjZn489fl2PLgJus+sGp8BCbTR8/ji9Iokf4YwWTDbsmSeG0Gb
 ZKXqGL1uRGDXnQUYmOSUJ0TdlVJuUCVPfUkqxGaeTBvTw3yb0M2UyFHxtyISsNs3+fBE
 WLj2bddre4eKYbYLyUcZao7Wzg2XZuNENjHorkOiuy1GBOl+vlDgjCXKbcHiZXiVNTXz
 PDVX7gsoXKq2ZWpDTDf8kDfdXB36VKYbfG2O+O3+EYfSeKqsOyVejtu8zixRAD7fO4rE
 iWnA==
X-Gm-Message-State: AOJu0Yz2ttRrAW3e/sqUMqR3EIGVYx9AziUC2Fo/aDqA3w3MDkfzDtwB
 2c1BbhqqQ0XjhHPbDD+Wi0mFwyLV6RaoZ04wItf1C/zRS7Wq6OwmWJ+3UVLmqJnEn3c=
X-Gm-Gg: ASbGncs/dxeAUvGiLa3fVwCB9mjJ+bQ7uy7qmwc6TLqc94z2cSSsWjGTc9aSsapYiJz
 T7Tv0KYia2V5pzwc6Emh+IIEEtnXcOCf9MdiJMdrptwchNOGuP4i3BnNNhFkMuJdG4B9jHppKM4
 l4xplLJXAaMYBfffSjbJgu4KrALo09b01pA03n/a1odyZtvtMp9WlvG2oUaS0WtlujkZKos7KOJ
 FixwL0+zDf1STPXnbpL5gklnUOgy3mhpgU+/xaPGWdInlnlWyZut6+Qc6NUOYS8D+AKZtqfgYG5
 cWrwphSin86dqD0Ai5ycT5Vsc+pYtIYI5+8o7aUzueia+L3n38WXTwCmZBkToDw=
X-Google-Smtp-Source: AGHT+IEA6NwdDoo5tr2dxfPFZgnFN2ppuvLwTIZBVQQh3e8R8+JsacxaEBn7SR0+Q+u9iy08/W18mA==
X-Received: by 2002:a05:6000:2d02:b0:3a5:1410:71c0 with SMTP id
 ffacd0b85a97d-3b2000b0826mr1262431f8f.38.1751453405856; 
 Wed, 02 Jul 2025 03:50:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b516sm15375280f8f.41.2025.07.02.03.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B65BF5F8F9;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 10/15] tests/tcg: Remove copy-pasted notes and from i386 and
 add x86_64 system tests to tests
Date: Wed,  2 Jul 2025 11:49:50 +0100
Message-ID: <20250702104955.3778269-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

The x86_64-softmmu Makefile seems to have been copy-pasted from the i386
Makefile at some point in the past. Cleaning up a vestigial unused
variable and removing some outdated comments.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-7-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-11-alex.bennee@linaro.org>

diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index ef6bcb4dc7..d3e09708a5 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -1,13 +1,11 @@
 #
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
+# x86_64 system tests
 #
 
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
 X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
+X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
+
+VPATH+=$(X64_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
@@ -18,7 +16,7 @@ LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
-TESTS+=$(MULTIARCH_TESTS)
+TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 # building head blobs
-- 
2.47.2


