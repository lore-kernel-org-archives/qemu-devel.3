Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F5FC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xz-0000Ja-4J; Fri, 28 Aug 2026 18:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xu-0000Gu-CU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xs-0005kT-K4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMUGfp3778632
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eXnvccp0DFb
 xwkO1Mw3GLTeuTcyRAoYMc66NG1wni7c=; b=Xs7RUfiNe0+r84SGCoRdkcNc9cq
 kpycBuTovwOHUsTGXvlsUf5RGPlYXGuuOJcz9qHLm1SJkI/GNrdUrKveeslcR7TY
 aNo3gkrn/EdgmEmUprEyueCoc/UZYAsSeVEMclIpRw37dUpf66R+fgMMCsLADYFg
 hUIDKvVzGEeWxNcw1m36IzlyLB2MV6+mtEd7l7UANZnGi+HWfR2/u/5LYzJRidF1
 weOXZrAmICR4eNxPtvzDJSHGYLN1Gn3rWTFn8CxVft7TcLhD7Cw1jlVp7biWtSQH
 FWmPvn8HaXWhiC4z3X0goyKuRyZffWvA4wDpRtplGOHqHoAbHBmBDoghFZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbj3er83e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso33159145ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957964; x=1788562764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eXnvccp0DFbxwkO1Mw3GLTeuTcyRAoYMc66NG1wni7c=;
 b=OhOWrPX7RwmlgPCP5Kno8/VoDxT15iyTkAwneouJCUHFN6fhNxQ6WF7qBDs3PBDqDQ
 qxlAAnKhsmje4Xhv5mn+MskjLdjW/4+4hEqiVB2sah6K/xyGC41qkKTENqROmhQWGru9
 ZSOgVGZ+NIolX0vJStVxTh9Oz/+ViIxHefTPE3NK5pzOEGlmHGJ3xJ5bLPKm6hA99B7l
 Iyq39CCwsfrH0Enwfyvta4dqElniMjWh5Uohz9wDGZA5WFBBSvUIoSH9J/lYepqlt3Y9
 rXe9J152pgpUvuelLYBPtnKFCMxbUDumnbAuUEvtf2ljmAwd8qInGWmcGEs3ihbo1+FU
 Lx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957964; x=1788562764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eXnvccp0DFbxwkO1Mw3GLTeuTcyRAoYMc66NG1wni7c=;
 b=BfSXGAbSfRvMDTfQmN1fHYeRIU2+DnoLpqnMzxpM4YGCPyFgAqh6SZYiKmbAv3lhf5
 W06GUuKIjfDJ3WhqWx7takfR2mfSQEVGc6sjSol2r6qpo+Tvzj0pxJu330C3aSEXXxaf
 76fpBHvnZnaXGvep57SsAy0Gn9zXD4iPBIVejgSS8LEke1xcodAbEDqZ2GS79QjLCnXi
 DR2XW5cpDOS8E0V3thzUIIXVWM87ihHNL+MwK3Di4kwvzRcIRC59l0tPiNpINM4/dT7C
 vMycafXmSKIa2oKGwfZ6SkdwTGhf06Qbnm3YzCvYt6mAXqkRIpWA/Xo1iI4FN5FFzp3Y
 cjCg==
X-Gm-Message-State: AFuF++kLNncc8lwO70eLXn5YdDS/ALmBQ/VucSCYog1JekUyV3kMd7cX
 zTsb1qMZSsLTvF83HVPd1v+EqlD0F85IdAnAzoj+aYhjUJAkNK8jUemsBbKbZiWxdFFXfVImY+o
 uHeeHQlHQc4s2RKOeH/ggTaHVkYnXS2MWfGcqujfR/SdWQOpt8cHnSIOnFAXKXjPW9A==
X-Gm-Gg: AYBFou3WXzsl2U28S3lANLr/FCI3RBVK/4D7eNr5Fn1TFDESFFk1rbWmsgYIRukTbDn
 Y06/gEG1MghQByC84kywTK9Y7iEptdeHq89qwaeoJTkZXqP957VVIUKIZ5K4XXt/Q1QH+Ge57Ls
 kkGUGvJ4SZFqF89AZAb9Stv/Fgb0KosYaACmbuSRIsuk11laiIgtZyxAoTW02iOI+9tYBOsZXzy
 K7v0cgMlW7XVAaHzkN6jS/fDbmnH0m+z09CPytFYuGu3TnJD1fYbFnZn6O5icUISYz4dM7/ribz
 zc/kUs20HZfDPk7bx3Z5icBokKBCon4ylewQ+9AWhVczuJDTQQm3XzNrWKKgA/836ctSLDRFjcP
 z4R0b5oExwO+O2cD9aJcwanrzXju9WU/uBwK8PXswYnSF8lLgySkzrGQCBgs=
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-396d0e25905mr19253397a91.2.1787957964365; 
 Fri, 28 Aug 2026 15:59:24 -0700 (PDT)
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-396d0e25905mr19253352a91.2.1787957963858; 
 Fri, 28 Aug 2026 15:59:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/47] hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
