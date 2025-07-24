Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271A0C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg6-0007b3-Ux; Thu, 24 Jul 2025 07:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg0-0007Qz-Uu
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:52 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfz-0007zL-8w
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:52 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60707b740a6so1344072a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354790; x=1753959590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWlT3FmdPmH54t5v80OARO557JNa+kkNhBDoMAfKoW0=;
 b=qb8VRkJg0YkSQYb0t8mR6VRaloBNBIAClBzOvSRPpW2AvKGmh8332DRJQPKWTGa0ha
 0Wf/N3HJOSEUrs3wsk8/k9/lQ0K640oP2o6tTlSx7OWkq1FSx6fm64BKfQFpZsZILMuA
 lgS3ReWpYlJsmvPu8BpdMsMf+sKRE0tRGdl0BBI7xeWnbw4lNnA0Ffqt5tEXfop4b2kU
 ukNfyN3vpfbqH0oPbapMUkYSzxZPZLYJuiuw0RUbqD+EwQwY9nPj+J/Puqhgif29wgZq
 UuBSIIqFx5ch5/Aghy2x/PGxi/AEDSOuxQs0b0jr3lUfDf5hm/3c8PaKCPQ0WCk2xstF
 pVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354790; x=1753959590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWlT3FmdPmH54t5v80OARO557JNa+kkNhBDoMAfKoW0=;
 b=S0xmWZgJW+bu8i0oPnCpjZYzAAT1ztUOSUKzStbbCOThthEOyAJWohEbmX+qgp0veZ
 Tw+RzsaslkuyY0pPj578/Oqf1JtMkqcqf957NB5Xc8qycC5H9V61qu2Lm+IGArkNdP5l
 ohVLWTP9KI6enaz2TcTYMfIFa//wz4IVm/8SaNmUBGsPA4AMscfnp1W9TLn6NP1jeRT0
 umwoqFjFNvtD7iogfeAjnHvo0uBDAu5Pyv8PYDxGfFcABpWe58vhiuakFJJhX/jcIqKa
 ACCviAlMTYqblyN29qMmTE/FEpTSfxHIvvLe61JNURkk7AESZ2nz2ii8vFpqkFItoWZN
 wVQQ==
X-Gm-Message-State: AOJu0YyKCnwkpxb8qG2rxc65mZRomSfRJKqmgyWzJe56iPeAG08KdlJX
 PRKVtzy8NDpCqUDClovCsb6cXUUfd34b2dfIVqC9Kk8Mw/MftxXt63j58tIgTI2qYn4=
X-Gm-Gg: ASbGncvyI5Ee1u+uydgxg27wqjICPrMg2vs7GH6h/Z6zJa0loiAeSBA3T5XYvPt6Kkj
 2byoYqf7R3Uw0QrmoQ8zyvRcTPedCWdseWBGFe7o2gGXg330dt9DuAaUnuF7GYS5jwIC/rzpOrP
 czKKB21yp//fuVpgJj8orKyk9ZxYo1jrxXeOM5gmNW4zu18WovFNNT+ztbYSSo97rtU6Jwhj3CR
 vW4jRSyzQbKgILUGnuuSJNAwv/rheCpMsdMLNs/jITZhyN1WEpFsGYLqda6YmZYof5bBa609jM+
 XIjUQQXBlwnx2J/11411HCX7ynFcetDJymXcO96mBfS8ZlgsWS8DLop0YF9dHIjcGq235huag2Y
 zIdvw7sbRYSY7q9A37UwcIu0=
X-Google-Smtp-Source: AGHT+IEUgoSpQUb8WqVztc6pvO2IIdMGYsXgeFVBfbK4tASHfHJfX+AJFeri/gOiAqzJEfv8DCMy7w==
X-Received: by 2002:a05:6402:42cf:b0:60c:3d54:4d17 with SMTP id
 4fb4d7f45d1cf-6149b5b229fmr5184055a12.21.1753354789610; 
 Thu, 24 Jul 2025 03:59:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd3362d6sm694045a12.60.2025.07.24.03.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B32835F8E7;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 09/13] tests/tcg: don't include multiarch tests if
 not supported
Date: Thu, 24 Jul 2025 11:59:35 +0100
Message-ID: <20250724105939.2393230-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
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

We are about to change the way the plugin runs are done and having
this included by default will complicate things.

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


