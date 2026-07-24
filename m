Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E48C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UQ-0004jX-DK; Thu, 23 Jul 2026 20:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UL-0004hC-O3
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UI-0005v1-RP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeMbV948314
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1YCSjMl6uZ4
 i8a2ExPf6qEM53DxRL0Xw2CieCgqODZg=; b=b5vfRElLogcKldVXTD8ldfEuV3V
 Z1fQp5NGpOF6OVlP9e3p53qdFkJET5PhYq7SukaPk1/6EJCb0EwebCyZNIvwzNvm
 h78pbAUl/39FfE1mCK+rPTZmtk3BU29NV5R4YXfEyAIJZU6WGstnX4U57eiBftsA
 X9DgxnowxhRBDbt/JleiZU/KwHgD+0A2Vx6mTbHzx+IkfgYtSlcOriPBOcgtyZxC
 6foNw99PhzdlZOLnbDnV+EzeMJb09edtIl9d7SKP/mxJ8emt/skwoeXCwfrDqDa5
 WvKox0qhkG/5eeWxDOrEC66M18sODemJrxT3Qx/PAltygOmdBMZ/USuRlmw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0kv2f1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so1765361a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851801; x=1785456601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YCSjMl6uZ4i8a2ExPf6qEM53DxRL0Xw2CieCgqODZg=;
 b=A4/IagHj2zuAVddMud92+2ZoYfppSSOcybz9x4xaZSUOQj7VtJ3lWl/gbXZIjGpy5A
 q7AccNZEm04s29Yh5bpAx3AfsyUt57NrXZtTFqTgyyD2SWLzt9Qa9MRO1Xa+E1TfqlnQ
 HdIQHOEeETA17amlT5q0jywL7aF1z5obvIe+YTwZKtzp5Le5ksD4rG+KWYXZCrmO0rR0
 QDPOl6f+Mgge4groxhmrxnQ6CsNAKnw3AO9fYhi2DjNEdSmk4eDKeIYCTcChZh4iPf9P
 qb7jGqrOt4RbNarzu8VOiBAtNQPbnuO4bkFOrrBg8xoEJHoxmA6AyaMB1z0NJXenjv/Y
 UMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851801; x=1785456601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YCSjMl6uZ4i8a2ExPf6qEM53DxRL0Xw2CieCgqODZg=;
 b=aumvQopwGew52uQDeAlIHybt6nxyJbS/NuifbjshuCs4QgojHc/tV9i936y8nGLC94
 FfNAxIDsr99Cknh/kAOmGe926Q9IhHBP2/fcShwWzvtejwyw2fr6UxthnpSB7mlp9wRl
 ofAcoqpDhejb9IkFU90Wafg5LAN1dXVGtcNX8DRheTtGxx94KEj9ennHZ97W86o43/2z
 tIpxP4FwCctlYYYbcBNljku6qUQl6KwA04eTKj+Nao91BA4l+4YZdPasmHN+HSudOe97
 CZJmI4W2Ar0gy+p7Rx3S7qAQ0mVNAfb+NVQVb4c9O/prRmuR0E9QbbmloJlqdgC/4MDL
 w9WQ==
X-Gm-Message-State: AOJu0Yw9DTlDnzWSsDnZHtZwULx9Ds4wPKHYdCWrKt7w4ome5RwpAIDA
 WFHpIYaPNFMwzA8uEEkP4MJPtWhYKtrO8I2YQ7kcYG3cY1Ntptvc9M9w0n10wQY4gxHxtg1iVRF
 /2JZ3R8X4/wCkRISzqcyvg2thmCdJCGPZ2zpLeiqjylIH5PjJCeUnCXTCyzACaNYlag==
X-Gm-Gg: AR+sD11Bp9hRAA6XsoHM1Y73ihwEtg/JE64FPLj38r+uFgMuNlbTj+XLd0feca66Fql
 uSClHwDqgfJYbx/t9rUnOxHj6g+0LDQLX+nlCOJhbxWJxANJwwvd0DhZ7gyvaYp4LgpXiRC49j+
 +SvAotFJlt4QF6siF7wF3Ueeza1yunOafG3B2CG7rTOfPRPV0uznRpRlG+8u1bhtmEQOMN0I2Of
 MeMqUHXzwYOryT567uLyK3x/j113w1z2KffaX2wUe9bKcCuEnj6Gh+IKl9y92SyNn+yK3+NVfwM
 zPnqFtu0Dom7dqyM2pfTYUbQtsreiCAFFvSa282iHeu0g79hhE91Y4PHGRQN2HLPUWiqnESj9JS
 5UJ7opGS4JRFDM55vbfEo/WO8y5TqcrCuLM60FxXejUJneSP5+fPInh8s+lKW4Fl5lODfX4s=
X-Received: by 2002:a05:6a20:9404:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3c44afcdf7bmr5977692637.18.1784851800865; 
 Thu, 23 Jul 2026 17:10:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:9404:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3c44afcdf7bmr5977667637.18.1784851800479; 
 Thu, 23 Jul 2026 17:10:00 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:09:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 04/27] hw/riscv: implement TYPE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:24 +0000
