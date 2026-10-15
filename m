Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90395CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ75-0008S9-8g; Thu, 15 Oct 2026 06:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6p-0008Ep-V0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6j-00081b-0F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6JmCSe/+TU2ARnjQ5PdYdd6dT48oDlUT2AZT0kgnDY=;
 b=EduQSInrcAhiEvpIkY8gIR/iYMClQ2ekfJxOD+dB/4shB0g637pUnb2kpNrFF9Y5OwebOY
 2TcqGAhjB5wJCjUCGL8n3bIUIfWmw4phPPw151xQVscZDWpEOacWOVUtzBpN590aop1OEK
 Rtow5gDu2Angxv+W4Vl9bzJgWMoOvYE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-rvY8iqPNM3q5AnLFR_lecA-1; Thu, 15 Oct 2026 10:54:43 +0000
X-MC-Unique: rvY8iqPNM3q5AnLFR_lecA-1
X-Mimecast-MFC-AGG-ID: rvY8iqPNM3q5AnLFR_lecA_1792061682
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dea677afcso1270882f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061682; x=1792666482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N6JmCSe/+TU2ARnjQ5PdYdd6dT48oDlUT2AZT0kgnDY=;
 b=ryWAz0CQZeyIvzE9pH2FXKQNItcgoLVVF+HHQmfnxs9FuXEk5n/AbV4FHTOO8d2wIp
 syc7ErhB6WLNqsLE77BeBDiB/TC0krXrdiQSDJYLCR/AqEqUSapgdUq/NNVOV6la3xeF
 P6xpap2AAqdLRYzEyI2FnegtT4p5EwcLX9ob9FC8Sv9OORk/aXdaANew2xi6aUYMeS36
 ExFAh5/DGk7ml+D4udBrpoui3Rds0Fp+g20kyGDrc4zUb3Xyf0WPfUNdVy1XZXjq6EaU
 ghdeNv+zcPcJZDeVDOSpDMawVONBDiru+zGNpyyvh++4tXcEITd4kkow1bRAz9syJGKD
 4dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061682; x=1792666482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N6JmCSe/+TU2ARnjQ5PdYdd6dT48oDlUT2AZT0kgnDY=;
 b=CaRHqMb2IrP2J3bjFW1IEJM07SWF+jyv99oH3K5A3weQpBC77A7aU5ww7AFjEzD3wk
 PGEFJvv+0NsGRmR3q/4ERAottKMnLeZWkKmMwQv/SdP3cvP1cTa/HoztCoFRDli9tLVb
 K0/cVlNce9pZ33QFSxKpHKtYGE/LgubB3RSsaQKyL2aUoICHOto2+f6mL7n3nKhyoKbb
 hFo8aTbsfQsKHckDZzQV57kIksOlwn4AF9jOlEyVHRZ8FwHbJtrOzenWQgVlQEDmZo21
 WYFtLjHUINkZoMamd1JhnT4YlcmnOMI2JFmxpIC6Bk+Rxkt3KkBbQny1qfW525KU2Tpz
 H3WA==
X-Gm-Message-State: AFq9FYIx5IY4dQjzmzBqGtCq69CrTBXR2PbC71h0oE8Qwaqdpmlmzb4x
 idMhpZ+W8mpm1uzzb5K+FJHbpINKMyfwCx3YmDol0bNpaie2CpO6K8Sq2KD6R1S47CVbaACBL+t
 n9izfjxI0rqmWIRFRV00hKn47kDBzF+CNgq8GoUWysDi8/hh7MSH9g3SE7R96ztMNZUf7PghfHC
 WEs0DN8nWAqrFMCCmtSAaCMcZWFXbOBHArZyog/AXo
X-Gm-Gg: AYBFou2eNQEtuxXXmT/61S+VxJD1/gmjbTW33ZOBZPycyuXBMY41vQ7+qJFq9GySmN6
 ZfGymTxAwpF7eyI6yk+6uT27AOwx/m/odAg8DxTISsaKVRb5Rh4JaXMCyszTqKtJSkpg0i6IkTL
 eUc4fwQ4TBrosCBSf2tBbkt9SuW2nifsk17gVGUPm5kfkM3Nn90cCOzVMkf571BXGQncycQ9Yo0
 P5Yxp0ddQFuG67ALunozVd/3CAwTHC26WpN1azzHA1GQUeftALw6B72PhNOgLnccnUvmM+ZqyeQ
 MQ/3yb1/+coXfvEKyMgPxb9wUdzKRdvXnAIB8KbTtIfqSeC4NONtiTm2xYGFK6rvMIBLw5t0K8W
 Y0yMCh4UYXSYXsLfigfe/WiqjyXJBdpHISCurpkZQhItKY45JEED0rMu65XWD+TGrlCsFdup0U7
 bY1BTs
X-Received: by 2002:a05:6000:400a:b0:48d:f4ef:62e7 with SMTP id
 ffacd0b85a97d-48df4ef6476mr3666168f8f.0.1792061681798; 
 Thu, 15 Oct 2026 03:54:41 -0700 (PDT)
X-Received: by 2002:a05:6000:400a:b0:48d:f4ef:62e7 with SMTP id
 ffacd0b85a97d-48df4ef6476mr3666114f8f.0.1792061681265; 
 Thu, 15 Oct 2026 03:54:41 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm18282682f8f.14.2026.10.15.03.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 07/13] hw/scsi-disk: move MIG_EVENT_FAILED into a new function
Date: Thu, 15 Oct 2026 12:53:41 +0200
Message-ID: <20261015105347.827029-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Move the MIG_EVENT_FAILED logic from scsi_block_migration_notifier()
into its own new scsi_block_migration_failed() function. The next commit
adds logic for handling another event, so doing that in dedicated
functions makes the code easier to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-4-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index deb33ac1dda..3d88e57eded 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2761,20 +2761,26 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
  * fails because the destination may have already preempted and we need to get
  * the reservation back.
  */
+static void scsi_block_migration_failed(SCSIDiskState *s)
+{
+    SCSIDevice *d = &s->qdev;
+    Error *local_err = NULL;
+
+    if (!scsi_generic_pr_state_preempt(d, &local_err)) {
+        /* MIG_EVENT_FAILED cannot fail, so just warn */
+        error_prepend(&local_err, "scsi-block migration rollback: ");
+        warn_report_err(local_err);
+    }
+}
+
 static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
                                          MigrationEvent *e, Error **errp)
 {
-    if (e->type == MIG_EVENT_FAILED) {
-        SCSIDiskState *s =
-            container_of(notifier, SCSIDiskState, migration_notifier);
-        SCSIDevice *d = &s->qdev;
-        Error *local_err = NULL;
+    SCSIDiskState *s =
+        container_of(notifier, SCSIDiskState, migration_notifier);
 
-        if (!scsi_generic_pr_state_preempt(d, &local_err)) {
-            /* MIG_EVENT_FAILED cannot fail, so just warn */
-            error_prepend(&local_err, "scsi-block migration rollback: ");
-            warn_report_err(local_err);
-        }
+    if (e->type == MIG_EVENT_FAILED) {
+        scsi_block_migration_failed(s);
     }
     return 0;
 }
-- 
2.56.0


