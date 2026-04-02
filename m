Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05418D3942C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ISr-0003I7-KN; Thu, 02 Apr 2026 09:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1w8Eav-0001D9-Ul
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:44:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1w8Ear-0005Ng-CL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:44:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so635116b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775123044; x=1775727844; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CksdsVsNY6Vvge/pF7DyPU97nKOJ2uT4c+sk2AA7088=;
 b=UURZvFtRPNPUtad4RPbn7E/qNtpGehLzSSuUtRPc2Dd1uP55FnxTFDzh4uszo0y019
 LMKY2wM21GA7f0hYbCV1KqeKJ+zQfn5QjOWsKQVlrC0TAMBN01t1PRckx/zOb2QCbUvg
 IGelurMNCmzjnRT98/FhhI/zlIl1UA9zIj/AmXjsUthoOdvK4W/d8Kez25504d10cByx
 UgSQg/KfVsKXxbFhalvZn8OJEnvOQPr6qit/7KMSJY5DKi27yQOgvHn9echBqujhmzHW
 KVcpC8YiQXe7WRXC9ii1E4zrP+6L0IpyICfAwIc40HmJTxCmySdVa5wf46ZVGZ0VDAFG
 Jghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775123044; x=1775727844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CksdsVsNY6Vvge/pF7DyPU97nKOJ2uT4c+sk2AA7088=;
 b=awsWH/IAbg8AtubKU3aUlJIeJh61KNNaHfZ9A/oWAkUaQCB0Z37WvfJTRa8w93RpLU
 vF1uwL1k/GXDrdC6vGPR3T4oYDtZaAAlaU6TeB/qO4IMGd6SFNXhqK6Io2tgBuFDgk6i
 cNdKWo8M0kPI0yAV5vTOB4sngrJ9qSfsIyJlcdB5vj5w1mEM2KP8rJeGBiihcNUiiHTY
 41IinK1F+Noyksdz0qVcvoecnvBl3Vv6xKdah+XZm5ZKDc/BVWgArh89puqb+KiKZVvl
 uqGDShTClQw/xwr99uKHxQrwAtGeuoxdOTgMQhaGYdBZgatLamFVoyQQLXaAIZ7xDYqh
 s8fA==
X-Gm-Message-State: AOJu0Yzm8ODos5wwnElzrGrKvLk/LtgmXaGUs0hgJFA28JKZtHTvSaMX
 sP8rim7pCGJqx/7ASAsLOo6fa6YNXoi/Bvc2MdLiD43+GZ5axNRKCCq3
X-Gm-Gg: ATEYQzy7TDbZt4+qzQr0pMrVq0++GA61PNNV0Rt4izTF56qiqwc1H54aOMj9UXBEnG8
 78bDZb8GM6XY6xKSOqdDSoN2Aurv3g0yxrdcnK1fyGU0TYplPHekUH+txdl4bxoi9aBk2B0/hBO
 UDziBhiNPmRJzEdPrMfb2recRvlBufp7jlkFnB8ocfYsgJy26W5OjDJcpJMvElexfR/ISOceike
 jVDOgEbTEGBdpGBoKCx0P6Qlv8N8ZIBxf6s3E2nBsDTWpMht069QaLp271N/f8AYBPHZUk03rpN
 A/8J4Xf32ggWFJhSkNTy+Sk72btMwSErcvv3jb5F1mohg78abTCXQrsO1hqclguNlsqSYgVSD4H
 F4Gp9obCGlJGMuFV6sXBdkycy5R4WLh7Kj6tHML2z2ODj+Cmb7zCd7bs73ovBRMz24SDslwxKR2
 frMiR7hlR5AHHUFz8Ebfz5uyxMWuvD5w==
X-Received: by 2002:a05:6a00:2406:b0:829:7d31:dd9a with SMTP id
 d2e1a72fcca58-82ce8ae3016mr7540021b3a.51.1775123043783; 
 Thu, 02 Apr 2026 02:44:03 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c6ad8asm2668477b3a.40.2026.04.02.02.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 02:44:03 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Thu, 02 Apr 2026 18:43:47 +0900
Subject: [PATCH 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-write_booster-v1-3-e4fed1df6c7e@samsung.com>
References: <20260402-write_booster-v1-0-e4fed1df6c7e@samsung.com>
In-Reply-To: <20260402-write_booster-v1-0-e4fed1df6c7e@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775123032; l=2916;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=/YX9M0/8utB10RyJw1Al6+6NhTczJLb9C2D6zloxtfQ=;
 b=MaUmkDUTMfV4ai3EE2sxjNQfLI2ZCCsmJroS/6g1hn3HdGK2LwFbFpi/I1WQw2yb0Ls9Hg10i
 Ew5K1qMNhKZDA+DkZtf+Opz1zH/oJUPe2lcKWZuM68U1yA36n5BV+WU
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=ldc.jml@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 02 Apr 2026 09:51:40 -0400
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
 hw/ufs/ufs.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 69f82ab462d135fe6cda479891f9d8f26d19be9a..111ce3c3a0b03a1ead722f48b799e3ed0c403cce 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1801,6 +1801,47 @@ static void ufs_sendback_req(void *opaque)
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
+    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
+        if (!ufs_mcq_sq_empty(u, i)) {
+            return false;
+        }
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
+        if (!ufs_mcq_cq_empty(u, i)) {
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
@@ -1863,6 +1904,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
 
@@ -1959,6 +2001,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -1986,6 +2031,8 @@ static void ufs_exit(PCIDevice *pci_dev)
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


