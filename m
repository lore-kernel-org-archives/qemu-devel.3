Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974F6CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc20q-00028X-UG; Tue, 23 Jun 2026 10:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc20R-0001uT-IO; Tue, 23 Jun 2026 10:21:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc20O-0006JX-6p; Tue, 23 Jun 2026 10:21:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmlHO1858081; Tue, 23 Jun 2026 14:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2Q5lITYwff7C+vA6y
 WF3u7xIjdqUjtMgNUMvHZ6T6G8=; b=MxsqKRpZR6lFzWERxH1JPXT7eOezvCksK
 70R3dZiO68uErO+NHJnwPuUhBjXpgIyZ1nU5EvdNUWFfipZXYURY1KzwkSAxaZWF
 ftTLlSDfyqVtH4DWy6cX1kWyCsg7g1/O77OhPmIK53Vb1Tm+r5iSWXSvzrgJCN+u
 A5cU5xmXUU2yPjuzXPu26mKLdXtiRFRJ6NsMBPkMygF4t8JVh7fXMdGHmcge/UV1
 jNvb/605BPc5rxe0dELgv/rjTtkANYVH6Y6pVLXBXcioaR0oJncvifbfnkrolDfE
 umI2yLrq5QLci9aguhGLY7/JLdgePoyHBAyvzdDZxm83+ABuSVwUw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:21:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJexw005046;
 Tue, 23 Jun 2026 14:21:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykbkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:21:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NELTlE27853312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 14:21:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7039A20040;
 Tue, 23 Jun 2026 14:21:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 270522004B;
 Tue, 23 Jun 2026 14:21:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.165]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 14:21:19 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Tue, 23 Jun 2026 19:49:33 +0530
Message-ID: <20260623141933.577981-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KMWi70rAGIbYUS1g8iCXQw3Eg2u-osBu
X-Proofpoint-GUID: dGMcB4qe3UsTZ1E1dY1Zz_LOvrIsfTME
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a966e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX7UznYGksmktc
 +NV6bkB8xKUAoVbglGrxOMJsgmEjxNGo5w54llZ8Le/0zTDddCEByA+3Zk8V6Eud2OCyLyBZaMd
 Ivpvdg4Uk79KyqnshNXA4gaUGGgmp9TLoly/CnwADB7jFmD6y2Rrve0BG5b0/JorAyX/+rEq9y3
 6YtC8yFh5/ALvYEcJCH0k+zI4TXIcSVunx3n7v2lmhfyWeh+gZJWj0at1qpAh/PdE8f5e+eqkK+
 4ENgg7+VcBRJCn5rQxOhIYspTy7XEKFfIIDpM2XULabesxTSw8XNIYeVPBfYuTG6PiA/OtqnzHp
 k57YmJ1R9UKVDW51PmxmC7ddNE8bViVdKEmoWj9+5JiLYirc21n3fHav27o0CwKDkEcxEvBg/Be
 lhQgum8xPo9bgakq+BCmgDQAm9i31av7FJrAvT/mEMyqjZ/rlQ+cN8rl/+Ya5PuUSLkOjWzIlFk
 G3n/yTSAn/u7eVoVx3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX6nwz2R7F5uYh
 kKKqdZCH5/p7vAWJ+jaDlIUjbUj33kd5k4DgWyCar3w1kbPtugnxRQt5gdSJGKqhue1PEglodKa
 qUr9QjUa0BFZf6/h5mCK1ZBT2IHgdpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117
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

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f63..67f65bff3913 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Aditya Gupta <adityag@linux.ibm.com>
+M: Aditya Gupta <adityag@linux.ibm.com>
+G: @adi-g15-ibm
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.54.0


