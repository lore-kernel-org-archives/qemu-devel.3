Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8948BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeq-0007pe-JM; Tue, 02 Jul 2024 01:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVen-0007nk-8N
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:21 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVel-0007CM-7d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:21 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cdc4d221eso4093391e87.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896537; x=1720501337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsG4HS0Hi0hbjd75KzsL4izJ2zeNMAGK2+0U8SqDHJE=;
 b=h4olOEi2s7NrTYrxfv2roBL5GP+AXMUlXKIqpquobTt27UVLKa3rYjVV3/If7UVtND
 N3ay/UGFtkFT3PuHCjePJTwIUiHGTOtCWqFVk2C5Y9EVm37LqBiYv7gOgwBRwL5wEYlY
 upL1EkLEGDWTF8Y9LZrAZNZDWeu1fwphQ7SQcmtaa1d0XUUW+BXF+DIAPhBCJWeRUSte
 6OMc4GOru+ko6ICuwTchrpvD3rPHKRqCrE0QYTzWtslyaNzeufmmBxNcqLLm5tAXAchV
 muhkDGjiBSR3opgq0zH7W92hFMwUJ0JxZEZnu94job+uA0qyWJn2lxBnCQbZViOQVWKk
 tEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896537; x=1720501337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsG4HS0Hi0hbjd75KzsL4izJ2zeNMAGK2+0U8SqDHJE=;
 b=usgN14hMh+RxUgO7TE0VU+jHuVL4a4QIHxZNnYyaT9YU/MYqxg05nuKSuMsc/3rz07
 x2moR0Xf7PHPT3XleOX/PNY2ySzNPgtt4AQijnnPg9p3uKfBaF2QgkF8QfbM8Bobmpx1
 wx4BKlCqt7Xv8e2QDeEKBK87iDXzXwEAGXwa74WhRTnLAhCdb2TOKhW+1WjPoU1ZH1Jh
 4eRT0FQP7IUx3Y05MifMRLlCzsR2zUTzYg1SY0nIrf9tLApG05wGBvN+87LuvO0OpE4j
 NwXyOLtvbbYftzYpjt2CyIL9v3v+dovipFOK1R0HYMj/NRp15JZ3EWoMhxGNyJQIYS4M
 Yp3A==
X-Gm-Message-State: AOJu0Yx9Jy7dE7zx7CnUzCDwebmSFd4cE0wmD4PAdozht7Lo1sXOTHsk
 Uk3sztvTh52/o2eXWi5QCBVstFUrE+wuQnx42i8hpnQj/hnuQQ+ohbbsxKFbSJzsMmQ0tqtAlkA
 P
X-Google-Smtp-Source: AGHT+IHEnQnH5Mk5iLK9jJ32wU+zohfO5/Q8FyLCR26QKh0ODkpFiACo4hkk9qjVl7o2PuU9Y4HD9g==
X-Received: by 2002:a05:6512:1108:b0:52c:d626:77aa with SMTP id
 2adb3069b0e04-52e82731df2mr4709720e87.58.1719896537064; 
 Mon, 01 Jul 2024 22:02:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789d5ec1csm228250f8f.37.2024.07.01.22.02.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/22] include/hw: temporarily disable deletion of versioned
 machine types
Date: Tue,  2 Jul 2024 07:01:00 +0200
Message-ID: <20240702050112.35907-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The new deprecation and deletion policy for versioned machine types is
being introduced in QEMU 9.1.0.

Under the new policy a number of old machine types (any prior to 2.12)
would be liable for immediate deletion which would be a violation of our
historical deprecation and removal policy

Thus automatic deletions (by skipping QOM registration) are temporarily
gated on existance of the env variable "QEMU_DELETE_MACHINES" / QEMU
version number >= 10.1.0. This allows opt-in testing of the automatic
deletion logic, while activating it fully in QEMU >= 10.1.0.

This whole commit should be reverted in the 10.1.0 dev cycle or shortly
thereafter.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240620165742.1711389-10-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 187ed76646..ef6f18f2c1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -686,11 +686,28 @@ struct MachineState {
  * suitable period of time has passed, it will cause
  * execution of the method to return, avoiding registration
  * of the machine
+ *
+ * The new deprecation and deletion policy for versioned
+ * machine types was introduced in QEMU 9.1.0.
+ *
+ * Under the new policy a number of old machine types (any
+ * prior to 2.12) would be liable for immediate deletion
+ * which would be a violation of our historical deprecation
+ * and removal policy
+ *
+ * Thus deletions are temporarily gated on existance of
+ * the env variable "QEMU_DELETE_MACHINES" / QEMU version
+ * number >= 10.1.0. This gate can be deleted in the 10.1.0
+ * dev cycle
  */
 #define MACHINE_VER_DELETION(...) \
     do { \
         if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
-            return; \
+            if (getenv("QEMU_DELETE_MACHINES") || \
+                QEMU_VERSION_MAJOR > 10 || (QEMU_VERSION_MAJOR == 10 && \
+                                            QEMU_VERSION_MINOR >= 1)) { \
+                return; \
+            } \
         } \
     } while (0)
 
-- 
2.41.0


