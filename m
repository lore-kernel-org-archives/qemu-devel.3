Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63CDCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN57-0004d1-7i; Wed, 07 Oct 2026 04:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEHwX-0007th-EO; Tue, 06 Oct 2026 23:03:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEHwR-0006N4-AH; Tue, 06 Oct 2026 23:03:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5daZ3393004; Tue, 6 Oct 2026 10:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vu36dmnm+8tfsykiO
 2X0UXJkJdaf1sGjSRY/3bUj7R4=; b=GB9dtrsQxnIsYqFqh4vxyHf3p0DpqbmI2
 jHRuhMdZzjXnBEXMzPcfhqAq1KuYodFzA//AuV+3Kv89glC65r5VTqdobdxW0o7k
 u8uKLwEubGTdpyXIV8hIH8Nc1Q71SRLrWH2UleApH1/8SIYmif2WlkgikKQ3mygg
 DWqEB5oMTxqIUZEnhD747g2tzo9V35aUnDqr/iuudz3rMYi0Fr63CX9CDSGh3JTr
 91u/jpjxMV/pW9v7qvkrKWhv7+1RHQ/BOt6Y+mvOFnpOCWiNGPhn3Jy0/7sYOlvW
 cfxFfUHFmJxMk8cReTPu9B5WVV+nrFC85boJaMtG+b7WVuB9FsMHw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5fgc6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6J1A175121; Tue, 6 Oct 2026 10:57:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgsg47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvM7q48759040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5CE220043;
 Tue,  6 Oct 2026 10:57:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD79520040;
 Tue,  6 Oct 2026 10:57:20 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:20 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 6/8] target/ppc: Implement DMF accumulator instructions
Date: Tue,  6 Oct 2026 16:26:17 +0530
Message-ID: <20261006105650.189752-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX89HnnoRFRWWB
 FaaSoKbGHK3OLTOCCmsQzHMcTm3wz4rQLAZ8t3KUpjdM3zGpLwiUYZO6nZrFK7AM77g1fQnyipe
 86dv8Y4V2UQiUMll71JlwNkYZPNLmGI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXx3L3CHztWUZe
 rJsHK4ItAilojzf/KWOhhdb3SVZxHbUoD7xEJJHU1Yz5DoXeg8QsXcYILrJvvwoFLWU2b/Fui48
 FFeo4ZpPja5w5oqTyaWqJfD1NzWafGy0nUBcGhjog3DDzjgtvtqr82+8zWVD4FJU+YuMdW/Q+vN
 hxK8SWpgWhyTvA+LyfXuoC3ymP4YxA/pgCVmir9UPAkNOZO7QiraIJ9w+5hAxL2beZ04WdyhtZ9
 P9u0DzNYiKnFaaEs0ZH/JHns0cgES1HijNNQ1vuaffdPHtq1jpQ3JdibOCwt4I6f+5npC5Lvyl/
 5ie44HN3JuOmGZISQLTTfAl7ETkLtzsAMCE6rtstNCtTGOQezT4/EjzBOWIpCfNkT5KFFOWjene
 BDREp5JUFO67eicXVhSb+u1hyJCjzspT+pxV5uzkKihitnIMOU5XeyNqPROJ0bmqqET313gRf0P
 CcOMdQy1bLqeS1q5CKw==
X-Proofpoint-GUID: dS3QnllUuXq9bJU3vQ8OVsX-omNenuNW
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac4d419 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gWyWIIHY48fqD8z5wp8A:9
X-Proofpoint-ORIG-GUID: X-i4De8aMXY17TfMpNrZwsIa8Zb4o22D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042
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

This patch implements the following instructions that are part of
the Dense Math Facility in RFC 02653 Power ISA 3.2 :
    DMXX{MF, MT}ACC and DMSETACCZ
These instructions have the exact same opcodes as the older equivalent
vector instructions. This is handled using overlapping pattern groups.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode            | 20 +++++++----
 target/ppc/translate/dmf-impl.c.inc | 55 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 1d3ab1e046..f718d550dc 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1429,12 +1429,6 @@ XVTLSBB         111100 ... -- 00010 ..... 111011011 . - @XX2_bf_xb
 @XL_s           ......-------------- s:1 .......... -   &XL_s
 RFEBB           010011-------------- .   0010010010 -   @XL_s
 
