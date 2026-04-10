Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6537AF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5u-0006st-B8; Fri, 10 Apr 2026 13:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5r-0006rp-Ri
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5l-0001fy-To
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AHCWOV1498619
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uJr3Gr7KYqM
 D1GbUrDqXbuYTqiUZbXBU2TT7eZ+R0bU=; b=LUBhVcow3SfebGVdOMUPsrgMYL3
 KlvZPMg5IvixRVasUaxEtFdtr9ezgw14N1FTohfUyWGRZ1AT9Qo1Tg6Z/ZWqtgxw
 49NMhS27mPcIrhFE05O2qxdPmZPrtP3friULdhx2caFXXpGMCRAr2w9K5THzN68m
 GJ++WPm9cG08QF3zaP2BwkHZHG7NBjPp1o8YzGQ5qcS6xskvDZrDJ1l9fCZ+Se1N
 VkTpr4GHKHIyvZBn0d6hjTo9nMDFOoLWbtovu9VqvNQSsm1kQmP9KGGgCj3PA+QP
 ZWspA5mq0mWSZPwyyP87Vtxc/nEPjnjrC2yNaLu1GG27qIzIohbgC/kVteQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b1ctf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:21 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1275c6fc58aso2785960c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843781; x=1776448581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJr3Gr7KYqMD1GbUrDqXbuYTqiUZbXBU2TT7eZ+R0bU=;
 b=cKs0wqYyej8rCJAN22iFM6lsVb+3Q3DWs3rmYxYy2aGPfxyvtBaTJbJRuSTIhFLgSx
 0iVkxrkEp+PaqcUnOsSKPB+b7dNYGilg4uaVOFDuZl2XkdiOQgI6pulPV15vJPlOgMXd
 gUTYkSeiDu8mxxeDCGQFsl4XHb4PRl8Bqhi6e1jKHwGVjtyXh31WfHK/yQKPucHcDuBj
 Xi8Jc9d/1uN7kZqUItH/XpnCD7Yf0w2/2pMkw7H0x6b27KQ2ufHZtSQG2uLp6B/42msz
 SP4/JziopMfZIei4hPaVk6dmYFIj6SFHbbwkjoRpJcydOsRat1ip+wbw1YBhCIAgtjun
 zVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843781; x=1776448581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uJr3Gr7KYqMD1GbUrDqXbuYTqiUZbXBU2TT7eZ+R0bU=;
 b=fgnFnsqbAJ/xEQhz/TT8qsSxNcg6rXHrVHe1/8lMh7/jGRsU63JwizBeN31OqY+Wop
 UrQHt8laIPtkK46GiG0Jf/P3ivteFDVpz3FfsvoWKa0a3Exr7Olq5O0cs17ERPD/AKcY
 +PS4QNwqp2ZMf/mbJFFNY3wMmOChoY9Ji6ShiPK+m/0h4zQplMptAZ7A2wGiYhbPULo7
 cK9HlGxbyHMswyQ5glKjlhEzA11uKmtPdXulnae+IbjTtA7XyM2mnFIFPHX8S4vmncvT
 jDjPEPR2xd9gVTq4ZLc1oRV7vIrkL4hfbqAGR6yiIXCw0ZP/XqhhJaYug1o6gDPKXtdv
 bBYQ==
X-Gm-Message-State: AOJu0YxQQi3M7ipp12SiFePaNcsIHLND5S1usr3iTEIHKc2mxYDViWpb
 NMmVqnp2S3yCFlWtv1ORlNi7JyXOmHr8E/C7Dn49CqJBE60ovgjLtl61LQDd0oKBQXjz62P1oOT
 0Mgy60bEPXxUAINV3HEV82LG9JwqdUV+1vfzzhSBzpGqAR2GNog5Dkmmq755lwGCvlH7g
