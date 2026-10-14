Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EABDCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g4-0003x6-H8; Wed, 14 Oct 2026 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fy-0003wH-BK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fw-00020H-6C
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbRDA3813089
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1boj2F2SPgf
 JqtJg1RZDb6cYPTMQRV3Ay7864ODb73w=; b=kwbg6ZnOqX7I6XeqNBr0dJBOr4z
 O3ikIguNV/9AZ+wjvwqucjJD3qrzXnHahGkkkUxTlmZNjIjAIw5LVINbMGCQG8qr
 RHJlZCK/OjbExl5tu2GazZDC3Jyzy9tRmcLwFjsut/u0fWVq1hVUM0+q2a6CN4ep
 2RIWbXg3MITETM/suPlT/V+tWAi/BMKQzxPP7QEZSj4cyJY111IsT6HM94Y1UVaP
 brSD7Cwq9rhVMNXV4glyd0GFcavLxWses2bNEwVMnD8I+lUjj3U9K48FYdYYg3w7
 u33x1teqIwm1upMkec8g0sKcx8TuCo04clM/3qLjfcnKY4hM2tWLWDR5o+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u30jp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so5377214eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002362; x=1792607162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1boj2F2SPgfJqtJg1RZDb6cYPTMQRV3Ay7864ODb73w=;
 b=cAoGPmkjFjpmrTe8I8LeL0WoMQMvpfqFlultG4xcjyp8QbUUo7rO4H1SYRLYpIvc/b
 rNxvlTMNvf5XnUFhk1D0QiHullgMQPWiDGsgOi3ZXBvPcqwimaZQCfprA3S/3mCnF5Ir
 Idyn78rzhiPexpAyjTmQFNkkSQKtUbERE11j52m4svHcPVyh4kc4qsXnl18M/fC6/zWI
 d2d1GcAPxPpBKOqmEcHMT91dope1YIWjZfUEvk6zf6GyOHQOXpCibiRsl4m8Fx8OYoO7
 88C+SNXNVqwpUwGQTSlMeFDNZ6N4BXj+69w5Td/VBBBaf4NZfRfbPmV4RQufVQvi1bek
 P/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002362; x=1792607162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1boj2F2SPgfJqtJg1RZDb6cYPTMQRV3Ay7864ODb73w=;
 b=uJGbNU25nz7GstIQ3inKDB7Zq1BPFltT0VA3CM4f7TXBRJz0JccHRKXYcNfWkn22st
 mrtUWHBAlO2zqjNfVjTu661sz3j/pkgpHcCUQ7iFm0tNxTTuA+h5Kr3hpxxjFm7aJe8Z
 413+sF1z5FluipWx+a1fM59xGpta6ubbd2g991jH9/VEiIceLZ54SvHHODbrQd607YAs
 CJAAKVLCyWJcktT16/VacFmX4ON+EolPVGl5ogz55dn5eJw8cHwviWolFkxE10ZIoL/R
 nZ4dOf7tQYVaKOVnCDkHG44RcSk9Ph23KYYBzJjifO1zmb83ScqQ+ro2KdwrR/4dA37H
 Y4vw==
X-Gm-Message-State: AFq9FYI+C3HmSoQzkgaTDDEo14nTCm8Dflr7LzAZ8JZ+9ShAqNeLp2nA
 xUDgNXMKMk1cwfhkQ+g6zRRRKO2dl+rzjupsXoBhdU/w9SmTVBvcSgPvCzi22G/QVt0KjEhzhDb
 Gji4hQGnQ6R/Oj080tjk/2D49XzTRuRtyX6tK5TAbPLtAvHfBkTzhwFdx3t0qj2PwLQ==
