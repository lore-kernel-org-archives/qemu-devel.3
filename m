Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25DDCD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyy-0000hH-E2; Fri, 08 May 2026 20:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyO-0000Tf-JQ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyM-0005y5-Mg
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648MROSA318068
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XEcizUUTyZsT3aUtnh6Piq3IYZxAXkYO//vcr+qpH3w=; b=AwEceEPopjMGPu+x
 LNG2YWsqa7W2XrJ46U8JB1Xmx9EJ1zGE+5lqkHw2JRSMLyJWGBSOve6qGczlBg/z
 niVIFFScIZT5+Ca+GbDfPot8OzEz/2lvTJonGoQZOh0cOsPxCRC0BHcYMsMYAj9Y
 2Oy4BclM97b5ONgIqHIHG1/ltY//PAXoz9i+I777d1MkTee8UECx0UdKE6BW3xAj
 5fz5ABwB6vkKGYxPG2LiQSggnxUQhBGecezeARSQt3pwvjzy59S8V+jA4J4qnZkr
 VJPuKJDv5CYtE5l9ZPFxV53MyVMDJKCxzepqi4TWwn05lrSZBim325ci6kOiwKSE
 QiAsMg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc03nv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so2810374eec.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288112; x=1778892912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEcizUUTyZsT3aUtnh6Piq3IYZxAXkYO//vcr+qpH3w=;
 b=MUXVBHBZ3EYOS0/m268yem3e3RX62HlZO5pOlOWKegssrj5ybhNVK532s2WUB6ttdk
 DDbtRIUAkCB/95r/kfG+ucXY+jqsYULl63ytfzM3qxzV4oeWNgYs8ZO6m8eMxXFZe3Rx
 P+PfqNI76lsKmdkzWpPP7XSQrMuRGl+t/uzL2N8lybqqctzF1P27P0XNPkSZjPrAAjAo
 lo1loNMf3zfq8EWuNysp6KtrTo13Vr36GpRKkbfrn49Iw4aA5lJVHDBfphID+v3TUl7W
 pEq/36YAQ1Zfr4tRFNeu99ta1FEIW/sB/Anccy8jgpV/TUjf6NdpaXndw/CSF7sNFoZg
 uX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288112; x=1778892912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XEcizUUTyZsT3aUtnh6Piq3IYZxAXkYO//vcr+qpH3w=;
 b=jcLJ4deqc85Ob0LP+ZpuGNaQy1ysjGsdLtYdqjjtK0agdLeFmDcIsxsf343aA4Gq0N
 EsD4ubTXqOSXAVzSGkO0CX0QA8CZrwjhqNLLs8sc9h/en2hwDK4iuYOzDY9/zK4ziq5w
 SLGa5Z5VBDC+TMgNkOrO0yG90IyfBny0ZEeTTaPJsS9xNJ9a0aZ8fuZJ3gHbmc5vef2P
 PFaL3NDRS4/c3kn9zKEnZJ1QXHSq4DX3IC68jM9AhtU5WuOVh72ADeRYuTNRBbZHw6mN
 EURycLfbAEg9eYvu+nfFtFG5WTpn2NVFXp8CL3KphR+xC5gShWBwxOwC/Uv1TRmz6l3D
 xWug==
X-Gm-Message-State: AOJu0YyNJ/1+7MF3ALWW+rHwcFnPLsWo33VKqLTinwI/mgAYCYgIoj4G
 Wt00z0elxfcvrs9hUcj4R2wfK+pudr6g1+IQSRbOD+WdRAYvmiMizi0IN2ftWsz4r744ZkibvS2
 1911DQezk2ZcBrptz9yyOm7gr7PQHsv+G0Msq3ypjVU6qpEN+/55qoXIRwEOjF6CBCtFr
