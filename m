Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12DFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS6-0003C9-2P; Tue, 28 Jul 2026 15:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wonS4-00039w-0C; Tue, 28 Jul 2026 15:26:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wonS1-0001Rn-4r; Tue, 28 Jul 2026 15:26:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIHs2O1959789; Tue, 28 Jul 2026 19:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=DFJYd9d93LuhuxNg6wCeAyzoEpGRkaGl0ff5KsSqT
 5E=; b=pqwm9u23jyQQQE0dSzVdth8mVfbBFiKcJzNc1VfFygJ3/c11Pb6hV6fIk
 4rAV/v1+/U4N+C5kMKbRcZIIRWnCMYqQNQs/YF9n1aCyKVb2N13TN1iu420XwBe3
 V2ciXC/TbVjSTJT8ORhjGKcWUaBdKaz8Ve2oHAMr+u0sh2z3PvBcXzJ/xFZ2YuHX
 lt3AhYbMggIzqh5+6pouZV2LHQYi6N5UQ61o73P7NIQlQRzpigJLqIBi2COBN9Bw
 NPkzVzNHOwFSCysfAhqWo/NF5wW4nplnCD6Fydkcm52ZTyOvp9ehscTwYDDeWGmI
 dbPZa1j5HTN8YBNR4zfypscpnf2nw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xq7tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 19:26:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SJQIYV030727;
 Tue, 28 Jul 2026 19:26:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqbrxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 19:26:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SJQkLU29098280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 19:26:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9242020043;
 Tue, 28 Jul 2026 19:26:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FA2F20040;
 Tue, 28 Jul 2026 19:26:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Jul 2026 19:26:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 2B600162592; Tue, 28 Jul 2026 21:26:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/1] qemu-iotests: One more fuse fix
Date: Tue, 28 Jul 2026 21:26:43 +0200
Message-ID: <20260728192644.2879028-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OX0wv9rSLNS_RbQcjz7X8dwY9QPMZWxl
X-Proofpoint-ORIG-GUID: OX0wv9rSLNS_RbQcjz7X8dwY9QPMZWxl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX+fr9WAvfNgzU
 TDwiJ1MvEgE7DgcwMV3Z3kaSZR1WSXQDur94pBwLpgy6TXiUL/QNxS2fvkUZ0Blv5XGCxl3Rs9G
 yKEGvtiqLjq3OAjbpbZb40eYIAOafKY=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69027b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=6rqHouBjAAAA:8
 a=auybPDAIUdcjEHudMXUA:9 a=zZCYzV9kfG8A:10 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX608/zIHpEtoh
 6jUNIyfQTeue3ExzDhK02WSGhaAIcXaPfY4NZpakOkvvat+FjJp9XbpnboxmxMX5rToKEmP0OKK
 yLHXQe6yGUACvXMYMeOTcWzcdl2nBjHGSytPxjFpAB0OiyDbbeVnG0b+KDgHPMXqj+YMQY1Ik78
 X5JM58Rlvh1ibbGsc4lsXluJfFx1ujS2HR47grgQImZia1GHMQY5Jg3c+rfsMAFJfTrrIbuEXEc
 mYJ0/18EGj7xtyCxb2hJuYe+i846lN66iE+sju3oHOmsQYKuU8x20a9xfW8KhAUz8Y0cgKaJepP
 SGXgl1xGAfWphiAnYg2w8yXZ72QtEnKRC0P5jzawdN9/vnrlmK/lxMJ8cXo5bTscCZrBT1jJ0Uy
 q/iEYyMKrAjfsdSTy9LIgo3tMDKJ/S62da0d/tDN5LgsEIJ0wznOyJSGjYEQ+sOztA43I/O7e9K
 4k9T5e4W6/x/v4U5vfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280166
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

Hi,

After learning about Denis' series of fuse fixes, there's still
one test that doesn't run on my system. The attached is a fix that
builds upon their changes to fix test 108 as well.

v1: https://lore.kernel.org/r/20260725125651.3896151-1-farman@linux.ibm.com/
v1->v2:
 - [KW] Rebase on https://lore.kernel.org/r/20260715103451.1930909-1-den@openvz.org/
   and drop two of the (now superfluous) patches

Eric Farman (1):
  iotests/108: skip test if cannot access /dev/fuse

 tests/qemu-iotests/108       | 5 +----
 tests/qemu-iotests/common.rc | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.53.0


