Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57BFC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 13:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncFd-0005RH-26; Sat, 25 Jul 2026 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wncFb-0005Qc-BL; Sat, 25 Jul 2026 09:17:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wncFZ-00084J-Q2; Sat, 25 Jul 2026 09:17:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66PB1mYd504578; Sat, 25 Jul 2026 13:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vQ3Iu2ocwAcAVC1ad
 UnZsR3HYKveZkv34EC5f2TeF2Q=; b=P8CqE7SmQu8oK+o2a/OOlZNYBMWFTqcnR
 roeBIpXBHtm2qsPaN1tJPGEwyCI+B1Ot8HZjPLsA+AbUKYsNXY9kCIEv3PiNSqR0
 Vop9aG6PK+RF2h07w5V+UnnuVawP5h/AmGJ0Qa6rm+EFE1ocQGzEoot09j0MQENK
 5xffh2zC91e1riZb34O5rZlD/SMd1xZFIMj5KgT2aFEvRHsiQpXw6s+FUwjMFl4r
 CpbKnQWkzWkz7sF++vJgQSA1sEN4eAFIhGRQDbXr8IKgr0EH+C8xi5VHudeBuSsG
 MSvhgbjnCpxExuZ3BF0gov/Rt3skJqLPwxrg52i+KNb/ZfWs0GzJg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcg9gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 13:17:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PDBKlu029828;
 Sat, 25 Jul 2026 13:17:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h9bqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 13:17:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66PDH1nv7143686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Jul 2026 13:17:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 965B5200F6;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 785D9200F3;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 5F99016280D; Sat, 25 Jul 2026 14:56:52 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 3/3] iotests/fuse-mmap-shared: complete permission denied
 check
Date: Sat, 25 Jul 2026 14:56:51 +0200
Message-ID: <20260725125651.3896151-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725125651.3896151-1-farman@linux.ibm.com>
References: <20260725125651.3896151-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rRTLB0GoUBwyM5HqLNCcFz0359J6KEvF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfX+/gl2FTG6zL8
 bwMrODWkCnQxdEcgVMRmqFUVs6UlY8VB3XOBPgyrNYFy36U4mxPb6b8kbmqSaa5D7K6SXYyJinD
 uCSu7Bq14ybFrT53y3Lv8IxynL3vYFY=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a64b752 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=wYm8ukeX07llxbEcVw4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfX0G2cLqcKMfK6
 aZea/WmhlVx1x8Wfj7sIbbtXSL8rHFdcSX6E6dVqxeOH5Buwx7JFYt83PICtHiBpWvcYJU3fu3M
 j+cptE1CI2dpB+AulNBtufQas89TYeQxT28SgNW216sdBiz5CcHcbYD0G4595ZOSuzwwjaruq5t
 VZ0ZhakXY9qUzB6Cc8J686RKRb50p0FYe/f/AK4VQ1zgzU3Q8+zEQtjXcYnYzs7YJzxwai7Ms1/
 9ZbYSYYKNacGuUdqBji5jjHG/KkefLkOow2eeeGJXiViuccdXZm7xQIIqym/3+S4mhafoeFDZia
 srMkaY4nEgieQbIghtNeUUW8gW6E+a7WTahDp9/PjKibn9mu3dESdJJMKlaobZUd8B55U3oDe6j
 +Fsdm24EfXhaLptUwogVGAuDkRQRU4sj15UzJjUrY1bMwbTNCB61ZveT6mq0iqQows5QYB6IJQj
 j7MxoQPH5DgyU5Q2qxA==
X-Proofpoint-GUID: rRTLB0GoUBwyM5HqLNCcFz0359J6KEvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250120
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

As with iotests/108, there exists multiple messages that would
signal a permission error when accessing the fuse tests:

  fusermount3: failed to open .../scratch/qcow2-file-fuse-mmap-shared/exp=
ort.fuse: Permission denied

Incorporate an additional potential error message to cause the
test to be skipped rather than failed.

Fixes: ba20257d9b ("iotests: test shared mmap for fuse export")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/tests/fuse-mmap-shared | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared b/tests/qemu-iotes=
ts/tests/fuse-mmap-shared
index 52941a3bb6..faa302e4db 100755
--- a/tests/qemu-iotests/tests/fuse-mmap-shared
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared
@@ -28,8 +28,11 @@ def test_fuse_support(mount_point):
     })
     test_qsd.stop()
     if 'error' in res:
-        assert (res['error']['desc'] =3D=3D
-                "Parameter 'type' does not accept value 'fuse'")
+        print(res)
+        assert ((res['error']['desc'] =3D=3D
+                "Parameter 'type' does not accept value 'fuse'") or
+                (res['error']['desc'] =3D=3D
+                "Failed to mount FUSE session to export"))
         iotests.notrun('No FUSE support')
=20
 # Shared mmap when using direct IO is only supported for Linux kernels >=
=3D 6.6
--=20
2.53.0


