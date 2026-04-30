Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34294CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA8-0002ud-8Q; Thu, 30 Apr 2026 16:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYA1-0002nB-FW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9x-0000u5-Dt
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UKIDvp1854109
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kdYb4dp22kf
 FuJHASL+X2gyJ+4ROfhuXXuPO3RoA9Zc=; b=FmsCf6ixyVtWfqLjCPR+oGwIVkv
 dhb4fFgmacULvCKbhofb04OtuRZ+UXXKUUP1+Qb6iNawwTdL8HYZG9t8vHbIg0nq
 3SId9gtJ/3AFwXfb8xw0Oh0FD7hZcbzYM4+rd9yJlIXSgyTZJL0jeD5yygmYB4uY
 gb8YJl3batf9a4fKKy4P+FbRUBi+MLAttmnHQfBjw/1e8mBODtW0DdqMvtsYjLwa
 w14cGtEKSzj7C2YnHdz+ygFmZl3nGEjXCndchVsAOcRBx2HR7Z8SYnerBKwrRZyv
 ojXwNJtYfwWND90jrhPJ0SNeAopSKeIqZwXG4Pa0XKRtT1hdiXG15AfcU3Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dve0g01ww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so4724770eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581535; x=1778186335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdYb4dp22kfFuJHASL+X2gyJ+4ROfhuXXuPO3RoA9Zc=;
 b=Hd/6cy6yMyDeBpWhjLVZb9RUUuwgYgIy5e2nMmGAfMVMRv8NeDjn1ceH5x/Y4C2js9
 bWzjDRy5AApPnHV6OAZRCiq3WA3NXkiEma0I2fUbLrkktQ3ua0kCXmT84fk3WG1Cz9th
 /yY4lrr36kYANdiKTX8fXu2gGVX6zGKs+JQHtwwS1ymBHqPYj4pTLTAkijcR+WN+EiYK
 QWvybjWbuNRr9qQ8Q+6zZ/FueG8NrStaK9Knc6o9AOU2m6uj2m7KRG6sMsT8pyGUOvuO
 0479LcNuKI91Ta3WTDGicCDcYtOLFUXPfvquD82B39vGz9VVsimOE6a/enAcfs7M0fGz
 1D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581535; x=1778186335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdYb4dp22kfFuJHASL+X2gyJ+4ROfhuXXuPO3RoA9Zc=;
 b=hncGwvHylRbBNo4qahTilBryuqjDxIqptI0uReZTyNnuKy9D/OsrrjgeL5oGs8d+24
 1eqfHC3xnGHEu0e+5TPbvPOU+u17aMT+eaaD0QHSfo79ABGVgHmNs1Xmu5Apa/ldC2hg
 4tg5QxZH4CKc0aP2omH6yGZJ4O7A6hfs/r78ItmHHKpb0Mw621CYAm2Evzy2VQv05IMe
 uzzA3nZ5KvkT5df66JC/3TMcsvSAH/ULYeR/0EqWkERIL1anRZnz6/oJK87IjUfCH7eA
 +5N8JZ0ai7hELADsBPH9Fygb9Iq9jgtkLYzJrWp9siMv4pDKR0VpDbKiVhN41HERpc8X
 NKoQ==
X-Gm-Message-State: AOJu0YyqwAr46EuDDQup7OvlIs9O6YE4kH+AbAFQi8AEw3SRie21fKPy
 5HWULjnJvpSB794vlwRGMl/voFzQb2lU1jsEbrXnTFMYyACNmlxngIlETubKSUgpSGnd3Yg+EGq
 9/o+ZjirnDIo96UffOo0EqIHc/wNrJH3abOdG0VLrtOOuRu/pJ2iwo/OKsZZkIPndnWak
X-Gm-Gg: AeBDievjr6mPY/1cd0PTT6if2cQ06UeihH7eDIJlep25E0+WjnoAv/5A58064Du243r
 ngHz56Crvn9n2BEzy6N9f8LAd+QZbed648FMOLrQMxs6Nt8Q1xQouloAEF+bMbjXb0bxHZHUCBg
 40rXdQ9nUZfFUI3KYQGEWi7vtYxO5teLSUl2X2zMTbff6xI7BABgDvBiO2wYpt2Uuz9n3PQWjOs
 RYs1zoUNvnSFFjWW1nEgXNV74iG3Fsv/aIeL/Z8uXisw1MevVYYZvJtthBAU0YqVReHflk0IFVp
 tn8XLDfanoiGoLC7UqylYYlVKIGY4pZOgrV44G0BjGdEO5NFWYlEaxXI5V/nSyTlwrvG+lkfpi0
 18wjiRgQbf/PnTl839ksxQInXuww8Mb8sA460173AIcJn03JZwBc4E5NbK29I/wFabGp5vzbe1b
 YsPfX0hV6CT5FxnhBn
X-Received: by 2002:a05:7300:e827:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-2ed3ba12a42mr2501600eec.2.1777581534547; 
 Thu, 30 Apr 2026 13:38:54 -0700 (PDT)
X-Received: by 2002:a05:7300:e827:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-2ed3ba12a42mr2501577eec.2.1777581533978; 
 Thu, 30 Apr 2026 13:38:53 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/8] target-info: introduce TargetInfo in QOM
