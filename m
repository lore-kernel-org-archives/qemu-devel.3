Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D40C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3Ok-0004wf-7x; Thu, 20 Aug 2026 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Od-0004ey-Ey; Thu, 20 Aug 2026 10:05:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Ob-0006YF-FD; Thu, 20 Aug 2026 10:05:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9HLlF2794846; Thu, 20 Aug 2026 14:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=W1gARh
 f0ZCFhIBCtmL3Sj2flPgOrFpN5UPk34sdJWzI=; b=pJw2dx87jBcVGj5sRH095Y
 Q4cz3lMT+oOVq0BqY9dTpwiJFz8zItGTEFSaBYf/KPgKcm708Mh/vNWckDoD2w+l
 drIZS8IPmIrIZs3qSjnemPEsh43UkscAT6YLdijS7ohgGEeUE4Be7xWCg1Q9RvfY
 yE/c93tt1ISTjOK5iINIFm+d5BrQEUdoZiyEBKSgskeAtKnVkjY8m5u5ztO2FIrA
 gMCLRsgObRmIC+k19vbZjlch0RK4+3/2R69Eh3U+GwdSq+xXhEcnbcNtPJavw2g9
 BLa/RsBoRd+mMQk7XBwOEjVFet7derzPc0iP1XOrvhAjx7uogyLouc2I2eHTanTg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0asb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuI2s021598;
 Thu, 20 Aug 2026 14:05:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhewmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE5Htd30278246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:05:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BE9120043;
 Thu, 20 Aug 2026 14:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ED8B2004B;
 Thu, 20 Aug 2026 14:05:08 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:05:07 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 16/29] target/ppc: Fix TRANS* macro variadic arguments handling
Date: Thu, 20 Aug 2026 19:30:45 +0530
Message-ID: <20260820140114.327023-17-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rHlM9T5leFYv0oqlo34UNhdFBZocTmVk
X-Proofpoint-GUID: ZqHYCoI4OkwAd3rkjOmmdNGreJU_fDk3
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a8709a5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CtCGoDGENXNllPNDbDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXxikjrZ1faiFl
 11n+7qx1jqddxJMHiJUNz3gjyS0Tl0U+jSetryhveNCdCEIcDmAmUKhjsC1ffSnaA8p0fGfTgkc
 72aYvsYFqLV30PVhLf33K7jFdOYnFWI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX9SdehzmO4Lyo
 SWh60vXcopyxoTFD6ib44h3NB3MRSSGVex6itIhYjRVTY5YKdrj1ZoKjW/+d3Zd2R3n4bPHiYAd
 2kWeB8gaHdmkKs25GnwqvFxMe+i8+lsm9aIGYCuMdonb348jNEaaK2WcT810ncP+tkhECbbS/Wt
 hkODJfd2a462AftNiOjR4qvVGa7iubazuGbnpg6f4ABP0CrFysQAn5t0OvgZGXIf8CB3EV4VGsi
 9r9JhUfOdokGHXkrd2wtbSrgb/jiQhWIelWCij9RAQ61SdRdij3bfAttt8pI1C5ZoLxEaTU35W0
 RtDU5NvGKuJJBShppXfifwzTvgK9gA2dzV1JMWiHPiyWdOc0lfatx+X69dxnbUQwcCinVVBAJhi
 QwhJGSF4BIiJsV6db1LF4CMYNh1m+38OA8J82/HdZiBhmovKetladO+DlgdrTRduhjuLK3NKPXX
 HYiWGSTnbAmzijOZQlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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


