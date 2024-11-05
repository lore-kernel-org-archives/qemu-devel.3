Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE31D2C11B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L6N-0000rX-Br; Tue, 05 Nov 2024 10:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L64-0000qH-Ns
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:04:00 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L61-0000rx-VP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:03:55 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539e63c8678so6341206e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730819032; x=1731423832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYHCRBRNBPe/0uEKc6Z5yhuwEHOYnf7f6KwnFwUGwXc=;
 b=hesJf0YHdpm2v5OKr3xFaOTvd4cTajDt/iMA7AS0XNsKnT/DS6HCb5TO97ui1Li3pJ
 kedEgvzwxSZ3oRz9hRLPXUqthYTG5JlS26dNwrZ2zEKh/UcjIx8rbfhIkA1uBYa5c/+N
 FLD4r89JO+Z1NK7pdNh+Ugjjl5QgU2Xfaw1BRRobVkHCAEgJcaC/AzQdO6aMtzHvMiQG
 wanLw5Rq1Y4cT0DOdqrH4UaJdbdtAFtbNgnH49GB1ADL97fV3b7g9ZMSrucSvUwk6R6C
 4ONaNf6LZm1DrT8O1e88cyCj2macncv99mSd69hB6xBmzZy7f1Sg7sLnG/XtziSQLoGe
 m3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819032; x=1731423832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYHCRBRNBPe/0uEKc6Z5yhuwEHOYnf7f6KwnFwUGwXc=;
 b=NB4B1JStJsvTdDvNzn6+j6tNebk430cCMDcAWZBdR2YKqg4bU0fW+15U0E0e61uIqA
 X5ZZVvypDkGP5jUpF20ezExlzkDcxIvpBBKwooib5SxaNk822HQVTshgrRJ6ezwXokx9
 KkZKk1uaUSEzL5bOOHsQM4NePNO4jF3f6tPYmIAti34PZA+PQ9oL/pSCNBGLrUUMBusL
 wlSRjxIX8P7O47WcznVinqNRPqnlgYEFHtt5sR4pgCuaJy/CSMEpCz7zgaR/squIi7oT
 LqUHB2YSyS6lvOWHkwhElWtMHzJN0VcCXUmdIjwl7384Wz5Ieof9fDLxsBPD5jJjLQNr
 1eKw==
X-Gm-Message-State: AOJu0YzpkSKdq4+tWzr0vXF00io7kCbXC33N4FNUYDs1HeoYgS19Q7BE
 Yq6WiuBfHuTszYfzCbJdkMvy3MKY7wXagsdpPdWRVAlgzDFxDBZEm5Jg2lRdThL9JEUUxuyiLCU
 5HU8=
X-Google-Smtp-Source: AGHT+IGEghE20/vby/4+//YPJp4pUPdoQnEKHqrf5JRzphuz685udHkBdfw1oJxcloO2xNzryvpYKg==
X-Received: by 2002:a05:6512:2243:b0:53b:1f7a:9bfd with SMTP id
 2adb3069b0e04-53d65e17196mr8140531e87.52.1730819031889; 
 Tue, 05 Nov 2024 07:03:51 -0800 (PST)
Received: from stoup.. ([154.14.63.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca6f8sm221301855e9.39.2024.11.05.07.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:03:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/4] tests/tcg: Replace -mpower8-vector with -mcpu=power8
Date: Tue,  5 Nov 2024 15:03:45 +0000
Message-ID: <20241105150348.446982-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241105150348.446982-1-richard.henderson@linaro.org>
References: <20241105150348.446982-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

[1] deprecated -mpower8-vector, resulting in:

    powerpc64-linux-gnu-gcc: warning: switch '-mpower8-vector' is no longer supported
    qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error: expected ';' before 'float'
        4 | typedef vector float vsx_float32_vec_t;
          |               ^~~~~~

Use -mcpu=power8 instead. In order to properly verify that this works,
one needs a big-endian (the minimum supported CPU for 64-bit
little-endian is power8 anyway) GCC configured with --enable-checking
(see GCC commit e154242724b0 ("[RS6000] Don't pass -many to the
assembler").

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109987

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241023131250.48510-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/ppc64/Makefile.target | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 1940886c73..0d058b2600 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -6,7 +6,7 @@ VPATH += $(SRC_PATH)/tests/tcg/ppc64
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
-	    $(call cc-option,-mpower8-vector,   CROSS_CC_HAS_POWER8_VECTOR); \
+	    $(call cc-option,-mcpu=power8,      CROSS_CC_HAS_CPU_POWER8); \
 	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak
 
 -include config-cc.mak
@@ -23,15 +23,15 @@ run-threadcount: threadcount
 run-plugin-threadcount-with-%:
 	$(call skip-test, $<, "BROKEN (flaky with clang) ")
 
-ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
+ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
 PPC64_TESTS=bcdsub non_signalling_xscv
 endif
-$(PPC64_TESTS): CFLAGS += -mpower8-vector
+$(PPC64_TESTS): CFLAGS += -mcpu=power8
 
-ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
+ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
 PPC64_TESTS += vsx_f2i_nan
 endif
-vsx_f2i_nan: CFLAGS += -mpower8-vector -I$(SRC_PATH)/include
+vsx_f2i_nan: CFLAGS += -mcpu=power8 -I$(SRC_PATH)/include
 
 PPC64_TESTS += mtfsf
 PPC64_TESTS += mffsce
-- 
2.43.0


