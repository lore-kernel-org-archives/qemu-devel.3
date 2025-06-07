Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B003C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 11:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNrMR-0004DW-GP; Sat, 07 Jun 2025 07:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uNrMN-00049v-To; Sat, 07 Jun 2025 07:05:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uNrMM-0002Vq-AL; Sat, 07 Jun 2025 07:05:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5573lKix010918;
 Sat, 7 Jun 2025 11:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=t8v6U1
 27aAgXbPZYKy5zFASpgwt4eW+UI1hTU5MsnI8=; b=m42dMQAr86pquS4EeueyMT
 yYbb44u6MCtdcF5kIjN1xXV6WT7Y8efS+O92kO5URVR6Gq7SAHKvufJ/TUvPM1FK
 V7I4nz8khatwfCQvOhISi9s/2hbXLMhftobO/0ZaiVuVPyuYCC+EpXo5NCeM3Zmq
 xV8BOF0V/L97xt2dChw0UvzhgG0R5BsmsQ6n6C7VRbpydxD9Bh/lLce3t5VtMPlf
 j0fQIIIe8fHEzJkLYkLGGn8SbKyqdGzoHWKMeY/7jCtwCurpTkuJV/uJ1FwZCgJ7
 lPfo6TT8wOYskyN42VeGMMJYe5UUh9TqeOlRXE1bJJ2IwSTS9FYWNVEaSsg1En8A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474d31s4ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:05:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 557B55a0018615;
 Sat, 7 Jun 2025 11:05:05 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474d31s4u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:05:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 557AeCLL012569;
 Sat, 7 Jun 2025 11:05:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2w94t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:05:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 557B51mc48955814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Jun 2025 11:05:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E91E420040;
 Sat,  7 Jun 2025 11:05:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1064120049;
 Sat,  7 Jun 2025 11:04:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.13]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Jun 2025 11:04:57 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v7 2/2] target/ppc: Deprecate Power8E and Power8NVL
Date: Sat,  7 Jun 2025 16:34:12 +0530
Message-ID: <20250607110412.2342511-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607110412.2342511-1-adityag@linux.ibm.com>
References: <20250607110412.2342511-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA3NyBTYWx0ZWRfX2qRAyP2NdkFA
 Ge/JazTTBoe/DKXirpvdlukE2Zkx5nb5gseFkqgCN3iwy5tRflBSdaiAYSGqhN9lh57VXQrIZm+
 a8Ohy+3VjUBuYaLFXZQJgEbl42NkpzzQeBPTD9eI5lHf3cCTvni35TX9jfeOpu/uri9q9iLJzwR
 2M0CzfeOoGP5a2xwKa+zSMxyEYIrxWd5g1vcYwD8ViqgRqlthahkPQp5ruCtTyEbMkfXra9LtAg
 RoyZtiGjCV48SoOOnVQE8+ynGVUlsbRqqQrL70cDOeRsDM63t2xyCxgZrbQ7fYt52V0pMUjDiQm
 WeZpoRtd3os3jfdF80AuVoY2qNnFl5ASA4WgpF2mpVzuZlQqyv1jMja/JPm9ZNEhPBwN4NhFJiC
 o3vTpQCitjqzXchlUIKd8KBstP6YBfoPzTJ3r4Qv2kwwVz1yFMUqO7uPB8ACDsZxC+n4fk9G
X-Authority-Analysis: v=2.4 cv=XOcwSRhE c=1 sm=1 tr=0 ts=68441ce2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=SYv8DMXN2cHv4ii3y3oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mQ5tMEfzQQ8ifJasxCGhA71NfU8AWLQ6
X-Proofpoint-GUID: 1lpRKti5SBSFxmRD37caCfDbZy2ibVKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Power8E and Power8NVL variants are not of much use in QEMU now, and not
being maintained either.

Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
to be exact:

    commit c5424f683ee3 ("Remove support for POWER8 DD1")

Deprecate the 8E and 8NVL variants.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 target/ppc/cpu-models.c   | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 42037131de12..11fdd5c0409a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -297,6 +297,15 @@ embedded 405 for power management (OCC) and other internal tasks, it
 is theoretically possible to use QEMU to model them. Let's keep the
 CPU implementation for a while before removing all support.
 
+Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Power8E and Power8NVL variants of Power8 are not really useful anymore
+in qemu, and are old and unmaintained now.
+
+The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
+be considered deprecated.
+
 System emulator machines
 ------------------------
 
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index bc3f9586cb67..66001c5ac06d 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -732,12 +732,12 @@
                 "POWER7 v2.3")
     POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
                 "POWER7+ v2.1")
-    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
-                "POWER8E v2.1")
+    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
+                "POWER8E v2.1", "CPU is unmaintained.")
     POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
                 "POWER8 v2.0")
-    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
-                "POWER8NVL v1.0")
+    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
+                "POWER8NVL v1.0", "CPU is unmaintained.")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
     POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
-- 
2.49.0


