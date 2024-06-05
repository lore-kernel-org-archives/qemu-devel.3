Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE9C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz6-0000hL-TI; Wed, 05 Jun 2024 17:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyw-0000dS-L4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExym-0003QF-T0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7025b253f64so210725b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622130; x=1718226930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6Mj0yPmK4aF2gdBWUJi8XJKeBX80hKgL2mV428joew=;
 b=X9U12m3ZOWpkFESkavbYaNI0cWJ6ox6wsAwDBdUmcVj7DySqYHVscny641v/NgXxB4
 XPr6pcnCovVesTMDBWgzvVQgLR4L6aLsuSrqOisQ7JWipd7iizvY4lnOy9LV8K4ew4eu
 vwaBM8E3+sSZZ2laPJkiz28l2LEhG7MKRWHEaXS0DDBH41kB+TBRTgHoGtUdWBOamUsN
 N2wqfgVTjpjLzI3unmyHI7lefazyks5uscKkSuY2dxOFR3EeJdQdcRXmzm+mXHGWflle
 /ZEJdQgeIwjNWsRWPrmM4voVVtEbiLCG/GoHywDj6E0We1r9UwYQplkHcr8Uyow/+g8T
 KJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622130; x=1718226930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6Mj0yPmK4aF2gdBWUJi8XJKeBX80hKgL2mV428joew=;
 b=aGoktzJvtrpWODXBxutJnupwwHIXwJ/k6BMLhebehCEweeuDsCRYJnWLehCqv7LDZW
 JGqdDRGTo+4Cr8s/k58gjL8paRDiWv3oHzbKO9OkVK37ZT1a5ryILHZbvmrA9Horygb8
 c/B6EIhzyI7UrQFnCI6OwNNB+S+K+3IDIIc4Si3CKZFOkFOWVNaAWdUbj25T+xfvHtgM
 00TJ5bUrIh03bpKBlxM0B+s9xxjMuF/5J7bApc+MCbVfUz/ukKhtjNssURtDhzmelyb6
 iZ1tdb/LhPBMOw7o5sb8+2BEByE9noULk/q1QhZLsm/o7VpUjXaPfgvo1uS9O5LY4eC+
 13Xg==
X-Gm-Message-State: AOJu0YxB/iDkJUiVK48EZyPtRUkXgK0oyXWrf5JQ3kGwh1aBZtoIK/z0
 yZuw8kjfnc63YvXtNLXPDXuOGDFCVVwDB5qAnZBpOSkNBelsq0JmgzCgUogyS6iKVne5rm+gRuF
 c
X-Google-Smtp-Source: AGHT+IGhr7BRxb3M94JGDbi3Ok9eB/kGHpddidlKChvChFjLt/9uMsIBU4HbxoE28nfTPCCTSkjIsw==
X-Received: by 2002:a05:6a20:918e:b0:1a7:bb6d:6589 with SMTP id
 adf61e73a8af0-1b2b6fd4af7mr4730011637.29.1717622130022; 
 Wed, 05 Jun 2024 14:15:30 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/16] hw/dma/pl330: Use qemu_hexdump_line to avoid sprintf
Date: Wed,  5 Jun 2024 14:15:13 -0700
Message-Id: <20240605211521.577094-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-11-richard.henderson@linaro.org>
---
 hw/dma/pl330.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 70a502d245..5f89295af3 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -317,22 +318,14 @@ typedef struct PL330InsnDesc {
 
 static void pl330_hexdump(uint8_t *buf, size_t size)
 {
-    unsigned int b, i, len;
-    char tmpbuf[80];
+    g_autoptr(GString) str = g_string_sized_new(64);
+    size_t b, len;
 
-    for (b = 0; b < size; b += 16) {
-        len = size - b;
-        if (len > 16) {
-            len = 16;
-        }
-        tmpbuf[0] = '\0';
-        for (i = 0; i < len; i++) {
-            if ((i % 4) == 0) {
-                strcat(tmpbuf, " ");
-            }
-            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
-        }
-        trace_pl330_hexdump(b, tmpbuf);
+    for (b = 0; b < size; b += len) {
+        len = MIN(16, size - b);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, buf + b, len, 1, 4);
+        trace_pl330_hexdump(b, str->str);
     }
 }
 
-- 
2.34.1


