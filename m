Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3980CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ref42-000642-HO; Mon, 26 Feb 2024 12:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ref3v-000601-6I
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:46:51 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ref3t-0000VO-OY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:46:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412a9a61545so2979675e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969603; x=1709574403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/iX7CVh0CvYZYKZo+EQYkcaTBYd6mrWc2+etueIh3hU=;
 b=xLeu3gy2aLqQiw2WQeiqX6MYHD73ied/wQKujA5VWZy1936QngM643+M9Uf+t/HBH7
 hrh9Xkgjq13ZNFrsdy5cU5YAoqgi0146uQNfuES8Kocj7Goia94Mj2YZXpv22gOUEzm7
 hwqsh4TiEz3t7bTZe+CpAJdJVJ40Ks+Ekpav5VuHWvwZ64WXeeQszo/yvJ92r37BGWz0
 zTJgGwKzevaHC7/mxIvMw3G9pvKZjAuXfXCsQx9FWqEL/3bZRcEpeUaT6BblbXoFqrq+
 cyuF79d5SsgO2Woz7kz8K6QFJLVhogjAYY0293SK9NddnoSX8+yuHmhSmWkzox8TTKew
 9XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969603; x=1709574403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/iX7CVh0CvYZYKZo+EQYkcaTBYd6mrWc2+etueIh3hU=;
 b=sCsJFJiHOzr6XlphBVPc1YE4605thyQ7iAGZFoErRGrrPRbmvd1Dkq0l/j0xsyDPss
 0Zzz3oyZYRYkYQawtzOJynL7KMvr0oA/Uqz522olWhkHmFtggZ82InJAKgT5PUQHOMAp
 2p/lv6A0XVuX+ozfAdVLmo3Kx9eFQidhiTLoq9nLi8tWluOAeV1Sy6XbRIyyZ6DKeebC
 xLOJDUIlI0igWqrd84Ac38szhkp18J+EFqw0uc82Yf8ODkQVWu4ceHmKeJfkmxMt/02n
 d8Az1uccERpvcCY9RizeOmSM3s61IAMwB5P/bfzUi6XvEYIo5XJIwIG3uRYDCTC6sGNo
 IskA==
X-Gm-Message-State: AOJu0YwFxiZrb3uK32j4f2jQuqfRfgw8v8a5CZjmHNAs9pLCnYWE4Nbe
 nX3J8dL5mTh8C+2+KJrbWhkkt5QlskI92em5FoZJHlJG+LDo0ru+vH7oSmWtbnM=
X-Google-Smtp-Source: AGHT+IGmzCPlNV5Spu5v62qqkG07c1CUJ6NOnboatvoYo5zbdGrXOFjUbTQTb7xC7PlFVMLBY7lfuQ==
X-Received: by 2002:a05:600c:35cb:b0:412:a1c1:207c with SMTP id
 r11-20020a05600c35cb00b00412a1c1207cmr3045480wmq.3.1708969603385; 
 Mon, 26 Feb 2024 09:46:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hi17-20020a05600c535100b0041290251dc2sm12361306wmb.14.2024.02.26.09.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:46:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 666AB5F753;
 Mon, 26 Feb 2024 17:46:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] tests/vm: avoid re-building the VM images all the time
Date: Mon, 26 Feb 2024 17:46:39 +0000
Message-Id: <20240226174639.438987-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There are two problems.

The first is a .PHONY target will always evaluate which triggers a
full re-build of the VM images. Drop the requirement knowing that this
introduces a manual step on freshly configure build dirs.

The second is a minor unrelated tweak to the Makefile also triggers an
expensive full re-build. Solve this be avoiding the dependency and
putting a comment just above the bit that matters and hope developers
notice the comment.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---

This is hacky and sub-optimal. There surely must be a way to have our cake
and eat it?
---
 tests/vm/Makefile.include | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index bf12e0fa3c5..a109773c588 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -88,10 +88,11 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
 vm-clean-all:
 	rm -f $(IMAGE_FILES)
 
+# Rebuilding the VMs every time this Makefile is tweaked is very
+# expensive for most users. If you tweak the recipe bellow you will
+# need to manually zap $(IMAGES_DIR)/%.img to rebuild.
 $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
-			$(SRC_PATH)/tests/vm/basevm.py \
-			$(SRC_PATH)/tests/vm/Makefile.include \
-			$(VM_VENV)
+			$(SRC_PATH)/tests/vm/basevm.py
 	@mkdir -p $(IMAGES_DIR)
 	$(call quiet-command, \
 		$(VM_PYTHON) $< \
-- 
2.39.2


