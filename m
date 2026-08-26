Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FBC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfb-0005GK-Bb; Wed, 26 Aug 2026 07:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfT-0004tJ-Py
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:43 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfQ-0005ot-S1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso1382216a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743179; x=1788347979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UBFPtGvi7DqI4Ui5hNdIN9aVXsLQeDDR8Rmf7GilLVY=;
 b=evJthzmRY4rGEsT7JnKGgUY4PghKCN+hn4HcAIBH3YauRP3r+6uRNkU/bHmEzZZysB
 lXq3NnyhHqvplOjzVQxcmP2qPs13Wx2Df61+BfRSwvZoe/KeIx+hhun8aX1xzRC9HaZb
 bOfNBkxlMNdHydB2g8BqbrmM4+K0u6GzSgHT0ys4zlOTJp/xpPFYnJq2RETZX9ro/81s
 1R4R8Do59MGt52vrtB5CvbwJbjJoRAmP8x9uFI+iYywtE4FjPh2p2wUNDZDGUIHO5nHB
 gKIHxrN2d3L+p+44xx9Io9250RsAsQr7Rk66nqC4VqXw5CW5aAAXorMzd8URuDcB9bTg
 pIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743179; x=1788347979;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UBFPtGvi7DqI4Ui5hNdIN9aVXsLQeDDR8Rmf7GilLVY=;
 b=Y685U20GVFiI5f0l/K+kRYITMNw+0ACT3D4a+ayXbOqYfyY6OvPk12Dk0hZdK164KR
 Qeun740OfYe60NlOKBt/Nzg00swqi6LZGFaK1J+aiAXFTz9W7z51KtUKULowlgvZUyTt
 vUGVoFeNWbaF2AJSeq+khbBvIobaCHDbwPaR4cmadKSZCRgnXUUEhiLs4Cu5yOBiTjI/
 6NrDb1zNPkrt9EeRO9sJg95uY4X3sf474BpxE9Y+GHu2PO4a+2n2GGlIKNkfj/YX5xg6
 kF0wXBAv4l+hysMOdNk8R3pXdMsjr/r9lxTGp0/wL7YPAENpLe030roR0juni2/U//j9
 o2Ug==
X-Gm-Message-State: AFuF++nfjJTKYDliOBamM4milMDjGWdXXdhdf5t41GN1oohtWyeLWsvz
 mCWACBcHFrydGD8zQKKQUhtLUD3tV3Kelsqhp9YIgkfx5CilfPWSfcU4DhgMCvny9jIG0wRNzpN
 8GhDX
X-Gm-Gg: AR+sD10u6B1ftEefoMrkOyHhEGs3GeYVAdprezhTfUhhD5s+bX8GbkRbPUcDxGpX+H0
 keXjwWaoUMnmHuKn9tqlH0jeOZonhDR+2gJISute7kW/GnxJUWEQ/onDOlqnYW/zN+C8i8pL1X1
 nbukPCYvxIu+NOvhzUo6H0DnqE24dv8E82qx0UvMW9iSz3/Use76sH2RfoPWsDuiXAlwAIuloQ8
 ibgomar0uHEXrK638UbcquztwyAsb3xZJbTfu7X2lP5gvga8dV3VlXNMVbaRiL28p3Wh0mW4VCh
 6ZS67tvtEgIKYmB4Zpv0TDqok6Zj7BfF+AXrYfW0xa6oQauOssbF+iRtG8+t6n49Q11Fy0tfJmr
 XWcUp0BTlBNXKFnzjdo0PFKzFTfVk/tAsuSiwGo9kOMThud54Qordj3X54XQb/H20txGxOClnQM
 NKGz8CjHT3NQOZKQ23U6lAp3Ezr0n/6QtQUqtjtQBVWpHf4W8V
X-Received: by 2002:a05:6402:42c5:b0:6a0:8885:e6f0 with SMTP id
 4fb4d7f45d1cf-6a5df5f0b61mr7436285a12.3.1787743179231; 
 Wed, 26 Aug 2026 04:19:39 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:38 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 25/28] hw/ide/ahci: drain the ports on teardown
Date: Wed, 26 Aug 2026 13:19:12 +0200
Message-ID: <20260826111915.3387926-16-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=den@openvz.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

ahci_uninit() frees s->dev without touching the requests still in flight.
The only blk_aio_cancel() for them lives in ahci_reset_port(), which the
unplug path does not run, and the ide-hd child's own drain is deferred
through call_rcu so it happens after the free. A guest that powers the
root port slot off through SLTCTL, or writes the ACPI ejection register,
while a read is outstanding therefore leaves the completion to run
against freed memory.

