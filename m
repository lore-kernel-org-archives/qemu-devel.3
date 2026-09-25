Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5183BC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABqH-0005MO-Dd; Fri, 25 Sep 2026 15:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqF-0005Kj-5P; Fri, 25 Sep 2026 15:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqD-0002Mo-DI; Fri, 25 Sep 2026 15:44:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJ5XNb711808; Fri, 25 Sep 2026 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uEZRFnRHhcgGmSX5H
 5vYPxzZuLe7XWkXkDb0FKlgNXY=; b=ZRsts4R/WntJsYTKq7QqrKCR7dyGkJa3N
 0LAYu8M/IKzxDYZQKRYzUCapfk9iH2IBExiirAwhNQfoZxyc40SRaNoMlY/9iLEP
 rzPHd30tItQEnpkx4IhtsI86BEmwR+dq9g4HajkMfJ8zJT0aQTGqwhXCnk7bd6S2
 eMtP2dgn11A79VseNbSC1zzJJ6i/CicdGc7cyRc4UXVqdfV8gbDUM7SbjmpSwjnC
 HL/CCOMceuh05R7XLm7vBNDi3RPvWiecJUADC2GrJMaX3iLhKHDMX83p3eb0YTXA
 v846IJGmtC7zhlV/E6/jX4MQZXA7OVHmjGZvbJDk8kNN1QR2BX4sg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqyuyq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJMDst214581; Fri, 25 Sep 2026 19:44:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gwy278259-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PJiBgq44564842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 19:44:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1528120040;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0A522004B;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C7980161EB4; Fri, 25 Sep 2026 21:44:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, eblake@redhat.com,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 4/5] iotests/108: skip if fuse is unusable
Date: Fri, 25 Sep 2026 21:44:08 +0200
Message-ID: <20260925194409.716498-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925194409.716498-1-farman@linux.ibm.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6cf0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=g5ZYLniJXgBoyFi4TRgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX1ggbfduCwv4a
 +S1NIXy9yrI8ynCFIyBWFWGxXxJQhOocXmYtadDFk1MpoihiEUmdMzNaclYljab4bHqIcOv5SAE
 re2Tz1XTqFuBasqDKS/cxidVg54H2/vXKFs6rrwbHoNRmqMkkliU8t6Ly3LLY4SYzdVLG2ORYc+
 pf6I5qKEYqnqj52wDnRlNbotQNccsdfTQsJA0KNKlFwWSVD1JQXLQ2fDFoatOPdKhElEwQ7eZrM
 xBEtBH5To4DfBwwQVuvO9CL5BRLGDPbfz3FSdB9yv1psOaReknMca9Iyw/xjCArk2aWJK3Q5/If
 nMJhLK5kn5Qy2ldvazMW5XK3HCjbRBDaoTROiaCfiOMQ9FzgkJzac1ilw8g0iPH2QmZtRgiz6od
 G9d8zhKkuIFcU/Wk0s/j7JpMjG1/xSNw2yWbsD33hpJaTFgfFrcFIPLF9FN2zAgqIECwDpKefCB
 uP+QkjMp2LjufneRFRw==
X-Proofpoint-ORIG-GUID: cUfVdY0VzJLtgu14PIDcHGdL8KhOm6HE
X-Proofpoint-GUID: cUfVdY0VzJLtgu14PIDcHGdL8KhOm6HE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX2VQVtzsK3Ooo
 yKXBQlc153URoiJoMg/tSL+NThjJnvfOpu87WleONfdalby+P0whuEcDFhJfuDJsNjd8IrFpoZg
 oCrwhYddu+uB8vng03WKfnaZ9uY0Jyg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250078
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

It is possible that the ability to fusermount is restricted
to privileged users. Rather than waiting for this test to
perform a mount and subsequently fail, perform a dummy mount
early on and skip the tests if fuse is not usable.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/108 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index bf808b35125..fc3f7322678 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -73,6 +73,26 @@ else
         _notrun 'Passwordless sudo for losetup or FUSE support required,=
 but' \
                 'neither is available'
     fi
+
+    # Test to see if fuse is usable or not (permissions, etc.)
+    export_mp=3D"$TEST_DIR/fuse-export"
+    touch "$export_mp"
+
+    response=3D$($QSD \
+        --blockdev null-co,node-name=3Dexport-node \
+        --export fuse,id=3Dfuse-export,node-name=3Dexport-node,mountpoin=
t=3D"$export_mp",allow-other=3Doff \
+        --daemonize \
+        --pidfile "$TEST_DIR/qsd.pid" 2>&1)
+    _notrun_on_fuse_error "$response"
+
+    if [ -f "$TEST_DIR/qsd.pid" ]; then
+        qsd_pid=3D$(cat "$TEST_DIR/qsd.pid")
+        kill -KILL "$qsd_pid"
+        # Wait for process to exit (cannot `wait` because the QSD is dae=
monized)
+        while [ -f "$TEST_DIR/qsd.pid" ]; do
+            true
+        done
+    fi
 fi
=20
 echo
--=20
2.53.0


