Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4608CC982F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKN-0006XO-DY; Mon, 21 Sep 2026 16:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKD-0006Dq-08; Mon, 21 Sep 2026 16:09:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKA-0005Pq-Hc; Mon, 21 Sep 2026 16:09:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Zu61869974; Mon, 21 Sep 2026 20:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3EaIYq8QwESfXJXRo
 G9EGq4rgguZJ+sE14l8I5toFHo=; b=S5qSMM+caCAl1isuuXSoQSs3HsFzd6JXB
 DAB9HQ54clJSA8MO9lbNerOBL3xsPyrkVP81O/RH1+fOl79+G55u6pfbHYMUnpCO
 JTFhhydrgQbr2sTUc7oJcyPGX7cwtXLhP1OwZKFVGPXqymHm+5Ld5JkBp5Rv9TWo
 RV7LmDhcDr8cF8j5NSwCe/x9zdZTc4v8Vcduh2+gHu7bwaNKE2CGrtDW410Cfmdj
 DfwLaRDad4gblo322ZngAMG+WVX2zzx6KDX53rcwuGl+l6dTAZyTxQAHBEoq0W2e
 GAaKEn3xHsJCJ9oDDC6TmkcAoHA1zB2S7mGDmA9HxoJ4/YE7JOTWQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs2h2y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJK2C21431700; Mon, 21 Sep 2026 20:08:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vf033-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8oWI4981344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83C6A5805D;
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BA0F58043;
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 31/33] tests/qtest: Add s390x PCI SCSI fallback test to
 cdrom-test.c
Date: Mon, 21 Sep 2026 16:08:28 -0400
Message-ID: <20260921200830.1302919-32-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab18ed4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=MvDj_lKWWGcuVSP3geIA:9
X-Proofpoint-ORIG-GUID: pXqsVlFPtgOxwj9VELEVMA-xnHQg0mCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX63W9P/5TsIHV
 tnohdOcE27aU6zAf3QOmcts1vMAEtGW46U6Q4srQuIJ218m29KV6TrTb67/YiA1cr1D4oazEtQv
 rsf0h4N6o942zY5jM4asEA6chSYvBVSeuCSm60omdKhTdGXFwxr8sb5LEakSaR5+0522Lwk8UGh
 K3mmfnAkvHPxQnbBKlDpn8G7x0p+jldJ0TXaGsGMuMF7bfSsfOuQ36bm4b7cchIZrm3k97IdX9V
 i/5Qk6JtrmPxNJkKb0P30m26rAQlpeqU3jjdMPoeA1MtdXtzgWjPCZ5Lo8dRQKjPXhfCebLSC9D
 lr/KWUNnjok+QDI84PIwtnDZfUdmn0TZaKtLZ1ootSVSdiwaWBuhLNXt9y0A/5BbsC0xSbWpzbo
 qw8rcm7h6AugnbKBXwKEctjy/dfsFJ49fZuN4RQGiLEhSRRnb4VjnJxU65jXf6UDawXBJ7Hcp1H
 v8K5vEZBL8hE5iV78/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX+IUQwmGMPYNW
 9+6v5eddIls7HKgC+6/8vf1A26ghvczy3qRstHlat+tv3kaSSaUgUcMWlm6AAbcZnw5oYrSToyr
 eIJwvb3Dgxsdzx30rVKliPlyxZVIZ8A=
X-Proofpoint-GUID: pXqsVlFPtgOxwj9VELEVMA-xnHQg0mCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add a test to verify that a guest can use a PCI controlled CD as a fallback boot
device after a failed CCW IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-9-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qtest/cdrom-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index bf997be6d6..9e725126cf 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -272,6 +272,14 @@ static void add_s390x_tests(void)
                             "-drive if=none,id=d1,media=cdrom,file=",
                             test_cdboot);
     }
+    if (qtest_has_device("virtio-scsi-pci")) {
+        qtest_add_data_func("cdrom/boot/pci-scsi-fallback-from-blk-ccw",
+                            "-device virtio-scsi-pci -device virtio-serial "
+                            "-device virtio-blk-ccw,drive=d1,bootindex=1 "
+                            "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                            "-device scsi-cd,drive=d2,bootindex=2 "
+                            "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    }
 }
 
 int main(int argc, char **argv)
-- 
2.55.0


