Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFB2CD343B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZF-0006QW-2i; Tue, 05 May 2026 18:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZB-0006PM-RX
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZA-0006AN-8t
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645ErHcO248496
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4s3jHbmg75cVEgANJXecjMz/G9qW28DVPPqZw24W3uc=; b=DlIV/7RghveM2x+F
 AIg43OlKxhLs2zcU58QE1MdaPaRFPOgzq8pdN3L03LTkuwk6/hQU9DH45W8NfC8+
 42dysL/NakLFDJY8z0bGfUwiKMdUuC+fHeH/BEArpMKgjxKNzzyZVeHDbHzJJCgE
 Ht5toqaMIA86JKkdxOblWSV/4ubDIUXWe8IBRbnYzjvUFnZGPgJssABOH67w5qUT
 DqmI1i7GgKXEF5lxP5aaE9U6ydoMsrZNIvad+9BZd0KJNJI1ckC5TleynJ2Qp7sT
 MCZdapQy67BTx1xA7QY0ahsBR1n60Kd/NLbCeuvVKSFfZIpN7+pfxMiV8zO0Zk19
 M9s7tg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyjq41qng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f485961555so991024eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021314; x=1778626114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s3jHbmg75cVEgANJXecjMz/G9qW28DVPPqZw24W3uc=;
 b=c5PVjqKwa8Kht5XTrP/aD0DqMyqC7SmKQkz4uZW98nB+z4hmlFWDDo5L33Pn7R7dP0
 va4A1KtV83hzm8EbHPBNmeiN0lvtUhrFRmMUdfwrmz2vIlCFa8jSKMuTc2zUfJ+MaW63
 TQ1WAjZYtEyWXbol6sdu8Uxpz4jM7TwtXWJjObkqWQH/nj19F/v4uJXiSse63nWPdmgP
 eSMzrgwC6rHIId9I2K6LNaRYqVwub7qlvpihl/t1akrlxiwYxpugoB3A3mkpW2OH9uv2
 i5P/yRBCwv7AgwKOA9HOjIXD/gxvxHPmCIB3U59iv922pnv9M7dmi06a8SrtRZDB3fBB
 rg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021314; x=1778626114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4s3jHbmg75cVEgANJXecjMz/G9qW28DVPPqZw24W3uc=;
 b=SWE615CIwYprzl7c38cuz7fJcZbELdpOUXdQWJn0HfI2kFLm8HNZTaSRMRSvDvwwj2
 0kjtAK5qPaODb/0aOtUmdtLuyPwuSNAImHJv4jA9vxgJrQyjUm+CYfVSdfWnvdTKZgG9
 6ZFTCB0GRm+XDlMCMZeqWEDTU/968q0OypMcZeWMowtl3WyTcR+t9Ucbx32ZeIpsXQND
 HQi3XmQ6vgfch4IWlCQMI/pmgZRiA3aY1Q/YdN/PNPHBQDueDU76/yU/ZmLHL6NjRvo4
 Fczbv6FJBKbZEQcBbUdiscaMYmvzny0P2is7oPBe8H7fzg1icg8QQySkKXOT5sDqmgC2
 UpUA==
X-Gm-Message-State: AOJu0Yz9T/coZiqia/LAdM226p4DrnP72oqF5f2iprgzX8XJlkHQnVYd
 7iFUi5rnDxXzcMpNy6DJaK6P1CMBhDUFW7QV5EaIlXv8ajxNQmh05ItfSNuk9OGdON45RqmrlLE
 S8Mc3XjruFffaIs8IIAX2Xq4+60FxPKVhxeoafGMsf9yMSLb710P+yBIwckhnjQrFhn8I
X-Gm-Gg: AeBDieuB31g1fGU4fdQVdo735P7OLp6Tc/BavCXzCr9YUz657be/tUu5rcxdAfNM3hY
 9rHraH1SIczteQD5ZyfMEmrvkuWoHBIpVxe/RyeQJKWQmRpj0yrsZDZ/Hfw9BbJV8XWYJ9U/Qmf
 L5MdZmZH6her84DYo+ax4qkskewN2AF9UDzUbx2GjgPXXlJmi7KIOPxiDXi6KoCOaAaM17Wqlh1
 N7GYHFC2d6dARuqvGjw2UcS0J9VGqjpVCiZeiMnjncRwU4eOSM/bps2iCSMSWKGlvrNSIlouRGu
 9lo2ZC8dZNv/062GwhWkL8MPA+lu2U821L/RD9Z1mWwYqTPifw5XGSfaSSz5rCn+36lA27dXTvT
 Gv6ANpz/vftnkJQ0GRT7AraNhFagS2zHswKPk/MqoyB5SfuAaNm5ZWAPtGRnURGl1kVAakyBB7J
 pLzSoXV6t2e83NJ72H
X-Received: by 2002:a05:693c:2c86:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-2f548e9922emr762018eec.14.1778021314176; 
 Tue, 05 May 2026 15:48:34 -0700 (PDT)
X-Received: by 2002:a05:693c:2c86:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-2f548e9922emr762011eec.14.1778021313656; 
 Tue, 05 May 2026 15:48:33 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 5/6] target-info-qom: detect target from QOM
Date: Tue,  5 May 2026 15:48:25 -0700
Message-ID: <20260505224826.2698753-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MYxcfZ/f c=1 sm=1 tr=0 ts=69fa73c3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0wc84GFNkZAXjcWhtbQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX4ZSVN8lc4yTi
 wM0rAZzfdBuzvtmt+CeoKpPNAk/h2sOAEMjKC1KD1rdOjR2xLYkVX6t+Ec3QrfPaBJP4BmnIdYs
 yOpcJEGcqLoElpG7PkY2gxFJE5ftwHju37Ve1FSKfOFhH6RUzZXs9Zl4dnFy8XqSQMRJxCEBR6W
 /SimoZPdOqNG5iN2Rh02jgSJxjHVNSngR5ss/WM0sFnGHZRSdz57Z8WetrgMFAorqfFnfeV6QZO
 +PhDrqdTZIgQOwaCVSnD0H41OMmN31ILPsLbt3YUOg309rkjzhxYudmnpnoxTX5+hYu8/436Q6G
 B4EqaRtOusq8y68BpBYUUfpAkh91Fzcx+RnWGQQpmVmAgOrtdDp2pDfgV7rFqj2EluDKcEqSiIQ
 734+tNq8ky+AvvLSB+oBBANtzi7GMr4K7xdawC9pGG0M7JwTFvzF1ZgRTLnkBBe8tTlm4ZNvjKF
 5JTY8lymBppJtsiFQag==
X-Proofpoint-GUID: W9_-PZfDuYlRK7bLqibfrwTLCeHCc94z
X-Proofpoint-ORIG-GUID: W9_-PZfDuYlRK7bLqibfrwTLCeHCc94z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050222
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
index 2b6739271ba..77b2b4e673d 100644
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
@@ -2891,6 +2892,7 @@ void qemu_init(int argc, char **argv)
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


