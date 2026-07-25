Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C0CC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbwG-0006ix-HU; Sat, 25 Jul 2026 08:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wnbwE-0006hv-Hx; Sat, 25 Jul 2026 08:57:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wnbwD-0005Zj-14; Sat, 25 Jul 2026 08:57:10 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66PB1JhW472452; Sat, 25 Jul 2026 12:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=r6J3+hb7P/Ye2JgKJ
 9BxXWaQp9ZIod5G3VC8zNJDNj8=; b=l5mewY86gq9TTx1NCasM95qo1GsCiIUAE
 JcseVSamta4Tj3tepZAckzrt2i0ns530hmTVze+5Io7EwcXH7zgLlNwpOPB6vfHA
 q0f3OzRp1hB3JhBxVs8wsUxxLGp0fTaXE/ilEzhZSo0cRXpXTpaB/KC1DltMOgu7
 zPQ+mD5r5D3/lsZMJRevm8bUzbx5Ez7y/74A5ny5DVTx+auhWXmCGxbT2n1iS9jk
 WhtE7LtaZHAoc9OYhPGe/PbmJa/hNT4bDBczfQQr9nPNXDl73jlAiEuIOmiRic2a
 VkJRu1CqMXSuyi19uQrftsRZrHitPuoXiUa7I/O8gUZvBHWVImv6g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw708p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 12:57:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PCuFlF028517;
 Sat, 25 Jul 2026 12:57:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12hb34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 12:57:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66PCv2Ja29884880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Jul 2026 12:57:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9284F2004E;
 Sat, 25 Jul 2026 12:57:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77D002004B;
 Sat, 25 Jul 2026 12:57:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Sat, 25 Jul 2026 12:57:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 5D53516280A; Sat, 25 Jul 2026 14:56:52 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 2/3] iotests/file-io-error: complete permission denied check
Date: Sat, 25 Jul 2026 14:56:50 +0200
Message-ID: <20260725125651.3896151-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725125651.3896151-1-farman@linux.ibm.com>
References: <20260725125651.3896151-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 22Y1YeSZUlaIE0iYYMRHnZ1LwgpkZLzW
X-Proofpoint-ORIG-GUID: 22Y1YeSZUlaIE0iYYMRHnZ1LwgpkZLzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfXx4OAMa2hlYvR
 3PSmR7dUI2kMuBJeqk9AcVVo6sHw0pWHWOaOqsHhRUHOgyfFAM96BWrF67T2DrhwKrilDmpzfcb
 8h/8k3MFhMm0iZorHz/WugHivSAiUmRVcRcRS+XPYtasbiXw4OiNWDT2mZ3+vXqEThN9Tzybfo5
 ZeHmIX45z6SKSe8/I/QOXtj94dTr/+YGJO4NY7MjImrXAZUM7ncFC1mMGaCZ9tFBOWETg0Rf8Dj
 x7DfwqH551+Xxv4mU90wg4pQ2VpDNWO3m46O9tBxpFh/8PNoJCW9syBI9CqRtpNmj75wB3pzJC1
 9LXo2+5bLizeZ2JnWvxG7Gw4jalj4qjoC71oaH/se4UkQKL+Dzq4JGYgpyii4MJ97+IwcoLCL4Y
 2vcfTbwxVvTDJPYCas9qN/0r6HNdn8KEAUF/N5//LlZseEvOw5IpmkID4nF6Qo8Qt8mc3uqlsI+
 bV7bSB9nkfe5fa4WINQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a64b2a3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=4wrIhZiHZY6pnxtr8DIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfXyhCHIeQhi+1d
 D0AWkifv11HLUbwa7sgHyTbdJaRRuBph7nxDTq1qbx6Jua/2rikNOtzSKbULtuOUHgJnifsn7xK
 w/C3uCo+Au0XInkPb8a4IDEvx4Hzpw8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250120
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

As with iotests/108, there are multiple potential error messages
returned to the user. Add a 'notrun' exit for another possible
error that would otherwise cause this test to fail:

  fusermount3: failed to open TEST_DIR/fuse-export: Permission denied

Fixes: 380448464d ("tests/file-io-error: New test")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/tests/file-io-error | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/=
tests/file-io-error
index fb8db73b31..86f8e1b6a6 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -92,6 +92,9 @@ output=3D$(_send_qemu_cmd $QEMU_HANDLE \
 if echo "$output" | grep -q "Parameter 'type' does not accept value 'fus=
e'"; then
     _notrun 'No FUSE support'
 fi
+if echo "$output" | grep -q "failed to open TEST_DIR/fuse-export: Permis=
sion denied"; then
+    _notrun 'No FUSE support'
+fi
 echo "$output"
=20
 echo
--=20
2.53.0


