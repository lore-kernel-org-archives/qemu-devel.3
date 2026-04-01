Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5601A1076381
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zEI-0003LV-6Z; Wed, 01 Apr 2026 13:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEG-0003Jv-BE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEE-0001Iy-PI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775063981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZVJJmwTxXh+7sbJhmm6vZsogwXgbvdK40MsXN3n/Gg=;
 b=Ws+2UQQYg5CaJo4hivfHJQZv9TIPPnZiEQkuo2Ih1NOO5qaPnPIZADPACkQPYgypdbzxm0
 ZxdAZ1ZSow5hon/kSsGiY1Gl44ONDiKmBOavGxvAlmV+yhushW1xkH+Fpr4IJsnNuP/blj
 hjl1NTUyNRocrxea+DCijZtSIw4FWAY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-swJLtvw8MFiAabTc7jErBA-1; Wed,
 01 Apr 2026 13:19:40 -0400
X-MC-Unique: swJLtvw8MFiAabTc7jErBA-1
X-Mimecast-MFC-AGG-ID: swJLtvw8MFiAabTc7jErBA_1775063979
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8080F1955DDB; Wed,  1 Apr 2026 17:19:39 +0000 (UTC)
Received: from localhost (unknown [10.44.32.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6592730002DA; Wed,  1 Apr 2026 17:19:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, <qemu-stable@nongnu.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Qing Wang <qinwang@redhat.com>
Subject: [PATCH 2/3] scsi: always send valid PREEMPT TYPE field
Date: Wed,  1 Apr 2026 13:19:26 -0400
Message-ID: <20260401171927.396672-3-stefanha@redhat.com>
In-Reply-To: <20260401171927.396672-1-stefanha@redhat.com>
References: <20260401171927.396672-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The SPC-6 specification says that the PREEMPT service action ignores the
TYPE field when there is no reservation. However, the LIO Linux iSCSI
target rejects commands with a zero TYPE field. The field never ends up
being used in this case, so replace it with a "valid" value to work
around the issue.

Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://redhat.atlassian.net/browse/RHEL-155807
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/scsi/constants.h | 10 ++++++++++
 hw/scsi/scsi-generic.c   | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index cb97bdb636..717e470a5d 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -340,4 +340,14 @@
 #define PRO_REGISTER_AND_MOVE                   0x07
 #define PRO_REPLACE_LOST_RESERVATION            0x08
 
+/*
+ * Persistent reservation types
+ */
+#define PR_TYPE_WRITE_EXCLUSIVE             0x1
+#define PR_TYPE_EXCLUSIVE_ACCESS            0x3
+#define PR_TYPE_WRITE_EXCLUSIVE_REG_ONLY    0x5
+#define PR_TYPE_EXCLUSIVE_ACCESS_REG_ONLY   0x6
+#define PR_TYPE_WRITE_EXCLUSIVE_ALL_REGS    0x7
+#define PR_TYPE_EXCLUSIVE_ACCESS_ALL_REGS   0x8
+
 #endif
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index b55d068323..349dea6bdd 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -453,6 +453,16 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     uint64_t key_be = cpu_to_be64(key);
     int ret;
 
+    /*
+     * The LIO iSCSI target in Linux up to at least version 7.0 rejects PREEMPT
+     * commands with a zero TYPE field although the SPC-6 specification says
+     * the field should be ignored when there is no persistent reservation.
+     * Work around this by choosing an arbitrary valid PR type value.
+     */
+    if (resv_type == 0) {
+        resv_type = PR_TYPE_WRITE_EXCLUSIVE;
+    }
+
     cmd[0] = PERSISTENT_RESERVE_OUT;
     cmd[1] = PRO_PREEMPT;
     cmd[2] = resv_type & 0xf;
-- 
2.53.0


