Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE7C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGW5-0005aS-BU; Tue, 08 Jul 2025 18:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGFx-0000mE-SJ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGFv-0003L6-Ee
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so41094995e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011618; x=1752616418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQ7EZXT9CO2OHBTy9GyeX1UKDvNPuq/+5ZdKjXTN/Ns=;
 b=HSXBeo3GXKywL9wHq8Gvq4pNAxGuN2TnNHjsSfc9DzuCxfDCG/QGYvUp3oL60jQa7y
 U2wqewjsE83aA3q9w/oeEp1h4gQ82gzKr5SRby80FiEDuKYlNMRQyLx2Od01qPDvzuPx
 bcSu4aGlpmIkxx7T7rzYgcvppXqUSPMvaa8TyjSVdxENPQdEHBQ7WNv/8OzTO+pnzOuA
 7HN7oX4DZL76j9xhX41DULjARL+F/N3XbEgDLvyhCQpRrlIP+H/GGOXaid9/+6I6QnUk
 4TbsvzAQu3RQWvRNH6MlkXbEPOpb7IGs9a3pGQgXn6eGJyEXp2PwuchIHyHf4dBMte+P
 hw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011618; x=1752616418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQ7EZXT9CO2OHBTy9GyeX1UKDvNPuq/+5ZdKjXTN/Ns=;
 b=R4BR9HSiGtu1IYFXoIcTPqWgMp/lopn2HokWO5JMGiU3djz1f5mL1x9aHH2Dj1TpKf
 gJoBV3S/T54HJiYyb3gY7sHL3iJ4Di2pNjHNeERjs1S3qvuSGupe0fw3WAhBrs3DoDCx
 wmw/ftf7oLZiMdy2LYau3CAIrCZ1DiVXblBuseAp+HrLEgmDST6yD9ulTQAzI+50W84i
 Run9sxgjtIDTzkTjc/DNYv2IX6+6NbasYSFCVI5jLle3tVBmZyxdA2r0R6Kzo1U7QOIJ
 MG+1kLdgeMvRR7x7rfTZhrQrRj7zdTo8PYS+keWQcAWcBNCS1uya2Itw3SsPlC+LYLUN
 qK0Q==
X-Gm-Message-State: AOJu0YzYIbJyyA1wi7Fjom4ulEd+q3I+/qkjacfdxF9RPSCKnmXVpCmV
 /doJWisQsAdFSU8KbjTBb6r/BzP6+k+TU/ChiKAavAX2nz0k57GIwBu5ZVkUmaX0ygFjFUD/KNh
 f0AR8
X-Gm-Gg: ASbGncsk/7g0xyvRyTKutU3gQ+jPZBx3ZMw3oaXuxD153xO/TMvB+dBcc/QQLc6HRxj
 P+OJzj8zXCs1yoBIRzc0qpaJMQiCruaOikJVpqgYd6xq4TNAoxahN+mzqnZvgEWnid7eLgrXSH8
 KY8IVwD8Sg8RVPaufqQ5EvPmG+hMqoTkZOtYxKtGF2UetwhKLCk5TeuxDwHWpGHj1kVfj3O0WR4
 8Y9Z1NLHVWGOxWBFcB/92h2gqLCP5bDL/H48dyhv1ZRw+UiZKIH6rvb02BMUeA/po6l1pgED0F5
 y+a9z1bWU3cVce2y0FHWR3aiOJ4efkzilK5NptzAYFK9D7YvRnjN2wt5BmZEIwtFak3+f8BYHpc
 wMIDsPWAiDdM45KAmXnlCk4dA9RgMZ7mWc1sLKqhtxw==
X-Google-Smtp-Source: AGHT+IH6LgiCiKP3S4x7k4EEXqGXeCKB1z+Qt1OoQC51l1ga4Ds5cTR1QEfJT4eN5CJVshZ3/iSHSw==
X-Received: by 2002:a5d:64e7:0:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3b4964ee263mr14146877f8f.58.1752011617528; 
 Tue, 08 Jul 2025 14:53:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d508cbdesm703125e9.33.2025.07.08.14.53.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 14:53:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 RESEND v8 3/8] qemu/target-info: Add %target_arch
 field to TargetInfo
Date: Tue,  8 Jul 2025 23:53:14 +0200
Message-ID: <20250708215320.70426-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708215320.70426-1-philmd@linaro.org>
References: <20250708215320.70426-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/target-info-impl.h | 4 +++-
 target-info-stub.c              | 1 +
 target-info.c                   | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 1b51cbcfe1b..a8b34d150ab 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -9,11 +9,13 @@
 #ifndef QEMU_TARGET_INFO_IMPL_H
 #define QEMU_TARGET_INFO_IMPL_H
 
-#include "qemu/target-info.h"
+#include "qapi/qapi-types-machine.h"
 
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
diff --git a/target-info-stub.c b/target-info-stub.c
index fecc0e71286..2e4407ff04b 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -14,6 +14,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .target_arch = SYS_EMU_TARGET__MAX,
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 9ebabec988f..8e29553b4ef 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,8 +24,13 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    return qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                           &error_abort);
+    SysEmuTarget arch = target_info()->target_arch;
+
+    if (arch == SYS_EMU_TARGET__MAX) {
+        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                               &error_abort);
+    }
+    return arch;
 }
 
 const char *target_cpu_type(void)
-- 
2.49.0


