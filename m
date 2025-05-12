Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4115C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJaj-0008KG-Pk; Sun, 11 May 2025 23:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaU-0007xp-Eu; Sun, 11 May 2025 23:12:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaS-0006p8-56; Sun, 11 May 2025 23:12:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso1283481b3a.2; 
 Sun, 11 May 2025 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019532; x=1747624332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ez2P7YkVqE8UhmrvzuTG/CN/hYwfRFuvoKT/P29BPa8=;
 b=Xeyu3afTxKwUHonEbGSQbZ2BjaLqMwisujdA590Gx2/SQdlhF1Q3gQwNgxQvEHwf86
 sFO2pNvHnSJq34PqLMrVx1eDiciHu+sLnFZwJ4LhMx+LeYqmRqifChGvb85xuw6SLmHd
 O1lAY/WvztBit2pLO3pw1TI5AUzBqiXbMWKO7plQjwQMBUjudhukhjG7c8FTHJ9hplyV
 yVchQtxLshJBIr7iojXPUKnpYGaP1sud4G0p3IjoqFM8YnN6fJV0hvFFdkQUfUcr2iGK
 1rC2i5dZ+6/gl67a5xaIunzNgclR1iXAfX6U5y2VnDLIJT6F3OrZh3LSj815rNNEXppq
 Cq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019532; x=1747624332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ez2P7YkVqE8UhmrvzuTG/CN/hYwfRFuvoKT/P29BPa8=;
 b=dIHYCFk6ye/uM1BJolzuePv6G3hdy6tsvzBhlI89OV8+06wboPxU+QtcmQ2DXcokHF
 K89E8SlfAyqttFUuSMdRyw+OCKHpRuavvCxh3lP9PKRCc/H+8TnxFaonO7txKL7RHcJs
 WlYD+PT4PmDLt9K0lRnuzJt3tv4rPA6AGeuepPB76lvnYGdddmAqhWbdp5mtfyoxkTsi
 WWOFZNk0PqEHnhZuz0RnK7IOoChQy6Fnxz8E1KlhvxIOwMquBG3bD2LtlEihekL/8Caj
 P9v0oRdetU6lcrPkgy03CBdIQKNR4282sSearMCIUj4qZEqbQUalNXPcHsBPnME0eCBB
 f4fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj0E5Pxb1dwJ3is3F14RJRDjHTS0lJGMwhruEky9Pc6hV5XZSBJI4nq4ri9/7T494d4Lq4l6pMj5VV@nongnu.org
X-Gm-Message-State: AOJu0YzmoUsrLcZ602pgnOXvkkbJscivZW2EFtsTj4s5z507uIEfiRPW
 vHcQF641RpwZLkHXnF+xNnez5ia5XreKghcvE2JXxv6jo9yFPiKtOiZVvg==
X-Gm-Gg: ASbGncuatoWZQfk3K9TSD/MgFpc3+UpMyDKp/S7skwkITSaHe6YIhdqOZ5IWB1o3ANX
 Nh81AALeA4HtYmSeUaPi4u1N+c0ao8f3HRNjZQ/y2vbefGJ3TQ+W253WZh3jk8dQCH24BOW/3d6
 wITXv1tCBrqtcGyWuPJdFVgN+2jV5839AHR3dp+Tfi6S1xf/NzDA6JPcgb6bvfc4MJn3w7/5C6l
 VCVn7+/WcgRzChK7/wAGczBFozV2Tv4AGvIyDVwd6XW6Jsy0jitvjnb2Oaf1WJ6xIw4+WvftcHR
 eJ71yvgtP8zodgId7aUU8cnX/IgVc7Blzxeo6q/yI+xx5sOSg5wjcDzDuQ==
X-Google-Smtp-Source: AGHT+IEuvxpis682XCpzEUjhwWiDFCZ5dgrIf0wyoRUaopVmgha3xS7zPP+66FBSoLmAngGUkqSfSw==
X-Received: by 2002:a05:6a21:3183:b0:206:ad2b:aa9a with SMTP id
 adf61e73a8af0-215abc78d33mr18893060637.36.1747019532148; 
 Sun, 11 May 2025 20:12:12 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 17/50] pnv/xive2: Support ESB Escalation
