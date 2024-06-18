Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FEBC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJU8W-0004jN-8y; Tue, 18 Jun 2024 04:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJU8U-0004iB-My; Tue, 18 Jun 2024 04:24:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJU8T-0000Tr-5H; Tue, 18 Jun 2024 04:24:14 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6SCW2017478;
 Tue, 18 Jun 2024 08:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=PuqnjpDd/9ttC
 KEZsxkOPGCL9lRR7Oqyk9qLr1wbxPg=; b=SU/xjL3Yo1aj1S/Gt45MIJHsb3H3t
 +WlVeGYMM5OGSJS3NLEBU4KvK424LBNs0dG1tlgMshogWrNMYUOHsgAX91HnU/dS
 mmKgdQ/CZtztctU4J6eifHAn7WdOFCAuUAlvxZUzaSW4rybilq+n95ARls4AKhA2
 T3ZYrc77KAWJuteLDIGVEoPe4KrqIUnh18AORvZaT1Ga2RLyYX98LMX5XFC2ZqOf
 crTfFZ6eE1RvcM3qZFz+UKRtJQ2oSbsiYF5VO/CGOTrlrmJTJGjFNyAJDmpIlVHT
 iwqK7UI+XCIaaQDija1Nrcyn625NCtL+joiXsFOm9w/6XGdYVxAJ/BfrQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu44frcn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:24:11 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I8OABC032461;
 Tue, 18 Jun 2024 08:24:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu44frcn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:24:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45I78ihC023963; Tue, 18 Jun 2024 08:24:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9q1786-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:24:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45I8O4sM37880196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 08:24:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45FB720067;
 Tue, 18 Jun 2024 08:24:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C32B42005A;
 Tue, 18 Jun 2024 08:24:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.242.165])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jun 2024 08:24:02 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, pbonzini@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH v4 2/3] cpu-common.c: export cpu_get_free_index to be reused
 later
Date: Tue, 18 Jun 2024 13:53:53 +0530
Message-ID: <20240618082354.13919-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618082354.13919-1-harshpb@linux.ibm.com>
References: <20240618082354.13919-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QdbwXNKxRiuxES3D5Y513Oa0gNANuNSM
X-Proofpoint-GUID: N3cxRA77EDHah9WiYQPWRc2jHd_I73z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=897 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

This helper provides an easy way to identify the next available free cpu
index which can be used for vcpu creation. Until now, this is being
called at a very later stage and there is a need to be able to call it
earlier (for now, with ppc64) hence the need to export.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/exec/cpu-common.h | 2 ++
 cpu-common.c              | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 240ee04369..2e1b499cb7 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -35,6 +35,8 @@ void cpu_list_lock(void);
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
2.45.1