A plain device_del is not affected: the pciehp attention-button flow
resets the secondary bus first, which cancels through the reset path.
Surprise removal is what skips it.

Cancelling the NCQ requests alone is not enough. IDEDMA and IDEBus are
embedded in AHCIDevice, so a plain DMA read reaches the freed array
through dma_blk_cb() and a PIO read through ide_buffered_readv_cb(),
neither of which the NCQ bookkeeping covers. ide_exit() drains nothing
and frees io_buffer, which an outstanding request may still target.

Move the NCQ cancel loop into a helper, run it from ahci_uninit() too,
and drain each port before ide_exit() so no class of request can outlive
the allocation. Delete check_bh there as well; qemu_bh_new_guarded() in
check_cmd() has no counterpart on this path either.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4069
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c | 72 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 2b2ef873e0..6b04762c4a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -619,12 +619,37 @@ static void ahci_set_signature(AHCIDevice *ad, uint32_t sig)
                              s->lcyl, s->hcyl, sig);
 }
 
+static void ahci_cancel_ncq_requests(AHCIDevice *ad)
+{
+    int i;
+
+    for (i = 0; i < AHCI_MAX_CMDS; i++) {
+        NCQTransferState *ncq_tfs = &ad->ncq_tfs[i];
+        ncq_tfs->halt = false;
+        if (!ncq_tfs->used) {
+            continue;
+        }
+
+        if (ncq_tfs->aiocb) {
+            blk_aio_cancel(ncq_tfs->aiocb);
+            ncq_tfs->aiocb = NULL;
+        }
+
+        /* Maybe we just finished the request thanks to blk_aio_cancel() */
+        if (!ncq_tfs->used) {
+            continue;
+        }
+
+        qemu_sglist_destroy(&ncq_tfs->sglist);
+        ncq_tfs->used = 0;
+    }
+}
+
 static void ahci_reset_port(AHCIState *s, int port, IDEResetKind kind)
 {
     AHCIDevice *d = &s->dev[port];
     AHCIPortRegs *pr = &d->port_regs;
     IDEState *ide_state = &d->port.ifs[0];
-    int i;
 
     trace_ahci_reset_port(s, port);
 
@@ -645,27 +670,7 @@ static void ahci_reset_port(AHCIState *s, int port, IDEResetKind kind)
         return;
     }
 
-    /* reset ncq queue */
-    for (i = 0; i < AHCI_MAX_CMDS; i++) {
-        NCQTransferState *ncq_tfs = &s->dev[port].ncq_tfs[i];
-        ncq_tfs->halt = false;
-        if (!ncq_tfs->used) {
-            continue;
-        }
-
-        if (ncq_tfs->aiocb) {
-            blk_aio_cancel(ncq_tfs->aiocb);
-            ncq_tfs->aiocb = NULL;
-        }
-
-        /* Maybe we just finished the request thanks to blk_aio_cancel() */
-        if (!ncq_tfs->used) {
-            continue;
-        }
-
-        qemu_sglist_destroy(&ncq_tfs->sglist);
-        ncq_tfs->used = 0;
-    }
+    ahci_cancel_ncq_requests(d);
 
     s->dev[port].port_state = STATE_RUN;
     if (ide_state->drive_kind == IDE_CD) {
@@ -1659,8 +1664,29 @@ void ahci_uninit(AHCIState *s)
     for (i = 0; i < s->ports; i++) {
         AHCIDevice *ad = &s->dev[i];
 
+        /*
+         * Unplug does not go through a reset, so this is the only chance to
+         * detach the requests and the bottom half that would otherwise walk
+         * s->dev after it is freed below.
+         */
+        ahci_cancel_ncq_requests(ad);
+        if (ad->check_bh) {
+            qemu_bh_delete(ad->check_bh);
+            ad->check_bh = NULL;
+        }
+
         for (j = 0; j < 2; j++) {
-            ide_exit(&ad->port.ifs[j]);
+            IDEState *ide_state = &ad->port.ifs[j];
+
+            /*
+             * Everything the port still owns points into the allocation this
+             * function frees, io_buffer included, so nothing may be left in
+             * flight once ide_exit() has run.
+             */
+            if (ide_state->blk) {
+                blk_drain(ide_state->blk);
+            }
+            ide_exit(ide_state);
         }
         object_unparent(OBJECT(&ad->port));
     }
-- 
2.53.0


