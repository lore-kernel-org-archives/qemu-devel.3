Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB4FC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 10:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjyge-0003SZ-Fn; Mon, 17 Feb 2025 05:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tjygc-0003SA-1l
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:49:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tjygZ-0001qg-VB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:49:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GModuX030494;
 Mon, 17 Feb 2025 10:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=XkLxPGhf9nzTPiaSG8chHe9qdg6Vun0AVSHRG71PH
 Ew=; b=EsvgxXk+clHnO4PeI+8DE3TJgMw7+u9h600wI2AGG4Deaf7t1D4MpUZSC
 j8iT8t5oN3MNSZUMT5s3Ce7ics/pBv7ARYOoD4dkZxNGUmbBhjDj9QO0zcDV3Oa2
 XC0hYEvfV1K0WPFT6wVaelOoA04Aoosu+IFvSv4wa0894+KU0lrJuLj6BolQmtrW
 gJVAjqthQyhK8exDdHBi+EWAlDBjMknWJx3+dnkoVwEenDzZG7tlmVdjUwPrvu76
 Uc1f/fEoPzxC3RyZwW3YO5g7vOxX4Y/fEVRwo87aHeCYZbF9CoTOPTpl9NP63tks
 0jJSmm1D+O9eveQVRkopYBJVo0LYA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a2qpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 10:49:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA51MC013271;
 Mon, 17 Feb 2025 10:49:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkdfq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 10:49:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51HAn5Vn42795348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 10:49:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34DDE20043;
 Mon, 17 Feb 2025 10:49:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C916D20040;
 Mon, 17 Feb 2025 10:49:04 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.82.227])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 10:49:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] stub: Remove monitor-fd.c
Date: Mon, 17 Feb 2025 11:48:49 +0100
Message-ID: <20250217104900.230122-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OlR2iECsCV-SZvgzqSeP3451sm1fXuxx
X-Proofpoint-GUID: OlR2iECsCV-SZvgzqSeP3451sm1fXuxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=821 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Both monitor-fd.c and monitor-internal.c contain a stub for
monitor_get_fd(), which causes a duplicate symbol linker error when
linking rust-qemu-api-integration. Use monitor-internal.c instead of
monitor-fd.c and remove the latter.

Reported-by: Zhao Liu <zhao1.liu@intel.com>
Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Fixes: fccb744f41c6 ("gdbstub: Try unlinking the unix socket before binding")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 stubs/meson.build  | 2 +-
 stubs/monitor-fd.c | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)
 delete mode 100644 stubs/monitor-fd.c

diff --git a/stubs/meson.build b/stubs/meson.build
index b0fee37e059..63392f5e785 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -62,7 +62,7 @@ if have_user
     stub_ss.add(files('qdev.c'))
   endif
 
-  stub_ss.add(files('monitor-fd.c'))
+  stub_ss.add(files('monitor-internal.c'))
 endif
 
 if have_system
diff --git a/stubs/monitor-fd.c b/stubs/monitor-fd.c
deleted file mode 100644
index 9bb67498850..00000000000
--- a/stubs/monitor-fd.c
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#include "qemu/osdep.h"
-#include "monitor/monitor.h"
-
-int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
-{
-    abort();
-}
-- 
2.48.1


