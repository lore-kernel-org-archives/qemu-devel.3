Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2C610F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EiR-0006jf-GN; Fri, 27 Mar 2026 17:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiP-0006Sg-CV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiN-0003rI-Ho
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64HjyIw3YSOllArTTqZkAithVHrT5AIrg1J84ohe30s=;
 b=WkN5nqrokkzpOkXW63o0+n92FCI8yIsFnaXDZhjUywfNpX+ov4SQHjxSsOpbwy5ME/sWRN
 LpSepOMQ5G4BZJOP+beqV81jtzHl+KO25m8j/7myuXooO8ZE9zeL50GFIPkI6zK/clDyt1
 HgvAXRRW6EG/B5XSltb/Rh/AqzQyJGA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-cps7H3i9MPSJMSaccNPM_Q-1; Fri, 27 Mar 2026 17:27:32 -0400
X-MC-Unique: cps7H3i9MPSJMSaccNPM_Q-1
X-Mimecast-MFC-AGG-ID: cps7H3i9MPSJMSaccNPM_Q_1774646851
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486fcc05b20so17776225e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646848; x=1775251648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64HjyIw3YSOllArTTqZkAithVHrT5AIrg1J84ohe30s=;
 b=G2LLFIsQFMR4a0rGW510A8gngRubwYeBlrvDeGfdvD3K4yP5I3p+HCIFeQZY0cbGGL
 16v3zfsSD/EIM/uGaI/1NSPc913Bl4wqXWsKbJdvwth6Yk1ykZZMDXBu3hQ9Zuy61tMX
 ObB7u9RN8/WPDYWg7zNw/nFSc1INbJw3+rSZtI5g+oqgaoDZzbN7jxChn4IhuT4RuXg5
 lg8wRTnRsXmdXmlQWyQv6iEepGDDtfUbrGFynRlIrptzZxqHXreKfsRjHGE2nx/VMFIN
 nqbmGJhi1dkfGB6R5di+gyNHOxQf9d8gguM//fCBVisNcN4lLjQmCMOpdVFYIcxHxfvY
 akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646848; x=1775251648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=64HjyIw3YSOllArTTqZkAithVHrT5AIrg1J84ohe30s=;
 b=dF7ie5M4cknNWoxrWAWNlYDV+OdNx5GJDNL59CIxTHXGo6CDUFGwHgnuVPFrBBKY56
 1ogMKkTji6CSvlU3ITmzFsMeySxDLPOdZOLNAT7JxXu613NbDLT8y74D8xNeKZgJnUBh
 /Bg0olY53nmgMod9hs23mGnNmBYHQliOyP3RTdlveDohXUtPDmiBMgmLFxO8RM0iB7Sc
 o/K/1bOGeg3yPH7/BG3tYR8jY+Twb+euUiFr49JOprAcskRgDddse1pW/obHRhbq5PVm
 of3w638ktBuxBdlgebUUVQ+xBOjswMxrOPzRFar8YtnKIwb2GDMUeoFJ0XSOtA2RQ2Lp
 D9ZA==
X-Gm-Message-State: AOJu0Yxk4adozl7ytqtdRTOz8TtELwQmp16fRnC7IL6w0v5cyV6iMAls
 D3HiZ2nUOlnXuGw35+A5vhk/YJ7lCQKVjxX6sRV8ZChJDTkHD7b2rohTNToDftx0RUI6aIp5msh
 UmLgHVcIFO0m3CDdUZV42PFZPPT41mcNhTldFPlMUlrsuLYv7w/Xz653heHwBL/Rja3nQlkAId6
 sdEVJbSARkxpUROc5JzNaqRLZuMPxPccBLXcI5z2J1
