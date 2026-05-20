Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F17CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbrC-0003tG-L2; Wed, 20 May 2026 04:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqR-0003US-8d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:00:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqO-00047u-I7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bcd3ac3307so25417875ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779263994; x=1779868794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqta58yhpZd9aYHLNbyGE5K22GTl6WBvggYweOfKiPI=;
 b=QnLon9Kvo0JTu19anuCZ8JrlaxUYgcooyAU/YFC5vmxUsE4+nmRusr5S0zwCZLBLul
 qLKYwhVNEI3SBM2lHl4JwocmTaL+JcObwnipor93zJDu6yt5lc3mvxZUKam2ALq0qOO/
 USHdyQQh2P4gDK7cH6yVR1nfNd/xCdeSzgAo/9U4rDGK0KPkOMgvnksCvPMmMNGrtD8n
 JMFiLkzDxLF9W13Wg216WcvIpdw0iLe6Xn1KlGbOmpIlQL8WD8S16PGcqNRYA8AOzCR2
 RTN/5NY3PCcuK4duN8odHJYn/uWPz/u8kiuFCfccZ4M9yJw0m3M1In/hMx6r9/ROMfxX
 4mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263994; x=1779868794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqta58yhpZd9aYHLNbyGE5K22GTl6WBvggYweOfKiPI=;
 b=gUvdm9lDNCczG1cpx/Zhtd/XE2uazFqUrS52IxO61DrQJ6WT4UFw+DLmXuTB/KeAjH
 6tINc5v0Pm3yOxHBhaX6gQ1OP4dlhy03QVsnZWfeEjCDMRH0TuEMUf0OKVyjfbyhBHWh
 NS7OfAUIE+2KE53OMxeNb7wCISI/DaypkZXnp7cWQqP199KcZo9FsuRnu3Q/pyoThqpi
 yWRnZ/Is62hZxWC0KCRQxTQqvQWG0HeVBiQl4O9RyPPUNOCDr0lxubrM9fMgdgKifnXR
 ucAa2JWZtxCtudVoG0dlMPdoVGIbbHRFOaavmqxFbeXYn0hXdsvXLIP9qPMAD0seDB13
 GMOw==
X-Gm-Message-State: AOJu0YxaUonL4La73aokAGihZF4YGEP06BeAIqna65zQx3fv61Ez91vu
 C7/9aUnEfypRwOclPmZ3FYECg/T86hdbDlmckidi6jyoa0zw3mv2PtD9vLcJlg==
X-Gm-Gg: Acq92OHIM3JE+r/JCQXFxVVbC9YpNIDLXZqSIiFR8IKCyaDqwzBXECx48ypNyUDcs6W
 YNLwR6HNH2CpYTsUwg8M1phV8W8M1AyKO7IYsJ49tOMGNXKsHwtNkcTsidc+2Xh9GSaQ67h8G86
 +KUMe7YQ37AikEgXs92iZBwwhvfZDymhvepDnW5rfvmgOljXsNcENiSsv/rM0ezdze65jjMrmVh
 O5JZCUfFsri9Qr/gFodlunh65u/fCUSopMTKCrUBddvVe09HI9roJbg1ixf46HEXAE8DeeFSl04
 uxP3zKS9y4dahivzlVMaGMJqgoNukbGiYW6oyfttAkSkBAfbBuDlJi8yAFLrHkjUFH938RcPT4L
 iQkXNqeWn3QBfHS78PfRq7521jZvZqf6tn7AUYIqfVNhyoL7DrYDwC/tzamsZ5XDbZtPw6m7XNg
 yfI+aDA16xfJQs5YvKJx+2Um2Nwwts2j+2fFSR85s=
X-Received: by 2002:a17:903:94e:b0:2b9:f59e:aca5 with SMTP id
 d9443c01a7336-2bd7e9e7777mr241599135ad.39.1779263994463; 
 Wed, 20 May 2026 00:59:54 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05ffbesm216608435ad.27.2026.05.20.00.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:59:54 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com,
 Jaemyung Lee <ldc.jml@gmail.com>
Subject: [PULL 3/5] hw/ufs: Add idle operation
Date: Wed, 20 May 2026 16:59:29 +0900
Message-ID: <9b43508b10469f6cd5dad3223d1cdcf2b448d5c9.1779263628.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779263628.git.jeuk20.kim@samsung.com>
References: <cover.1779263628.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jaemyung Lee <ldc.jml@gmail.com>

When no I/O occurs, the UFS Device performs various internal operations.
To emulate this, adds a timer that periodically checks the current I/O
status of the device and call the ufs_process_idle() function when idle.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  2 ++
 2 files changed, 73 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 2cf838d20f..237b410668 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1870,6 +1870,71 @@ static void ufs_sendback_req(void *opaque)
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
@@ -1932,6 +1997,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
 
@@ -2028,6 +2094,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -2055,6 +2124,8 @@ static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
+    timer_del(&u->idle_timer);
+
     qemu_free_irq(u->irq);
 
     qemu_bh_delete(u->doorbell_bh);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 9e800cafac..64144b556a 100644
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
2.43.0


