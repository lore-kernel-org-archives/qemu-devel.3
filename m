Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1DEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbz-0004bN-7L; Sun, 11 May 2025 23:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbH-0000lK-Lt; Sun, 11 May 2025 23:13:08 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbF-0006x6-La; Sun, 11 May 2025 23:13:07 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30a8c9906e5so5048840a91.1; 
 Sun, 11 May 2025 20:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019583; x=1747624383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTU93SYJwbP2BMIUxyECt3OCP66XcUHIxZ2s40avHbI=;
 b=l3+IhD0SWBkOGSPVbbbtu4nsx7IVJRxPxMiX6+k/JEGuChD321w+sp3arVWIU+WbTx
 yDs+XuwzIdiFzx1NORpR/+pdgX5mYYbXCuz1tUOCcmL1YO9di696IVtIY8aAj9mfcVGZ
 O3PPFvl3CiNM5CchL50fT54AGsWr+IZbtmJl+TmGV3L4awC7yev0Ys0/NFuIu7HLD3nn
 ttkWWWVEleF6acLad4XR/bRE+SefLoId02oVLbatbKf4jx0yMEwf7noK5bK3KtXVewtZ
 iL4Hg31Jq9XSfHndG0BhlvZ/JV6huJQva3F9QoUDkcfQAYr+vxhzb1B7byacTg2SE8ku
 Mndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019583; x=1747624383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTU93SYJwbP2BMIUxyECt3OCP66XcUHIxZ2s40avHbI=;
 b=bj9F9kO3UdnZpp64e16gJADAPNqcwVcGkafh1M98/aWsEdFq5D1Cl9HD9vNAriktOG
 Dx5mX1gYGJCtjmitxEDb/65pNM+Yo8hsDaBFJ+UL+z6jEdfWCfaK054UKlwROSFDAGr1
 RLSw14Tj/iEIBFSecg0rihaxJZRgz/b3TPNbVN0xDDmL6pSakELMSm8I64qP9St5+2rB
 rV2TlfZOpO80Gxqo+1HGzH9AwxJKiNArWK2JiADhGUc9s3Y5i2dCZN7CRBrAWIFQB4Ga
 XqTJc10HevOxqoGGKNcAmFzhSdX6eC0C9EZ9YVvrx8GC0TOc+nkMwC40ARRReOplMF4E
 EY9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWODX07jUAo2sJJKmN6A1swQp+aTlxGPhR8XQBrVw2nbHquEtjM1C/A1br3b/6sYUnjbrIPmG/A+X7g@nongnu.org
X-Gm-Message-State: AOJu0YwLJ4QmRDv7M5FeueErx7N8mz08QUz6mrV4rEyNnHW0Uxd+Ybvi
 q7C1++uF+CcZqyFw+ARQ3KH40Fkw5dFuiw2ej6ozQ9GlDMm/kD/Pes2Xsg==
X-Gm-Gg: ASbGnctaZIc0bq1U3vXSG3kOe53tSYin00l/Nk7AOdcJYPQVQYtmVS6ePePN6l2mO0D
 FRE2STDH5pEVw2xs4BBi7VkyfCaUltztlkMTGWnpX1Bg6KtinNko04KWWq5Q6mykMdLX3zbuv5r
 9px2ykmS2B60ojUjAawA4uBjS9nYnchNOOC1iM0B473sP9tcFi2cAmqhIz+Z1aummU6dRZ3EDCS
 RGXndZwPQeke1xFCzNmpep8t2Fsj8/O0D/XQ9ENFwCxsiYQFDWYLxPE0kT11ZdO7zrCWiEX0YCg
 ZKgOI5bKKJMa12hdVsdzTvE36h9HBl+q/OIGbGRMnYqQQtJLkNZXpRyHRQ==
X-Google-Smtp-Source: AGHT+IGuepo3sbSaDZDxJw/9Reu9ip1ABgcc//qx0yem89pArfLvtJk/66A67D6/NcG7ZKEhMtq36g==
X-Received: by 2002:a17:90b:1a89:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-30c3cefc37bmr18039156a91.11.1747019583329; 
 Sun, 11 May 2025 20:13:03 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 31/50] ppc/xive: Fix high prio group interrupt being preempted
 by low prio VP
Date: Mon, 12 May 2025 13:10:40 +1000
Message-ID: <20250512031100.439842-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

xive_tctx_pipr_present() as implemented with xive_tctx_pipr_update()
causes VP-directed (group==0) interrupt to be presented in PIPR and NSR
despite being a lower priority than the currently presented group
interrupt.

This must not happen. The IPB bit should record the low priority VP
interrupt, but PIPR and NSR must not present the lower priority
interrupt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index bf4c0634ca..25f6c69c44 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -228,7 +228,23 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level)
 {
-    xive_tctx_pipr_update(tctx, ring, priority, group_level);
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *regs = &tctx->regs[ring];
+    uint8_t pipr = xive_priority_to_pipr(priority);
+
+    if (group_level == 0) {
+        regs[TM_IPB] |= xive_priority_to_ipb(priority);
+        if (pipr >= aregs[TM_PIPR]) {
+            /* VP interrupts can come here with lower priority than PIPR */
+            return;
+        }
+    }
+    g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
+    g_assert(pipr < aregs[TM_PIPR]);
+    aregs[TM_PIPR] = pipr;
+    xive_tctx_notify(tctx, ring, group_level);
 }
 
 /*
-- 
2.47.1


