Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB87C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEonN-0005ZD-RG; Wed, 05 Jun 2024 07:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEonM-0005Yz-3b
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:27:08 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEonJ-0003Nn-Tn
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:27:07 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so2678468a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586824; x=1718191624;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0aXqXcmnBCSHTUMGza3JBiKc8v6Yf/pH6Wf+LjvE9A=;
 b=n6MW/lPncgVtUFN25wnvWYkA9o1oKwS6vhC1n/kGuMzdBRB/42SgYAeLPQP7a5ydxJ
 nBnTAAEFyF1fu6MySQIivRfAoX7+hkmHU3YUUN/bUMevy/aS6XP34DhlLETXXXPMNcdT
 zawTDE43nno8+vKs50JqMOEnA5Rk+mxNC8thTRFrHgGHQbjFq5rWiOpGIWU+vIMN771M
 qnBAmwBGNoc4g2DGPbxod3gvM26cXLVgxXuV9aAxA3GAqwajlcD1EDPn8oLjxEMYVzWm
 XgV0wqWZ9OX3SnH6WWWFOvXwUcFcQAVyXVZUuRikDj/H9q5oedNDzcBUYmiLveYUWPEQ
 Adag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586824; x=1718191624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0aXqXcmnBCSHTUMGza3JBiKc8v6Yf/pH6Wf+LjvE9A=;
 b=Kx++wDRLdsAhCuYnzOIn6+09Oy5F2zyKovwQaVMP1wNMLDNFol7VI/L2JPsSoQ4gN9
 mmlO9NcrAhhsTnAfVfUwOyzl+Z9OptCDTWDUiZMg2slH3i+SP/pP/xmsy1ie4fcCuQEs
 qkNustEyPNCjIPZlWilbBm9sLW5d934EutjxOepldWCyidK6F7+BbuSjjodmk8DU+Utp
 d3Vg5SRfE/9zXzDRtLvwITHAu86NC6erhj8nT0a5drBHbr1NxnxFdybZusBOXyWuleft
 HI9f0dfKmcoDgvCGTP/6qHY+biUpct+AZWAosqX/LGJocXv91pAxFU5o4QTlVyOheXm/
 kwaQ==
X-Gm-Message-State: AOJu0YyaJL8I8kUQje6KUQZbqH7RgVI9WvWC8O7/PUdYiz3bNG1w9qt6
 ly4MNn20O7wTA5LTATuVIVrYpZCliDz24tIZe+Xz9Di4/8c0w7FXowo40e6W5h9jflvQcjb4m8M
 =
X-Google-Smtp-Source: AGHT+IH4f6E5RmBELgGtPxvCF3hgAjt/4lQFG5C6R4P9pc8H2wr4y5gUeLgCeObO5Q/2jsrW0MUYMQ==
X-Received: by 2002:a50:d79b:0:b0:57a:259a:489a with SMTP id
 4fb4d7f45d1cf-57a8b6a698fmr1355330a12.14.1717586824291; 
 Wed, 05 Jun 2024 04:27:04 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:27:03 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 7/7] hvf: Makes assert_hvf_ok report failed expression
Date: Wed,  5 Jun 2024 13:25:56 +0200
Message-Id: <20240605112556.43193-8-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52d;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When a macOS Hypervisor.framework call fails which is checked by
assert_hvf_ok(), Qemu exits printing the error value, but not the
location
in the code, as regular assert() macro expansions would.

This change turns assert_hvf_ok() into a macro similar to other
assertions, which expands to a call to the corresponding _impl()
function together with information about the expression that failed
the assertion and its location in the code.

Additionally, stringifying the numeric hv_return_t code is factored
into a helper function that can be reused for diagnostics and debugging
outside of assertions.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 accel/hvf/hvf-all.c      | 49 +++++++++++++++++-----------------------
 include/sysemu/hvf_int.h |  5 +++-
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index db05b81be5..c008dc2f1e 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -13,40 +13,33 @@
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
 
-void assert_hvf_ok(hv_return_t ret)
+const char *hvf_return_string(hv_return_t ret)
 {
-    if (ret == HV_SUCCESS) {
-        return;
-    }
-
     switch (ret) {
-    case HV_ERROR:
-        error_report("Error: HV_ERROR");
-        break;
-    case HV_BUSY:
-        error_report("Error: HV_BUSY");
-        break;
-    case HV_BAD_ARGUMENT:
-        error_report("Error: HV_BAD_ARGUMENT");
-        break;
-    case HV_NO_RESOURCES:
-        error_report("Error: HV_NO_RESOURCES");
-        break;
-    case HV_NO_DEVICE:
-        error_report("Error: HV_NO_DEVICE");
-        break;
-    case HV_UNSUPPORTED:
-        error_report("Error: HV_UNSUPPORTED");
-        break;
+    case HV_SUCCESS:      return "HV_SUCCESS";
+    case HV_ERROR:        return "HV_ERROR";
+    case HV_BUSY:         return "HV_BUSY";
+    case HV_BAD_ARGUMENT: return "HV_BAD_ARGUMENT";
+    case HV_NO_RESOURCES: return "HV_NO_RESOURCES";
+    case HV_NO_DEVICE:    return "HV_NO_DEVICE";
+    case HV_UNSUPPORTED:  return "HV_UNSUPPORTED";
 #if defined(MAC_OS_VERSION_11_0) && \
     MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-    case HV_DENIED:
-        error_report("Error: HV_DENIED");
-        break;
+    case HV_DENIED:       return "HV_DENIED";
 #endif
-    default:
-        error_report("Unknown Error");
+    default:              return "[unknown hv_return value]";
     }
+}
+
+void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
+                        const char *exp)
+{
+    if (ret == HV_SUCCESS) {
+        return;
+    }
+
+    error_report("Error: %s = %s (0x%x, at %s:%u)",
+        exp, hvf_return_string(ret), ret, file, line);
 
     abort();
 }
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 30e739a2b5..5b28d17ba1 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -60,7 +60,10 @@ struct AccelCPUState {
     bool dirty;
 };
 
-void assert_hvf_ok(hv_return_t ret);
+void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
+                        const char *exp);
+#define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
+const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
-- 
2.36.1


