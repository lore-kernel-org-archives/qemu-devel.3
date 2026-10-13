Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4F5CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGhEc-0004IQ-JS; Tue, 13 Oct 2026 14:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGhEV-0004HB-Ry; Tue, 13 Oct 2026 14:28:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGhEU-00028o-3S; Tue, 13 Oct 2026 14:28:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DEGDLZ151645; Tue, 13 Oct 2026 18:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=cFBPfzV21fUooRfqLNBhg+k5XiHeQVuXC+qog4DJn
 tE=; b=V1iXtrxXol+63UEHBPNctc21QaJDApsOZ4VjT9Vz2UB4l07Vxp5iKkK+A
 DF3gyTIXJIa4GnKz0v3TI3r37urupb+tasmo/EHB6tyaois8O4DE0UI2LkT8KqcQ
 K4ePZY9UqGzBs/S2GEdSKkZdK2q2ID6hqBfIiR91OnqZDa3y6q32RmmtlfFbQ3cs
 YJ3ao0kYxykEmMyWJgJKkLgYdRuyLk21N1UHOsR31ONoTJUlTXolXpuAb1P77OoG
 YLvqDnavzU/Gbo3nGva7///Yrrp32WmUTxDDlx1zuIjvM/W8icUGNPyRs5CeWVWl
 v1+SthwJJCBmk5wZKWOT9HkLs1lWA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhg559-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 18:28:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHwaMo3212041; Tue, 13 Oct 2026 18:28:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2yh213-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 18:28:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DIS7e949938728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 18:28:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3352320043;
 Tue, 13 Oct 2026 18:28:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96F992004B;
 Tue, 13 Oct 2026 18:28:06 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.35.59]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 18:28:06 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] iotests/108: probe loop device setup
Date: Tue, 13 Oct 2026 20:28:00 +0200
Message-ID: <20261013182804.103882-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfXyq+w79TgQyTd
 DHEYhxnqGGgTGP+ghW2ckdgAAUqX10DgHZntkKq5ArC1rrlrfFl4ITy+GvbSew10wSwQ6iYT74X
 kGxROzcfrdsoHdIsBcV7AoCWomC9wXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfXzVy59sbHkvxA
 msB73M6azkM/mY5tKu1uLYn8ZAwROhAxF4JhZsujYu4+URKVpr74n9sqsjih2dF2oIDXiUwqxvx
 qL3YaHa5Op3FqMqmv7RP90xtcc2Pzq8IUJYzp3+iThCwzfAB92gGBgM3M0+lIUDcw9IVediqfVk
 fOeNgr8o9yp+U9sO+35gfsdCAuNSsltS2tSWXyrMl0k4Fjr8YFN+HIMmVIZsW9wn4soNRpSTht2
 EaOTKAQ20qteCp4lKb7p1KKeXsV1752yanbQu7ma5dwdRCENPL+zDFxUgEyG9VslVx03MSbgJIy
 BSW+TOYc+oErJ0/3+V8o060X+4HTsNo2gizex0INzHEySNzmuug2ri2wdkNZXRS9a0T+jjiEIn5
 d5m7RAabJEm5bQA5mQel/wxCOccL5I8L9a+PEJ/Sk1wbpBadiZvmLyBAGB/15rgWxqUl2NsOaCE
 8IWFIVA8IjQh+TAq3QQ==
X-Proofpoint-GUID: sFYNv2zS3s7UIY4gJXVkh6qQ259X1o74
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace783b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=dgZOFHOvU9bSPEp8mi8A:9
X-Proofpoint-ORIG-GUID: sFYNv2zS3s7UIY4gJXVkh6qQ259X1o74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

Running iotests/108 in a Docker container, that has passwordless sudo
configured, fails with:

    losetup: /home/user/src/qemu/build/scratch/qcow2-file-108/t.qcow2: failed to set up loop device: No such file or directory

because it incorrectly assumes losetup is allowed to do loop device
setup, when in reality it can only list devices.

Fix by probing loop device setup, using the test script as a backing
file. With this, the test is correctly skipped.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/qemu-iotests/108 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 1de718188aa..adbaaf87095 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -53,7 +53,8 @@ _supported_os Linux
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file
 
 # This test either needs sudo -n losetup or FUSE exports to work
-if sudo -n losetup &>/dev/null; then
+if probe_dev=$(sudo -n losetup -r --show -f "$0" 2>/dev/null); then
+    sudo -n losetup -d "$probe_dev"
     loopdev=true
 else
     loopdev=false
-- 
2.56.0


