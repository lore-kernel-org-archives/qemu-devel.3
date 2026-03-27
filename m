Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD9010F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EhY-0003Eb-By; Fri, 27 Mar 2026 17:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhW-0003E5-KA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhV-0003h4-76
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ag0x9W61+MLi+fSgFl+jWBLoe9JN7um6jSU0ZIBfrJQ=;
 b=NSaWbBuo9x/R8XU6/do4jI39zULSbd1ugdaiRjJwGqyScj1tTL2/iSgRXwGCDiP7ojOwoV
 FhCNZUNOQxfANBanO9GOwEA7qF2r9J7dSVznNyNsDWaxDDfE0gf8+FJC3bEroFkR4jVjE1
 Id+nyiSGCd153NLvLVGNQYKSXi4jTSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-LAf42xDPORuFuAcIyP2UeA-1; Fri, 27 Mar 2026 17:26:39 -0400
X-MC-Unique: LAf42xDPORuFuAcIyP2UeA-1
X-Mimecast-MFC-AGG-ID: LAf42xDPORuFuAcIyP2UeA_1774646798
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48534941525so32035095e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646795; x=1775251595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ag0x9W61+MLi+fSgFl+jWBLoe9JN7um6jSU0ZIBfrJQ=;
 b=I+rVMam6zBIEhspQP+bERPn4izbkbZfHp/qErWBlKatjnydB+gVu6YQ6jUIL9NdLaw
 XR5V/eM3ouXsO8FQWW7wi6bE+oDYQpJaVD2IlRkZSVFynZPhoRxoEXEZDl83XOpSCKD/
 R1pr1sgrk/Y/CBZpn/gnTPLaMIBmZ2wtzFOTrG26nJOCg7mZaem7YhgHGZbi69wdDt4Y
 OoXNIavaHQfoXq7swZmacv8Uc8oh6JSq7gCebPwuueds+BSpDrUX6LSimZh5HN0B+o7T
 VV/DQoVltNhLfpom2Ykj8KMgwVge6cUQZsPvDjkA7cWr2oh9z5HWqFOD8/YATw1cGaZ/
 CJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646795; x=1775251595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ag0x9W61+MLi+fSgFl+jWBLoe9JN7um6jSU0ZIBfrJQ=;
 b=PW0CudDSuDh7gbfjsu29CgHs52vG4rcK5SHCoRHQ6LSpLvz21WNTFII2NabMll4DhH
 9dm6a1lgo94657Q8LtPLnFxsP9EzAxRJ+rC3FjYbvEKArdNtFGGo5bIykJ72aMwm8Lcg
 fg6Oo/N9Z4Dj0+Rq6o+GVllPmko14CW9r9DXU1URu6jkcCs0XPqNE4Hoi8Z/T4azfqC0
 Bb0rr5oQSRJ2mO/BZ+u/VwoXFgaDar0RZADIoxS3bB68Z1C4fTjgvHDUPPgten2+Q27W
 6dtjs0nUdspbapqZtdLUQUyfO16JcxJRQl/ooxqpadRZZ6plzpOL1TYHzkRylzbVEu50
 nI3Q==
X-Gm-Message-State: AOJu0YwTgEjJdMYbMUuPE+rc4L86crb9zXI4RFhl5aifGkheYBBkRzVe
 0J2hCgN3h1MP1UQwiiEcfUGvoh/1bp46MQqKCvDs4DAzkMoj2cumA23ui7quMc8FnM3veRzFXZz
 M/7RJcn4+xc2At/UDl3px0ed7U4O9amGx7gVM79KYvgw+2MMK0wXTZlBn3wATU3BE3qEBO5KsDC
 HIOhIas7bORf2+4q9a9moQdWBFq/XVWBX/ZeBbb0/l
X-Gm-Gg: ATEYQzz56PsJejLwHkOravjLy8FsvdCSl1K1t7OW+CRe7i1ijoTJqKOmHMMqs5yO6Ac
 gsE1Kyrq3MbirMX8ryP6YVvAknB2vukWmH7K8Cv7TC4ACN1jqj6YjQv4HBGgeh2VSCNiLF9W76N
 BII+QF3V4M4j5ZyNjfYnyzKTFWn4wiebPcStNSMLm0QRbBH1c2z4PdP6uoW4nkIfT2+961CYUjP
 lUqcRTA9lXn17ABG9U45L+63zZE52Uv1rG7o7MMhb3SPSJR7SsYC7d+AokE9wjmXP3vCXsYoRBA
 GZvFutVO1xqye4atL7k4dbGOFEFaw4YkIPGy0x/6e7U+YI1aS4amEJwXkV249yx1YiyGsUaOENg
 LeJye5bdfmptMvgBZlu4j66cxOHTx0Ctpn87PJUJXT1JmVK8e7GO3KhimCDfY7i4j7I0ku6t9zK
 0ifD73hYonIweG9C5vFfKC30CI
X-Received: by 2002:a05:600c:6487:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-48727d679e5mr66323035e9.7.1774646795475; 
 Fri, 27 Mar 2026 14:26:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6487:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-48727d679e5mr66322815e9.7.1774646794952; 
 Fri, 27 Mar 2026 14:26:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725ebe9dfsm33989145e9.4.2026.03.27.14.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 07/16] lsi53c895a: always use enum constants for s->waiting
Date: Fri, 27 Mar 2026 22:25:38 +0100
Message-ID: <20260327212547.460420-8-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 6b0c97d98e3..6f65a2188c1 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -201,13 +201,13 @@ typedef struct lsi_request {
     QTAILQ_ENTRY(lsi_request) next;
 } lsi_request;
 
-enum {
+typedef enum {
     LSI_NOWAIT, /* SCRIPTS are running or stopped */
     LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
     LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
     LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
-};
+} LSIWaitState;
 
 typedef enum {
     LSI_CMD_SENT, /* command is running */
@@ -239,7 +239,7 @@ struct LSIState {
     int msg_action;
     int msg_len;
     uint8_t msg[LSI_MAX_MSGIN_LEN];
-    int waiting;
+    LSIWaitState waiting;
     SCSIBus bus;
     int current_lun;
     /* The tag is a combination of the device ID and the SCSI tag.  */
@@ -605,7 +605,7 @@ static int lsi_bad_phase(LSIState *s, int out, int new_phase)
 /* Resume SCRIPTS execution after a DMA operation.  */
 static void lsi_resume_script(LSIState *s)
 {
-    if (s->waiting != 2) {
+    if (s->waiting != LSI_DMA_SCRIPTS) {
         s->waiting = LSI_NOWAIT;
         lsi_execute_script(s);
     } else {
@@ -822,11 +822,11 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     trace_lsi_command_complete(req->status);
     s->status = req->status;
     s->command_complete = LSI_CMD_COMPLETE;
-    if (s->waiting && s->dbc != 0) {
+    if (s->waiting != LSI_NOWAIT && s->dbc != 0) {
         /* Raise phase mismatch for short transfers.  */
         stop = lsi_bad_phase(s, out, PHASE_ST);
         if (stop) {
-            s->waiting = 0;
+            s->waiting = LSI_NOWAIT;
         }
     } else {
         lsi_set_phase(s, PHASE_ST);
@@ -861,7 +861,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
     trace_lsi_transfer_data(req->tag, len);
     s->current->dma_len = len;
     s->command_complete = LSI_CMD_READY;
-    if (s->waiting) {
+    if (s->waiting != LSI_NOWAIT) {
         if (s->waiting == LSI_WAIT_RESELECT || s->dbc == 0) {
             lsi_resume_script(s);
         } else {
-- 
2.53.0


