Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07819606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h0IpkZm3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmRy-00018o-4T; Fri, 30 Oct 2026 09:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmRv-00012W-Or
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmRs-0005Pd-Va
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793366112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnbgHXpVmzu9H9r8MAAWf/5moNjJNccjfQF3zoxtSPw=;
 b=h0IpkZm3PD3xf+/W2wbRHePTB46seQz6p7k7f3/9G9vlxW6yq12NZ2ez7DPqks1A80co1K
 hCUXcJBzsjnLWVIHZp2wtVgTN0/Li/eSLnfz6C83RBJzXUhUpunK+sZes0EMR+OhpALrwg
 c6nM6QuxLKCapfexGL4MzfgoPjFAqBo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-lkQVPcfvPki9EGwF7_1d5g-1; Fri,
 30 Oct 2026 09:15:06 -0400
X-MC-Unique: lkQVPcfvPki9EGwF7_1d5g-1
X-Mimecast-MFC-AGG-ID: lkQVPcfvPki9EGwF7_1d5g_1793366103
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77FD21955F26; Fri, 30 Oct 2026 13:15:03 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0C121956088; Fri, 30 Oct 2026 13:14:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v4 for-11.2 09/10] target/arm: Directly store cpu probe
 failure error
Date: Fri, 30 Oct 2026 14:13:17 +0100
Message-ID: <20261030131406.461599-10-eric.auger@redhat.com>
In-Reply-To: <20261030131406.461599-1-eric.auger@redhat.com>
References: <20261030131406.461599-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In case *_arm_host_cpu_features() fails, we currently
record that state in cpu->host_cpu_probe_failed to later
report the error on realize().

Replace the boolean by an error handle to allow
more relevant error reports.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  5 +++--
 target/arm/cpu.c           | 10 ++++++++--
 target/arm/hvf/hvf.c       |  3 ++-
 target/arm/kvm.c           |  3 ++-
 target/arm/whpx/whpx-all.c |  3 ++-
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5c5f551dac..dae79539b5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1075,10 +1075,11 @@ struct ArchCPU {
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
-    /* True if we tried kvm_arm_host_cpu_features() during CPU instance_init
+    /*
+     * Set if we tried *_set_cpu_features_from_host() during CPU instance_init
      * and the probe failed (so we need to report the error in realize)
      */
-    bool host_cpu_probe_failed;
+    Error *host_cpu_probe_err;
 
     /* QOM property to indicate we should use the back-compat CNTFRQ default */
     bool backcompat_cntfrq;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index aba45b66f8..a9fe92affd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1736,6 +1736,10 @@ static void arm_cpu_finalizefn(Object *obj)
 
     g_hash_table_destroy(cpu->cp_regs);
 
+    if (cpu->host_cpu_probe_err) {
+        error_free(cpu->host_cpu_probe_err);
+    }
+
     QLIST_FOREACH_SAFE(hook, &cpu->pre_el_change_hooks, node, next) {
         QLIST_REMOVE(hook, node);
         g_free(hook);
@@ -1838,12 +1842,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * then it's possible that might have failed in the initfn, but
      * this is the first point where we can report it.
      */
-    if (cpu->host_cpu_probe_failed) {
+    if (cpu->host_cpu_probe_err) {
         if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
             error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
+            error_free(cpu->host_cpu_probe_err);
         } else {
-            error_setg(errp, "Failed to retrieve host CPU features");
+            error_propagate(errp, cpu->host_cpu_probe_err);
         }
+        cpu->host_cpu_probe_err = NULL;
         return;
     }
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4b947e9ba5..2f2a46644d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1287,7 +1287,8 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
              * We can't report this error yet, so flag that we need to
              * in arm_cpu_realizefn().
              */
-            cpu->host_cpu_probe_failed = true;
+            error_setg(&cpu->host_cpu_probe_err,
+                       "failed to retrieve host CPU features");
             return;
         }
     }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4b20c5dc2..f9c7577460 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -538,7 +538,8 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
          * We can't report this error yet, so flag that we need to
          * in arm_cpu_realizefn().
          */
-        cpu->host_cpu_probe_failed = true;
+        error_setg(&cpu->host_cpu_probe_err,
+                   "failed to retrieve host CPU features");
         return;
     }
 
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 024d18df04..ded42c980b 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -767,7 +767,8 @@ void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu)
              * We can't report this error yet, so flag that we need to
              * in arm_cpu_realizefn().
              */
-            cpu->host_cpu_probe_failed = true;
+            error_setg(&cpu->host_cpu_probe_err,
+                      "failed to retrieve host CPU features");
             return;
         }
     }
-- 
2.53.0


