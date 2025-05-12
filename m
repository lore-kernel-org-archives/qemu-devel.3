Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE10DC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJci-0007Ut-49; Sun, 11 May 2025 23:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbr-0003zv-SF; Sun, 11 May 2025 23:13:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbq-00071p-44; Sun, 11 May 2025 23:13:43 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-309fac646adso4663336a91.1; 
 Sun, 11 May 2025 20:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019620; x=1747624420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmemdiyewvXYyAMHa6X+3anELoRdqKv3dosIbNPXpYQ=;
 b=Q9Wmi+kD09Yfes9G7vagzN842Mr+/+MiTwehUpt32o+cGPCpjRV0M3R4SLQnJKkRrp
 nqMHINphp6H9eppJCx3Q/aJIVioc5/DkEikiDuhlWyG6/Mqmmp8kif9C4Bp7OSK5beMb
 blFR3po0vgw05jH2pEmRx+M4NUWmM8/6vHrYFuK232gzFzwgGir/g2TmcC27Q512AjpM
 n2Ky26ut76peKF93qffA8F4uX6uCRHQN5sqYImSbd54L3mg041qEZbNWIc3LpLKIWnK2
 zv16mRd0nC05VDm2bO2fHqxTE2m5gjMf01SUkglk91stZcMOgjnCGAbO/MmAvg+LbkUR
 xJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019620; x=1747624420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmemdiyewvXYyAMHa6X+3anELoRdqKv3dosIbNPXpYQ=;
 b=cLBZK/M9NCbPoor3det2QNMo9UCDqH4134NKhwmND5m+8Ds9DfUzQLd+/L03wkXteT
 WNw8lMXkumeqoLy1FlY4x7Cs0eJ5iJ4+xf7wOxR21HlteRCX9Hb/m72+a5+lRNt95lAO
 w2amL288GytrgJ6sxmDtuoSlhRAsUzXXpPiSyT2dzHHYsreGchrf53pBCnyKgTMmmIUC
 MzILPsNDWjydiEDBw/SNwDalyzjo/AZLBEbCmSAfvLwl+ZL/z323kyQXgQJFpDQgOHTU
 X7Wo+/qGLjvTvOPDOlgSvdBAUfA7KbLQ0reXcxT0oFbQovjTMUNyjMYnYSVwB0masTk9
 Nykg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDsa0HkZbVFXz7p05gB/GZdWD3E1pDgvPPwc63gK/i+z+E17qCF77heTFQVBZEPBlp2Wjqi4uvgrcZ@nongnu.org
X-Gm-Message-State: AOJu0YzwsTQsKKWW5pj6efx08Y22+3vo6ppVDZWGGSeC/D3E4iEthNHC
 I1lbGnOzA52NfzZ1+XNpxsnmElm1Ju6/0TTy4T5VVYLZMPnK37HhNuduLQ==
X-Gm-Gg: ASbGncuq8aZJfhq36kidyam4fUK4oKBmJk71ZEcG/mNmf7fKRg6AadM+w3+BQWFDmN1
 3EdA72vX1uwqv39Gich2j9Ak9FLLHqwf2M4SjTfQZ01/LDRSd6dMhAUTLLZInU7KPRHJ+VQXkLb
 xpsVBhJE7T1pzx/MiQkPXaxf0vVtDp3ZEjsmHnWSVShjhIVa5//y4ottHJRENDGjbLJBpeIgHFh
 T/GBuyRiKSEj2wGxtzj8mcVxdCrxrwl6YHdsg1jraR4Ej9L+BLiK4LhNdj0oIF7vvmpw+Y+g3yJ
 9IlRij38SCJD5/IK+Xb95tArn38DhWmy1OyhQJIb015d9fZ3LjAADKBBTQ==
X-Google-Smtp-Source: AGHT+IFdlJ/VI5Cg3kpH+ouxUSuHKNSssjNQk7xgCmNluX6pClOUeZ8Hdm1Ldhvg35nV5cUsMOB8GA==
X-Received: by 2002:a17:90b:2886:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-30adbf59091mr24297083a91.11.1747019619686; 
 Sun, 11 May 2025 20:13:39 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 41/50] ppc/xive2: Prevent pulling of pool context losing phys
 interrupt
Date: Mon, 12 May 2025 13:10:50 +1000
Message-ID: <20250512031100.439842-42-npiggin@gmail.com>
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

When the pool context is pulled, the shared pool/phys signal is
reset, which loses the qemu irq if a phys interrupt was presented.

Only reset the signal if a poll irq was presented.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index d899c1fb14..aeeb901b6a 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -727,20 +727,22 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                 xive2_redistribute(xrtr, tctx, cur_ring);
             }
         }
+
+        /*
+         * Lower external interrupt line of requested ring and below except for
+         * USER, which doesn't exist.
+         */
+        if (xive_nsr_indicates_exception(cur_ring, nsr)) {
+            if (cur_ring == xive_nsr_exception_ring(cur_ring, nsr)) {
+                xive_tctx_reset_signal(tctx, cur_ring);
+            }
+        }
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
         xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
     }
 
-    /*
-     * Lower external interrupt line of requested ring and below except for
-     * USER, which doesn't exist.
-     */
-    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
-         cur_ring += XIVE_TM_RING_SIZE) {
-        xive_tctx_reset_signal(tctx, cur_ring);
-    }
     return target_ringw2;
 }
 
-- 
2.47.1


