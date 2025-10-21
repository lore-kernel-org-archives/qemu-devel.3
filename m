Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658DBCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCjc-0002GX-LJ; Tue, 21 Oct 2025 09:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCjb-0002F6-5A; Tue, 21 Oct 2025 09:49:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCjZ-0006rG-DM; Tue, 21 Oct 2025 09:49:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L33ekb031143;
 Tue, 21 Oct 2025 13:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9h3Vvn
 GZ8OLoaTVuyoC+Z/mhm5FI0cTT4sjt3vfC8/I=; b=eqw36apJD6TPEBmUGgKAfz
 ++jNB1iro+miFxAlOjM4QsRiR8P+ZqMDeCtr9p4HP9QNuf71L7c/aJWQ6FsyYpUO
 ln88/ZnOELWW0ciw8W0hvWp6ecaHgbZgpGuVIvgqLhOeRhh+eY6FueQNZ7TTxYGI
 w9FkqKV1jTtFz1coqK8Gk2Z3fM0qJWq9m0AFdL8x+h3AYjDUDjU4FlbK+kmnf/eq
 hfH6nBq9XBwgSx5Gaxw0ylisR706I2dCtX/upliLsA9XZWIDTMJ/g0zUZumkiazC
 d7mrATOaR3UxZZ1UTQTZ0PJhcjC3e2AVQnG/NyExsrnjA5E1FZIOH0pcFc4TvRYw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vnyme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:49:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LDXE3I010426;
 Tue, 21 Oct 2025 13:49:03 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vnyma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:49:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LAqrRi014650;
 Tue, 21 Oct 2025 13:49:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s376r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:49:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LDmw8729294892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 13:48:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95DFE2004E;
 Tue, 21 Oct 2025 13:48:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36BB02004D;
 Tue, 21 Oct 2025 13:48:55 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.222.96]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 13:48:54 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 8/8] MAINTAINERS: Add entry for FADump (pSeries)
Date: Tue, 21 Oct 2025 19:18:18 +0530
Message-ID: <20251021134823.1861675-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021134823.1861675-1-adityag@linux.ibm.com>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3xG7bqptrsQ7izL49-vIfwkB_FgdYuP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0bKdjiOQsqrj
 OoaJ5gyzKVzekHmLGR3gVtNnmco93ksdjr12ZSt2RoEDMev9DCtsJPIaMDGi5+bMdqtpGgfzg9W
 xMjp7t0cjbldc/anSh9QRhnhBa02dUIkX/9ozAWTHokwaHtFTMPDS9K6/Q64KAPso6eJWCOB+l7
 QDCjHjvaS/BLDWs/Hop62w+ks3FQpuDJ/AAaX6cBb5V6T1G0xWCtT2HvX+7kqu9/3pxh/ftn2Hc
 x8smokluuLwSIsPFbULhN2zyEcc+WfFe0xUVSGHG1YT7y1QqAF9bzJ3aw+VujnwVmLvzLIf+HbK
 YzOegvwSl9KMKtf5Dvtx0dOmpozHIVeHMYPT47Nm+48r90AZ1G0RWhwXDB6Z/6PWKgUM5/OHJwd
 BYhmpTFp/k6MxAEWZx0DOg27357p/Q==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f78f4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=mbnq6HtSZEenJqVaWLAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JS_TfmVSpN4E3XY9bMpoUe8Orb6tnEHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add maintainer and reviewer for fadump subsystem.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 667acd933c7f..5dcea23bfd3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3213,6 +3213,14 @@ F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 F: scripts/coccinelle/errp-guard.cocci
 
+Firmware Assisted Dump (fadump) for sPAPR (pseries)
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Sourabh Jain <sourabhjain@linux.ibm.com>
+S: Maintained
+F: include/hw/ppc/spapr_fadump.h
+F: hw/ppc/spapr_fadump.c
+F: tests/functional/ppc64/test_fadump.py
+
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.51.0


