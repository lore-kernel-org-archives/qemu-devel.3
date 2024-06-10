Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA108C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYRf-00049X-Pm; Mon, 10 Jun 2024 02:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYRe-0003zO-K9
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYRc-0004ps-Lw
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421b9068274so5264165e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000631; x=1718605431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYilv7Qw7hhLPwOWxXzn16HBO3Z9l6H4QsXbLEJ0kt4=;
 b=eP4kWX8Y9Qlb56BlFMvfXKlFq6nW/zJc6LoTZpJA7vURfiBCfYN1uxl+A0fZQ79qbx
 +hxeI8kt39fk+kEXjihdeBt7vm99SAxCEFCOd8xollQHx1DOJxLq86WiIwTd271RFimU
 SRAHJnEce5ydT8f/fVShN6hIgDCg1TOQ6lzZ8CXdQHzkwxvgyhKqycX8Yzlf7ixmmkwO
 ntIT0pn72fYcMT/FDvkne34aazjeXxM3PmPMQ8zrj2UyJ8MdTEO/i5etSSgKeIrr+GMk
 wNqWsbpyHeYUq+d+2YEV4jzr3bALtFDv25LNBleHaq22Cin1IPTGRDWLR19OXClbBoTj
 Dmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000631; x=1718605431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYilv7Qw7hhLPwOWxXzn16HBO3Z9l6H4QsXbLEJ0kt4=;
 b=m0QNVTeIy3cnwkvMgsBX3w6I1n7yUh07NKkdw/ySMNmu2Spy8DZMArhb8KZUQE7CjS
 LGJS4MJtsyGoKxk1fwkAaZPECQT/Ge4wjs8Aq4Fz+jb9sGPzPrCofX/C5bWBsTD5KRtW
 QuOzuv5Rc5eMjU8GOy09Wz1ufNwaFDnoGfJpSregw7a8hYB5mquVZK0dx3BgLHldMF9y
 jam6xnaER/FxhGqZf3NgZpaLM5EgflUVrziJerzAKm/tdYlpT+9Q5HLwK7qo7NnfdK6D
 4zLV6DScOKGixRXjbZhrcW4Is/OLD1tOCNiwBfVI7tGtz3d0J+/OM/bZOJvtY0CVd32U
 vocA==
X-Gm-Message-State: AOJu0YwkaoEai85oDXPXRKeZJJKtKKCI00fxXZ6BX1YEqkA89dH8o7YT
 j50Jx/k62u/ASJoLk6swYQZiZyGfeg3BbtQShtsvm136C+mCUaipqKeC8jTo2xgA22RUXmv2x1r
 Z
X-Google-Smtp-Source: AGHT+IFhY52DjZzwO/AkrrMFGdXL8HyAvX/RdUgSQZt/1MqEOPP3whLwVWaG1fpKSb+9zQA2M0zhlw==
X-Received: by 2002:a05:600c:4f07:b0:421:6cb5:c914 with SMTP id
 5b1f17b1804b1-4216cb5cb49mr59850335e9.37.1718000609739; 
 Sun, 09 Jun 2024 23:23:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c1aa1desm131072945e9.11.2024.06.09.23.23.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:29 -0700 (PDT)
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
Subject: [PATCH 25/26] hw/ppc: Avoid using Monitor in
 pnv_chip_power9_pic_print_info_child()
Date: Mon, 10 Jun 2024 08:21:03 +0200
Message-ID: <20240610062105.49848-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 hw/ppc/pnv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5b9dbff754..9039c1777a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -789,18 +789,14 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
 
 static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
 {
-    Monitor *mon = opaque;
+    GString *buf = opaque;
     PnvPHB *phb =  (PnvPHB *) object_dynamic_cast(child, TYPE_PNV_PHB);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     if (!phb) {
         return 0;
     }
 
     pnv_phb4_pic_print_info(PNV_PHB4(phb->backend), buf);
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
     return 0;
 }
@@ -813,12 +809,11 @@ static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
 
     pnv_xive_pic_print_info(&chip9->xive, buf);
     pnv_psi_pic_print_info(&chip9->psi, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
 
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    object_child_foreach_recursive(OBJECT(chip),
-                         pnv_chip_power9_pic_print_info_child, mon);
 }
 
 static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
@@ -865,13 +860,12 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
     g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive2_pic_print_info(&chip10->xive, buf);
-
     pnv_psi_pic_print_info(&chip10->psi, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
+
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    object_child_foreach_recursive(OBJECT(chip),
-                         pnv_chip_power9_pic_print_info_child, mon);
 }
 
 /* Always give the first 1GB to chip 0 else we won't boot */
-- 
2.41.0


