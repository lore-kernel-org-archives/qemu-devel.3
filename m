Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448DEC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbY-0001TM-0g; Wed, 12 Aug 2026 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCa5-0000E9-HE; Wed, 12 Aug 2026 13:17:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCa1-0000uQ-OE; Wed, 12 Aug 2026 13:17:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1fc43994436; Wed, 12 Aug 2026 17:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=77oxwcW3642R5fK9q
 LD3J5GKO6rp/5jW+H4nF6ogR04=; b=W+IugUqkhUMZD1kaWTnu1TogbWippMPZw
 Y5c/+aFRkZTE3tu+iQRes635QNF6xyShN4X6LmnsCqt22Y/T/v1uE2m3LZKS1+42
 HNgCQrg1GvLqlyolpeMq9fw1dyJ6PQH1Non53Pw0plqBo3WxP7cPxEuemifClOJM
 cSnl8yC+j8S8ewsSMHVAgwRlHkrujb+bSkyp9d7nQQiqfEsM6aDHJJ6A1F39JjCp
 iyloNGaEa6kPuJnxCpZ6kDL1q0Dt84zRKZ7rSZyfxND/WVkv+uYiyhhEsiaS1eVA
 8D2PUhRpr5r3bQyTn4ivDyF2Nh4DzWJy5lhC6nTmTbyTkecYpKXig==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32vpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBRI2017606;
 Wed, 12 Aug 2026 17:17:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h72na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHK8Z30933628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E066F5805A;
 Wed, 12 Aug 2026 17:17:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 593645805E;
 Wed, 12 Aug 2026 17:17:20 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:20 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 14/15] hw: add compat machines for 11.2
Date: Wed, 12 Aug 2026 13:17:06 -0400
Message-ID: <20260812171707.1605637-15-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7caaa2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=0e9nVU_5ajEX5vtfCxIA:9
X-Proofpoint-GUID: A3CiYVsRaakz2o86MpA-1itfmz6H53Js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX2JZ/OBSd31oi
 JVc3B4HyeSf8ugSWquLUHOKe3AT33jdno776EgqepLAWSxklvIjuwjWG9sJZZUIa2lKD5U6NL5h
 bqocrizorLXbGDDgEriHMz9zw0NLfZ0meZBW+NRD+S6P6Php/1iLHcF3ta/ane5+/08Z0Ktk7Vo
 i8rT7+e4GR5qjJLMHxA6RsDk0rCg58YBx5/Lw5CsXyuB5iJNb8+zzpT26l1KmdDqMlxL7pEsUpW
 +Ky/RKgkG3no1Twas0GtV8ISuvqs90D0AGIUi5KnTump7XHA1G1x+F9giDvSXSJfRrL2WINVCtr
 5S0j2iKRRFVSPp6BTEYTNUmyWPoVsyv4QNuW3+YWIFOXCA1UAYt7mVX9JtVvT9DjZt82WNyNkea
 ZRoNEf/tZAegnuzqDe8fLwOTWSWta7tU4EKpgx5cTxZdB7gki2DzLAtTu986PCMphUKJDePs+qX
 tgzsz7STZ/xKjZW21sg==
X-Proofpoint-ORIG-GUID: A3CiYVsRaakz2o86MpA-1itfmz6H53Js
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXw5oAmN++dCyw
 JVqJqtsW2DqnaX9LN5FDYaFNlCh14iI+gx4YihxL44G6XU3OQ09oPGdcsLQCfXAXtX9vyXrrdes
 0rABW0OcZk7LhiRanDFzOzFlAg2JvS0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Add 11.2 machine types for arm/i440fx/loongarch/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Link: https://lore.kernel.org/qemu-devel/20260723163806.368127-1-cohuck@redhat.com
[farman@linux.ibm.com: fixup hw/core/machine.c hunk]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/loongarch/virt.c        | 11 +++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/core/boards.h   |  3 +++
 include/hw/i386/pc.h       |  3 +++
 11 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 219597cabd..e7a56e37f7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4441,10 +4441,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
+
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    virt_machine_11_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE(11, 1)
 
 static void virt_machine_11_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 73b4d82b4a..3b15645304 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,9 @@
 #include "qemu/audio.h"
 #include "hw/arm/smmuv3.h"
 
+GlobalProperty hw_compat_11_1[] = {};
+const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
+
 GlobalProperty hw_compat_11_0[] = {
     { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
     { "chardev-vc", "encoding", "cp437" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e..e9e4fc262b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_1[] = {};
+const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
+
 GlobalProperty pc_compat_11_0[] = {};
 const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb16..223a19cc4b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_11_1_options(MachineClass *m)
+static void pc_i440fx_machine_11_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
+
+static void pc_i440fx_machine_11_1_options(MachineClass *m)
+{
+    pc_i440fx_machine_11_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
+}
+
+DEFINE_I440FX_MACHINE(11, 1);
 
 static void pc_i440fx_machine_11_0_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c1e4eff5f..94cd71124b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -383,12 +383,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_11_1_options(MachineClass *m)
+static void pc_q35_machine_11_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
+DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
+
+static void pc_q35_machine_11_1_options(MachineClass *m)
+{
+    pc_q35_machine_11_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
+}
+
+DEFINE_Q35_MACHINE(11, 1);
 
 static void pc_q35_machine_11_0_options(MachineClass *m)
 {
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6693dea647..9cc79929a8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1465,7 +1465,6 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "loongarch.ram";
     mc->desc = "QEMU LoongArch Virtual Machine";
     mc->max_cpus = LOONGARCH_MAX_CPUS;
-    mc->is_default = 1;
     mc->default_kernel_irqchip_split = false;
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
@@ -1546,6 +1545,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
             mc->alias = "virt"; \
+            mc->is_default = true; \
         } \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
@@ -1600,7 +1600,14 @@ static void machvirt_machine_init(void)
 
 type_init(machvirt_machine_init);
 
+static void virt_machine_11_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
+
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    virt_machine_11_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE(11, 1)
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 51158ce1c0..274970978f 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_11_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
+
 static void virt_machine_11_1_options(MachineClass *mc)
 {
+    virt_machine_11_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE(11, 1)
 
 static void virt_machine_11_0_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e9..7e284edd7d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4763,15 +4763,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-11.2
+ */
+static void spapr_machine_11_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(11, 2);
+
 /*
  * pseries-11.1
  */
 static void spapr_machine_11_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_11_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
+DEFINE_SPAPR_MACHINE(11, 1);
 
 /*
  * pseries-11.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa4955..55131c1a44 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -925,14 +925,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_11_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_11_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(11, 2);
+
 static void ccw_machine_11_1_instance_options(MachineState *machine)
 {
+    ccw_machine_11_2_instance_options(machine);
 }
 
 static void ccw_machine_11_1_class_options(MachineClass *mc)
 {
+    ccw_machine_11_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
+DEFINE_CCW_MACHINE(11, 1);
 
 static void ccw_machine_11_0_instance_options(MachineState *machine)
 {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 29c68931d8..a436d48c8e 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
     }
 }
 
+extern GlobalProperty hw_compat_11_1[];
+extern const size_t hw_compat_11_1_len;
+
 extern GlobalProperty hw_compat_11_0[];
 extern const size_t hw_compat_11_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed57..ac03da97b6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -209,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_1[];
+extern const size_t pc_compat_11_1_len;
+
 extern GlobalProperty pc_compat_11_0[];
 extern const size_t pc_compat_11_0_len;
 
-- 
2.55.0


