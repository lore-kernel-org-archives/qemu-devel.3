Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2A10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EhT-0003CR-3v; Fri, 27 Mar 2026 17:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhR-00035P-El
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhP-0003gJ-Qx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUsd9sUtiSiyq2C2ZiaTTBXPp31lw16nowEZdc00IaI=;
 b=AxXj8/kkjJT8T4VB6My2V5bXEA99FVMF4Dc6ZswdZhMdx0rTYWlmqBep1MXhZq3SrbfTZC
 MvlFSAfLp5lZ2u/mCcYf6Lsv8cLSEAapNJKnSAq8fjAIAJc+RHr8WQ5OtTmMNguR4U91nX
 4cTvVe1S1Il1O0rek4O6Qtv2z/xEPhQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-eiqHmz1MNsqbAqmgxCTQWA-1; Fri, 27 Mar 2026 17:26:33 -0400
X-MC-Unique: eiqHmz1MNsqbAqmgxCTQWA-1
X-Mimecast-MFC-AGG-ID: eiqHmz1MNsqbAqmgxCTQWA_1774646792
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43ba0d2e46dso812023f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646790; x=1775251590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUsd9sUtiSiyq2C2ZiaTTBXPp31lw16nowEZdc00IaI=;
 b=L9z9IXAcy4WvW85xDAddNB/01/asuAm5ojRCfdG5FO5X/kmiHNyOq3D6mBFp3PSSoH
 5qdMlWgCtKhjBI0cO6VHxK/1OwRYIp2TsWZzdM7/bt8o8mXPNXS0mw3PSexwul6I+Dj3
 VOTJEofffAvtBBBVGoO6MVWD82V8J/XoipalleBFLVuvrLd0cFvHaWRKOhyOOJol/Clc
 Sn4EJuumeOz7eXQNs/0qZShnLA0517RZUbqbwIIZ/2mGqQhmdLb92+fXAkAVM24yCpPz
 hx0SQAZylnsohWnR6O/QAnANHmVfGCsKPviC49Z3izm3cEdmjgSa9EVMsu5xiA8wR4fT
 JTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646790; x=1775251590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cUsd9sUtiSiyq2C2ZiaTTBXPp31lw16nowEZdc00IaI=;
 b=WeCvbn4WilOx0h0CagWAlnjUj6ViMmn+hu+UkIEZYvn+cfyKkHQmyrL9zo39UPJUmv
 EkeFydDRvOx++h8H8G3LoOPETcXI5vhvYtXFFuhOPXb1l5tfc1Pk2ywIvmK1/z2Y+iit
 PRxLD16kFn/c9wuUVVcpRE5QltIHLAdUFFJkRTjklRKF4qElxpnJK/4G/sbxyRStF+qI
 T/ZS69Ns0YWY8i4Me0NDhktdUaupJgHTZ9bHNWbNxQda9GxfgNaz2HrlMBgv8VF/3dfD
 bASxi78T0+e3jtf+hBbDla/6iv22JLZVZh0mDRKYN5d7mzXJkOvMUFfkY4z9mbUakKxk
 ztXw==
X-Gm-Message-State: AOJu0Yz95lG02hkzvpUbWLPcKgrrQbJTe5gZWDiuJxYqgyZbh3hWmiyv
 chnpulpR1lNOomazRf8a6QbsaDwA5jmIvP5DIknSUsQs0dYsqI4HHOjUG6juMrFOFWBeymsuYOe
 k2uCACT8MVzOi7oC1U22pKf+R7mwnBFGek3jg+609QfWMwHpPO07Nfjf59NgWl9vr5PdO4/a6Qp
 5qT+1bsi+Wthg89kngNNEidPzN20ri+BcYDaEvcA2T
X-Gm-Gg: ATEYQzzKgtBW69DtXtiL2H/lt2036qupD4u0wltkquiK0dZr2t9j9gzmxQAVLJlKnQX
 9AgLCaRtwdn6cMuNpeue1L0NMyToWUaWFgn4oVyFVOVzpDpV/Jw4tnZ8MPl9c5hwe7la2Ay0Cbp
 yJqddb23dLsdedNO8MyqEKTzxQYDHQYx/Y9ZkYGddzHtjU7EopDx645KRqWt4a6UMm9aC25GRwm
 MgurLOWX4mtqgwWT/1F8bmUr/xorCClkYf+I6Uxe2l2ltTPS7JtcNE3tATM9ufE8yZ2gdGQZR4S
 9xp53IubSazEzpw8aQQts3ifELT0kbHngxZn6M/+UkXpP0CPR4DjLurIKYZIha1okKVmBUoXv06
 EItgmsM6kpsI2Rzrhouf03UE12vpuoy56PvmuGfRtpIZ+SEbulJb0srfGN1RXBQSc7Lu8MwMkD1
 gNashtld7QQymcseUZL5wZu2WB
X-Received: by 2002:a05:600c:8207:b0:485:3f1c:d887 with SMTP id
 5b1f17b1804b1-48727ee4d13mr67741965e9.26.1774646790190; 
 Fri, 27 Mar 2026 14:26:30 -0700 (PDT)
X-Received: by 2002:a05:600c:8207:b0:485:3f1c:d887 with SMTP id
 5b1f17b1804b1-48727ee4d13mr67741705e9.26.1774646789627; 
 Fri, 27 Mar 2026 14:26:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f173dsm909682f8f.15.2026.03.27.14.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 06/16] ncr710, lsi: use same enums for command_complete
