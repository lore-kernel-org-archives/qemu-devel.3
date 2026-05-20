Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F419DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjUJ-0002gF-5w; Wed, 20 May 2026 12:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUE-0002AR-Ns; Wed, 20 May 2026 12:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjUB-0002zD-JX; Wed, 20 May 2026 12:09:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDW9Jj3919898; Wed, 20 May 2026 16:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=u5MC7A
 izQ88nBfuTCGAnF80TtUO1/Pi0Fa07i9AQQqk=; b=QtmixvkWeaI/P6uYGnJA2A
 /PKnmUssc53q5B5h3Y5i2p4WUT/q+gHY89tHlT+6PxrDXRMpMeFHfnliOohcbgIg
 VtzjTmZ/uBF5jeEI9zFEp5iUZO8ukVMoRAVaqZmHfKL5wkb3v2YYTmtHD73J1kGf
 EyfXf1k67MD+VSfya+5RkGMmreHhbgjxTKSB9jdniCPa8PwgpizwKTVyhvS/xMxo
 y32seGqldN9TLCUkLYpwSzEY4AkSfaFLffzvFdYni0nN09zQA6NgOL68jP904rXB
 T9+a3dQVJqE44CXv5JgpmlJGrqip+73fB6/R/MolU9jA64TJarGpF7CzAOlxxrPg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mtwcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KG9B9l025915;
 Wed, 20 May 2026 16:09:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7tsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG9NxP11993462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:09:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C93BA20043;
 Wed, 20 May 2026 16:09:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E9A420040;
 Wed, 20 May 2026 16:09:18 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:09:18 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 16/28] target/ppc: Fix TRANS* macro variadic arguments
 handling
Date: Wed, 20 May 2026 21:37:16 +0530
Message-ID: <20260520160728.2283628-17-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: G-JZ-9dthBOLRlLJRiA0ztM__rY9pYlU
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0ddcb9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CtCGoDGENXNllPNDbDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EL0LBdu3T2Hi4_s2ZE90nbuLHKOlgdsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX8WFkzpD4p6zg
 H2xbC3+jCr4Cxdg+M5U61z1Xw80NIY2vx0XruegDF9RSdjkdGX+DcnDK+jXpLk/2MFNCenr2xL1
 OZ1fIcilnM4Hiizp2d7bKoex08DPD6Er+ukDg6fy6HK4FY6RIl0JMb5nSUDQoO9l+DhUWDAUbxn
 O8W7uO0zKPDu9EPkHw7/Lil3vPp0oJhEgnyRXe0Ub8288hNHHC3EROVQ3TlXJSyNJ0nPmDz+iPx
 6iNFRtkflnupZL3q553NwueSv1M0vD9VAA4nni+ZVXtW4fK8o2aYMeIa5Q+NlRfW6RFgV3QSem3
 ODffnOLcqaTpSV8N7gKdnzl7ev7CupgDATMeFJqPb3XREWcai/3GH2Pi/nFBMZdyIyEzzG5SHcK
 KCKUhiZr8wK7ZGY1TaXdZYBrFAXzQxrSc3IWiOS/qYZqczWtpFeXny0x5oa0fFnwzbPaGkPhuzb
 c72T7kLlvw9EI8vAhWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Use ##__VA_ARGS__ in TRANS* macros to allow variadic arguments to be
optional instead of mandatory. "##" removes the preceding comma when
__VA_ARGS__ is empty, enabling macros to work with functions that don't
need extra parameters.

This avoid compilation errors when using a pattern like below:

  static bool do_wait(DisasContext *ctx, arg_X_wait *a)
  {...}

  TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)

Compilation Error:
../target/ppc/translate.c:5526:40: error: expected expression before ‘)’ token
 5526 |         return FUNC(ctx, a, __VA_ARGS__);                      \
      |                                        ^
../target/ppc/translate/storage-ctrl-impl.c.inc:368:1: note: in expansion of macro ‘TRANS_FLAGS’
  368 | TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 22125c30a5..a8ee87ffe2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4719,29 +4719,29 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
  */
 #define TRANS(NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
-    { return FUNC(ctx, a, __VA_ARGS__); }
+    { return FUNC(ctx, a, ##__VA_ARGS__); }
 #define TRANS_FLAGS(FLAGS, NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     {                                                          \
         REQUIRE_INSNS_FLAGS(ctx, FLAGS);                       \
-        return FUNC(ctx, a, __VA_ARGS__);                      \
+        return FUNC(ctx, a, ##__VA_ARGS__);                    \
     }
 #define TRANS_FLAGS2(FLAGS2, NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     {                                                          \
         REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
-        return FUNC(ctx, a, __VA_ARGS__);                      \
+        return FUNC(ctx, a, ##__VA_ARGS__);                    \
     }
 
 #define TRANS64(NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
-    { REQUIRE_64BIT(ctx); return FUNC(ctx, a, __VA_ARGS__); }
+    { REQUIRE_64BIT(ctx); return FUNC(ctx, a, ##__VA_ARGS__); }
 #define TRANS64_FLAGS2(FLAGS2, NAME, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
     {                                                          \
         REQUIRE_64BIT(ctx);                                    \
         REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
-        return FUNC(ctx, a, __VA_ARGS__);                      \
+        return FUNC(ctx, a, ##__VA_ARGS__);                    \
     }
 
 /* TODO: More TRANS* helpers for extra insn_flags checks. */
-- 
2.53.0


