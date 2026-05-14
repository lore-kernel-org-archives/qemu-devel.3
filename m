Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F596CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc8z-000191-Rx; Thu, 14 May 2026 15:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8t-00018V-14
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8r-00026u-66
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:46 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpRCY3795545
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uz396+7ZaeryXuhhDG1a8EY63qK6rCuMgSeFRQgHmzw=; b=IxpTm4RrCvl+F8DF
 n8IiKMN9mAwW60HGZ6MY1+mcD2rBDQAc3LCsn1dYlLjv6F3c7FyhfO7swa32ZXg2
 N5Y+Mm1Efh7I1U5RA13+gvXvhrGDvVMOmZK+uFIrCON45WN4MvSKG0gtdcJzyu4l
 gScaafm1+T3sGWPBYczOgbkTg7BLRYg9QYFSIlTar5tg4+/BGYpJbgKAnkY7suFw
 rnKCSFbQV0TrDd+Kjt6LGDkha1AKOyk+Ukc/oOOh7xXUkTg6Eok5clfQ15dGf+4D
 qaLzx4bxxsfzLmHWF5ZTOjT8Yk6hZ+t0yuk1h0P6JrYhtYfuVKSnQ9SZt4ScRuC9
 rIHyeA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sr5v2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:44 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13312af37fdso13033c88.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788481; x=1779393281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uz396+7ZaeryXuhhDG1a8EY63qK6rCuMgSeFRQgHmzw=;
 b=de8ka4Ow4Kwx7J9yby1IZis3vjVyeIgPIdoTQmTT4/WnguSz9Xal+GKlpqvkEAwMIE
 gbDfVyt/lAiYtRQAOgbJfvcUgAY+LAhQ6VGqtE3f6bGeF6dFj2FDCJ2ZEZ+Ar5QrrQ2e
 Ld8pwXxxOwpvGMtzj6Yk54JxKIIYkGJFi3z1jxuCV+IlWOchrFYp0SLEAjII4Ovl/eLt
 TkjKfzR6y94WwqlyIfrOevmmjWhesSaXbXf7XGsTYHSnHJQTOa5wyeMAt+vFvanQKEPA
 dRrEj2AQPggKPmEh85bk38qc3hsDQpO+EZakDFu06sNbrqnWjJJsu3OAjVw/lghT0mDS
 VU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788481; x=1779393281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uz396+7ZaeryXuhhDG1a8EY63qK6rCuMgSeFRQgHmzw=;
 b=ILnwfF16In8TT94I+lkGPwGUSOTfzBGqaQ6wpaEuRH4X5pt2WrfPk1k9c4TT+ZERlg
 OPnZxvlN1hmpGpTiePUUOf5Ktq54yf5myGlcLvUvsgTMBs1zKK7LwtrBkOi3FOFl26zE
 ECeBIpnwhqf+4eLsha5HDKe1ygUnBWAUcm6I8R14qWBc5vioMFXnkhDManVv2tHIeksh
 8iqYCoq3UXa+/kR1kUOqMqc+x9A5bzYmk55p4XG7SVtm4KUcYyQnCGYxyaAa0NLZd+9q
 kracuscA3q0FGrDOsIzXTbhzeFNj8NuhwddpnoCT7XhcT/JYxdAJb8KFQCx+TA4y/Vx0
 AsoQ==
X-Gm-Message-State: AOJu0Yy4eP7ekaJ9EgMUFm5037ebtBYKt12tReht5VtZAkmFcpsLFmvV
 y+ryHTTuJjrf989Ga3F6MwJpvwWPXEaQUqjNCJax2xrvj5kXQ7/L66jOYUlGZiL6IIHKOx/gkKL
 uJzZKAfyHF7AwCtMSo+gHxFg15pYcPrMockHUOSVIVIXk8X+o0qug3xP1JhgVyRxsXKad