Date: Fri, 27 Mar 2026 22:25:37 +0100
Message-ID: <20260327212547.460420-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The ncr710 and lsi53c895a HBAs share some of the logic, also make
them use the same enum for the command_complete variable.  Change
the names for ncr710 to something that is more representative,
for example NCR710_CMD_DATA_READY might also indicate that the
device is ready to *receive* data, not just that it has data
ready to send.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.h  |  4 ++--
 hw/scsi/lsi53c895a.c | 16 +++++++++++-----
 hw/scsi/ncr53c710.c  | 10 +++++-----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 00b6a01577c..97f1bf5fe22 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -100,8 +100,8 @@ typedef enum {
 } NCR710WaitState;
 
 typedef enum {
-    NCR710_CMD_PENDING = 0,
-    NCR710_CMD_DATA_READY = 1,
+    NCR710_CMD_SENT = 0,
+    NCR710_CMD_READY = 1,
     NCR710_CMD_COMPLETE = 2
 } NCR710CommandState;
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 54123f77579..6b0c97d98e3 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -209,6 +209,12 @@ enum {
     LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
 };
 
+typedef enum {
+    LSI_CMD_SENT, /* command is running */
+    LSI_CMD_READY, /* one round of data transfer completed */
+    LSI_CMD_COMPLETE, /* command completed */
+} LSICommandState;
+
 enum {
     LSI_MSG_ACTION_COMMAND = 0,
     LSI_MSG_ACTION_DISCONNECT = 1,
@@ -238,7 +244,7 @@ struct LSIState {
     int current_lun;
     /* The tag is a combination of the device ID and the SCSI tag.  */
     uint32_t select_tag;
-    int command_complete;
+    LSICommandState command_complete;
     QTAILQ_HEAD(, lsi_request) queue;
     lsi_request *current;
 
@@ -815,7 +821,7 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     out = (s->sstat1 & PHASE_MASK) == PHASE_DO;
     trace_lsi_command_complete(req->status);
     s->status = req->status;
-    s->command_complete = 2;
+    s->command_complete = LSI_CMD_COMPLETE;
     if (s->waiting && s->dbc != 0) {
         /* Raise phase mismatch for short transfers.  */
         stop = lsi_bad_phase(s, out, PHASE_ST);
@@ -854,7 +860,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
     /* host adapter (re)connected */
     trace_lsi_transfer_data(req->tag, len);
     s->current->dma_len = len;
-    s->command_complete = 1;
+    s->command_complete = LSI_CMD_READY;
     if (s->waiting) {
         if (s->waiting == LSI_WAIT_RESELECT || s->dbc == 0) {
             lsi_resume_script(s);
@@ -876,7 +882,7 @@ static void lsi_do_command(LSIState *s)
         s->dbc = 16;
     pci_dma_read(PCI_DEVICE(s), s->dnad, buf, s->dbc);
     s->sfbr = buf[0];
-    s->command_complete = 0;
+    s->command_complete = LSI_CMD_PENDING;
 
     id = (s->select_tag >> 8) & 0xf;
     dev = scsi_device_find(&s->bus, 0, id, s->current_lun);
@@ -900,7 +906,7 @@ static void lsi_do_command(LSIState *s)
         }
         scsi_req_continue(s->current->req);
     }
-    if (!s->command_complete) {
+    if (s->command_complete == LSI_CMD_PENDING) {
         if (n) {
             /* Command did not complete immediately so disconnect.  */
             lsi_add_msg_byte(s, 2); /* SAVE DATA POINTER */
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84f..7113ce2d8a9 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -849,7 +849,7 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     }
 
     /* Host adapter (re)connected */
-    s->command_complete = NCR710_CMD_DATA_READY;
+    s->command_complete = NCR710_CMD_READY;
     if (!s->current) {
         return;
     }
@@ -924,7 +924,7 @@ static void ncr710_do_command(NCR710State *s)
     s->dbc -= bytes_read;
     s->sfbr = buf[0];
 
-    s->command_complete = NCR710_CMD_PENDING;
+    s->command_complete = NCR710_CMD_SENT;
     id = (s->select_tag >> 8) & 0xff;
     s->lcrc = id;
 
@@ -1279,7 +1279,7 @@ void ncr710_reselection_retry_callback(void *opaque)
     p->pending = 0;
 
     SCSIRequest *req = p->req;
-    s->command_complete = NCR710_CMD_PENDING;
+    s->command_complete = NCR710_CMD_SENT;
     p->dma_len = len;
 
     s->scntl1 |= NCR710_SCNTL1_CON;
@@ -1466,7 +1466,7 @@ again:
                 break;
             case 1: /* Disconnect */
 
-                if (s->command_complete != NCR710_CMD_PENDING) {
+                if (s->command_complete != NCR710_CMD_SENT) {
                     s->scntl1 &= ~NCR710_SCNTL1_CON;
                     s->istat &= ~NCR710_ISTAT_CON;
                     s->waiting = NCR710_WAIT_NONE;
@@ -1640,7 +1640,7 @@ again:
                                            "preserved for driver processing\n");
                             ncr710_script_dma_interrupt(s,
                                                         NCR710_DSTAT_SIR);
-                            s->command_complete = NCR710_CMD_PENDING;
+                            s->command_complete = NCR710_CMD_SENT;
                         } else {
                             ncr710_script_dma_interrupt(s, NCR710_DSTAT_SIR);
                         }
-- 
2.53.0


