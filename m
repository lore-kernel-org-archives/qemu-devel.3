Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C57DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMV-0007pQ-Bi; Thu, 30 Oct 2025 04:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOMP-0007oY-3J
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOMJ-0007YZ-Cp
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TLn0Tk025885;
 Thu, 30 Oct 2025 08:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Sqlblq
 1MeXt0L45/MWtpbq9GmnPCdlDdo7dJ0KWWwek=; b=V0QgfVjBW5hHIqOsnR/5pw
 XzugRXLoUjkHUe8AcyGMhT0KXR5FmbDIRF+y8hBndOZRa/M2q0U/oxIO+VzExsBE
 RHAdh6jHY/MR/CKaoGTwuVkvb2WWEAv7P+BwvLLU0UssbnKvfFXPsXBf5mpP7Ieo
 i70Q4pbTRxw+2CCAn4Y6jcZWLpVZzROxuxxfzrHY7bUTFL8svgCQZfve9K4fI4dW
 QX5LCVxBc2rW+Y3HFiOjiq+L5uHOfBGeu9MV5YucYSwEqAUbtLOaw6mUsLs/V7r/
 Q/cySt/7WzNI2EXMx1Lgs8D4eETQ0rfjbMZMEqGDEKKmDAGxJYdpIojFlVlQgVyw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acqdd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:50:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U60JbN019541;
 Thu, 30 Oct 2025 08:50:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy7q8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:50:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8nx6l22151654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7A612004D;
 Thu, 30 Oct 2025 08:49:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEB3220040;
 Thu, 30 Oct 2025 08:49:58 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:58 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] hw/ppc/pegasos: Update documentation for pegasos1
Date: Thu, 30 Oct 2025 14:19:36 +0530
Message-ID: <20251030084936.1132417-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=690326ba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=R4SA8OYZAAAA:8 a=a4NEJbfMAAAA:8
 a=h7_BzZE7AAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=P_rJWWM8_-YO9Bp8fwoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=7stNvC5sXRea_myt1Wfc:22
 a=TnV4WSYrcWMO94jUQ48d:22 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=p-dnK0njbqwfn1k4-x12:22 a=rLkV7i5x5X597yo9dRWc:22
X-Proofpoint-ORIG-GUID: dy3utwIkDwvX7rb823k-HtYFm-d6ZKwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX9yYosZBD0eyl
 0EgaauGrJGkScr3nCMxJGg8/r0BUxfAwz+USsUxLMc+NScr3rXqJQ90h3XAqa9/cMr3+w8nclX3
 ULORgugVUtru+9GRuxwrE0/1yw71Jtv0iRwz1QdpCmH+u4kmn2rT9oy5yK3XCHfY1HXn/cXT6cK
 ZWIDcVqDGImO/2bNVGyePQ/xEXysLzT76UA+ManbgNohRQ8ywXVjX486HH8CraxBWMxNFbwejQh
 /LznKjsrOkgt8nFLtUOqd7tVfsNQ6ajxR0+XruaYIH/IzSjOedneLbLtVm4JXx9mOj6lOQltdGG
 qRKsbMEH/vFngyAYFayTrlU0yCamqKCSD52PpeHqsA/iro27yU5XUrKWA/fvBSH9nDDaEpuKfa0
 IlrlfDt5SEYue2YA39CnQFpDCc2dvw==
X-Proofpoint-GUID: dy3utwIkDwvX7rb823k-HtYFm-d6ZKwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/f86b90f6839a0cf9426c0d89e95e6ca33704728c.1761346145.git.balaton@eik.bme.hu
Message-ID: <f86b90f6839a0cf9426c0d89e95e6ca33704728c.1761346145.git.balaton@eik.bme.hu>
---
 docs/system/ppc/amigang.rst | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
index 21bb14ed09..e290412369 100644
--- a/docs/system/ppc/amigang.rst
+++ b/docs/system/ppc/amigang.rst
@@ -1,6 +1,6 @@
-=========================================================
-AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
-=========================================================
+=======================================================================
+AmigaNG boards (``amigaone``, ``pegasos1``, ``pegasos2``, ``sam460ex``)
+=======================================================================
 
 These PowerPC machines emulate boards that are primarily used for
 running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
@@ -64,18 +64,23 @@ eventually it boots and the installer becomes visible. The ``ati-vga`` RV100
 emulation is not complete yet so only frame buffer works, DRM and 3D is not
 available.
 
-Genesi/bPlan Pegasos II (``pegasos2``)
-======================================
+Genesi/bPlan Pegasos (``pegasos1``, ``pegasos2``)
+=================================================
 
-The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
-designed by bPlan. Its schematics are available at
-https://www.powerdeveloper.org/platforms/pegasos/schematics.
+The ``pegasos1`` machine emulates the original Pegasos (later marked I) sold by
+Genesi and designed by bPlan. It uses the same Articia S north bridge as the
+``amigaone`` machine, otherwise it is mostly the same as the later Pegasos II.
+
+The ``pegasos2`` machine emulates the Pegasos II which is a redesigned version
+of Pegasos I to fix problems with its north bridge. Its schematics are available
+at https://www.powerdeveloper.org/platforms/pegasos/schematics.
 
 Emulated devices
 ----------------
 
  * PowerPC 7457 CPU (can also use ``-cpu g3`` or ``750cxe``)
- * Marvell MV64361 Discovery II north bridge
+ * Articia S north bridge (for ``pegasos1``)
+ * Marvell MV64361 Discovery II north bridge (for ``pegasos2``)
  * VIA VT8231 south bridge
  * PCI VGA compatible card (guests may need other card instead)
  * PS/2 keyboard and mouse
@@ -83,9 +88,9 @@ Emulated devices
 Firmware
 --------
 
-The Pegasos II board has an Open Firmware compliant ROM based on
+The Pegasos boards have an Open Firmware compliant ROM based on
 SmartFirmware with some changes that are not open-sourced therefore
-the ROM binary cannot be included in QEMU. An updater was available
+the ROM binary cannot be included in QEMU. A Pegasos II updater was available
 from bPlan, it can be found in the `Internet Archive
 <http://web.archive.org/web/20071021223056/http://www.bplan-gmbh.de/up050404/up050404>`_.
 The ROM image can be extracted from it with the following command:
@@ -111,7 +116,7 @@ At the firmware ``ok`` prompt enter ``boot cd install/pegasos``.
 
 Alternatively, it is possible to boot the kernel directly without
 firmware ROM using the QEMU built-in minimal Virtual Open Firmware
-(VOF) emulation which is also supported on ``pegasos2``. For this,
+(VOF) emulation which is also supported on ``pegasos1`` and ``pegasos2``. For this,
 extract the kernel ``install/powerpc/vmlinuz-chrp.initrd`` from the CD
 image, then run:
 
-- 
2.43.5


