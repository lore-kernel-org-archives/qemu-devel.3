Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35388C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbi-00032j-Fq; Sun, 11 May 2025 23:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbA-0000ct-8M; Sun, 11 May 2025 23:13:03 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJb8-0006vw-Jv; Sun, 11 May 2025 23:13:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74237a74f15so3936239b3a.0; 
 Sun, 11 May 2025 20:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019576; x=1747624376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjgLp/XAvt3iJXToOLL2Iq9gt2+chIsC7ctaM0YPsfs=;
 b=QmJPXEL1ApOm1g5FayajnUiMyYU6ieJ1DHRS0sAtLWofziwzd5C2qzYow8Wx3GNbCP
 sTm6fgoymI07AKGl7cJC4UZZRussTE8ufe6DxH2pphjDuXixTjRbzYrRl8VSMf+JXXij
 wP5Rbe58CEOZr/pXc9zdo32LYzySUoQAoX0ShrFC2jIb3mGsvtzwSuV2Frrn2BylIHun
 C6Lv9PMj90VgJT6Sec1hCO8Ou4qNI2erk+Ve9TV1yoyiwGesxKFohtKdjkpbwfJl9oeV
 GqhaCdCOT8ICCZF3W7I9SCy+jgtBU5CwaMz/irzIWUZkKU7bdzTU+vzYntfAJJAVI1c7
 05nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019576; x=1747624376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjgLp/XAvt3iJXToOLL2Iq9gt2+chIsC7ctaM0YPsfs=;
 b=rIpLZOsELkLnCzfQ9GaO0tHqvGfcd02OcHrv4S7hbLkdfKxFfS7RMvAmq4YjKBBfFF
 X6MI8ut94JGbYAsyaO5BmoRYuzFMTx1OJ7dQig868FjRhAkIV/aji7uLQFLJ72JPxM2a
 qBR5+9qAKAWMz2evOvhK2R7rQirzJxQzlqzYBhJpF/o84xsi9gTpFE8TgcpbiNqBGLUp
 p4pRUCsLZQ/2PZ/5CGluBrbQlClQFbjUeRuIi9tc5XPfghx9tndhBAP1nMsnKnLVBtoB
 XlbT5p2EnoH08884AbnIAJ3OPsBSBMIGHNC+NyYgM03I8VXzgLPctgvQflbyY++J1XR7
 oVUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl9kqIZJbssRpmSDJ3KyugOganXdBygPYFXz+K6hoRx2C5+m0dVQPZAJPxKrcCJd7zbliN0jqXbmBU@nongnu.org
X-Gm-Message-State: AOJu0Yxl9BqF/anxQnFQPkIOI3FCRsTZ8gawi6fCIUKa8IxcltCP8smE
 aZmuoGYyRoJvuOUlpt8M0EpZ4lz3bc6L0Lt/qfdtl6vJZBtVQ7XZUEEDNQ==
X-Gm-Gg: ASbGncumkKmUx7ISkRYmXJ1bZXHrQIknHjFeEDPxNkx03tOpbVBFpo6gJp/VHRGvJKP
 UgZRd7kKLyGRJdRqL05o5vW3R0i6XxBCY9pdPaLmLeWE0TFqNWZ11+IeMxV0MFnHHbYw28c3oVX
 1K8Ydn0rj4MS/LxomA4AvYt2qwjzY/JnjbLgkRtrKvYDpWhWgEmZ9j06u+fI2fg0gYjHa4yn9fN
 bd3xYH/9yxRQSWr0Ssf984vRzwUcoYZGpX/mJVCbfvfRCCUEfTUjSWbqCvxhoxr4CDULvKvSSoK
 PMMB1REBxWZYmOt+X1LB6OXtBiSaO6ODQT0euIAv7vZW8i5OP56QpoabkA==
X-Google-Smtp-Source: AGHT+IHMiiMhoHx1zZOYpEvxz+gdOgp4/pSakvj1wRSN3A6j9lg+rMc8GPWF+LDYexdm59qewhRo5A==
X-Received: by 2002:a05:6a20:2450:b0:1f5:8748:76b0 with SMTP id
 adf61e73a8af0-215abc2f9a5mr16438539637.29.1747019576072; 
 Sun, 11 May 2025 20:12:56 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 29/50] ppc/xive2: Redistribute group interrupt preempted by
 higher priority interrupt
Date: Mon, 12 May 2025 13:10:38 +1000
Message-ID: <20250512031100.439842-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

A group interrupt that gets preempted by a higher priority interrupt
delivery must be redistributed otherwise it would get lost.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 6e136ad2e2..cae4092198 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1638,11 +1638,21 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
                              crowd, cam_ignore, priority,
                              xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
                              &match)) {
+        XiveTCTX *tctx = match.tctx;
+        uint8_t ring = match.ring;
+        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+        uint8_t *aregs = &tctx->regs[alt_ring];
+        uint8_t nsr = aregs[TM_NSR];
         uint8_t group_level;
 
+        if (priority < aregs[TM_PIPR] &&
+            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
+            xive2_redistribute(xrtr, tctx, alt_ring);
+        }
+
         group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
-        trace_xive_presenter_notify(nvx_blk, nvx_idx, match.ring, group_level);
-        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
+        trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
+        xive_tctx_pipr_update(tctx, ring, priority, group_level);
         return;
     }
 
-- 
2.47.1


