Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343E4C54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS5-0003BO-FU; Tue, 28 Jul 2026 15:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wonS3-00039n-S9; Tue, 28 Jul 2026 15:26:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wonS1-0001Rp-4a; Tue, 28 Jul 2026 15:26:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIHg0G1847795; Tue, 28 Jul 2026 19:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tcocHMKGOitFbIO0A
 iuKvq9Jkdg0WyqmIl2Fj2ZS+Hk=; b=sMIcCpzqtaijlpQH4UrlAzzv51C1P3WR3
 eUWnh8tGqFotnk9J2WiMJdiBF7C5W59nX2fhnUu2OlvnSo5viGmUOxWlmYlAME5h
 k29FPCH1QfkmqiB4KFsmrXJElL4gUqwugZ8SCwHfW6+ooiqHRAr4RqQge2POCt2P
 M9+Y2wdxPI/dl3McQjsXB7wckbCDDmfLarR1C4rpm3pvnXUML3rma7suH8XbyOVI
 8bJVfiUpQRgdcCIZZy/RfPFYriZ20gvKOyzOYHdMAyz+ddnvQjliqx+E491C7o5i
 NpLEXRQQeU1XxDrdRVhlm9ZvZ+i+KH4J7kMM7DWjVpSs855lqD+bA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj6jre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 19:26:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SJQHt5003853;
 Tue, 28 Jul 2026 19:26:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgbct8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 19:26:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SJQklU30867812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 19:26:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 910F42005A;
 Tue, 28 Jul 2026 19:26:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BFAC2004D;
 Tue, 28 Jul 2026 19:26:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Jul 2026 19:26:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 2D855162820; Tue, 28 Jul 2026 21:26:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/1] iotests/108: skip test if cannot access /dev/fuse
Date: Tue, 28 Jul 2026 21:26:44 +0200
Message-ID: <20260728192644.2879028-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728192644.2879028-1-farman@linux.ibm.com>
References: <20260728192644.2879028-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfXx2y85RytcmKD
 bU5ngO7BCnvbwZHU7aGJ20FzCwphRn+GlOaf4GEzZhDOde9EMPUUAZkd7HUpw10cx+J9RVeOoND
 obZMa7MDHjng1W9ewjqPYuiJ8t6ARyI=
X-Proofpoint-GUID: b1ytC65bCRHm4ZIq3UmF7S5anIqxjR-3
X-Proofpoint-ORIG-GUID: b1ytC65bCRHm4ZIq3UmF7S5anIqxjR-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX90YQuZ1XYHH+
 jsejzUBmwALkuw9EWvLiOphfRB3FoSaLESQf4Jh+A/RPeuYeCHNI/8gDNw/BDHABoXP6A34ztYk
 /vJHKgD2J7vcT2D4ssDrDdJcWVepTgaf4K/8hO7LyfKu07jzdOUzUtxJjtV5VOwYbnn2e8OJSrY
 c6AXSmVESHTvYJF3x3ocJTi7JWitqdc7bvIJ21HabscCHbnqZYZj7xJ26DtzomTzc/MSekhuEw/
 pctA4jKvZcEJ2qfqiZOIYY3cPNOiQ33iszICUXs2QHh42flvXOgwlI0txVPAA8hn+u88udCjvPA
 jThpdEHtW49te67c+0ISAOXOaJviPdMajqG1uj8sNwLXiqGHf3d0Ivu8w4EHzJ4EY3pob0dT3X6
 /gLdgpq2liPRn00x3dYPylFeaZN38V0cn+YTRP4BN59kukybRKDZJRPbifu8yB5npIwhIys5x1q
 hTZGrAchHzUpuiFue9w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69027b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=6rqHouBjAAAA:8 a=VnNF1IyMAAAA:8
 a=1E8FyHytxJbjzsJNRtcA:9 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

This test might fail if the user is not root (or sudo'd):

  fusermount3: failed to open .../scratch/qcow2-file-108/fuse-export: Permission denied

A check exists to try to cover for this, but there are
two potential error messages that signal this case
(per the comment block associated with the check) and
only a skip for one of them.

Update the common fuse check to include this message,
and update test 108 to utilize it.

Fixes: 9ffd6d646d ("iotests/108: Test new refcount rebuild algorithm")
Based-on: <20260715103451.1930909-1-den@openvz.org>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/108       | 5 +----
 tests/qemu-iotests/common.rc | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index bf808b3512..5d91e58943 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -69,10 +69,7 @@ else
     # or "Invalid parameter 'fuse'", depending on whether there is
     # FUSE support or not.
     error=$($QSD --export fuse 2>&1)
-    if [[ $error = *"'fuse'"* ]]; then
-        _notrun 'Passwordless sudo for losetup or FUSE support required, but' \
-                'neither is available'
-    fi
+    _notrun_on_fuse_error "$error"
 fi
 
 echo
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index bcb1ec50a9..844c19d15a 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -986,6 +986,7 @@ _require_drivers()
 _notrun_on_fuse_error()
 {
     case "$1" in
+        *"Parameter 'id' is missing"* | \
         *"Parameter 'type' does not accept value 'fuse'"*)
             _notrun "No FUSE support"
             ;;
-- 
2.53.0


