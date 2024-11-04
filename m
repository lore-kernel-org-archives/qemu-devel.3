Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F00D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpI-0007eo-UL; Sun, 03 Nov 2024 19:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpH-0007dO-1o; Sun, 03 Nov 2024 19:20:11 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpF-0002Ye-2Y; Sun, 03 Nov 2024 19:20:10 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so3037674b3a.1; 
 Sun, 03 Nov 2024 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679606; x=1731284406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glt8LdjLrhqs+rwJ3qBJ40uDOCd/SYRFndsslvUj3Qo=;
 b=e7tUrF+Q52uvw7cMVEF5goTVOdowC3ZywFTpgdaIZfC/lkPUIN++YedE93rhNfJJNs
 NEqbAvxFJ4Oe2eGNwtJvDKC17Aszwx8XF7r19D6PI7ZoPJCMFZmA1hYXkSPhouY1LFOc
 8jjqhxEd40pchyOB9z+FsJn1HiIE1RaKHIm+ARH20vh07KY4ZuPgCas/Is7TDNH104HI
 68qY3sx3k3LhOqsio6Lu9NH+qll+2WhkyAR0Zxd5hDjLk+Wf6S9WRQ7AHXaKkjjwXtPr
 22OAszDqG1C70SMVRDOwaUjC84Dcw4df1bZNEiEU2t584q5thvKf7PIgoXO+GhpiVxSw
 WPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679606; x=1731284406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glt8LdjLrhqs+rwJ3qBJ40uDOCd/SYRFndsslvUj3Qo=;
 b=H0aFbNOPJpgfiTjxZRZgsfW/onnPBMdgqbHpiMc0QWmPk68acTEAAXvecTm6QZtuCf
 27AqTug9v/7H+X3DAJQXu1XNk3zXyW1A6aAtjzAjniAVLMzJOwRD3gNj2Bs360romgn2
 Wn6dsII1Ix6nzLfc/+eJHBKO2vZ9yoKjQmaWrTrnLIdpWeAnnEVyTKDzzrXVQ7Tvu1w4
 VPMH1vF8Xp56oUxRh+WX58YtJXchWe7K6h3AIlHfJvX4Vc/Jn7dE1OCqpCrkRLxBBmvb
 si6PFtd3z0bYQg7oeZ5lrHKs2ilCv2FlgqzmnHeIbyPxGtjkav5NuXNY+PyNCuATymyJ
 o4IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcK0Rh9h4NbBdbuYPGqnPqX3pajVD4c+fwPBV4R7cGM3twgW+/TVFhZwhqOf1g6mk0IvZyLkW13Q==@nongnu.org,
 AJvYcCX06EVWI8mvvSmWHJAXydET/NqdLTHCi6k/+cTSzT4g5y2aBYi20iZ2bUHUWZ/UFNM+MOpJmPDOHHAeIsM=@nongnu.org
X-Gm-Message-State: AOJu0Yw4em0iWPXmJUPiaJjtSXkTAWIlRj7lxgKA1zqMz8UfVPpc4JUA
 Tt9ZMp5sb9jkN3qSGXWrXg7Q5NYd4uRdxSJNeeVhhRG+Qut9HxYEmqNeCw==
X-Google-Smtp-Source: AGHT+IHqBiSv3D12+d9LUbNDUkWhhS8Hs93BFr03tQIpSpdsTFcMYy2wjr6Zxmn9NlsTgi2dk1tUcg==
X-Received: by 2002:a05:6a21:478b:b0:1d9:278a:9ab with SMTP id
 adf61e73a8af0-1dba54a619dmr19411176637.35.1730679606420; 
 Sun, 03 Nov 2024 16:20:06 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 15/67] tests/tcg: Replace -mpower8-vector with -mcpu=power8
Date: Mon,  4 Nov 2024 10:18:04 +1000
Message-ID: <20241104001900.682660-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
2.45.2


