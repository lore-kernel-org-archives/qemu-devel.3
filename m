Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713B1C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wefdg-0006C6-DK; Tue, 30 Jun 2026 17:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wefde-00069S-EV; Tue, 30 Jun 2026 17:05:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wefdc-00039E-Vd; Tue, 30 Jun 2026 17:05:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJII5A2792815; Tue, 30 Jun 2026 21:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mjFyNYga0uRVy/7FE
 f+33TyvG9iJ1nqEywN9R85FJvc=; b=TcIYFMsvBnUl/5TXuHAg+3hc1Muu+JVzp
 6Oa7CeuPQ/MtYa/XEk374d2P5ssn8sVkYclmvOBHA3i5dUS/NXUv8tG2aWrDLzTc
 /s2lf5Jr2V6rkH/fNYWFIApSpCzTWFkt9wLUbnXaT9rBUOrsjddgPUeRyRsK95w8
 G67J7z0LTY5a06uAS5STsiudPg+/w16yqZQZOA0ZBGt+gVv0/TtrPLX8+ga7vHB5
 Yw0dSnc6J6oh8En4poXePdA8lKrooJXhB+2m81hGh7fQO1vXFO30+KL/XF/SSMGd
 EkkgmqHR7wUW9963XX1hfzxGOTjlbV8ASKL6td5ziNGTpFI3pZ0jQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjrvew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 21:04:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UL4fR5024212;
 Tue, 30 Jun 2026 21:04:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyc0gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 21:04:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UL4nWU42533224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 21:04:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7536620043;
 Tue, 30 Jun 2026 21:04:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 433E020040;
 Tue, 30 Jun 2026 21:04:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.35]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 21:04:41 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 5/8] ppc/pnv: Replace Power8E with Power11 for 'none'
 machine test
Date: Wed,  1 Jul 2026 02:33:52 +0530
Message-ID: <20260630210355.789109-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX1gXSD6q3gtiX
 FpaOydIYVgPk1W3tVu6EHZqGBs1dCiiAbwOY5QiAN+9YAYvWtSrbWOuzZ1wo7MQ3kEQYh80fbdI
 nkfH4fUvXdJh1KNMvXzMqaHuETmlaKRSS9qYxyul0nxNRnanMpkviHvlDF39J126I8E6m6e/WvC
 HLGBWt1awqye8GtnuBkFZ003zeJKua2n6Jfc4U8BaFfCFiHwb7nk6LCkCHfMuxs6lNGeWGD2gsc
 GfGVLRy8j+fkzbXOXzykP6iSANCir8iPPewUN/bc4mhqO83yZVG87bCb6xH7Xa9PsJmRvnXHWEL
 UTpHUYebdJ1rEkg25ENaBSsafACmqzoUZHrM1mi3+Uw8nvwbX/W4kbzF0Lu62Gn0ScgRUiKGXUQ
 hlFN/xCE1iaULJRR9HA5NxuIPlUYMM+EFdPIj43S5ZoslDTzcSh/c/Lap+/EyUrTK4I0fE7Za77
 /zKiqy+DEJl+NHYaGhA==
X-Proofpoint-GUID: Mr1BoHWU-m36-7zmxtNcglrhk_iCVbX9
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a442f76 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=F5hhBwQ8Fieae4k-f6wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfXyZl+kEphK+Kt
 XF+Ubss05zcdxZ1TO1gmV6OAmrPfnV1YWIbY1XHOEZluT21vDHbbnb0dBjgYLoSiXmgMUIKvY7T
 MsUZjjgogYsNy4Im4KFCkqP54XCjUdE=
X-Proofpoint-ORIG-GUID: gTc7LVOy3csRssbMZ6VFBHuHNR9o9xtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

As Power8E chip is removed in future commits, remove the use of Power8E
chip for use with the none machine test, and replace with Power11 for
ppc64 test coverage for the test

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/machine-none-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index bafd7d660ec7..3205df190f35 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -38,7 +38,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips64el", "I6500" },
     { "or1k", "or1200" },
     { "ppc", "604" },
-    { "ppc64", "power8e_v2.1" },
+    { "ppc64", "power11_v2.0" },
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
     { "sh4eb", "sh7751r" },
-- 
2.54.0


