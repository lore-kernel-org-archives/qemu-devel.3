Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B5FC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVT-0000jW-BS; Fri, 05 Jul 2024 04:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVB-00007t-MZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:12 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV4-0003Fi-69
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:09 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77c9d3e593so54847066b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168861; x=1720773661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZmaG2CChCOyc5PFSRDoUdccfXw50o6nOO/sLxGnTzs=;
 b=ke+RX4eT7CB4KrEl3t1jZstQnSltMnECh8kAEoz/ez+U97xm7bZLg2VVo4HK3Qhnhh
 7YifdZCbpV5SlArmXTroll2yk7tjP1d+HeunxmiYyn/Rqx0SU9jSvaKM23YWHX8ENM/+
 eNXfU81UIncjPykU5XYGgaDb8myrYXPsLkEvxu3KLZvz0pFGzYa9sxflSoZtY8TTw+Ak
 WpCaLQBTfyEruqFxMqqT0HpsijDSqh4AYPmv7r7fAOmCHhOSEDmZqpqVVlAPvq2GaDeN
 DdhZ3yObW/veUg0LVqQx8C0cuaDbWMrUZRzsx/Ab78GFssckURGMleDSOdZweevZlTsc
 D0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168861; x=1720773661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZmaG2CChCOyc5PFSRDoUdccfXw50o6nOO/sLxGnTzs=;
 b=HlsXofAxG5WGimWzQ2My1Abwwz06BlhUzBkj/mVo+DlQwxJwdqmtbZe+r8TfNFVKB/
 G56mgYuJbTl73Qiu1UjhCT4cO+fN5Ivlek9YX/aeRWz5HvfmEFXE6LZp8MRunYeghQis
 bpZMa2BbIq1T9zfW/UXYZEFNedW65GL28ZIJfwoW9YqeJs8M1rAWOg8Vd1gf2xOie0Wn
 iOcSoZR1lv1NGkjCpFY7MpQFwJmq6GeiosnKG59T0zOQMkG5Yggp1wSBjvyja8dC8t1b
 B5I/y5VbAQJBRMFC0lf7G+OXnKtUmaAmruOHrz/wsmyKqmEYaSYWxXAyHv4XczV/FwCr
 dGKQ==
X-Gm-Message-State: AOJu0YxoUY8eD9OlGCYha0hdpM+UMT42D6Crc10Choeui82Xu5YnKhx+
 YrRFsk6f/Ht4CvDxtHShO9V+BoGfqiOvSreRugfK5M7JE+PicGr9GBAfVbukDuE=
X-Google-Smtp-Source: AGHT+IH4YaGA3ScYPYfsLtQV4WtJ7voz4HJOvSoYLgpxmEBjTT5wWGNArU3sTYTQziSTSaBFGHKf9A==
X-Received: by 2002:a17:907:104a:b0:a6f:ab9c:7778 with SMTP id
 a640c23a62f3a-a77ba4c949bmr247996366b.34.1720168860336; 
 Fri, 05 Jul 2024 01:41:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0651easm662620666b.137.2024.07.05.01.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3122D5F876;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
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
Subject: [PATCH v2 15/40] tests/tcg/arm: Use -fno-integrated-as for
 test-arm-iwmmxt
Date: Fri,  5 Jul 2024 09:40:22 +0100
Message-Id: <20240705084047.857176-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Clang does not support IWMXT instructions.
Fall back to the external assembler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-11-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.target | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0a1965fce7..95f891bf8c 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,6 +8,11 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
+config-cc.mak: Makefile
+	$(quiet-@)( \
+	    $(call cc-option,-fno-integrated-as, CROSS_CC_HAS_FNIA)) 3> config-cc.mak
+-include config-cc.mak
+
 float_madds: CFLAGS+=-mfpu=neon-vfpv4
 
 # Basic Hello World
@@ -17,7 +22,8 @@ hello-arm: LDFLAGS+=-nostdlib
 
 # IWMXT floating point extensions
 ARM_TESTS += test-arm-iwmmxt
-test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
+# Clang assembler does not support IWMXT, so use the external assembler.
+test-arm-iwmmxt: CFLAGS += -marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16 $(CROSS_CC_HAS_FNIA)
 test-arm-iwmmxt: test-arm-iwmmxt.S
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
-- 
2.39.2


