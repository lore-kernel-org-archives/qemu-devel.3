Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5F0C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVhd-0003hj-72; Mon, 24 Aug 2026 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wyVhN-0003cT-T9; Mon, 24 Aug 2026 10:31:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wyVhF-0002Wg-QZ; Mon, 24 Aug 2026 10:30:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1d8i826561; Mon, 24 Aug 2026 14:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=ZogtcuRznbaCgFvyrvBHXL/mpqcI
 0FdWqUd4ohnfDxs=; b=V384f82X6TsjDgBAvT5Xe6cxBC43/caseQw972dex1rB
 5AplwmliJPuj4UnvjF3EPEXFpqowboway0BGC0yVEbVcGwEEO/D0XMW6irtIMwCj
 OU8IMNrAR5Oj/g6dM2GwWuaBhV33Wf5n6Z6sGEWxjnQ8XO7ZSdOo9iD4EJ3+vTsj
 oBYYjQpFvWlExjeA4eahiUc8I/7r+tsi4Pmy9JdjJs1FVTckvhOUvrBSqFR7oyae
 knlnB9n5jC9WF7LcCBsrKISDfudLkC/FR0OYVuK6E/IuZ+D84Rb8KvXXxqbLObqZ
 SF80A7nMX9KmNS5DhCBycGgxoFPKJfAPA2i6vYpGaA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ea06e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:30:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQHuQ011179;
 Mon, 24 Aug 2026 14:30:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6bf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:30:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEUbKM30278172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:30:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BE2E20043;
 Mon, 24 Aug 2026 14:30:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DC620040;
 Mon, 24 Aug 2026 14:30:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 24 Aug 2026 14:30:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 3CC821623D5; Mon, 24 Aug 2026 16:30:37 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] disas: Replace straggling CS_ARCH_SYSZ
Date: Mon, 24 Aug 2026 16:30:33 +0200
Message-ID: <20260824143033.306201-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c5592 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=j-usCZypzy5qgyMhyvEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX9/DgE33ZGVfr
 YsKq66/VuswASvGWZGx8h+YINCNYhS/6xBsuVSArYOIiIWtomTBuiEC5mipms0WhvBtq+fZ2nbA
 oHIvhnAK1/2aEteN/lrfa7KxaAfToI8=
X-Proofpoint-GUID: AUGiyqFFoGzAksvfz82cwr69dyttPgJt
X-Proofpoint-ORIG-GUID: AUGiyqFFoGzAksvfz82cwr69dyttPgJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX2zDGKrlWbrav
 0gW7GJemShq3Z0Ee7lZ5TWF/h+LXs9XqQY9fqlLh6tLbfcY9+2Fth6MRxRqX5t20mK8ZQdWwR6/
 cwQ7odAD8Ita6GetEkvaA2AKtwA+0350CXOGd3r6NaW7yrE+dLqgMqxFW7S0EXVIXO187UOp+h2
 PjsJMImSJmI+UIp3U56gpYYkMmKKlAQyJ1RiWrK6ooCw5+8HOy/I4RPwYFmwRFdmmG9NBb1L5Gk
 FRTmlmdG4mPdqr4C9qmdm4BAcYaHZx59hwoYbeFNp0anOjVzIja+jKI27z+Oa4GqTBWvT5xpDGa
 jhUBOV3DFrulG18B7yjYl6I2tn/D1x1wDw63TjuzUX7Fd8Py6ZlTCrzguAxaAiZhHo8yMriU0hc
 sAR5H8whgpNVeJB7cTixbtiP7Ph6yoWxRLaMpDrTwqBYqB5b+1IpqFYhZuoaQeFS7N51PywE4IU
 CYkuMQObWHp2X4EA0kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118
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

When updating to capstone v6, the define CS_ARCH_SYSZ was replaced
with CS_ARCH_SYSTEMZ, except here. On systems without capstone-devel
installed, this causes a compile error:

  ../disas/disas-host.c: In function =E2=80=98initialize_debug_host=E2=80=
=99:
  ../disas/disas-host.c:78:24: error: =E2=80=98CS_ARCH_SYSZ=E2=80=99 unde=
clared (first use in this function); did you mean =E2=80=98CS_ARCH_SH=E2=80=
=99?
     78 |     s->info.cap_arch =3D CS_ARCH_SYSZ;
        |                        ^~~~~~~~~~~~
        |                        CS_ARCH_SH
  ../disas/disas-host.c:78:24: note: each undeclared identifier is report=
ed only once for each function it appears in

Rather than making capstone required, replace the constant
with the same one used elsewhere after that change.

Fixes: c8220a096f ("target/s390x: Update capstone disassembly to v6")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 disas/disas-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/disas-host.c b/disas/disas-host.c
index d41235250a..799f5e86c4 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -75,7 +75,7 @@ static void initialize_debug_host(CPUDebug *s)
 #elif defined(__m68k__)
     s->info.print_insn =3D print_insn_m68k;
 #elif defined(__s390x__)
-    s->info.cap_arch =3D CS_ARCH_SYSZ;
+    s->info.cap_arch =3D CS_ARCH_SYSTEMZ;
     s->info.cap_insn_unit =3D 2;
     s->info.cap_insn_split =3D 6;
 #elif defined(__hppa__)
--=20
2.53.0


