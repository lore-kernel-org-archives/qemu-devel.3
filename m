Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B376C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVl-0001Jv-P9; Tue, 07 Jul 2026 18:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVk-0001IM-3T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVh-00048A-QG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cc891373e0so786935ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464204; x=1784069004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lBJ/QDAyECFxsw9vQUS2oMzovvSIiQI/RHhlqrlamsA=;
 b=vwnX51fQI4FMc+cwwoW5Z+IUChh1Umk91yLOTqz3qXmt2QDnH9Jj6H2w9RxLNileIK
 PYDiA8GHNxzpMJrLYOB5lbRLRcX/rzWswI9j0p5P+xVIqbqkotfXLtO4zUr2/whMwQda
 G5ijXTFhGFtj6rpwML1GRB0Zh/NjoMHAkSfHgSJU3WmFl0bDeZfBDVzMj+qNRxdHnUgg
 +nD0wt6Mj5HSK8n+GGUyOo4yvg2C3WCDHYlJ+WDcLEoHZHXvBK5EV6ApPadVPqdBu8zt
 PeuOh+Zcs8YHUA3sllQTV+aKv4aGgWs5MZ8kWkMnGtZvgiP9eSbio1nB/5/2xBwHV5lX
 VmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464204; x=1784069004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lBJ/QDAyECFxsw9vQUS2oMzovvSIiQI/RHhlqrlamsA=;
 b=aebC/Rs1fmzxNxj8eH4Bo1gYtAiWh4S2MUYMeL6T9WXqq6rhlC8BUKM01oeX5/7XfL
 +YoCUkC1aJ7CC5aRzXyUKjXHcv9hNwwSBE4763lvhZzYd++gjgcx8J7D8phQAJ4fp2hN
 PVr+JYfBlfNfnuYfBic5ACitIOmVT7qfgXFD+4t5gU8BZa4SHUFWbdDRBReVr2riGLhY
 5tXgN/K9VdcY+qk9OByu/d7q3ki6o1FuoYI1noheQo4l45BFacAZbsKCl5R82I02TmGk
 jeb244OtRat6pyQUq0yEInYcGHIIfKSzXUnJRCtax12+aByKB3H8dxpGSMdhA7zdm9Zv
 dNpA==
X-Gm-Message-State: AOJu0YzLgRUpLBOorHuOW3+OMXqRGRYlkBGmGaV/uCywKv5E5RRuZjJA
 fj3JoVzQM4o6I8xQnYO5IhTJWBQogVXeTaL5GYl3F1gmmxLvCTTTsETHR7LdMghS/uM=
X-Gm-Gg: AfdE7ck5zTg33CbPkuIWZYv8NwaLcBLk4CtWLnK3PDxdoBB4K9JQruIv9yCC+bF8j4g
 MaOe4K4dOSBHak3rTIsKzh63+dWRKKzXGiaC3aolKc/VDHGut7wQw60Z6YzfGk+4QEAhkcpET42
 ATh9BHWJhMS5bLeHiXCu5sKK3ZeYCsKlotW3MiIzvgmh0VfuyNY3kLJ5umrPOuy5WKMhXvDGd64
 QMO43Tn7aI1TZDWWi/7K0lPJYDfICKKYRtMoBmCmRazeY19rN3SFQICYaQeIBmzk3GchzcWblT8
 AT3+3MNjQxB/Il9Rc0536xGqXAU/QkVAYxwwc29PAQmBUw+VRd+lfOywrFuhKqW4Wj2zkjuokFE
 092TiMock5pyp/FyY1lKeb2sCbtlLMrmd+k9GjVoczAzGFhWlNzrcdTG5AeTWg3Ry0hTwGcq/jl
 /ip4FNiMr180+XAgG0IDzIhV8FYTNYJ8m5GfHf/UI=
X-Received: by 2002:a17:903:1a0f:b0:2c9:97a7:b1eb with SMTP id
 d9443c01a7336-2ccbf06aea0mr62459205ad.42.1783464204248; 
 Tue, 07 Jul 2026 15:43:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:23 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 07/25] target/arm/kvm: Create scratch Realm VM when requested
Date: Tue,  7 Jul 2026 16:42:48 -0600
Message-ID: <20260707224306.1202330-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 8
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c  | 8 ++++++++
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 4 +++-
 target/arm/kvm_arm.h  | 8 ++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 90c1d30ba24c..f763d5ed6199 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -99,3 +99,11 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
 
     cpu->kvm_rme = true;
 }
+
+int kvm_arm_rme_vm_type(void)
+{
+    if (rme_guest) {
+        return KVM_VM_TYPE_ARM_REALM;
+    }
+    return 0;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4ab6f08637d1..6d52f172c5df 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -129,3 +129,8 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+int kvm_arm_rme_vm_type(void)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4c212ed0c337..6aa1cd04e484 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,6 +108,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -117,8 +118,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+    vm_type = kvm_arm_rme_vm_type();
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 12ed1eee18b4..65ec1b970606 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -259,4 +259,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s);
  */
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
 
+/**
+ * kvm_arm_rme_vm_type
+ * @ms: the machine state
+ *
+ * Returns the Realm KVM VM type if the user requested a Realm, 0 otherwise.
+ */
+int kvm_arm_rme_vm_type(void);
+
 #endif
-- 
2.43.0


