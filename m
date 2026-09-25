Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F287CC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABqJ-0005O4-El; Fri, 25 Sep 2026 15:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqG-0005LD-9E; Fri, 25 Sep 2026 15:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqE-0002Mv-5P; Fri, 25 Sep 2026 15:44:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJ5Pv91882976; Fri, 25 Sep 2026 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=36Pvord78sVh1Ydsn
 1vR0RRQAGzm5eTC9SA+SyJTD1c=; b=tYsTW3Rmy5EhfXfXXYGyqyufwXI3v1xzx
 iKe+3gAIH/WoeDGzWySVifIl5Owf4v+2sRhL3f2sF6DpU5qf607sIHn9Q5oK6l0f
 qTvmHTN6g2qiiEE/mFpxs+l3btf9l5174ocDppmYaUA73KOSoo92NNAt3YCwFIdO
 0E9arny/eYSef3sR4sihfeY3zrBJLhPYjKE7Xzjr593ZjhWKtr94+fg2dkgNxGzH
 fRfTFiUsucu/oaAbL9a41rwutsMKfqSfnrmgDz71kDNmrPhE9Px8vIBPMHZB9EG/
 xbbanYie2sPFmsqiZiCqZ9ubekHtRQ/PIqBu3n/uyvbBalUlh9+Ug==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsrw7p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJMNxi214715; Fri, 25 Sep 2026 19:44:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gwy27825d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PJiBEX37945824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 19:44:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 110192004D;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFF3320043;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C36A6161DB6; Fri, 25 Sep 2026 21:44:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, eblake@redhat.com,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 2/5] iotests/nbd-tls-iothread: skip on non-x86 hardware
Date: Fri, 25 Sep 2026 21:44:06 +0200
Message-ID: <20260925194409.716498-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925194409.716498-1-farman@linux.ibm.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab6cf0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=x8aU6ZPjE2doOINR9VcA:9
X-Proofpoint-ORIG-GUID: xa5gMAqkzLGZPE1wRTc0l1jiKYmJzqNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX/zEARbG8Hopn
 twOx1iapB69pAGYxcXLvYH9QJIdCAJLU2xk9SxznpBT2Wu+5TW0iiPBUo9FfO1/wmG0JwFDhl2l
 ftcx0isxEbyIzoLcNMo4/dajfrQ6FYp6ivoAClbVP7QtCb6OuXR1sDUzfYVew3REX9tTMNfgOVL
 yQjXqwqpO9Way25kLjQnnpGtO7INrhTTQzSovQIeUz36xiuqcVK7Ln3l9YHWsQLA4jFMig/T0MU
 tX2OVUybSxdaHr/x4T0LLAayo+FYF9fOToobkUAqnU9snaMa5eMKON07MJaiHH3UK4KI+KVY8J6
 Zkn53fLkJx69EijaSDd5aZOHDd4eOQ6IYOKTsDRSDRogP2GsGOA52bB2yKQ0JW83U8UbfY6C6q/
 IJWUoh19obhPZoWzueBYBJaLMu7qiMXFA6tw7hg9vZHkuODTM8CQlvhmUY1R6PUOcidtqW6zMgj
 kuSQ8wPZyDOcLhmL8dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfXwk5mFQz4nzHC
 MeGSidHDzDz9AikZmvB52ty/lN3YcWH49CPVMo9qoPYSWWBQFp6T1J8ncIZJl6XhmQf8qCoHi5Z
 JI7omMyjinu18X1jdd8xZnnnakZddZQ=
X-Proofpoint-GUID: xa5gMAqkzLGZPE1wRTc0l1jiKYmJzqNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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
index a2fb07206e5..4326e2d3e5c 100755
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


