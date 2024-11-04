Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BA3D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krr-000879-5N; Sun, 03 Nov 2024 19:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krm-0007cu-VC; Sun, 03 Nov 2024 19:22:47 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krl-0002oi-8l; Sun, 03 Nov 2024 19:22:46 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-720d14c8dbfso2326207b3a.0; 
 Sun, 03 Nov 2024 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679763; x=1731284563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKJeZuECGCGYQRCE/Wz2aptnEpkzwWv0a7kXALVVYP8=;
 b=H4O4WLtx+QnA4byWd8SIocZZ8LpBKxCcy2eSIzD0UWtBsuBmsHniETIlR8sAj98TI3
 HRneZsHHw//e7ntb39nkcaRinrmSqnYw1cbCNUKIsm3HAdcUdeQMnvpQ/Ry3c3pSCKoi
 F8egmM2+t684qS+Tk393KmLjkoybdEQf7+JIe6YEYntvtt+GLT2o+1ZyLjNBycZZI+IN
 YpnHuPpJxLCVzkeJCHHaDsTxu24K6fr9fw1xrLX6pbfrIURrLoiSiv/rk4lxsXRABiA9
 Cby/Sq6ROOyfl2O5MDoRDT1hgTa0KK6PltL7Jtm/L6IUkNXf0LgwpWwBzB9OftArIhA9
 66fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679763; x=1731284563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKJeZuECGCGYQRCE/Wz2aptnEpkzwWv0a7kXALVVYP8=;
 b=nPpMs6tovlu65fuNCxPwBSNKJndGLIH/jBySdONRMHvU6x69Zm1it+URYo80HpAHrf
 P8T2uCAYRh9MIk4TrNRWWnTsdgkbzSm6kV+AgGtqoSf9ezOY8nn/zvNB4k/4SvhqcN67
 N6KQm8iknGEoOrl1boHz2jUIOh2wAEBj7NU0jLnCtp5FG9EQLFLx09ZfGXBqqxC+lmjT
 zO9AU++Q8F4u1k3EIEneuBkDhoF7LS40wB9Cx488oTAZRfS4EcUFTHcE68iW5eh7+9hw
 WoT6HPDGiK9OAV10tC2LaY8Zwh7BnQR7XYYmY8BIewc3H9X9U7MVQkZsWk3tMVIJ6pQz
 75Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW81B0ptl+FDz9oA+bcwOIUbMEiiR9vm16JWPzfhf9Fjm9okszhRQGa1YMVbkLL+EDtg5H7OaOj3Q==@nongnu.org
X-Gm-Message-State: AOJu0YzbNNVGwklpEBEyKu8y6jEONqlop3xcVYn9JKpWxyFydvHB7YtB
 nQYAFtkYcmjuUQsP0b+CSjw4HPTtt8SxaIdu0oSUyC7K2VNUaUb0uw/e9Q==
X-Google-Smtp-Source: AGHT+IH8WTOaxPIx8AOQS8yZLRGGkYNd23+mHjiZsjacKdsC5+S/GCkrHz8LysRomM4VnF1nCp0L+Q==
X-Received: by 2002:a05:6a20:d498:b0:1d9:1823:83bf with SMTP id
 adf61e73a8af0-1db91d516d0mr19815344637.8.1730679763291; 
 Sun, 03 Nov 2024 16:22:43 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 59/67] pnv/xive: Update PIPR when updating CPPR
Date: Mon,  4 Nov 2024 10:18:48 +1000
Message-ID: <20241104001900.682660-60-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Glenn Miles <milesg@linux.ibm.com>

Current code was updating the PIPR inside the xive_tctx_accept() function
instead of the xive_tctx_set_cppr function, which is where the HW would
have it updated.

Moved the update to the xive_tctx_set_cppr function which required
additional support for pool interrupts.

Fixes: cdd4de68edb6 ("ppc/xive: notify the CPU when the interrupt priority is more privileged")
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index baad7129ca..8460bd622a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -89,7 +89,6 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
         /* Reset the pending buffer bit */
         alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
-        regs[TM_PIPR] = ipb_to_pipr(alt_regs[TM_IPB]);
 
         /* Drop Exception bit */
         regs[TM_NSR] &= ~mask;
@@ -143,6 +142,8 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
+    uint8_t pipr_min;
+    uint8_t ring_min;
 
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
                              regs[TM_IPB], regs[TM_PIPR],
@@ -154,8 +155,37 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
     tctx->regs[ring + TM_CPPR] = cppr;
 
+    /*
+     * Recompute the PIPR based on local pending interrupts.  The PHYS
+     * ring must take the minimum of both the PHYS and POOL PIPR values.
+     */
+    pipr_min = ipb_to_pipr(regs[TM_IPB]);
+    ring_min = ring;
+
+    /* PHYS updates also depend on POOL values */
+    if (ring == TM_QW3_HV_PHYS) {
+        uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
+
+        /* POOL values only matter if POOL ctx is valid */
+        if (pool_regs[TM_WORD2] & 0x80) {
+
+            uint8_t pool_pipr = ipb_to_pipr(pool_regs[TM_IPB]);
+
+            /*
+             * Determine highest priority interrupt and
+             * remember which ring has it.
+             */
+            if (pool_pipr < pipr_min) {
+                pipr_min = pool_pipr;
+                ring_min = TM_QW2_HV_POOL;
+            }
+        }
+    }
+
+    regs[TM_PIPR] = pipr_min;
+
     /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring);
+    xive_tctx_notify(tctx, ring_min);
 }
 
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
-- 
2.45.2


