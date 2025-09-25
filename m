Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904E2CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ppy-0002di-GF; Thu, 25 Sep 2025 13:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1ppH-000266-8e; Thu, 25 Sep 2025 13:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pp4-0006GD-MY; Thu, 25 Sep 2025 13:32:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PDI15X028853;
 Thu, 25 Sep 2025 17:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=05lUZn
 0BGRhevZXh8CeX+dFP9XQlxUmiQ2UJk9ohODM=; b=XI7Y773WWbHQ8fLDVez61M
 vH32Y9Z4s0caQYZ7zII7e2ymAoPH7bgQxGi1nvJiaMk1BKNxmuysFeWWAvmrQGVt
 q4ZR329EoMZMO+X0njZdup4NQqWEb72FBqWbwHtp7y2wa6hIa3CbYBpC++/ReWfD
 eNSDVPhCHbL/3GW+yv3dVMoJyW2QuFNT11jSrvfLNjqZoJzzeCsJdoclMGlx0kYZ
 nzmS+VvBmEZ0OWkw7dz+kjagVLLb0Ls+2tgY9GK01EpIlmLXuwNj0pY/xQX4FjN8
 MO+80nZP7BqqqDmD5gw6eYF+RUw3gvFPbU9LO1ZR3l9tiCd03NJNz+C7W2HjNUXA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqprvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHGD6T025753;
 Thu, 25 Sep 2025 17:31:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqprv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHB098013638;
 Thu, 25 Sep 2025 17:31:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjq07u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHVq9047120780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:31:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F39AE20043;
 Thu, 25 Sep 2025 17:31:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D1D62004B;
 Thu, 25 Sep 2025 17:31:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:31:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v10 8/8] tests/powernv: Add PowerNV test for Power11
Date: Thu, 25 Sep 2025 23:00:49 +0530
Message-ID: <20250925173049.891406-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d57c8c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=J8gcU684rTO2RAhmCq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kuq2oLIAqcZHsmM3vOFU3hLNqpURGWFW
X-Proofpoint-GUID: imtwd9zvsGQlydjeMUxyIGe-OjRhC1AS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX7MtOuHdOkZ93
 vdVo8ciCYwBa+mMT3/CP4u5Qoh96/88lhrVfTKgJl5cZdS6bGC+fE6fmAlkQfHYL5zscrr7uRtB
 AXul3WVdwcCnerGmyX4CdKP/C+m1m3Aucy9c0MzOLfbMh1y622lwWecf5R6wfmA+s23k/lXTSOC
 /GJtSG5w2uhVdGjqsa3Ux/ptkeekv0Ci7HJLBpfNUofo2r46YE/mM+8JwRdgEvPAdwt8+QGYiMl
 hL/nAi6LSK/3gNvAi74ArOmF3gN1DfgIucSkZSr31py84EmXHDV1mZqm2nQRfFeDxPoIUPaEO2g
 9Cg6bFwP77k+EBbFArkd4UdJG/6xa+sHoKfSaUU4vqX/NqB37pR9T/Ie8PxBx3TkwqiuV/ENkGJ
 VE+WVJTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With all Power11 support in place, add Power11 PowerNV test.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 2b4db1cf99b4..9ada832b7816 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
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
2.50.1


