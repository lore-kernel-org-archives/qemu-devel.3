Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB671C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJba-0002NP-Ov; Sun, 11 May 2025 23:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaw-0000Jz-HI; Sun, 11 May 2025 23:12:48 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJap-0006s9-RB; Sun, 11 May 2025 23:12:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742596d8b95so1010806b3a.1; 
 Sun, 11 May 2025 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019558; x=1747624358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAfppuOTeQrikbdZGd+x7tBvAYxbvHHKhnMU31PbpK8=;
 b=AcR1/oR3wgCdI1PYRkiF1l9eb2wY5/gLdIM7UWmrXf36p2rjlNak6q1YJjr5fw/QRn
 oRY4Y0MGPta2uOCEnbj06+k83UPJDCDobpf+MNrkjzqOxyTm1WIOU9G7lMdWQfP7cbVQ
 mzH7Dm/JxDINAvyYz+sWJAS5UA0/HNORkGC0R2se+h7Enjc6zi8DnFtiUoyn6nrYJtDw
 lO421P8oZhvZiBrGlbNbnotU26hNgFC8lsmPVT0lH6ij8Dp+Be+fwp1f6XIMYkFhRvFM
 K6yKAd8m6E/z5qGBvUqkDr1br2fIQYO+rfTmwKtt4GALMyfwUIYoY54AsJW63vnJEKKz
 CqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019558; x=1747624358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAfppuOTeQrikbdZGd+x7tBvAYxbvHHKhnMU31PbpK8=;
 b=kjRqHlGcFsk8MLCwmJjkDIHx3Wmp19e3LVTYWbEjpsv87yoka7mNh0JCeE2uFngpLt
 Hi4h472PCIn1C4tE4IhNECAMeml6vXcs6qaS3XqHw9o+HKsiwoN2ZHweCfw/UI+oNPsY
 o8sBZNnPdFH3nkuN0J85CmnsoLOmStSnuhS7/MBqHnAwQRPWfsXsxz7U/586HIBWkfw6
 6loWfPNpYInMIJtSDElh9Q48CdhgUGlSrCEFyn/bptV3FBAkmbiM32jI51zPGHoQEKds
 eucKwA6or0G20w5e3R2isV2h8HeFfB+gPyFjqan7wpuFFOqsJ2t0iHZt/b7eE/pGQloO
 zBIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR4IaStT6e4cfXUr02f0NNLuwzDOjUfAMDvqopUtlL2sV5bNS0Vourp7np2XYkX34izKmC12g8tSBK@nongnu.org
X-Gm-Message-State: AOJu0YzJRexbdg43SuZuEEzHHOhp2+KaymPaJcoFWZ7GPjKhZhZ92VVW
 8x0ytM6nWDsAAk/Lj9WmjMUVzC5s0k5SYk4Q+BmXp0ed9wT967g3Mdtk+A==
X-Gm-Gg: ASbGncthdiwA1OySiRs8ngPzGdvgKcKDWY7l4I4QonmJ7JNoE1QZIRoYhMpbVwW7VfJ
 63pUVpkPYVnfz/WAxf9d31KvF+HVNoDfjI/36mfdhX+NMgb0gFvtQttCIPYqCezIxNIOXi6a63r
 sz8duzJYyBt/Y1uyYRKc30xRANG8myiD0B3f4fXhpYf+W+YuIZCC1RKTNKtpP3tZvdfZnCSmXdg
 v48Gjab0SfM0vgzXgf+ZsSjrvThCOPy1ezZe5pfyQYcrXcdE8zPOaOEgkDO6q36AR4cXJr/jmzE
 Xy2jxvs34S5Vtc8HQN1pXK4M6Jr6irm2Xf5BWPDJLA1TpQf6A2WmHzu5SQ==
X-Google-Smtp-Source: AGHT+IGNnJbFYwgHGXslkHyDRmpATGmEMkPhRPF9OTD/O94DscNwPR73t6UYpNthyGqjDLPGIjQr2A==
X-Received: by 2002:a05:6a21:99a3:b0:1f5:8eec:e516 with SMTP id
 adf61e73a8af0-215abcf819emr17653364637.32.1747019557794; 
 Sun, 11 May 2025 20:12:37 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 24/50] ppc/xive2: Improve pool regs variable name
Date: Mon, 12 May 2025 13:10:33 +1000
Message-ID: <20250512031100.439842-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Change pregs to pool_regs, for clarity.

[npiggin: split from larger patch]
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 968b698677..ec4b9320b4 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1044,13 +1044,12 @@ again:
 
     /* PHYS updates also depend on POOL values */
     if (ring == TM_QW3_HV_PHYS) {
-        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
+        uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
 
         /* POOL values only matter if POOL ctx is valid */
-        if (pregs[TM_WORD2] & 0x80) {
-
-            uint8_t pool_pipr = xive_ipb_to_pipr(pregs[TM_IPB]);
-            uint8_t pool_lsmfb = pregs[TM_LSMFB];
+        if (pool_regs[TM_WORD2] & 0x80) {
+            uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
+            uint8_t pool_lsmfb = pool_regs[TM_LSMFB];
 
             /*
              * Determine highest priority interrupt and
@@ -1064,7 +1063,7 @@ again:
             }
 
             /* Values needed for group priority calculation */
-            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
+            if (pool_regs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
                 group_enabled = true;
                 lsmfb_min = pool_lsmfb;
                 if (lsmfb_min < pipr_min) {
-- 
2.47.1


