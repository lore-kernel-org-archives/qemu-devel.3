Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34993C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAc-0003jM-He; Tue, 08 Jul 2025 16:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDcz-0002x7-8N
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:06:00 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDcv-00042K-0S
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:05:14 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60bfcada295so7717927a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001509; x=1752606309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFonhSB51r1m9DRDPq3gxW3IKaSRsXZYDkC267ansE0=;
 b=yXG9H428JSmZWcNHQxA2a6A4b2mp0YutzM7BMh1DCKoV2z5eQzfA6fFbzOI81ZVoHN
 o7F0jw0QEb0Q/KrDLdoy+uom/YOqIf/L/d+MW3H1y52bw7dZG0+4UkklvZgo0gmlkuPS
 qgG9m/3Zvd2DW6jG2AlVn9vq8TgH3MKLdBC0mMxRzGTxnDT1Gx1+4mNCJwuyVPHVxyML
 XTDpuS2t5m3Y3XVq+hvfYbun5kYJkU/uzb828uj4p+KsithwZKxkZf2wEVxaxdRpnM2i
 QHcW8/9qsUz9PSXPluwJeKv6+IOgjPH1mcWY7EG6+1yu/qF9/8Z9hWDPnawPb5dk049e
 iTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001509; x=1752606309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFonhSB51r1m9DRDPq3gxW3IKaSRsXZYDkC267ansE0=;
 b=IDTaiHUT9hKINacUow96+UOPFIPx82B9HshN+FEqHn0F3LkY8cswjPtNfYCPMaCDDf
 NOsj+0F7N50aeNar8DtSvB2eKwq3pFD/nlGtAIRJUN+WJpuOLdr6wps/Qt9eK6J4K7Ep
 9GxKIaQ3e1Rdrw5ak6PM/B/pf6BR8Z4cyGlmdVMmNvyWGPMNx/ADn4+eBS2LVtB+/EE+
 uuQ9CnG/Pwa+Os+BxVH0atEt8qs2QV2qXXGjV+3qALnbfMu2nBuDrsWeOIxw+alnnpye
 G3tf7y1sVqQ9FRrvPVaRQ3cDJahe9O0yPrCmavfDf3MKn8gZF2dXZYzEBv+WhFdls4n5
 N3Fw==
X-Gm-Message-State: AOJu0YyOEanXt9B71RRFKarkJPYsRfJtfBvNJ57+XnHJ0FOOKjFaoZq+
 xIIjFdp4KYyrv70lG4slLj25ALuhIHR8sDssVyh19WyTbkzfUelQ4uJ6v/TJQZkdwv1/fr6tgb/
 OW/iy
X-Gm-Gg: ASbGncuTsI0H2Ljy66WcmrNgERAYeW9DJDZTP80E3Z3mz5BUyAQOXX/8ctTxAFrDEHD
 jcZJWNLAFYwYE2PDdOnOT7nCkhHPFP/hdJmoNALbL28yc8q7JdOboS28SLdzqXGuCkapyf7gqfj
 jATKH+VBdwhdqdmBKAt6YRQlI8OjQy2ExHs6Wrq+v5mqo+tZ0Qbea5xYWbRyqp8V64RVcB174qy
 tIqP13GbVy63et6zw+LhX+0COf47TNgFb7eHUS41XCYsreau5m2Opm1j5mNzF4Ua5FjEvQReEyl
 A7a29eUCdTuhJKxICCwyN8kfJwvjoCs4YSJM3vxC60okFRLujLRti59No77WibvwoQXHW8etmQK
 fx+D1bSME3gHOlGRfAHpCJt2LmINyJFuC1jc7
X-Google-Smtp-Source: AGHT+IFEQ+Grn2rKXvnzGJpvoE1KkuW74qXxlvK4ke3uCqnSbhamEV2TgSUSqn/9QolpXsBttWVTuA==
X-Received: by 2002:a05:6000:713:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3b49701abf5mr13082687f8f.16.1751995380379; 
 Tue, 08 Jul 2025 10:23:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd44ffb9sm28311905e9.14.2025.07.08.10.22.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 10:22:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v7 6/8] gdbstub/helpers: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Tue,  8 Jul 2025 19:19:46 +0200
Message-ID: <20250708171949.62500-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708171949.62500-1-philmd@linaro.org>
References: <20250708171949.62500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adcb..1411b136d5c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -16,6 +16,7 @@
 #error "gdbstub helpers should only be included by target specific code"
 #endif
 
+#include "qemu/target-info.h"
 #include "exec/tswap.h"
 #include "cpu-param.h"
 
@@ -55,18 +56,14 @@ static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
 static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
                                  uint64_t val_lo)
 {
+    bool be = target_big_endian();
     uint64_t to_quad;
-#if TARGET_BIG_ENDIAN
-    to_quad = tswap64(val_hi);
+
+    to_quad = tswap64(be ? val_hi : val_lo);
     g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_lo);
+    to_quad = tswap64(be ? val_lo : val_hi);
     g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#else
-    to_quad = tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#endif
+
     return 16;
 }
 
-- 
2.49.0


