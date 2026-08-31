Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728A1C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180k-0000PP-Hc; Mon, 31 Aug 2026 15:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180g-0000O3-NT; Mon, 31 Aug 2026 15:49:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180e-0002eD-M8; Mon, 31 Aug 2026 15:49:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVYmu3115264; Mon, 31 Aug 2026 19:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FxCr26HQGGPcNVJuI
 cyctYV5TU9dYfbvI5MmrgksQyA=; b=UL7OhOarTRc8OPpnPNOAH4Tvt3832eKVa
 krTdckOnkm28+3aLjfh7SDTUj4lWUmE5dJovAYCucy95B22mTzQMAhDv2mlAXVJw
 TsRtNLudzd8dKucn/BN+1O0FePrp8waSssW9f/tvqafVuzvpWf18lUFccNpEYKFD
 C1+gMFSebBiZPp5Kf8LQVvE5AWM1NW3mWZ5Chu2ICkeRE70kraT20xZAdf4HaU/u
 ROsON6opyw4SaU8qPmce7ka3G4CVpSHqm1sHpaR3dmFC6gZnt4oUQSWiie6kT3o7
 ab4Lnl4Zj7VnMct+myzDmVnW7ygrcUC1r9nm3OuwOtl/UxH/tzxZA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5bhf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfNYh028717;
 Mon, 31 Aug 2026 19:49:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg7kj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnX2u64684292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3812A5805E;
 Mon, 31 Aug 2026 19:49:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9983158052;
 Mon, 31 Aug 2026 19:49:32 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:32 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 8/8] tests/qtest: Add s390x PCI SCSI fallback test to
 cdrom-test.c
Date: Mon, 31 Aug 2026 15:49:19 -0400
Message-ID: <20260831194919.3830270-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95dacf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MvDj_lKWWGcuVSP3geIA:9
X-Proofpoint-GUID: 51pxN89feuFZ58BeuUbKKZKdZ7PuStlB
X-Proofpoint-ORIG-GUID: 51pxN89feuFZ58BeuUbKKZKdZ7PuStlB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX25KVFR63EDJ3
 RcdgoC9HrZdqHAxyAV+0EKjQbsCSf40RluasZ7h3AHQSumPjJK1ztZM3trXuvYLzDykz6vCvlIZ
 FMARP+mPw40H6r14NrFbjTANzU171K0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX7pmdwK1MrqF6
 FXMBEjkDmfV7NG7F8I4kFa0tsfxYhaKj1Byu6wsdatmCcsT+REtA0HcfLngf8bVpZ5Ucf+4eiWj
 8d/R2SsfnHFxTs8QLQBOXgoeQ5Ha6KJFf77+ZsUbHDOXhBt0JDiPEX+CKmjDtkKY5BqrQjDtLVS
 JLONBnGb9i7Lr+AW02zHoEJ1Eb6kVNOTZ6EZ9/fmPJ8Hy6oH4l9QKK4yTyxQV2Pr6Mp28gEeRI6
 tdRI2BZyErv7ykpSYV9QyQj3ZAEfYC1vVqim0UN0GNTzK+NsR7UCniqDPXYdWweMvFkA5QM8SRK
 dr4RamX3RmhMji2nTbcSXbXZlZs+wf1d8WXb63XtZ4Qwm9u7Xxm7UXNbzQLms4VBzteTmqX+2KU
 QEglbJv7bbd5ktgyXJeHSvrtNU7mTZik9Daf6UUAcRz28d3+m/CT99hjs1grxhldJfff2XeY4pR
 DNDaYSoS/wNZi47bjDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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
---
 tests/qtest/cdrom-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index a65854d2bc..ab34930404 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -253,6 +253,14 @@ static void add_s390x_tests(void)
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
2.54.0


