Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A5BC54EDA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGev-0008Q1-34; Wed, 28 Aug 2024 07:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sjGes-0008Jj-FW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:16:15 -0400
Received: from ma-mailsvcp-mx-lapp01.apple.com ([17.32.222.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sjGeq-0001xt-Ud
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:16:14 -0400
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIX00VTCDYV8C20@ma-mailsvcp-mx-lapp01.apple.com> for
 qemu-devel@nongnu.org; Wed, 28 Aug 2024 04:16:10 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=20180706;
 bh=NuxdHQvEWMO186/Pq64WVK2Wqxs7tuae4uiyuSIdisA=;
 b=UpKNSyyrtrk23ca6JRQuMRPoB+CLZyo9X1Wz0KNgChX5UiCYLqYrkOiIN0W2LTV/rATp
 bhVHtBi2G3XsXD0aGYVv7aickUbaA4p3H3DQLktnPTngTAh8T3xG3uKD0Vz1kqwqhCte
 4XewRB2N6x/EfhLF8K+fGuNWvufoU7l3DApgta0THcCGVHvs36QBTIB9F2ag7629o6Ri
 HpFDpP1i+NqyY+mCFlk6RdX/8AqtuBu7jP5ZWCelydUKbdFgRX8V0qoSRYBHkg0SGINS
 RhZdLSh+ApPQTinfomzj2FwsPHSbeIhMGbNqwKksBdxYFIVEcn+3A511FfK08MfmmFNz 4g==
Received: from mr55p01nt-mmpp02.apple.com
 (mr55p01nt-mmpp02.apple.com [10.170.185.213])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIX00711DYWJJ10@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Wed, 28 Aug 2024 04:16:08 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp02.apple.com by
 mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SIX2GG00DAAEB00@mr55p01nt-mmpp02.apple.com>; Wed,
 28 Aug 2024 11:16:08 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 18a8a04ab20a1763aa377ff80017b310
X-Va-E-CD: 3b56e0df51ee4f416ea534a48614cf9f
X-Va-R-CD: b21774bb28acbe54f0c689c454c37b14
X-Va-ID: a9801331-97fb-493e-9c95-381a51a0bafe
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 18a8a04ab20a1763aa377ff80017b310
X-V-E-CD: 3b56e0df51ee4f416ea534a48614cf9f
X-V-R-CD: b21774bb28acbe54f0c689c454c37b14
X-V-ID: 7fa2e5de-6c92-4f7a-ab3b-490ee94ce2dc
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
Received: from Mac.apple.com ([17.11.139.69]) by mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SIX2GJ1IDYJB800@mr55p01nt-mmpp02.apple.com>; Wed,
 28 Aug 2024 11:16:08 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, agraf@csgraf.de,
 peter.maydell@linaro.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 danny_canter@apple.com
Subject: [PATCH v2 2/3] hvf: Split up hv_vm_create logic per arch
Date: Wed, 28 Aug 2024 04:15:51 -0700
Message-id: <20240828111552.93482-3-danny_canter@apple.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-reply-to: <20240828111552.93482-1-danny_canter@apple.com>
References: <20240828111552.93482-1-danny_canter@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Received-SPF: pass client-ip=17.32.222.22; envelope-from=danny_canter@apple.com;
 helo=ma-mailsvcp-mx-lapp01.apple.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is preliminary work to split up hv_vm_create
logic per platform so we can support creating VMs
with > 64GB of RAM on Apple Silicon machines. This
is done via ARM HVF's hv_vm_config_create() (and
other APIs that modify this config that will be
coming in future patches). This should have no
behavioral difference at all as hv_vm_config_create()
just assigns the same default values as if you just
passed NULL to the function.

Signed-off-by: Danny Canter <danny_canter@apple.com>
---
 accel/hvf/hvf-accel-ops.c | 6 +-----
 include/sysemu/hvf_int.h  | 1 +
 target/arm/hvf/hvf.c      | 9 +++++++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ac08cfb9f3..dbebf209f4 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -61,10 +61,6 @@
 
 HVFState *hvf_state;
 
-#ifdef __aarch64__
-#define HV_VM_DEFAULT NULL
-#endif
-
 /* Memory slots */
 
 hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
@@ -324,7 +320,7 @@ static int hvf_accel_init(MachineState *ms)
     hv_return_t ret;
     HVFState *s;
 
-    ret = hv_vm_create(HV_VM_DEFAULT);
+    ret = hvf_arch_vm_create(ms, 0);
     assert_hvf_ok(ret);
 
     s = g_new0(HVFState, 1);
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 5b28d17ba1..42ae18433f 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -65,6 +65,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 #define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 int hvf_vcpu_exec(CPUState *);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ace83671b5..19964d241e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -929,6 +929,15 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
 }
 
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
+{
+    hv_vm_config_t config = hv_vm_config_create();
+    hv_return_t ret = hv_vm_create(config);
+    os_release(config);
+
+    return ret;
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c9c64e2978..68dc5d9cf7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -223,6 +223,11 @@ int hvf_arch_init(void)
     return 0;
 }
 
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
+{
+    return hv_vm_create(HV_VM_DEFAULT);
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
-- 
2.39.5 (Apple Git-154)


