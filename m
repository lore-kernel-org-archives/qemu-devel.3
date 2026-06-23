Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77973CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc20F-0001Wn-W3; Tue, 23 Jun 2026 10:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc1zr-0001J2-OL; Tue, 23 Jun 2026 10:21:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc1zo-00067V-Eg; Tue, 23 Jun 2026 10:21:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmIPI1983827; Tue, 23 Jun 2026 14:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LGNgZMw1UEgMoxoYi
 supKjhdJLZKr9GILaxiozmZ6es=; b=tQTp5K8WOKs3FuQC+kCMehYRZb//jfN7L
 sUcediV/rJAYkOvOqfYx2nT7vKRaXzwa5D1GIh44ZwkLj/1RZJvMfvN+Y4DpDGz9
 wtT++PePUvGOWGG5phBkm7JoFUqLD1KvpR8RM3RdMkg2dLV0PZgnFDX6ELIrQrHV
 ca+4N3+b5XL71gx8xxvgB63KUYnO8foBQuureNIZGPOD1lMiXKOBhOoj/HdkGqYK
 GR/uXb4lcncz4jajNsaBlN3wz0b4m9tVqbYx+yq4kDgSRGr+iqaRpAPkfOWdBriN
 w/6QP1bUK9RF0Fh9WvV+UCM34OCdqXPyvJ6rmt29J2q9mT/ABvNaQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3f1jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:20:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJlob016983;
 Tue, 23 Jun 2026 14:20:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3ng1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:20:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NEKnUH38011170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 14:20:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AEA92004B;
 Tue, 23 Jun 2026 14:20:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CD1220040;
 Tue, 23 Jun 2026 14:20:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.165]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 14:20:39 +0000 (GMT)
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
Subject: [PATCH 4/8] tests/functional: Use default powernv machine instead of
 power10
Date: Tue, 23 Jun 2026 19:49:29 +0530
Message-ID: <20260623141933.577981-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a9647 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MGuuq5ZBRx0t7b6k6EIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX+zyd+WORj2PU
 dmrXHE767hBjw6RJhJ979j4Vh6UpusYnL78kV7hUURvigz7WTmPuf46j9Ayj3RPfsS2XOpyF+E0
 v8A4c6U9+dZ/8WsSy9K801MbX/5FVbE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX99YQK07LVY2A
 KkeiNSTjVItTySUPEWxmktgbj07oKl1LyCD+9tz4bNqyf5HRaxBYAVhh7pUbW3ZT8ZRsOZcMPwh
 haz8788WLydjHWlUQV+0fljoAJyV9z5f2YmSLjzihZ2NyjeAYMB969EsTmc5CQedPCoFpXL0vfk
 LGYvY11Og0dytfdp/60HYpjQ4yT9TUN9F2l4oZjg0xiSPxihQxXGvTifssAALmTGP8ArgK9U4xn
 knJog7tlFUD2edZpNc9SYV9RF4799v5kz2ZNMZAuluK3ApuvM5T0SQ2OZM/IIDx9s3IPdlEyyUG
 wLa/Q2WQ/+n767OQvUqIZyZrh2xtE+Dw15k1xyiM+6GNiebhJFBkKRjfOlAsh3Vray0UX4pWELy
 jlqHETCVWKSsN5I6SPW0vF0v1hvlr4bLcdzolIsYDr/y/zwVaIYgyGv7ptwZCHS4U5EX+lFXqAg
 2HhY6QYCjfn3lEYSt9A==
X-Proofpoint-ORIG-GUID: d6SsggomyJ5akhQGcassHHX56V947UXh
X-Proofpoint-GUID: K_EKy-WL-ZjcJz30zDxBl_z35puNVh6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

The default powernv machine has been recently changed to powernv11,
though fadump functional test used powernv10

Change it to use default 'powernv' machine for the tests instead of
being fixed to powernv10

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_fadump.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
index 7ea65974e0ea..c75095076b52 100755
--- a/tests/functional/ppc64/test_fadump.py
+++ b/tests/functional/ppc64/test_fadump.py
@@ -53,7 +53,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
             self.require_accelerator("tcg")
 
         if is_powernv:
-            self.set_machine("powernv10")
+            self.set_machine("powernv")
         else:
             # SLOF takes upto >20s in startup time, use VOF
             self.set_machine("pseries")
-- 
2.54.0


