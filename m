Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4943EC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pa5-00060s-Q5; Wed, 16 Sep 2026 09:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa1-0005zu-V5
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa0-00034F-Ed
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zBW25gKUyiE/snsk8aXKtC3LP8ALTPiyrh6mxfmGyk=;
 b=fM3iuSHn8oxGnJJLHtcCXbdyl/5obSsdIcgomvBiiEEZtZGrt/ho4+pi+vetyS+BOQMA7y
 LDW8IWMbtAE/69+lIn+XFRIU9TDxYx2VRYDTMcOOZddi8gBOjRBvs8qkntpblZm6trNcZ/
 PDIepQEG/Zcev9KrUL0aKswRGUChwLs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-2GwZjtUBMrOs49J6UbUOXw-1; Wed, 16 Sep 2026 09:21:35 -0400
X-MC-Unique: 2GwZjtUBMrOs49J6UbUOXw-1
X-Mimecast-MFC-AGG-ID: 2GwZjtUBMrOs49J6UbUOXw_1789564894
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e65f2f1baso45010885e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564894; x=1790169694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+zBW25gKUyiE/snsk8aXKtC3LP8ALTPiyrh6mxfmGyk=;
 b=joJrFdRF6y+4HxfqmUaIGTFnivTVMNJfcwVK41S3R4bW/c9DLJiz0NixL6fLEDTwnE
 J01Nlr3ScqGjILC3pZdQzO5R/5H8nKodH8yuxRVuCa4t5EjqDC8IIUADeWV7AMnr47mx
 wJl+X6eHm9fZqSWnevsuxXJrkSwu7YH+uhHQ7Nk+ZYRgCImvgDeqHMKGsk44wr7c+4Et
 vA6ukmQR9vcrTUAD5ab8TaLMgp5fHEry5PydI+icOrW7tUHvOFNC4DsuoNuAxFhq8raP
 3kH+0pJOoJZ/igAhfmnyHKOmcJ7fhYnftGvby3T3r+0fHXABp4xLH3HdmeQ30FQtCJp3
 Bhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564894; x=1790169694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+zBW25gKUyiE/snsk8aXKtC3LP8ALTPiyrh6mxfmGyk=;
 b=DIbyBIUoNCPwwppMpRvZe0l7AoPkxRrXkyddE44DRpeBC1+gmsGrj/u1JbH+gcMTQ3
 Z7uE/gTyy+TVzbiRWzLnzFfrPTW3tKN8pLDCP91P2IQvNHDTlpKhF8AyOzwtRwDjd/yl
 rjo98IyA9qtZUNGnH7cJ+ujqQ+c4Lz6c3/4ON7kFigQsGiUMxjX3+qD2dXC2OSe0HFf/
 5WVVcBEpieYPV+dyEr0CVIAMke4T02QIKaibgbW/wV8spb3Z+f5V4LIo8Szc0i4bE4gr
 CFr9kAbsG/BqKMWhpTgFuNc3c+LrsgfplIuFxq/pOjXu2kF2iNAyOTI8NJbPYvF1CymV
 kH3g==
X-Gm-Message-State: AFuF++k9jsEpLVUeQFD1bd2mJmSOgHJCGjVwNPiQkX2JNXNx9n/PTWzK
 hIoiaitclDCkhQJb95K/KE84Mkgf5KeI8mEtJGDqFy2GnrxcbUxrYbQMjOtejzrJ3muRO54rFzu
 EaPGNdxXn5dboELmLPLODXiXgQscaqmQTL9GQXRZPTk0XDXwRbuSX8d60UnCk8xYphYfM1X1F39
 k0X7SlCoXMoa4df+4xBc8WHUgc+T9CLWz8lFquUKq6
X-Gm-Gg: AYBFou0gUNWdmG49Ts5ZGRXg2mA0Mw8SB1MmlhivSH9TVLD8EyW6t/0D3IsjjG0Mztf
 SFvtxZJ9t0Ms3EUWRDRTdq0TtX4cGIL1YTFr/3Xs6NrObtsulTrpHetNu7GZRiTibJMutZbQ5jF
 6WEk9EJhFgN0xI9lDDiVNnCwiK3pmE5Oypm7307CqU3afodNk5/e67jwZP4cVmyWlsCrj/oHt8E
 IPc/N2HswKqhyPxTuBBgFDGKv2sKFvcd2kEa2U4LQ5hhMImjh2n2QI6ES7WRwIvSTI+PZWQzNNf
 eTNR19BGvJFrjibM9GMTB1hb74+iEyyyuoxm5ZvzbZ8t+Dofl9uRddXXEMVzfGW8sGspfX4rGc/
 4909wMVa1aLrlXXuRS7AG1Q1J9XSHAW6Ps+5OTsIf5RaQyd82+lSY1QnGg9Z9Txnr9t8nvvirC/
 5K8+pl