Date: Thu, 30 Apr 2026 13:38:39 -0700
Message-ID: <20260430203842.29156-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69f3bddf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ifg725Mek7oY8M_gCSsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: i475GTnKDvddYBwN1qyxIa0B4dQRCNHt
X-Proofpoint-ORIG-GUID: i475GTnKDvddYBwN1qyxIa0B4dQRCNHt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfX9LYGdDCxNjBA
 edu1QZTJoFw0sQJyDUAsRpnRIRW67m0QMgTOoeOwBPjBxqrHdxjmxRKPUMTljZUoqACuReq1urR
 RVx2vq8gfTdHSxC/rRDdfaYVvgvCBMK2u9PSAT7IaNqXJhT/E5QnT605kP6t/MvGVT7gO3iILnp
 lB92KGu3IxLAOQgpXH2SYQ6EKlunRdqbj6hjCAN1oZMAzqTHAa9GcH4pZX9DjSTlMVlhZ8D90Ww
 a+ChAMDPeDbGRACF+ENuEQUak5f+z89wGWgxxlcmbztuz2Q9PFBseWF7ke5CKiEuNtsnRkCU0rw
 1Nbf/XzubxDC81oQ61mHECLlgmrcVhmDcuIVkWFhlrECK/3hau2uhSxLxU75vzZt+YQdkutVVQo
 Yo2hzt68mkyE+prszFmA+k4+EZzS6Wvmiy2i5A1HidH2WYcFE3LwB4SSUWt/BejjoHG79+khKyk
 bw+eGDja986yFHJdI3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300213
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

For the single-binary, we want to be able to retrieve at runtime the
current target among the different ones available.
A consequence is that we can't rely on existing target_info() definition
since it will create a conflict once more than one target is available.

To solve this, we add TargetInfo in QOM, with this hierarchy.
We define one class "target-info-X" per target, that inherits from
abstract class "target-info". Using concrete vs abstract class ensure we
can easily filter "target-info-X" from all QOM types.
Associated TargetInfo is directly set through class initialization,
without relying on any instance.

For user mode, we simply define target_info() like it was done
previously. In this patch, we keep the same definition for system-mode
also, and it will be replaced in next commits.

We will introduce detection of target from QOM, so we need to make sure
those types are registered early.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 57 +++++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h  | 28 ++++++++++++++++
 target-info-qom.c               | 14 ++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 include/qemu/target-info-qom.h

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index c781cfc0590..7e6f5d90ec4 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -12,10 +12,67 @@
 #ifndef TARGET_INFO_DEF_H
 #define TARGET_INFO_DEF_H
 
+#define DEFINE_TARGET_INFO_TYPE(info)                                       \
+static void do_qemu_init_target_info(void)                                  \
+{                                                                           \
+    type_register_static(&info);                                            \
+}                                                                           \
+type_init_early(do_qemu_init_target_info)
+
+#ifdef COMPILING_PER_TARGET
+#ifdef CONFIG_USER_ONLY
+
+/*
+ * User mode does not support multiple targets in the same binary, so just
+ * define target_info().
+ */
 #define target_info_init(ti_var)        \
 const TargetInfo *target_info(void)     \
 {                                       \
     return &ti_var;                     \
 }
 
+#else /* CONFIG_USER_ONLY */
+
+#include "qemu/target-info-qom.h"
+#include "qom/object.h"
+
+#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
+
+typedef struct TargetInfoQomTarget {
+    TargetInfoQom parent;
+} TargetInfoQomTarget;
+
+typedef struct TargetInfoQomTargetClass {
+    TargetInfoQomClass parent_class;
+} TargetInfoQomTargetClass;
+
+OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
+
+#define target_info_init(ti_var)                                            \
+const TargetInfo *target_info(void)                                         \
+{                                                                           \
+    return &ti_var;                                                         \
+}                                                                           \
+                                                                            \
+static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
+{                                                                           \
+    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
+    klass->parent_class.target_info = &ti_var;                              \
+}                                                                           \
+                                                                            \
+static const TypeInfo target_info_qom_target_type_info = {                  \
+    .name = TYPE_TARGET_INFO_TARGET,                                        \
+    .parent = TYPE_TARGET_INFO,                                             \
+    .instance_size = sizeof(TargetInfoQomTarget),                           \
+    .class_size = sizeof(TargetInfoQomTargetClass),                         \
+    .class_init = target_info_qom_class_init,                               \
+    .abstract = false,                                                      \
+};                                                                          \
+                                                                            \
+DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
+
+#endif /* CONFIG_USER_ONLY */
+#endif /* COMPILING_PER_TARGET */
+
 #endif /* TARGET_INFO_DEF_H */
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
new file mode 100644
index 00000000000..585995c7ad0
--- /dev/null
+++ b/include/qemu/target-info-qom.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU target info QOM types
+ *
+ * Copyright (c) Qualcomm
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_QOM_H
+#define QEMU_TARGET_INFO_QOM_H
+
+#include "qemu/target-info-impl.h"
+#include "qom/object.h"
+
+#define TYPE_TARGET_INFO "target-info"
+
+typedef struct TargetInfoQom {
+    Object parent_obj;
+} TargetInfoQom;
+
+typedef struct TargetInfoQomClass {
+    ObjectClass parent_class;
+    const TargetInfo *target_info;
+} TargetInfoQomClass;
+
+OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
+
+#endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/target-info-qom.c b/target-info-qom.c
index 7fd58d24818..ba2c7923760 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -7,7 +7,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qom/object.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
+#include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
@@ -22,3 +26,13 @@ static const TypeInfo target_info_types[] = {
 };
 
 DEFINE_TYPES(target_info_types)
+
+static const TypeInfo target_info_parent_type = {
+    .name = TYPE_TARGET_INFO,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TargetInfoQom),
+    .class_size = sizeof(TargetInfoQomClass),
+    .abstract = true,
+};
+
+DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
-- 
2.43.0


