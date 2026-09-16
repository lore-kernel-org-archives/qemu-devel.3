Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D157C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6paC-00065K-1F; Wed, 16 Sep 2026 09:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6paA-00064k-8e
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa8-00035V-AI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEapkFoc3/SS/ruroSAmQFU1e206ax8sjMrw6J1moDU=;
 b=erTmFqfc9TuJMGJmiAFUunBoBSAqYYh3LOwActUSyAM3fmdS2MH0YbxKEjvaTHjSEHOfZg
 6p65K/zATkSX+/h6iOLXhboU1aCvQTrhNuiRJ279A2TROdmok9LNubVRlp+/53kH488WZW
 Zupi6pwnr82DVFWjhj9cCBfy0x/ToXY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-ukMOpWz7M-uIIXiVO_p5cg-1; Wed, 16 Sep 2026 09:21:43 -0400
X-MC-Unique: ukMOpWz7M-uIIXiVO_p5cg-1
X-Mimecast-MFC-AGG-ID: ukMOpWz7M-uIIXiVO_p5cg_1789564903
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-487038a4a88so1347362f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564902; x=1790169702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NEapkFoc3/SS/ruroSAmQFU1e206ax8sjMrw6J1moDU=;
 b=i4sPqmd8p8cL6t7dcQrREq5vIwtFTwkw8HAfYyA/zweHALr0S3dSimWwJGUYzlpDET
 Frgr+rSfGUubDC/hm3HtwdFwQrqii6q8utNf8MU9JxZxyPZ34eKCoZovv8lwy6FO4Ocw
 o4ZGS/aX4hi/zUbwx8+N0nkLh9ExdrAAbwsYIscICe1WAxLgGFzbJrJigE5D0e4wJWxV
 t2rFQab72TteYa3QeT6jzFglQ9JZYD6qfD3uMVGol266BDarTTgc6TuYlpMH8XdVBfWj
 vlD4JAysPYdqdxBTSfavpUiGCIgY37JYgAAaVBgV4a0Jhe4nks1/tL3DqKs8gGmXtA0A
 zKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564902; x=1790169702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NEapkFoc3/SS/ruroSAmQFU1e206ax8sjMrw6J1moDU=;
 b=2eS355uHvWNQf9H2eLDMuUJI1uc1udh+Qjcw26Bsj9NN09Tar77hhikm9JJoRUSnry
 7yg7LT4vfjm3FF0lwiumB09WZz5RKBB3FbRnUCmvcDNXA/9oW8fOeuWlX0JZjrTu4hcG
 etLFyz+47hC1H8qvdo2K8//1qy6QcSG0DUViNfxgci5bUqoXhdDvMOUjKtJGrdztLZuB
 2xvAIq6D+LFcC9qzDBjWpggHt/ZjypOtOCTEIWlM7P49Az+i/IUg7EcoqGhF0GcJrH9C
 /gN7741+OHjzFTsWmKMQ6qbEWlGcej3yBCn+LL1TzSEuHbfhxGW3al6wsOJ6qNPKtGF9
 llPQ==
X-Gm-Message-State: AFuF++mx4J35i157zgSL9SkxmtzU9AZEzvJvgSrkVnU4FbSDbBS0FMQE
 WX51s5a76p8Ux1OKCc7jiESbzB9EF89spypo4uL/LBqTrBRgNsyRMqZbadeQXURtnM7tvlarNv3
 7EMozsPmFWCGuTKNRxmVXvFcDiBieMD6ih2QeLAmwmFkPz3MVC2oq8rKui0Z1CiDqhPT+ojHgp+
 wQhu+9uApQ0KjMvriUEiW087EEd6MAouOBZnbPj/jR
X-Gm-Gg: AYBFou1PMiZE8QtFNwBTj36PeaQTTGcvsqooVdada54cr2Jzr9jjPfmDW4EtrXnUWA3
 sNip9VWN0IhAkzWwqAQW6aUl/kR5b9bko/Vx8I4lpXztOpcKkXeeE4y1S2AvvmhiXD/ofEHOIK0
 MB3rwqBKobmGxBR2r5gOnjt8MQlP0mY/cHd1ONgPnBzBjG0rEWNJt6xARl5hm22ow9QU9vfLpNG
 La0L7OiiT+QBXsXBlyqe/dr3em6OwJ4ns4A7Gbi59t9JTG8xIUKlqjA45DTvYpbHZ9uG4aOya2A
 0InuqxNAONcqPFx2QCfTuVTVAkTVXQYpJUpeYQeY8K+mkvKqKjvgf78G6FdIAI7xwa3PfBJvVT2
 6yoR8XbCx1oWRJWylu5Yw1ApzyD6VTazi8ISYQ/dtPIJoBhEjG6FPS2qPzoQ1uZBKqvJxZW6uZw
 xGDIy6
X-Received: by 2002:a05:6000:41d3:b0:486:f767:8be0 with SMTP id
 ffacd0b85a97d-4870cee660fmr3104090f8f.12.1789564902320; 
 Wed, 16 Sep 2026 06:21:42 -0700 (PDT)
X-Received: by 2002:a05:6000:41d3:b0:486:f767:8be0 with SMTP id
 ffacd0b85a97d-4870cee660fmr3104027f8f.12.1789564901571; 
 Wed, 16 Sep 2026 06:21:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27ce2sm7432592f8f.20.2026.09.16.06.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 7/8] ncr710: copy reference counting fixes over from lsi53c895a
Date: Wed, 16 Sep 2026 15:21:19 +0200
Message-ID: <20260916132120.860910-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
index 2a658a00138..d5bc3de6f2d 100644
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
index 25cde311b70..18c3a4e8c51 100644
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
2.55.0


