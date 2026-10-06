Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B8FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENA6-00027x-AF; Wed, 07 Oct 2026 04:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEIG5-0002ZK-BN; Tue, 06 Oct 2026 23:24:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEIFz-0003yo-03; Tue, 06 Oct 2026 23:23:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5fFZ1603649; Tue, 6 Oct 2026 10:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IXydPQJbIqiQ5xvKT
 Td3az+7/n8dS4K6WDQ1oMNs6o4=; b=snEntOx0CAdnzyTaGDIYjM5z7AMfqHvBs
 idKyhAPi5sxh72TVswf7jVirBIaWI7Cq8qALNVAnMngxA1j7HF5WvkE4Cg/qVjFr
 mm5EFafZBd5t8XMIsrSZBvfxuw8cQW+OgiAbUoWTEClUG5hXPN8OIse6ilCv6Utm
 +t1UcTC4zH7Vxs0IQSZ61CNZ7J7oQY5wX/uV/DgqsIrJbC4GrrpPWa8mrCv3yJSy
 RlQjNqX/DP343MQdFgAlAYfuTD9orZi7jJpm2A2z+jz1phGXtq9E7X3SLEIUWPpI
 RN2zVSYvxOunuNZTFMJrm+VSxNZPWX1zVzTNsxLpbykWGmMyyFkRA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrfguy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696ALBTH126457; Tue, 6 Oct 2026 10:57:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvsnq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvKux42664204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E2652004D;
 Tue,  6 Oct 2026 10:57:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FF1620040;
 Tue,  6 Oct 2026 10:57:18 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:18 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 5/8] target/ppc: Implement DMMR and DMXOR instructions.
Date: Tue,  6 Oct 2026 16:26:16 +0530
Message-ID: <20261006105650.189752-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX2Jc4V54lMmWg
 brs8Jy+HjuPloYLzZDKnujvtUWDy9+Tvaakl6OUxnmFxu2ngEL0u015i9G/Ahim+Ey6dyunuXai
 iuKeg1z5S0zofVqnZgMIvuFbJTajRjA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX+3yCwK0IDZfB
 slRn2lufPzaaGSxcprYRJaeF0JczY+FRP6zw1bNOaaCEPdPj9sSmOcP6tzVFmHIW5uFKwKhc5vX
 bx8L/qQunf72cxD8pHdOMdBT+VmpKVikQaCWKsLw7hKjoWM7nrhqfQTCRFPeUHaFT/vbF6PHIUt
 N8pxkbxfc/LvaKyMg7nX4+cLXlUN95BkZ+cU53mNCF6/It7hYUvLw0oe9RvF5iKKFGaZgxM2BFt
 PosvLH6m50UBUCHDHwnsHIhYMZ906xXCj2OFAFjis6bchQ9ZT72WoM+9bXQsTlnzXIkk5C29pdn
 cPt2du3S85gDvqAwltQGcJO8dnvTcw6IaS+gDztI4i+VWFmYeF1AhKySov+AP4fyed+xUfHU2Ez
 ruIeD93wAeRfoaElYdYDj6VSPTf7MsHgJh0drycnWqRT3MGcO9xr5R1CThsGVY5k7/0J8PZ10/l
 oMTf7JsR6LbrwVShYPg==
X-Proofpoint-GUID: ZqssucHPNYv3gKmBgsE-yXoHL0aN2Wb-
X-Proofpoint-ORIG-GUID: FmUkZdcbJTkYFltC1lpQmO47BtNfE1h_
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac4d416 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=QLo4xXuWsxjYlSXZyiQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
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

This patch implements DMMR and DMXOR instructions, that are part of the
Dense Math Facility in RFC 02653, Power ISA 3.2

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode            |  6 ++++++
 target/ppc/translate/dmf-impl.c.inc | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 2a9733d6fd..1d3ab1e046 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -231,6 +231,9 @@
 &X_a            ra
 @X_a            ...... ra:3 .. ..... ..... .......... .         &X_a
 
+&X_ab           ra rb
+@X_ab           ...... ra:3 .. ..... rb:3 .. ...........        &X_ab
+
 &X_tl           rt l
 @X_tl           ...... rt:5 ... l:2 ..... .......... .          &X_tl
 
@@ -1552,6 +1555,9 @@ DMXXINSTDMR512  111100 ... -- .... . .... - 11101010 ..-    @XX3_abp_as_p
 DMXXEXTFDMR256  111100 ... ------ . .... . 111100100 .-     @XX2_bp_as_p
 DMXXINSTDMR256  111100 ... ------ . .... . 111100101 .-     @XX2_bp_as_p
 
+DMMR            011111 ... -- 00110 ... -- 0010110001 -     @X_ab
+DMXOR           011111 ... -- 00111 ... -- 0010110001 -     @X_ab
+
 ## SLB Management Instructions
 
 SLBIE           011111 ----- ----- ..... 0110110010 -   @X_rb
diff --git a/target/ppc/translate/dmf-impl.c.inc b/target/ppc/translate/dmf-impl.c.inc
index 5409ba8836..4afa269f12 100644
--- a/target/ppc/translate/dmf-impl.c.inc
+++ b/target/ppc/translate/dmf-impl.c.inc
@@ -78,3 +78,30 @@ TRANS_FLAGS2(ISA320, DMXXEXTFDMR512, do_ext_inst_512, true)
 TRANS_FLAGS2(ISA320, DMXXINSTDMR512, do_ext_inst_512, false)
 TRANS_FLAGS2(ISA320, DMXXEXTFDMR256, do_ext_inst_256, true)
 TRANS_FLAGS2(ISA320, DMXXINSTDMR256, do_ext_inst_256, false)
+
+static bool trans_DMMR(DisasContext *ctx, arg_DMMR *a)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA320);
+    REQUIRE_DM(ctx);
+
+    TCGv_i128 temp;
+    temp = tcg_temp_new_i128();
+    for (int row = 0; row < 8; row++) {
+        get_dmr_row(temp, a->rb, row);
+        set_dmr_row(a->ra, row, temp);
+    }
+    return true;
+}
+
+static bool trans_DMXOR(DisasContext *ctx, arg_DMXOR *a)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA320);
+    REQUIRE_DM(ctx);
+
+    for (int row = 0; row < 8; row++) {
+        tcg_gen_gvec_xor(MO_64, dmr_row_offset(a->ra, row),
+                         dmr_row_offset(a->ra, row), dmr_row_offset(a->rb, row),
+                         16, 16);
+    }
+    return true;
+}
-- 
2.55.0