X-Gm-Gg: ATEYQzzPSEFWlfAmDwz43tz4uDmtqzoC2z1gUUFRMaY048raIH35LI07XMCwx0OkQKm
 exqwsILPFUdpmNrICTs0sqDHyANjSOSzXr71j3b3X1cNF8B0r3+qlcNB+YgEaYQp1cuLIMLwxxm
 QveItue50b82TNPp3PCDuDeZRrs5m14Xoy6RHl+1RN5kS1XRCrSn8z/tM2/kbTncNI4Tjvxj9MR
 ZUcGXNdsQd6TOb9PqTckBu+HcfrJze8dIzZso+VXiOvTAEJxqeWbELC85cM2Y9Eu+gVhC4RVrUk
 SSyKT+RN/MdRORowN/ynXFhVYkyLiKYa29Tot13a2vw7wCMo99LwDHZcP6YJRPiEoB7hG9NhWdQ
 T/+L0z1jRnGl3DRwOKEKOrl3bjoeNpNTKTGijuVbKm+cQpECGmEa159zJwQhuRbcVd4te+e2ADS
 oEuBhgdpA73e7vwPuWq6nu90NK
X-Received: by 2002:a05:600c:3e88:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48727ee9897mr62252185e9.2.1774646848459; 
 Fri, 27 Mar 2026 14:27:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3e88:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48727ee9897mr62251915e9.2.1774646847953; 
 Fri, 27 Mar 2026 14:27:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm112708875e9.7.2026.03.27.14.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:27:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 15/16] ncr710: copy reference counting fixes over from
 lsi53c895a
Date: Fri, 27 Mar 2026 22:25:46 +0100
Message-ID: <20260327212547.460420-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

These are mostly the smae, with only the "if (p == s->current) case of
ncr710_command_complete needing some care to check that it's safe to
remove.

s->current is dereferenced:
- in ncr710_clear_pending_irq - guarded by if (s->current), just to free it
- in ncr710_do_dma - guarded by assert (s->current); only called from
  Data In/Data Out phases, which are entered after scsi_req_new and
  left after scsi_req_cancel
- in ncr710_command_complete - guarded by if (p), command is not complete
- in ncr710_transfer_data - coming from the req field of NCR710Request,
  with assertion that !p->orphan
- in ncr710_transfer_data, later - guarded by if (!s->current) return
- in ncr710_do_command, after assignment
- in ncr710_do_msgout - guarded by if (current_req), would be bad if
  the request is already complete
- in ncr710_reselection_retry_callback - guarded by short-circuiting
  s->current check
- in ncr710_execute_script - guarded by if (s->current)
- in ncr710_reg_readb - guarded by short-circuiting s->current check

Nothing relies on the post-completion s->current being alive, so get rid
of this case and clear s->current immediately as in the lsi53c895a device.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.h |  1 +
 hw/scsi/ncr53c710.c | 65 ++++++++++++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index ee6980753d5..b15e331f060 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -133,6 +133,7 @@ struct NCR710Request {
     bool active;
     uint8_t *dma_buf;
     bool out;
+    bool orphan;
     uint32_t resume_offset;
     uint32_t saved_dnad;
 };
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ea114a0cb40..f7b1e153960 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -299,7 +299,7 @@ static const char *ncr710_reg_name(int offset);
 static void ncr710_script_scsi_interrupt(NCR710State *s, int stat0);
 static void ncr710_update_irq(NCR710State *s);
 static void ncr710_script_dma_interrupt(NCR710State *s, int stat);
