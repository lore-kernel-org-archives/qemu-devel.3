Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4D9C9832C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABqI-0005Mh-AH; Fri, 25 Sep 2026 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqG-0005LL-Cd; Fri, 25 Sep 2026 15:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqE-0002My-5O; Fri, 25 Sep 2026 15:44:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJ5wnN1899757; Fri, 25 Sep 2026 19:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TS3SB6PFD4hCLWCbL
 BgW+H8Im7wIqQY6gwS23F5/5vM=; b=pnUZO3vNV3OgSgkk+0kOJ2VzLxh+bZI14
 ZOiks3nVGeVRwL0hrEa4WVRR7StdHfqg9ZgS642qpmeOQnSnN503SH2V8v0PCWML
 L6SVOO3bg66BKao+TjgYCkgi1eJJmsOnImxsVR/6WuP1HiM7IepLPvcrQo9JTqVU
 5u7VWXmGXobXhiVWNPjtC9RrkiaGbXGbzabuVGasGAdlSUCiqLO35NnNil5OuEo7
 rEGQl8Mr9YpKUF0taUHULVczjyGtZ3biT/kILlkTiuvwf+woiYAomvSLW///f3FS
 THHOmkOphw8ILtOS8nFFhbkvNt/5RQ82+IWC0Dheyb2z0EsEUvcdA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg312rx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIlxgW132229; Fri, 25 Sep 2026 19:44:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gwwsfrcus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PJiBT036700542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 19:44:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3031320040;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EA0D2004B;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C98B4162303; Fri, 25 Sep 2026 21:44:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, eblake@redhat.com,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 5/5] iotests/iothreads-nbd-export: Skip on s390
Date: Fri, 25 Sep 2026 21:44:09 +0200
Message-ID: <20260925194409.716498-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925194409.716498-1-farman@linux.ibm.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ICmmUhe4fbEtKq1xVeaTUQGBBWWH8-mR
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6cf10 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uhQAi5MUBj_ZaE3ncFsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX9CEU/SHfymT5
 PQKQq+MTqBRECG0mi/ZLslZ6Sf18/2E22vZHn1Pxyj7qW7Is5POVWLbs7kEpnTrEd7UiBjzAQG+
 lSJPlqk2ukXoKTOE0Qtu5ChCEAQyFNjDIURnfdDooANegycrINmsv43QHOcOW+Q/J/D9tZCeD7o
 DMF3AbdGLdPt1XbZQqxkcWjBbQrSUq5yLqq1/awV6z/7T7I0HRnkNMoOOY7Sb2bWJphkxBB2TW2
 9Bql4DIrCiFslOMZWhmHmrINdUW2vu7nJ7v0sntjGArg3g6j4LniHZszgtDZhpPVTieISfd2qB5
 hfbxYfK4ud8mT5VC3XB8FYhmPq6ld4hk9oTLskAnzcZiG/rxfshgJ+96XN3OLtlWbYrrLOIG8Pk
 ejlYRHuxOJcsYHQvGJy8g5kqaVote9yMhR4ilzGQOzZI4TcAFOekkl6oeGxIOsebFZDaQ6RXKjV
 Pcd3aBNTuLBlIXyyjaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX5Glkv/oSRAvm
 rXe5vN4ajBME/t59AbD1qLDfpk95Oy1jRmNI07i3uDVPLI8Plhx209r5H57TGsWO6QbVbbkjdfw
 z+OOaK03DIovmAh92Wrn14sjfLY2oTE=
X-Proofpoint-GUID: ICmmUhe4fbEtKq1xVeaTUQGBBWWH8-mR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

Running this test on s390 causes long python exception tracebacks
at the beginning of the system_reset loop. The problem appears to
be the same one described by commit ad302b21aab6, in that QEMU
will exit on s390 without any kernel or boot disk.

In other tests, this is addressed by adding -no-shutdown to the
command line, and that does create a clean failure instead of a
long line of python exceptions:

  --- /home/farman/git/qemu/tests/qemu-iotests/tests/iothreads-nbd-export=
.out
  +++ /home/farman/git/qemu/build/scratch/qcow2-file-iothreads-nbd-export=
/iothreads-nbd-export.out.bad
  @@ -16,4 +16,4 @@
   {"return": {}}
   {"return": {}}
   Checking that it is still alive...
  -{"return": {"running": true, "status": "running"}}
  +{"return": {"running": false, "status": "prelaunch"}}
  Failures: iothreads-nbd-export
  Failed 1 of 1 iotests

...but obviously this isn't still a successful test, since it is
expected that the guest will be still be usable after the reset loop.
So, barring a solution to that, just skip this test on s390.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/tests/iothreads-nbd-export | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/tests/iothreads-nbd-export b/tests/qemu-i=
otests/tests/iothreads-nbd-export
index 037260729c7..72493ad2279 100755
--- a/tests/qemu-iotests/tests/iothreads-nbd-export
+++ b/tests/qemu-iotests/tests/iothreads-nbd-export
@@ -25,6 +25,11 @@ import iotests
 iotests.script_initialize(supported_fmts=3D['qcow2'],
                           supported_platforms=3D['linux'])
=20
+# QEMU on s390 will exit without any sort of backing disk,
+# so the reset loop requested by this test will fail.
+if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
+    iotests.notrun('Cannot run test on s390')
+
 with iotests.FilePath('disk1.img') as path, \
      iotests.FilePath('nbd.sock', base_dir=3Diotests.sock_dir) as nbd_so=
ck, \
      qemu.machine.QEMUMachine(iotests.qemu_prog) as vm:
--=20
2.53.0


