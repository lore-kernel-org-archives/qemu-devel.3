Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6461AC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaDZ-0004En-05; Thu, 27 Aug 2026 09:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaDP-00041F-JM; Thu, 27 Aug 2026 09:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaDN-0001ir-VY; Thu, 27 Aug 2026 09:32:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVe9l3056486; Thu, 27 Aug 2026 13:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MqSH5I
 Xqkv+YZQPOKvZivx1UVgz3FSGqKEo2KSNBEWw=; b=f7X7sqPAolfKDlcSIc/R/l
 COULs4yst7CUhmH0wNQhoeTwr5O+4eBchBqHftPNMQ+TxAu3fcTmafi7P2/WEq6L
 kyxSMVQFyXuR/GLOdtiBX9y1NhiQrU9znxw6Fbl1/WSecMNjOkV4IVjE47nftx78
 ro5x/WSlf3m5d/Ca8rMa0bX4sZaQ8s9vR3+NPQ+pZrIIEe7Av/6y2WYdg/yMCYzk
 VxRlgq97oAeIBO1RxH1PsuKLhwrv7zXEqA/NUbu7eibo9LE3nEGDV/GTPER5ik7Y
 MkG2hGUNkqo7e3cwouworpz49izaqluN/F53CZfXeGB/7tjjYztr6X+N5jlA0FiQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn9my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQO9V003907;
 Thu, 27 Aug 2026 13:32:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwgcux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDWEQC16646620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:32:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D111B2004E;
 Thu, 27 Aug 2026 13:32:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20D7320040;
 Thu, 27 Aug 2026 13:32:09 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:32:08 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 16/37] target/ppc: Fix TRANS* macro variadic arguments
 handling
Date: Thu, 27 Aug 2026 18:59:31 +0530
Message-ID: <20260827133010.278889-17-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXw4nrxWF3V9Hb
 Zqx3oqe2WtpdDMS3tKs0iMDSr8iPPSFFkNuzZVa4pdB1D9VjwfJ1lyaVyV+qUnpT+cXaS3bv3WJ
 XUavnsfS6gk4TGE3WevUy2pJjiwbHyM=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903c64 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=0e3g0i_IWCW26FfZcfsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tk-ruzMutDfewazVV5-nAqSzF1s3y8WI
X-Proofpoint-GUID: oszdl85d4ky5NzjOl7Q3BzntJBpe51WB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX2vXxRhLduePg
 ltfzXUCa1HUtF48BVNT7VpSXQC4P43ct7FZRaasdLo2XcRFyVTz6m0FQJoLQzdXMqYQ1119IVPC
 zMY9ITV1IrdJ4PWq0MkRksheL1JNL+5FqJL+rilvkeDhbWOG8mmJCXk2iHWbCs9E+Dy3Tv1rlsY
 711JEZWv0bQZyHaD01CLmEUSmsI9VZW+dSyAtIkKvi11tbJuf3oTG/yK00xdvCUsLYIAUUd/oHX
 sVEq8AZGQdp7RK92s533IzyVLwnci1op2JJmQ/4BJTJ6jVZJULdBKP/amIREGtt6jv7y8j6BlC1
 difwowU9armPFG+AkuhDhokV5/0JDSDWloVOKeCkqH3PtVIdPyMzzSEcEPVDF3gHjAeEmYueIeR
 tnq2pWriDxBJrbJK2jT3VdIe0gWJMlHI2LXBf/JVB4ySFutMj12w9OyY71smtRVOSTeF8ndwSOx
 jU4tbxbhlqXrGUoIf6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f5b1446d7a..322870dc0d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4749,29 +4749,29 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
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
2.55.0


