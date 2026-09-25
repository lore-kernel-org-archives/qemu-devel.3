Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE734C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABqJ-0005O5-J7; Fri, 25 Sep 2026 15:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqF-0005Ki-NS; Fri, 25 Sep 2026 15:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqD-0002Mq-9A; Fri, 25 Sep 2026 15:44:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJ5wNQ1743480; Fri, 25 Sep 2026 19:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Hu7i133pEqECDlN9g
 KdKekGrtbA1TkVHHAYI4JvHpWA=; b=FkCbcqZ3VH1Zw08kw3QwZAnqM3TpZJCw3
 3vfbiMLOLxSbZzpUxpqnvisa+eXKtCyChAAbxIN20dN6Wj6NqAmTsotwpIDzghRx
 QXdrkoL/HKeFIjpkz4HDJSOQmSoQT+xF55/X/H+M0JXlJ8+KlAeu3yqVvmI7QJr8
 VqlMI551FiSR0cV9ZqSr8oAvIjjlCCV7U3f8fyV798Drx1OUh+pdF1Aeyq7F/JKY
 vloV1nR2rIk3En09rFA+ErMXLDlX4dE6oCIlA1TOxiP1YnQjqvUUpSRSghHkFysB
 jvnczHnX6VEZRaqnYq5ra39GUxtu6YbtIGTZPzGBkxAZlWv0w7ktA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske2015j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIm10I132238; Fri, 25 Sep 2026 19:44:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gwwsfrcut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PJiBNu36700540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 19:44:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ED9B2004B;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE01320040;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C17B2160CB7; Fri, 25 Sep 2026 21:44:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, eblake@redhat.com,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 1/5] iotests/nbd-in-qcow2-chain: use default machine
Date: Fri, 25 Sep 2026 21:44:05 +0200
Message-ID: <20260925194409.716498-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925194409.716498-1-farman@linux.ibm.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nU_1BAmiTz5kOatKr1fWxCyMVRGELYoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX5P302ChVPJ4b
 rP3FMv4XLl8EFVxq68cvDFtcJ8k9JxAqYpPqT9CvuurFlZaC4OFQdJpcSRKO7w3FZOZBJHvr6F9
 him91XadjQqBzGHRp/LpIpOFATg90ORfBP2Xqz47r0Ufbq8Am9bgp/On38kcLoUHo4zVmWD3osa
 QhloVYKqbBobRN7VIKVL4QnX5zJNrIWBHomsU9xrLjByrZcv5CVlVhGuhhwm3pQIcx1LdriRsQM
 3Xn7GhhvlSgLp2vZQWKhxXikB+tnOT8NtWPUxtASPG/BkbDh1TdLcZx64I+CCmTgZUkDgTZPhqd
 Zeq5S+FjY0PQpI0yVK4CMy8ebQc8eoINRarXANENViYazQqKJa38RVaLm/IQTuhncxZjXBOB/Dz
 TJCwYeP8VEyKDvV+JLH078R/AlaaeVI7FEOnSkAUETGDbwYJJR4pfRZfy4BUsPfUx6mo9tN4Zy5
 DIvNjOA5duWEqh0cUEA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6cf0f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sizahn3ISlv5E9aKlsYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX/KeaWm1Mpf5o
 cCH/5eRQPRAhQPy/VVvnddJF/KK/9GEj0JdSD3gvULKyuJu8+tG09Dtkk92UdCuS31VVCrc2Mo/
 yo8iRuuLDfMaSTnraBttvrLvvKvQUkI=
X-Proofpoint-GUID: nU_1BAmiTz5kOatKr1fWxCyMVRGELYoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
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

Some of the NBD tests explicitly specify `-machine q35` which won't work
when running against, say, qemu-system-s390x.

The nbd-in-qcow2-chain test runs fine with the default machine on a z16
host, so allow it to run in other configurations.

Fixes: 24fd6d75b3 ("iotests: Add coverage of recent NBD qio deadlock fix"=
)
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/tests/nbd-in-qcow2-chain | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iot=
ests/tests/nbd-in-qcow2-chain
index 455ddfa86fe..e35f072eba4 100755
--- a/tests/qemu-iotests/tests/nbd-in-qcow2-chain
+++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
@@ -43,7 +43,7 @@ TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
 echo
 echo "=3D=3D=3D Starting QEMU and exposing base image =3D=3D=3D"
=20
-_launch_qemu -machine q35
+_launch_qemu
 h1=3D$QEMU_HANDLE
 _send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
 _send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
--=20
2.53.0


