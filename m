Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FFC10D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B9w-0004co-2G; Mon, 30 Mar 2026 07:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8u-0003bo-JW
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8s-0005xa-6j
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XB8m7Sndyux0qiJrEVjHOmARiOQkTMH4+4NUfWzFM0Y=;
 b=JYPCpkLeDJ9w/M0NuivMnP5f3F5pD+fHTA1GrbIxIeelUoATeSiZmrLk2my4Kadmxv+AxO
 f2sfA/0gpI8XXiFv6P8zX/s8LQwFhBpNzINmUutUudCar3UAHCeLetZ+l7VKY8tuWtFFyJ
 +uXsIVEqxfWCgiqpY2ulpc6VPHoeXLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-1hVFE3iAMeSmJYX0LXq6FQ-1; Mon, 30 Mar 2026 07:50:44 -0400
X-MC-Unique: 1hVFE3iAMeSmJYX0LXq6FQ-1
X-Mimecast-MFC-AGG-ID: 1hVFE3iAMeSmJYX0LXq6FQ_1774871443
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so38080855e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871442; x=1775476242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB8m7Sndyux0qiJrEVjHOmARiOQkTMH4+4NUfWzFM0Y=;
 b=EEDH5fnYG5aH41Ge5O8sjrkQVjXP7aM32BI04hBX2vfEUJAo2ueE2Ii217XDK3X/p/
 Eb4t3AIUAYNvvQ8oA71O4l6U7GZq+s4kvD3uEV7XgrUQV7+SMSW7EWHh0lBCM9Am7AVy
 163N9tD8ZSjaUUaojMQIjkJJuBZ4FD9sQMOTQ8JLZDETq2kJcfBsWnIBKGoCywXf7mwx
 DOCpUVT60RZM2Sl9saISGYtO8PjTT8H4/bKYpbUxM6WNe09R/VVxtMo6yDLH4/b0SUeP
 Etp9o+yZrFUaXm9vCN/zc/6pkOHq/x8YB56NTFgRQviHGc0rqlAlHFbIkIfZbY3Pysh/
 GCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871442; x=1775476242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XB8m7Sndyux0qiJrEVjHOmARiOQkTMH4+4NUfWzFM0Y=;
 b=nhc9xAEUvL0xlwKx25LnS3r/1t6QKyHIseofrWEVoeoy6yeMUbNgBEKgaSMfb02gPM
 6uuZsWzAbaNLk31tqQTF5D8Q/v309mQrhhNkq1mc9lp6aiUrx5XoCbMCJ/nI2uqdHCk5
 b7B6rkVr9nQhYP7XwA2oRag4xUhsRTjgj6AXYXfMm/uEYmIlt/v8WC6tPGVB3bDoEysf
 8xM1SJ5aWMbZPCnI7+VQQUpDg6giptvRJlpkVAmNxmnUKA5A320ea2EkT/OiFjWoNg3k
 YrRD2RXcSfCxR5jpapAfNntJ8v63Na0YrgKvrooY9oudoV8HJ/sHb36qzOnrwAcjJo01
 CCKA==
X-Gm-Message-State: AOJu0Yws9VJEXhuQmHA8ykWxJMkaAeDCmgDxLGyZcZNAf0UUsD/5+TjT
 gs28h0P/XDTStuiK89zLtepDnMT+gVCovF4bZdSbpDEN1rvMVjiE2z55BGp4XDL/e6Q6+zvtoJC
 TyDJu8xjxtod2K7gzy22QHcLOflxhutlGuAaxkv6Mq3vL7Pu3i+hJuMJYl/Tt1ufhlwDAwoFeNo
 QIZ3MGDfJc+YRW33pA6MV+ts1SPvg9vE1iPdw6DWnL
X-Gm-Gg: ATEYQzxQzMHfR4M2fOTUE/4Ln4VEmwGwpJzO9+M080OJVUhHCmJ5TDvK4/DZe/Lf1w1
 kEotOvGz4D1w/xIE2VzMPsQ6WozPbzipNkVg1P0QCbmilXisDHQiL8/rPdijZbQFlL1pF2qgc7O
 HDAPLUpfHG+BwqPqHGgWD4gCP3wrim0w50138Tf5XcEVjNNFU9et/t8jvTeUG4K+zr/RMkMmO2r
 MuCX/CPPfZv07NSPVJIqoGg/A8wPOigJCoIlI4hDSJvLNcfcz7IcrV1Hc3JzyY73N5+8yc4ML0G
 LVk0zH5Y38ePsFYSf5TM7c1WSd390KrZc1KH199aFb28aNw5Mr46X1PszhVOEr1tPCk/PVj4YYb
 TUkCV8wDydT12u19YPxsu0q84qEk2lTBKrP1pD3Kqy4BYv+0FiZFqZdu7I5gQaHLaXYGu7GqqNV
 fzpPyEDkoKDQEeauLSUhCJpubm
X-Received: by 2002:a05:600c:a012:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-48727ede8d3mr216732995e9.21.1774871442425; 
 Mon, 30 Mar 2026 04:50:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-48727ede8d3mr216732415e9.21.1774871441797; 
 Mon, 30 Mar 2026 04:50:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e265fsm19206909f8f.1.2026.03.30.04.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 09/12] lsi53c895a: keep lsi_request and SCSIRequest in local
 variables
Date: Mon, 30 Mar 2026 13:50:13 +0200
Message-ID: <20260330115017.256211-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Protect against changes from reentrant device MMIO during DMA, by always
operating on the same request.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 81b4f93f4d3..1180e601811 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -626,6 +626,8 @@ static void lsi_do_dma(LSIState *s, int out)
     uint32_t count;
     dma_addr_t addr;
     SCSIDevice *dev;
+    SCSIRequest *req;
+    lsi_request *p;
 
     if (!s->current || !s->current->dma_len) {
         /* Wait until data is available.  */
@@ -633,12 +635,14 @@ static void lsi_do_dma(LSIState *s, int out)
         return;
     }
 
-    dev = s->current->req->dev;
+    p = s->current;
+    req = s->current->req;
+    dev = req->dev;
     assert(dev);
 
     count = s->dbc;
-    if (count > s->current->dma_len)
-        count = s->current->dma_len;
+    if (count > p->dma_len)
+        count = p->dma_len;
 
     addr = s->dnad;
     /* both 40 and Table Indirect 64-bit DMAs store upper bits in dnad64 */
@@ -653,21 +657,22 @@ static void lsi_do_dma(LSIState *s, int out)
     s->csbc += count;
     s->dnad += count;
     s->dbc -= count;
-     if (s->current->dma_buf == NULL) {
-        s->current->dma_buf = scsi_req_get_buf(s->current->req);
+    if (p->dma_buf == NULL) {
+        p->dma_buf = scsi_req_get_buf(req);
     }
     /* ??? Set SFBR to first data byte.  */
     if (out) {
-        lsi_mem_read(s, addr, s->current->dma_buf, count);
+        lsi_mem_read(s, addr, p->dma_buf, count);
     } else {
-        lsi_mem_write(s, addr, s->current->dma_buf, count);
+        lsi_mem_write(s, addr, p->dma_buf, count);
     }
-    s->current->dma_len -= count;
-    if (s->current->dma_len == 0) {
-        s->current->dma_buf = NULL;
-        scsi_req_continue(s->current->req);
+
+    p->dma_len -= count;
+    if (p->dma_len == 0) {
+        p->dma_buf = NULL;
+        scsi_req_continue(req);
     } else {
-        s->current->dma_buf += count;
+        p->dma_buf += count;
         lsi_resume_script(s);
     }
 }
-- 
2.53.0


