Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98448C27C75
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQs-0006f8-Gf; Mon, 10 Jun 2024 02:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQl-00069r-Et
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQj-0004f3-NL
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35f236a563cso498206f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000576; x=1718605376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=km+J4/bxGtBeLJ5xF5e7gXgDE+TBo1niqUyibMuzvFY=;
 b=bVAYOUp5aWMcCTzJ5/l/vYB3goZW3gdoDUq6DHlKHoINjGdZ/nytaqMGA+0UD+aQOF
 pmoL6ryFztpdabwwN0bVxZZ9Hu87LCMGMHXqudURqziEjG8KJNOZLdJAeuuR4NHvy86O
 0CkmbCZmhJgdMcpCOrKXh/4gZaAX3UfCcMy7ZHZFG69Ot36H19eQ+7e0F4i4QSteyNPB
 i6J1j+0SOCHH/lGns4HtgjcAhSzL3TbCeOExZidtVgld95jNAaNDNBvQhBNpq4/T6hZi
 mDQlI2P40sIJ1OnPhwOQTPE5OOFoLSKMgxlQGx3C2pwqLouojOi+0d88mAyUSRCdsNrc
 tqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000576; x=1718605376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=km+J4/bxGtBeLJ5xF5e7gXgDE+TBo1niqUyibMuzvFY=;
 b=OCzk2ryupn7z1PoO5tV3sypr+OUTNc0/s6kARXasaduzJtVd6uj55+35QPPrPxvaWa
 rGQOd/2LVOcd0RVom4MdLfbpwaH0E/eGCkfNpy5yAKwBGZOIgWccaseleGsY7z+c58Uo
 uV7aetl8uRt2xp6c1v3K67Ld4b4+wPpPfBTKN551o5Wizcr0oKeP1Y741toDlownlFFv
 gRrEDNNZaxz7XbofkVQ42g+EZ3cnMX7oeqVGOC7+QoxreoH9CO9dfbkQiMX+Gb4NkVyG
 agyfYrJOhrdR+IPk2b2moEr/sW27DHLW6OAuk7nXY2ZC7vFDU1ez3OfFKoL+YaZuy0Ht
 Trxg==
X-Gm-Message-State: AOJu0Yy/Dxui0NFAyBmT+GFlNz24b39vJYCy+gkCkZ900xGfnbpo/O1W
 sk7ZBjPRBKMBWgZvROunQpdxy8o7bPSkey/SYiCw/TaQ02ixAJOYifcYqCzjo07iTSAZuXZHZZC
 r
X-Google-Smtp-Source: AGHT+IGc4AMdVXUYVeU4xncjcgknl/G4CgnaqCd0liKnpgoEdp1g818Ovthpl0/uAjaP9VlQot3eEQ==
X-Received: by 2002:a05:6000:186c:b0:35f:1c3c:56b8 with SMTP id
 ffacd0b85a97d-35f1c3c5723mr3525178f8f.36.1718000576053; 
 Sun, 09 Jun 2024 23:22:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f271ead7bsm766337f8f.20.2024.06.09.23.22.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/26] hw/ppc: Avoid using Monitor in
 xive2_end_queue_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:57 +0200
Message-ID: <20240610062105.49848-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h |  2 +-
 hw/intc/xive2.c             | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 37f572ed6d..4d32703c26 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -132,7 +132,7 @@ static inline uint64_t xive2_end_qaddr(Xive2End *end)
 
 void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon);
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
-                                    Monitor *mon);
+                                    GString *buf);
 void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
                                   GString *buf);
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 23356acff7..6a15b4d1e4 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
@@ -40,8 +41,7 @@ void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
                            (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
-void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
-                                    Monitor *mon)
+void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GString *buf)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
     uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
@@ -52,7 +52,7 @@ void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
     /*
      * print out the [ (qindex - (width - 1)) .. (qindex + 1)] window
      */
-    monitor_printf(mon, " [ ");
+    g_string_append_printf(buf, " [ ");
     qindex = (qindex - (width - 1)) & (qentries - 1);
     for (i = 0; i < width; i++) {
         uint64_t qaddr = qaddr_base + (qindex << 2);
@@ -64,11 +64,11 @@ void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
                           HWADDR_PRIx "\n", qaddr);
             return;
         }
-        monitor_printf(mon, "%s%08x ", i == width - 1 ? "^" : "",
-                       be32_to_cpu(qdata));
+        g_string_append_printf(buf, "%s%08x ", i == width - 1 ? "^" : "",
+                               be32_to_cpu(qdata));
         qindex = (qindex + 1) & (qentries - 1);
     }
-    monitor_printf(mon, "]");
+    g_string_append_printf(buf, "]");
 }
 
 void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
@@ -108,9 +108,14 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
                    priority, nvp_blk, nvp_idx);
 
     if (qaddr_base) {
+        g_autoptr(GString) buf = g_string_new("");
+        g_autoptr(HumanReadableText) info = NULL;
+
         monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
                        qaddr_base, qindex, qentries, qgen);
-        xive2_end_queue_pic_print_info(end, 6, mon);
+        xive2_end_queue_pic_print_info(end, 6, buf);
+        info = human_readable_text_from_str(buf);
+        monitor_puts(mon, info->human_readable_text);
     }
     monitor_printf(mon, "\n");
 }
-- 
2.41.0


