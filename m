Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1825C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzoA-0003Lt-5t; Wed, 16 Jul 2025 06:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmJ-0007ok-CX
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:23 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmG-0002Th-Uy
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:23 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso1042405766b.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663259; x=1753268059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KVF2ZS8Wkb+tDxBdS/SYtogmTbLC9pawdzdVe4S6bc=;
 b=FmqIWvYdCmVdlINtqAQfWGsHN/x0ChaJfhEHuclK8n1+BfpegyIR+rqqEmrlHhD73I
 abxoDcKTchYFlPyrwwd/jo0W2/VO90HPnrxfxdA7Kb4cIrtMFshPoCiQ4Do7rGmsVziX
 8xNMlvzXzGsB9E861V5nwgH5+0y8InITi5czu03MqiGHERi/dhwjs/6OoLK9KEGq7uwD
 HtrXNjKXz6s6ZzWwZ4HzIK0TebpPPn7RI2a6UVnqXL5LWwYJ0CDqAiznaEkDZ5/fG3Wo
 9xeyaVEjrGK1uVEypq0m3KsD3STdG7bux65AUkThwWKbyAo5EOnDN+juQipAuOT5Wgbz
 XXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663259; x=1753268059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KVF2ZS8Wkb+tDxBdS/SYtogmTbLC9pawdzdVe4S6bc=;
 b=r+r6RMotDT/guGi4E0K9LiVLqw+zmP6UWXTHvys8pXHwgLnb5xQJrvBG5b0X3RlKhR
 CagXHy1s+eyxdz5yxV98U8YEvWysKCu5X333lhgHWmBQM8wfAgO/uGFDOaNRwhTX2L7s
 x/QQeF4qRF7Kc/5hgf3nUZ+5Yuof1cqRgJajbSWIRLkiAfTW7+Cdp68jHV9PsGrnpyfq
 ickTOEf0igQYWCusucWRR76ore0Ptny+dFYI2clMcobJJ5w4yJFQl3xP2artXYwF/B/K
 bXSSQUrLLLOiRFCNcJ3bfNt5I7kEIlgMEsNO3WvcBsFfl1km2c0v4K4YggYnoZYlQsq7
 +MYQ==
X-Gm-Message-State: AOJu0Yw7dr3eNdTghw+dqcYvjqlKNg3ZHwnhA/SaHhvQUfmdjYF3/xpz
 FHzpSFRGlXGvCH7mlP5XLPzkfmYSK06zOZuKp43tVGxsdqJ7c9vPPvWnfePhRJDZIq4=
X-Gm-Gg: ASbGncsphhcVqOa1e326EQsBbDgj0Y1NiqoPhTwydvv5uRAcBd9b5Gyg/JtulB4J2AK
 MdLXDbN/+18zRLMIuoFEHHIlNPpHrxPnAlHD/Kg0SM+wccFe+b+PXOA02oiUc82Q12buPDOc9/J
 duFuBMsuVIDLHmpXVOqMkd4YBfi8yH9Z/zb0jAYFieI2JXMLZUI+v/appDLVkSJLYuqEIdzY4AR
 E9atx6kAamaGRh6AH8FJi4W0u7VS3/7T0GTlakuIJG3eA7t0phc5tUzeALwbUXb+p1rmM7vi0mX
 jriI4r2Nic0Oxqk1uyHgxethvOSuIakHZGbcKyZThOhozBKMZXhPXYIKBIPBZpDeIC94pc2eNkw
 5od4IhDrO3FF65AyqOLQFj2g=
X-Google-Smtp-Source: AGHT+IFKVUiHKcxQm7WpbJ6MpswO7uRC79JMoCi4tNDrOyUPQM71tX95HBagG8dSQjrsKG0msFkQuA==
X-Received: by 2002:a17:907:8692:b0:ae3:5185:541a with SMTP id
 a640c23a62f3a-ae9ce19fdcemr223484266b.54.1752663259212; 
 Wed, 16 Jul 2025 03:54:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8291bb2sm1163863666b.113.2025.07.16.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1753F5F89A;
 Wed, 16 Jul 2025 11:54:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 2/6] tests/tcg: special case sparc32plus test cases
Date: Wed, 16 Jul 2025 11:54:10 +0100
Message-ID: <20250716105414.2330204-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We can re-use the sparc Makefile to ensure we build but don't run the
tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 2 +-
 tests/tcg/sparc32plus     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 120000 tests/tcg/sparc32plus

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8bcafaaf7b..bc5d2cdeeb 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -106,7 +106,7 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # architecture in its VPATH. However some targets are so
 # minimal/broken just include directly and skip the common multiarch
 # tests Makefile.
-ifeq ($(filter $(TARGET_NAME),aarch64_be sparc),$(TARGET_NAME))
+ifeq ($(filter $(TARGET_NAME),aarch64_be sparc sparc32plus),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
diff --git a/tests/tcg/sparc32plus b/tests/tcg/sparc32plus
new file mode 120000
index 0000000000..af551a9571
--- /dev/null
+++ b/tests/tcg/sparc32plus
@@ -0,0 +1 @@
+sparc
\ No newline at end of file
-- 
2.47.2


