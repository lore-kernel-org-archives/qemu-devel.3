Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03374C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 04:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u75PY-0004bE-Mu; Tue, 22 Apr 2025 00:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75PW-0004ab-5j; Tue, 22 Apr 2025 00:39:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75PU-0002gF-5S; Tue, 22 Apr 2025 00:39:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LMJqbS012196;
 Tue, 22 Apr 2025 04:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=UmClCp5AGqpcTU32WoW0ryR32Jjy
 xcbmNVPl6ZEnYws=; b=FZmESeUhorz++6JIT2pravz+xqicZOfy0eXIBg9k7Als
 LA+h03vDe+yDI951rNuOz7QvlNi7D3DH1wUWXBbj7uG2f4E+V4MIc5nel+SW5/uS
 CEVrw6aoPKeo2OClV2FG+OR5WAtsjjBC8in/3YxVD5q5RSCKnccOnCfxtilXQCzL
 y7TuB6y6gESRq3gIFbTa2s/wwRWEAj2jSq9sXpZm0Jy16kWCh4d38Vjch8/9X+/J
 ylBNToY8OQZdheypMzUE/oFI9++ZOeI10QQkDkjgnDlSQQ4Cyb45fc1d3VvPn92G
 EZOrxMvPXu3SG5f5ZENGs1d42mAZ6FzbHWoRnwrEUA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465mfsbnke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:38:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M4cClw027065;
 Tue, 22 Apr 2025 04:38:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465mfsbnkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:38:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M42QE4028120;
 Tue, 22 Apr 2025 04:38:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv20xyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:38:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53M4cnvE15663508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:38:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21C5620040;
 Tue, 22 Apr 2025 04:38:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D454520043;
 Tue, 22 Apr 2025 04:38:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.215.117])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Apr 2025 04:38:45 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v5 0/2] Deprecate Power8E and Power8NVL
Date: Tue, 22 Apr 2025 10:08:41 +0530
Message-ID: <20250422043843.26115-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cM/gskeN c=1 sm=1 tr=0 ts=68071d5e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=31Clpgyuveq3k6-D5LcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QEPb0y5_olgQRMGtj5Qjh5kewuQSL5A0
X-Proofpoint-ORIG-GUID: II3QaQu_GkJ1czLIEVMtYAMZIIWo1zlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Power8E and Power8NVL are not maintained, and not useful to qemu, and
upstream skiboot also has removed support till Power8 DD1.
Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
to be exact:

    commit c5424f683ee3 ("Remove support for POWER8 DD1")

No direct way to deprecate the pnv chips, a field like deprecation_note
could be added, but felt not needed as the chip will only get used if
the user requests corresponding 8E / 8NVL CPU, which will print
deprecation warning.

Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
which will throw the deprecation warning. So just deprecating CPUs should
be enough.

Changelog
=========
v5:
  + split into 2 patches, defining macro, and deprecating 8e & 8nvl
v4 (https://lore.kernel.org/qemu-devel/20250330211012.2932258-1-adityag@linux.ibm.com/):
  + remove unnecessary 'if'
v3:
  + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
v2:
  + add mention to docs/about/deprecated.rst
  + add '(deprecated)' in output of qemu-system-ppc64 --cpu help

Base Commit: a9cd5bc6399a80fcf233ed0fffe6067b731227d8

Aditya Gupta (2):
  target/ppc: Introduce macro for deprecating PowerPC CPUs
  target/ppc: Deprecate Power8E and Power8NVL

 docs/about/deprecated.rst |  9 +++++++++
 target/ppc/cpu-models.c   | 20 +++++++++++++++-----
 target/ppc/cpu_init.c     |  7 ++++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.49.0


