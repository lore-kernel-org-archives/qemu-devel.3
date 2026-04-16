Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A9CF8A163
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4T-0005H1-Sd; Thu, 16 Apr 2026 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4M-0005CM-LL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4J-0003CN-Ox
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G6PGcY2653725
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V6nVKixGSjR
 GXMplnHG6wHz1J9IW5gbrlupSNq0KwoE=; b=GJeeOqT/iTy2PGcqOBG01znj8OX
 I/wCKrqZHwHEtilivqvly7ZZCCiVy0puSgxCc4KyCbjjwqfxJYzsJhQb1GCWNq03
 TflHvuOrGAWHeLOlrz3hWf5/+SJS56zPoVQJXuCGRxaDxQhX1UBNUIagi8aePAdv
 CAOeES4eo3S4m0Za7lRoAipZK7K+p/kEplfZWiCJ2zf28wTyRXudM+d9meKDq8eb
 y3XXj5eJlIIaDK8M9O/9Vg/EHNxB842lgelEnjUTTKHL8Hlw7w2/Ltbfpa6tXmFD
 i3pB1Va6QM9R51eG+2MMPtd/yKqFvOoWGfatpVV/tN7m/0g0d+muLt0Iiuw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtfuh3xs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:24 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c56ad1a90so19502486c88.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339564; x=1776944364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6nVKixGSjRGXMplnHG6wHz1J9IW5gbrlupSNq0KwoE=;
 b=FGeDEbvjHmNh2nililq2Y203+szBCC5/83zjPEdDBeGVlmzih5KPzDs6TugkwgVRDv
 pf3a75ZEeKz/bd+TJEeOYWceWXiZ5NRQDjnlqeVp+lAgSKriqmkpHIHlp/w9UFcy/HXs
 7UMJG0QnXQOj2L9X/H5pxCK+ygdjAn+sJ07p6QyQwliRMP6y6eNRZOkqtqXv5wzXUJXC
 SiMJYNyXW+n8oEigyOpe0TZVK99bPCChdZXM+WYzM7A13Hkgv3uQm1R8NdJlkSxI+wec
 +nq9BokzWQWvxbszA3PUOnQoC38EJqUmGUNa2Py7Gwr78agoQ1lwjO6UK+94gLzhUSrT
 uvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339564; x=1776944364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V6nVKixGSjRGXMplnHG6wHz1J9IW5gbrlupSNq0KwoE=;
 b=kl1Ex+teb6lhFtxdN7vUaif/GYK+2MP4qhzVGq5R4xlPju0WFGASVbCYqoiLRhgEcr
 Gt7i3a7nD3RGGSHQL0d+M1oUs+6B6mDJPSIp9ZHCbaDtNNiE7K/WbaU9BPMV7x1MwC2g
 WcQKadFcRr5Bcql6TCGlt6RZ4DZ3gRm45UZM3vjY/saKNr+QlDyNUTjblJLrgiTJlSew
 dMxRwOM+vzddOG1wLmIh02GkmGVElJqD0aAycCCIKzRmMLR7PWz2cycz0+QadVLQ1IIT
 pIm1wcVxVDbdvSFV+BzcB0qB7enC9JoAD/bBRMP6MOe8thrCgpngNlZaH3BJ5GmVVgvy
 yhCw==
X-Gm-Message-State: AOJu0YxzDL4WyQ29xblxlImCbCTlsLYhTSy8ACQjEYbI1jWrbUiTJzn/
 JpuZCIOdk45LK89q8piQyhBmiQ0Q2KcyFYhC5Pzca7aywayE4koB3zstu1KMPVoc+iLw/QkGqVO
 kU3NF37549nDFTmSqXKA4qRnrqFttCNBT78CLYWzQ9E+y65LYILJCXV/TolEOXYzXV93+
X-Gm-Gg: AeBDieu+rjzjaK4aQELVAen3hHa9sHGgfGAiTTEaNDLWRBGO3z93xihkSppXuGvFTkC
 Y/JZDHFiClR8VdFyPqmPaLneaN5W6MDx5uqCnO7eeqlRJAYepoJM8+5AnhdNmQzDaSJOU1ZdnX1
 qUG9PT/Usli0CCiDkpj07t9XYwAie28k0jYLvOsZWbLF4jS5SBPj06gjnUNe/zC+pCaoSg2SWcH
 PvGfBG50IZruH3QKrT5v6EDu8ffUHU17bBDtrydxJeEqAMlrb09Js2vA+/iVSY61hBMdvLYa6WC
 a+ZIFi4U1a+9Oobkj3b0/6FthtmsvM1jo78sLA9nS+sV7eMREdZ29SSfIsUrZ5W7lGRB75ZY+kU
 kfPCLzekZu2RSs2rnI+BtSszZOVSZ07unToOrtvhPE9956xkqMij4a2346NAcMtkqYB1a+f8JeO
 yL82+k9dzsEwZBeWBL9ps=
