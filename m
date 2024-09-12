Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5246FEEB575
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sog9w-00075U-4D; Thu, 12 Sep 2024 05:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9h-0006vR-1K
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9e-0004L6-BT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BLcvX9004900;
 Thu, 12 Sep 2024 09:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=BciYKAAcVl6ew
 /+esm6yGIWokh3KtE4RrIk6UxbGtY0=; b=L34JnH1ZIpeT5C4k/HSRaNHNKgGpw
 TpdsUzYKuvJF7MIPksEcJ5Oda8b/lvJEq/8xHdiGD0xZA3HXOsgMbL6LcHMU9/wx
 80jQH7wounYVKHB7qUd/QUUpxvAm2HCnOK5Gaqg5Osy7Le51j1kI4SRh8931HCzf
 Hh8XOrU1QEDW1TsT/ObaDeFW8wloZrb5n89A5NWj8F42NUVhWhgfKPK6PW8Hyq9b
 nPqwwU+3QmDpBE5C7iIYeOkvK8Qnd/F1UmfqZSIEzx9z9yTht1COS1O+w8HRaiqw
 KNBk4bRky/aeUvFfnozb5G4LTIfvSMtG0/aefHbHCS+chxlA6glC1wX5g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qjwsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C9UI6X015105;
 Thu, 12 Sep 2024 09:30:18 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qjwsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C7SbOl027315;
 Thu, 12 Sep 2024 09:30:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3eq3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C9UGb152036058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 09:30:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECDC320043;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EE3020063;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.24.155])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/5] include/exec: Introduce env_cpu_const()
Date: Thu, 12 Sep 2024 11:28:20 +0200
Message-ID: <20240912093012.402366-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912093012.402366-1-iii@linux.ibm.com>
References: <20240912093012.402366-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8e34rjlLK89IFtaoWerltAVKI_xLS606
X-Proofpoint-ORIG-GUID: 7eb0YrslVHJHS8S5-ccZKlcheYJMoSju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's the same as env_cpu(), but for const objects.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/exec/cpu-common.h | 13 ++++++++++++-
 linux-user/elfload.c      |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2998c95da4a..dc5cffadf29 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -242,6 +242,17 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
+/**
+ * env_cpu_const(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUState associated with the environment.
+ */
+static inline const CPUState *env_cpu_const(const CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
 /**
  * env_cpu(env)
  * @env: The architecture environment
@@ -250,7 +261,7 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
  */
 static inline CPUState *env_cpu(CPUArchState *env)
 {
-    return (void *)env - sizeof(CPUState);
+    return (CPUState *)env_cpu_const(env);
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0861f115fc4..05292c27776 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4329,7 +4329,7 @@ static int wmr_write_region(void *opaque, target_ulong start,
  */
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
-    const CPUState *cpu = env_cpu((CPUArchState *)env);
+    const CPUState *cpu = env_cpu_const(env);
     const TaskState *ts = (const TaskState *)get_task_state((CPUState *)cpu);
     struct rlimit dumpsize;
     CountAndSizeRegions css;
-- 
2.46.0


