Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFE4CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ai-0001PD-Ie; Wed, 14 Oct 2026 17:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ag-0001Ol-SX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Af-0000iT-2O
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4DZB4167044
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=paWdih5wsu4
 pFa0HzwbRdAAtDgAq79AZwmjuzoUSo+I=; b=W95hHOpeGnlmo3x5AmJISTj3hSh
 gzDMPmPBy16v1XCQgg/jOO27O5lpjr9TgR3CL1fdivEFvm6VqPCZljF/qCxwXqvn
 f0dIssB20zTa7Fob8UmgcdhQql7Weh6e/y1lmsMJWsfupN1eLrfO3PCds0AuB0aL
 mzUswyn0MMJuFLJhYHcB5XnYdoe/VFbnXv0Fy4LZQQqe/EX9G/n1ODHd0MkIvCeF
 gyXgwViEJrCmKQ1IP3/XaJxfHjaHVZL1ngL3KElyUkLSE3oCtZY2NAqBo8UG6H4f
 76ojscW7J+15u8TROON0rN9hyga8iCEHGbVeLrZtKrHc+JoM72fgw0pPRUw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac231bgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso11982584eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011955; x=1792616755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=paWdih5wsu4pFa0HzwbRdAAtDgAq79AZwmjuzoUSo+I=;
 b=LBo58gdxkMld7ZJrBXIZLL8AmYmTooHBfm2CxF9xY2iFi8vFcvyRwqYCnbF5qLUryO
 UcBoNFaVs9WjpEZcBuho5HkTATtOjj3QtjMwXmOcbN/rmyR1S7/rd41LX1+1btJIhhFV
 ZqnlkxWK2BPBfb8Xr2DG7QbT2pwm1z2cflpNadMJmZ6rAWrp8oqxN1SO5g09JPIyeuOv
 XUUQ8Z1w2rI4eMU5Tt0ZJ+FN8k98opxgiZxcDElXl66XCusFOpNujNktTp5Tx7WcKrF3
 QvVgyUWtSgOvzPH2tSCCFe/A7Q+82heXnwY0TP9VRHp3Z6csCxBavlOw5ls6lkCrHnLD
 aX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011955; x=1792616755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=paWdih5wsu4pFa0HzwbRdAAtDgAq79AZwmjuzoUSo+I=;
 b=NF/d2TQXsHBhiMmNvIsqcFh8LXjBH1zOQW4qjhchJCzCo33ZfkrMpDqX2cAxfF1yfT
 IqJs3g5Fu10NcRspi5N7/mNE69P3aCB2GA5XEUEb+V1cVx6BEAWu1xDvnsl1i+XfMIOm
 +E0wiWVah3E1Nj03TgEPrWwLChedJAXFl6b2ZOAomNnhtYQtjKE2Mjg8YjEhYnB98TfT
 jCRxPyWhFqtePF0KkZ9bEpsElDzT9/hOMpv79JUCd9yeWpJvMUROGWFjmmJLBhMM4VBD
 ilRw3cGq9UGbiVLAS3ZFM9RMWbwVQPXW49tcoC/8Wp+boJtdIyUkKN1xSfEcaYQ+k//Q
 umtg==
X-Gm-Message-State: AFq9FYIa9JyAUk5ckSQg2giPjwPwCrd0LO6+DDvln6e6XGENuGCAzWhK
 pKYVmmmohBHf895mGYEjIpmWQUr8snN8Y3rz35VfJXaZZTSl5qptGlSFBV+iliMIGRYtHxsOhqk
 kJtZlCbI3xR+jH9SgckZaX+wmIZ6Xk7a7+GsdQ23sutpH5Eha8WEJ1bQVtzUM99ufiQ==
X-Gm-Gg: AYBFou2+gff5U5rtGOTGoXWS/oOUYc0L/TB0gTKcR2gYl02b4qde4iEfhGCjDyu1W1q
 qWLkSs3Ed+EqGmLCbNmLJDpcMc8/qAq4KilSpM0qZkdMW+spwWxyBOxuMVXD3a7redm6h9yevaZ
 NMb2RRG7qB4xt7wYqN8vKNT+G6nDDWtofIDNDLG56mdemfY9MDICJAzajfqh+vAr9qeWsSIL0xr
 R044FZGzlLUz90Q5X1wlWuhFMVqIKoxa5ElletWZuz6b3lVRWP79WQ8csplKh1LE7p9mwAoFSul
 +/fKMeZoA1aRNOgXSSka2ILZc2noPh0Wbw8SmiwNvWwTd1jPmjDVvi348LCcxxnLDQEiNdLCmY0
 gMZ4UzFgC+hxvk16XagX5L2pIgM3aNxyVbYqOrhTvldX+jzvzEOrajqtgaEQs
X-Received: by 2002:a05:7300:3c8f:b0:35c:8abb:b4ae with SMTP id
 5a478bee46e88-35c8abbb713mr8330055eec.25.1792011954617; 
 Wed, 14 Oct 2026 14:05:54 -0700 (PDT)
X-Received: by 2002:a05:7300:3c8f:b0:35c:8abb:b4ae with SMTP id
 5a478bee46e88-35c8abbb713mr8330002eec.25.1792011953218; 
 Wed, 14 Oct 2026 14:05:53 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 08/12] target/hexagon: declare semihosting ops
