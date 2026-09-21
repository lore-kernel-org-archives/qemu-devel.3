Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9FDC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kJi-0005gB-T1; Mon, 21 Sep 2026 16:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJZ-0005e3-4C; Mon, 21 Sep 2026 16:08:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJX-0005Ju-BQ; Mon, 21 Sep 2026 16:08:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8WD41711839; Mon, 21 Sep 2026 20:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=u44Mc737QUAQdDpt7
 MqrQuDnPMeRpzPKMimxP0OQq0M=; b=D9Y/xBXHb0BTnAIGNOY7FJka9F8MgYVxM
 T73ImqJqzHU4Qv+DewgLQF5X4O4xqKH56usAIMtLKF1UQDpmK9P+Ji5fHfaRdNSS
 at3vHC1Fppmt0gcilqMrFNy4p4lTvk6IOpd1v9Kon6rtI7kzgHRLDRRahCOIT8qM
 M+pd7OaKXbTyhunfFOvvITahiHcqdvWSyBLjSawP+ZBYh9tEv4NbmYbBPbUFkjfR
 gbbYQb8IZeLfBUr3+Q3OYq03Jgu8HLyWJ841TZocv8LvvkPJeDacdA6cT+bI1Ndg
 5HZ694qHZGQp2fGZkzQ9Pn2/IXWLXnqLpEXXt22MAn2Rtb1bCb9Lg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1abv9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJKdv21451390; Mon, 21 Sep 2026 20:08:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gpu3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8Wri24904224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D9A858055;
 Mon, 21 Sep 2026 20:08:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B15158043;
 Mon, 21 Sep 2026 20:08:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:31 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/33] target/s390x: Fix missing privileged flag at PCKMO
 instruction
Date: Mon, 21 Sep 2026 16:07:58 -0400
Message-ID: <20260921200830.1302919-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jaeNlKsPJqz_yEoAhO9rBIWaWlK7cDwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX1DEBEC6xg2bf
 YhF9QPCFWF2tMfTVAqSui11QTEdNzjy8rdE1ORyx9IFVm3gdvL2ydj04SazZbGcH0EPJqGkRyim
 hYl/dtOBUANGIjq4tSM38tmU5R5FZZDVwGzMKLYdexGbjXGAQXHBUnCt5B+P5nCIo+lHEi7Xdl4
 r0UJiBEb9dJYtxVWBTVpj77x7MDm+JNHHylDhkSlmx6quPle9QF5bVACTG0e2ZjUiNHchIIvmiz
 E8CfS/PJG1ZaKzgipirG8XI7iKRG7mZR+oE1IVQAT2Xc84A2rLHNuJLs6RLg6NG2mj7qrk9tfZb
 ZxnU7kI98F7Ux+WNQyFLz0fglqWISiuTuDKc0mViso37g4NqDVZv/j+8vSXYVUEoGP+TGHC6Eai
 LEuPDny4rWSx914zezd9ulSnAhMi58XafVANolGVWk6MAfJMNSqO/IjjRyyvh+mS0jDBEAOLjgT
 pmrR7Z953LX5QPEA3dA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab18ec1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OshStu86mOkqpzp6wrYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX8n0s4gEBHpHJ
 Y6nbPs9y7wxAnIn6bcnYeuj9IwRl4QEqGFqgj8cAppWx9o/yv+EYUIoQhVlkF7r8yHbrjuJ/aOE
 hdoAJjUgf+xPluk2pnK1Zd1E6NnFGlY=
X-Proofpoint-GUID: jaeNlKsPJqz_yEoAhO9rBIWaWlK7cDwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Harald Freudenberger <freude@linux.ibm.com>

The CPACF instruction PCKMO is a privileged instruction. So set the
IF_PRIV flag in insn-data.h.inc to reflect this.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260824083204.40877-2-freude@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 68260ffd9d..b5683f7641 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1007,7 +1007,7 @@
 
 /* MSA Instructions */
     D(0xb91e, KMAC,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMAC)
-    D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO)
+    E(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO, IF_PRIV)
     D(0xb92a, KMF,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMF)
     D(0xb92b, KMO,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMO)
     D(0xb92c, PCC,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCC)
-- 
2.55.0


