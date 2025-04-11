Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4F5C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Nn-0001tH-5H; Fri, 11 Apr 2025 04:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nk-0001t6-E8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Ni-0004il-Jj
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2260c91576aso14244155ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358697; x=1744963497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MJO33h08GE60V6bLEiUEHlZaWjO09OnGNPdPAk5FWo=;
 b=XCrNJgXsiS9anr0eZXpG8llWAKn/ym6dB5uBUYAAVBndu4jI/IkHCSWXYO1nfFExJw
 eUlSvkEMejiMMNZ5zdH2bZhc5ZuCKeKYG9j8gG8xPScpsf4tfqUCMn8REz640CdOGvBw
 XHh9pUjdezhMSVvP8M/aItlLtlH9ygSzNv0huh3PQv7ptxYyf3EdqKl5EhomZae7OJX0
 aNKTwvdply656bidtZiNRLvq5v8QsbGzeUFFqJhOj73uZNfQlRzL9SmRR+A6OxVxfK5i
 xtYBSPYRNGKgkWA+aLo+AXJVtSEX3RydUADj2dZWodXXtBErVD+1lh1UOJIHLWpgAYV6
 1Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358697; x=1744963497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MJO33h08GE60V6bLEiUEHlZaWjO09OnGNPdPAk5FWo=;
 b=EggSV2U5Gpiu6W2DCNQpv/ev5lTjLSMANB48C6akDYbG8o2S9etPAjBshurAitOYop
 rMp5ShrOLwQTWFQMfhh6JnR+3QaxISguC+EV3IKjW1L48ljHMbiTJFnsTANfRyI+vhH7
 HtablSaJzUpPCHXUxqfBEoyh+/FKSJqOgx00g+861SRk/5iwr/tkRYDhnEe2ksM88SSV
 t2cfog6sC7OkWqdtqWS4q5z6PuNqQASjI4TYTvS6WKU1ZvQe7MyJ4WcohSBeXeRTLzU6
 XxCJvU7peXXhvtiIwpXdptX4aiwIxHZ5noUMgV5GM+Wuh+cjbhM67oK19ZLMWIMV20dz
 Rdeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4k06ik5eiseIRuRHxWcv8MkS1D502fXh7fpzB2iqNji+bkh/uYK4FD2ENTfPkAlgM9wabmypNXf33@nongnu.org
X-Gm-Message-State: AOJu0Ywwe/rhcUstuBoBS1r25TFnPLXxjPbaLqLp63GpAGtGVv09TWqa
 ld+6Uzu7Kboq9pCLsvFbJMldaWgENBkwxejLb6//qQ6Pi6RhryVb4REsjA==
X-Gm-Gg: ASbGncv+PajrAQKyG4ZdvaMFfd0ib6PB43GFq8cGuUeyIeGJWD5k85L3yqJyT1VzrnY
 7znWQUFDl/y22xvSrkcqdNw1Js4YepNYxmjYhdPvaIx8SM4qQRSwwxlhDn2BXSgWHxQxyrV0B6k
 730VL/XuAIMRv6NxfocaJFauJW8TC5KYTmtR8bTSs2jUZfXHptN9huJ9fytZ1eh/soNjmuiPrua
 DmAvLfSkcRoHVHZbOhKfmZthrtxwPCL1tKQZsWoKwD19P7S6e3WQ5oAqWqJ0/SA9FaSsTJhs0dA
 jXVLi0xwPkR+r4KU2M8hF/nLmCW3LeRG7n8B39nQN4hD
X-Google-Smtp-Source: AGHT+IG3DXCThWYR8TdW8CRGUpS3CEO1RnPTPANrnjrrLRNgrly5MiX55Q3+387wAPqSxsj0CwED/w==
X-Received: by 2002:a17:903:11c8:b0:224:255b:c932 with SMTP id
 d9443c01a7336-22bea496003mr23405635ad.3.1744358697233; 
 Fri, 11 Apr 2025 01:04:57 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 07/10] usb/msd: Add some additional assertions
Date: Fri, 11 Apr 2025 18:04:28 +1000
Message-ID: <20250411080431.207579-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add more assertions to help verify internal logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index a9d8d4e8618..3b806872587 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -264,13 +264,24 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->data_packet;
 
-    if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
-        usb_msd_fatal_error(s);
-        return;
+    if (s->mode == USB_MSDM_DATAIN) {
+        if (req->cmd.mode == SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else if (s->mode == USB_MSDM_DATAOUT) {
+        if (req->cmd.mode != SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else {
+        g_assert_not_reached();
     }
 
+    assert(s->scsi_len == 0);
     s->scsi_len = len;
     s->scsi_off = 0;
+
     if (p) {
         usb_msd_copy_data(s, p);
         p = s->data_packet;
@@ -288,6 +299,10 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 
     trace_usb_msd_cmd_complete(req->status, req->tag);
 
+    g_assert(s->req);
+    /* The CBW is what starts the SCSI request */
+    g_assert(s->mode != USB_MSDM_CBW);
+
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
     s->csw.residue = cpu_to_le32(s->data_len);
@@ -486,7 +501,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
                                  cbw.cmd_len, s->data_len);
         assert(le32_to_cpu(s->csw.residue) == 0);
-        s->scsi_len = 0;
+        assert(s->scsi_len == 0);
         s->req = scsi_req_new(scsi_dev, tag, cbw.lun,
                               cbw.cmd, cbw.cmd_len, NULL);
         if (s->commandlog) {
-- 
2.47.1


