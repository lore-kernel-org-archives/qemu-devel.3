Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6273FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romKR-0006e3-Od; Mon, 25 Mar 2024 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKO-0006dP-4g
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKL-0001BC-RE
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PEPKtK007583; Mon, 25 Mar 2024 15:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xsIQz7z80DrbkYrWZ8KO9DLksja9CUgehp3MSWLnL6M=;
 b=UEFhQVoQPWR9UMzj2LQSAia4awqzN6UK74Ql2XtT0cOVNC7sZA2PXuknvYadmrgu122z
 Mv1YJtTuUzGMAzR4t+jJr4w/Np5rJTOtjMKhg+nFgVbsa15jpwfgS2tsqUEd7WuFwpco
 9VzTlbnHC5EcgzrsQNNehLgn4+z9af180QjGXYM6ES9Y89n2Lg6Z6Pr/JiwGUpDaelA5
 LqNH9s2KDilEy4r6Ok2BoGrnIbAvMKFNMFay3jzfj2D4u4UgGfIYiQLAozJOvXzdVmSB
 Lp9a5DF7NGJYJToF7sVmPGB/D5T2NsyUIShP4/2SDKDwkCzfB/bCBInashyqc70pr1Bt ww== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3a7vr8xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PDN35N016410; Mon, 25 Mar 2024 15:33:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dttav5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PFXRb152298164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 15:33:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D13CD2004B;
 Mon, 25 Mar 2024 15:33:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77FB120043;
 Mon, 25 Mar 2024 15:33:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 15:33:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/4] linux-user: Fix shmat(NULL) for h != g
Date: Mon, 25 Mar 2024 16:07:40 +0100
Message-ID: <20240325153313.526888-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325153313.526888-1-iii@linux.ibm.com>
References: <20240325153313.526888-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2TC536HHhny0i48WcPkpIO2IgpyiImkI
X-Proofpoint-GUID: 2TC536HHhny0i48WcPkpIO2IgpyiImkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_11,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011
 mlxlogscore=940 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

In the h != g && shmaddr == NULL && !reserved_va case, target_shmat()
incorrectly mmap()s the initial anonymous range with
MAP_FIXED_NOREPLACE, even though the earlier mmap_find_vma() has
already reserved the respective address range.

Fix by using MAP_FIXED when "mapped", which is set after
mmap_find_vma(), is true.

Fixes: 78bc8ed9a8f0 ("linux-user: Rewrite target_shmat")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e88faf1ab3d..681b6db1b67 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1358,7 +1358,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
         if (h_len != t_len) {
             int mmap_p = PROT_READ | (shmflg & SHM_RDONLY ? 0 : PROT_WRITE);
             int mmap_f = MAP_PRIVATE | MAP_ANONYMOUS
-                       | (reserved_va || (shmflg & SHM_REMAP)
+                       | (reserved_va || mapped || (shmflg & SHM_REMAP)
                           ? MAP_FIXED : MAP_FIXED_NOREPLACE);
 
             test = mmap(want, m_len, mmap_p, mmap_f, -1, 0);
-- 
2.44.0


