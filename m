Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A1AD18144
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 20:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0RmJ-0000hN-Oc; Mon, 14 Oct 2024 16:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t0RmH-0000gn-Dn; Mon, 14 Oct 2024 16:34:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t0RmF-0004dQ-JP; Mon, 14 Oct 2024 16:34:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJBqnF023357;
 Mon, 14 Oct 2024 20:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=de+lJbdXTLaIXfMMfHlSuAT1cH
 RlcjPpUelMEsqgAeE=; b=V03YzFdaPWJHKpwUE4soaTUZ20uuA5lrHbNxs3Sbja
 57P0xmBkZYTGjgtnbO2HHEC3p5t2XVOgPYslIv01IGn91bOPe+71NM0HfhX4j0ew
 5TFwmfU+Swo47x3FzFsAiateepD0ysdN1eyw5FIMoHYUKxIyX7yFaLkIRXQsk25f
 ++Hnf2ZVqQyX0+h/pGHFLaFnmk8EVkymyDBN7AVwtOtroAuawiZ5kH2E2h22xi/x
 gaKW2EXRm1L2JJp0DVPZ9tdGlmXACFeYX7MDItqO+ymkMjPcLPADvWfbWxzaO12D
 tm5ICg0/VBKcFcJFY0NDswlrAHQE2cDJbNiVCqcZL7Lw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429929gb7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 20:34:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EHtic7002473;
 Mon, 14 Oct 2024 20:34:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emgdjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 20:34:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49EKYhH147382944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 20:34:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 777B92004B;
 Mon, 14 Oct 2024 20:34:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20AEB20040;
 Mon, 14 Oct 2024 20:34:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.20.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 20:34:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] linux-user: Emulate /proc/self/maps under mmap_lock
Date: Mon, 14 Oct 2024 22:34:21 +0200
Message-ID: <20241014203441.387560-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5aSKScscJxd_hVjsM7-I04v-fbltkn5j
X-Proofpoint-GUID: 5aSKScscJxd_hVjsM7-I04v-fbltkn5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

If one thread modifies the mappings and another thread prints them,
a situation may occur that the printer thread sees a guest mapping
without a corresponding host mapping, leading to a crash in
open_self_maps_2().

Cc: qemu-stable@nongnu.org
Fixes: 7b7a3366e142 ("linux-user: Use walk_memory_regions for open_self_maps")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1354e756941..dd2ec0712b8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8151,17 +8151,19 @@ static int open_self_maps_1(CPUArchState *env, int fd, bool smaps)
 {
     struct open_self_maps_data d = {
         .ts = get_task_state(env_cpu(env)),
-        .host_maps = read_self_maps(),
         .fd = fd,
         .smaps = smaps
     };
 
+    mmap_lock();
+    d.host_maps = read_self_maps();
     if (d.host_maps) {
         walk_memory_regions(&d, open_self_maps_2);
         free_self_maps(d.host_maps);
     } else {
         walk_memory_regions(&d, open_self_maps_3);
     }
+    mmap_unlock();
     return 0;
 }
 
-- 
2.47.0


