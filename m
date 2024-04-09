Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F77CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruC10-0006mk-0h; Tue, 09 Apr 2024 09:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC0y-0006mJ-Vg
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:59:56 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC0x-0004LZ-Ea
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:59:56 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a51a7d4466bso500384566b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671193; x=1713275993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d4Pf+e5xlZoPOTwBIco4FU0UwZBSRn1p8fSkttjbGE=;
 b=GVKufjhmH+own+ZgS0uYhLknGR5rjVAaKTk/Np23ilpZg9eAURExMHvSD9enx0nWbz
 ETpXIN12StbFD4vsIAp6jEgL6wlsYMZr5RXMTZX1uBzZMtd2BHf9/p9TlbsfYDYT07ys
 eB/RptfwcGnIMFhflW5rXVskxKtE+UCRonhME16I13UsNcroV034PHd8xJSdGdWmWuXy
 cbwqPC7h2eaWVAg56zK5RKpRS+4eWFKrJEjV5UXSqYwqw2elxCtYUq8oNgQwOeYmH2zf
 y5gvbVD7gU829g1tteaodN9ep9VI0ra0X4RL6vTzzlk0Jy6ZV7f1dxs0g+T50orPvZuy
 jLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671193; x=1713275993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3d4Pf+e5xlZoPOTwBIco4FU0UwZBSRn1p8fSkttjbGE=;
 b=CEM4BHqpTOor5JqOzDZSZmrcWB2yMnSk3eaMfpn38+dssJRm+gqTzOsWOkLIvT8Mtl
 9K5xQ5uZHhzQZtBCc8AI9DgCLLwP9F7vSL9tddKIwQ1NCcVPsAnzVYZ28lC9a2dMwU+W
 P+khUEzzPJf7YkIB68+2voARxXRaDgb0graiVnaUMuMM3lqW/tLJm8WJUN4PP0yNWJuV
 OCpF69xYUAwP6Rdw4fM8Uz66aIGH8/VXdZJ/YAiW0w8GXOk2Nate9gzq9laSlBtbmj6m
 /dDSOWL3/dWNXQSrghtqsemrT/8LC23OnMcJpR2SiSZnv44x9aJYA/Ykjcjwj2BPjDha
 dq2A==
X-Gm-Message-State: AOJu0Yxre1pSYRNo05DhHhQqZ/PbGfjWqh+n2QnQ4QRLStKFdJYuXxv5
 RX5CwFvA6aq470ATdcZ3VKHuWH5EkSbEqoIYNOd5mNr/3mPI5jg4QOjh+WuAu3g0brg6SgORwJs
 U
X-Google-Smtp-Source: AGHT+IHxgDsZQRNp74LolrrMDt77+Rbtc0td2hM1AVbJY4bfmMJcPDK1bAUr/s/EaBzNme/osZvqNw==
X-Received: by 2002:a17:907:84b:b0:a51:df52:5a65 with SMTP id
 ww11-20020a170907084b00b00a51df525a65mr3604970ejb.2.1712671193421; 
 Tue, 09 Apr 2024 06:59:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 ld11-20020a170906f94b00b00a51d8a3a632sm2345694ejb.168.2024.04.09.06.59.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:59:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: Qiang Liu <cyruscyliu@gmail.com>, qemu-block@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-9.0 v2 1/3] hw/block/nand: Factor nand_load_iolen() method
 out
Date: Tue,  9 Apr 2024 15:59:41 +0200
Message-ID: <20240409135944.24997-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409135944.24997-1-philmd@linaro.org>
References: <20240409135944.24997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/nand.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index d1435f2207..f33eb2d552 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -243,9 +243,28 @@ static inline void nand_pushio_byte(NANDFlashState *s, uint8_t value)
     }
 }
 
+/*
+ * nand_load_block: Load block containing (s->addr + @offset).
+ * Returns length of data available at @offset in this block.
+ */
+static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
+{
+    unsigned iolen;
+
+    s->blk_load(s, s->addr, offset);
+
+    iolen = (1 << s->page_shift);
+    if (s->gnd) {
+        iolen += 1 << s->oob_shift;
+    }
+    assert(offset <= iolen);
+    iolen -= offset;
+
+    return iolen;
+}
+
 static void nand_command(NANDFlashState *s)
 {
-    unsigned int offset;
     switch (s->cmd) {
     case NAND_CMD_READ0:
         s->iolen = 0;
@@ -271,12 +290,7 @@ static void nand_command(NANDFlashState *s)
     case NAND_CMD_NOSERIALREAD2:
         if (!(nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP))
             break;
-        offset = s->addr & ((1 << s->addr_shift) - 1);
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, s->addr & ((1 << s->addr_shift) - 1));
         break;
 
     case NAND_CMD_RESET:
@@ -597,12 +611,7 @@ uint32_t nand_getio(DeviceState *dev)
     if (!s->iolen && s->cmd == NAND_CMD_READ0) {
         offset = (int) (s->addr & ((1 << s->addr_shift) - 1)) + s->offset;
         s->offset = 0;
-
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, offset);
     }
 
     if (s->ce || s->iolen <= 0) {
-- 
2.41.0


