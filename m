Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286BC10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EiH-0005mh-A6; Fri, 27 Mar 2026 17:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiF-0005Yu-Cb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiD-0003p5-OZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8WL7DzJeKU4ayulWVhy2puPdPuY2wFd4bIkD8S1wS0=;
 b=XmNZ6bDZqrh6CIkC5o8c7+5wGcMsKQnK4ORxKPP09/DD336PBkxaUtLAm3t/6c0n3n6sja
 U07z8ckNpWMG43huCZVoaZwPiSmtuAg0Uz/ENntKOvxvCQu+9d/txFsGcw2MVjRgcSoMS7
 LbgM+9ibpoNlb9VhzIMPLoKCp/QUjtA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-uydHhSxyOyqO2FRWK0zR4w-1; Fri, 27 Mar 2026 17:27:14 -0400
X-MC-Unique: uydHhSxyOyqO2FRWK0zR4w-1
X-Mimecast-MFC-AGG-ID: uydHhSxyOyqO2FRWK0zR4w_1774646831
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b96365ea8so2481924f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646826; x=1775251626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8WL7DzJeKU4ayulWVhy2puPdPuY2wFd4bIkD8S1wS0=;
 b=qsrVPpO2EWe+ZMcUfPdBYh6GZHKhY9KZRumETfQVYKSYNh706SBIZgnIZFVwDg45kv
 w3eY/ldxxO8dphS8MLYTl9uEuXf+E4svDWHJRJmQqDgLtOScECSmBh3X49rxErFgIh3L
 888c871YMcX8H8mCh2k2l+eILJNqq4zEMChd+nj+9M/aLYqth3dA86n2PkMnWscpsBZq
 Xo5IrOegGRgNrMikhV6mpxYPgdd1wX0H+CuOrp/7LZhNVAt25HbtuD2CaWxTDvH3nr1G
 Ssw7l9ONZ/keRXn3oXi3WA00pFobVHoX++EgdtdTSYys7C5RG3CEH+Wdhmd4fATe0mpY
 xfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646826; x=1775251626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8WL7DzJeKU4ayulWVhy2puPdPuY2wFd4bIkD8S1wS0=;
 b=Tq1yglkcKuRJAgCax0dtcxv6DRF4uZuNHkUomI71YyHeB1VE+jGRig5X5fSiRi5bIq
 1QcY0nLArpJZ2UKu8YkGtufbsbdH/NQl6rsNtoi6wRMs8S55tsVkt7NC7NpRPuYoGr/v
 I+OBWmHN7OlIvwnt1ZU4HUdkysBwloc0T4eJKWlOIUNMxee+JV9f7k2g2924jqi4msf6
 naxR0EyrInB1ieKbwdkfFq5LyEp4/5qwQNCUN5cfmFcCgP8IonwpqgGiLKIzMQOfoRsj
 oUqsQNpIgOJPaSnTO2rFEFbICVBBpqstfNHmzpt3g9ul1Y3R62wJH8vAuNdWvwpD/5g9
 nbvA==
X-Gm-Message-State: AOJu0YymdPxlZocJ3uztl1wcAeUzUcwey/dL7GjdCgMEl42DcORvseGd
 E1Nj8XJP2uVH+aeRkdd7t+0xzPzfNz3XA31WKLsdYj5yvaDUcoZt4E91novDkQ/NxSMjtiNbSHb
 40RP67w18384OJMIIiqOfdGlpx7BUX4I66/H2eN3uNfnajUTgRd34qz8FmWfI+IuQsYocE3TdmZ
 x6AB8dtlGavcEpgOB4p5I1aOWHjXvYrlZj+XH2rUAm
X-Gm-Gg: ATEYQzyggaVrS65RPX2eYUxalhcR1ZmG2Qn20qfr4NTxbctGANSBUe5EElgFMuPoPgQ
 otvpEr0j/y1rsF9U3Ajc1VJ0bgLB02ptISc3IsaCbaNMKYf25Ls9eMlhiF1rex/UmNG3S98moCL
 Je6MPASjrNH7wKo7pYhT84L9ts3LCfShV1JmUhVi/ei2/XFGNI2wUk0JqexM+ocv1GbTtQvkXZc
 6jLVxiGPWtpWLC7G9i4Dzb5Fn4aBjO51HcHphpsBMjivQNi3Ok7iFJ/50H+fVMybCYoV7hEo7vD
 SW9QQChxtBlYzCgfpABWKV7Zy9D9Wjb10eKBnA5DGiwr6I0pCbAU2QV6tQwxsTKEDov0ubou+qO
 SePnkU5ACUi7rxEWlvRspic3C2Wjkb61Cjgj+2uz8z3QR3FlWkQf6vn4y+rzQFronaUS0IhaVb4
 v9p3Pe6D1T0Ht5S89ZsKAjooz7
X-Received: by 2002:a05:6000:40cb:b0:43b:5003:e300 with SMTP id
 ffacd0b85a97d-43b9ea66e1emr6684259f8f.43.1774646825988; 
 Fri, 27 Mar 2026 14:27:05 -0700 (PDT)
X-Received: by 2002:a05:6000:40cb:b0:43b:5003:e300 with SMTP id
 ffacd0b85a97d-43b9ea66e1emr6684205f8f.43.1774646825382; 
 Fri, 27 Mar 2026 14:27:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm790860f8f.14.2026.03.27.14.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:27:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 12/16] ncr710: clean up ncr710_transfer_data
Date: Fri, 27 Mar 2026 22:25:43 +0100
Message-ID: <20260327212547.460420-13-pbonzini@redhat.com>
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

Move the short ncr710_execute_script case first.  Remove redundant
s->current check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 65 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index fd03f243eda..f768ad74237 100644
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
2.53.0


