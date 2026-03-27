Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0808D10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EhC-0002pc-NS; Fri, 27 Mar 2026 17:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhA-0002p9-Vh
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Eh7-0003bW-Gu
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XB8m7Sndyux0qiJrEVjHOmARiOQkTMH4+4NUfWzFM0Y=;
 b=CvJ8+sxSLLZQ9RZisbFGDH9D2rTjlUUjtv07qpUAxWlfz4Lmb7nvEeJLsLCNvE2L1Fwm3C
 Pxdux/emwmHNOhp59mnM21Et5KDSH+Nu6JJ63jbNmxnMqUm34rDHsyN7mpL+s1flo/dsen
 cocoMv+yvayT8hmn95C73sU59umvVm0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-s9pHYuhnNYu7LVNfjoc0rA-1; Fri, 27 Mar 2026 17:26:13 -0400
X-MC-Unique: s9pHYuhnNYu7LVNfjoc0rA-1
X-Mimecast-MFC-AGG-ID: s9pHYuhnNYu7LVNfjoc0rA_1774646773
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439f5c57c52so735573f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646771; x=1775251571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB8m7Sndyux0qiJrEVjHOmARiOQkTMH4+4NUfWzFM0Y=;
 b=qUiiukuUHFeQaAetHd3uKKFJBynp797tO7Gjxc88LnFSs2SrgwZ/hLM0ysLSZIF11a
 4OB+znHbFI0ieWvMIsC3TspFmbTdyqsD4G9+UfEnXFlbW+C6FltHs8jw2tqiX/UDha52
 vGJ2GyJq3rcoUa3K+u18ifxj+CC1LCbGN//yeaNyIIr+HtOO5gSoO0whnIPqN3zAH2qn
 /19gDVr+/muOMmEjHC6d+kdrrN8YSTCrmXgxxB5uXqIr7QkpXBlmQjMfA0UHH8h9sPem
 CW7z0/Uk7nzBdGl9CNDvygjwFnPAuIep88WF82JOkDM1Yw69PAp00zRWK23eaEaB7wvL
 mXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646771; x=1775251571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XB8m7Sndyux0qiJrEVjHOmARiOQkTMH4+4NUfWzFM0Y=;
 b=Euc3tgpV7tVkYyidFZw7I3hIxXTepk9jmU3Id+ZFs/H+Vmb8Ype+tC/0P/I+0yvzEV
 3CJPyUA6u8XedklnwOMuYNa1qN0Mkt4KfV85rFJdRUxh1nTODEfThO58E5XicB+YDABD
 WTMsFvw8fRHYe9VC5BsIp4eiIvJ6xv9485jsYO1Ec1YSSs+yAHizFNeniTj3KhHbnO+8
 KNaeLY6w/ZQtZ7JuX89b3I5ZQfkwNUl4HWV8oKsZJ+anKHcRRlIyZdgKc+UXGzawygrs
 iHkgap6F7/walHc2KM7bSxkmUTce/fW+yocRQJDWNZWZ2903OEGBLA0+rrD3m42eCAto
 k2xg==
X-Gm-Message-State: AOJu0YzXKaPOFyX2S6CzQL0A9+h23L20YNkNgJI8hRN2Ws1WnescRflm
 a/p+M/vV1wiMQdjAvlpEGnUVEMEQd0yvir9/iKdofgup6iUrpuJM2O4MDpi6jGbRpuraxRyfiZY
 7CQ6VIA7dwQdJ3DIUta+qOxKK309NH+SZWK9D9xvJ/SuLEebzC90xqBDR8/o+l+A1RYJHzxQy44
 /wEx7st789ri/3t6/IJg0IGGoRy56Onrm+aw5Rz1XS
X-Gm-Gg: ATEYQzzHtVdfdZTwGR+iwdVPzGe4a2cUeVQcbIcVMOpqqDWicccDgdaPfFx3XxQ4YF1
 tpRrGKQWqtVVZzHowq4pQvDqc5Hd0Xca6TXft1uDb2boOUP9eYE1kmnbSLt1iMIX+Hr46pAw9Ws
 t18vg8YB6sv6Z2WppPykxAbuR662a9dunZqMiva+mPvaLI7pfSFudnqlXp/XFc0u8P/85wPdPIX
 AZbqYopAnxX03/t06kvwb810xMdfGryfyb0CRS6emTGb5TcxV5IJ4sfGKdknbfeC2cItfPOK+ck
 9Jv2JOLTWVLXgYGV/ZxgnNdhOhn6bOMBtJAqS/UJLUwR0DozbxSCrU8lq1t78mXYnUgilxtFVUo
 O7+KVTgawkbaGUuv2BqXvzqXfchaKAqMKbsqIVhbS59A8+Oz7QkpBNFA2rNMZpm8ncbTr1sAHUA
 6VtwFXG2/ogdNnZjPMjjF5lLL9
X-Received: by 2002:a05:6000:40dd:b0:43b:445f:3177 with SMTP id
 ffacd0b85a97d-43b9e9e83f6mr6360011f8f.31.1774646771012; 
 Fri, 27 Mar 2026 14:26:11 -0700 (PDT)
X-Received: by 2002:a05:6000:40dd:b0:43b:445f:3177 with SMTP id
 ffacd0b85a97d-43b9e9e83f6mr6359983f8f.31.1774646770527; 
 Fri, 27 Mar 2026 14:26:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2487sm808172f8f.5.2026.03.27.14.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	qemu-stable@nongnu.org
Subject: [PATCH 03/16] lsi53c895a: keep lsi_request and SCSIRequest in local
 variables
Date: Fri, 27 Mar 2026 22:25:34 +0100
Message-ID: <20260327212547.460420-4-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


