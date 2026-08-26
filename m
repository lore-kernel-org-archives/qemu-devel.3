Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A72C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5vA-0001Rn-SG; Wed, 26 Aug 2026 01:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5v9-0001Na-OE; Wed, 26 Aug 2026 01:11:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5v7-0005PT-W9; Wed, 26 Aug 2026 01:11:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3Vfer2830808; Wed, 26 Aug 2026 05:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N0+f5t
 z4358pnkCxomPRcN5eTS4PkgiKvaweWeeJDzM=; b=jQDCMyUDgrCESTW1DGWKWL
 kPcXakkWS0eO0l6aRSQzx+r3BxTtEzwcyzpwhe4FO25sjE27DKGP/EynYCLFxpnj
 cRFazbQ7f5PV6Q/jFYYRl4GPwofUoSNTd4ba9xhgKg0A5ZsBU7sho2SMXGgT6w1t
 aPKl9CYd4+qxL8wfG7pvuhsxZ3ydq6cNsUOqcBdLL0ZiiCjuIXXAf10O5qgWmhy2
 umKmm/U0vaPZdN1pXsid1j3+DEfFP/t6hIXXJvtYeiORQynNNj42aybvZ2JLVTRE
 u5xRqvwJD3DVS4ga6zD5suSs7U6E8yNZTL2uofQIDBPi5GSo1lH3gbR1VOTGi7kg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4vnt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BIqJ031858;
 Wed, 26 Aug 2026 05:11:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8aun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5BLL136372892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC21B20043;
 Wed, 26 Aug 2026 05:11:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCCE320040;
 Wed, 26 Aug 2026 05:11:15 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:15 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 16/37] target/ppc: Fix TRANS* macro variadic arguments
 handling
Date: Wed, 26 Aug 2026 10:38:42 +0530
Message-ID: <20260826050923.74756-17-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FiUilr-lvGTLVs5yej_Eu6p55yt_i51g
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX/98o5oswxuYZ
 MKinIzfMrhBV3jk3EiwfCPLNyRbQkk/JSM6YDeDYDDhtMoY0bPp3SZaNgzxzq/F8L91fe+q4pu/
 3u3eavi8Izvcf5MxfO5LX+Km8kz8Hgo=
X-Proofpoint-GUID: 0c8plvi5X35FpWDl8XA_nd_OLc_jbpbI
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e757f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0e3g0i_IWCW26FfZcfsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX/qczndYyqeKl
 1QxjEV6tb0GN87+Wx8Xh5yI2vOqSJYb+kt6OZhqbCkq+linA+mbBYV3/3rL2zfbCrLTLlZXG9uR
 jOBQ2kyItV3U4r+QaYLTP1y6vhUvJDI6SsV+umCdomnzRuQsTjQ/gycD43er/Mhplj3wUY8nlto
 Npfjh0mDkE1IoTLRuQY7V9XnrPVK7VKYBcn3yL7Fmcc1t9M3qfOpdlXyn304aVcZ16zK3BAb3+h
 cGWjjLgwcUKc/WO/+k9M7igd+2MD3kqXLlFxpKhCa5U9Zd0bthjbNc5laz1qipEuYekYNXshz9G
 NRWVlN1FeZJSMuAaV5LC05Dk1LfjuHJAq5r3lQJF6ts8mzffqwN5tB9oKC1ZNz2mzbKd8fVe6F0
 pZSTOZpxvniB7H9x2jtn44JStFTtCRErVjMK8UWr93bRT7Lt5R2od3jioHnlifHJGJXBnGO3DuL
 qUdVXZxtPu7aZBqy6cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 7100787a25..f7c7f53d82 100644
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
2.55.0


