Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F91E98FAF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAi61-000561-U4; Thu, 09 Apr 2026 01:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wAi5w-00053b-7t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:38:24 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wAi5u-0002pj-NQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:38:24 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so516301a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 22:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775713101; x=1776317901; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lyj11Tfxbe9RYXSzdg43MBGOPwmFNVkbNtPSImIsubU=;
 b=PI5E9/wE5jkjapmUpLo5bVQa11OQjiMuINQuLVwBaWX5Qqri3NHqlhYSVKwjewmdBg
 4cOtX78sZoKMJWLmgJ7Z3yDC2TNCykJnXhpozSfkqcBN3GITUvJCd2NHpvK4yrEy1q+p
 gwDe8/IEeo4KS9XiN+n2t0wesKU6I7eutD3JxUSWUEN6cqlLI9wIKzwXh4CTkVAOfj8W
 jYNE7b5tIiCOEozry62DJe46kv0hVelgfmAsN1ZqQLddKzwVTF33wGsJtfvhz2OJsLFh
 fgGW3VGWc1DrVzQWljOhGBsVf1k7we7a4jGRfzGv1HYQHerOX6MfkR5/GGvhcg9mVxMU
 MGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775713101; x=1776317901;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lyj11Tfxbe9RYXSzdg43MBGOPwmFNVkbNtPSImIsubU=;
 b=KJr2rVW4fcpCTqRc8esJJvTdJbFas85oEXIqdn+LuFPjG+fx9eXsHk1ClnxzsjGcVD
 Lfimhi1ODJnFFGBTjimqtCMTAh/Gg8+TTdh3sUXI0AL2Jmi4HLJ6k2oivYHyPggpRjWU
 lqzIqZUDA8jOjjPjJNyneXSUZA9ZXfy/dwGZzvhebrbIXtOuMMxjLxN3lKAiUToX97It
 iybYo8z+U/4+bYWJrusXVkoYITMX2CkaLGo4DETv6mdtMMU9EhI9ihzs/vUBsyl7qd21
 ZTJIEk4c5mSh5dmJ8eFG/Mmmq9JPMAnCFFFkS2Vg4ZakvZjw7hXKkiWXXrFLl49fl6Ls
 oXUw==
X-Gm-Message-State: AOJu0YyUvIsSMnwcPZyGZCEN7Dd5zTR+W72KbpvGosIjA9anIfvqA7Rh
 t4tNLRfHiZjvxyp38T1Yt0PGJB7eEYJ7Z8ysqt5GtJ24zb5ytFDur0eniZ3IkxkDV/E=
X-Gm-Gg: AeBDietVhW+KltakFyT64dhmRg6lJl3lkYI+Qg438MK6FeZrbtvDL3lHtPsD1AmWPO8
 hxS7784dNuP6HoikPm+mkzegOjfsE28EBVLCFYdOkSAARcAv9h2ysCMvbVU7yqhpl9oSBPWKKvI
 t+jOS/4et8Gka731SAj9JDczo2fNVZPKi+bKyW6Zi7mCn9AeDWzdZnkCIBk9CeNmEz81NclIqeU
 sRfeV8fnhCnGEA+W/NENP+kBUwPLejpWpoe7mkf1zfJC+ZsKziz1xD+QJN78bFAF2YeYOaC4Uh5
 DmAx2nKwk4qIkE7SXRCtO/Gso15ndeKqB1Byb6HXJZjvnUFe8JTfdXwRFtsX7r1Lr72p1w/o9GO
 SX3k2PUcNJO29sm890Sp1utlacAjKxOaxD1AfI+XCxOlSnb5LvRUKB7NLGtX9lcmeGJLzGAl0zb
 /HQ4CpgAO+ydLlnXEn/DASkURIRFiUcnZwF1vWk9/C
X-Received: by 2002:a17:903:40d2:b0:2ae:ac0c:5a29 with SMTP id
 d9443c01a7336-2b281674f1emr253166975ad.10.1775713101264; 
 Wed, 08 Apr 2026 22:38:21 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2747a7115sm211108905ad.36.2026.04.08.22.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 22:38:20 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Thu, 09 Apr 2026 14:37:47 +0900
Subject: [PATCH v3 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-write_booster-v3-3-dd2f1c0119c8@samsung.com>
References: <20260409-write_booster-v3-0-dd2f1c0119c8@samsung.com>
In-Reply-To: <20260409-write_booster-v3-0-dd2f1c0119c8@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775713090; l=3387;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=31MAxkp+dtUmBja2++zT4y/RbcFSibN2tncuWfFeMA8=;
 b=9cwbvHl4SwON1FOQrhsn5kv0FxnlZFl/HfHnXWqLyoD2Z1LK2ZoweqbjzKofkD4DBZEHNLhpB
 ZNP85YvICb2D5lKyoVIzczbuBpvjRP8P4N8kFVVSyg1RSuGSxShAubK
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ldc.jml@gmail.com; helo=mail-pj1-x102e.google.com
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
 hw/ufs/ufs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 69f82ab462d135fe6cda479891f9d8f26d19be9a..33887ac12a4bae647acb94b292f1d680bff9a007 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1801,6 +1801,63 @@ static void ufs_sendback_req(void *opaque)
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
+        if (!ufs_mcq_sq_empty(u, qid) || !u->sq[qid]) {
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
+        if (!ufs_mcq_cq_empty(u, qid) || !u->cq[qid]) {
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
@@ -1863,6 +1920,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
 
@@ -1959,6 +2017,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -1986,6 +2047,8 @@ static void ufs_exit(PCIDevice *pci_dev)
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


