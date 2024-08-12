Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AB9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQtE-00016o-PW; Mon, 12 Aug 2024 04:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sdQtC-0000yf-Qn; Mon, 12 Aug 2024 04:58:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sdQtB-0007lC-1j; Mon, 12 Aug 2024 04:58:54 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C6FKeX023483;
 Mon, 12 Aug 2024 08:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=XK2noz3UT37Ae
 6kuavkplU//eSJQCfOR1O8wZwQmkQA=; b=ActZOgsaMBI+61d0bGvuUDV1vHHHI
 jMjKtNwcewX8mTsmyRv8/tDB9doeclsmGbFFkiUfbK7TrQav1bV19yPSsv8IjsGB
 a2poRTjpFHjOpMusr1JSiDuCrmmdozxrka1RjiEoAdHraqKmKE/kbrXYnDQsa9SD
 A/RHXTqLIDJEMzacTG+v5c155bZ2JR4zKj7jJJP9qjHVOP4LZ+5px/xsL0GWErFn
 CuQ+nZip1t0NINp6WJ1f4n5DYYHqpMou+fKdXJIoZLh8SiX35JbmPoWe5TnZLeKG
 KEJzdFlCHXPEYVpQJjTifOpmIBjiAbDW+144xrY5kB1l/IxhGt7Oa/uBw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwcqvdhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:49 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47C8wnql009424;
 Mon, 12 Aug 2024 08:58:49 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwcqvdhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47C8EGv5029759; Mon, 12 Aug 2024 08:58:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrm5cxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47C8wi0R50397450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 08:58:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE4B020043;
 Mon, 12 Aug 2024 08:58:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C6120040;
 Mon, 12 Aug 2024 08:58:44 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.70.115])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2024 08:58:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] target/ppc: Make divd[u] handler method decodetree
 compatible
Date: Mon, 12 Aug 2024 10:53:09 +0200
Message-ID: <20240812085841.1583-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812085841.1583-1-iii@linux.ibm.com>
References: <20240812085841.1583-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dGm4TO24xn1he6D7Ab0BPCQs6Mrk0A9n
X-Proofpoint-ORIG-GUID: d46dhM1BXIZXo_KbDbAy7wJTHFPP5TP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=790
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120064
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is like commit 86e6202a57b1 ("target/ppc: Make divw[u] handler
method decodetree compatible."), but for gen_op_arith_divd().

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 02c810e8848..5a352cdad1b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1823,7 +1823,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret,
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
 
-    if (unlikely(Rc(ctx->opcode) != 0)) {
+    if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, ret);
     }
 }
-- 
2.45.2