X-Gm-Gg: AYBFou0Kp4m8a8ispvTzioodmWpeZX55yh1cROiJBjW/thAOnPk4RiIkX3dgxU/JOjZ
 F4n+/tVGJhmT3iIyYsS0lpHS7Km8mxo0AUk8ACfCesyoDoeylL9Ymd/zD++Y11HZuquBPpKEoic
 IoD78hPNGruZlF7iYps1asSP3MOkYaUCcIcn8kMhVUtx0Sc2z6TUC3tRR/jkN/2U6YD5cdFvQH5
 x59//okhOkvTONZtY8/RIU0C4GSZ8Kkjzo6MW+YvZDvZTiP0OIGj98Pp/h8rp5uKPxhyEU0UVy5
 UBIj/++jmIsDTR4vD1z5/1g9RAOftmw8y+HcSIrg05TTZfl/Nvg5VdvZ04h2ofw6YhdRnvVUaSD
 QNsTmLXAHaw+2TQBaxhL7+4NlB+K4+AJJC/PYl0NGQDb144UF2+p/l/GK3PN9
X-Received: by 2002:a05:701b:4541:10b0:144:ed03:8972 with SMTP id
 a92af1059eb24-16a5dee12c8mr22042255c88.16.1792002361543; 
 Wed, 14 Oct 2026 11:26:01 -0700 (PDT)
X-Received: by 2002:a05:701b:4541:10b0:144:ed03:8972 with SMTP id
 a92af1059eb24-16a5dee12c8mr22042225c88.16.1792002360845; 
 Wed, 14 Oct 2026 11:26:00 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:26:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 07/11] target/hexagon: declare semihosting ops
Date: Wed, 14 Oct 2026 18:25:39 +0000
Message-ID: <20261014182543.135965-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX6t5NJI/c8gVw
 FpHdCJsbe9jHjc5G5/T+5OfxCP8hxxZsbIgkZ+E+Zw/o3sntmqZzbvrL42m6z+uwuiU3+es9Koh
 FHRXAOyOy/PXEpBq1Yl4RwRaM3bXK14=
X-Proofpoint-GUID: 2rgdE7ITyMDAMMPktEkivegF-VubUm3D
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfc93a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=RKMH5O5a7-KqqQVN41YA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX6LPAx2ZNB6oG
 5zPMsAFsnc5W/TCqks8EKkLPSjNBvonxwLAbf2hJcFn05lOMoX7sh/MMgeiCtWmVjMfkZkBHhfA
 OWom/tGWNz2cEIZemIkLLUuvBFUwjTHOiB+LYVMbgi83XHZJVFa6/3HfB2qZfqHpf3Zdwm2Dm4u
 JpsoeTKANCn/93U/FRQPUCgpn/b0no4eozMpBNdQNiIxxxzaQjwisWYmEvaKS+zSpxyrh21YOh2
 gpF0HfHZQFp+ia4dbg76VFd5BQ3+pOkLstmLkDzRJ0+/rteBbXvZB+W1BMh8TdPvXm7Mxdj3d5D
 nTwj5163LazRgoeEIuki04h/lWskZLhQAocZYZdgGgRU8vyQ6Uf3uvLUYcxdoCynVvXS8aLRQP9
 RZOC0Z8PO/EcwRDAVZOEX8i3DkRGATRX/GdCtM72wMoy2yjqH3VuJ9nGS94frDXxYPd8RL107Gi
 1yvqHMXRePHMBBpQMSg==
X-Proofpoint-ORIG-GUID: 2rgdE7ITyMDAMMPktEkivegF-VubUm3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
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
 target/hexagon/common-semi-target.c | 63 ++++++++++++++++++++++++-----
 target/hexagon/cpu.c                |  2 +
 target/hexagon/internal.h           |  2 +
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index 210d33e54e2..b97ed6796f8 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -8,44 +8,89 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "cpu_helper.h"
 #include "semihosting/common-semi.h"
+#include "internal.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t hexagon_semi_arg(CPUState *cs, int argno)
 {
     CPUHexagonState *env = cpu_env(cs);
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
+static bool hexagon_semi_is_64bit(CPUState *cs)
 {
     return false;
 }
 
+static bool hexagon_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return false;
+}
+
+static uint64_t hexagon_semi_stack_bottom(CPUState *cs)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    return env->gpr[HEX_REG_SP];
+}
+
+static bool hexagon_semi_has_synccache(CPUState *cs)
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


