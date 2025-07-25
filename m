Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DE9C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcZ-0003jC-EK; Fri, 25 Jul 2025 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc7-0003Oj-4d
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc3-0002Va-Af
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:37 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso402166266b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458333; x=1754063133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hheeh9Xx9hzorxh/J/X7KgueFhsA9Hl1jTdEQCdFEQI=;
 b=gLBgmta8fQ4W/p0L30IIFet1McS4RAGtq+S/i6KNhISuowIV8zh6HuYiFRhhySD/JM
 C6V96nGAlji/wz4vGk+YYyGaw4hkTJWBAAuQK+hjZetNgp/5jQBXUHoGWNtzV0eZQ82Z
 3Q4HFjA5FOrLvmVp+LRbaqOp6GHgDIbgmjLpMEXO3JPR0foE54HBRDDlzde/JrEawpv9
 j87u7xjm5eiNSMMQnQkVNCB2Zrs17Bks/IKqNEsRT4ItEtoKsc73C21HeFvGGwhrHtgQ
 qVTH2NNxAxS8L38htUybDixeuSvdvP2xUt69YsXX8yu3h+YP6E1mLZD3xBfsCk4w0I7H
 G5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458333; x=1754063133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hheeh9Xx9hzorxh/J/X7KgueFhsA9Hl1jTdEQCdFEQI=;
 b=rQaUuk1o1/tRTB+ODEsEpbdf0MHSazzBewElFufdA6Cmh0IxQJS+8XfQLhIXySh7GS
 bLP+aIw0JBm005cp8YAPPexgi5OrbheLkQVvEYTBDZK4FETqzEy82QsH1DVvilTqL0G8
 AhUqsIbC79AtKNWx7Dg2tO461ZdXioMNcWgIDfGaIyA6uz4xKnWeF/VvHjuxnnUGN1zX
 SF3RG7VkBZoVgp/EnONb43b8OvC1sXBEETY1t0CQO5W3pyKi1i+ES65D5yZUILqAAPaj
 Gb7HGDwfNs0g1ItWYDldTwMkZ05PTUafnn48TBydR6NkNe4eoD59VHqt4oblc/L6go2M
 fR/Q==
X-Gm-Message-State: AOJu0YxbdTGYcj9v3xzjSwsg0p0rAcWjagNk27k11MrOLESZV8zHWdiw
 Q9EI1ZQoJnzbLUeg5s7ARFfCKW/yyzss3pE6yZ+FWc/ss/20eJY4D/SPTPAXMTDFtQs=
X-Gm-Gg: ASbGncuch2Ei+1kgwkHqG5lF6jN7497+olaSXirBYwgmzdVHrZH0fAoN+K8KpYed3CP
 exEmbtsyhNo09l7nhdN3ipNVEgzLFzJm8FPtJQYzUsXc+mbzDrIVlTTRnLEXXCQuKdP2P5pRnYO
 ccDcEZb8lm/r7QyiG1zdeW/8Cz2ypLknevqXA2cHZAAgegmq0pYq94Ejubi7PzG00yHkcGu1fIe
 JAoKG1wP6p/JuOWdRVppPjC6HKxx8N6znTHQL7k03u1CNh8j9nfwx+EgWbbIEIYTb/jef7DYRU1
 Mci+z2F/3Y7aq2zEz2cefDvRh3e/MMNidqwwU0ozErKBuqsZIb+iQPh034v7B0cVdc7s+gsA1Pj
 pNdbItcGnx5H30ufY+J2jgv4=
X-Google-Smtp-Source: AGHT+IG3kR2ipPy+qPBfa5bZA2no3zs7OW9Npw0ou3CnqJceZCc8HZ12IxsmV2ygqP3C59+yjvP8pA==
X-Received: by 2002:a17:906:4785:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-af4c1e266admr781863966b.6.1753458332753; 
 Fri, 25 Jul 2025 08:45:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af6358b052bsm10070366b.57.2025.07.25.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A22DC5F8E7;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 09/14] tests/tcg: don't include multiarch tests if
 not supported
Date: Fri, 25 Jul 2025 16:45:12 +0100
Message-ID: <20250725154517.3523095-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
---
 tests/tcg/Makefile.target                          | 6 ++++++
 tests/tcg/multiarch/system/Makefile.softmmu-target | 5 +++++
 2 files changed, 11 insertions(+)

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


