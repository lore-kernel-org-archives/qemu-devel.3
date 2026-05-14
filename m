Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D767CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 08:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNRAE-0004dZ-0Z; Thu, 14 May 2026 04:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNRA3-0004bC-QF
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNRA1-0001cg-0r
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b941cd869cso48838235ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778746271; x=1779351071; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=g65n5aGgeHW6mAfEKoFeqyfoEqxNSk+X/4qXsY9aRDv8EP8eQ7JMmXusyL6SsCQsi3
 Z8vsHxI0Xm6aOSBs/KJk8JisA9sc6ft+huo3sQ0ISS0IqTG3o4y3pUOK9IJ5CcK05uIZ
 xUbCjMF2+2cWYJi2FI24t2IqhPe2sJ6Orz/CyaT9eMlcbDCdHADPhSb4jGj5KE5AXZh8
 R64tq5QhH+rzAvADScR07pSIiAvTh4defUjLtVEh3H7iaGblTy0iVeOJnnibEIMUsadg
 7ee3yADRIM3HfufoOHv+JxXz/8pqik8PRzjBZH/PytrBYxy6dSdDVnnR9Cx4YzBM5Ps7
 sZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778746271; x=1779351071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=f9BC2KCnjZiKEq4XaVj/Y/1+cmh4yx0+oQnO0KE0R1GdK5frrU9V0t/um5CnGZkwet
 SnazQ6tZbJXsWinzeJ6uYwBF2nTNnr8LV3m/FU8RAlFAOPqf5kNO4NqBEdHxqqeTtIZJ
 BBZDc7kQoHEO58pf/N22shqtGv73S4NYbm+6jnh0R5xUBhy/2EwmwIezIIXvOGqt/02h
 QV1wLEhORN84Z3LEvIdXmXUppn0OJTvuXP+rYglU5+ACzMtUTQWf9UQOUFQAvFvxflE0
 ceyw3L1BBe+1YJRcwbmo38qWYe57jneC+vauY7a5qeVCMOeXl1u7tAH/SZYQQnnmMeC1
 RXuA==
X-Gm-Message-State: AOJu0YzJL708eaA75DqpI4O8z1D2+73gwzTxOPP+PDz4X4pe4NKE/n8H
 i5F9q+VvsvkqyeNxs51UXmHsO6CNelTgVyVilY2o6j0bkSf4WEDZxIBz
X-Gm-Gg: Acq92OGc5dUShnTuqly0oETsMLf5JMOiOR3CSOZj1FW08aRPU/vqGSWwisJYfmExZqS
 g3h80MmEOWSxsiLLGb7v0fWW757CZdjMiYzLFfouzKICyvZ7AC5/P8ljE1XhlCWnNpA9/HH+BKR
 rExv3TKsfvAe1I9kbzC6CfFif1pSLCKqwbnld4WZh1e2GhABBJ8X6Ha67yDtfKOmz98ZFedBQn1
 0NxoB0SohXcQ6SdcL3eGDgSEY15Of7BS43aqCaMF6ZpwJfkWp9br6loE+U51FQagh5go+9cDVKl
 SqwJJB5i9hHrV6iBcsRR+WfTghyH6BOQZIZM6M5Hosv47xa5RtTCFs5mcsl2u4bbvmT4SoEnxiC
 ey0Z/sFDKGIwVsOg/0ctB9VejX4UmAwxP5JHQE0RF2Y7QlLjrAPQaNJ0YSdzWe9wajezEYV2WlK
 KHfHQfuf6hjBhZee/daorrdmvefhCUxA==
X-Received: by 2002:a17:903:2b0e:b0:2b4:696b:7bb7 with SMTP id
 d9443c01a7336-2bd2f601102mr63795185ad.15.1778746271036; 
 Thu, 14 May 2026 01:11:11 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c2631basm14480165ad.34.2026.05.14.01.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:11:10 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Thu, 14 May 2026 17:10:46 +0900
Subject: [PATCH v7 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-write_booster-v7-3-c3ae3452980f@samsung.com>
References: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
In-Reply-To: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778746262; l=3493;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=U1I7iR9KAXBx24tNL1R8hKu0trzHrSPwvB+dS7OpoRs=;
 b=d0pa4iOIVhRUJClM4W3bMXe2hveXxz7dY69rUHsa8iSGi+9BmbLBxs1yK9iZ+j21bb8IFZbKh
 1V3qquUxQ3/Di5Tcv4NcEtAJwY2bX0Fa5Ile4JmEauzTdqpk68LRzdA
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ldc.jml@gmail.com; helo=mail-pl1-x62e.google.com
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