X-Gm-Gg: Acq92OFXYDKYSlLA7Nf4af1IR2szpzfVx1dHbMgsl1gw5zSXWkpF7smlcPB2VE4xy4L
 KoSRJWNvdrPkig2WDTmSY+EW6OB/cYCE+WMyNcuYcixK4t5Nec/JPOC4Jap561PoCX1B4c4ylW9
 lnPhx+SPRDcRnV3dD+2ISGfRqMrqKL7xBmOg3S7aZz0QYRg+2qvt5AIRzUk7lBk/X4rr9mGWEcx
 5i2u2pMQw1yhnxV6qLUd+b6I0E+pJohG1BmakUo7P/zShcu8LMH2OITUfEE91fYfAjQxZ0M3BiL
 zhDwIVB3RI1QI3tNEuv0BhWjPOdl5ofiD5FQnd/5AJCv0FE5Ten4AkqTHHqbkLB1PVwayNBWD1d
 fF/3EcoaxN3+zkrzI29tLiKQS2J1wf5DRp37fTjhc7XlAxE0KddSDhbZhrp3RC0xkOCF+wZnWWQ
 fKN9r4mQ==
X-Received: by 2002:a05:7300:ad30:b0:2e6:e504:5435 with SMTP id
 5a478bee46e88-303982be4c5mr520764eec.12.1778788481337; 
 Thu, 14 May 2026 12:54:41 -0700 (PDT)
X-Received: by 2002:a05:7300:ad30:b0:2e6:e504:5435 with SMTP id
 5a478bee46e88-303982be4c5mr520747eec.12.1778788480831; 
 Thu, 14 May 2026 12:54:40 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm4180636eec.22.2026.05.14.12.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:54:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 4/5] target-info-qom: detect target from QOM
Date: Thu, 14 May 2026 12:54:26 -0700
Message-ID: <20260514195427.1706609-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX9JDmIYDPu0ZP
 Vg8x5u1hftPBg6B+BbYA9mFkhTayu1yT5DkjJzKoW+nBtLKzZENAjo+Dm/0fy72AtvXuLiGkpfU
 BRA0d8TdRS4CLyymvr639r8WVgtqzZAGkMc3EEzcUMQrAwT181a20cLwrHF/fXLClIknwkFnZrx
 /68+0WFjpKlFcrdo/aMbAAxp/05+8Dyw89KjzimSo6i1BOdZ+qNJpd374QwHtlvq8K3ztGFot/c
 FUpBh/jm/ymqdvDQxBB1U+8MfftE1bkGcCRXc+foYE9VCHan6tbOLKYxRK5xG5t8lKCU6ha88Xo
 0l9G8UkCV5uGe+nylzdslNF9xAwVpTp4rvCiev88NEpzR5OyqmMTfsgTTWEDzrcWcr6w62levsw
 Uz68pctR08sss6tooQiaaRV6QMDZIDIBOVb/YQJ+rPiFF/z4d0Ntd0cUuXPRQU/S9GHJYCjqqdF
 PiMXJCCKOsm9HgKGHwQ==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a062884 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=Ta8ybb0yH1EomjxcGswA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D8a_FHn3Z-pS1p2xmw81Kz9N4WhdflzM
X-Proofpoint-ORIG-GUID: D8a_FHn3Z-pS1p2xmw81Kz9N4WhdflzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  2 ++
 system/vl.c                    |  2 ++
 target-info-qom.c              | 16 ++++++++++++++++
 tests/qtest/fuzz/fuzz.c        |  2 ++
 4 files changed, 22 insertions(+)

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
index 79752366b61..9947fcc9922 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -46,3 +46,19 @@ static const TypeInfo target_info_parent_type = {
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
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index de230d20e0f..a3a131c80f8 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -22,6 +22,7 @@
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
+#include "qemu/target-info-qom.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "fuzz.h"
@@ -173,6 +174,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Initialize qgraph and modules */
     qos_graph_init();
     module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.43.0


