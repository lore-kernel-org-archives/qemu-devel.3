Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6DB107BCD9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18Um-0007XN-8o; Fri, 13 Mar 2026 15:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w18Ue-0007Vj-Ef; Fri, 13 Mar 2026 15:48:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w18Ub-00068u-PV; Fri, 13 Mar 2026 15:48:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DHcIAu2301842; Fri, 13 Mar 2026 19:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AETrYUHQCKOuzXIRL
 v+DUMjfkDpdINQ9nHezRDm36Os=; b=Y5vHX1sUnMR9gXYBh35gASs+97s2zqyAA
 fG30d3sszIEBeIMpeIuzj4MQD/ZKIN6q2dkMWASNuy0MzA3G2GJFQZUY/YOx8RqX
 dSYcvjglkIfgfv5ubfd7ig8FaX27LEcymrr7P+G2uGdbtTK0NZPfuuTtUZLfujku
 2920gWichD+9ABJndTWTwLf8D9sP3X5z0ogT66K5Z3vkNsfy2kwTgLpn8FHl1n/B
 PkMi4tiMeVKS6bH6tslnflUA0qf1PUs0kxlHbpeh0uLH6H5wotggVSxOanGZgHiu
 Q9BSV9QwGsJcKegsfvKVanZ9yItnwFw5RA3eyOzru16ahWmL2sEIA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96160q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 19:48:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJXp8X025681;
 Fri, 13 Mar 2026 19:48:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8g39h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 19:48:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DJmB6C62456098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 19:48:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03BC82004D;
 Fri, 13 Mar 2026 19:48:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2E9A20049;
 Fri, 13 Mar 2026 19:48:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 13 Mar 2026 19:48:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id BB3E0E0038; Fri, 13 Mar 2026 20:48:10 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 1/1] MAINTAINERS: Add another reviewer to s390x boot
Date: Fri, 13 Mar 2026 20:48:10 +0100
Message-ID: <20260313194810.1844241-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313194810.1844241-1-farman@linux.ibm.com>
References: <20260313113424.15583-2-thuth@redhat.com>
 <20260313194810.1844241-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfX5ikVwF6g4Juk
 8f0FoTns8kachCCsaowOHXwqiCUO9vj0YFKT/uq9bY4m3eNNgo0NwUxJo4z7QFdUISwgsikGHpi
 4vHHdU3yd+sQNA66JGeRWWNXdep1gFxO2EK58vGPofFzXhs5TcPN72vL3d8AkU1fiXfSfeIao/Q
 yoQVdC3hLqsEnwmyyhNUvwMB3HdzZFf1U277ZCT0p4pT7cd7gv2hfsgrJ6887jez5eJ7XGFqpTc
 CjVsrGDHEWwJqepQd9fZz6YCvkK4UvStYjyD6NU2tQUbVoIbOmpBVyn2e3DHrf1A7sf/A6JtRxo
 hTWMFB37hSM6jn8y25jeUnVGZ6g/8CNnENfG8RIxpVs5NVdXLK0SCkA1LGOpycN6Yqw1XyxNLR7
 55ghp6dihYBJLVwPZrV2koTv1TfMh7T+6l9nATeew2R2tGCg262DfHQZmwXEQaX1p32Xweviv7+
 ikXIKIGke0zDew4+INQ==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b469ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=QwBb3BLNbpGYZBIvMrQA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: akU5Gtd0cwRi6nHbO3dLyl5NASWI1suS
X-Proofpoint-ORIG-GUID: akU5Gtd0cwRi6nHbO3dLyl5NASWI1suS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jason offered to help review this area of code;
let's make sure he's notified of changes.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23562aaac2..e83ff3826b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1866,6 +1866,7 @@ S390-ccw boot
 M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
 R: Christian Borntraeger <borntraeger@linux.ibm.com>
+R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
--=20
2.51.0


