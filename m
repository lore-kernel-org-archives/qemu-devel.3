Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC11CC5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 18:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOKly-0003DZ-RA; Sun, 08 Jun 2025 14:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uOKlt-000395-QC; Sun, 08 Jun 2025 14:29:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uOKls-0001Hn-C6; Sun, 08 Jun 2025 14:29:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558Au3kq008973;
 Sun, 8 Jun 2025 18:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ukOSkT
 srsF04UWONRkDOzrSwXmkYh2LCb297Rv8Mph8=; b=XSXJTbv3h8b5+xmrfZXOwo
 NQCNIjFEvZBa+CSNnw6a15P/ZTefFny5GAHGF7jKZV35RzhDPBOUXmDfxheCuqIZ
 6yB89hE4LkZMi/5scKc1SRwzjAE3/trt+CxQj3o0j7WTNDsnoQ0igmFhzDYcjCT1
 GnUYoO2hgI83AZ6wsjqZtVrNpJGXgeOPLWfUf0uEd1nrV9OVq9aeLEb9bwgc1w4Q
 7XoPvY2xpttKQFrEXI0dDo0aJj837er/B7ybE1Na2QOfcG6GPukl9I2XJDQlQGu+
 1wwaWTP6BITYFP/eC2orOrrqEh4FKKsDFPuRRasajCs0NwAG5WQnOTqooX4tOyAg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgu4ke1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:29:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 558ITJTn014809;
 Sun, 8 Jun 2025 18:29:19 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgu4kdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:29:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 558Gu9xa015180;
 Sun, 8 Jun 2025 18:29:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrt2wrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:29:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 558ITF5d55640392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 8 Jun 2025 18:29:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E62DF20049;
 Sun,  8 Jun 2025 18:29:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28CE820040;
 Sun,  8 Jun 2025 18:29:12 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.39.24.199]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  8 Jun 2025 18:29:11 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v8 7/8] tests/powernv: Add PowerNV test for Power11
Date: Sun,  8 Jun 2025 23:58:41 +0530
Message-ID: <20250608182842.2717225-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608182842.2717225-1-adityag@linux.ibm.com>
References: <20250608182842.2717225-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=6845d67f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=aow-egSQAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=M_iqQ_o7Tyesht7ruFAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: rETgZsZ8aLm4R63x84OoRiw9jomBeN0x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDE0NyBTYWx0ZWRfX62QplcobaPA5
 bB+suptlbdywusCqUQnw3NwWvHR1hOo0Bm2bYG22zQLIaENfFPJpW6RzJTe1ra89e0zBqmjXCXb
 1jHWDcWTOdacjYYnN1FAKWFVTbdDOacXbG8DAotNvAdObwdmHEZPJ8bAj6Dmpg1c1FkbIChl8gr
 aUWkPGnf2faQc8koNr5jVF0Ywjvc2teKmt1WmourlJdLUhaXXjIDK1+aSopbuZQ+RjHIjeTcz8K
 RevvlcPYAmYMlG5a31Lu26Tn7pjTjzJ4NQhqoNu2rdz1Q7ff7RnvkV93Uf+fv4GJtgd1uNbMxOa
 YIxtRR4fasqJQJY1DrZW6SQMdJTg0xLwArLlbdH/a3RwkjBPH+PN1PyRa54LCfI17Y4wXkc9Rt6
 KHvLKiLUPmtqIIhmJVH4Fs7yz8MW84VOfqmoY5a41PX7bQv4uy8rppZ8dcE1O1N3dTmDDFfv
X-Proofpoint-ORIG-GUID: yTp1PWdiRo4lFr612QpQRNNktdkE-nvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=759
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506080147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

With all Power11 support in place, add Power11 PowerNV test.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/test_ppc64_powernv.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
index 2b4db1cf99b4..9ada832b7816 100755
--- a/tests/functional/test_ppc64_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -116,5 +116,9 @@ def test_powernv10(self):
         self.set_machine('powernv10')
         self.do_test_ppc64_powernv('P10')
 
+    def test_powernv11(self):
+        self.set_machine('powernv11')
+        self.do_test_ppc64_powernv('Power11')
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.49.0


