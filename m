Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F8AC021B6
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASJ-0008S6-6J; Sun, 23 Feb 2025 06:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASF-0008QH-Ml; Sun, 23 Feb 2025 06:47:27 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASE-0005vm-6i; Sun, 23 Feb 2025 06:47:27 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso6455415a12.3; 
 Sun, 23 Feb 2025 03:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311243; x=1740916043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kr4LGBLlY45X+fTtppD0/lSbX42xqY9SsQCuy+Wnyto=;
 b=bIUaLMsV9BuT5Gx6CFdiyjdGY7a9s4bCkWUAzwyST604OdBsK+TDj5BAdfmbCrRFok
 upb9ZTVeWYmSSN+HUUOXwbArxYBUS4Qp3sINoqwOoPw4MlJsvz5pbbeC9zOjgHgHSEW6
 mb5Y6DAcbHPV3EtEMnBdmv2WwSfKZVZftg61cz/bXu6a/KczgIGPy8xF6u1gT3JMoN9a
 UvyGavToNx/UBO7OaPnw89DI7rJss5rX75Px2YhYB9+jj8hHl4hHIFUj5FcEuE3u3i4S
 DpwEPoM75xgsADJ+R0MrbToAgfSgc4ULH5mdoyngsW+l1DE/g4Z21sPQvlAMR/rdpNIE
 jlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311243; x=1740916043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr4LGBLlY45X+fTtppD0/lSbX42xqY9SsQCuy+Wnyto=;
 b=sWx1ag8oiUNhk7CLVaEq8uH/eyoUQKe9dkZj3F7vbII5bS05ezK3Smxq7jyas4t1k9
 LCCC+qDQU5AamxQP7GvZMhkmGmJspJbW+6TUBu6ydvopGTVv6H82ryFSiobpYfdMnxST
 79hs8ycBvTpFiSj0z89JJTjEtztpcxGrB/ppx04PsjCk0/iqckwyNTl7HIJ4zFwZzEaF
 zeBEZ8RvnAYgtk/OCjGaCk0iAt2li6yO9c3ubssg75ogrr0fm2VS7Z7J0d0NN/qjssNf
 YMqi6krtD0Fpx8GgNl7FRDB8UT2TrLH7QqYw5zbxHRu7nUtudlh9/4Z6GcahKhS5eAeh
 4qqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV14svS5zRJwvBqSb9QgfvjbqEZEYom/Mu0FWOBYHck7YfOMsgOh4+m9aw3tT3fAp8h2scOs/lt0Q==@nongnu.org
X-Gm-Message-State: AOJu0YyNAaSGu7WJKumuqjZGtVaw7cDYdrjkiX6pgI4MQ+88rgPOmxJL
 0qnFfoAg3Cx2n2O58vWCdF/lXcJ51YEgyOTod2NivEQPYfhLyUNqFpoHiw==
X-Gm-Gg: ASbGncu6Z8fCdiGKhovPPyNW8xga4mnnGpCTmZ0QlffUeC0lafn8TxgoiU3vu8uA+Bt
 2JW387n6Uy9tQ+OesTbZBmNv5gTZYJLw9bSbtQpMr02cLFll27XnqCqzX62wKvsb3aZqTe/H0yZ
 NXPbkEisAqMeVxpjbGc6Yn4ijFaWGypYwWXlNl65PFlv7D7XsI+u4hAUE9l4V0lFp//N+daPD6n
 zl1Ylut0Li2+QxzIr5rbXYyFGX5thtDyN8ffi/EhlkAgqYIo0bV36sfVkL1kXLsEZffk/68/pmb
 zdsgJ6zCM2Jak4tLMOniRhaNF7Jl8ZTD+xpWsVgzB9pLvZLfgTFae2TRjEvbf7hpud9cPCXCM7N
 y71qfM+KaWZXo
X-Google-Smtp-Source: AGHT+IEKi2CmLBwR+N0TisZKnNWu4xP3vISFNqEXQZb45/9fGZC5lqW+8pBC2qQSekFNQdg0jZmkKg==
X-Received: by 2002:a17:907:9801:b0:aba:6385:b46d with SMTP id
 a640c23a62f3a-abc09d37dadmr896947466b.50.1740311242966; 
 Sun, 23 Feb 2025 03:47:22 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/18] hw/gpio/pca955*: Move Kconfig switches next to
 implementations
Date: Sun, 23 Feb 2025 12:46:53 +0100
Message-ID: <20250223114708.1780-4-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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

The move of the Kconfig bits to hw/gpio is fixing a bug in 6328d8ffa6cb9d
("misc/pca955*: Move models under hw/gpio"), which moved the code but forgot to
move the Kconfig sections.

Fixes: 6328d8ffa6cb9d "misc/pca955*: Move models under hw/gpio"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/Kconfig | 8 ++++++++
 hw/misc/Kconfig | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index c423e10f59..a209294c20 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,6 +16,14 @@ config SIFIVE_GPIO
 config STM32L4X5_GPIO
     bool
 
+config PCA9552
+    bool
+    depends on I2C
+
+config PCA9554
+    bool
+    depends on I2C
+
 config PCF8574
     bool
     depends on I2C
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f9ce2f68c..4271e2f4ac 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,14 +30,6 @@ config EDU
     default y if TEST_DEVICES
     depends on PCI && MSI_NONBROKEN
 
-config PCA9552
-    bool
-    depends on I2C
-
-config PCA9554
-    bool
-    depends on I2C
-
 config I2C_ECHO
     bool
     default y if TEST_DEVICES
-- 
2.48.1


