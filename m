Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732C4106FD66
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0su8-0000uc-B3; Thu, 12 Mar 2026 23:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0su7-0000uU-Ap
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:09:35 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0su5-00017E-QB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:09:35 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2be8828e632so1670199eec.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773371372; x=1773976172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAJU8vitxZFqocH8zEKRNLY1Wna7hBU2z5rdHj3hilI=;
 b=msxM8b1BdbabuaTIDrqUJfJuH92KXbN4XphR85J0467dsnhZwbWHahqyLmJXNwaTYw
 3+jMfPLnJoEe8XGKP9xu22OGD/CvbwBucXU/Hnyd1B40uiLyR/XtCe1x+lG2h09jGLbY
 bV63bkkBwlgvq7s+z3Lj6D+boMtfWQ9n1YZpTQcq+hFFOUDwzmRNbKAq7vyq9jg4SCQ9
 puczjGHcxjQXqdhto6AOAwfCSaiiNgDUGcGgi5gfVVpbE2UaACwdX65NbsDIPvULVjsU
 3c5Rt/ZrpvlMu2G3MtQyyhHH43sohj9OxfPpNXL771GYuwjzmpdI7Y4tLGUcEH2kFu5C
 1gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773371372; x=1773976172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zAJU8vitxZFqocH8zEKRNLY1Wna7hBU2z5rdHj3hilI=;
 b=hby0nY089I9bnL+uxFq1IBU2qLLNV7QriyExld6/r/p+GMx5ql1uXpfbiwWEX1SiBa
 BTk9Zk/i28XOfiu30isfERgTM8gQSKrdL+BycJVR9BhWpavnCZh+XghrT4Q61JresHTT
 9NTOS0mbrsGnW5P3TWhO0Cru4Hg/O6p//oJG/iE37nUTUftPAkOl+6fNTzZC+jMdVwuN
 nxBe7lWis+IILM8YiU/TpxEAZhgDZLD5MuE/d7UEm4UtWjYppotpLCtih0H8dgOL1jiv
 QrdpXj4C1acfMfy6J5lnqaHnqKqzwSAJdQm+f1Y0zpd5/sQe7F/8RW7cgd5epA53W9h3
 z3JA==
X-Gm-Message-State: AOJu0YwCS7EiCG76GTlCVECLpW55IQxUl+HtMyjEwdeSkovrP9Hvs6pA
 1NVnq7uzNU3V6dKaMQOpEnzCdtjcQ51CWEgJLIFfmb9HhAJ6Wj7aXjSO8xNKq90P
X-Gm-Gg: ATEYQzwE8YcdFP7IC+MD00kQZ2XMsOHokc3RCv6H6L1W37fC+qFEo5fSYVXKVPKqAF9
 l0FGX5MVGKdI0n40FmeOr7nE6XBz4r/uYqkqylXo/3IRFBTETQlaH2SSJbPYqfbkekhJzEU5yHw
 GcROfc3iyiQvrZU1OpwypAdtHw717BeGqbmJ7rL3z6a4tmhkAPW+OS4Jh4noJbacUP+Hhe9Mew7
 WMk4LDfKpWAGo2BvrGjbHS+WzKuRbAYANfc3zaTZC9vkuzfMmhPBxrx6E0AcCR2Aqq+M8grUbRE
 KkHPU0DmV6vIf1NEgNnCkSgpfzPvgJl1ePjbuc/WR54oUgo4HaSXRIyp/XhisTU+BZ33qOAL4lE
 /3aYESKdHzqnoyB0+DxvTr1+rGpRaTbE/GoP47Uy6ELQ/IBlGNJPLsGOCiGltXogh/NuT9CVh7n
 PV3PeHFSW4gdW1I8wv6vqMtREd7YDN2LaElUmLbsmOUwZIpLruxTI=
X-Received: by 2002:a05:7301:1e84:b0:2be:12ca:b33a with SMTP id
 5a478bee46e88-2bea5508dbamr783407eec.13.1773371372098; 
 Thu, 12 Mar 2026 20:09:32 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:588a:39d7:d008:37c2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab52702asm902472eec.16.2026.03.12.20.09.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 20:09:31 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v3 1/3] ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
Date: Fri, 13 Mar 2026 00:09:22 -0300
Message-ID: <20260313030924.45299-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313030924.45299-1-lucaaamaral@gmail.com>
References: <20260311022752.64192-1-lucaaamaral@gmail.com>
 <20260313030924.45299-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Define GRAPHIC_FLAGS_VK (bit 2) in the console flags for future
Vulkan scanout support.  The compatibility check currently returns
an error indicating the feature is not yet implemented.

This prepares the display framework for direct Vulkan scanout
alongside the existing GL and DMABUF paths.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 include/ui/console.h | 2 ++
 ui/console.c         | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3677a9d3..19ac06e0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -361,6 +361,8 @@ enum {
     GRAPHIC_FLAGS_GL       = 1 << 0,
     /* require a console/display with DMABUF import */
     GRAPHIC_FLAGS_DMABUF   = 1 << 1,
+    /* TODO: require a console/display with Vulkan scanout */
+    GRAPHIC_FLAGS_VK       = 1 << 2,
 };
 
 typedef struct GraphicHwOps {
diff --git a/ui/console.c b/ui/console.c
index f445db11..d29733ad 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -594,6 +594,14 @@ static bool console_compatible_with(QemuConsole *con,
         return false;
     }
 
+    if (flags & GRAPHIC_FLAGS_VK) {
+        /* TODO: check for Vulkan scanout support in display backend */
+        error_setg(errp,
+                   "The console requires Vulkan scanout "
+                   "(not yet implemented).");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.52.0


