Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D1C3814E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPecA-0002KW-GQ; Fri, 05 Jul 2024 04:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebO-0000yZ-VU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebA-0004C5-R1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:34 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so29608866b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169238; x=1720774038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcTtzsKeBB4MlD0Q7gjS8cN5rY9ihom2n5xaHwaWlG4=;
 b=E6AjQ6/KC3wCia/eGNAZM4aTvg/WGIbN54MU4Aop0M58BW1I1MVXoGt0jRkT+Rb8ic
 AGTkjmsVvk8iQzQ33m1vx1os98kjombRNmequqjdYaZnIPhIIQAu58lhnk+TcxsAOJsz
 FtbnFodlf4WORp9VjR84pYV9q8ZJZdF1OGLXEoyfqM6dPdnKIdi56QfktvlEiEshYi6c
 EIZV9mEyNwA28YWH4mdloNHVYY6YgKhl2eBiQKJVWjTIvZIkmZvsqvHHLY0K7O6IS70l
 4hk1YBqiI/XoHBlgIppgZyWAdVX8beosZDmRY4VGaKIQ+WtcWYRjbRPtxtCB+lfLIzhB
 z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169238; x=1720774038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcTtzsKeBB4MlD0Q7gjS8cN5rY9ihom2n5xaHwaWlG4=;
 b=CJL8S2DQL752IDZVCQZZbE2jZh1sKfkfg21AJ4BxTblDUbrXcwlSAUwpO9UYSBYb0g
 uVz/FEETihBvSzBDHLkgukXgCIelJFMXS+b0RsYHxwRtUYAnjVT4ClG7arn+QEaiJjQJ
 YqjQv0ivefBjZbu9Cs8twuYmc7a00qo07nkOqobr9m+18OUSkvdvZfeIaXTjQ04mzbTP
 5HkNNRpue6YAwE0dPCQ28HoxrTmJWMOsKCIoPg03GqsWI8QKmOS07n8z7G/C72MMCHAC
 VHUoyXROZbfEu90N/3Ge/YNxCplgDaQxler7IpoM4shUV/YuU5qSHAh4DTxO1PqPChC9
 WPfQ==
X-Gm-Message-State: AOJu0Yx5gemF5UE2Wvz+20t/Q36+uWBq7geIxc4+WhXFLRF8w9kvlwwA
 1ldDuFcN0HwyDzI+6w++yJxB/QswGAcPcd72CF8w5DOre20ECkqoMlCurblnUmY=
X-Google-Smtp-Source: AGHT+IE42LIRsJmCP8FHhJ0bNVrRawiv6myytSeD1SwwYw2X9Vdn/RKT3wpeAQ8rRgqvAkoXWhhZ/Q==
X-Received: by 2002:a17:906:d1d2:b0:a77:cfe9:8ed5 with SMTP id
 a640c23a62f3a-a77cfe98f21mr73338466b.30.1720169237896; 
 Fri, 05 Jul 2024 01:47:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b033f3a3sm636125966b.187.2024.07.05.01.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ADC662107;
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
Subject: [PATCH v2 14/40] tests/tcg/arm: Drop -N from LDFLAGS
Date: Fri,  5 Jul 2024 09:40:21 +0100
Message-Id: <20240705084047.857176-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

This is redudant with a linker script, and is not
supported by clang.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-10-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.softmmu-target | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 39e01ce49d..547063c08c 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -13,7 +13,7 @@ VPATH 		+= $(ARM_SRC)
 test-armv6m-undef: test-armv6m-undef.S
 	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
 		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -N -static \
+		$< -o $@ -nostdlib -static \
 		-T $(ARM_SRC)/$@.ld
 
 run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
@@ -30,7 +30,7 @@ CRT_PATH=$(ARM_SRC)
 LINK_SCRIPT=$(ARM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib -N $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
-- 
2.39.2


