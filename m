Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC586C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHv-0000qt-Pb; Mon, 14 Jul 2025 19:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHN-0006Gg-Bm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHL-0005et-I8
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbxQM6MkMC8CfUCcdkREoYX34HGmxCh+T/dmT65bbE8=;
 b=A5sdu4TRDzVAH89L44veXBaHEUMzq8pPtSn7HKBChQb8ptng1nKoyfHM5WiiwnY1V7xZN3
 kCN18ZgJfma0evNs5Vy+Uz6Isi8paaJVgSKSz+M3d+k5Q0ElPec9I4T9vb3sshX2hgpkQi
 KFu+jk+0KjnvQu6b/5dIrhsCbHnubt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-jEAMHkKVOICWUa3jJS8B7w-1; Mon, 14 Jul 2025 19:08:09 -0400
X-MC-Unique: jEAMHkKVOICWUa3jJS8B7w-1
X-Mimecast-MFC-AGG-ID: jEAMHkKVOICWUa3jJS8B7w_1752534488
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso37909345e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534488; x=1753139288;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbxQM6MkMC8CfUCcdkREoYX34HGmxCh+T/dmT65bbE8=;
 b=fmnUz/vi8+XKayw/GHw1cHTw35UjPH9mcyHvad7lkbi2GPXGTRAw0zMbA0RyPRzu6o
 Ygo3XxUuj+5MBuzWWZadDKUf4cRxlVaG8MPnVU71ygZ2z045VW6e/19FZI+HwQBvB3HP
 oMwwUmLg4FkcYemLQRGzgicwX44mRRLtHcBLiMl7WS06UyCl+X7aP5Mp0iOjg4HECh3W
 zjitrzrcNMgRVYMkqoziWvmW0DZRXEpFkQANSIiLwcrxS8th9SICGxl3sF/58N9Ma9e+
 EegvjWuY4YxbdN5mx6i2+xURG5ekYhEgcALnyPuWf2gjU2EDMDeFyDnkVPzkAyD5N9vZ
 LbCA==
X-Gm-Message-State: AOJu0YxJ7O1Bdu7Som8pzvdGRuT0itA/weG+VOFgjl2KEN84GFKkWKFO
 +TkqmhROtRNZIIoN+3Xx/T3F62ueuDpEBruHgoc/PzVvUx4nq50jMoylvEfmardunZdfY8L789F
 bp8xjwRtgCG05ytIQzXgaFY4FRMUTAyIikDthRjpTrkzXMSy9oV6kft7C52eG9TxR4N2vE2cHF1
 aU0+DQX4ieSBHt0WaQ8EzqMxtD1nytg7nx6Q==
X-Gm-Gg: ASbGncuqy18poJgHZh0uiWCT0Ide546IUJv4YeIlcd6P0Kws/jGUS6Er0U4gZuRKrTE
 b9Qk8Xh3yrePVk1fbkjMTgqRkUHyMhwHu2FjpPKz6JC8E6gZ+WoVgCaO099A4dBA9kkDH32Geyg
 PV7gD+DVznyzl9QEAsefveEisHVyRu+HVktK0R9lJWMF9Ws8NoipFubbVU3yArmZKlsFWNk8e2p
 tT7adDlMV1Wg8/ldFgVKDtpVghCyHy9GgbBkK5SNpiCTBVXM/Rv3c8z6OaHAeB71d9RVgaDRpjg
 8TVBMSJEK0ytS3C1mjRfM3cAmKV2FRT/
X-Received: by 2002:a05:600c:a03:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-454ec14d7a9mr133129945e9.6.1752534488144; 
 Mon, 14 Jul 2025 16:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcK+6c/Zuwu4v8gbquTOu2jYiwSmqqsPM6OBxRXI6TfGcuA4e3RJBMMsOKw4r+EcX7BYHMHA==
X-Received: by 2002:a05:600c:a03:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-454ec14d7a9mr133129755e9.6.1752534487651; 
 Mon, 14 Jul 2025 16:08:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd180fsm13367383f8f.2.2025.07.14.16.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:07 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 44/97] gdbstub/helpers: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Message-ID: <617017448439fff450932b19c9eab17c8904e4e5.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition. Use cpu_to_[be,le]XX() from
"qemu/bswap.h" instead of tswapXX() from "exec/tswap.h".

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250708215320.70426-7-philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/gdbstub/helpers.h | 48 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adc..b685afac43 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -16,7 +16,8 @@
 #error "gdbstub helpers should only be included by target specific code"
 #endif
 
-#include "exec/tswap.h"
+#include "qemu/bswap.h"
+#include "qemu/target-info.h"
 #include "cpu-param.h"
 
 /*
@@ -33,40 +34,49 @@ static inline int gdb_get_reg8(GByteArray *buf, uint8_t val)
 
 static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
 {
-    uint16_t to_word = tswap16(val);
-    g_byte_array_append(buf, (uint8_t *) &to_word, 2);
+    if (target_big_endian()) {
+        cpu_to_be16s(&val);
+    } else {
+        cpu_to_le16s(&val);
+    }
+    g_byte_array_append(buf, (uint8_t *) &val, 2);
     return 2;
 }
 
 static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
 {
-    uint32_t to_long = tswap32(val);
-    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
+    if (target_big_endian()) {
+        cpu_to_be32s(&val);
+    } else {
+        cpu_to_le32s(&val);
+    }
+    g_byte_array_append(buf, (uint8_t *) &val, 4);
     return 4;
 }
 
 static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
 {
-    uint64_t to_quad = tswap64(val);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    if (target_big_endian()) {
+        cpu_to_be64s(&val);
+    } else {
+        cpu_to_le64s(&val);
+    }
+    g_byte_array_append(buf, (uint8_t *) &val, 8);
     return 8;
 }
 
 static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
                                  uint64_t val_lo)
 {
-    uint64_t to_quad;
-#if TARGET_BIG_ENDIAN
-    to_quad = tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#else
-    to_quad = tswap64(val_lo);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-    to_quad = tswap64(val_hi);
-    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
-#endif
+    uint64_t tmp[2];
+    if (target_big_endian()) {
+        tmp[0] = cpu_to_be64(val_hi);
+        tmp[1] = cpu_to_be64(val_lo);
+    } else {
+        tmp[0] = cpu_to_le64(val_lo);
+        tmp[1] = cpu_to_le64(val_hi);
+    }
+    g_byte_array_append(buf, (uint8_t *)&tmp, 16);
     return 16;
 }
 
-- 
MST


