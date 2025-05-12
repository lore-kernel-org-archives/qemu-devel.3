Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57BEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZh-0006xf-HZ; Sun, 11 May 2025 23:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZf-0006wl-Nk; Sun, 11 May 2025 23:11:27 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZd-0006im-Ov; Sun, 11 May 2025 23:11:27 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30c35ac35dfso2838031a91.1; 
 Sun, 11 May 2025 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019484; x=1747624284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoP5Rwmzwa91xzV/AyP+VdPUdzZjJco7/2dUQOhnjSA=;
 b=e1xBUGGjNuTspZTQGgogPx2e1nGLstJA8v6hkz4oKmKvLh8itjXd3M0KDccdcOXeHo
 Nk9zBpOUmKuwO6S4AI/AeCy4QAPSsGqt2GPijZJPPmcR8mlEODNmTg3beZ7VT++FaTVh
 DtRwK2p/usIDmxoxF21qWWkD58XN0bCpzxIXLSaLLD10meNtZEqiYQmhoC6JNKwAWj07
 kjTICjf8jpIY8XCLN570y3uZzt0O5U0hrhKXwEEJWOxefR7wqOTANTStTxP1LoROXMbR
 7DCDcTPxDVzqAI4wY49PuQPfkY7a6ZaLgC9ADnMfQXGnd9KFMa2ZzFsg00FCZF7o7tur
 DQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019484; x=1747624284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoP5Rwmzwa91xzV/AyP+VdPUdzZjJco7/2dUQOhnjSA=;
 b=fEP5ZQkIUWvD7xPFbDdEgTBvbrt303o19L32+eLD6gW2LDbLGBKetNhroJPN/82Nnb
 pqDXSKLpUfMVIOfiI59e1kTmHDWFLZF5HJ6GTEsVtnyvuFyrBC+R6UYY1i9flstdbZUF
 tu3fWJmCk9Kh2DVF/ArBj5foSemSrT4N/c5R2lOJPKLHGwCRtJpxXVtYR+EPUdjsB6dn
 r2lF7UqiKfdwCRQ41BNVVFFm67dp6Dmo4+cWp1JouG9AtblCHLd9dV3N305NrpwhDQ3f
 WImCL7cq865dCoqpNkXlMz49BZq5+zUDXT8cIcKVHJPhL3B6Ze90v62PcbHO1CuZ94kt
 BxQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVleOcoPCaUgg77nt0uP6QgNbs41JUoHAZLgAekeAKMW5OgHKz6q+6zlTKfV8G+l8DCs0/Y3YD8T+AY@nongnu.org
X-Gm-Message-State: AOJu0YwF2e5vOb0Ve9eE8U7giKWiGmzab8+QE7cjKphwR8oTwKfZWVPA
 xhBVviopHz3y9zYPDgD+VABgoA2sVvB00GuDiA6hc+KSAP4SlgDjxJsPjg==
X-Gm-Gg: ASbGncsKgbDrMNIkZru963hc+OItIvFmmYFpgXy+JJ24/Ev9ElddFzGIGgc1jy+SgUL
 qbV6MXKWAkv4p4hTB6F28kPUazYLIuxWO/T7/CLqfH7RBD6rOWtWEz11IbZHFvGRzv/psLRMOzK
 W376vkgujSKAr10+8UxtZ7xhnL9rCV0TxsMTGDFZZnKMZhXM/c26Y+KxOUbw5cLCKJXo6m+D7Tj
 kLshcjAqzqIVRQismCAgLPwMhL/scLGRIKIJMsX9yVBTRrcmDvWhTrLkF/UynVE0WWntjZRUet5
 ZDfjPYtYnjLXkdqJqfAY3pOOJsuhykDH9GpT3OXm4KPLRSY9DMAAjT8GLQ==
X-Google-Smtp-Source: AGHT+IGfysmRXbbks6M79gdzJcq4ifce10xsyh7E79YzsC0KH78OsXG0yJdbWFV99skYBY5vn9I3+Q==
X-Received: by 2002:a17:90b:554d:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-30c3d64d8c9mr17322932a91.29.1747019483583; 
 Sun, 11 May 2025 20:11:23 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 04/50] ppc/xive2: Remote VSDs need to match on forwarding
 address
Date: Mon, 12 May 2025 13:10:13 +1000
Message-ID: <20250512031100.439842-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

In a multi chip environment there will be remote/forwarded VSDs.  The check
to find a matching INT controller (XIVE) of the remote block number was
checking the INTs chip number.  Block numbers are not tied to a chip number.
The matching remote INT is the one that matches the forwarded VSD address
with VSD types associated MMIO BAR.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index d1713b406c..30b4ab2efe 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -102,12 +102,10 @@ static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
 }
 
 /*
- * Remote access to controllers. HW uses MMIOs. For now, a simple scan
- * of the chips is good enough.
- *
- * TODO: Block scope support
+ * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
+ * scan of all the chips INT controller is good enough.
  */
-static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
+static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     int i;
@@ -116,10 +114,22 @@ static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
         Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
         PnvXive2 *xive = &chip10->xive;
 
-        if (pnv_xive2_block_id(xive) == blk) {
+        /*
+         * Is this the XIVE matching the forwarded VSD address is for this
+         * VSD type
+         */
+        if ((vsd_type == VST_ESB   && fwd_addr == xive->esb_base) ||
+            (vsd_type == VST_END   && fwd_addr == xive->end_base)  ||
+            ((vsd_type == VST_NVP ||
+              vsd_type == VST_NVG) && fwd_addr == xive->nvpg_base) ||
+            (vsd_type == VST_NVC   && fwd_addr == xive->nvc_base)) {
             return xive;
         }
     }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                 "XIVE: >>>>> pnv_xive2_get_remote() vsd_type %u  fwd_addr 0x%lX NOT FOUND\n",
+                 vsd_type, fwd_addr);
     return NULL;
 }
 
@@ -252,8 +262,7 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
-        xive = pnv_xive2_get_remote(blk);
-
+        xive = pnv_xive2_get_remote(type, (vsd & VSD_ADDRESS_MASK));
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
-- 
2.47.1