-## Accumulator Instructions
-
-XXMFACC         011111 ... -- 00000 ----- 0010110001 -   @X_a
-XXMTACC         011111 ... -- 00001 ----- 0010110001 -   @X_a
-XXSETACCZ       011111 ... -- 00011 ----- 0010110001 -   @X_a
-
 ## VSX Vector Logical instructions
 
 XXLAND          111100 ..... ..... ..... 10000010 ...   @XX3
@@ -1547,6 +1541,20 @@ VMODUQ          000100 ..... ..... ..... 11000001011    @VX
 
 ## DMF Instructions
 
+## DMF accumulator instructions overlap with the existing accumulator ones.
+{
+  DMXXMFACC       011111 ... -- 00000 ----- 0010110001 -   @X_a
+  XXMFACC         011111 ... -- 00000 ----- 0010110001 -   @X_a
+}
+{
+  DMXXMTACC       011111 ... -- 00001 ----- 0010110001 -   @X_a
+  XXMTACC         011111 ... -- 00001 ----- 0010110001 -   @X_a
+}
+{
+  DMSETACCZ       011111 ... -- 00011 ----- 0010110001 -   @X_a
+  XXSETACCZ       011111 ... -- 00011 ----- 0010110001 -   @X_a
+}
+
 DMSETDMRZ       011111 ... -- 00010 ----- 0010110001 -      @X_a
 
 DMXXEXTFDMR512  111100 ... -- .... . .... - 11100010 ..-    @XX3_abp_as_p
diff --git a/target/ppc/translate/dmf-impl.c.inc b/target/ppc/translate/dmf-impl.c.inc
index 4afa269f12..45aabe2a4d 100644
--- a/target/ppc/translate/dmf-impl.c.inc
+++ b/target/ppc/translate/dmf-impl.c.inc
@@ -105,3 +105,58 @@ static bool trans_DMXOR(DisasContext *ctx, arg_DMXOR *a)
     }
     return true;
 }
+
+static bool trans_DMXXMFACC(DisasContext *ctx, arg_DMXXMFACC *a)
+{
+    TCGv_i128 temp;
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA320);
+    REQUIRE_DM(ctx);
+    REQUIRE_VSX(ctx);
+
+    temp = tcg_temp_new_i128();
+    for (int i = 0; i < 4; i++) {
+        get_dmr_row(temp, a->ra, i);
+        set_vsr_full((4 * a->ra) + i, temp);
+    }
+    return true;
+}
+
+static bool trans_DMXXMTACC(DisasContext *ctx, arg_DMXXMTACC *a)
+{
+    TCGv_i128 temp;
+    TCGv_i64 hi, lo;
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA320);
+    REQUIRE_DM(ctx);
+    REQUIRE_VSX(ctx);
+
+    temp = tcg_temp_new_i128();
+    for (int i = 0; i < 4; i++) {
+        get_vsr_full(temp, (4 * a->ra) + i);
+        set_dmr_row(a->ra, i, temp);
+    }
+
+    /*
+     * As per ISA 3.2, the last four rows of the DMR corresponding
+     * to the target ACC are set to zero.
+     */
+    hi = tcg_constant_i64(0);
+    lo = tcg_constant_i64(0);
+    tcg_gen_concat_i64_i128(temp, lo, hi);
+    for (int i = 4; i < 8; i++) {
+        set_dmr_row(a->ra, i, temp);
+    }
+    return true;
+}
+
+static bool trans_DMSETACCZ(DisasContext *ctx, arg_DMSETACCZ *a)
+{
+    /*
+     * As per ISA 3.2, the last four rows of the DMR corresponding
+     * to the target ACC are set to zero.
+     * So essentially, all rows are set to zero.
+     * This makes this instruction equivalent to DMSETDMRZ.
+     */
+    return trans_DMSETDMRZ(ctx, a);
+}
-- 
2.55.0


