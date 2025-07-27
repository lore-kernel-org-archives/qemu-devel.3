Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27464C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwpE-0002CK-NF; Sun, 27 Jul 2025 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwon-0001lo-9g
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:17 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwod-0000Cq-JE
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:09 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae401ebcbc4so551405266b.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605186; x=1754209986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7A/yYw4LUBPp0+haSiFGu0g5ThK058QpMamZZA8gaY=;
 b=TVeJ11hJPQJG/P3ER1BxqU6xb7MXqPE0tNcavGyQLiLCqx8ZjhCHZiRw42CI3mBgxe
 K9Fjr8exP4b5oBuaQTjgwBmfYY51FCWrRGqD2V5mTsEDOQ0xG3H7DNhPqiC8jY2DS7yk
 6MN2vggRWTonuSMfvWFUhh4hEB7T6mCLOKexq4RyUTWpQGhLgGp/eUrsjpl25bNaBQZK
 OD2AXHjr5hsBDzJP7IIAiA26zuNS7vk8TLMv57q5M9vo3YKQIEIDdsUNgJh7bmdEHwvB
 JFynUIrFnQUCIUy1A/xAlDySBIHVSD0dJqV/KX+hNrdBtqtxPgoMZ/tz3kYsStRu6WHu
 7OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605186; x=1754209986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7A/yYw4LUBPp0+haSiFGu0g5ThK058QpMamZZA8gaY=;
 b=uXTLVycpd8C8wuBZttoVols712nul8FFnQhaeCBjuSd3EAHEGmd5nZ01AxsyWMRhfR
 +kB14gLX+/6hVm+6Bxa9a6hdf9I7e0RkFFkuEa6NTPoRW2A9LrjFo7mXFwSeyIFxpMJN
 rNYUUzG1fgDiqrOJmEt1GOlOeUMdn9wDNMrL32lEnugk6ceddJcpu/FUjr2WnV8ARdrm
 +bH2L4+zdhyGgzi4DY/iFzHRCTc9LQVXuQzrCPA+o4MaZHA1r0fEtEdT+MwNdUeBxy1v
 KOfb5lhhv+FndgbDmQLGyAFrPADLzo9DD31QoYG9BQf/2jXen9hDzXXSkW3CZV3uhuIq
 MB9A==
X-Gm-Message-State: AOJu0YwHqUmL/dw8kd1cb9XSnQ+RY0/f2f+KiIesgxiQf6K4Wi8ptQtG
 eCWOe9HQyoiVBoCl7BZYqQyKRjTsuIz/GP/3nhNbY+y0dOrZsj+HSqsRE8wVGODK9dA=
X-Gm-Gg: ASbGnctQzXKecFt0+cOPVwOpTZXrNRZ8dOeMxcTski9QGYHevNCHJcRQ8WsuTvDnQW0
 4mBMuGSB6ki9idyvQXpA01HJWntMSqf0NDxu6Lv7XWlQLpjgkTLwo6CloxsnPqkYPi+3ak+5D5k
 wifqy0wZ9iJfXnQPXZA6lTjF3sZSkJFIxQHpoSu1Aj77BMtmnofxXbsNrLcYn3EDNXCBbHxBajr
 BV1VOuK8fLN/7W2TB4zn4aSe+Y6WXdR/d5vmZkfQKpxoCLB32SC0/3lKAQ3uge/EnP3yKyMsIWo
 /utDJIOw7fOhrtaQIH3wVa63F5wbTGwjqFoaUMvyslPikqQjLVoSHs5jnLHblhX3nZzMtcpWEAm
 zPvujkR2T1XNzDRvocC2J4SY=
X-Google-Smtp-Source: AGHT+IFNXLqoHmxHsHhCCf+TZUjf/jfIU12w/eK0Ykrf4HveCHiVSgsbr5LI/txymUFy2V+F0fD7jg==
X-Received: by 2002:a17:907:3f12:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-af617d0b1eamr986998766b.27.1753605185655; 
 Sun, 27 Jul 2025 01:33:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635b4a57dsm257809766b.147.2025.07.27.01.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E22165F8E7;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] tests/tcg: don't include multiarch tests if not supported
Date: Sun, 27 Jul 2025 09:32:48 +0100
Message-ID: <20250727083254.3826585-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

We are about to change the way the plugin runs are done and having
this included by default will complicate things.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-10-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 97ebe8f9bc9..a12b15637ea 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -127,8 +127,14 @@ else
 # build options for bare programs are usually pretty different. They
 # are expected to provide their own build recipes.
 EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
+
+# We skip the multiarch tests if the target hasn't provided a boot.S
+MULTIARCH_SOFTMMU_TARGETS = i386 alpha aarch64 arm loongarch64 s390x x86_64
+
+ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
+endif
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
 
 endif
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 07be001102b..5acf2700812 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -6,6 +6,11 @@
 # architecture to add to the test dependencies and deal with the
 # complications of building.
 #
+# To support the multiarch guests the target arch needs to provide a
+# boot.S that jumps to main and provides a __sys_outc functions.
+# Remember to update MULTIARCH_SOFTMMU_TARGETS in the tcg test
+# Makefile.target when this is done.
+#
 
 MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
 MULTIARCH_SYSTEM_SRC=$(MULTIARCH_SRC)/system
-- 
2.47.2


