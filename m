Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A5DCF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpl-0006qm-8e; Mon, 23 Sep 2024 12:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpb-0006Xl-VH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0000cL-0p
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NAIFSe027592;
 Mon, 23 Sep 2024 16:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=WN3/U2+USrWvM
 Y+DeKvu28fORRmLsnH2CzE0ZonIXnk=; b=Ft3KeRToI2r8rzifjPFk5tR/Yi1Mw
 gTW8dH/zm5Vz7n6wtFSTGBpqlLu4SMDE0BdjnunqNSSWawxmuR3GUqLfMmX37tR8
 jOh2kgrBgd5KcP/hvxIXKmqseZOy6HrmCP/RsFnZLbjn7ucc8Qv3ApNj8rzDQC37
 ED6XWztdBNzVzKfsFfeEX+h0fMozZm2rEckBJf7GeM/p5e8NrnC+5z3c083Qi7/R
 T3YP0m/rLFnX5ITc79fbdUPlAgniZBkcYiWF7NP4zLuFHV2YU3MiogtLsYuBobFs
 MHPBe1NSCRay2JE90C/93xee7lOSi6NUmY4IUH3eTIM+Rk1+ijP8a2emg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14pcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGJFhW018370;
 Mon, 23 Sep 2024 16:22:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14pcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NEF4Sd012489;
 Mon, 23 Sep 2024 16:22:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpqg0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMN4J49611236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3393A20040;
 Mon, 23 Sep 2024 16:22:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD63320043;
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 15/18] cpu: Set current_cpu early in qemu-user
Date: Mon, 23 Sep 2024 18:13:10 +0200
Message-ID: <20240923162208.90745-16-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ccg1hI_Opm5eyXFZ-7BIrDFlOQ6cooJD
X-Proofpoint-GUID: AhV3feqNPaNBasTvtutqeCZnAgkB0LIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=778
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

qemu_plugin_get_registers() may be called before cpu_exec(), and it
requires current_cpu.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c      | 1 +
 linux-user/main.c    | 1 +
 linux-user/syscall.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index b424a21f643..fb70aadbcee 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -617,6 +617,7 @@ int main(int argc, char **argv)
         gdbserver_start(gdbstub);
         gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
+    current_cpu = cpu;
     cpu_loop(env);
     /* never exits */
     return 0;
diff --git a/linux-user/main.c b/linux-user/main.c
index 60091cf3053..4a794445d72 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1022,6 +1022,7 @@ int main(int argc, char **argv, char **envp)
     qemu_semihosting_guestfd_init();
 #endif
 
+    current_cpu = cpu;
     cpu_loop(env);
     /* never exits */
     return 0;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 344c2e65234..46a8ba7098c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6531,6 +6531,7 @@ static void *clone_func(void *arg)
     pthread_mutex_lock(&clone_lock);
     pthread_mutex_unlock(&clone_lock);
     bql_lock();
+    current_cpu = cpu;
     cpu_loop(env);
     /* never exits */
     return NULL;
-- 
2.46.0


