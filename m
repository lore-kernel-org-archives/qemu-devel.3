Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3F5C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsedj-0005r6-5T; Thu, 13 Mar 2025 05:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsedf-0005qc-MD
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:14:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsedb-0000n7-Me
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:14:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOGrPodJnrL+UAA--.57439S3;
 Thu, 13 Mar 2025 17:13:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfOodJnGD1IAA--.8822S3;
 Thu, 13 Mar 2025 17:13:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] target/loongarch: Return directly when detect KVM
 disabled features
Date: Thu, 13 Mar 2025 17:13:48 +0800
Message-Id: <20250313091350.3770394-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250313091350.3770394-1-maobibo@loongson.cn>
References: <20250313091350.3770394-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfOodJnGD1IAA--.8822S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For some paravirt KVM features, if user forces to enable it however
KVM does not support, qemu should fail to run. Here set error message
and return directly in function kvm_arch_init_vcpu().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 28735c80be..b7f370ba97 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1091,21 +1091,25 @@ int kvm_arch_init_vcpu(CPUState *cs)
     ret = kvm_cpu_check_lsx(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_lasx(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_lbt(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_pmu(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
     ret = kvm_cpu_check_pv_features(cs, &local_err);
-- 
2.39.3