Date: Mon, 12 May 2025 13:10:26 +1000
Message-ID: <20250512031100.439842-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Add support for XIVE ESB Interrupt Escalation.

Suggested-by: Michael Kowal <kowal@linux.ibm.com>
[This change was taken from a patch provided by Michael Kowal.]
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 hw/intc/xive2.c             | 62 ++++++++++++++++++++++++++++++-------
 include/hw/ppc/xive2.h      |  1 +
 include/hw/ppc/xive2_regs.h | 13 +++++---
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index de139dcfbf..0993e792cc 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1552,18 +1552,39 @@ do_escalation:
         }
     }
 
-    /*
-     * The END trigger becomes an Escalation trigger
-     */
-    xive2_router_end_notify(xrtr,
-                           xive_get_field32(END2_W4_END_BLOCK,     end.w4),
-                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+    if (xive2_end_is_escalate_end(&end)) {
+        /*
+         * Perform END Adaptive escalation processing
+         * The END trigger becomes an Escalation trigger
+         */
+        xive2_router_end_notify(xrtr,
+                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
+                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
+                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+    } /* end END adaptive escalation */
+
+    else {
+        uint32_t lisn;              /* Logical Interrupt Source Number */
+
+        /*
+         *  Perform ESB escalation processing
+         *      E[N] == 1 --> N
+         *      Req[Block] <- E[ESB_Block]
+         *      Req[Index] <- E[ESB_Index]
+         *      Req[Offset] <- 0x000
+         *      Execute <ESB Store> Req command
+         */
+        lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
+                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
+
+        xive2_notify(xrtr, lisn, true /* pq_checked */);
+    }
+
+    return;
 }
 
-void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
+void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
 {
-    Xive2Router *xrtr = XIVE2_ROUTER(xn);
     uint8_t eas_blk = XIVE_EAS_BLOCK(lisn);
     uint32_t eas_idx = XIVE_EAS_INDEX(lisn);
     Xive2Eas eas;
@@ -1606,13 +1627,30 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
         return;
     }
 
+    /* TODO: add support for EAS resume */
+    if (xive2_eas_is_resume(&eas)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "XIVE: EAS resume processing unimplemented - LISN %x\n",
+                      lisn);
+        return;
+    }
+
     /*
      * The event trigger becomes an END trigger
      */
     xive2_router_end_notify(xrtr,
-                             xive_get_field64(EAS2_END_BLOCK, eas.w),
-                             xive_get_field64(EAS2_END_INDEX, eas.w),
-                             xive_get_field64(EAS2_END_DATA,  eas.w));
+                            xive_get_field64(EAS2_END_BLOCK, eas.w),
+                            xive_get_field64(EAS2_END_INDEX, eas.w),
+                            xive_get_field64(EAS2_END_DATA,  eas.w));
+    return;
+}
+
+void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xn);
+
+    xive2_notify(xrtr, lisn, pq_checked);
+    return;
 }
 
 static const Property xive2_router_properties[] = {
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 8cdf819174..2436ddb5e5 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -80,6 +80,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
+void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
 
 /*
  * XIVE2 Presenter (POWER10)
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 3c28de8a30..2c535ec0d0 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -39,15 +39,18 @@
 
 typedef struct Xive2Eas {
         uint64_t       w;
-#define EAS2_VALID                 PPC_BIT(0)
-#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ block# */
-#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ index */
-#define EAS2_MASKED                PPC_BIT(32) /* Masked                 */
-#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the EQ */
+#define EAS2_VALID         PPC_BIT(0)
+#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(unimp) */
+#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
+#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# */
+#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index */
+#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
+#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
 } Xive2Eas;
 
 #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
 #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
+#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
 
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
 
-- 
2.47.1


