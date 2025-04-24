Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A90BC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xw-0006UO-GK; Thu, 24 Apr 2025 18:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xu-0006R3-LU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xt-000138-28
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso10880485e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533359; x=1746138159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyQnKU/Qb5MFlABzvGsbZVvBtDKdqhE3tTnhTcPso0Q=;
 b=g9dkEEVUa1sBNzfEx9lGQIz+OSoT74WRNyy9mTaK+/LSxYjb5Q1De4tWBFmmNUOT4G
 C5p2b79as88oGNASOQWGTMwOUHqJQ56R1gK1nsF7B+kVhiIZJsrV0wYClnuqVjJbrkJn
 sBgJ960Ds9Szpq2xI5vsqdJk4dnQC6sWCUhFt4RrtHmyx/ABDinbuC03zEmQMPpFg3Rc
 vYKeNNdbJieWEuN200HEnQKA+Me5FAJUBJLNgAsOlhZdT0BDeK/kIhh/H6rf1pFYPyxo
 XTjtZtpPVkuPqywx2rkOwx6t7umkBA3zCyovE/B7ar3qgq00LvjsMhExbJTXY1IIpnP7
 jWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533359; x=1746138159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyQnKU/Qb5MFlABzvGsbZVvBtDKdqhE3tTnhTcPso0Q=;
 b=VBwMdJ2UkzXjPoTjJcCDpedJTbwHBakNwpiquJycvshAZO/t6iTinovRcyHKEj7VUb
 SQqizCXxv79B2tMP9BhIsPQE3pi1iwctfHbSN5V2nDjcv2bGejJHJit4mWBfOPyJEUq4
 0p4jEgInj2uwMhZHi1dgS/mgFvyYOew72SHrQHP+LV7LZmcapQLrZ4BrGM43fJ3lnF5c
 KXeGPwHlPPuu8NEY+YZwi0ZSifVi0AU3otbXKGGE1AuU4gx6x6FIXxZHKYFmQYG/plS5
 UwvXgaNqv99KGuEzMPmkYErCyPXTEudmtoO88gLhEUylPVWm+4RRGokua5F/d8WMwZ41
 pCGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/ReZqWTd5lcqjEiifLsnfyI0AtJbahqD0cCvrIejR/KlqyYhzYyigyxj7FzoQjG+9XPIrvbyzUBrJ@nongnu.org
X-Gm-Message-State: AOJu0YzAtrOgyxzBLK64Nvrzjg5CY7jERGRL+qTxuGQZVX2IFwQ9JZaD
 KJYxITD7f6rwoyRueOgNS+ojJvD7xMqarzMQQgALZR48sy/F+wb64qzp0NRUcCNukGvEdKy9V27
 G
X-Gm-Gg: ASbGncvdTYzH3mfWQjagDQFokb7t3MG9X0lSR6Wt51+FnTa3BF/1HLL8IRoSRTYgYP/
 2n2anCtNPG6sPSSbio8mVsqeBOQhcn1VcMPY6fKL1rJoXcrY83tPIGZoIQgT4lViYWBwMbEIk+6
 H7ar8UCtzfCGSYOrd4YenI2PQnXSBmt9DAflNfjaobElY9Yk+lBhsYXbOgWovFGZGDhy0flmFl+
 AQ1nfpLz09xAfYjxFhRXzDWXQZqSlG/lDgFI3tZneFYy8FEchedoCP9nxPMXS3leHBfjL54phEh
 W0QrAooIGaJch19JGoSXBIBT4lQ9ybsHVb7FSb6pg8UIyE7QrQZNZB+A7LkfjP/5OQspOGvcE8T
 j/DNtQZkVkKns7dw=
X-Google-Smtp-Source: AGHT+IECeKta2KvUC5QS/hTRuwatDXyarQEp+wOp36wIgAsyuJvbmMrzOk1pOlk1lmNREfpxWr+TpA==
X-Received: by 2002:a05:600c:3b04:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-440a31923d2mr8331775e9.21.1745533359108; 
 Thu, 24 Apr 2025 15:22:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1d1sm3101845e9.26.2025.04.24.15.22.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 17/21] qemu/target_info: Add %target_arch field to
 TargetInfo
Date: Fri, 25 Apr 2025 00:21:08 +0200
Message-ID: <20250424222112.36194-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h   | 3 +++
 configs/targets/aarch64-softmmu.c | 1 +
 configs/targets/arm-softmmu.c     | 1 +
 target-info-stub.c                | 1 +
 4 files changed, 6 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index d0e8c86176c..e5ef425f2dc 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -10,10 +10,13 @@
 #define QEMU_TARGET_INFO_IMPL_H
 
 #include "qemu/target-info.h"
+#include "qapi/qapi-types-machine.h"
 
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget target_arch;
     /* QOM typename machines for this binary must implement */
     const char *machine_typename;
 } TargetInfo;
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 375e6fa0b7b..ff89401ea34 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -13,6 +13,7 @@
 
 static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
+    .target_arch = SYS_EMU_TARGET_AARCH64,
     .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
 };
 
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index d4acdae64f3..22ec9e4faa3 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -13,6 +13,7 @@
 
 static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
+    .target_arch = SYS_EMU_TARGET_ARM,
     .machine_typename = TYPE_TARGET_ARM_MACHINE,
 };
 
diff --git a/target-info-stub.c b/target-info-stub.c
index 218e5898e7f..e573f5c1975 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -12,6 +12,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .target_arch = -1,
     .machine_typename = TYPE_MACHINE,
 };
 
-- 
2.47.1


