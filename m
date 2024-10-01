Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201DBCEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svevX-0006bK-4D; Tue, 01 Oct 2024 11:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svevV-0006Yp-71; Tue, 01 Oct 2024 11:36:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svevS-0006W9-Rb; Tue, 01 Oct 2024 11:36:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491EJa8h020050;
 Tue, 1 Oct 2024 15:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=biRTxaQ2nLFFt
 oroHxPtERfzdXigXBF0DaJmILfni58=; b=mMkUPaD35E2+JJD44fZNm+15ceZQX
 YV7evUMtWkmk7aC5V8WWxxsuB2Yd5f4DdYLR1rJtKgmZLrZRfs9TGSbU+DKchdAg
 76/AP3djS9oM6Fv/215IsQw6RwyjQ3VyIz0car8v2i3/tk7j90o+l24IRaXCR9Lc
 /wfZj1vaT8lw4hr+cZpYzzCikIByYAynvrCydnSVWkr6vz3ioRHlbEAxiyuHOdpH
 gxRT5nZyJG/7cxFI6pnGQBr9e5Ni73Vae/unfIKl2NTzDnX+mwitpzkk1ABPpY52
 oJbklIIrGhPgtd5J4ql0sMKdRKR5TE2Tz/j89OPmNk15M9ZQlGrs+YIEg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420jra8eb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491FaVxH028398;
 Tue, 1 Oct 2024 15:36:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420jra8eb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491Cm39J014150;
 Tue, 1 Oct 2024 15:36:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk5578-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 15:36:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491FaOof17301956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 15:36:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 901A720043;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4829020040;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.fritz.box (unknown
 [9.171.30.227]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 15:36:24 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Jens Remus <jremus@linux.ibm.com>
Subject: [PATCH v1 2/3] pc-bios/s390-ccw: Don't generate TEXTRELs
Date: Tue,  1 Oct 2024 17:36:17 +0200
Message-ID: <20241001153618.17791-3-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001153618.17791-1-mhartmay@linux.ibm.com>
References: <20241001153618.17791-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MUa31YAqcDgCpHBOZQC4zfnALsUbXHhl
X-Proofpoint-ORIG-GUID: GH_eRofEq1T46387UwRVnobiGvU9JdEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jens Remus <jremus@linux.ibm.com>

Commit 7cd50cbe4ca3 ("pc-bios/s390-ccw: Don't use __bss_start with the
"larl" instruction") introduced the address constant bss_start_literal
for __bss_start in the .text section, which introduced a relocation in
code (i.e. TEXTREL). The dedicated constant is required, as __bss_start
may not necessarily be aligned on a 2-byte boundary (see subject commit
for details).

Move the constant to the .data section to get rid of the relocation in
the .text section. Add the linker option -z text to prevent TEXTRELs to
get introduced in the future.

Note that the R_390_RELATIVE relocations are taken care of by function
glue() in include/hw/elf_ops.h.inc introduced by commit 5dce07e1cb67
("elf-loader: Provide the possibility to relocate s390 ELF files").

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 pc-bios/s390-ccw/start.S  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 6207911b53aa..ab6bd1edf41e 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -40,7 +40,7 @@ EXTRA_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -fno-common -fPIE
 EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
 EXTRA_CFLAGS += -msoft-float
 EXTRA_CFLAGS += -std=gnu99
-LDFLAGS += -Wl,-pie -nostdlib -z noexecstack
+LDFLAGS += -Wl,-pie -nostdlib -z noexecstack -z text
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 576fc12c06e8..b70213e41246 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -113,8 +113,6 @@ io_new_code:
     br      %r14
 
     .balign 8
-bss_start_literal:
-    .quad   __bss_start
 disabled_wait_psw:
     .quad   0x0002000180000000,0x0000000000000000
 enabled_wait_psw:
@@ -124,6 +122,11 @@ external_new_mask:
 io_new_mask:
     .quad   0x0000000180000000
 
+.data
+    .balign 8
+bss_start_literal:
+    .quad   __bss_start
+
 .bss
     .balign 8
 stack:
-- 
2.43.0


