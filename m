Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84709D26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFet-00084X-6H; Fri, 09 Jan 2026 11:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFeV-00081m-E8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:47:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFeS-0006ft-Ct
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:47:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso32833695e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977271; x=1768582071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=END3tMzR7ssOor5FcuUSvBVigCMVRMcaU3O2EW3YawA=;
 b=n8iPOmoEO+LH77Q8HfOOWMMTWkYGOhf6ysJFsQ/X191ito935KflwcXKIfxaHuMOqH
 Ks/Y8c20jdShGzSSOFHVtBCSnXSUAnFkR/OSfPHnD4bOu+fXrOcpI8FX4XcHq2IT+CkW
 pPsg0sNaTqiSu8VOr75hczillpyZAycM3B3KggTCrJQrbNjAu6iPoK2+zxLys5ulJ2j4
 atOzuQ9VWs+LQwGR6bTfbo61ODNROgjGeW73yol/zq8bt6LmOSyCsmObdyBtOT+CiSG4
 15MNBW/sLIx175ZJRcoDbrtsyQ1XM+M8QGkbAvs9SkxcZY3kVB9olkyh02DyIZEZ8YQl
 7a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977271; x=1768582071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=END3tMzR7ssOor5FcuUSvBVigCMVRMcaU3O2EW3YawA=;
 b=WPyz1aUaoDOQSkThMTAqyutKcp15yBM1IotUcbPmBwJx43SZHfwJGQdifbRDvX2+2e
 775X8IBwjJtn1ignnljs2+hFDNO88d4Q6/f1detnKjsgy8SWXe/qg/FGJjPskVHlyDvg
 /VhlurdhMqrltpYp1ff1EcXZd3ThF79eaADrFU4myQmqaKZwWJ8kNMNahqo5XPQqURNy
 ZZmQ05wMFriWNWED6NOl98vIy5uyViDYVws9c3VQ+U+6rSpBM3rv06H4B4lP4cNYxUNF
 P41dZKHtE9gnMkD6TuuAz0cU6bGcpEHCsFKMo0vnhgwUdP8uL2lHysNYXBSQl2Ro0a+c
 8Mdw==
X-Gm-Message-State: AOJu0YzSHALZD9Ga2yzsXjIk9Eo1MZoTd3lPRArvqLfOXQzupKBizQN+
 g02AqMklvhjMbSwM2Up0QNmkCVvEt5kWkN+KhgeF7UD7YvU0+YwbTmknpD4lYydu+lfE2vFFi+m
 Aj3uuXmE=
X-Gm-Gg: AY/fxX6vyBaacPgxRqPfPxPe2zzDZRmyvqYB7TtLbTpVKIQeDxmRtP2PROJWzRlHY6u
 /gVFjDcv3g1i9JtiPj/jgm0fekVnu9wfwRX9mBwOqrAHzDRoccWCSFJTYKZwCvwQD8wUxfv2kan
 BmF2XQOopUSvqBlGObqMshdrrt9d8MzttFdXgcg6bPsPIHdxOm4rvhcprJlYYnCuvPPxklyUc8P
 p3QfkPwthLRUDYMbD7TrR9QQZonaHYCbxnihj6rjK/leGvIHyCge6YSJAdwBQ98fSIp9BhJe4Rp
 Q2Du/vpe0BIMk4FHOPXR9N5yKtxUQsznD2FPenNHnvwhohK+8U5aXNNcw7ddiYkp9383CDtBs/W
 muuf85wmn39QYDBZT3RwZYtaZ1FWowjKgo2Q0oMSJhAl5czvPPXwtw6KcsE5KBIOGYT6XETxRNv
 raNE5AdkkpWzYCnx9Zj/vGHPkE4//Saxc4BQFXvcRZUOU58LQtAKoqNk8pn/cF
X-Google-Smtp-Source: AGHT+IGIKxwPJNkSmcKLtUGHI1seUh2RngrxnMme36+yfsMuOPLnzF85ukGKRclmYDwS+9AG4uRx5Q==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47d84b3b8b9mr111320605e9.32.1767977270585; 
 Fri, 09 Jan 2026 08:47:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f686sm215771675e9.3.2026.01.09.08.47.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:47:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/4] tests/qtest: Remove unnecessary 'qemu/bswap.h' include
Date: Fri,  9 Jan 2026 17:47:39 +0100
Message-ID: <20260109164742.58041-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109164742.58041-1-philmd@linaro.org>
References: <20260109164742.58041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

None of these files use API declared in "qemu/bswap.h",
remove the unnecessary inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/pnv-xive2-common.h     | 1 -
 tests/qtest/aspeed_smc-test.c      | 1 -
 tests/qtest/ast2700-smc-test.c     | 1 -
 tests/qtest/libqos/fw_cfg.c        | 1 -
 tests/qtest/libqos/i2c-omap.c      | 1 -
 tests/qtest/pnv-spi-seeprom-test.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
index 2077c05ebc7..3b842274243 100644
--- a/tests/qtest/pnv-xive2-common.h
+++ b/tests/qtest/pnv-xive2-common.h
@@ -15,7 +15,6 @@
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
-#include "qemu/bswap.h"
 #include "hw/intc/pnv_xive2_regs.h"
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 50a87e62500..39af1df0ed7 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
 #include "aspeed-smc-utils.h"
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index 62d538d8a3a..33fc47230ee 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -7,7 +7,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
 #include "aspeed-smc-utils.h"
diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 0ab3959171b..8611f648c14 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -17,7 +17,6 @@
 #include "malloc-pc.h"
 #include "libqos-malloc.h"
 #include "../libqtest.h"
-#include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
 
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
diff --git a/tests/qtest/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-omap.c
index 6f98f54820b..71f70c64f85 100644
--- a/tests/qtest/libqos/i2c-omap.c
+++ b/tests/qtest/libqos/i2c-omap.c
@@ -10,7 +10,6 @@
 #include "i2c.h"
 
 
-#include "qemu/bswap.h"
 #include "../libqtest.h"
 
 enum OMAPI2CRegisters {
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 8033261758b..44e0b92730b 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -7,7 +7,6 @@
  */
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qemu/bswap.h"
 #include "hw/ssi/pnv_spi_regs.h"
 #include "pnv-xscom.h"
 
-- 
2.52.0


