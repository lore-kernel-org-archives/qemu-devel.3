Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205B9CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUQC-0002Me-Po; Sat, 13 Jun 2026 15:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUPS-0001P1-DE; Sat, 13 Jun 2026 15:52:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUPQ-0003gT-OY; Sat, 13 Jun 2026 15:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380259; bh=jRU+UtsBhamW6RptAMMY9hyEox4Us69tOuIZJ51dTHU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oeklgcbi38l8Yr7uc7zhjIlAAWfRqBLDz8YrlEANzkuRDLnDiAM6YAnmXrm9mn97k
 k9LfCAH3pvDmD6IVHkpeZEQGPUQ3MEi2Nz+iD+0mCEK1uZM4kpDTAQguuYOXCiyEQm
 3iHcx2v/zb+nSKkoxmAfCoWntmbi9rjNk7m+3DK6gJ+NkqEwKrjV9V2OBQQrj5ykKX
 JGbnQnY5lE5xw3+LaI6+JKRR75oeyYpHwM9X398j7XtNTaqRNOcf5kKUrtmXpnXCIg
 EDrvtg/NQ40DHKDnDW9A0Fc8U6VgvGTEzCFb4iyhzSM4nYW67o7KjP9yXkO/nmJ+Ek
 /x70aQggzYOAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1377B1B6E21;
 Sat, 13 Jun 2026 22:50:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6C7B13CE89B;
 Sat, 13 Jun 2026 22:51:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Che Kao <skps96g313.cs10@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 18/56] lsi53c895a: fix use-after-free of cancelled
 request
Date: Sat, 13 Jun 2026 22:50:32 +0300
Message-ID: <20260613195116.1807273-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

When processing the Message Out phase, the lsi53c895a controller
can cancel a request and the continue by processing more messages.
When this happens, it is important that a cancelled request is not
processed further, because scsi_req_cancel can cause the request
to be freed.

Right now this is happening in two cases, but not when cancelling
the entire queue of requests after an ABORT, CLEAR QUEUE or
BUS DEVICE RESET message.  In that case, a subsequent ABORT TAG
message can use a dangling current_req.

There are three possible fixes:

- add a missing check inside the loop, clearing current_req
  if p->req == current_req.  This is obvious but complicates the
  code inside the foreach loop.

- change the conditional prior to the loop from "if (s->current)"
  to "if (current_req)".  This would work, because s->current != NULL
  implies current_req != NULL, and would clear current_req correctly.
  However it is less obvious because the point of the code
  is to clear the entire queue, which consists of s->current
  and s->queue; current_req is not special here.

- delay the retrieval of current_req until an ABORT TAG message
  is seen.  This is the most correct option, because the SCSI
  protocol only deals with tags; requests are a QEMU concept
  that only makes sense for the purpose of calling into the
  SCSI layer.

Reported-by: Wei Che Kao <skps96g313.cs10@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5297a0fc65317ba7f79ef44ce7a44e41d15fdb27)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index c845e0bee7..25fe437af1 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1000,10 +1000,8 @@ static void lsi_do_msgout(LSIState *s)
 
     if (s->current) {
         current_tag = s->current->tag;
-        current_req = s->current;
     } else {
         current_tag = s->select_tag;
-        current_req = lsi_find_by_tag(s, current_tag);
     }
 
     trace_lsi_do_msgout(s->dbc);
@@ -1058,9 +1056,13 @@ static void lsi_do_msgout(LSIState *s)
         case 0x0d:
             /* The ABORT TAG message clears the current I/O process only. */
             trace_lsi_do_msgout_abort(current_tag);
+            if (s->current) {
+                current_req = s->current;
+            } else {
+                current_req = lsi_find_by_tag(s, current_tag);
+            }
             if (current_req && current_req->req) {
                 scsi_req_cancel(current_req->req);
-                current_req = NULL;
             }
             lsi_disconnect(s);
             break;
@@ -1086,7 +1088,6 @@ static void lsi_do_msgout(LSIState *s)
             /* clear the current I/O process */
             if (s->current) {
                 scsi_req_cancel(s->current->req);
-                current_req = NULL;
             }
 
             /* As the current implemented devices scsi_disk and scsi_generic
-- 
2.47.3


