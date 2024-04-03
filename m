Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3CCCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxkW-0003Y3-Am; Wed, 03 Apr 2024 06:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rrxkI-0002SG-PC
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:21:33 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rrxkG-0000tM-8a
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:21:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so3958817a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712139682; x=1712744482;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RAKn+HK/aO2kUntmx7L4AWae45qjf7S1vOzU9qUnU98=;
 b=lVZF1pIPag7vEVspYgber63I0V9R+0If/VFlPQ21R20RgJupunXIn2Q85BRx4p0EK6
 5eNtxHddxF34bTki8xK5UJkZGv8Sqp3FoJ5/dzFpHEVEnEjWr4FA4zpnHb+cF6cLUpSF
 YVzImjIIixjkoUZ7BVoWkWWuSzJQp4D4HacWNzdKvRctTzsYN6Z8yMwuuqGaZReo6nyE
 yOLeuMUz8+fiGXY1nJV3WJQOKFKSb3EEwXmBhLOgF14do8i7YXfS7IzNGvX6MZfPpxWy
 k2XemlbkQhe37f69VMN+TSOb1qY3ElCb6GX8jE9cuB5v6CDvJ2/bRoeuuZ/PD58/GE0+
 oyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712139682; x=1712744482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RAKn+HK/aO2kUntmx7L4AWae45qjf7S1vOzU9qUnU98=;
 b=ew7HL+nT+sKsBxeSZuoKzIcLXNIztA377uVRWXrpDdwXRWifXzd86Q7+5hEYbCXeGb
 fEhhQDyiS/uykZ9GSX8lkeVDpWKphOfGM+HsLBNmClFfyXBGRwz9+DxsCA3EVZR5XLnY
 QRRdze2+RoSCNTSkPaiSCfUhus9ivauYDubulrLHSt1p4pTLwXbUsFTr2GNu9ZPqcz6X
 MYFDf57Gfidz3giFD54h8FDkK7hQTyeVWq5N9vNJn6RN9jxJ6DHRtj0pu+pITfz33wox
 IZHeGb8Wkb2Os+FNc/trFALWCB+HqrLrhFG2nc/48G5TO4diB2BbNcKgH6TCA/yvvd6N
 96yQ==
X-Gm-Message-State: AOJu0YzGT3LBXh28KvB39FBktxGlqv26XPamPhFCVEo8j0vwIw3gSS9n
 yPtxBJ7dKR5mRFNaHEj6Nakdw88o+HukLqmUNVTvoGng0cSd4bsMlWM5OhWz+32kDa6M8zgddNg
 nTiwHoG6V
X-Google-Smtp-Source: AGHT+IGKo/6U0Q21WXxcUP/9oyTrxEzM8ctimogvqGSRbflwklzaSWRDQYGyjHmMF2bEl6vR0AmHcQ==
X-Received: by 2002:a05:6a20:ce4d:b0:1a3:68bb:89d3 with SMTP id
 id13-20020a056a20ce4d00b001a368bb89d3mr15164646pzb.17.1712139681523; 
 Wed, 03 Apr 2024 03:21:21 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 x8-20020aa79188000000b006e795082439sm11382261pfa.25.2024.04.03.03.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 03:21:21 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH 1/2] scsi-disk: Introduce the migrate_emulate_scsi_request
 field
Date: Wed,  3 Apr 2024 18:21:15 +0800
Message-Id: <4ed86afd109e3084f68c51e036884192ef535107.1712139560.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

To indicate to the destination whether or not emulational SCSI
requests are sent, introduce the migrate_emulate_scsi_request
in struct SCSIDiskState. It seeks to achieve migration backend
compatibility.

This commit sets the stage for the next one, which addresses
the crash of a VM configured with a CDROM during live migration.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/scsi/scsi-disk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..0985676f73 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -111,6 +111,7 @@ struct SCSIDiskState {
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
+    bool migrate_emulate_scsi_request;
 };
 
 static void scsi_free_request(SCSIRequest *req)
@@ -3133,11 +3134,21 @@ static Property scsi_hd_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static int scsi_disk_pre_save(void *opaque)
+{
+    SCSIDiskState *dev = opaque;
+    dev->migrate_emulate_scsi_request = false;
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_scsi_disk_state = {
     .name = "scsi-disk",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
+    .pre_save = scsi_disk_pre_save,
     .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(migrate_emulate_scsi_request, SCSIDiskState, 2),
         VMSTATE_SCSI_DEVICE(qdev, SCSIDiskState),
         VMSTATE_BOOL(media_changed, SCSIDiskState),
         VMSTATE_BOOL(media_event, SCSIDiskState),
-- 
2.39.3


