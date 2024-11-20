Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3BDD743D9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDsF1-0002Ip-1j; Wed, 20 Nov 2024 16:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tDsEx-0002IT-5S; Wed, 20 Nov 2024 16:27:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tDsEv-00021b-1y; Wed, 20 Nov 2024 16:27:58 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFMa2g030824;
 Wed, 20 Nov 2024 21:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=jCjDShz1aVErzgPi9lmBgQNWKRCv9KNz8L7Grd76l
 Iw=; b=RPFRc22Fg7EWRx4UrpqY24Erw7aU3G+OHWOt7scl9ywKW7stR5f4trvMw
 er2erGWGO5lGGOYN4mxrqa2VMlV2EfpkCxgQotce6Y+MB+S1KIsqXJIO1vbysdNI
 +buo56a1nRrRRQ9qcfZBXQEg8HEgPgJcsmCyhALUgExsVcAOjIExUpM3bSktDFbI
 hFcN9B0SAWwg86SYqu/QANruoxq0c6UJYk3ZmqmgTINtfhVOfjUNCOUNktDG0Hy8
 +NA1ZcUkT6TW9FgV6yxkljZ7YSpMCjDhKgPyfDY1XGMIaRqL2t83ahbiBStOW27L
 eA+zBHwAI+93uomNfVvb4WEHya+gw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjyaht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2024 21:27:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKLHWPN030975;
 Wed, 20 Nov 2024 21:27:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63yyvmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2024 21:27:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AKLRNDB7930166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2024 21:27:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B98332004B;
 Wed, 20 Nov 2024 21:27:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AD6220043;
 Wed, 20 Nov 2024 21:27:23 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.13.249])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2024 21:27:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2] linux-user: Fix strace output for s390x mmap()
Date: Wed, 20 Nov 2024 22:26:44 +0100
Message-ID: <20241120212717.246186-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GAOUO42APtQy1WCiP8AMv-WgylftHAJH
X-Proofpoint-GUID: GAOUO42APtQy1WCiP8AMv-WgylftHAJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=938
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200152
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

print_mmap() assumes that mmap() receives arguments via memory if
mmap2() is present. s390x (as opposed to s390) does not fit this
pattern: it does not have mmap2(), but mmap() still receives arguments
via memory.

Fix by sharing the detection logic between syscall.c and strace.c.

Cc: qemu-stable@nongnu.org
Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/qemu-devel/20241119211138.148806-1-iii@linux.ibm.com/
v1 -> v2: Share the detection logic between syscall.c and strace.c
          (Richard).

 linux-user/strace.c       | 2 +-
 linux-user/syscall.c      | 5 +----
 linux-user/syscall_defs.h | 7 +++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b70eadc19ef..9c55f39b095 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
 {
     return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
                            arg4, arg5,
-#if defined(TARGET_NR_mmap2)
+#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
                             true
 #else
                             false
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0279f235768..1ce4c79784f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10588,10 +10588,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_mmap
     case TARGET_NR_mmap:
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
-    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) \
-    || defined(TARGET_S390X)
+#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
         {
             abi_ulong *v;
             abi_ulong v1, v2, v3, v4, v5, v6;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0e08dfae3e4..faad9147c91 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2766,4 +2766,11 @@ struct target_open_how_ver0 {
 #define RESOLVE_NO_SYMLINKS     0x04
 #endif
 
+#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
+    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
+    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
+    defined(TARGET_S390X)
+#define TARGET_ARCH_WANT_SYS_OLD_MMAP
+#endif
+
 #endif
-- 
2.47.0


