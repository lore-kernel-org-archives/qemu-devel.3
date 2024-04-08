Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A680CC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 12:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtnpZ-00065H-4X; Mon, 08 Apr 2024 08:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rtnpV-00064U-RM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:10:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rtnpT-0004oK-Ec
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:10:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so2481100b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712578106; x=1713182906;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAKn+HK/aO2kUntmx7L4AWae45qjf7S1vOzU9qUnU98=;
 b=xJsgSDirD35W/zqrjlg+amHwFvQXbgE/c0hcJznjtNmMnepRj0pTq2g67AelRqcgIg
 fMYyOAGipC5tyLbc7hhBmQWpJHbouAQDISdbgIMcPAvcJNi9azZs/J7EiJftYAy0qo5f
 5VHgrEpbfD6QvzZfGjEqjjPLynJ3LliZyKNLec5sj6oRdnIxFiWT/sZvk5yv12lUM+7J
 cFRhriO8CRwSwic3JXWX/6InvBdE1y03AzREnUfL1TekkS07k8Lidm/uBMf91ulXGHgB
 I22+YcJl+pRvMLVE2fSL3ZVilA/zXfLqTVlOhJVU4cvTiVh/uqTH+1t5AQYBCynuYSkj
 UUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712578106; x=1713182906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAKn+HK/aO2kUntmx7L4AWae45qjf7S1vOzU9qUnU98=;
 b=cUDsuFUuuS275wJBqnBE5bmmd+pm6H6fvJkaxKsiHbc0nilekW7RKZpAXluWijfLOK
 dEfL5pu82T+kZtwrNzC2S5XdYZyv/nPQ7M6JlfYy5WFDMsex7MzIG7GB0nG8cYGRdM+a
 xclw06S9JllIfynghhxtZcjuxhLJ/ON35C4TG2wslfwkwuooOm5DC05F/n0LBE2Zx7Ap
 4fe5ucFTVb+nsaw+RwEgMlI07XhKu2RQCFUBbhe03mJc29ri1anMIXdQqrd6jTwOcfFc
 zPcM10dvIOg1J3DYJYNINNnFE8GvNXbo10bK9DV857yaao1cLi1u0TBjJfQGUOkTEiJQ
 zcWQ==
X-Gm-Message-State: AOJu0YzD4lCX/8uu7eXQO6zHwIWV59O4If+pDNgavy08kYR2uo5iOiNI
 qPfGO/+uTXSgNxc3Lo+77gGqZqt+qidhYGiNUDBH88h2oNS/cC+mZPi/9bTB0/wKgAxuN1Kf09a
 wJmenbg==
X-Google-Smtp-Source: AGHT+IHFYqYc8C3C2li1YwdZy8prHut4eltf+FCu9Z+Kj0I2++y+JJ3msKiuUuPGzzOXspWpkfDeDA==
X-Received: by 2002:a05:6a20:3d82:b0:1a7:97dd:d800 with SMTP id
 s2-20020a056a203d8200b001a797ddd800mr289594pzi.15.1712578105718; 
 Mon, 08 Apr 2024 05:08:25 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 x42-20020a056a000bea00b006e6b180d87asm6410478pfu.35.2024.04.08.05.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 05:08:25 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH RESEND 1/2] scsi-disk: Introduce the
 migrate_emulate_scsi_request field
Date: Mon,  8 Apr 2024 20:08:17 +0800
Message-Id: <2da3a08785453478079cfd46d8293ee68d284391.1712577715.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1712577715.git.yong.huang@smartx.com>
References: <cover.1712577715.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42f.google.com
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