X-Received: by 2002:a05:7022:b97:b0:121:dea2:d54d with SMTP id
 a92af1059eb24-12c34ececbfmr17166671c88.20.1776339563438; 
 Thu, 16 Apr 2026 04:39:23 -0700 (PDT)
X-Received: by 2002:a05:7022:b97:b0:121:dea2:d54d with SMTP id
 a92af1059eb24-12c34ececbfmr17166642c88.20.1776339562825; 
 Thu, 16 Apr 2026 04:39:22 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:22 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 14/16] tests/hexagon: add tests for v68 HVX IEEE float
 conversions
Date: Thu, 16 Apr 2026 04:39:03 -0700
Message-Id: <ec6af07a285c47e5f6df343860bfedce5bed9421.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FNR-y0AW0HWKuiCxy08pYUmYTWfHkHNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX/zti/MtrLYch
 PVov8f7cSlqdyT7EMfweVtJ7ai81Ee9eh0U+/pSEeCLSeqaMkTKpAlSTWdAAknCq7/0t/mAdWhi
 9bx5OBEWfVyzaeh5jXgPVrQHtfSNJ8mj+neV9kU4EzmAII7NO0moXRVmIxE5e6WTMSyz4zDoYkC
 ZpiJ+XO2LfJLQouHx/JooEPoJXPnMkk3aJXKS4yexj8ds0MRYCp/bssK1vig1Usqswlv/oANEfG
 ruPnndgdBdn2xZdQa6OXh8n3AjTCD0SNtgIqjNcYHXzDMjzrIqw0ovvz84Ui3LuufBjZTHfkoWi
 75+SIGnOrnIWlWn4MTgiQVxsNLJKaMa8WfzMbqUmXUC7B8ejT5G59FxokCRD9dvCg/eqDG2aeYE
 DCIyKiuRzKdHAQJJGWiMnVNuTXpRkIb/qnknbO7IW7XOtoiP23K4lz5YOyzxzrgBWYuCjj1BYm2
 oUXQbIzX+xE+qtDudgA==
X-Proofpoint-GUID: FNR-y0AW0HWKuiCxy08pYUmYTWfHkHNb
X-Authority-Analysis: v=2.4 cv=KrF9H2WN c=1 sm=1 tr=0 ts=69e0ca6c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=OZRFAO6Uk6ULta4fWVgA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/hexagon/hex_test.h      |  14 +++
 tests/tcg/hexagon/hvx_misc.h      |   2 +
 tests/tcg/hexagon/fp_hvx_cvt.c    | 188 ++++++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target |   3 +
 4 files changed, 207 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index e7a6644d41..d5da8ad240 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -111,6 +111,20 @@ static inline void __check64_ne(int line, uint64_t val, uint64_t expect)
     "usr = r2\n\t"
 
 /* Some useful floating point values */
+const uint16_t HF_INF = 0x7c00;
+const uint16_t HF_INF_neg = 0xfc00;
+const uint16_t HF_QNaN = 0x7e00;
+const uint16_t HF_SNaN = 0x7d00;
+const uint16_t HF_QNaN_neg = 0xfe00;
+const uint16_t HF_zero = 0x0000;
+const uint16_t HF_zero_neg = 0x8000;
+const uint16_t HF_one = 0x3c00;
+const uint16_t HF_one_recip = 0x3bf9;
+const uint16_t HF_two = 0x4000;
+const uint16_t HF_small_neg = 0x8010;
+const uint16_t HF_any = 0x3c00;
+const uint16_t HF_neg_two = 0xc000;
+
 const uint32_t SF_INF =              0x7f800000;
 const uint32_t SF_INF_neg =          0xff800000;
 const uint32_t SF_QNaN =             0x7fc00000;
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 0330cb289d..43de20da6a 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -69,7 +69,9 @@ CHECK_OUTPUT_FUNC(d,  8)
 CHECK_OUTPUT_FUNC(w,  4)
 CHECK_OUTPUT_FUNC(sf, 4)
 CHECK_OUTPUT_FUNC(h,  2)