Date: Wed, 14 Oct 2026 21:05:22 +0000
Message-ID: <20261014210526.104215-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfeeb3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=RKMH5O5a7-KqqQVN41YA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX9Vc9DrySEv7M
 PmU5mjW/fzz47AQXY4MWf7IlU7SCRCO6QfV/QqTxXcHuL5UbvPHjcBce1OuGx2WBak9Wk3pABxR
 mC+SIJp6c35IczbfW6u/vZn5r/ivoZo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX0z52FS0DxHuH
 9NDJj0U1ZqErhb2JAOEGvooSXEwLFrjFHB1gCmq7foQwlvJDS6xLeNFpd7c4pnY+4jRx6fcBtzD
 aV2kMYVepnF+RieuQvSIqlGTBh+YRbhq0QtiXF4fn96wa+s8MkT690i4iSKmK8zVnIvuwOgeju1
 o+/AEZc7TAuxoSTgedho/VnMynWORgCM6SbgG441ih+iG5Bs7zdLq0FM0fGPm8Yn5mJngv5cxhB
 SMnK+Nqo0tiBodJra6wopULoXGJ8TqJioKO/gsh+SZLzHDGP9KfhKnqKcXWSyBY91Tg4kCTeHbP
 D8Re0ZMVsnI5WlcKfChF4jOFpeUvxmjOHjPurWzUtoIH0re4Q6Ey82ztQ+Q2RLZ6BWSTfp8+Hee
 wJGyBSfe+SbebWi+B8acPAq83z34iIBv/TKVLSYwGIkZ/43dWBNJEPvv9WRVLrRVKSav/3tBpKk
 uAkgezxYLMQ4aGZ/h4w==
X-Proofpoint-GUID: 9zC4Uz3fwXN2kl7YvIKXZu-ZKN-LOG8L
X-Proofpoint-ORIG-GUID: 9zC4Uz3fwXN2kl7YvIKXZu-ZKN-LOG8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
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

For now, we keep the global common_* symbols defined.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/common-semi-target.c | 65 ++++++++++++++++++++++++-----
 target/hexagon/cpu.c                |  2 +
 target/hexagon/internal.h           |  2 +
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index 210d33e54e2..da92ff298a2 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -8,44 +8,89 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "cpu_helper.h"
 #include "semihosting/common-semi.h"
+#include "internal.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t hexagon_semi_arg(const CPUState *cs, int argno)
 {
-    CPUHexagonState *env = cpu_env(cs);
+    const CPUHexagonState *env = cpu_env(cs);
     return env->gpr[HEX_REG_R00 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void hexagon_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R00] = ret;
 }
 
-void common_semi_set_err(CPUState *cs, int err)
+static void hexagon_semi_set_err(CPUState *cs, int err)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R01] = err;
 }
 
-bool common_semi_sys_exit_is_extended(CPUState *cs)
+static bool hexagon_semi_is_64bit(const CPUState *cs)
 {
     return false;
 }
 
+static bool hexagon_semi_sys_exit_is_extended(const CPUState *cs)
+{
+    return false;
+}
+
+static uint64_t hexagon_semi_stack_bottom(const CPUState *cs)
+{
+    const CPUHexagonState *env = cpu_env(cs);
+    return env->gpr[HEX_REG_SP];
+}
+
+static bool hexagon_semi_has_synccache(const CPUState *cs)
+{
+    return false;
+}
+
+const SemihostingCPUOps hexagon_semihosting_ops = {
+    .arg = hexagon_semi_arg,
+    .set_ret = hexagon_semi_set_ret,
+    .set_err = hexagon_semi_set_err,
+    .is_64bit = hexagon_semi_is_64bit,
+    .sys_exit_is_extended = hexagon_semi_sys_exit_is_extended,
+    .stack_bottom = hexagon_semi_stack_bottom,
+    .has_synccache = hexagon_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return hexagon_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    hexagon_semi_set_ret(cs, ret);
+}
+
+void common_semi_set_err(CPUState *cs, int err)
+{
+    hexagon_semi_set_err(cs, err);
+}
+
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return false;
+    return hexagon_semi_is_64bit(env_cpu(env));
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return hexagon_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    CPUHexagonState *env = cpu_env(cs);
-    return env->gpr[HEX_REG_SP];
+    return hexagon_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    return false;
+    return hexagon_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 6550e7fa800..8bbd4647968 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -851,6 +851,8 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &hexagon_sysemu_ops;
     dc->vmsd = &vmstate_hexagon_cpu;
+    /* semihosting is only supported in system mode for Hexagon */
+    cc->semi_ops = &hexagon_semihosting_ops;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_ops = &hexagon_tcg_ops;
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 3ed83904eb7..073de10284e 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -34,6 +34,8 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
 void hexagon_debug(CPUHexagonState *env);
 void hexagon_dump(CPUHexagonState *env, FILE *f, int flags);
 
+extern const struct SemihostingCPUOps hexagon_semihosting_ops;
+
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 #ifndef CONFIG_USER_ONLY
 extern const char * const hexagon_sregnames[];
-- 
2.43.0