X-Received: by 2002:a05:600c:83c4:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49eac463960mr32560785e9.6.1789564894113; 
 Wed, 16 Sep 2026 06:21:34 -0700 (PDT)
X-Received: by 2002:a05:600c:83c4:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49eac463960mr32560275e9.6.1789564893664; 
 Wed, 16 Sep 2026 06:21:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b11691sm88193685e9.12.2026.09.16.06.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 4/8] ncr710: clean up ncr710_transfer_data
Date: Wed, 16 Sep 2026 15:21:16 +0200
Message-ID: <20260916132120.860910-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the short ncr710_execute_script case first.  Remove redundant
s->current check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 65 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ac44e99dd90..9939d2e2813 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -842,43 +842,42 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     }
     s->current->dma_len = len;
 
-    if (s->waiting) {
-        s->scntl1 |= NCR710_SCNTL1_CON;
-        s->istat |= NCR710_ISTAT_CON;
-        s->sbcl = NCR710_SBCL_IO | NCR710_SBCL_CD | NCR710_SBCL_MSG |
-                  NCR710_SBCL_BSY | NCR710_SBCL_SEL | NCR710_SBCL_REQ;
-        uint8_t host_id = (s->scid & 0x07);
-
-        /* Special case: both target and host are ID 0 */
-        if (req->dev->id == 0 && host_id == 0) {
-            s->sfbr = 0x00;
-        } else {
-            s->sfbr = (req->dev->id == 0 ? 0 : (1 << req->dev->id)) |
-                      (host_id == 0 ? 0 : (1 << host_id));
+    if (!s->waiting) {
+        if (!s->script_active) {
+            ncr710_execute_script(s);
         }
-
-        ncr710_set_phase(s, PHASE_MI);
-
-        if (s->current) {
-            uint8_t identify_msg = 0x80 | (req->lun & 0x07);
-            ncr710_add_msg_byte(s, identify_msg);
-
-            if (s->current->tag) {
-                ncr710_add_msg_byte(s, 0x20);  /* SIMPLE_TAG_MSG */
-                ncr710_add_msg_byte(s, s->current->tag & 0xff);
-            }
-        }
-
-        s->sstat0 |= NCR710_SSTAT0_SEL;
-        s->istat |= NCR710_ISTAT_SIP;
-        s->dsps = RESELECTED_DURING_SELECTION;
-        s->waiting = NCR710_WAIT_NONE;
-        ncr710_update_irq(s);
         return;
     }
-    if (!s->script_active && !s->waiting) {
-        ncr710_execute_script(s);
+
+    s->scntl1 |= NCR710_SCNTL1_CON;
+    s->istat |= NCR710_ISTAT_CON;
+    s->sbcl = NCR710_SBCL_IO | NCR710_SBCL_CD | NCR710_SBCL_MSG |
+              NCR710_SBCL_BSY | NCR710_SBCL_SEL | NCR710_SBCL_REQ;
+    uint8_t host_id = (s->scid & 0x07);
+
+    /* Special case: both target and host are ID 0 */
+    if (req->dev->id == 0 && host_id == 0) {
+        s->sfbr = 0x00;
+    } else {
+        s->sfbr = (req->dev->id == 0 ? 0 : (1 << req->dev->id)) |
+                  (host_id == 0 ? 0 : (1 << host_id));
     }
+
+    ncr710_set_phase(s, PHASE_MI);
+
+    uint8_t identify_msg = 0x80 | (req->lun & 0x07);
+    ncr710_add_msg_byte(s, identify_msg);
+
+    if (s->current->tag) {
+        ncr710_add_msg_byte(s, 0x20);  /* SIMPLE_TAG_MSG */
+        ncr710_add_msg_byte(s, s->current->tag & 0xff);
+    }
+
+    s->sstat0 |= NCR710_SSTAT0_SEL;
+    s->istat |= NCR710_ISTAT_SIP;
+    s->dsps = RESELECTED_DURING_SELECTION;
+    s->waiting = NCR710_WAIT_NONE;
+    ncr710_update_irq(s);
 }
 
 static int idbitstonum(uint8_t id)
-- 
2.55.0