Date: Fri, 28 Aug 2026 22:58:29 +0000
Message-ID: <20260828225901.367438-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GhTta89htJ7i_EckSojK5AMOVeoBy2Uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1TnKtPNx5gDJ
 e/AuLP6CtvfD+N32p0YYCkZpf9uUvEZBswxcwYonEBD/EOP6T5gA7hPJzmtjh0NYOyb5gMAKpO8
 cZ33KGvpu/+KzudAvBKOMt7AVZ5Yw4WGqE7rJbYntOE+o8Ru262IjgNDy6tQnEanSSoDCaGLNr6
 pMjBqUtSeLH5cec5Q1mTI1TSA2Y099fPaP9GhIOc1G8DZzwv5mX0oFzQWvUFQKFnF07OyP/2M/y
 HIwAwvhYjsoSXMv6QNWP+iqFQ3bf83/H9qV/7RuKLtRXlTfjSBXaQSEdZKrgyYRxp6VBJKCfsd4
 4cm+lsASPb07gZp+QItRxXxVnk9dxtRIyQoAY8ibCtDvCNq0WDV0LlSWAPCX6w3FZ8O7gPNrIse
 0Qs23ayMiHIKDVr/lFGnxtnvncdQCk56ed5eED+1QVUgb3Qsxg0ro9Asej51VwBF589OiKMgn8P
 txU+j1iyytSNYhHdoPQ==
X-Authority-Analysis: v=2.4 cv=QLVYgALL c=1 sm=1 tr=0 ts=6a9212cd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=SalYC_UygP5POjnEfZgA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: GhTta89htJ7i_EckSojK5AMOVeoBy2Uc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX57drhjS5CRaV
 OSFOfAWbpL9ixct31xkbN6Mpny2b3WA231600A86CjDawrkRUecoEtMTXDHmqqqMiNy0igGt/K9
 6uzWSyPpQ/a8f+nCC372YKQZSQCS+KE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

We don't need those types anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/null-machine.c        | 2 --
 hw/nitro/machine.c            | 5 -----
 hw/remote/machine.c           | 1 -
 include/hw/arm/machines-qom.h | 6 ------
 target-info-qom.c             | 8 --------
 target/arm/machine.c          | 5 -----
 6 files changed, 27 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f132a7b89b4..c1ecf3214fd 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -58,8 +58,6 @@ static void machine_none_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_AARCH64_MACHINE },
-                               { TYPE_TARGET_ARM_MACHINE },
                                { TYPE_TARGET_RISCV32_MACHINE },
                                { TYPE_TARGET_RISCV64_MACHINE },
                                { })
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 8849959359c..bb8878299bc 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -262,11 +262,6 @@ static const TypeInfo nitro_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(NitroMachineState),
     .class_init = nitro_machine_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        /* x86_64 and aarch64 only */
-        { TYPE_TARGET_AARCH64_MACHINE },
-        { }
-    },
 };
 
 static void nitro_machine_register(void)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index 88d38b75d52..6580e0d9683 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -149,7 +149,6 @@ static const TypeInfo remote_machine = {
     .class_init = remote_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
-        { TYPE_TARGET_AARCH64_MACHINE },
         { }
     }
 };
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 3ed39384e59..81ffa434303 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -11,12 +11,6 @@
 
 #include "hw/core/boards.h"
 
-#define TYPE_TARGET_ARM_MACHINE \
-        "target-info-arm-machine"
-
-#define TYPE_TARGET_AARCH64_MACHINE \
-        "target-info-aarch64-machine"
-
 /*
  * A machine filtered with arm_machine_interfaces[] or
  * arm_aarch64_machine_interfaces[] will be available
diff --git a/target-info-qom.c b/target-info-qom.c
index 7958a5cc685..eb9491338ca 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -16,14 +16,6 @@
 #include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
-    {
-        .name           = TYPE_TARGET_ARM_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_AARCH64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
     {
         .name           = TYPE_TARGET_RISCV32_MACHINE,
         .parent         = TYPE_INTERFACE,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 89127e5d83c..42a1427fa16 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1348,18 +1348,13 @@ const VMStateDescription vmstate_arm_cpu = {
 };
 
 const InterfaceInfo arm_machine_interfaces[] = {
-    { TYPE_TARGET_ARM_MACHINE },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo arm_aarch64_machine_interfaces[] = {
-    { TYPE_TARGET_ARM_MACHINE },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo aarch64_machine_interfaces[] = {
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
-- 
2.43.0


