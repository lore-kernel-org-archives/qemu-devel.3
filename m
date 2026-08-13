Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8313C5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuaJc-0006wz-Or; Thu, 13 Aug 2026 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJQ-0006ug-4z; Thu, 13 Aug 2026 14:37:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJL-0005Ap-BE; Thu, 13 Aug 2026 14:37:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFXUlB2642465; Thu, 13 Aug 2026 18:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q0YbGRrcnGhjh3opC
 lZnYFr8lviFz547IpFH98aj3A8=; b=DNZbDz+dlc1YBcaGH7XcXTAtMxHgwQb0w
 dhSDI3cCUnZ+p/xTfnUn+g8MK60KzenUCVFio7B04U8agnyX3LixV0w2NwSDCA0R
 NkpSn1adPvAyV+iDH2R6NrovaheCL1vNum0DpNn0Yiasf8TfGWnI6CR8NEfE96eY
 z58ETVFywYVyLxXmLnEpLGMj9Y0orOkVlABWiZhKBxVa7707qaTfeQVPqq5tCdy3
 MiGdIm+kLw7CVz4GRQ+0LEQLe+1zxhTijy1TtwzFotx0mMhhLg84i4Y6qBQc+w3o
 g4c7E+dGjyJKPE8G9nqIEZVcmqfberzyMTeuVQTWqqu3Di81lELSw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp38c6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DIQH7E003917;
 Thu, 13 Aug 2026 18:37:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqcchw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DIbgaY33620350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 18:37:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D01A20043;
 Thu, 13 Aug 2026 18:37:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E59E32004D;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id CC240161288; Thu, 13 Aug 2026 20:37:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 2/4] iotests/nbd-tls-iothread: skip on non-x86 hardware
Date: Thu, 13 Aug 2026 20:37:38 +0200
Message-ID: <20260813183740.3503107-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813183740.3503107-1-farman@linux.ibm.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7e0efb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=x8aU6ZPjE2doOINR9VcA:9
X-Proofpoint-GUID: GBAyj8Dtf4b_Y5_DdhCrPtHoLECGB7cI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfXxIwBwThMT8xm
 a9b4O2iCTqCio1gVN8gxepchuCZHK1g4ZiT5iP1AHZ2t7uj4X9/kVHIKiuCRDCebFTsnoCIFsck
 Lph9stzI/35XBUZbIg2v0VtAa2+H+TcY8H/sjaWSFNRJu+RWUaH4uOn/V7bcGf9JwjcHzCsoXAE
 9VOmHKgHWzf0ciTSaA/dHsPcAhOIvKZsNYsikLIabs+4N/2IarTYD7wrlUVdcbiUSaCVoq1kBtj
 V7YbgAI61dzZ9ExqOI2AIkbH0ssRvpqmMr0cAG/9a4FOIHWQPzOcOnAmhbBMWz6y3dkL11KQr/j
 +LTO9ioyj9Hu4UyEZgxU0xh3xd6eUeS89VYjodXPnsmEmfJXKFGH3ZFf8XzMsOYxg7DNCP8cw8b
 DUOQDQh0gs3LcDk6NFDcVe2gRVsBUb1m66kiyO2+FN2YQfI7ZRSLLl4pxQrVpvq9cdYTPy2w4N1
 CZgC2mQ1A3dehnos/zA==
X-Proofpoint-ORIG-GUID: GBAyj8Dtf4b_Y5_DdhCrPtHoLECGB7cI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX9He6yAh1mlvo
 ofBxji1mr9MsG8Cbgn/TalNhYNGFf8NdHDaLQ+gfjJjwQawMCE2nh+EhiG5OlkGvg1sdLCdQPgC
 8MkJEEyVLOkR2upf0cdzDT5oplqLYQQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130134
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

Like nbd-in-qcow2-chain, this test assumes a q35 machine is
present, which might not be available on other hosts.
Unlike that test, simply allowing it to run with the default machine
still throws an errors. Fence this to PC-only machines for now.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/tests/nbd-tls-iothread | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread b/tests/qemu-iotes=
ts/tests/nbd-tls-iothread
index a2fb07206e..4326e2d3e5 100755
--- a/tests/qemu-iotests/tests/nbd-tls-iothread
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread
@@ -47,6 +47,10 @@ cd ..
 _supported_fmt qcow2  # Hardcoded to qcow2 command line and QMP below
 _supported_proto file
=20
+if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
+    _notrun "Requires a PC machine"
+fi
+
 # pick_unused_port
 #
 # Picks and returns an "unused" port, setting the global variable
--=20
2.53.0


