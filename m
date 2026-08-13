Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA62BC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuaJc-0006wi-0Z; Thu, 13 Aug 2026 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJQ-0006uh-50; Thu, 13 Aug 2026 14:37:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJK-0005Av-Rt; Thu, 13 Aug 2026 14:37:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFWcL6860699; Thu, 13 Aug 2026 18:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Raon8qk4LlTR4U89Z
 beSXHFO7CVc3y6XLJ/sZQ5Aufo=; b=Tl0Oe6CdqQxoyNhYwqR5Gkib6FpNuqHui
 E03rUhuvMtTMCSDeSefz7j76+azRtmUtXPm5DlGhhljdHDJ8YYIsmASEO9XBFJCg
 IfyeUiwmGsHBTFRpAQkDaolYFcd7hz99knwrJr5FdWCctYQoBq4xxkIBNVvOnqng
 zHFRvMAgoQV2vGWgn7+udr2TNizRQftxEBsMe+f58ALLX/4C6+LGQ6p2PWHMPML2
 LYv4pc585B6RaHSJAXRI0URPhYLJueCqkYjXgRzyAS6EViXh1+foAdgLZLN2icTb
 sZv3OOkjczOQD+w9lwE2Qx4+Y4lbzJRBOsCqWXGK8aMCcyJ6+m8rg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk09dg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DIQK34020425;
 Thu, 13 Aug 2026 18:37:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk4740-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DIbgqC39518714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 18:37:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12D3520043;
 Thu, 13 Aug 2026 18:37:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E874420040;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id CE4E016128E; Thu, 13 Aug 2026 20:37:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 3/4] iotests/fuse-truncate: skip if FUSE is not usable
Date: Thu, 13 Aug 2026 20:37:39 +0200
Message-ID: <20260813183740.3503107-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813183740.3503107-1-farman@linux.ibm.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX6kIdrkE7uazM
 RiC+gYBRNiNvjtxUoezdYD2tcM1MJ/0kvdLRZHXazFl7aJ7cqbrq2lukIjBsnN8HsG0kh9qCPbj
 l/v69JNI6v6bS/JglAydM/AOWzzJZVFUVut1vixPuO0+0SmeFXe3x3GP9qvn9SX1PY33MzVm16t
 ugmfjtNCPDPy+zkl7rvPtIdUgqeS7fjZbQKttV6wBIm93iIMEKa3R559pv6a4sIYKDZjus2ZXOa
 sVPYKIklYWBZ3YtAMdTe8PzrbS82ShV502p5U6BzAD4j8WXrORiFsqIX2WtZmjnLBE8vomvkTHe
 o376nza+nXSTjl4qx5bIFsIEF26edqA+pL4MBM/Gc3q9mluNiHJPoDUGBNbPgRv14ITV29uMj6C
 v9CUGnvNSCjP7FxaF7j7JKwVdnB4nJZs8KEoRm0YI9Ys6ewQ1dbnxmqfWchmVDRNNaNm8OU/7Nd
 SGaYK7gAOFeSaLzMMUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX1lsdiR25WrhN
 UKuD7Rb6kqjhJyGRQELSpfCII/495vZ5qLylolhUNSfZzgK1B/VuXsczzjSpYEduE3WOuyh+l3D
 jtF5feo0+NeB2zFWtYamrzgRee9t/7U=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7e0efb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Kb8N-gTP1LXiH-1UIUgA:9
X-Proofpoint-GUID: uPq8lbKbTBoo9L-5FwgCxzlEw0gEjJgx
X-Proofpoint-ORIG-GUID: uPq8lbKbTBoo9L-5FwgCxzlEw0gEjJgx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130134
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
index 7eee35111c..f3d2f1866c 100755
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


