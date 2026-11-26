Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70868606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d2pMyUHQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWYyp-0004kT-2n; Thu, 26 Nov 2026 07:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWYym-0004jO-54
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWYyk-0006xV-G8
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795697610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ekUT7FxHyxXeUWC83sXPRsH09Bs0SkDKb39ji/f285g=;
 b=d2pMyUHQcy+XVlR0Bmq88mKIMsTqXE7u+XAcUiJOVzKWf2B/CTmnfl4k4b6ihOJaL4OTU7
 YptEQgmBa5C0oNWGZ6Q1G/OBZ82eMq17ghHB6Q6BBGIVvqVvu4P2Na2rK2w1oGAkmeqQXU
 Jk9zJEOt3ow2FA45dzy2lUFmHWv4UEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-TOO43fMXNi64Ju7XJHNogA-1; Thu,
 26 Nov 2026 12:53:28 +0000
X-MC-Unique: TOO43fMXNi64Ju7XJHNogA-1
X-Mimecast-MFC-AGG-ID: TOO43fMXNi64Ju7XJHNogA_1795697607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D2451800759
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 12:53:27 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFE66180054C
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 12:53:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386/cpu: Add back x-hv-synic-kvm-only property
Date: Thu, 26 Nov 2026 13:53:25 +0100
Message-ID: <20261126125325.2223204-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Partially revert commit 804cca26dc9 ("target/i386/kvm: Remove
X86CPU::hyperv_synic_kvm_only field").  The option was removed because it
was only enabled by old machine types, but it can be useful for debugging
as well.

Do not bring back usage of KVM_CAP_HYPERV_SYNIC, which only differs from
KVM_CAP_HYPERV_SYNIC2 in that the latter signals that some bugs were
fixed in KVM; and keep the hv-vpindex requirement even with the option
on, since in-kernel SynIC wants the feature to be active anyway.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  1 +
 target/i386/cpu.c     |  2 ++
 target/i386/kvm/kvm.c | 15 +++++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e90371b..0ceb4be7413 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2373,6 +2373,7 @@ struct ArchCPU {
 
     uint32_t hyperv_spinlock_attempts;
     char *hyperv_vendor;
+    bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 40974bee26c..14d7b86ad0f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10900,6 +10900,8 @@ static const Property x86_cpu_properties[] = {
      * to the specific Windows version being used."
      */
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
+    DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
+                     false),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
     DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76528f1123f..bc5a39cecf4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1607,7 +1607,8 @@ static int hyperv_fill_cpuids(CPUState *cs,
     c->eax |= HV_HYPERCALL_AVAILABLE;
 
     /* SynIC and Vmbus devices require messages/signals hypercalls */
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
+        !cpu->hyperv_synic_kvm_only) {
         c->ebx |= HV_POST_MESSAGES | HV_SIGNAL_EVENTS;
     }
 
@@ -1757,11 +1758,13 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        ret = hyperv_enable_synic(cpu);
-        if (ret < 0) {
-            error_report("failed to create HyperV SynIC: %s",
-                         strerror(-ret));
-            return ret;
+        if (!cpu->hyperv_synic_kvm_only) {
+            ret = hyperv_enable_synic(cpu);
+            if (ret < 0) {
+                error_report("failed to create HyperV SynIC: %s",
+                             strerror(-ret));
+                return ret;
+            }
         }
     }
 
-- 
2.56.1


