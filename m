Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C16C25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 05:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7TjZ-00033D-NK; Thu, 16 May 2024 01:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjQ-00032e-MH; Thu, 16 May 2024 01:32:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjP-0005da-3s; Thu, 16 May 2024 01:32:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G4xCAw014355; Thu, 16 May 2024 05:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u5nUcOOzm7QvDOlxuhR8wow1ilAy/PMO5KzzFNCX8P8=;
 b=N4Y+N4cHlEyaWR2QGJejQTu+NNMsrGvAd2m6YbUJ4uF8D4brdwKFwSVnGNB9H1m8xQED
 NeH/6LOxSykPVHk3hHLd7XDF0v1kKpDHZ4gmVmVQut60WHnhXLP4huqLtXs9MhU4Kwup
 oE2ucLP32/EU5LBo9wrwjeqcdfzMYR4vCLxRaGl2xf0UWqa8tW0A7C0YaucyI07kV4Co
 mdIsiQPMZpeqVy/EqoH8tKhVQJCd/TAwdVCau1BI/lltACO2bjIOrBy7aYwXsfdLmuZR
 1mya71gVBzJoRF/Bk2gfZCO4yYY5pIMuiwUj8pgbSHPS8KQMVPfEXUxYd3YgQvFr4GmK Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5bbk04b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:34 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44G5WYnx007107;
 Thu, 16 May 2024 05:32:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5bbk04b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G3KLQI020349; Thu, 16 May 2024 05:32:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kd08asc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44G5WRdS45678988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 05:32:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FB332004B;
 Thu, 16 May 2024 05:32:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EB0F20040;
 Thu, 16 May 2024 05:32:25 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.79.188.146]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 05:32:24 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 salil.mehta@huawei.com
Subject: [PATCH v2 3/4] cpu-common.c: export cpu_get_free_index to be reused
 later
Date: Thu, 16 May 2024 11:02:10 +0530
Message-Id: <20240516053211.145504-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516053211.145504-1-harshpb@linux.ibm.com>
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xLxbcWmgAvnUQPq9d70bWpzuBBMzaVQZ
X-Proofpoint-GUID: 9x8epw0AlueFhm6WaeVtemyiaVdxQR9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_02,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=868 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160037
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

This helper provides an easy way to identify the next available free cpu
index which can be used for vcpu creation. Until now, this is being
called at a very later stage and there is a need to be able to call it
earlier (for now, with ppc64) hence the need to export.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/exec/cpu-common.h | 2 ++
 cpu-common.c              | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6d5318895a..0386f1ab29 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -29,6 +29,8 @@ void cpu_list_lock(void);
 void cpu_list_unlock(void);
 unsigned int cpu_list_generation_id_get(void);
 
+int cpu_get_free_index(void);
+
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
diff --git a/cpu-common.c b/cpu-common.c
index ce78273af5..82bd1b432d 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -57,14 +57,12 @@ void cpu_list_unlock(void)
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
-static bool cpu_index_auto_assigned;
 
-static int cpu_get_free_index(void)
+int cpu_get_free_index(void)
 {
     CPUState *some_cpu;
     int max_cpu_index = 0;
 
-    cpu_index_auto_assigned = true;
     CPU_FOREACH(some_cpu) {
         if (some_cpu->cpu_index >= max_cpu_index) {
             max_cpu_index = some_cpu->cpu_index + 1;
@@ -83,8 +81,11 @@ unsigned int cpu_list_generation_id_get(void)
 
 void cpu_list_add(CPUState *cpu)
 {
+    static bool cpu_index_auto_assigned;
+
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
+        cpu_index_auto_assigned = true;
         cpu->cpu_index = cpu_get_free_index();
         assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     } else {
-- 
2.39.3


