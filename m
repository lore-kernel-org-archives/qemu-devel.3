Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81231C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P0p-0005ft-2B; Thu, 17 Apr 2025 09:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0Z-0005TW-81
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0V-0007tx-ON
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso5880675e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895415; x=1745500215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uw5NN7Xo5UOrJyhClnps6dKALo3bScAPHLwVEEE8AFY=;
 b=bVN3uCWA6o/P4xnhLY/AI6/kxPGoRfRi3wl03rh7l1mfJ4/VW8x1qd7wjRHkL6uGWj
 perX4v51F6E6grVda2KgshTRE/xWQrh6KT2Fj9ymkNSnuOAWG46IaTE0NvZjTHXS0Ljt
 1pCv2nkdUm+ynnCMQXQDnTtPdJIBzO+7m+6itnoDo1ltbyvihsSz0MQmhWZvM1OV+JxY
 VHyfAmhng0SjMTq7haMn1DznqrUOKjDJRig9MRDZVRtH6dJZJJfPfnPhEmVOimHYh/vG
 HaHAfNsoC4wMrOwM1R4H1PiBL0s5T7xcDcT5Gz5wl7VegLMF3fj72ONVJNtBYrmyBjRX
 n3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895415; x=1745500215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uw5NN7Xo5UOrJyhClnps6dKALo3bScAPHLwVEEE8AFY=;
 b=JWUGE99Oo9X/06iB9adg7sajrI+D7mp1FXpqNB6nsrD3YOH1NgwPyVkTGateAhn3Mo
 q4Yw3Qj3mMGcY431Z9AkvyP32e9+ltZrbbJUdWBaehMtr8b21hBRSbLit+qg3GLdTfwh
 4T6C12Zh1J/P3zq3tb3T97XdYAJLS/MtiRTYUedXstN1fNH4ALU8hxFLv1WjKYzqv7oo
 f3niXeZ1lq15NzHLcziWEAbVdfJyj0FOHCf+rbBwDPeALSWhbDAPjBL+liPg4z3QrjWf
 mTqNDEgGhma81+yQTsx5wgyubN/xfiXQHWACm4HIZyadtIPfzaPsRw3/b7b95MMuTOOM
 njsg==
X-Gm-Message-State: AOJu0YxqS1cLvjVx4qIvWF1caVlnN23ty8O/ZujOBy4vNj7mJLmZaGog
 0BH8qe/RiZSVes6yZS52oQjr4prC1lW7ubNa+pjZuqa866tSavCanJjXncvpi25/TmlJoINlLNt
 X
X-Gm-Gg: ASbGncuLt0AL9v2dkXk6QE6zHhDzBQ8BLnpt8sMhugV8YqhtHKU6t2jOMiObI4DzRuf
 BYVgNdVUxBKEWx5eUgTjyRy58lnEU1DRIa8bElH2igWJWlc14sFBnGB2/q3HpIGJTPJgFnWxsiT
 p0nPp6IRHJO3zBZqQNhZQrXr7ysCyzD2jiWisYkzGSvL1NqK+0ync45Bn2hpVRR68qsMNKMu34j
 JLkmxFbNYWTw3Qj2UpLxLq4ykwGEP/7OZAVOtuxT9fWGXenq3wgxf/27sN5TJBiZZvzNwRMa+J8
 zDn9In1R83HqwgwBeHbhrFsygAPmUisbvuXcBw7W/xP+TAvuGgOTS86eOwn+X7TBCRaJK5XsPF9
 ES3xV9F49TgKCJT8=
X-Google-Smtp-Source: AGHT+IFNB9mzDknxD9OlmHxbJ96LDCXMMXdb0R0o74lJrExCbfJUCOkuLnEsFNrsnOiZARj5fzGKug==
X-Received: by 2002:a05:600c:4f8e:b0:43d:fa:1f9a with SMTP id
 5b1f17b1804b1-4405d6cea58mr56540255e9.30.1744895415445; 
 Thu, 17 Apr 2025 06:10:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4d3453sm52906815e9.16.2025.04.17.06.10.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] accel/kvm: Use target_needs_bswap()
Date: Thu, 17 Apr 2025 15:09:58 +0200
Message-ID: <20250417131004.47205-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
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

Check whether we need to swap at runtime using
target_needs_bswap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7c5d1a98bc4..28a32afb209 100644
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
@@ -1319,21 +1320,21 @@ bool kvm_hwpoisoned_mem(void)
 
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
+        /* The kernel expects ioeventfd values in HOST_BIG_ENDIAN
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


