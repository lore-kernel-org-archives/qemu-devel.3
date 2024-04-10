Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418FBCD1299
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQlS-0004oW-2R; Wed, 10 Apr 2024 01:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlP-0004no-VT; Wed, 10 Apr 2024 01:44:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlO-0001Mo-7F; Wed, 10 Apr 2024 01:44:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1DD515D4E0;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D6344B0147;
 Wed, 10 Apr 2024 08:44:16 +0300 (MSK)
Received: (nullmailer pid 4182024 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 08/41] hw/scsi/lsi53c895a: stop script on phase
 mismatch
Date: Wed, 10 Apr 2024 08:43:29 +0300
Message-Id: <20240410054416.4181891-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

Netbsd isn't happy with qemu lsi53c895a emulation:

cd0(esiop0:0:2:0): command with tag id 0 reset
esiop0: autoconfiguration error: phase mismatch without command
esiop0: autoconfiguration error: unhandled scsi interrupt, sist=0x80 sstat1=0x0 DSA=0x23a64b1 DSP=0x50

This is because lsi_bad_phase() triggers a phase mismatch, which
stops SCRIPT processing. However, after returning to
lsi_command_complete(), SCRIPT is restarted with lsi_resume_script().
Fix this by adding a return value to lsi_bad_phase(), and only resume
script processing when lsi_bad_phase() didn't trigger a host interrupt.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
Message-ID: <20240302214453.2071388-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a9198b3132d81a6bfc9fdbf6f3d3a514c2864674)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index ca619ed564..905f5ef237 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -570,8 +570,9 @@ static inline void lsi_set_phase(LSIState *s, int phase)
     s->sstat1 = (s->sstat1 & ~PHASE_MASK) | phase;
 }
 
-static void lsi_bad_phase(LSIState *s, int out, int new_phase)
+static int lsi_bad_phase(LSIState *s, int out, int new_phase)
 {
+    int ret = 0;
     /* Trigger a phase mismatch.  */
     if (s->ccntl0 & LSI_CCNTL0_ENPMJ) {
         if ((s->ccntl0 & LSI_CCNTL0_PMJCTL)) {
@@ -584,8 +585,10 @@ static void lsi_bad_phase(LSIState *s, int out, int new_phase)
         trace_lsi_bad_phase_interrupt();
         lsi_script_scsi_interrupt(s, LSI_SIST0_MA, 0);
         lsi_stop_script(s);
+        ret = 1;
     }
     lsi_set_phase(s, new_phase);
+    return ret;
 }
 
 
@@ -789,7 +792,7 @@ static int lsi_queue_req(LSIState *s, SCSIRequest *req, uint32_t len)
 static void lsi_command_complete(SCSIRequest *req, size_t resid)
 {
     LSIState *s = LSI53C895A(req->bus->qbus.parent);
-    int out;
+    int out, stop = 0;
 
     out = (s->sstat1 & PHASE_MASK) == PHASE_DO;
     trace_lsi_command_complete(req->status);
@@ -797,7 +800,10 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     s->command_complete = 2;
     if (s->waiting && s->dbc != 0) {
         /* Raise phase mismatch for short transfers.  */
-        lsi_bad_phase(s, out, PHASE_ST);
+        stop = lsi_bad_phase(s, out, PHASE_ST);
+        if (stop) {
+            s->waiting = 0;
+        }
     } else {
         lsi_set_phase(s, PHASE_ST);
     }
@@ -807,7 +813,9 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
-    lsi_resume_script(s);
+    if (!stop) {
+        lsi_resume_script(s);
+    }
 }
 
  /* Callback to indicate that the SCSI layer has completed a transfer.  */
-- 
2.39.2


