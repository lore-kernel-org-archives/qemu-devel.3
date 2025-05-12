Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFB6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcf-0007SO-Dj; Sun, 11 May 2025 23:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcN-0006nw-WE; Sun, 11 May 2025 23:14:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcM-00076o-DK; Sun, 11 May 2025 23:14:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso3578411b3a.0; 
 Sun, 11 May 2025 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019652; x=1747624452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBzmhfjZpXdUceDRxOMSjUrNt20VDq379vjoE6eVUwY=;
 b=MmVTlP2BaDMG8S6FIdMRi07D/d421jT0U3Fm1YuiBMwlK62MPgJ+ZApRP80CMBoFp3
 OTHhfDd+4rM4YAqD9TmRiPnV7LToDh00NQBKcWuE/8yME1dV050c+jjFoz+QxEs1tSnt
 LunfJBia0MbBCjXkamMRW+kybNFI3iI/CH+aCja9O5OB/Hw6QkJ+hHmRYsU4Ui6tL+Bm
 kIS7Y9bWmS1OEix7Ofs0VKQ6LWGhZn1fHY5Py8p26StDWN2aw/MXNRDevwv2bXEkdZi5
 v9tTEW6feZ6em5nL1KnhQcs7eoyRrvJPo5ZYr9WSdcEC0OF10U3PxwH6DNhH3xLhszEz
 nLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019652; x=1747624452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBzmhfjZpXdUceDRxOMSjUrNt20VDq379vjoE6eVUwY=;
 b=EA9k5Pxh/s4XRWH/Z/ilpcQXQpNRLAATlQ+T355bE385tPUDe5UXm2ItMDLt4vehmv
 cV/DptEW3x65USz1Ajs64+f6V0arFZ8q3LgTfvLaM8YpkGk9U2q2b5fe9oFqdBAIqbRa
 CeV3baPsrQN50ln/18aTroJwanOwc93CWgL5o2sOmzj+X00pz2fNEKt6MReOcGOkSxFU
 9cWauvRrqoFPMGYgNWmAjpu/vDlJkBrkeuTf+YZJ6VWnC4jAO1OW/ltQ5ewjjZ+QqoC5
 k91pihr3DgqVNhj+klP/LpdLWfVSQ4AXwNBXwB7o0v9Mwa5kmJ6LnlfIi7t9JEijdBTT
 /XEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkTUNUIx8jhtzKln7kL8yKmWldsACuEqArbj6CanoDOK+GiK7cbOgyPT5VXq13I+UBOhsShr13+C5n@nongnu.org
X-Gm-Message-State: AOJu0Yxjd93jsl4Unn65kf/szdk4Fq8YJC8YNa3PJ4u0aQWQGB4TWucV
 vCQOv6gF1cAV4PSx75JNbFgr6SsneqsXST6BtIkw6Zx+mwywCq/Ezks1fQ==
X-Gm-Gg: ASbGncsunl0VQF34gCEmu0aOC5Oprl0ITFSn87Ev5TAfrQ/nMOlbipyR+Su4JFN/glp
 MgGixtUgMsG8pLA36qZuA17GxlVTe14Dfbr6E1mu2zBbiXD4ziv24AdNu7Z+B/RmlwVJncS07yN
 AM5SDKRxHaxkfFlzGBcL2Lqb0ohBrb59u9164JQsk3J+S4r0j4rORe1KVSOtf6H/fDLWUB6MbA+
 4CPTrc6i6CTxxkqibCXj+g8sG/+ziM4hOsI9ZOGfSScUNX9K4aisyEeM8Nq+ZwazQjW8Zfbc1w/
 g7bhyOL8zgHj+S6uaLTF5DlD7HsilJ/WYZqWqrr2F1tDYFRni1BiBFfnPQ==
X-Google-Smtp-Source: AGHT+IFqPfS9/NazmmIsjUHpQGlTOL87Zxz39hBO5fAuFZzwLPAb2ZjyEDbtFY861UW+f9CfYIEF+A==
X-Received: by 2002:a05:6a20:559d:b0:215:d25d:fd1b with SMTP id
 adf61e73a8af0-215d25dfdaemr3593415637.14.1747019652271; 
 Sun, 11 May 2025 20:14:12 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:14:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 50/50] ppc/xive2: Enable lower level contexts on VP push
Date: Mon, 12 May 2025 13:10:59 +1000
Message-ID: <20250512031100.439842-51-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

When pushing a context, the lower-level context becomes valid if it
had V=1, and so on. Iterate lower level contexts and send them
pending interrupts if they become enabled.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 53e90b8178..ded003fa87 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -995,6 +995,12 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool v;
     bool do_restore;
 
+    if (xive_ring_valid(tctx, ring)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Attempt to push VP to enabled"
+                                       " ring 0x%02x\n", ring);
+        return;
+    }
+
     /* First update the thead context */
     switch (size) {
     case 1:
@@ -1021,19 +1027,32 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     /* Check the interrupt pending bits */
     if (v) {
         Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
-        uint8_t nsr = sig_regs[TM_NSR];
+        uint8_t cur_ring;
 
         xive2_tctx_restore_nvp(xrtr, tctx, ring,
                                nvp_blk, nvp_idx, do_restore);
 
-        if (xive_nsr_indicates_group_exception(ring, nsr)) {
-            /* redistribute precluded active grp interrupt */
-            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
-            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
+        for (cur_ring = TM_QW1_OS; cur_ring <= ring;
+             cur_ring += XIVE_TM_RING_SIZE) {
+            uint8_t *sig_regs = xive_tctx_signal_regs(tctx, cur_ring);
+            uint8_t nsr = sig_regs[TM_NSR];
+
+            if (!xive_ring_valid(tctx, cur_ring)) {
+                continue;
+            }
+
+            if (cur_ring == TM_QW2_HV_POOL) {
+                if (xive_nsr_indicates_exception(cur_ring, nsr)) {
+                    g_assert(xive_nsr_exception_ring(cur_ring, nsr) ==
+                                                               TM_QW3_HV_PHYS);
+                    xive2_redistribute(xrtr, tctx,
+                                       xive_nsr_exception_ring(ring, nsr));
+                }
+                xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
+                break;
+            }
+            xive2_tctx_process_pending(tctx, cur_ring);
         }
-        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
-                                                 TM_QW3_HV_PHYS : ring);
     }
 }
 
@@ -1159,6 +1178,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
     int rc;
 
     g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
+    g_assert(sig_regs[TM_WORD2] & 0x80);
     g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
 
     /*
-- 
2.47.1


