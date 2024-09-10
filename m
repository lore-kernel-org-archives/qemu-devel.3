Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6179ECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X0-0007g4-3J; Tue, 10 Sep 2024 10:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wy-0007Zo-Is
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:44 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wv-0006Uy-CD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:44 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a7596b7dfso23608466b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977260; x=1726582060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9b0lTkZojj9hYO/C00YAyDV7juvCe44sJPqhBOockE=;
 b=IP0zdsKXM8qmWnxqNvsEX8q72HmDyZ5gd27QDb+PUxbsyf+Bgx2ZTVRAIlEgSq2Bl+
 uFmicV5otAjQJYSjw8lBEUIx6DLLJ/OifYMI0p5nmOctXF/liE1tBBgvy4Ege4sAKCi+
 TJSnIPROO3elzi8sJxqvsfYWQX1IXNUb0lnIHFPGYIuTiaIqxVMkQOr+AiZIfNeE0yN9
 eY3jKEdjvmEbFs66DJ3ygfy6K7Uhb880B6LGE2QScb18xDJ4ggqrRcNCRP4aqXVQMFRg
 1S8laBR9vItebm+BiTKlWQER1lY9IgHPXkZ9GumD52Y1ZIgOYNjULo/GWOdKqsN8ACGZ
 nXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977260; x=1726582060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9b0lTkZojj9hYO/C00YAyDV7juvCe44sJPqhBOockE=;
 b=E44kCbGBEfaudqVKQf4hCWKPMIMHbxSQOUr99kL10wR8uIBLFuSNcKyGfDfBRSlf3e
 OfGnkld7szuL2fh1M4zsid7qWQKfDJf+0lI76xY23xRL7tnM3RF6HTUS84DRY5iej9pE
 wowkqSR67ke+HY5ZS40oZMe1QwSCXI9yD2rgH73/eeI6yTfER088+ZI0YQt0tIIRhFab
 c2A7+U7B7quH4zKyG9U1/XippJ4Z9UYzrmss0xe0YrcfpqMkpfERzyrLGuL8i3ioll4I
 1F79oWBgQzDLVx8330yGziPMWqAJLHvG47epG63Dtbc0slA4cUMxZSrD/A1voAO3mc4g
 TEkw==
X-Gm-Message-State: AOJu0Yy9V5AtohGhmORDIl7SOtyvVDvDS/CQ06xvfBeAt2kcSV0auDKr
 JeuLsyl0+4tNYtkKEwm43/D1aNONwHmfKG5TfiNj35WVOyhorZ8Fp8Gb44jfCgM=
X-Google-Smtp-Source: AGHT+IHd5sZIKfhBKo+JcT6B85aMNIPgLtx7UlLuykNO7OjlDo5LymBSdq2/3Yp5pWinJVXY0Rmn+A==
X-Received: by 2002:a17:907:25c6:b0:a8a:8dd3:f135 with SMTP id
 a640c23a62f3a-a8ffab79894mr108768366b.14.1725977259513; 
 Tue, 10 Sep 2024 07:07:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835a76sm487586366b.39.2024.09.10.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69F825FA11;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 08/26] tests/tcg/aarch64: Improve linker script organization
Date: Tue, 10 Sep 2024 15:07:15 +0100
Message-Id: <20240910140733.4007719-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Improve kernel.ld linker script organization by using MEMORY command.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240906143316.657436-5-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/kernel.ld | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 7b3a76dcbf..5f39258d32 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -1,23 +1,23 @@
 ENTRY(__start)
 
-SECTIONS
-{
-    /* virt machine, RAM starts at 1gb */
-    . = (1 << 30);
+MEMORY {
+    /* On virt machine RAM starts at 1 GiB. */
+
+    /* Align text and rodata to the 1st 2 MiB chunk. */
+    TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
+    /* Align r/w data to the 2nd 2 MiB chunk. */
+    DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
+}
+
+SECTIONS {
     .text : {
         *(.text)
-    }
-    .rodata : {
         *(.rodata)
-    }
-    /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    } >TXT
     .data : {
         *(.data)
-    }
-    .bss : {
         *(.bss)
-    }
+    } >DAT
     /DISCARD/ : {
         *(.ARM.attributes)
     }
-- 
2.39.2


