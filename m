Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D84E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVcdo-0007HW-Sp; Wed, 08 Jan 2025 15:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdb-0007Ds-8F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdZ-0006s2-AP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:47 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IRGOh022466;
 Wed, 8 Jan 2025 20:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/hbt49r67rS3xCl1j
 HRcoMA5k7zqsxxjHM6BonbVVyc=; b=Wg1PSPzgPohBvg3wIp83m7QXSaekqsEQb
 WmSqF8f+ZbLA/l36yddgbIF/jA429jtqMPxilEUbmiUHvY01P/juwBjRJ67YthtS
 +pYytElhneVYhG8/P3z52vT1vsLqZa0szfWgalMvnhoOzhhE4pog9hcN6jgOqrEJ
 O6awnojTuHVf9vNp/fzWPl1l/QMMpf5BfuEiWpOJ2KSfSVZs2f5WNwM54fRJuh3a
 aCc9YqlLxPv/nEWSiBfSEbf4uq9mUmN+y4cuhv8ved/Jxzs/ZOuPLsG8kNep9aCh
 OSq7dKZ+9s0Lb2MF3G+7NceBxa/S11DEpt/jLgeqhUPnVs2LShJrg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj3b84w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508JPuSN004143;
 Wed, 8 Jan 2025 20:26:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat9t12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508KQVEl59376020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 20:26:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAD8D20043;
 Wed,  8 Jan 2025 20:26:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3990820040;
 Wed,  8 Jan 2025 20:26:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.127])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 20:26:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Warner Losh <imp@bsidmp.com>
Subject: [PATCH v4 6/9] osdep: Introduce qemu_kill_thread()
Date: Wed,  8 Jan 2025 21:05:01 +0100
Message-ID: <20250108202625.149869-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108202625.149869-1-iii@linux.ibm.com>
References: <20250108202625.149869-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JtFTFsRK_p7Xrv21eNqckkcVokxJYtRc
X-Proofpoint-GUID: JtFTFsRK_p7Xrv21eNqckkcVokxJYtRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=939 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080163
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a function for sending signals to individual threads. It does not make
sense on Windows, so do not provide an implementation, so that if someone
uses it by accident, they will get a linker error.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsidmp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/qemu/osdep.h |  9 +++++++++
 util/oslib-posix.c   | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b94fb5fab8c..37ee3eabae3 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -630,6 +630,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
 int qemu_get_thread_id(void);
 
+/**
+ * qemu_kill_thread:
+ * @tid: thread id.
+ * @sig: host signal.
+ *
+ * Send @sig to one of QEMU's own threads with identifier @tid.
+ */
+int qemu_kill_thread(int tid, int sig);
+
 #ifndef CONFIG_IOVEC
 struct iovec {
     void *iov_base;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7a542cb50b5..f8eb3f17b2f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -111,6 +111,21 @@ int qemu_get_thread_id(void)
 #endif
 }
 
+int qemu_kill_thread(int tid, int sig)
+{
+#if defined(__linux__)
+    return syscall(__NR_tgkill, getpid(), tid, sig);
+#elif defined(__FreeBSD__)
+    return thr_kill2(getpid(), tid, sig);
+#elif defined(__NetBSD__)
+    return _lwp_kill(tid, sig);
+#elif defined(__OpenBSD__)
+    return thrkill(tid, sig, NULL);
+#else
+    return kill(tid, sig);
+#endif
+}
+
 int qemu_daemon(int nochdir, int noclose)
 {
     return daemon(nochdir, noclose);
-- 
2.47.1


