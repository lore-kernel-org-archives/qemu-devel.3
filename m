Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7A7F36B9F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB11M-0004Ov-6I; Thu, 09 Apr 2026 21:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB11K-0004OZ-EW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:50:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB11I-0006UE-SF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:50:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so10321385ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785851; x=1776390651; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=b5pFDfunUnffNdYxpGmpBGgpL4s7msV4acUuKWTLCHRtBDz1fjINEonCpbMfVTP8w8
 u+qmjYgPkRc0pmC61i6e81PTVxXxt0Udpb9KOg/p/tT8unuhMhRWqtwpqe6eE1UFMG/X
 GHiHVchOWLaRC01nC/ZUYbFe0ERh7zOOQmgLPUTHWx8UOJn409exqg10RmQBAC0zwf+p
 qExy9D1vn3rsQKhZ76c8k8bcfOsdptUns7M0qMXrCgHQWSCRkcWEutqYzX1u7hgZCK57
 U7iRN0ByDtYPBgsatemRRv4fF7vgKOs5acwnzH9yDtQRMaAqJe731MrAIlLTZEXIhqm1
 LWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785851; x=1776390651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=CBOVckYFxTW5gEGplCH8xsFtTnP1pkQ0S1RU0B6zuWEAr1zw/Ejaq5SLS2+y0oLDDF
 kMOFuQhBTLIiJ14JEOMdgCylTzLWSPkMEwO1jGikvVYkltdJEZUlV5ZYJV7Bfgx5hGBD
 3HmgZL14XO8mWiZ8m2E05KUz3vpCsh2LWk9ni6Kkv4+AudUdOfkVxryO52HmnpsUtz75
 H6ZxJ6uqWMKiD8x6Qz7KCi7R8Af22BsWr5zORzYkksteFvbWzjKJ2BomuvxEUD1qbImD
 RCvbZjP1JdKC3dxJDo+IqPZAopwrFa9bKatOv3YtTtoIoKRcN/oCEMOkJClqWyKuspcd
 nCFA==
X-Gm-Message-State: AOJu0Ywqo+0fSn4yF8a+762n3CgIKg1DuTdaSBNy46v5s+L6znJaQTGq
 9ydohtvKBuD4P+GK7z8wiespw3Tqg8GSb/ZiyQ0gS88qLr5Q6pmR4u8b
X-Gm-Gg: AeBDieuoAPGVCCl9xSYbXx8tjp7xujRr0rX7RaMl9sh49dh1Y9ypiSXGv0f57m9EsHZ
 IlFDRIj7TsvooUWJ2FHG84R2pnctM7PY/L9+rDhTZk3ZMzhZhItbctShp5Y3bAUmWzvqwfTpcq4
 co3h4XrjeoZ9ZmpU22+NQdaloyeAgfnWj9ENA4RIzyJuzatdDZUiFRiXAaH4hnlceihhMCiZaZ2
 Pt2ikRwTIhFKOvnDm6RheaXLYaGOUCmwAtgHjAouhkAlQNJwZan61EZ/4o10UXuwWDhj/Ur6Arj
 N6yyfLXbssi2Kh+obhGOmsNEwr5Q+AqIUCvqsLg3odRrKI1xrD0MSe//bm815KWrZttnt7kwnCS
 HfOLB870PInk/OJUfd2yoSqcSCP+u+OpFPEhXOlx+gWAdZ/U6Nv8eEE7jT8AcV9wj5LoLVrENx4
 c81T3OIigYBMPkvsyVwnO4xwMdSowUbg==
X-Received: by 2002:a17:902:db02:b0:2b2:51ed:4524 with SMTP id
 d9443c01a7336-2b2d5a78e62mr10002415ad.43.1775785851194; 
 Thu, 09 Apr 2026 18:50:51 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f0b284sm8832245ad.52.2026.04.09.18.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 18:50:50 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Fri, 10 Apr 2026 10:50:05 +0900
Subject: [PATCH v4 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-write_booster-v4-3-d58a680587df@samsung.com>
References: <20260410-write_booster-v4-0-d58a680587df@samsung.com>
In-Reply-To: <20260410-write_booster-v4-0-d58a680587df@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775785840; l=3493;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=U1I7iR9KAXBx24tNL1R8hKu0trzHrSPwvB+dS7OpoRs=;
 b=R6q3PUaIrmOUYaUEpSSXni/3vwZ/JD3eOY6uj++MauS4mlv1ng+bbKrPRCfkin/iBQdSB/apd
 NND6GJoUF68AVFb4yVCYbhjERxLGoiI0UI+V28gJL+0y+AqH9crW5lM
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=ldc.jml@gmail.com; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When no I/O occurs, the UFS Device performs various internal operations.
To emulate this, adds a timer that periodically checks the current I/O
status of the device and call the ufs_process_idle() function when idle.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 hw/ufs/ufs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  2 ++
 2 files changed, 73 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 69f82ab462d135fe6cda479891f9d8f26d19be9a..c504a0d7e3fb89eb5558cfd9c410cda9396bc3b4 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1801,6 +1801,71 @@ static void ufs_sendback_req(void *opaque)
     ufs_irq_check(u);
 }
 
+static void ufs_process_idle(UfsHc *u)
+{
+    /* Currently do nothing */
+    return;
+}
+
+static inline bool ufs_check_idle(UfsHc *u)
+{
+    return !u->reg.utrldbr;
+}
+
+static inline bool ufs_mcq_check_idle(UfsHc *u)
+{
+    if (!u->params.mcq) {
+        return true;
+    }
+
+    for (int qid = 0; qid < ARRAY_SIZE(u->sq); qid++) {
+        if (!u->sq[qid]) {
+            continue;
+        }
+
+        if (!ufs_mcq_sq_empty(u, qid)) {
+            return false;
+        }
+
+        /* internal ongoing MCQ request check */
+        UfsSq *sq = u->sq[qid];
+        for (int i = 0; i < sq->size; i++) {
+            if (sq->req[i].state != UFS_REQUEST_IDLE) {
+                return false;
+            }
+        }
+    }
+
+    for (int qid = 0; qid < ARRAY_SIZE(u->cq); qid++) {
+        if (!u->cq[qid]) {
+            continue;
+        }
+
+        if (!ufs_mcq_cq_empty(u, qid)) {
+            return false;
+        }
+
+        if (!QTAILQ_EMPTY(&u->cq[qid]->req_list)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+#define UFS_IDLE_TIMER_TICK 100 /* 0.1s */
+static void ufs_idle_timer_cb(void *opaque)
+{
+    UfsHc *u = opaque;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
+
+    if (ufs_check_idle(u) && ufs_mcq_check_idle(u)) {
+        ufs_process_idle(u);
+    }
+
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
+}
+
 static bool ufs_check_constraints(UfsHc *u, Error **errp)
 {
     if (u->params.nutrs > UFS_MAX_NUTRS) {
@@ -1863,6 +1928,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
 
@@ -1959,6 +2025,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -1986,6 +2055,8 @@ static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
+    timer_del(&u->idle_timer);
+
     qemu_free_irq(u->irq);
 
     qemu_bh_delete(u->doorbell_bh);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 13d964c5ae5ec430a98b2ef71987cb9279e9a317..b5f040302129f4d02732ddd20ef82eb33c41922a 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -148,6 +148,8 @@ typedef struct UfsHc {
     UfsCq *cq[UFS_MAX_MCQ_QNUM];
 
     uint8_t temperature;
+
+    QEMUTimer idle_timer;
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)

-- 
2.48.1


