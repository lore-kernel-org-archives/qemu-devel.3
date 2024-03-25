Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD3BC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropwJ-0006ch-Bl; Mon, 25 Mar 2024 15:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1ropwA-0006ba-Rk
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:24:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1ropw9-0007vC-Bf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:24:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PHatRt014199; Mon, 25 Mar 2024 19:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d4raO4FXqA8ISg3QUii+dspus0gzJCpElzOjTWRIQ8k=;
 b=lC2kg6n4zXU/3b8H8aSG+Mtb+wrsEGrYDQHP8mW9qnjawNAzA/C7DnKPwm2lagFqd+An
 +Yp4t3iQCEBz/J3qm4YJTYeMTWF8MB+9qGUolLsb6gYrHO+2ZN9ihU94MoX6kD3v277V
 /0jQqJCwFQ0ToSv6EeDeYaqTKeIYcOiYMFXNW0XUSzC6Tpz+D6YhDGQzR2OQJ/2gYvXj
 dUX1kMMjK7vtRt4dyXV/DYKq9UA8LGrZn3k14bRVABYS6jH7YtNU1FAgIu1UDhsH9yAy
 5Ek0RGkIVsSKqz5bkN3/LL5js2lckStOeA0bCt1Ymj2+BXe4Xo1eca7a2qusCSE54rjT jQ== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3a7vrsfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 19:24:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PIiQk2003767; Mon, 25 Mar 2024 19:24:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42jpuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 19:24:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PJOh0228967452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 19:24:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 198852004B;
 Mon, 25 Mar 2024 19:24:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B27DB20040;
 Mon, 25 Mar 2024 19:24:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 19:24:42 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/4] linux-user: Fix shmat(NULL) for h != g
Date: Mon, 25 Mar 2024 20:23:01 +0100
Message-ID: <20240325192436.561154-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325192436.561154-1-iii@linux.ibm.com>
References: <20240325192436.561154-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1mQI2TzcbUAtX5bZcyVQVJuXffUN0MxQ
X-Proofpoint-GUID: 1mQI2TzcbUAtX5bZcyVQVJuXffUN0MxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 mlxlogscore=962 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250116
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