X-Gm-Gg: AeBDietbOU4Eut1DaPjWfmC1cJ5FXd/mQMRPXOPSZoyp0pkpIo4RozafhVx+vQAkuZp
 a8q04N4rCsl2awuYCN8ecFe9W9hprP8/Xquc2S2Sp0OBlb+2Mi4pl7KeLSd8eoGkADGx+OvJp++
 RuovUjEnmiSZKrIat/Y5mw4aty/8BDcMmNIz3bANQU9I488v9UzNTy1klMdklSewm+QjYur7+T0
 qa4X8uMpGCUnOyueMoHM+ua12E0CpyoR4qC3ni8E6ptcHWqLoWvswESbx6oHyNnt9nqmrVLvfWX
 yzrZ/E0/EngwGBOjC5rMcj6GC98ZVnHN6yz4hKYT85xg2xH4pAzKefOBgta557NF3sjO8YF17Ov
 RUzmHaN7mY/hfSMkS4AVURfgv2eic01B2uIQTRSiubdbgwQH2Xnt7zg1VnCoum7IIaCxMVlsEiD
 +erQney9Nd
X-Received: by 2002:a05:7022:60a:b0:128:d5bd:3572 with SMTP id
 a92af1059eb24-12c34ef7ba4mr2290823c88.31.1775843780467; 
 Fri, 10 Apr 2026 10:56:20 -0700 (PDT)
X-Received: by 2002:a05:7022:60a:b0:128:d5bd:3572 with SMTP id
 a92af1059eb24-12c34ef7ba4mr2290795c88.31.1775843779771; 
 Fri, 10 Apr 2026 10:56:19 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:19 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 12/16] tests/hexagon: add tests for v68 HVX IEEE float
 arithmetics
Date: Fri, 10 Apr 2026 10:56:00 -0700
Message-Id: <cde613d444deb76f6b746b9ecb7329f0b559f590.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: goZavrmZNXHG3dA0Loejz3sIZKjzG2ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX1okpwCJFGhEq
 9TUx0/MBZW4MfF+UpTxXm20l7nPyQo2N19brDKegeYlzQHqPzVG6hiIScOcWJwobnNOasdoyggR
 uI1UQahXXH3a0Qoe1mNotHyJ92MwT9Zlij58rYxRixtREklY+iCOagyjM9eiqyrxP6tSuIvWq17
 2o/Ck52DUlRScKnrcv02RdW2iCoRhE+c5uZRWtjXMBXEBU0SCMKMyBxAH6JmUyCv5xoGQz/HjA6
 IG3CQYeRl9fnLuw5TRibKUvdfubxf5IbizeqdDfDNzsYkEt73T1KO/jVT+ttiNP6m5w1lVUKsMR
 8ePOyP4uXSwsAZkhY/m4x1ZDvcu+Fsea6IQmONre1Kq3sXtmO0J8xeuTCKHfYQlrIuOAT7Wo5kt
 T1zxIyqaQG3w/Hnin12WffEZ9GuKEPwHwmaykqoOF4gx9GU565DacVzep2Xg349oE06OmCEhaQm
 qlqwxm6ik8xeN8m0ODg==
