Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6AC109022C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3EFN-0008PD-Dh; Thu, 19 Mar 2026 10:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1w3EFI-0008Kh-Nh; Thu, 19 Mar 2026 10:21:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1w3EFF-0003Bt-3N; Thu, 19 Mar 2026 10:21:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JAJUlv3775990; Thu, 19 Mar 2026 14:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=tVQYXjpTKRPxno9Bx8MTCvdytdQz
 QTwTlps/8Rp8YJ0=; b=GkZABOG6uyeVcRChZd0s4FEx79yokd3l94ArLIGatuL1
 rElvkGY/lmoRYMruBKHsltx63lwzDqvVM6Ff7GgCoMjwhTHgJ/w4G990zCi5NE/w
 37LEe2YWC1NhN0niwYT5moPg5+QDTDh7GYT40zxarN9/uzTSZwTgDgFiG383VUSq
 NFJ9d2iuGx4hRlZcxnAZr2dSy8NDLsbYGf4/3IW9HzCklDYnWSWkYmIQIpJtXbOn
 ryfApTOAXL1qAewNogjAmd6MC234kV8bOPbrk+VRukrRY/8KVs1YAUWwHuLLNTkm
 97FM6z4GEdPAT0Va4jKMLu2SVxAPPk/p7SbpZLxOvA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsfae7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 14:20:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JA1ri7028459;
 Thu, 19 Mar 2026 14:20:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1jj9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 14:20:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62JEKqk551708166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2026 14:20:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E41D20043;
 Thu, 19 Mar 2026 14:20:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DC1620040;
 Thu, 19 Mar 2026 14:20:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2026 14:20:52 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH] mailmap: Update email for Nina Schoetterl-Glausch
Date: Thu, 19 Mar 2026 15:20:42 +0100
Message-ID: <20260319142048.917219-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bc0648 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=j8RhgVXbAAAA:8 a=1cGLs3X8AAAA:8 a=unkj71DYAAAA:8
 a=FS0upHgUAAAA:8 a=oCJs8q-oAAAA:8 a=KKAkSRfTAAAA:8 a=ggQks4fKAAAA:8
 a=lzDhS8hmAAAA:8 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=HVa9FsKFN9bTpKEVuYAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3SzYsRL22XtqO3ZTpi69:22
 a=d8ghUycwObenwynNfMyN:22 a=5RyQM4v5J9L3wGZf4tZl:22 a=BQgJtduX4OmZBxSA4osX:22
 a=qUF70SbvcHBaGhGVny9j:22 a=cvBusfyB2V15izCimMoJ:22 a=6g8pSQqS8yRHbJHhMaLw:22
 a=rigQk1bY_8VmChEzA3fK:22 a=AlIIF0cMT2hfDT4axODj:22
X-Proofpoint-ORIG-GUID: a-yBcRyghwl5cTqOX3N8pu0GC_ehPVmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExMiBTYWx0ZWRfX2Sk5nyXWWx6s
 m7apQVxl2gtwNgk8U1yD0R8JRI25o7cJkjHs1rnPzUTOFOKlc32pigkhKDFyP0bcOCjng0e46ny
 Ki5zms+dsQO/LHfqGede2i2ifPp7w/YMcbaCOPMjC4K8cVZwXiLEnTTbukR1GbEhfOsn4fg2zRK
 pSAnnR841AwUx6V5AtMJsDhc816m6kZ8z0EgeFJ6Tkkk11ciLMvGguH7A6QS3Aj5kRX1F6rFxSK
 JhSKf1d3Et7/YkHfLWj01YZGTR0RjoSaMBHOMZeyGmNQzvflxqh3MhqZci+auVrs5INXz1zhiLc
 53MzTsWmZfLri4jWzyOOnl53jacUf1uFzHubxpBh0kOZVKMqLoV6istKdXy76Jq6rF3Y74y/15P
 V/ldXn7S4Qg9Ed6EI6qs7HbZFnaUcP7us7jCePIj6SXeRJEsXKp7LksMq5mdwlsq4YBs1+Uh0Yk
 gl1PCrcC5jflwC6oiAg==
X-Proofpoint-GUID: a-yBcRyghwl5cTqOX3N8pu0GC_ehPVmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update to my private email.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 0690f7be34..383948400a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -97,6 +97,7 @@ Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
 Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
 Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
 Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
+Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu> <nsg@linux.ibm.com>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Brook <paul@nowt.org> <paul@codesourcery.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
-- 
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


