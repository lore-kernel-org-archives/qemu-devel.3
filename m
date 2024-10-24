Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA20D0E3F3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4414-0003PL-Vm; Thu, 24 Oct 2024 16:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t440q-0003Jd-PX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t440o-0002Dn-TB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:00:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHuol7027146;
 Thu, 24 Oct 2024 20:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gXPMKOYMZnvmSB4pd
 Nmk37nyU93FpLtqLe/ASu2oIvY=; b=q+V9MNhwa/ZoT1WfhF+nFxGfvYidKeGgm
 lA5o0XtbtWY5Scm0TblAda6E7RhV8MnDU7pdjmiS6Nrs714qVw57NDL6kM3yg+aa
 Y45+EP0FEiDLmUdDu3GQTHPlgIc/Iukz66oqlNKvy1cjYgXk9dV5v0s8c9nvIyA7
 M18X2q0wqlF2juzWASpYb4/PEnw0cLfWhQlcvf2Q+JD3MGF4hECTdgGc/oXh8S2k
 lJpK2w37GqFLH9/5abKziZV5oJME4whgWVmhcZHrlKilGg4sGLYskB08XbYVI6cu
 vuNkT0kd87H2JgXe4329IGXCDFB0kwEw5ctFQY8py2+wdjJEGJxHQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnukx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 20:00:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHx1QJ012603;
 Thu, 24 Oct 2024 20:00:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfj8xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 20:00:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49OK0ajp56623398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 20:00:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67D6420040;
 Thu, 24 Oct 2024 20:00:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAC8C2004B;
 Thu, 24 Oct 2024 20:00:35 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.25.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2024 20:00:35 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 5/8] osdep: Introduce qemu_kill_thread()
Date: Thu, 24 Oct 2024 21:59:12 +0200
Message-ID: <20241024200031.80327-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024200031.80327-1-iii@linux.ibm.com>
References: <20241024200031.80327-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W0eNdIaH7aQ0Fpy5Y2V3hUEQenoK9SMD
X-Proofpoint-GUID: W0eNdIaH7aQ0Fpy5Y2V3hUEQenoK9SMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 mlxlogscore=875 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240159
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

Add a function for sending signals to individual threads. It does not make
sense on Windows, so do not provide an implementation, so that if someone
uses it by accident, they will get a linker error.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/qemu/osdep.h |  9 +++++++++
 util/oslib-posix.c   | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fe7c3c5f673..2350477787a 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -626,6 +626,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
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
index 11b35e48fb8..32a41fa8640 100644
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
2.47.0


