Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E9CD343F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKH3M-0006fi-IL; Tue, 05 May 2026 10:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wKH30-0006eB-5R; Tue, 05 May 2026 10:47:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wKH2r-00080N-8Z; Tue, 05 May 2026 10:46:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645Ej30E1386183; Tue, 5 May 2026 14:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5FzSjXlWueYWg+gK1GZP6IRbnOLLqFrZNq9WXJZ9P
 fg=; b=qWydAD0A3lKCtWdNAHZ2LkpT1ugi4Oe77cS/evjM5cJR6S7buoM6kNt23
 15OCjQyaoIgXZVtf/BvaNlgemm2AVvdtIre4dE/HpBXzLvKkGMkUhM2qYjJKTqh3
 gpHq80YNtnjrEn5j0JCZ5xXfrGb/nI6oloEhz47k0K+4bO/CbsmKe9OMRcpIiDgY
 PyqgljXhCqHV3AC7884nuEdqnvVOBlwythbj6ns+ttlthVA6q/PWlqruXaHITtC/
 CH/Ln1740z9ZGtHTI4ijo5Aio5OR0OYc/muJ2taX1xpdTr7y74P7H46ExkWjwiq/
 jns/yIhMTboUT9LyFuzSKsWovGpDQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1c72u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 14:46:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645EdXBT028047;
 Tue, 5 May 2026 14:46:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw25gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 14:46:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645EkbQ827329268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 14:46:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E92F058067;
 Tue,  5 May 2026 14:46:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50A8658052;
 Tue,  5 May 2026 14:46:36 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 14:46:36 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Laurent Vivier" <laurent@vivier.eu>, "Chinmay Rath" <rathc@linux.ibm.com>
Subject: [PATCH] Revert "hw/ppc: Deprecate 405 CPUs"
Date: Tue,  5 May 2026 09:46:10 -0500
Message-ID: <20260505144621.1308457-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: k_T1NN7340aFyCXsE4wuSAHRKsY0AgVK
X-Proofpoint-GUID: 6eVIodOhHvptOT-Htt42UBH08r-2F-mk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MCBTYWx0ZWRfX2FRtjeDaZOEl
 xyw9oIWBBTUysj68vylEA/nqUcZqU+qxaKV7RS/br97LlPFPxR37jXW1uCsIpdaeMiPwA3X6+8j
 emktk9CH9CKNXHhnBwnyyaCG0SYIAFfChS+nYLnuSMsjDtfIMRZR+KjHKOx/f/RfXGpLpuXmwoB
 yULD7aX8tkrjIQW2LY/hsnEnLDNb8FhV/tGtIsqC6hQ8dqOmcvrhAJYe1HAKAQzgMkmNQxg55ww
 skFYT93ijy54fQfkJcv3bUh8C1vAHTyUHw+CIZkrOxZy7gl3w56CbSzTnp5VnIWxA2wmaFFy5ty
 9x+2je3P40omK11AGcBeCkltMDg7BqjypwJtDs12Ytxkzgu52pyLMYf/XguqkB5v2jgNqIBW0vL
 4zlE450yXmgsnfgQlGApDOTlsUa9oBhzW9/xKk3f4475hLklcjo4QDFMjn9m47tD/OlOFr9T8Ey
 5uSx2CewqGWkj//WuWg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fa02cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=kzH-N7ndX5ZrohmAGq0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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

This reverts commit 52f0b59ec6b780f2a3e162d5862b90b406fa4697.

The PowerPC 405 CPU is used by the PPE42 CPU which was added to
QEMU v10.2.  The PPE42 CPU is basically a stripped down version
of the PowerPC 405 CPU and is used by the Power9, Power10, and
Power11 CPUs as an embedded processor to handle various tasks.
Also, IBM has plans to use the PowerPC 405 CPU model within a
year to model the On Chip Controller (OCC), which has an embedded
PPC405 CPU.  Therefore, this patch removes the PowerPC 405 CPU
from the deprecated list.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>

---
 docs/about/deprecated.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 10de10dc23..3639000af2 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -209,15 +209,6 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
-PPC 405 CPUs (since 10.0)
-'''''''''''''''''''''''''
-
-The PPC 405 CPU has no known users and the ``ref405ep`` machine was
-removed in QEMU 10.0. Since the IBM POWER [8-11] processors uses an
-embedded 405 for power management (OCC) and other internal tasks, it
-is theoretically possible to use QEMU to model them. Let's keep the
-CPU implementation for a while before removing all support.
-
 Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.43.7


