Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE2CC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG1J-0006yd-Ct; Tue, 08 Jul 2025 17:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEj-0006w9-F5; Tue, 08 Jul 2025 16:48:23 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEg-00030s-13; Tue, 08 Jul 2025 16:48:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso9352436a12.0; 
 Tue, 08 Jul 2025 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752007695; x=1752612495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxDzbC3+dod/Dyop0Reaz9nyV0vyvHAmdIBbxAEj8z8=;
 b=OgiT4LWSl0iVdNON3nveGRUS0NsTRUlVTKQN/ETufGphnx7LvXrwIVOGCBp8mKkCyp
 mZWlKbv4KZsPEMn/Wmv8MQggSpprW9ofRuMyXwVxXE0TJN0m8e5HSdHXCUjhI3bpURVO
 7cQ2KwXYvPVa8tz2vzJpERS91Oygp8aJJxVCWWVgjUmByX2Kwa9PhUy7QqCg1jA+PK2H
 u9+SOi3Pfd63EGgW3wjOxUSa7cxP63w6RweTjQ4FjN6Auu3vapVQngJQ/aQbuEJclcxH
 puR5jHMzdSzSf+1jG9WQjT7+CHU/kNQvc+9xkPNuk1LfucZnWz1r1+SWJg0dgWjTARXU
 z96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007695; x=1752612495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxDzbC3+dod/Dyop0Reaz9nyV0vyvHAmdIBbxAEj8z8=;
 b=ACKsUAslItcOkGkYvyPLOO+a3ezBhmA4EA3f1pRgUf4z98YR9Grw/Ihp89z7IQYxmf
 vqRB1T9hzdU9MUrnx3gjqQJNqBdwTiv+BnQKE6cx29WpvOWwg86IvbRLYWcyGi2AEMvU
 87KPdat2IykddF89Lwr6hryZCM1j4b3hOlbK0P0xaAwF7oNZB8V7fckU/0rrEZ/EXw3M
 UBY7jvTYHlyVgWjCiaVShwlcC75j/ED6al2K77UhrahaBC+Xi95pmuARxHoPgG3sUPeC
 ZQhJnS2gM0ItsBBQeDypgn2FV0ejOxAMmV9/m6Y4FNipQfRxJIxTJtgL7U/ZvncM7Ntq
 Wnxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXGbQIZbrSmXGkSIX13IbAWJjk88iAcP6NFB5/VXzqihDSAwI5d/whHMWjAxfiV93bR/jAFxgBaJE=@nongnu.org,
 AJvYcCVOJQ4TKeZYDHvUwkwjfXRLJCHC1GNTKBK5b0MhRWNQHV8m2GjzIrUciXLdfhPKPplM2GsOJLlLpw==@nongnu.org
X-Gm-Message-State: AOJu0YxYR+3zRVMX72ixCAvzwkwsu8feUHG699QJ7xncMj0j+8q62rOO
 +rBLH45asEQOQSmxj34HATDZpU+xUF+ltn/ervibtsWmzBP1WcMv9jLH7R/oSQ==
X-Gm-Gg: ASbGncvWP7aiVnrPWvhS1OkU641iaaf5poFSwdBmT4Vj+l96f+SwL4ac0sgJad9Ruhn
 R1Rn7QY6WRWcPnat7h2AeJHxaOYOzJdQ5jf8tnIQxVGHMsVaCg0dYtcmwR6xSi8pcyo7yPag+1T
 oFOZV6A6AfRtFugOYnAJKG6YV7cA/ZgBdeKYckWqEIUYWMVp3xu1mUJYgOh4YyM+UOyRAUtKn7y
 x1ehVvofM77XFZggpU/2NkDxurRUvZBWMGvMBjyHV/I4XcKJ2LYTca37i0tWAhGz4MjJGiX6DQy
 klCcsw9RWXFmQWInRv8XBDEOL5PyObMlGYkLBplHqxKTtr9qWAofs9XI69xkfQd2rCF6mrQFbpV
 7O/WhgvPb26EaRqgdfb3bYo/WkiHAHF3cvce3sF84vvjjButW3as9y11N4QLZYzh2v+zAzJF6z+
 w/hCw2Zw==
X-Google-Smtp-Source: AGHT+IH1ryzbQ4ssSSuR+5VjPU2L2XtXoXRBzTpN0U4xuAIy/ppTxnyH/LUG3bwC3UsuB4XZDI4tAA==
X-Received: by 2002:a05:6402:5d0:b0:608:a7a0:48 with SMTP id
 4fb4d7f45d1cf-6104ae4310fmr3988741a12.28.1752007695188; 
 Tue, 08 Jul 2025 13:48:15 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-18f0-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fca66410bsm7647461a12.1.2025.07.08.13.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:48:14 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] hw/microblaze: Add missing FDT dependency
Date: Tue,  8 Jul 2025 22:48:04 +0200
Message-ID: <20250708204806.1898-2-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708204806.1898-1-shentey@gmail.com>
References: <20250708204806.1898-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

These boards ship with a bundled DTB, and dtc will be required for generating
these from device tree sources. Prepare for that by adding an FDT dependency.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/microblaze/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index b0214b2c8b..72d8072f76 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -1,7 +1,7 @@
 config PETALOGIX_S3ADSP1800
     bool
     default y
-    depends on MICROBLAZE
+    depends on MICROBLAZE && FDT
     select PFLASH_CFI01
     select XILINX
     select XILINX_AXI
@@ -11,7 +11,7 @@ config PETALOGIX_S3ADSP1800
 config PETALOGIX_ML605
     bool
     default y
-    depends on MICROBLAZE
+    depends on MICROBLAZE && FDT
     select PFLASH_CFI01
     select SERIAL_MM
     select SSI_M25P80
-- 
2.50.0


