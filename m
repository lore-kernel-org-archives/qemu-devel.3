Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BD1C5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuaJd-0006xv-LP; Thu, 13 Aug 2026 14:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJS-0006uk-0k; Thu, 13 Aug 2026 14:38:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJM-0005BZ-Ni; Thu, 13 Aug 2026 14:37:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFWlNI2768736; Thu, 13 Aug 2026 18:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=No2wbFeoud783CF3d
 TcH2kmhkL0LFzrymm+oME8MbyA=; b=DUsHfFPlvixF5p8Y8ZXP0uCgzB6VNEqS0
 iwMK+PiW8iXHEP1YaPTh74wQSB1EcKYGo/5Leo1Am/x5YBJ5SRAFk+Ov5zrQavKF
 MP98VwsrMFJB/NfIjM0IIkj9hDPz14um2QYCQaRt4UbU6mbLvGJzCL01fMhgl0CY
 LC2N5HPia8XTE4kmrJUaEAvhkY2zAwqUV+dnZQmNebAVdLBiRnqC8II+5H036IcB
 wbF4hqW6wEmV/UQha5pLrEAVGZMKLyAXuHjgfilBiFuFS1PNDSdPpJR+pcPOuQrn
 GWEDreogPo0lv7wvt5Xhl1NgetauAqK5f7QqFDi/NIHJ3iGfGwwDw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwgc4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DIQMXB000677;
 Thu, 13 Aug 2026 18:37:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wcaud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DIbg1829033088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 18:37:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10BCB2004B;
 Thu, 13 Aug 2026 18:37:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E604F20040;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id CA850160E15; Thu, 13 Aug 2026 20:37:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 1/4] iotests/nbd-in-qcow2-chain: use default machine
Date: Thu, 13 Aug 2026 20:37:37 +0200
Message-ID: <20260813183740.3503107-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813183740.3503107-1-farman@linux.ibm.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7e0efb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=sizahn3ISlv5E9aKlsYA:9
X-Proofpoint-GUID: oBs5gU-Q06ZtgKdfOTgWKbRtRuIahIbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX+AowpmGiD7Aw
 zbin3eVUmOr6FEVWw6CpojGeuWKt3SiTytha70LsHBGwS4LKRWIg2tV6xGOrN8p0klXzsf8N4zd
 RPkskH5J/pobCiDijUCcXs8RZ6jdQ/hcBy43QXvhUbNWDa398osOo6T/HFEQVj83D8R0jWd7AG1
 1ZPtaFg+SQep0ABha03I8WN3MAzqPO9O/lWY1R4R7gbqLi/N52fU+zpJFFUaWS5ydObV6M0ICsF
 xhuVwEdJARxSQBNLFkIdH8RUlMosvZ/GMimKChJjaYfv0/vZk/FQhrW2kHC9X6/XfY+hEv/rnTG
 4MRSRD2H7JiZkfTMkZ1EeDjG7jpEoeryKE3IvyQgMwPbsGyzfaC956ZQFQd6wnc3+IGvD2z0GCA
 Thza60cZAVufa8HTHxRNHd0C2Kbhv272KqrD40W/UEH9Jhw/LN3HPJeYK8vhKJNdNl8ZApNuHhB
 9C6MFU29hYmH8ZGmkbA==
X-Proofpoint-ORIG-GUID: oBs5gU-Q06ZtgKdfOTgWKbRtRuIahIbr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX9eWfsyVpmi2e
 OtQN8lekDYp0WVBHptYwIaIONN8eItprY4eQsLJYAHewPeD+48fVPol4GYGdi8yiwCXVypXvQ3D
 g1gWaKU76pZl8Im2ryh4/5W4jX59RU8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130134
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
index 455ddfa86f..e35f072eba 100755
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


