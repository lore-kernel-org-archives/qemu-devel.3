Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E58C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplL-0006PH-6e; Fri, 28 Aug 2026 02:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplK-0006Oc-7d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplI-0000vE-Co
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S23RnF516454
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yarUJd
 ZYZt7qAzwM9fP3mUMT5ag3hYjTRF3B+rWJOW0=; b=FH8qjtw9V/GvRTplju3as0
 T8PyUe31+pTFV6v6s6UynrPL2JbkaHTn+z9uTKUAvPvSyChF6BIcv+FZbQwvJSbJ
 O/lW64f5x0O8m/5JVZZ68L2q8P93m1591DKWP/KZGbXRSzSZ2UpaJ2a51tz8sChJ
 XFRzi/f7fqGf8tSF7bref3z2J3viO7NWJFIuJitYnP37qjlr5aPL1XdNp2iA7cwJ
 OpfJlaayhsfNw/2aDXX7fOWYSqFh9Au4SyTbDTHuD9hXF0IB+guvm31UKkjJdvJh
 8IqRuz0um3rnkKKukXZ6FGaYnvS185yV8r3QWYac0oQWnKMzG2/h9cHZC3Jpn7kw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jadrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uPhe025910
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwmq3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68Ifd8847798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73E0A20043;
 Fri, 28 Aug 2026 06:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F8A120040;
 Fri, 28 Aug 2026 06:08:16 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:16 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 20/41] target/ppc: Fix TRANS* macro variadic arguments handling
Date: Fri, 28 Aug 2026 11:36:55 +0530
Message-ID: <20260828060716.91672-21-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX3lThG4zlBQAR
 3v3g5E5vXCl27OHiwyQpTipm+CFkdYo9i1PkG/4uGKvECrmTwWo5u3yNn8SqCT/E04TvDIdbi+3
 hjXkHfMKtegXyykoMku6T2Ms4poh4Ok=
X-Proofpoint-GUID: ttrU0bahKPY92d9Prb79-PvkWtKEaIMY
X-Proofpoint-ORIG-GUID: ttrU0bahKPY92d9Prb79-PvkWtKEaIMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXyT5j3lFm7IOL
 8LLWdhTv14phQaa0rR1zVQ7QhmXkRMqvS78LDhBHxdTWidxQw1XiATO+mTrX+h+WSONPnWOShx3
 ex9pIdJQCwyrN0i/AGzAKa0X9T8j6i+JpBLVdH9AP5iyhjQ5dqjYYLQPMvdFkvA/KjU1rvj80Ks
 mERQrQG5zS2yz/QY44/mNqbJd56CMYIN40XU4NWG8sna1EskVjBoGeL/CSsP2eNtHoccv/XyMAU
 MbhJkM4VWebWmWfqnSGObbMbQ6OZ1ThfXcJVdJqXp3LzmaIj0zIsMBW9QF+aWOFb9CBQEkfkftI
 2X3lde4EId+8bJdNhg70mHjTuu6NszsAwXd/69ieQocxP96xhWrX0n3b0SNvKRF7eBxHsMtIMGn
 IgOzBtiAO/zk8e6I6t8dkkePMFWbhdxPyNc3779Kta9rs4sZKS2+h2jK+r/oUGfrkwS5wRjpaiX
 6TbhZd/b2ckbxzvF7Ug==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9125d7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=0e3g0i_IWCW26FfZcfsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-17-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
2.52.0


