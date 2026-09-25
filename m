Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF761C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABqJ-0005O8-RX; Fri, 25 Sep 2026 15:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqG-0005LH-Ar; Fri, 25 Sep 2026 15:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqE-0002Mw-6u; Fri, 25 Sep 2026 15:44:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJ6F1c032660; Fri, 25 Sep 2026 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nLlcdvUrtjWDQtE7O
 I6VnaCeUVMOHi2mkfoz5/Sdqn8=; b=pE/ecOBi6LuHVDQ4guA2Vh59bv8AZyc3E
 sAApD7s/yg3ZT1CZaynE976wXn46y7X4VrCkICK63KfTRiNoU6S3FJAz6dQ0RsEs
 XwYgu7yETnGOjmATCAGbrqmlKuogC3cHZujPU7bFS5Y7z/3nLryW7zjWpYe90mXw
 rT4BCZ/HtRhR0bJvd5LXgo2T3o7RvxMQci0GqeD+lHQ9OQbLyScSMja6M3UKGli7
 1wh8yM3fgEHG0cMqrJ6qdqnpfpS5laxpwFWW+84qpHXDs4Ha+iNaFx2vH+ZelY5/
 tMXC/PgKP3LIRKRAFHAf6IksUb73GlPQlE1jNwIA8fo9jWsxT9pIw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske28y40-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJMHto214647; Fri, 25 Sep 2026 19:44:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gwy27825a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PJiBAf34013452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 19:44:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CA7C20043;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DED2920040;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C5A5B161E18; Fri, 25 Sep 2026 21:44:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, eblake@redhat.com,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 3/5] iotests/fuse-truncate: skip if FUSE is not usable
Date: Fri, 25 Sep 2026 21:44:07 +0200
Message-ID: <20260925194409.716498-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925194409.716498-1-farman@linux.ibm.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DfzOZLKocOR8J3tgQb5YCDUfzTUe7tFO
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6cf0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Kb8N-gTP1LXiH-1UIUgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX+aSNn5b3ZQWX
 IT71oTtJa/6DrsXMKG4nfEBz5udhCWkAbZ4M2FmqjtFjwdMM0t/Fo99PkHWVP7VFf0o2X4qaalQ
 avIJeonfyoZHT9mzhUdju3IWINTZO60=
X-Proofpoint-GUID: DfzOZLKocOR8J3tgQb5YCDUfzTUe7tFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX8/tBAAk/03aF
 aW+chvMBCSJIpzskOvfUwrvrUgA1Z6QEv8FlYRlEKX9baKV9WJ+/p6o6ETJAEvEwI+13421dzqc
 3n4Gm8nYwJpoQnDJIlcKPbUNA7pZ5cxnrbwDKx8P6K8iL8Z+5DuWh2OjIORyOUQxw9FWo14MYHd
 LbyjyhFJDiL7p9eSV65QXtNgCxb0Ds0+GfC6SHKSJ5ZPPdN7rno8hH0EhVGzDMA1kgh0U8Za3K9
 JVy4TENgZBUnQn2pdkEaU5EcSOUqQbzj4DrSerebEFCA86OZEdcid95jyMd55D/LI+nOuNQrnTv
 aVeWlM5kL6jcQsMJYu/h+Chvuf6nZj/O9BlNuP3cQHzcRUcLtF/8fvdG/UvZYFJB/aa1h01HNdD
 AHAWfqwjxUQ8lMU7wpGCrrn0zkrw8Eef4ihJ0TvN/L/j6GEMd7LTpvTMj3c8fgn7UnjWx1vyAns
 CyLduGOXTY2hwvt5L2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
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

Commit 951227d3755 ("iotests: skip FUSE tests when FUSE is not usable")
reworked some of the fuse-related tests to skip where needed,
but the new test fuse-truncate raced with that and missed out on the
same treatment. Add that same python-esque skip logic to this test.

Fixes: 7d06bbb2d9 ("iotests: test O_TRUNC behavior for fuse exports")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/tests/fuse-truncate | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/tests/fuse-truncate b/tests/qemu-iotests/=
tests/fuse-truncate
index 7eee35111c8..f3d2f1866c8 100755
--- a/tests/qemu-iotests/tests/fuse-truncate
+++ b/tests/qemu-iotests/tests/fuse-truncate
@@ -32,9 +32,12 @@ def check_fuse_support():
     test_qsd.stop()
     os.remove(fuse_mount_point)
     if 'error' in res:
-        assert (res['error']['desc'] =3D=3D
-                "Parameter 'type' does not accept value 'fuse'")
-        iotests.notrun('No FUSE support')
+        desc =3D res['error']['desc']
+        if desc =3D=3D "Parameter 'type' does not accept value 'fuse'":
+            iotests.notrun('No FUSE support')
+        if 'Failed to mount FUSE session' in desc:
+            iotests.notrun('FUSE not usable in this environment')
+        assert False, desc
=20
 def check_sudo_support():
     try:
--=20
2.53.0


