Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555A4C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVN-0000Fa-P1; Fri, 05 Jul 2024 04:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV6-000055-Ub
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUz-0003Dy-1n
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:03 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77bf336171so193699366b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168856; x=1720773656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn4+e2+s4PmF4hbnzvZLoM3JOdLV8P43Drx86Z36Eh4=;
 b=WH79K5jt5VijLPJ9rYTfQ5s3rHxsY5YmItTG25tjZADPX6gA53NJU/UVlaQiiJVT6K
 L5GhlTaSfKPrjXNNHmCZVXsX8bnJCYDine826jncIsvFZm3uKtIRL8EsTWOzoAQyCLBb
 bkBrL/LiwvgXYM2We3f/6LBCVskQXZHSrUU3ORIHYrdevWWXzRPdYEz0mFS7uOcqS/Cg
 +y2cT1zPwf+qCdrXRa5dgQLsluMGWgkPvzT9DScis7NrJPVMf2/daI16DIKnJkVd9kEW
 WsXJLP2ROK6N6dyvJ2aSAA0LLOYbgbhDqamm3yI1f/LpnrN+lPg0nOtsUhspeTN7ryEF
 32rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168856; x=1720773656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gn4+e2+s4PmF4hbnzvZLoM3JOdLV8P43Drx86Z36Eh4=;
 b=q9ix/iJI3USz6Gxr13cobukTH4yz2BU+bow/X+nVgC4fu4Cq8zpYiWrt3Xk9ttztM2
 KHK2YVWAe2fLdEnivxaoUvHNlZGvD9Gal8L8bL2pTspBKp5QvzR3U6gXFsPZlCGMON0G
 PgIVpyQox2GB2RVpaK+n+eKdTlLecZqOiBXbgn+GchQqzHL7VHom8UpaqkY/xpc9b+iy
 vFqawCswpbsNuGyUPxq8FsID/cU0uKE8LZtSHFFV8n19P2K3hqc1mmReIiREuS3bJk5E
 NZhOninMfldLiOxdj7ykOGiu7HWy/ME56KPMustf411KlT+9QfmticV3Pm/ckn1rbWL9
 LreA==
X-Gm-Message-State: AOJu0Yz9q76A8V9fTcZjyd0egJnX3xn6wIGPdzSKt+ktvWP3ETfBoZOh
 lce4bc7pPJBFSxdMJmw6u49dLBiBkwn04MXt5eBK9R1HgCMXjgRm6e7KPxW5ru0=
X-Google-Smtp-Source: AGHT+IHTYlUK1n7yHNtv5mm3fMcB/Kv3tpsapVRqNhoYCZNR1AFm2JCeHFCr1OeKJeAx8f4QU7MDOQ==
X-Received: by 2002:a17:906:f8d4:b0:a77:ba4d:a4ea with SMTP id
 a640c23a62f3a-a77bda09b81mr283728566b.23.1720168855376; 
 Fri, 05 Jul 2024 01:40:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a76841c4ffcsm261248866b.41.2024.07.05.01.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BE075F9EB;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 07/40] tests/tcg: Adjust variable defintion from cc-option
Date: Fri,  5 Jul 2024 09:40:14 +0100
Message-Id: <20240705084047.857176-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Define the variable to the compiler flag used, not "y".
This avoids replication of the compiler flag itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-3-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target                 |  2 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +-
 tests/tcg/aarch64/Makefile.target         | 15 ++++++++-------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index f21be50d3b..cb8cfeb6da 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -49,7 +49,7 @@ quiet-command = $(call quiet-@,$2,$3)$1
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>&1
 cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "$(strip $2)=y" >&3; else \
+    echo "$(TARGET_PREFIX)$1 detected" && echo "$(strip $2)=$(strip $1)" >&3; else \
     echo "$(TARGET_PREFIX)$1 not detected"; fi
 
 # $1 = test name, $2 = cmd, $3 = desc
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 4b03ef602e..39d3f961c5 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -81,7 +81,7 @@ run-memory-replay: memory-replay run-memory-record
 EXTRA_RUNS+=run-memory-replay
 
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += -march=armv8.3-a
+pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
 else
 pauth-3:
 	$(call skip-test, "BUILD of $@", "missing compiler support")
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 4ecbca6a41..11ccde5579 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -32,17 +32,17 @@ config-cc.mak: Makefile
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
 AARCH64_TESTS += dcpop
-dcpop: CFLAGS += -march=armv8.2-a
+dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
 endif
 ifneq ($(CROSS_CC_HAS_ARMV8_5),)
 AARCH64_TESTS += dcpodp
-dcpodp: CFLAGS += -march=armv8.5-a
+dcpodp: CFLAGS += $(CROSS_CC_HAS_ARMV8_5)
 endif
 
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
-pauth-%: CFLAGS += -march=armv8.3-a
+pauth-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
 test-2375: CFLAGS += -march=armv8.3-a
 run-pauth-1: QEMU_OPTS += -cpu max
 run-pauth-2: QEMU_OPTS += -cpu max
@@ -55,7 +55,7 @@ endif
 # bti-1 tests the elf notes, so we require special compiler support.
 ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
 AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -fno-stack-protector -mbranch-protection=standard
+bti-1 bti-3: CFLAGS += -fno-stack-protector $(CROSS_CC_HAS_ARMV8_BTI)
 bti-1 bti-3: LDFLAGS += -nostdlib
 endif
 # bti-2 tests PROT_BTI, so no special compiler support required.
@@ -64,12 +64,13 @@ AARCH64_TESTS += bti-2
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
-mte-%: CFLAGS += -march=armv8.5-a+memtag
+mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
 endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
 AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
+sme-outprod1 sme-smopa-1 sme-smopa-2: CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # System Registers Tests
@@ -99,7 +100,7 @@ TESTS += sha512-vector
 ifneq ($(CROSS_CC_HAS_SVE),)
 # SVE ioctl test
 AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
+sve-ioctls: CFLAGS += $(CROSS_CC_HAS_SVE)
 
 sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
 sha512-sve: sha512.c
@@ -134,7 +135,7 @@ endif
 
 ifneq ($(CROSS_CC_HAS_SVE2),)
 AARCH64_TESTS += test-826
-test-826: CFLAGS+=-march=armv8.1-a+sve2
+test-826: CFLAGS += $(CROSS_CC_HAS_SVE2)
 endif
 
 TESTS += $(AARCH64_TESTS)
-- 
2.39.2


