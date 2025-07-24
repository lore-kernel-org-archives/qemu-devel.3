Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092AAC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepaD-00049m-Ji; Thu, 24 Jul 2025 02:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZQ-0003vK-OE; Thu, 24 Jul 2025 02:36:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZO-0007Nz-PG; Thu, 24 Jul 2025 02:36:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NJPaU1029171;
 Thu, 24 Jul 2025 06:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ByNLjDExmTIg266JQ
 NHp18a51BfWNVrhBa2dUbWI/Jw=; b=T7XeqLN4IxBFMYwUa3C/LUArE0LkUTtUk
 1JpqFIZdflrSlFcOr7A/BvV9lVLuswWP/3JHinF26g6Mgq2+CE9KKqyDGYUubgCR
 FCr6zbx4BsHtgCSHFqBaPyzm83mpR7GIMZT9d0jHF5nAgQxOhw8mMzHenhrcF+dc
 32gU7QeIWhqK/RnSAwne7D6lCyx6HDp7qVJQ1RzFSJCB/9AqtmmB4CfBR+9m+tkb
 f2wYvoh6ooTnj8ShdHMiUh6gxqP1t7Aq0Mka/HIh2IItbE7sXBYbqCj9NbaD5ENc
 RwVXSLw9DhcNEHJ4rNKac1/7+JS9wgm4VhwjcxEBO+eR4f0nRuDIg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyqrgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O6YVi3003125;
 Thu, 24 Jul 2025 06:36:43 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyqrgg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O43FVd024761;
 Thu, 24 Jul 2025 06:36:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2k072-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O6ac4b59638174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 06:36:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD86520049;
 Thu, 24 Jul 2025 06:36:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFC9320040;
 Thu, 24 Jul 2025 06:36:36 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 06:36:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
Subject: [PATCH 2/5] MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.
Date: Thu, 24 Jul 2025 12:06:07 +0530
Message-ID: <20250724063623.3038984-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724063623.3038984-1-harshpb@linux.ibm.com>
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lanuUBt8-1vGtLk0NzzCV2DjXKnNVQD1
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6881d47c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Wx8enTvzk5m5oACMLf8A:9
X-Proofpoint-GUID: UyUfxjspRD8KQPGYBN-UJ9hctVAFxpeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0MCBTYWx0ZWRfX0zV1xPaQbgAi
 7244BfaP9EUyncRxmwGOg6GsmKBOl8FJGfJ3dR7b7ebD/Zb3HYd9gcCkZFcz3gfzXUsI2II+DPa
 6Z1aKmaRZBH/Hk2vaE33/cE7wJPxHD3L/MAfJTLkWcpb+zj1zNpIWC69Bh3BlPyOfq98AINlaHF
 VfF3+7CxA1/0mc5hbmH9kPMPht1vN4FR3VBNr5zmDT4D3ticzwtZvP44Vq568H9JJkQlk1zaykp
 Ntud58UTPF1a7++I4BUOJtr7YnnbPpSEMiJvUoXgKfRemQSW3udai9Ub8IPI38QJwWd595+Q/4p
 QvoawLjRP1QTulBn6O/XLe3wKZiK/pqdznfY9fL/3WhAVuMLKd88xzpZHoOLh1SLMjJy6swVW8D
 tIn3+XJl9iTJvVpxQVesRGWEn0HU61d204faaEhHgq8z0g6XDEipf4KA9nrDk14xoQtZ4iWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=525 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Have been contributing in ppc/spapr from tcg/kvm perspective, stepping
up to help with patch reviews and get notified of incoming changes.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index afc94e6e67..6e95ef00c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -453,6 +453,7 @@ F: target/mips/system/
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
+R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
 
-- 
2.43.5