X-Proofpoint-GUID: goZavrmZNXHG3dA0Loejz3sIZKjzG2ob
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d939c5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=p626gilfWeCCYUnsPZkA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100168
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
 tests/tcg/hexagon/hex_test.h        |   4 +
 tests/tcg/hexagon/hvx_misc.h        |  41 ++++++++
 tests/tcg/hexagon/fp_hvx.c          | 155 ++++++++++++++++++++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c |  57 ++++++++++
 tests/tcg/hexagon/Makefile.target   |   8 ++
 5 files changed, 265 insertions(+)
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index cfed06a58b..e7a6644d41 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -19,6 +19,8 @@
 #ifndef HEX_TEST_H
 #define HEX_TEST_H
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 static inline void __check32(int line, uint32_t val, uint32_t expect)
 {
     if (val != expect) {
@@ -110,6 +112,7 @@ static inline void __check64_ne(int line, uint64_t val, uint64_t expect)
 
 /* Some useful floating point values */
 const uint32_t SF_INF =              0x7f800000;
+const uint32_t SF_INF_neg =          0xff800000;
 const uint32_t SF_QNaN =             0x7fc00000;
 const uint32_t SF_QNaN_special =     0x7f800001;
 const uint32_t SF_SNaN =             0x7fb00000;
@@ -128,6 +131,7 @@ const uint32_t SF_large_pos =        0x5afa572e;
 const uint32_t SF_any =              0x3f800000;
 const uint32_t SF_denorm =           0x00000001;
 const uint32_t SF_random =           0x346001d6;
+const uint32_t SF_neg_two =          0xc0000000;
 
 const uint64_t DF_QNaN =             0x7ff8000000000000ULL;
 const uint64_t DF_SNaN =             0x7ff7000000000000ULL;
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 2e868340fd..0330cb289d 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -18,6 +18,8 @@
 #ifndef HVX_MISC_H
 #define HVX_MISC_H
 
+#include "hex_test.h"
+
 static inline void check(int line, int i, int j,
                          uint64_t result, uint64_t expect)
 {
@@ -34,8 +36,10 @@ typedef union {
     uint64_t ud[MAX_VEC_SIZE_BYTES / 8];
     int64_t   d[MAX_VEC_SIZE_BYTES / 8];
     uint32_t uw[MAX_VEC_SIZE_BYTES / 4];
+    uint32_t sf[MAX_VEC_SIZE_BYTES / 4]; /* convenience alias */
     int32_t   w[MAX_VEC_SIZE_BYTES / 4];
     uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
+    uint16_t hf[MAX_VEC_SIZE_BYTES / 2]; /* convenience alias */
     int16_t   h[MAX_VEC_SIZE_BYTES / 2];
     uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
@@ -63,7 +67,9 @@ static inline void check_output_##FIELD(int line, size_t num_vectors) \
 
 CHECK_OUTPUT_FUNC(d,  8)
 CHECK_OUTPUT_FUNC(w,  4)
+CHECK_OUTPUT_FUNC(sf, 4)
 CHECK_OUTPUT_FUNC(h,  2)
+CHECK_OUTPUT_FUNC(hf, 2)
 CHECK_OUTPUT_FUNC(b,  1)
 
 static inline void init_buffers(void)
@@ -81,6 +87,33 @@ static inline void init_buffers(void)
     }
 }
 
+static const uint32_t FP_VALUES[] = {
+    SF_INF, SF_INF_neg, SF_QNaN, SF_QNaN_special, SF_SNaN, SF_QNaN_neg,
+    SF_SNaN_neg, SF_HEX_NaN, SF_zero, SF_zero_neg, SF_one, SF_one_recip,
+    SF_one_invsqrta, SF_two, SF_four, SF_small_neg, SF_large_pos, SF_any,
+    SF_denorm, SF_random, SF_neg_two,
+};
+#define FP_VALUES_MAX ARRAY_SIZE(FP_VALUES)
+
+static inline void init_buffers_fp(void)
+{
+    _Static_assert(BUFSIZE * (MAX_VEC_SIZE_BYTES / 4) >
+                   FP_VALUES_MAX * FP_VALUES_MAX,
+                   "test arrays can't fit all FP_VALUES combinations");
+    int counter1 = 0, counter2 = 0;
+    for (int i = 0; i < BUFSIZE; i++) {
+        for (int j = 0; j < MAX_VEC_SIZE_BYTES / 4; j++) {
+            buffer0[i].sf[j] = FP_VALUES[counter1];
+            buffer1[i].sf[j] = FP_VALUES[counter2];
+            counter2++;
+            if (counter2 == FP_VALUES_MAX) {
+                counter2 = 0;
+                counter1 = (counter1 + 1) % FP_VALUES_MAX;
+            }
+        }
+    }
+}
+
 #define VEC_OP1(ASM, EL, IN, OUT) \
     asm("v2 = vmem(%0 + #0)\n\t" \
         "v2" #EL " = " #ASM "(v2" #EL ")\n\t" \
@@ -175,4 +208,12 @@ static inline void test_##NAME(bool invert) \
     check_output_b(__LINE__, BUFSIZE); \
 }
 
+#define float_sf(x) ({ typeof(x) _x = (x); *((float *)&(_x)); })
+#define float_hf(x) ({ typeof(x) _x = (x); *((_Float16 *) &(_x)); })
+#define raw_sf(x) ({ typeof(x) _x = (x); *((uint32_t *)&(_x)); })
+#define raw_hf(x) ({ typeof(x) _x = (x); *((uint16_t *)&(_x)); })
+#define float_hf_to_sf(x) ((float)x)
+#define bytes_hf 2
+#define bytes_sf 4
+
 #endif
diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
new file mode 100644
index 0000000000..a309654ed7
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx.c
@@ -0,0 +1,155 @@
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
+int err;
+#include "hvx_misc.h"
+
+#if __HEXAGON_ARCH__ > 75
+#error "After v75, compiler will replace some FP HVX instructions."
+#endif
+
+/******************************************************************************
+ * NAN handling
+ *****************************************************************************/
+
+#define isnan(X) \
+     (sizeof(X) == bytes_hf ? ((raw_hf(X) & ~0x8000) > 0x7c00) : \
+                              ((raw_sf(X) & ~(1 << 31)) > 0x7f800000UL))
+
+#define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))
+#define NAN_SF float_sf(0x7FFFFFFF)
+#define NAN_HF float_hf(0x7FFF)
+
+/******************************************************************************
+ * Binary operations
+ *****************************************************************************/
+
+#define DEF_TEST_OP_2(vop, op, type_res, type_arg) \
+    static void test_##vop##_##type_res##_##type_arg(void) \
+    { \
+        memset(expect, 0xff, sizeof(expect)); \
+        memset(output, 0xff, sizeof(output)); \
+        for (int i = 0; i < BUFSIZE; i++) { \
+            HVX_Vector *hvx_output = (HVX_Vector *)&output[i]; \
+            HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[i]; \
+            HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[i]; \
+            *hvx_output = \
+                Q6_V##type_res##_##vop##_V##type_arg##V##type_arg(hvx_buffer0, \
+                                                                  hvx_buffer1); \
+            for (int j = 0; j < MAX_VEC_SIZE_BYTES / bytes_##type_res; j++) { \
+                expect[i].type_res[j] = \
+                    raw_##type_res(op(float_##type_arg(buffer0[i].type_arg[j]), \
+                                      float_##type_arg(buffer1[i].type_arg[j]))); \
+            } \
+        } \
+        check_output_##type_res(__LINE__, BUFSIZE); \
+    }
+
+#define SUM(X, Y, DEF_NAN) CHECK_NAN((X) + (Y), DEF_NAN)
+#define SUB(X, Y, DEF_NAN) CHECK_NAN((X) - (Y), DEF_NAN)
+#define MULT(X, Y, DEF_NAN) CHECK_NAN((X) * (Y), DEF_NAN)
+
+#define SUM_SF(X, Y) SUM(X, Y, NAN_SF)
+#define SUM_HF(X, Y) SUM(X, Y, NAN_HF)
+#define SUB_SF(X, Y) SUB(X, Y, NAN_SF)
+#define SUB_HF(X, Y) SUB(X, Y, NAN_HF)
+#define MULT_SF(X, Y) MULT(X, Y, NAN_SF)
+#define MULT_HF(X, Y) MULT(X, Y, NAN_HF)
+
+DEF_TEST_OP_2(vadd, SUM_SF, sf, sf);
+DEF_TEST_OP_2(vadd, SUM_HF, hf, hf);
+DEF_TEST_OP_2(vsub, SUB_SF, sf, sf);
+DEF_TEST_OP_2(vsub, SUB_HF, hf, hf);
+DEF_TEST_OP_2(vmpy, MULT_SF, sf, sf);
+DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
+
+/******************************************************************************
+ * Other tests
+ *****************************************************************************/
+
+static void test_vdmpy_sf_hf(bool acc)
+{
+    memset(expect, 0xff, sizeof(expect));
+
+    for (int i = 0; i < BUFSIZE; i++) {
+        HVX_Vector hvx_buffer0 = *(HVX_Vector *)&buffer0[i];
+        HVX_Vector hvx_buffer1 = *(HVX_Vector *)&buffer1[i];
+        HVX_Vector *hvx_output = (HVX_Vector *)&output[i];
+
+        uint32_t PREFIL_VAL = 0x111222;
+        *hvx_output = Q6_V_vsplat_R(PREFIL_VAL);
+
+        if (!acc) {
+            *hvx_output = Q6_Vsf_vdmpy_VhfVhf(hvx_buffer0, hvx_buffer1);
+        } else {
+            *hvx_output = Q6_Vsf_vdmpyacc_VsfVhfVhf(*hvx_output, hvx_buffer0,
+                                                    hvx_buffer1);
+        }
+
+        for (int j = 0; j < MAX_VEC_SIZE_BYTES / 4; j++) {
+            float a1 = float_hf_to_sf(float_hf(buffer0[i].hf[2 * j + 1]));
+            float a2 = float_hf_to_sf(float_hf(buffer0[i].hf[2 * j]));
+            float a3 = float_hf_to_sf(float_hf(buffer1[i].hf[2 * j + 1]));
+            float a4 = float_hf_to_sf(float_hf(buffer1[i].hf[2 * j]));
+            /*
+             * Note, IEEE FP specifies +0.0 + -0.0 == +0.0. So we use -0.0 in
+             * the default case to preserve the zero sign.
+             */
+            float prev = acc ? float_sf(PREFIL_VAL) : -0.0;
+            expect[i].sf[j] = raw_sf(CHECK_NAN((a1 * a3) + (a2 * a4) + prev, NAN_SF));
+        }
+    }
+    check_output_sf(__LINE__, BUFSIZE);
+}
+
+static void test_new(void)
+{
+    asm volatile("r0 = #%2\n"
+                 "v0 = vsplat(r0)\n"
+                 "vmem(%1 + #0) = v0\n"
+                 "r1 = #%3\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "{\n"
+                 "  v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "  vmem(%0 + #0) = v0.new\n"
+                 "}\n"
+                 :
+                 : "r"(output), "r"(expect), "i"(SF_two), "i"(SF_one)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+    check_output_w(__LINE__, 1);
+}
+
+int main(void)
+{
+    init_buffers_fp();
+
+    /* add/sub */
+    test_vadd_sf_sf();
+    test_vadd_hf_hf();
+    test_vsub_sf_sf();
+    test_vsub_hf_hf();
+
+    /* multiply */
+    test_vmpy_sf_sf();
+    test_vmpy_hf_hf();
+
+    /* dot product */
+    test_vdmpy_sf_hf(false);
+    test_vdmpy_sf_hf(true);
+
+    test_new();
+
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c b/tests/tcg/hexagon/fp_hvx_disabled.c
new file mode 100644
index 0000000000..388a42e2b7
--- /dev/null
+++ b/tests/tcg/hexagon/fp_hvx_disabled.c
@@ -0,0 +1,57 @@
+/*
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <hexagon_types.h>
+#include <hvx_hexagon_protos.h>
+
+int err;
+#include "hvx_misc.h"
+
+static void test_disabled(void)
+{
+    memset(output, 0xAA, sizeof(output));
+    memset(expect, 0, sizeof(expect));
+    asm volatile("r0 = #0xff\n"
+                 "v0 = vsplat(r0)\n"
+                 "r1 = #0x1\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "vmem(%0 + #0) = v0\n"
+                 :
+                 : "r"(output)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+    check_output_w(__LINE__, 1);
+}
+
+static void test_disabled_with_new(void)
+{
+    memset(output, 0xAA, sizeof(output));
+    memset(expect, 0, sizeof(expect));
+    asm volatile("r0 = #0xff\n"
+                 "v0 = vsplat(r0)\n"
+                 "r1 = #0x1\n"
+                 "v1 = vsplat(r1)\n"
+                 "v2 = vsplat(r1)\n"
+                 "{\n"
+                 "    v0.sf = vadd(v1.sf, v2.sf)\n"
+                 "    vmem(%0 + #0) = v0.new\n"
+                 "}\n"
+                 :
+                 : "r"(output)
+                 : "r0", "r1", "v0", "v1", "v2", "memory");
+    check_output_w(__LINE__, 1);
+}
+
+int main(void)
+{
+    test_disabled();
+    test_disabled_with_new();
+    puts(err ? "FAIL" : "PASS");
+    return err ? 1 : 0;
+}
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 549c95082f..afd3dd6d19 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -50,6 +50,8 @@ HEX_TESTS += vector_add_int
 HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
+HEX_TESTS += fp_hvx
+HEX_TESTS += fp_hvx_disabled
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
 HEX_TESTS += multiple-writes
@@ -126,6 +128,12 @@ v68_hvx: CFLAGS += -mhvx -Wno-unused-function
 v69_hvx: v69_hvx.c hvx_misc.h
 v69_hvx: CFLAGS += -mhvx -Wno-unused-function
 v73_scalar: CFLAGS += -Wno-unused-function
+fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
+fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
+fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
+fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
+
+run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
-- 
2.37.2


