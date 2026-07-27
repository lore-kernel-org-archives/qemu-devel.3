Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831AAC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJrm-00052X-Su; Mon, 27 Jul 2026 07:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrX-0004xA-86; Mon, 27 Jul 2026 07:51:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrU-0003bq-LN; Mon, 27 Jul 2026 07:51:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAIYZW1956044; Mon, 27 Jul 2026 11:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=V/28EiZE6z19dCHIw
 2j/qKd+LNXHAt5Ltm+KpalEMOA=; b=S5VOTJtvL9GWjQv9tbv+qrX8+UzmJ9Ops
 yGA5tryMUcKZnmHBx4xcecQ5J4xwua5cPCVy6sWYYoWlfhxNJCWWLM1l89QOG4nF
 ER6G3Rdd0VmpqFMpzYqSG9KvtT54PbcX9s83HLbxEQ+WaJxhVjsGFVYyhU0GNcsG
 MEQUe5XNf5P3CBvQuERsPnfXLSAPejxAV/G1CacLRaqGrJz5F9yYir6X4Lg3VY2C
 81J/dCpuporMHDwO262FnTdo/TpiErfbk4V7BdI0XXVNMdj7fFJrn+as4nw8BYvV
 DsJ3Imfdusj+9xmiDcixUj3ssky8fi3rumF9yzqVyD62aWVFxLo8Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xft3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBfNIr007068;
 Mon, 27 Jul 2026 11:51:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xvxkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RBp5sK52560198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 11:51:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A32C5803F;
 Mon, 27 Jul 2026 11:51:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C95B558056;
 Mon, 27 Jul 2026 11:51:02 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 11:51:02 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Borntraeger <borntraeger@inux.ibm.com>
Subject: [PATCH 3/5] pc-bios/s390-ccw: fix out-of-bounds read in
 iso_get_file_size()
Date: Mon, 27 Jul 2026 13:50:50 +0200
Message-ID: <20260727115052.24289-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727115052.24289-1-borntraeger@linux.ibm.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XdjniAPU2_-qWApazUZjTFi6-mxTU2HX
X-Proofpoint-ORIG-GUID: XdjniAPU2_-qWApazUZjTFi6-mxTU2HX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXy3b7d8e3YjcO
 N5rc3g0doaWIs5mRdqXjaazlSDm30nZ9mvu8Y4Y75WHV0aHLsrcf/eeqkhCZN7C/XUa4svYQQiu
 AvC4FLN9bU6Z1Pdygur4qeh8XupRqpc=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a67462c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=V9O40ZNVcsgYW_DuhdMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX6C6rLLObqoFm
 KpN9/1ltMEc0yRZvEjIXs8Vb4EU+9xrvLWTFrOk8gxOSaQrXLwRE01l5wwwtSlQ58ojmqXPz9DM
 e81nIssGQM0KaC0Wi3GbrhD7ywJqR3RFc/B4voqzyEpE5gaR5YVLspIvcEiLdvDBmx0BI/SxkKt
 s8geU83DCK9GdpXf2DvqExbL0bLsa2pGHXGWTmlxg/i0uVZBwBjjIJrSOdSQofoh5tyJeyqmYZk
 BA5bmuPKQDGViuWT/OOKt8Aw4EvemqofT2y07fzbEZPhSqrvcbyM5daVUKd3LhfUuCmMjJFNBee
 5vsr861+p67tg0DYy+eA76oULBrIDAF717rAlNRMQNCeOy57mqDL/nU2yYge73nPRcHhcnb8qN6
 OYis09D5MqMZrSgsjCbhrA7RS/EXj17avSrykR34RT9y4M8Vek0Y/tJbChq8Q3rtcDMkE/Y6kPw
 00dD76JiDJqWYbEiv/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Joshua Daley <jdaley@linux.ibm.com>

In the dir_rem[level] == 0 case, level is decremented, then
a virtio_read() is issued on sec_loc[level]. If level is -1, then the
4 bytes before the static sec_loc array are read, and the virtio_read()
is issued on that garbage block number.

Guard the call to virtio_read() against the value of level to prevent
this.

Fixes: 869648e87eeb ("pc-bios/s390-ccw: El Torito 16-bit boot image size field workaround")
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@inux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 420ee32eff..ed6e8cbbc7 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -902,7 +902,7 @@ static inline long iso_get_file_size(uint32_t load_rba)
         if (dir_rem[level] == 0) {
             /* Nothing remaining */
             level--;
-            if (virtio_read(sec_loc[level], temp)) {
+            if (level >= 0 && virtio_read(sec_loc[level], temp)) {
                 puts("Failed to read ISO directory");
                 return -EIO;
             }
-- 
2.53.0


