Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B082C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJav-00008c-0p; Sun, 11 May 2025 23:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaS-0007wn-1y; Sun, 11 May 2025 23:12:17 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaJ-0006oG-Sx; Sun, 11 May 2025 23:12:09 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30a8cbddca4so4501205a91.3; 
 Sun, 11 May 2025 20:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019524; x=1747624324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wggRaurDIsoV0nzI182xGTLzWxaSo30BybVq33C1vm8=;
 b=lBIhN0Fn0mZqDVLmC5Ch3VT5jxxvELhyCsToaGBZxJHyVQXwTiIf2AWhl82p5JitDc
 OCPagCisNjfj2jCGak4Tj/jd4PTR1UDC0r8vNbF8zjYY7zBxmhWW5fDv3q62fiK3pfKn
 QIZWF7X96uMZIUqylfL6H45IYxYsxlQJ+SccfrWO/hEGXp88eDvupiM1i7n6x7KfuwOw
 mgOcvhcBPCK97mv2ANkw4BecNtuB+xnE+dGfU7JJsZlM8Z57UI/raD9BN4QcYjWedC2a
 76LfQheZY3REnAOA/+czmJ/VOzJTayKdR+OMaV/iAZteUAa3YOvZCHutLsA1BO2IGEXl
 Fi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019524; x=1747624324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wggRaurDIsoV0nzI182xGTLzWxaSo30BybVq33C1vm8=;
 b=OKWZ2HEkXuaHf1A+hMwGBpUxqdkpFd5TEgDaS/T18LlK/trY6LkFoag7F1jh5wGGrK
 j2IsuPJjKJh2r4ABUzEbgE9xCBxfMyr3WEQSVS9sglhFajhCZZurPpBwMHUxN8GNT2xc
 uit+51zW7Te9bP6rrDKCoE4IIjDWZzR996NnuoAH4sXLbyJ5C6c5r1c0J3h2LTSdDV5z
 KfoqGwFzIftz170LS5FVNVV7zzlctP6tOIG5dFEWIW80TmlR7ZQWO4jb/FUHgGw7Gp6k
 9aoBNysB7nyi6R6A+LrD/AbU0LK5JcsuMRUR0QckYSGszatFy9bY55s38+Bs8GzFtzi9
 JQfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm6uXhvsYXUzFIHv64MHsxBwwPrf9N3CTOhbJA/LG/b9/D2PUc8kHfKaPS587Ke6J3VKiNasmv0QbV@nongnu.org
X-Gm-Message-State: AOJu0Yy9yQwknNJDgIPT7oLOYt6iknIQy52yBlSu73gK56A83izOcmfZ
 MIk35R0MxI1XOZNrrPXjAoOeSXaMQCVweZpxizWWalPrduPiKFPGt6Q3Ig==
X-Gm-Gg: ASbGncs39c+VG259BkyIPvlKGQIiedVQcRBWyJqHLdgfJ1kcUPSYJfQpxpBe9ksJJXh
 O19NkTwI/m5P6q5HwqvM15ZmbpEeMc56yuKvH8FSidNsAtlAqly/OjFa7saZVuweWmyzPM5McYA
 pu75BSl+YHSayLSlQgzWXW2FoBUoTlmYkLWPl3CFaT0m2RCEhMnMrPWSdJME3DuCvVbtTU0ffOp
 X27aNI0kfSuRnyzHi0RKvEThm8e85zY61EpDIYBpGcqLYVYYoxAN5c8wkm9jGIyCA5UK1IF/+I/
 M8Wvow2zd18ciLntAkgmnOsXlXRMPb+cebodeM13rqX6dKUUoRGz0qM0Zg==
X-Google-Smtp-Source: AGHT+IExaAy2tFm9cMBkVmKU22N0LV+9tukyrEsXU+nVka6RmFWCX5TKFf2cVb/WhaGmK9XMYAMhFg==
X-Received: by 2002:a17:90b:3b8a:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-30c3d2e52bbmr16752162a91.20.1747019524539; 
 Sun, 11 May 2025 20:12:04 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 15/50] ppc/xive: Move NSR decoding into helper functions
Date: Mon, 12 May 2025 13:10:24 +1000
Message-ID: <20250512031100.439842-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

Rather than functions to return masks to test NSR bits, have functions
to test those bits directly. This should be no functional change, it
just makes the code more readable.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        | 51 +++++++++++++++++++++++++++++++++++--------
 include/hw/ppc/xive.h |  4 ++++
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index bb40a69c5b..c2da23f9ea 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -25,6 +25,45 @@
 /*
  * XIVE Thread Interrupt Management context
  */
+bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
+{
+    switch (ring) {
+    case TM_QW1_OS:
+        return !!(nsr & TM_QW1_NSR_EO);
+    case TM_QW2_HV_POOL:
+    case TM_QW3_HV_PHYS:
+        return !!(nsr & TM_QW3_NSR_HE);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr)
+{
+    if ((nsr & TM_NSR_GRP_LVL) > 0) {
+        g_assert(xive_nsr_indicates_exception(ring, nsr));
+        return true;
+    }
+    return false;
+}
+
+uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr)
+{
+    /* NSR determines if pool/phys ring is for phys or pool interrupt */
+    if ((ring == TM_QW3_HV_PHYS) || (ring == TM_QW2_HV_POOL)) {
+        uint8_t he = (nsr & TM_QW3_NSR_HE) >> 6;
+
+        if (he == TM_QW3_NSR_HE_PHYS) {
+            return TM_QW3_HV_PHYS;
+        } else if (he == TM_QW3_NSR_HE_POOL) {
+            return TM_QW2_HV_POOL;
+        } else {
+            /* Don't support LSI mode */
+            g_assert_not_reached();
+        }
+    }
+    return ring;
+}
 
 static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
 {
@@ -48,18 +87,12 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
     qemu_irq_lower(xive_tctx_output(tctx, ring));
 
-    if (regs[TM_NSR] != 0) {
+    if (xive_nsr_indicates_exception(ring, nsr)) {
         uint8_t cppr = regs[TM_PIPR];
         uint8_t alt_ring;
         uint8_t *alt_regs;
 
-        /* POOL interrupt uses IPB in QW2, POOL ring */
-        if ((ring == TM_QW3_HV_PHYS) &&
-            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
-            alt_ring = TM_QW2_HV_POOL;
-        } else {
-            alt_ring = ring;
-        }
+        alt_ring = xive_nsr_exception_ring(ring, nsr);
         alt_regs = &tctx->regs[alt_ring];
 
         regs[TM_CPPR] = cppr;
@@ -68,7 +101,7 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
          * If the interrupt was for a specific VP, reset the pending
          * buffer bit, otherwise clear the logical server indicator
          */
-        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
+        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
             alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
         }
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 538f438681..28f0f1b79a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -365,6 +365,10 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
     return *((uint32_t *) &ring[TM_WORD2]);
 }
 
+bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
+bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
+uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);
+
 /*
  * XIVE Router
  */
-- 
2.47.1


