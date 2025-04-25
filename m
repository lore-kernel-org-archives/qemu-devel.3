Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D48C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2e-0000cg-5Y; Fri, 25 Apr 2025 11:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2V-0000H3-Di
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2T-0004Az-JU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso10770915e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595147; x=1746199947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bURnSPDaVtR9N3EkMoH8bF+JT/oXfM8qcNeiJQnPSHQ=;
 b=Gmk8p79/wFZXvWm5TKsFnC0hGD7s5acPn7TMIJYd/0I+/Oe0O6InUJiyEHnyJzY6P9
 mL9YD/DX/ipAfcLczDwc1rmFyrJ//gf7gUyfgeJyk12SU9BG9AUUBG13uq82mc7WxNSo
 j9GRPlFxTfbn4qFa8IAGoSe7tjifbgBTfOKexxlWHsuHcNDPhc9BrAOvB885IZe1gxaa
 YtMQjqqgGChkIHdOxijMKYN/6AvvOzOmkvVHlSay7CxHPVa3VU76NytrZU7eXldAZLvi
 YuWeIjNL6zQBHRFir7Hn8nFntikfoGhHAYcy8QBpJLag+haDB/rQiRugI4CfvSMVXUBm
 lW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595147; x=1746199947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bURnSPDaVtR9N3EkMoH8bF+JT/oXfM8qcNeiJQnPSHQ=;
 b=GlmpFfPt24s+aO0f99R6PBgJFJG8od36i8NKtlu0493CdyMmPA7kYFP3ODGru1XxZU
 tX2JdrI5+lr729Ft/6Ry/mXWrRa2UbiLkbi0/QVL+Y2tj0HP3YNM2e5SVV/4EGPNsm7z
 M1FRulvzFuFqAcy/iKierZnL14FQXTpauUiuwXWKtGmf5p/wWt6Cgku0L5mccmRx13kk
 Xf/o9Wi3PwHgHXGzhhvToojGori8Y6rrSShhgcaHpwUF4HSB6v2Ns2Ze/J1BSNMh5OAn
 frEAWKoRQ4Uvkz/jo6S0UcyX5qmt023gWL7zIj4v3P8a1kBGJ96144+QTYCqmHOfszj8
 88iw==
X-Gm-Message-State: AOJu0YwoRqGNozOKInSwirlYPRrQoHOABFNhChkzyoxT0GgHq2sJvt8V
 1/UtMIwM1+86WS9Io2rHQbDwh2CxWpytWnY23VrtTfgQm3OM4fZ7nNjl8TsCbVe3tuYjI2Y16Tt
 E
X-Gm-Gg: ASbGncuDkllXJYta+d8p8mKRlmXsK+fR1YHfQipwFPQM2MKlE21oNk8OoK5eTF7NYE0
 FDclrK/lKyLz7oQsl4/9hkQRyETG+hgsNZiLi9OOTXyPKkK1FGboDcLaC9kKCusdeyaSghB1cQs
 0OUxzjABxfzgXzH9lLyYVfDRodQRnyUmMj5CJvzI46aGL/EhkrcGcFiEnhHC58VRShk9AuqH4hA
 D38EwYeazNjVIRTCVScUiVbHD1gEdbGJ9ZYqbF70wduEUwPTY3PulHsTfC3BP2sRVPf0kGeYmCI
 VX9/lpSb9sbpEIGwBAs8BbCP9CegqRBB/wF7xuZ7YKnnPvSvtxHTM3GbDhwawdVXs60bCs16ESm
 F3FAqRUaR4py5/Nc=
X-Google-Smtp-Source: AGHT+IG9CruOaGvCdUsd3ZaaflCZ2SU4AMJAmc0HopEBw9AQLbcKeWhcXIb4zuxailr7FBbO/67JLw==
X-Received: by 2002:a05:600c:190b:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-440a65ba213mr25134635e9.5.1745595147631; 
 Fri, 25 Apr 2025 08:32:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a0e7esm62693035e9.10.2025.04.25.08.32.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 45/58] accel/kvm: Use target_needs_bswap()
Date: Fri, 25 Apr 2025 17:28:29 +0200
Message-ID: <20250425152843.69638-46-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Check whether we need to swap at runtime using
target_needs_bswap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250417131004.47205-3-philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b8c68c7819a..278a50690c9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -33,6 +33,7 @@
 #include "system/cpus.h"
 #include "system/accel-blocker.h"
 #include "qemu/bswap.h"
+#include "exec/tswap.h"
 #include "system/memory.h"
 #include "system/ram_addr.h"
 #include "qemu/event_notifier.h"
@@ -1318,21 +1319,22 @@ bool kvm_hwpoisoned_mem(void)
 
 static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
 {
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    /* The kernel expects ioeventfd values in HOST_BIG_ENDIAN
-     * endianness, but the memory core hands them in target endianness.
-     * For example, PPC is always treated as big-endian even if running
-     * on KVM and on PPC64LE.  Correct here.
-     */
-    switch (size) {
-    case 2:
-        val = bswap16(val);
-        break;
-    case 4:
-        val = bswap32(val);
-        break;
+    if (target_needs_bswap()) {
+        /*
+         * The kernel expects ioeventfd values in HOST_BIG_ENDIAN
+         * endianness, but the memory core hands them in target endianness.
+         * For example, PPC is always treated as big-endian even if running
+         * on KVM and on PPC64LE.  Correct here, swapping back.
+         */
+        switch (size) {
+        case 2:
+            val = bswap16(val);
+            break;
+        case 4:
+            val = bswap32(val);
+            break;
+        }
     }
-#endif
     return val;
 }
 
-- 
2.47.1


