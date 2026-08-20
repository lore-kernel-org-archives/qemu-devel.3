Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCABC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zT-0000dS-Ih; Thu, 20 Aug 2026 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zM-0000b6-4v
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zI-0005Bh-7f
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so24339575e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787237003; x=1787841803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UBFPtGvi7DqI4Ui5hNdIN9aVXsLQeDDR8Rmf7GilLVY=;
 b=WbkaWgs72yMQ/ayr3iM+Aqe4xsjMhrIwRcFAEnngI4yUS7n69Avg3CoWGfs6kaZasg
 Jri439s9qQMKyK2MJZc3E4U105HKqlfu+TWqROUhpaBY6RxvV0XtKaikyHUL8ASLF8sP
 sJH21lfLpD2DG93RPnFSWht6z0NXxySjAtmUCKBMLsq6NUJbAbj/n2ls1rqZAY19O7jL
 vnNSc418yi/Gx/OuZI8CDyzh+xFcVmw5bbV893H5bxFD4OKQHqzOuu/4jNn4OoHPmbCz
 /UpLK2xwp6NNBOElb2Xj8JEfhvU0xLVW/Y8q7qxt9EkMjJaoQXb2Ai7O6koStzD3H3DM
 JDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237003; x=1787841803;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UBFPtGvi7DqI4Ui5hNdIN9aVXsLQeDDR8Rmf7GilLVY=;
 b=S5xICK6WsUrPmJySzvZxwDz/f87LfVlvVhiyaolMq13TRFWIy6yn0AatRh+TZoZVq0
 8l5z7UCaHKfEuvNntk32rcLn6FDiJUJ9JDGT59m5+G777Zu8W85WpzHlG9LEgt8hdnZ3
 l5rmwxfOn74bN7HCZNxbqJ8va6ePuYmh+XYeEQp4eSJto0JypZoyED2bhKjouSfKjesP
 ixZXj9Rh9Rvlv1bB+NKGpQgGmLyv2krTa0Fz/wNTWJVW2vJPmvRHtsHEEcFdIoPetPnr
 JShSoVz450s5MR9c8ktDZNFYlugE42uWDKFh4LtCMVBBa1yjjCRj309bH423oOJLZadW
 MB4g==
X-Gm-Message-State: AOJu0YySo4mE8o0adarTfO2O0ArzDLaD1JSDhFeIXu81e0P2iKWEpi6J
 GwEFZietLgWhfI4R8hY1dHsYrow34MyqWmqJhBvlL8BZDl38XOtazhvEXQMpDtUbU+Sp9ejUWG/
 5UxGu
X-Gm-Gg: AR+sD10w0EWq8oAROXnMT1NNuAP+9MbHTF3oNteDnfwHI0H0rGwuDBrErW0rN8354d/
 10PK0YB1+iQBeEJ0+JfjKcw7GI1vGuOP07Gl8phb5nSH7qDxfJSQbT2NezeH9bpepmoD+OKquU0
 qWlEbL/FsaubGeMyu/O1q5rxwHu/Z+raSJ/lTVv1G1Fp4P2lO5ht0SsdWAuXOL/RVu4XpdJu6Pn
 oZaaJE7BW9sdlZxeC+xW4AgrBS0mtqZLhcWSlfa8AhNZKLGYAdGGxbDsIcxs26e55id1yscX0Hx
 z6FFcTtAlWmpUOXhmIEX31+QBIcSl5UOh5LqnvBZhx4fPA+Mx2YVkks3FtoDJq6VKRTiCjXisU3
 FkKJtjBeh9OFP7+vuOfRAfv2p0cQa0Uo8llgfl2Lfll5E3TjoV96GrcyiOMvo7ovdlXDRj//FQ2
 k4YF4OQB7I1xivOKFsg445GGvxdPt31gcXiKyac37TwZ51vfpZlk6axcfbSA==
X-Received: by 2002:a05:600c:628d:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-499aa1c9610mr245799395e9.12.1787237002714; 
 Thu, 20 Aug 2026 07:43:22 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:22 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 08/11] hw/ide/ahci: drain the ports on teardown
Date: Thu, 20 Aug 2026 16:43:06 +0200
Message-ID: <20260820144309.835173-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
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


