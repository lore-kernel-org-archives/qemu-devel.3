Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F64C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJc3-0004y8-Ff; Sun, 11 May 2025 23:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbi-00031h-05; Sun, 11 May 2025 23:13:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbb-0006zL-Jr; Sun, 11 May 2025 23:13:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b2093aef78dso3744538a12.0; 
 Sun, 11 May 2025 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019605; x=1747624405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBBc3gBSAPDnNv4nVmf2AY8a5QMWS3hGn8r/WqWYuvo=;
 b=TgihwTszCcTPy4OC7i+Q38+VIhPPCLZv+KX3Itiidmv733kleI1LVKUHx8g8NOqIR+
 IY2x8AoU5Z5/JR4YOtsB5V60XPBCbATRD02tAGclHeONApRjj9UFaLpatrWEozcB3AGP
 9QkErkIe4PPd9RZrTNI10R6enCVIXzMo0yC00nqlxohY5Gf4N5AlfZoe0QaQbtrg2vzD
 JtuP1ck5HzydpbFmRKXyZ2qec6TjJyauKhHfiumApL/06X3pqfhOaa5gyHdwZfmL0pKN
 +U8ULEg7i6KWTdTVfux5cK7TD6NEdJuo9P0P/hxPh/TFSniHvCHUZUa8r0UexdOuQpaY
 Owtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019605; x=1747624405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBBc3gBSAPDnNv4nVmf2AY8a5QMWS3hGn8r/WqWYuvo=;
 b=TIOluXt8KpjTwWf/RuCbQZjrn16z78r5pIy1Oks74G1d4OtcDv8Q9RtYPfG/9uCLyK
 isALq4pmfKkNSXPvstzbT55A6/DK2WqWKjRmX1TP+uQS0m+1dXFzi24p3gynM44ScPtD
 8y237kNNY0CuabIR+bgMsM+H8N2sQB9fH0tsAy+GvUvtLY5NgAiJQiexkxkrMgGfh9KU
 Mnd9o4RlTAV/ZD5FVsDlOtbIcc3M1dfeOhppVF+fwGWr5V6syr1X+ihl2nvrhcfvD7kE
 nXrIlOwMyHAl797k481hkefi1XFQycAAaTSlQbO6NcOPgPTbB/f6ksrEs6EHZbQmQLJe
 Co4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDQvC/ipAkIdDw1AD8TkBMXn19b0od//FAd69HWXjecb6s9VXu9WtUk2m3P0ewP4U8uctCg76J8SuH@nongnu.org
X-Gm-Message-State: AOJu0Yz0Xn0MT864Jd+8x2+zylFIQ/k8KuJvdHaSFBQzd9UlV0eklzkD
 EOdpGfqqtoS8ifoVwzghiONL5yQbUICRAeB5pbeUW0ZDJndbAWKhl9yW6g==
X-Gm-Gg: ASbGnctnXlERKVdO3VCFX44qCfR0SpcGsA0ENgKsRwx+zXC/g/a0zVZVE7yZgdrrm8W
 d8E128+fWwe2waHpKcP/YA6jCfbUqXtP0Qs3jpmEJJhyIJxLZO6c86NzMBf6VxXhO796VpBWWHJ
 Aq9eNTkLAIyiIL8AkRjKOT918j+wP6IutsQj3vDhbE2BdLD3xOdhWqopCLfQXXhRuBFtULMVRJj
 TUWB6sonU8QhP0a5RJc/gKVgcjqjNs7TdGGo+EA2KQEn5Quamkgqu8GELfxnujhJ5LiHA+x3XTo
 xr7aFKAs4NVbt10FG5kk0fKRTJ1JVHstebPACwoAMQAR4pCSRnKzFaSByUMtC6KFRZrg
X-Google-Smtp-Source: AGHT+IE8wylHgtW8xErfxRVDM1hoRtPCJiS9t25V1Ek0ziDogUv26/gJ6y/x7g8NtOmBrIsGb5WwdQ==
X-Received: by 2002:a17:902:e74b:b0:22e:663f:c4b with SMTP id
 d9443c01a7336-22fc8b7eac4mr178758225ad.26.1747019605184; 
 Sun, 11 May 2025 20:13:25 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 37/50] ppc/xive2: Consolidate presentation processing in
 context push
Date: Mon, 12 May 2025 13:10:46 +1000
Message-ID: <20250512031100.439842-38-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

OS-push operation must re-present pending interrupts. Use the
newly created xive2_tctx_process_pending() function instead of
duplicating the logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index aa06bfda77..0fdf6a4f20 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -903,18 +903,14 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     return cppr;
 }
 
+static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
+
 static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    XivePresenter *xptr = XIVE_PRESENTER(xrtr);
-    uint8_t ipb;
-    uint8_t backlog_level;
-    uint8_t group_level;
-    uint8_t first_group;
-    uint8_t backlog_prio;
-    uint8_t group_prio;
     uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t ipb;
     Xive2Nvp nvp;
 
     /*
@@ -946,30 +942,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
-    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
-    backlog_level = 0;
-
-    first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
-    if (first_group && regs[TM_LSMFB] < backlog_prio) {
-        group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
-                                                  first_group, &group_level);
-        regs[TM_LSMFB] = group_prio;
-        if (regs[TM_LGS] && group_prio < backlog_prio &&
-            group_prio < regs[TM_CPPR]) {
-
-            /* VP can take a group interrupt */
-            xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
-                                         group_prio, group_level);
-            backlog_prio = group_prio;
-            backlog_level = group_level;
-        }
-    }
 
-    /*
-     * Set the PIPR/NSR based on the restored state.
-     * It will raise the External interrupt signal if needed.
-     */
-    xive_tctx_pipr_set(tctx, TM_QW1_OS, backlog_prio, backlog_level);
+    xive2_tctx_process_pending(tctx, TM_QW1_OS);
 }
 
 /*
@@ -1103,8 +1077,12 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
 {
     uint8_t *sig_regs = &tctx->regs[sig_ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
-    uint8_t backlog_prio, first_group, group_level;
-    uint8_t pipr_min, lsmfb_min, ring_min;
+    uint8_t backlog_prio;
+    uint8_t first_group;
+    uint8_t group_level;
+    uint8_t pipr_min;
+    uint8_t lsmfb_min;
+    uint8_t ring_min;
     uint8_t cppr = sig_regs[TM_CPPR];
     bool group_enabled;
     Xive2Nvp nvp;
-- 
2.47.1