X-Gm-Gg: Acq92OFx9BR5mHOEgi+WHidsaPB0NMAhHXaaIFiLHjy6QomZCb+B177I5/dBOUN2D8o
 /cIwzmlz61ZZDaKxPpgPp2/w4wPqW70VKMNEUn5xu5MEFBQyHwM73+2+SkOn3oyEbUSVaUgN54E
 AXGvdSafMLNCSYB2q91tpAf8+pfVTlvUTYKpxojNmqDLiUmX9dQzd/Q5SdcePDCBX4Ve+odZ4fD
 SCNrXTi/VcxbABdbljeIaJvBDK65LTH96iWvDgJdfeXLogQxh4LQWp3gk23FpHMRJqqlcQWJXKs
 Vu5kvSl2WGNvNhFgM1OxSkdROcBcEQEjh0ol33J+d0R2DEH/KVoijFsM+SPrxL133Y1xsvu09kd
 sHl1g8joD26rpQrqsTiKIZTdVg6Hza4OPum7dWfnzys8wfRt1Df8r1oRR+OXkX9al+Mh+kjHCgp
 xghl4KiQ==
X-Received: by 2002:a05:7300:f690:b0:2ea:7901:8d72 with SMTP id
 5a478bee46e88-2f54a87e863mr7914265eec.17.1778288112072; 
 Fri, 08 May 2026 17:55:12 -0700 (PDT)
X-Received: by 2002:a05:7300:f690:b0:2ea:7901:8d72 with SMTP id
 5a478bee46e88-2f54a87e863mr7914249eec.17.1778288111478; 
 Fri, 08 May 2026 17:55:11 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 4/6] target-info-qom: detect target from QOM
Date: Fri,  8 May 2026 17:54:51 -0700
Message-ID: <20260509005453.3984184-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfXzNM8TYUvUNzq
 98h03mnXCHxEgVm2Cug72uM28CMFFPAFLn0mgN7gf+iehZIdoPEhPH2+M29t4LCw5RKAoHC/AkL
 t6Y9qjWNuP8Uag87aFyL6jb3AjOF/ZLk9phKFjuDvYI2SN1rI+2VvByhqYC2j8Ym4OOM3XcY6Dc
 72MSr13p04nKDiLRmzbEbSgZnc+h8tsSJNibmP9YPzdMRyF3/wzmRAx7yYn5+lmEvwnCa+iIvd5
 g5LMk1oMISVfNNxEyrIUh74qa45ai/Pl18iB5mlqw1JGE4Riuooeo+hp9bKhvIWt2/0obfYdQW8
 7029te2K9eKuzp6C+p22FHVd3VBO17Sa2Rh04j7+TjAyt6cbpYlw2mt313vV9kuuzVjxmyoY+Z7
 KqL4IJKZoWoXiT/NLKDNTfir4xb5XrMQzH6MWRuiokQImNm53rtteXuyXlkZTEs/5QcoBgs1CRM
 Wflpme8IVEiN8vUHuYA==
X-Proofpoint-GUID: ur8_Q7SB_lIHlOY4KlYVUuEFn5b84euC
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fe85f1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0wc84GFNkZAXjcWhtbQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: ur8_Q7SB_lIHlOY4KlYVUuEFn5b84euC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090006
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

For now, we expect only one target to be available at runtime. This will
change with the single-binary and we'll detect which one to use
dynamically.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  2 ++
 system/vl.c                    |  2 ++
 target-info-qom.c              | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 585995c7ad0..91be415ed33 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -25,4 +25,6 @@ typedef struct TargetInfoQomClass {
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
+void target_info_qom_set_target(void);
+
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/system/vl.c b/system/vl.c
index e44da0941d4..e690aa3ed8c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/core/qdev-properties.h"
@@ -2890,6 +2891,7 @@ void qemu_init(int argc, char **argv)
     os_setup_limits();
 
     module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
 
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
diff --git a/target-info-qom.c b/target-info-qom.c
index ba2c7923760..9d1f50ffcab 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -36,3 +36,19 @@ static const TypeInfo target_info_parent_type = {
 };
 
 DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
+
+static const TargetInfo *target_info_ptr;
+
+void target_info_qom_set_target(void)
+{
+    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+
+    size_t num_found = g_slist_length(targets);
+    if (num_found != 1) {
+        error_setg(&error_fatal, num_found == 0 ?
+                                 "no target-info is available" :
+                                 "more than one target-info is available");
+    }
+
+    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+}
-- 
2.43.0


