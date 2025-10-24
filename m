Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E491ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 20:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCOpY-0005N4-1z; Fri, 24 Oct 2025 16:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vCOpV-0005LU-91
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 16:56:10 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vCOpL-00053E-4o
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 16:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1761339337; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=yl9QdN2x2OfkILOmRRrJUOvqG+TmkZlFlVGZNq759n4=;
 b=f/gcm34kt8ChW8QTqg9khUkP+Q8JqCmLEKkHzOjHNJmVDkpEGpjgxaYUT0KEnhx21bhTV3lh+q7wHnH3+HnVcpl2ecBp2eIWZAV0fzT9WjJ+2/KetVu/8U2WAO7MRn/1K2wK3Ije3sfvHaQh2z3qX7WiyAikPVYc3y3VdYeMwZk=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WqvCQcm_1761339332 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 25 Oct 2025 04:55:37 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, armbru@redhat.com, berrange@redhat.com
Subject: [PATCH v2] migration: Don't free the reason after calling
 migrate_add_blocker
Date: Sat, 25 Oct 2025 04:55:32 +0800
Message-Id: <20251024205532.19883-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Function migrate_add_blocker will free the reason and set it to NULL
if failure is returned.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/intc/arm_gicv3_kvm.c | 1 -
 target/i386/sev.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 66b0dddfd4..6f311e37ef 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -841,7 +841,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         error_setg(&kvm_nv_migration_blocker,
                    "Live migration disabled because KVM nested virt is enabled");
         if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
-            error_free(kvm_nv_migration_blocker);
             return;
         }
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1057b8ab2c..fd2dada013 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1661,7 +1661,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
     if (local_err) {
         error_report_err(local_err);
-        error_free(sev_mig_blocker);
         exit(1);
     }
 }
-- 


