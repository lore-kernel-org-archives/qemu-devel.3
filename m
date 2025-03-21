Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37016C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdjl-0001iO-LX; Fri, 21 Mar 2025 10:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjO-0001TC-Rd
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjL-0006wC-MT
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nHcO0iQBZg3xP5D9ExG0a55ZvDcfJdZXcEyDfrBdDg=;
 b=ENVlwBNXwrm0r0UvxCmA+v5MAB2od+gRWPz1gDEEPn6t3ek9q+K5mhIVaTq0Tcv85wH2g/
 7Jvc/WNZm57df8oVySTRWz3lSciXkCkRPZhquNn46RX8OE7uXBymXUTHGFIR+DgsCyuQ+6
 w1Egd2JOpKAle+n5vCD2rBLghIlqZ9Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-GVeEakK6M8CBHPhBjdl5Yw-1; Fri,
 21 Mar 2025 10:52:11 -0400
X-MC-Unique: GVeEakK6M8CBHPhBjdl5Yw-1
X-Mimecast-MFC-AGG-ID: GVeEakK6M8CBHPhBjdl5Yw_1742568730
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BB25180882E; Fri, 21 Mar 2025 14:52:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB7BD19560AF; Fri, 21 Mar 2025 14:52:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D544921E669A; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/8] target/loongarch: Fix error handling of KVM feature checks
Date: Fri, 21 Mar 2025 15:51:55 +0100
Message-ID: <20250321145158.3896812-6-armbru@redhat.com>
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

For some paravirt KVM features, if user forces to enable it however
KVM does not support, qemu should fail to run and exit immediately,
rather than continue to run. Here set error message and return directly
in function kvm_arch_init_vcpu().

Fixes: 6edd2a9bec90 (target/loongarch/kvm: Implement LoongArch PMU extension)
Fixes: 936c3f4d7916 (target/loongarch: Use auto method with LSX feature)
Fixes: 5e360dabedb1 (target/loongarch: Use auto method with LASX feature)
Fixes: 620d9bd0022e (target/loongarch: Add paravirt ipi feature detection)
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250320032158.1762751-2-maobibo@loongson.cn>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/loongarch/kvm/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 28735c80be..7f63e7c8fe 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1081,7 +1081,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int ret;
     Error *local_err = NULL;
 
-    ret = 0;
     qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
 
     if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
@@ -1091,29 +1090,34 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
     if (ret < 0) {
         error_report_err(local_err);
+        return ret;
     }
 
-    return ret;
+    return 0;
 }
 
 static bool loongarch_get_lbt(Object *obj, Error **errp)
-- 
2.48.1


