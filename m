Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB43F99C86
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhCE-0008H7-R3; Mon, 20 Apr 2026 01:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhC9-0008FF-JR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:19 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhC6-000822-Ib
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b461310af5so9659565ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776662948; x=1777267748; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=lBQbAOZ6rRELHmy76wyujcvzttFXlWf52u+vQvpkcJ30AN+J6zjiGMck7wuT3PhsAu
 n10DJbpK03BKQvhjJLxfAYB+xohGUtb2bUA3tzDvu3zhvgEYJ5DiKiLvfFW0S6I7Qu4i
 9sdtnD7Sk/ILCMIINLsYVrJYYhZe+O59u7plaCcH2s6ynEwFGaoRkFKzsLizjS1GOap/
 h90aJptmNXj88GSq0SFy4ipw4cP5TeS7I8sm/+gsd1auHKI2LRCQDiKF5DQv/ZpeWdE0
 eNOu8steUKtC6WPt/2VRx7xSs7C5zzHym8A+U6IIMeMevyIUVcugNVFv92TrL/MHKq9y
 UHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776662948; x=1777267748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=BiB2hO8DZhAVF2X3EN5Mvys3E5dM2ThyTUIftB5mzNrwu7q/LmWvW9MuEYE91ATo9h
 9X+ZVZ5S23HdDehoT2B4KdeoAndhgLkGJaLisZEuyp+RhF85dt20nk9Tg8T8v1gRTsx0
 2fozK/aj4mJ6Fo9e2Cfrdm3pDOPGbwqbreEHmVOxtOM1gfAXGQTnGrIFXFqfN4pUU+hU
 dJAau2OyQf6CtanacWbfsz/ElW3LPfjJq4X6IHqgkJBXz5zBc0oLAahij00mpn3y/h0K
 ecg6GXCFA90UJNsHb5HBcL9N+Nkv1MxfjF2bLlboOMGMPNApcNdv+6VUBUsiASkCNFEg
 /x0g==
X-Gm-Message-State: AOJu0YxqVGoIN9MQZyv7g908HHdj0moUVtigBUoJqCa1F/J2oJvLEIuE
 aVQgMWIzySp2EL/XWmzkKk5JERLEcLxwdnA0qRk2bSHMDmJ9xL2cvhKjeCsWhgJkTpc=
X-Gm-Gg: AeBDietx3jqABv2EEvwpHSzDeqY+purcXNuuw7WKVSmtVF6irRbUCugdPMADjehQ4dE
 Vk2FYtIdlTS3EI0LksCs8kYSIGrWU1ZgACk7udbd1NUJxjpmQQ5jTMr7C2z8sLlTzJEXy3MXfJR
 tts7ragrZnnwetiALeeDKClJsQkHCvtTHuiQI6EPjpaxi4DBH6FOpo2POgmd8P0hG+rGR1d49aR
 4L4A83VwVSNIiKQ/ymA0fho8d8CVzt3A1kpWV9/I6cV2hpr5/yVhWiw0i+uG7XAtQhog3kc/4ND
 fp1DFc5s0ksPCSrGYILQi6TYtGe75WMXTBCcqW8nDmzL+y5euQHSn6yV2tirzNJbeIsG7K6yFVE
 WPWYvxpU2jWMmGXCpIbX2J8EFMJX2LfpIGua+MYlqp4OwVhOADMfrM4+HdYI6owMA38ifQ3P3iX
 Ns7JBPN4KP4IvFtuXsLnCzcXWbm+4jV8K2Xi4ce3E2
X-Received: by 2002:a17:902:9002:b0:2b0:91e6:bc18 with SMTP id
 d9443c01a7336-2b5f9e7bb41mr69449905ad.14.1776662948556; 
 Sun, 19 Apr 2026 22:29:08 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ad18sm93099675ad.71.2026.04.19.22.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:29:08 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Mon, 20 Apr 2026 14:28:51 +0900
Subject: [PATCH v6 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-write_booster-v6-3-8c49acba03d4@samsung.com>
References: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
In-Reply-To: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776662940; l=3493;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=U1I7iR9KAXBx24tNL1R8hKu0trzHrSPwvB+dS7OpoRs=;
 b=HXEFZhSf5rng3vs9GzL1pBfJNw1EAHYTMz2xmn2rK6fprhAI3TE+UAwnbHrXkSS0Bp1isTZZ1
 +/iRdmYb/uYB/J1NpvTsMmzKyEW2390WM+euWlVVy1hXpxyeNT8k9v9
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ldc.jml@gmail.com; helo=mail-pl1-x631.google.com
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


