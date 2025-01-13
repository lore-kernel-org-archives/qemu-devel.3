Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBACBC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKmr-0000xK-0j; Mon, 13 Jan 2025 08:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXKmp-0000wT-Dl
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:47:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXKmm-0006UP-FK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:47:23 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCmMbj020832;
 Mon, 13 Jan 2025 13:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GwXKR2zRXtYZzYY4t
 CErncAcg57/dUdGdnm15qEjL34=; b=cxuAFpglpg75fVcGytKiGqPJ2XDbAjnKz
 WuzmYqj7KNSaJAAk+ioRJsTTs5ojG+BIOaA0aYfN/pyV+unpKEFNXr/ZeoQMkeGl
 weri99ZnQS1WuOk9NUiLHWZkDTAIj8SCoKxs5GWM/NAk2WnQrVl37YZ3O2UIbq3K
 3N7L4/USvw4K/kdNc8J2xBVJUakTfZTxRwUieW8irIyo6m5ae1mcrnGXH7sft88B
 dBxZKd15+K5UBY7RTcE2ulG0ek5oIQyGj7mppevp6SoHSjMyIPZDiAEf4MvgVG0U
 kGbwPVEUho4F9KgwJNvrLr8CTxjYy3KoC+6afsrRonKRqPV0L/g3A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qvhjtpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 13:47:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCKdtd007462;
 Mon, 13 Jan 2025 13:47:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ymxd0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 13:47:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50DDlDMO34210072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jan 2025 13:47:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4BBF2004B;
 Mon, 13 Jan 2025 13:47:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7148220040;
 Mon, 13 Jan 2025 13:47:13 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Jan 2025 13:47:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] cpu: Set current_cpu early in qemu-user
Date: Mon, 13 Jan 2025 14:36:27 +0100
Message-ID: <20250113134658.68376-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113134658.68376-1-iii@linux.ibm.com>
References: <20250113134658.68376-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W5G2pGOwh689tLFeV1UuCKLYCqs_ETw-
X-Proofpoint-ORIG-GUID: W5G2pGOwh689tLFeV1UuCKLYCqs_ETw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=848 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.787, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

gdb_handlesig() uses current_cpu.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c      | 2 ++
 linux-user/main.c    | 2 ++
 linux-user/syscall.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0a5bc578365..aa052e515c9 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -627,6 +627,8 @@ int main(int argc, char **argv)
 
     target_cpu_init(env, regs);
 
+    current_cpu = cpu;
+
     if (gdbstub) {
         gdbserver_start(gdbstub);
         gdb_handlesig(cpu, 0, NULL, NULL, 0);
diff --git a/linux-user/main.c b/linux-user/main.c
index b97634a32dd..b2bf0688617 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1022,6 +1022,8 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
+    current_cpu = cpu;
+
     if (gdbstub) {
         if (gdbserver_start(gdbstub) < 0) {
             fprintf(stderr, "qemu: could not open gdbserver on %s\n",
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78c7c0b34ef..a101f177632 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6542,6 +6542,7 @@ static void *clone_func(void *arg)
     env = info->env;
     cpu = env_cpu(env);
     thread_cpu = cpu;
+    current_cpu = cpu;
     ts = get_task_state(cpu);
     info->tid = sys_gettid();
     task_settid(ts);
-- 
2.47.1


