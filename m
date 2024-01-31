Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10C6C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV95D-0000zk-GC; Wed, 31 Jan 2024 06:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rV950-0000xD-VB; Wed, 31 Jan 2024 06:48:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rV94u-0002e3-Jg; Wed, 31 Jan 2024 06:48:34 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VBbgxV011100; Wed, 31 Jan 2024 11:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EMJdS9hKoA7kur7DqvESiD5ICfk5HChs5chrzcRw4VA=;
 b=qczS+Q1Oiaaq1m1D/WIKJFOTzCjNNrVkjHDm9ScroX2L+TGk5k+FY1QYB1eZT7LzgY3u
 8RwuAzavPN/gszzxnjrI0oAxbsfkw53bAeRKLHXtnH48Bg7FpvI0C70S/r7LEZPgz8ps
 HmLS6O79s78cFAI5JyD6l65+rFteheWuRxpVOwAhlABDFstzWgbVtXhhWJTbi7YKLEEa
 Ve8BHHJ+UAdho/s7flAc08g/lOe2JecdIVlTNU64+toGoa11EHTDy76cl+SPuwTqcXbV
 E//CHMM1EAYCJi7wXWyKVXu2EzWeGVRBcvRGcsGSAA+IzlFNtomwbHTTWsFnvahyinQx SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyng687f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 11:48:24 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VBbUcU010885;
 Wed, 31 Jan 2024 11:48:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyng687eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 11:48:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40V9LuB7007964; Wed, 31 Jan 2024 11:48:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnm50rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 11:48:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VBmK1d23921160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 11:48:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 257B420040;
 Wed, 31 Jan 2024 11:48:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D987E20043;
 Wed, 31 Jan 2024 11:48:19 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 11:48:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 1/3] linux-user: Allow gdbstub to ignore page protection
Date: Wed, 31 Jan 2024 12:46:29 +0100
Message-ID: <20240131114817.288027-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131114817.288027-1-iii@linux.ibm.com>
References: <20240131114817.288027-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ypo8NGYjx0V5aTGoMJ2CJnSEUBrldO6d
X-Proofpoint-ORIG-GUID: Zn_nKpzR6Ko_qjLPb-xl_HaMYi9rx3jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=951 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

gdbserver ignores page protection by virtue of using /proc/$pid/mem.
Teach qemu gdbstub to do this too. This will not work if /proc is not
mounted; accept this limitation.

One alternative is to temporarily grant the missing PROT_* bit, but
this is inherently racy. Another alternative is self-debugging with
ptrace(POKE), which will break if QEMU itself is being debugged - a
much more severe limitation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 cpu-target.c | 78 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index f6e07c3deb1..958d63e8823 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -382,6 +382,9 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     vaddr l, page;
     void * p;
     uint8_t *buf = ptr;
+    ssize_t written;
+    int ret = -1;
+    int fd = -1;
 
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
@@ -389,30 +392,75 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         if (l > len)
             l = len;
         flags = page_get_flags(page);
-        if (!(flags & PAGE_VALID))
-            return -1;
+        if (!(flags & PAGE_VALID)) {
+            goto out_close;
+        }
         if (is_write) {
-            if (!(flags & PAGE_WRITE))
-                return -1;
-            /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
-                return -1;
-            memcpy(p, buf, l);
-            unlock_user(p, addr, l);
-        } else {
-            if (!(flags & PAGE_READ))
-                return -1;
+            if (flags & PAGE_WRITE) {
+                /* XXX: this code should not depend on lock_user */
+                p = lock_user(VERIFY_WRITE, addr, l, 0);
+                if (!p) {
+                    goto out_close;
+                }
+                memcpy(p, buf, l);
+                unlock_user(p, addr, l);
+            } else {
+                /* Bypass the host page protection using ptrace. */
+                if (fd == -1) {
+                    fd = open("/proc/self/mem", O_WRONLY);
+                    if (fd == -1) {
+                        goto out;
+                    }
+                }
+                /*
+                 * If there is a TranslationBlock and we weren't bypassing the
+                 * host page protection, the memcpy() above would SEGV,
+                 * ultimately leading to page_unprotect(). So invalidate the
+                 * translations manually. Both invalidation and pwrite() must
+                 * be under mmap_lock() in order to prevent the creation of
+                 * another TranslationBlock in between.
+                 */
+                mmap_lock();
+                tb_invalidate_phys_range(addr, addr + l - 1);
+                written = pwrite(fd, buf, l,
+                                 (off_t)(uintptr_t)g2h_untagged(addr));
+                mmap_unlock();
+                if (written != l) {
+                    goto out_close;
+                }
+            }
+        } else if (flags & PAGE_READ) {
             /* XXX: this code should not depend on lock_user */
-            if (!(p = lock_user(VERIFY_READ, addr, l, 1)))
-                return -1;
+            p = lock_user(VERIFY_READ, addr, l, 1);
+            if (!p) {
+                goto out_close;
+            }
             memcpy(buf, p, l);
             unlock_user(p, addr, 0);
+        } else {
+            /* Bypass the host page protection using ptrace. */
+            if (fd == -1) {
+                fd = open("/proc/self/mem", O_RDONLY);
+                if (fd == -1) {
+                    goto out;
+                }
+            }
+            if (pread(fd, buf, l,
+                      (off_t)(uintptr_t)g2h_untagged(addr)) != l) {
+                goto out_close;
+            }
         }
         len -= l;
         buf += l;
         addr += l;
     }
-    return 0;
+    ret = 0;
+out_close:
+    if (fd != -1) {
+        close(fd);
+    }
+out:
+    return ret;
 }
 #endif
 
-- 
2.43.0


