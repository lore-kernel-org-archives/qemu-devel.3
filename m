Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E545606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UCCU8Ot5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBi-0007jA-0Q; Thu, 29 Oct 2026 13:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006po-1D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bK-Mi
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDFpW542882; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IWjAvbuhIju
 2pS6mfy7cPObqF8c3QSNsJ/J5Phf6GaI=; b=UCCU8Ot5/wxKmCp7oM9XYCmnh8h
 l2Sr9XFhR1d3HON+yk8Tr4lcBD21yLcnszPbOlBPt+UoJC3e4pWnHMAgj5XCkB89
 CwmP4MNcL9FSnGOdzCbwxYQlwxN3vXmd5DWw5WQm6BCEUsI6Lz0DlJGfP6a1rEq/
 hTgYZW1knE4pA8Qk/M/OW+JUiLR9ouvJhe4dttPNVi77gu9aLLNjylOm4/U734WI
 tod4bXjd7ANxBxpGF5p4+oH83u1TgPMFlpHiufj0vevU03ldQXbkXmF7ypIy+syO
 b2/zzNpTYYSJTMHV44xWEwgu6PDOrHlAWP7jFUQ2jat1EoCK82xT+T8k5vQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshuu8q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEQh2488375; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69THiDeu2488356
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:13 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 775B925820; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 03/20] target/hexagon: add an HLX instruction trace event
Date: Thu, 29 Oct 2026 10:43:56 -0700
Message-ID: <20261029174413.643130-4-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: xqPFd3o3eO_nwAQsOU0QP-cwtPaKSujm
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=kG8h4ji0q1-BL0gdWnkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX4ZRMY6ueRd8I
 0mBTxao7hLfzJcDylVq2Ql+yJQj+u+RwMnhzFK7/0DA+tsgGOeOV9+fZXN3kN0q5C9ndSgYYIZx
 nDrlW1tArV2Uch12IZsnHk5TILUHZ/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX6lkDxfUm/BKE
 lNm6mSWP39JY6xE2BtLwYEppdMwpwVGTtGJXhjW06CJL0yWnWr2G8pk/LF+bYzev+VN7makUAXW
 OCsDLZvOjcMdn8YwCp8v8FlZZf6XONhamsvXnjLg2fywActRrg3xjUghyEvolOrcp42YaSzf47t
 3b/jfI2s0MFd2erwr8WtCPx//DazHv1zdqZBeMtD1KPGANSKjHh95JVGaUd0gH+D0mZmn/PJgqG
 0rs+Jl2hdWZ/BEqY9txU+AYJ3xfDGgbiCIWHY5us1zaST1CHYf8tVaPckFQ83nTmUIio8yXKQ3B
 5DStzTc+fHrIxnwD4YJVb0u6vh8gMPixQL96cdn6TPyOAckWKFmYhAmQ/hoextIkPyLeIB27Viw
 DeuLguzU+hjp3u6ztVuwuf+AOWmbLQ==
X-Proofpoint-ORIG-GUID: xqPFd3o3eO_nwAQsOU0QP-cwtPaKSujm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a trace event that reports the executed HLX opcode and name.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 meson.build                 | 1 +
 target/hexagon/helper.h     | 3 +++
 target/hexagon/op_helper.c  | 7 +++++++
 target/hexagon/trace-events | 6 ++++++
 target/hexagon/trace.h      | 2 ++
 5 files changed, 19 insertions(+)
 create mode 100644 target/hexagon/trace-events
 create mode 100644 target/hexagon/trace.h

diff --git a/meson.build b/meson.build
index 7ec3fb9023..71f135f053 100644
--- a/meson.build
+++ b/meson.build
@@ -3695,6 +3695,7 @@ if have_system or have_user
     'target/arm',
     'target/arm/hvf',
     'target/arm/tcg',
+    'target/hexagon',
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 8a2a6563d2..245cd50b89 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -31,6 +31,9 @@ DEF_HELPER_FLAGS_4(vacsh_pred, TCG_CALL_NO_RWG_SE, s32, env, s64, s64, s64)
 DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
 
+/* HLX helpers */
+DEF_HELPER_FLAGS_2(hlx_trace_op, TCG_CALL_NO_RWG, void, env, i32)
+
 /* Floating point */
 DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
 DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 477c8d6b66..27106fe1ad 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -37,8 +37,10 @@
 #include "mmvec/mmvec.h"
 #include "mmvec/macros.h"
 #include "op_helper.h"
+#include "opcodes.h"
 #include "cpu_helper.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "trace.h"
 #include "translate.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu/timer.h"
@@ -68,6 +70,11 @@ uint64_t HELPER(utimer)(void)
 }
 #endif
 
+void HELPER(hlx_trace_op)(CPUHexagonState *env, uint32_t opcode)
+{
+    trace_hexagon_hlx_op(opcode, opcode_names[opcode]);
+}
+
 #define SF_BIAS        127
 #define SF_MANTBITS    23
 
diff --git a/target/hexagon/trace-events b/target/hexagon/trace-events
new file mode 100644
index 0000000000..4235dc6ac2
--- /dev/null
+++ b/target/hexagon/trace-events
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See docs/devel/tracing.rst for syntax documentation.
+
+# HLX instruction tracing
+hexagon_hlx_op(int opcode, const char *name) "opcode: 0x%x (%s)"
diff --git a/target/hexagon/trace.h b/target/hexagon/trace.h
new file mode 100644
index 0000000000..e886ce0b63
--- /dev/null
+++ b/target/hexagon/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-target_hexagon.h"
-- 
2.43.0