+CHECK_OUTPUT_FUNC(uh, 2)
 CHECK_OUTPUT_FUNC(hf, 2)
+CHECK_OUTPUT_FUNC(ub,  1)
 CHECK_OUTPUT_FUNC(b,  1)
 
 static inline void init_buffers(void)
diff --git a/tests/tcg/hexagon/fp_hvx_cvt.c b/tests/tcg/hexagon/fp_hvx_cvt.c
new file mode 100644
index 0000000000..71c3f0fd4f
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_cvt.c
@@ -0,0 +1,188 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+#if __HEXAGON_ARCH__ > 75
+#error "After v75, compiler will replace some FP HVX instructions."
+#endif
+
+int err;
+#include "hvx_misc.h"
+#include "hex_test.h"
+
+#define TEST_EXP(TO, FROM, VAL, EXP) do { \
+    ((MMVector *)&buffer)->FROM[index] = VAL; \
+    expect[0].TO[index] = EXP; \
+    index++; \
+} while (0)
+
+#define DEF_TEST_CVT(TO, FROM, TESTS) \
+    static void test_vcvt_##TO##_##FROM(void) \
+    { \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector buffer; \
+        int index = 0; \
+        memset(&buffer, 0, sizeof(buffer)); \
+        memset(expect, 0, sizeof(expect)); \
+        TESTS \
+        *hvx_output = Q6_V##TO##_vcvt_V##FROM(buffer); \
+        check_output_##TO(__LINE__, 1); \
+    }
+
+DEF_TEST_CVT(uh, hf, { \
+    TEST_EXP(uh, hf, HF_QNaN, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_SNaN, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_QNaN_neg, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_INF, UINT16_MAX); \
+    TEST_EXP(uh, hf, HF_INF_neg, 0); \
+    TEST_EXP(uh, hf, HF_neg_two, 0); \
+    TEST_EXP(uh, hf, HF_zero_neg, 0); \
+    TEST_EXP(uh, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP(uh, hf, HF_one_recip, 1); \
+})
+
+DEF_TEST_CVT(h, hf, { \
+    TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_QNaN_neg, INT16_MAX); \
+    TEST_EXP(h, hf, HF_INF, INT16_MAX); \
+    TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \
+    TEST_EXP(h, hf, HF_neg_two, -2); \
+    TEST_EXP(h, hf, HF_zero_neg, 0); \
+    TEST_EXP(h, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP(h, hf, HF_one_recip, 1); \
+})
+
+/*
+ * Some cvt operations take two vectors as input and perform the following:
+ *    VdV.TO[4*i]   = OP(VuV.FROM[2*i]);
+ *    VdV.TO[4*i+1] = OP(VuV.FROM[2*i+1]);
+ *    VdV.TO[4*i+2] = OP(VvV.FROM[2*i]);
+ *    VdV.TO[4*i+3] = OP(VvV.FROM[2*i+1]))
+ * We use bf_index and index in a way that the tests are always done either
+ * using the first or third line of the above snippet.
+ */
+#define TEST_EXP_2(TO, FROM, VAL, EXP) do { \
+    ((MMVector *)&buffers[bf_index])->FROM[2 * index] = VAL; \
+    expect[0].TO[(4 * index) + (2 * bf_index)] = EXP; \
+    index++; \
+    bf_index = (bf_index + 1) % 2; \
+} while (0)
+
+#define DEF_TEST_CVT_2(TO, FROM, TESTS) \
+    static void test_vcvt_##TO##_##FROM(void) \
+    { \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector buffers[2]; \
+        int index = 0, bf_index = 0; \
+        memset(&buffers, 0, sizeof(buffers)); \
+        memset(expect, 0, sizeof(expect)); \
+        TESTS \
+        *hvx_output = Q6_V##TO##_vcvt_V##FROM##V##FROM(buffers[0], buffers[1]); \
+        check_output_##TO(__LINE__, 1); \
+    }
+
+DEF_TEST_CVT_2(ub, hf, { \
+    TEST_EXP_2(ub, hf, HF_QNaN, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_SNaN, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_QNaN_neg, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_INF, UINT8_MAX); \
+    TEST_EXP_2(ub, hf, HF_INF_neg, 0); \
+    TEST_EXP_2(ub, hf, HF_small_neg, 0); \
+    TEST_EXP_2(ub, hf, HF_neg_two, 0); \
+    TEST_EXP_2(ub, hf, HF_zero_neg, 0); \
+    TEST_EXP_2(ub, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP_2(ub, hf, HF_one_recip, 1); \
+})
+
+DEF_TEST_CVT_2(b, hf, { \
+    TEST_EXP_2(b, hf, HF_QNaN, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_SNaN, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_QNaN_neg, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_INF, INT8_MAX); \
+    TEST_EXP_2(b, hf, HF_INF_neg, INT8_MIN); \
+    TEST_EXP_2(b, hf, HF_small_neg, 0); \
+    TEST_EXP_2(b, hf, HF_neg_two, -2); \
+    TEST_EXP_2(b, hf, HF_zero_neg, 0); \
+    TEST_EXP_2(b, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP_2(b, hf, HF_one_recip, 1); \
+})
+
+#define DEF_TEST_VCONV(TO, FROM, TESTS) \
+    static void test_vconv_##TO##_##FROM(void) \
+    { \
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[0]; \
+        HVX_Vector buffer; \
+        int index = 0; \
+        memset(&buffer, 0, sizeof(buffer)); \
+        memset(expect, 0, sizeof(expect)); \
+        TESTS \
+        *hvx_output = Q6_V##TO##_equals_V##FROM(buffer); \
+        check_output_##TO(__LINE__, 1); \
+    }
+
+DEF_TEST_VCONV(w, sf, { \
+    TEST_EXP(w, sf, SF_QNaN, INT32_MAX); \
+    TEST_EXP(w, sf, SF_SNaN, INT32_MAX); \
+    TEST_EXP(w, sf, SF_QNaN_neg, INT32_MIN); \
+    TEST_EXP(w, sf, SF_INF, INT32_MAX); \
+    TEST_EXP(w, sf, SF_INF_neg, INT32_MIN); \
+    TEST_EXP(w, sf, SF_small_neg, 0); \
+    TEST_EXP(w, sf, SF_neg_two, -2); \
+    TEST_EXP(w, sf, SF_zero_neg, 0); \
+    TEST_EXP(w, sf, raw_sf(2.1f), 2); \
+    TEST_EXP(w, sf, raw_sf(2.8f), 2); \
+})
+
+DEF_TEST_VCONV(h, hf, { \
+    TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \
+    TEST_EXP(h, hf, HF_QNaN_neg, INT16_MIN); \
+    TEST_EXP(h, hf, HF_INF, INT16_MAX); \
+    TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \
+    TEST_EXP(h, hf, HF_small_neg, 0); \
+    TEST_EXP(h, hf, HF_neg_two, -2); \
+    TEST_EXP(h, hf, HF_zero_neg, 0); \
+    TEST_EXP(h, hf, raw_hf((_Float16)2.1), 2); \
+    TEST_EXP(h, hf, raw_hf((_Float16)2.8), 2); \
+})
+
+DEF_TEST_VCONV(hf, h, { \
+    TEST_EXP(hf, h, 0, HF_zero); \
+    TEST_EXP(hf, h, 2, HF_two); \
+    TEST_EXP(hf, h, -2, HF_neg_two); \
+    TEST_EXP(hf, h, 2049, raw_hf((_Float16)2048)); /* rounds DOWN */ \
+    TEST_EXP(hf, h, 2051, raw_hf((_Float16)2052)); /* rounds UP */ \
+})
+
+DEF_TEST_VCONV(sf, w, { \
+    TEST_EXP(sf, w, 0, SF_zero); \
+    TEST_EXP(sf, w, 2, SF_two); \
+    TEST_EXP(sf, w, -2, SF_neg_two); \
+    TEST_EXP(sf, w, 16777217, raw_sf((float)16777216)); /* rounds DOWN */ \
+    TEST_EXP(sf, w, 16777219, raw_sf((float)16777220)); /* rounds UP */ \
+})
+
+int main(void)
+{
+    test_vcvt_uh_hf();
+    test_vcvt_h_hf();
+    test_vcvt_ub_hf();
+    test_vcvt_b_hf();
+    test_vconv_w_sf();
+    test_vconv_sf_w();
+    test_vconv_h_hf();
+    test_vconv_hf_h();
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index afd3dd6d19..1abc5f2124 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += fp_hvx
+HEX_TESTS += fp_hvx_cvt
 HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
@@ -132,6 +133,8 @@ fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
 fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
 fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
 fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
+fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
 
 run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
-- 
2.37.2