Message-ID: <20260724000948.234657-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XAaV4aWoPAGQ0PjUv6QiWRfOSg-flmGe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXyMD97nhTbJqY
 bxm1x5yhpU9/b9Hudj/xVTk7RWGGgmPvxXIGZNAJ0VYdMr+MjErJLM7luwgMxV4qYByD0ysnKn8
 OGavtA5nFIqGxr/9BvdDoxSb1Opj9d8=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a62ad59 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=N9kjl_DyerKUdbQnvnIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: XAaV4aWoPAGQ0PjUv6QiWRfOSg-flmGe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX788fJti/w3ZR
 bQm8Rzt86lGxuY9l8BeSStIpQ7XbVvdkeYr2PBsYxlSOEjD5uCpP0CnIGlxBn4uSiP9TcWMVRSU
 aKjtRtmCVA7utkQDgfLdkNfGGjIjjgEJHoyF1QvlTARFZqQ6IF9wI4cZHQig/bjc/9JZqKzTIBB
 cU5xGjzrGuoW/rhH7Wd5Y6WBLVh1Yebr+3ZuxM8vcZQ1aG2c60YK9eJo4OeVEePGZHt8+RYbyT6
 K/bZnp4MxdgtqMzABtnNobFlwTz5O1HtJaaEMw+T/OwCP4diMd+JnWbAMnHXwMDNvF25YjIgsMB
 9DWDTThddlROYzAjRykcnzG67XjEEtI0c/KVRNA5pcKIy8RH0NxzpsJi90CW7VHfMbAEinvnvVV
 Mtize0N6trqRDvU/LsCM+iimzX+ZM2w0QsJb2kmm9yLGrFaIQTvi8WHTTq333vAUSpZqGrFJIke
 OeUYjHfduddoDjoO+Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

For now, we still keep existing TYPE_TARGET_.*_MACHINE mechanic to not
break existing binaries. As a result, we add TYPE_TARGET_SPECIFIC to
list of interfaces *_machine_interfaces.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/boston-aia.c           | 1 +
 hw/riscv/k230.c                 | 1 +
 hw/riscv/microblaze-v-generic.c | 1 +
 hw/riscv/microchip_pfsoc.c      | 1 +
 hw/riscv/opentitan.c            | 1 +
 hw/riscv/shakti_c.c             | 1 +
 hw/riscv/sifive_e.c             | 1 +
 hw/riscv/sifive_u.c             | 1 +
 hw/riscv/spike.c                | 1 +
 hw/riscv/tt_atlantis.c          | 1 +
 hw/riscv/xiangshan_kmh.c        | 1 +
 include/hw/riscv/machines-qom.h | 2 ++
 target/riscv/machine.c          | 3 +++
 13 files changed, 16 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 965d0f5699e..42b16945c12 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -465,6 +465,7 @@ static void boston_mach_init(MachineState *machine)
 
 static void boston_mach_class_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_riscv64;
     mc->desc = "MIPS Boston-aia";
     mc->init = boston_mach_init;
     mc->block_default_type = IF_IDE;
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190cd..0eb1bede222 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -504,6 +504,7 @@ static void k230_machine_instance_init(Object *obj)
 
 static void k230_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_riscv64;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V Board compatible with Kendryte K230 SDK";
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d33ac39a68c..7cc24ed189f 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -179,6 +179,7 @@ static void mb_v_generic_init(MachineState *machine)
 
 static void mb_v_generic_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_riscv;
     mc->desc = "AMD Microblaze-V generic platform";
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4017129c830..520d1fd4d11 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -722,6 +722,7 @@ static void microchip_icicle_kit_machine_instance_init(Object *obj)
 static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
                                                     const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_riscv64;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Microchip PolarFire SoC Icicle Kit";
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 5b2f33d5aca..5c50b1c423d 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -117,6 +117,7 @@ static void opentitan_machine_init(MachineState *machine)
 
 static void opentitan_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_riscv32;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V Board compatible with OpenTitan";
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 835b1f879b7..7556fd8c854 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -78,6 +78,7 @@ static void shakti_c_machine_instance_init(Object *obj)
 
 static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(klass)->is_available = target_riscv64;
     MachineClass *mc = MACHINE_CLASS(klass);
     static const char * const valid_cpu_types[] = {
         RISCV_CPU_TYPE_NAME("shakti-c"),
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 71925583bd9..657f6ecad25 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -146,6 +146,7 @@ static void sifive_e_machine_instance_init(Object *obj)
 
 static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_riscv;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 99423ef472d..33f1af2cdf1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -653,6 +653,7 @@ static void sifive_u_machine_instance_init(Object *obj)
 
 static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_riscv;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9fde0faf39d..1f706f4dcc1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -262,6 +262,7 @@ static void spike_machine_instance_init(Object *obj)
 
 static void spike_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_riscv;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V Spike board";
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d808bcc11c3..ceaa88d5238 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -590,6 +590,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_riscv64;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Tenstorrent Atlantis RISC-V SoC (Experimental)";
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 384624d69ad..d8ee1dfa15e 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -196,6 +196,7 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
 
 static void xiangshan_kmh_machine_class_init(ObjectClass *klass, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(klass)->is_available = target_riscv64;
     MachineClass *mc = MACHINE_CLASS(klass);
     static const char *const valid_cpu_types[] = {
         TYPE_RISCV_CPU_XIANGSHAN_KMH,
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index ee346227bb2..5a5b5e05f58 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -10,6 +10,8 @@
 #define HW_RISCV_MACHINES_QOM_H
 
 #include "hw/core/boards.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 
 #define TYPE_TARGET_RISCV32_MACHINE \
         "target-info-riscv32-machine"
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0ab613a2980..507e862f061 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info-qom.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "migration/cpu.h"
@@ -537,11 +538,13 @@ const VMStateDescription vmstate_riscv_cpu = {
 };
 
 const InterfaceInfo riscv32_machine_interfaces[] = {
+    { TYPE_TARGET_SPECIFIC },
     { TYPE_TARGET_RISCV32_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv64_machine_interfaces[] = {
+    { TYPE_TARGET_SPECIFIC },
     { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
-- 
2.43.0


