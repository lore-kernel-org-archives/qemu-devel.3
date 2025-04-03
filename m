Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9A8C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USM-0004PU-AX; Thu, 03 Apr 2025 19:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USJ-0004PB-DJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USH-0002Rj-QA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so14488175e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724719; x=1744329519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqJyLYQ99OAQqFYuKShvFfQyIlJYmG5rcZMVwRgrMss=;
 b=TeJWlHOVYY3t1HLL9aN0HFegP1z3Pul4fyd/9miQlNNFCHL8X7uOuv3qnldjpE9vD7
 1Zps0Iw96uiIynhbf/w+K1VwbmGK9R8mepbl3WfsblxyQ5NX87cXxvJQt7OSyqvD26wS
 0bXu4nxFzQRzzj5Sl15eJAAoGW/ZtH/2lNKoAueTtPf7/GP8gyTAO/49LGRFTDCi2FJQ
 5L6zg6zp+JxmvVQGAUslMW+vGa3TJX/Ud4N357XiRgcjfQY82eTokNXIdE0V/smGBHeo
 xTSdaaUgMQkFPS/RvcjcZmqIHr2lS2i/sQ3du+uUCcj5T9Ll0iM6BcXUvQZK5axLLLrU
 YPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724719; x=1744329519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqJyLYQ99OAQqFYuKShvFfQyIlJYmG5rcZMVwRgrMss=;
 b=tBp6YLd4g5ub4xW51gl5KHDhTFfi5BPzfGwnxSHzpN7TMKJnTFjX7pyX2MyS2wr1rr
 jIzvPWkUYsJ7qQh534rbcm4lU2rfCZI2+QL5cOYWV/MaxcnBeZ/4gVzwBI9jQuVkYAf7
 gVYJyLACWwqIrr51LxANe/PzKqD7AJPbGsUuD4v/fenBZfqBMNNrJLBhiJrLA+uyVc4b
 sG87illWgP4lVZXXbfp3vJ0cc8YvCVRNK4aH7SfitqX0IlbDxKHnkYgiM4TEQaXbVkIb
 2PcNVEmhtdsimvxL/PqeYy2akkcgPZykQPD8hNA0cSuXu5pu79RbDBMyRT3y4LasYGBQ
 70+w==
X-Gm-Message-State: AOJu0Yyo+PaJgbXxHIHHXsiHVF2mmCIcGODjz0jEUkk8/XPaYmhBssnL
 eZBPLMoyPmQzQK6NDd0MJU+a6zJo3Oah7rCt17oQ3fuVFwLbkTthOmACTyB3Uu8SuzCNSMgF4Rx
 L
X-Gm-Gg: ASbGnctK3KJAMM0ZQWPa9NkTJuJOyolVSsAf+r2MZfHQIBxZVLiBglN/n/mNuckKndj
 GqgoKUUcIqAdDdGC/M008antXQ+i9oTvCefdorhxagjyBRLdBdcrHFpppe/+xZN/Y5T0GVNobgy
 JR97hCM9LTmqK7U5Yiz8Jmj/o/BWetcim/8XorWwblrK+Q3Be4b2eNV3F+ZwW2kg/pWb/Ty29TW
 Auq3k/CGbRx9+D6NW04ubCMuAqSRKV/fnpAKZ1awth9wQFsU8l84Ci2WH9ipqCghLP4yO2gC/ry
 X5bBcFnuDjrPcq9jF4tXC/bT1KXzCHSue1sWvQ6G+T4eLfYT1MBBeUiCDHuUmBUiRiSpQ7XD6P1
 t1wSYccV9oJYywKevH64=
X-Google-Smtp-Source: AGHT+IG24GUQlyq/xWr+fAgAGVLEB4efPzER9XP8iAFFX7j2jni2VmHvlB9Xnw1JLRXwu5fBv5ZxSw==
X-Received: by 2002:a05:600c:18a6:b0:43d:98e7:38dc with SMTP id
 5b1f17b1804b1-43ed242f065mr1331375e9.5.1743724719380; 
 Thu, 03 Apr 2025 16:58:39 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34ae0c5sm30916015e9.15.2025.04.03.16.58.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:58:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 02/39] target/arm: Register
 TYPE_BINARY_QEMU_SYSTEM_ARM/AARCH64 interfaces
Date: Fri,  4 Apr 2025 01:57:44 +0200
Message-ID: <20250403235821.9909-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
---
 include/qemu/target_info-qom.h | 20 ++++++++++++++++++++
 target_info-qom.c              |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/qemu/target_info-qom.h b/include/qemu/target_info-qom.h
index c87d47acf66..880b34e699e 100644
--- a/include/qemu/target_info-qom.h
+++ b/include/qemu/target_info-qom.h
@@ -9,6 +9,26 @@
 #ifndef QEMU_TARGET_INFO_QOM_H
 #define QEMU_TARGET_INFO_QOM_H
 
+#include "qom/object.h"
+
 #define TYPE_LEGACY_BINARY_PREFIX "legacy-binary-"
 
+#define TYPE_LEGACY_BINARY_QEMU_SYSTEM_ARM \
+        "legacy-binary-qemu-system-arm"
+#define TYPE_LEGACY_BINARY_QEMU_SYSTEM_AARCH64 \
+        "legacy-binary-qemu-system-aarch64"
+
+#define LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE \
+    (InterfaceInfo[]) { \
+        { TYPE_LEGACY_BINARY_QEMU_SYSTEM_ARM }, \
+        { TYPE_LEGACY_BINARY_QEMU_SYSTEM_AARCH64 }, \
+        { }, \
+    }
+
+#define LEGACY_BINARY_QEMU_SYSTEM_AARCH64_INTERFACE \
+    (InterfaceInfo[]) { \
+        { TYPE_LEGACY_BINARY_QEMU_SYSTEM_AARCH64 }, \
+        { }, \
+    }
+
 #endif
diff --git a/target_info-qom.c b/target_info-qom.c
index 6970b95ee0b..db3054c307d 100644
--- a/target_info-qom.c
+++ b/target_info-qom.c
@@ -10,6 +10,14 @@
 #include "qemu/target_info-qom.h"
 
 static const TypeInfo target_info_types[] = {
+    {
+        .name           = TYPE_LEGACY_BINARY_QEMU_SYSTEM_ARM,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_LEGACY_BINARY_QEMU_SYSTEM_AARCH64,
+        .parent         = TYPE_INTERFACE,
+    },
 };
 
 DEFINE_TYPES(target_info_types)
-- 
2.47.1


