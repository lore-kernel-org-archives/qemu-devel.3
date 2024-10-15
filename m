Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B25D1D876
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0osA-0004zv-LT; Tue, 15 Oct 2024 17:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os6-0004qO-SO; Tue, 15 Oct 2024 17:14:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os5-0000RN-By; Tue, 15 Oct 2024 17:14:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKoBTD009327;
 Tue, 15 Oct 2024 21:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JDHAZt3OEIu26gxyW
 oWLvd7Q8gdIopP79UnuRtkg+Wk=; b=qz4X2T0/dImb/dBdrR+jB7JD+CHpWBdSh
 xTjPl50QfCh7igIaFaSZH/vEDG9RP44/f8EX5o+TrPyeQqC22NotDXNeuNtT4jXt
 YsrhisAGWy1vnPFxir5lp51/Rx77EJbnlE/Ilg4a+0FH6sPj7SJUKBm3xd4fwCDR
 CL8INohJAkkkYfBYjZtN76sAQZV/sGanqMvH6SzOlmKmF7PjprzI6BzcJl84h6i4
 tRDf9FkXUzXtbO5++LrJl4eCz/1IQ436xJ7GFgs4Ehh+6/1hS2iIb1GFMaomHYqX
 FRdF40v1RHYxuWuFbJA5z7D8WJ3FVuaJ9+I5L288Ba9/AQbGta/bQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429ysbr29t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:08 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLE8GH022233;
 Tue, 15 Oct 2024 21:14:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429ysbr29p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FL1RrG006671;
 Tue, 15 Oct 2024 21:14:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283erx5mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLE39R50528746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:14:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D061D2004F;
 Tue, 15 Oct 2024 21:14:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B45BB20043;
 Tue, 15 Oct 2024 21:14:01 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:14:01 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 11/14] pnv/xive: Only support crowd size of 0, 2, 4 and 16
Date: Tue, 15 Oct 2024 16:13:26 -0500
Message-Id: <20241015211329.21113-12-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _mprSJYJOPy5qNjPGapRDp1pW00bqZSy
X-Proofpoint-ORIG-GUID: adWKgyedtRMrH4yqAqTuUG0uvhhQWmel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

XIVE crowd sizes are encoded into a 2-bit field as follows:
  0: 0b00
  2: 0b01
  4: 0b10
 16: 0b11

A crowd size of 8 is not supported.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/xive.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d5fbd9bbd8..565f0243bd 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1687,7 +1687,26 @@ static uint8_t xive_get_group_level(bool crowd, bool ignore,
     uint8_t level = 0;
 
     if (crowd) {
-        level = ((ctz32(~nvp_blk) + 1) & 0b11) << 4;
+        /* crowd level is bit position of first 0 from the right in nvp_blk */
+        level = ctz32(~nvp_blk) + 1;
+
+        /*
+         * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
+         * HW will encode level 4 as the value 3.  See xive2_pgofnext().
+         */
+        switch (level) {
+        case 1:
+        case 2:
+            break;
+        case 4:
+            level = 3;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* Crowd level bits reside in upper 2 bits of the 6 bit group level */
+        level <<= 4;
     }
     if (ignore) {
         level |= (ctz32(~nvp_index) + 1) & 0b1111;
-- 
2.43.0


