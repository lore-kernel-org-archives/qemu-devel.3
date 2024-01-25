Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D921C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 20:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT60p-00048G-2t; Thu, 25 Jan 2024 15:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rT60n-00047t-Fg
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:07:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rT60l-00065c-1F
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:07:44 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PIMB7Y018053; Thu, 25 Jan 2024 20:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5NPZ30BfLY//oFVi6BxarxRQYePzRvdPCisYkiu0OWI=;
 b=OMM3e6/hKX78yu/Z5ilxH99XsPpLlgUo2F1TQoMDkAY64hvB6EwMchXoX8MlBpSulZMz
 ifDyGgyJc3qiC+0DgD064TUYTYwGL0LQNLFgw8wqfsxfBNyl8ceimSH4NAj2BgyYajZ4
 1HjSzZzsyZVM38a7DDajLYLnKHYCGx7Ukb6UBACnPwWwlzOzBeeExZqwEjVNNdbhOcuR
 DEjwBWYowxLj/RXjRvVMaX0y8ddiqtT0iKdf39t6RwY9U8ymJQrBp/NjzRJZ3h3NGgmp
 E43ALkO4K9P9/18p0fxBeIRyVrQsydqfW145U7BReUgn2aRMpn1j1jjOJM8jTHzdNmji ow== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0t7vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 20:07:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PHJjbD028233; Thu, 25 Jan 2024 20:07:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72wxy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 20:07:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PK7Ys724380006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 20:07:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5A3620043;
 Thu, 25 Jan 2024 20:07:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7582020040;
 Thu, 25 Jan 2024 20:07:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.21.210])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 20:07:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] {linux,
 bsd}-user: Fail mmap() if size doesn't fit into host's size_t
Date: Thu, 25 Jan 2024 21:07:02 +0100
Message-ID: <20240125200731.2633-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q8XQU5qGYSG1lFDWdIbSR1dgvcth2UVG
X-Proofpoint-GUID: Q8XQU5qGYSG1lFDWdIbSR1dgvcth2UVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

s390x's branch-relative-long test fails with the following error
message on 32-bit hosts:

    qemu-s390x: ../accel/tcg/user-exec.c:493: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.

The root cause is that the size passed to mmap() by this test does not
fit into 32 bits and gets truncated. Since there is no chance for such
mmap() to succeed, detect this condition and fail the mmap() right away.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/mmap.c   | 4 ++++
 linux-user/mmap.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 3ef11b28079..5dc327d0ad3 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -256,6 +256,10 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
 
     size = HOST_PAGE_ALIGN(size);
 
+    if (size != (size_t)size) {
+        return (abi_ulong)(-1);
+    }
+
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size,
             (alignment != 0 ? 1 << alignment :
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 96c9433e271..ae59d70fb67 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -389,6 +389,10 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
     size = HOST_PAGE_ALIGN(size);
 
+    if (size != (size_t)size) {
+        return (abi_ulong)(-1);
+    }
+
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size, align);
     }
-- 
2.43.0