-static void ncr710_request_free(NCR710State *s, NCR710Request *p);
+static void ncr710_request_orphan(NCR710State *s, NCR710Request *p);
 static inline void ncr710_dma_read(NCR710State *s, uint32_t addr,
                                    void *buf, uint32_t len);
 static inline void ncr710_dma_write(NCR710State *s, uint32_t addr,
@@ -316,7 +316,7 @@ static inline int ncr710_irq_on_rsl(NCR710State *s)
 static void ncr710_clear_pending_irq(NCR710State *s)
 {
     if (s->current) {
-        ncr710_request_free(s, s->current);
+        ncr710_request_orphan(s, s->current);
     }
 }
 
@@ -683,42 +683,52 @@ static void ncr710_do_dma(NCR710State *s, int out)
     uint32_t count;
     uint32_t addr;
     SCSIDevice *dev;
+    SCSIRequest *req;
+    NCR710Request *p;
+
     assert(s->current);
     if (!s->current->dma_len) {
         /* We wait until data is available.  */
         return;
     }
 
-    dev = s->current->req->dev;
+    p = s->current;
+    req = scsi_req_ref(p->req);
+    dev = req->dev;
     assert(dev);
 
     count = s->dbc;
-    if (count > s->current->dma_len) {
-        count = s->current->dma_len;
+    if (count > p->dma_len) {
+        count = p->dma_len;
     }
 
     addr = s->dnad;
 
     s->dnad += count;
     s->dbc -= count;
-    if (s->current->dma_buf == NULL) {
-        s->current->dma_buf = scsi_req_get_buf(s->current->req);
+    if (p->dma_buf == NULL) {
+        p->dma_buf = scsi_req_get_buf(req);
     }
     /* ??? Set SFBR to first data byte.  */
     if (out) {
-        ncr710_dma_read(s, addr, s->current->dma_buf, count);
+        ncr710_dma_read(s, addr, p->dma_buf, count);
     } else {
-        ncr710_dma_write(s, addr, s->current->dma_buf, count);
+        ncr710_dma_write(s, addr, p->dma_buf, count);
     }
-    s->current->dma_len -= count;
-    if (s->current->dma_len == 0) {
-        s->current->dma_buf = NULL;
-        s->current->pending = 0;
-        s->waiting = NCR710_WAIT_DMA;
-        scsi_req_continue(s->current->req);
+    if (p->orphan) {
+        scsi_req_unref(req);
         return;
+    }
+    scsi_req_unref(req);
+
+    p->dma_len -= count;
+    if (p->dma_len == 0) {
+        p->dma_buf = NULL;
+        p->pending = 0;
+        s->waiting = NCR710_WAIT_DMA;
+        scsi_req_continue(req);
     } else {
-        s->current->dma_buf += count;
+        p->dma_buf += count;
         s->waiting = NCR710_WAIT_NONE;
         ncr710_execute_script(s);
     }
@@ -733,14 +743,18 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
     }
 }
 
-static void ncr710_request_free(NCR710State *s, NCR710Request *p)
+static void ncr710_request_orphan(NCR710State *s, NCR710Request *p)
 {
-    p->req->hba_private = NULL;
+    p->orphan = true;
     if (p == s->current) {
         s->current = NULL;
     }
     scsi_req_unref(p->req);
-    g_free(p);
+}
+
+static void ncr710_free_request(SCSIBus *bus, void *priv)
+{
+    g_free(priv);
 }
 
 void ncr710_request_cancelled(SCSIRequest *req)
@@ -748,7 +762,7 @@ void ncr710_request_cancelled(SCSIRequest *req)
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
     if (p) {
-        ncr710_request_free(s, p);
+        ncr710_request_orphan(s, p);
     }
 }
 
@@ -790,11 +804,7 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     ncr710_set_phase(s, PHASE_ST);
 
     if (p) {
-        if (p == s->current) {
-            req->hba_private = NULL;
-        } else {
-            ncr710_request_free(s, p);
-        }
+        ncr710_request_orphan(s, p);
     }
 
     if (s->waiting == NCR710_WAIT_RESELECT || s->waiting == NCR710_WAIT_DMA) {
@@ -806,11 +816,11 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
 void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
 {
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
+    NCR710Request *p = (NCR710Request *)req->hba_private;
 
-    assert(req->hba_private);
+    assert(!p->orphan);
 
     if (s->waiting == NCR710_WAIT_DMA) {
-        NCR710Request *p = (NCR710Request *)req->hba_private;
         if (p) {
             p->dma_len = len;
         }
@@ -2248,6 +2258,7 @@ static const struct SCSIBusInfo ncr710_scsi_info = {
     .transfer_data = ncr710_transfer_data,
     .complete = ncr710_command_complete,
     .cancel = ncr710_request_cancelled,
+    .free_request = ncr710_free_request,
 };
 
 static const MemoryRegionOps ncr710_mmio_ops = {
-- 
2.53.0


