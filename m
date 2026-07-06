Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5871C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmb1-0006O8-5U; Mon, 06 Jul 2026 12:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmau-0006MI-Lp
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmas-0002yz-MZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FITsr507586; Mon, 6 Jul 2026 16:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5cS3U9nM4hcwYoRXu
 CsbWdnzjuAZj78G/YwnXxrBmfw=; b=nBHVHGjuT58ICGTNkDX3KHshmreAwCCnP
 F80s+PgIbX5zhAIdCiEooIXKpxPz0W9pDmvQOz7tQ6hsXbvm6DELOnmgiRay1GYf
 QTah9S7R+kPzyOgbDfnOJ1JWZsfM3yAbaPJx13ZwdVRvdjEmv43cK3Ir8yzfnpgc
 PQxU1nMiCwF9LbPOtETuhSmIG27oydSnVpQJXQne/lKecTrctyqS2CSQ3IM5pisA
 +/jSPrrY/5exQwo0iumOWaD6lgNrCljlTp0a+4OkitSvSasEth0pksUoBQOnv33D
 FFH3wL5T7YcWBCqBzdA+vflgA3aM+AQCAwjbOs4DkAmLXu32ddgBw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4jg36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666GnhX8013180;
 Mon, 6 Jul 2026 16:54:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvxkkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666GsmxO47907172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 16:54:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D638920043;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 961CF20040;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.23.52])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/3] accel/tcg: Make PageFlagsNodes' start and last
 immutable
Date: Mon,  6 Jul 2026 18:51:23 +0200
Message-ID: <20260706165445.57418-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706165445.57418-1-iii@linux.ibm.com>
References: <20260706165445.57418-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kkw16akFLjuNlnvnfq8pfP7Z0PXzAmfM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXw7/BmRsgu82D
 sO/IGNt1CpK4ccCp/Vujoi5XbibTQWs72qpwanzLrcb8fQuVRSkkzh4B4dJuWqtVzHiUYTN4itZ
 xHR3asV96Etkqc8oBjAw/F3zN9Riell3xuabtd146vYt4/IwMGAsNNmUBHFvs5rwHwYWHdFvhfZ
 Wr/Pd3+WO4JpGK/6C0H4Pg0aQX7PuK9/5vqIcaqUWI9bfVpfm6zxvzSnAuB5bPotlONJzp/F414
 jnu3e4jw7gxkm0TQb4ieu76CLjCP9fpJTy9jHsc4LvLyvawJ53NOKzSXAVIQhJmFUiDDgc5YOmp
 dFownQs/f5Hx3rv0bXcN/5irApJWNABAPhefCPE4Zq7Dw0ONZ2at2x3bG1eEer7mTDsXRU8Cl7z
 ZYc73Phnkkgz/g0cpLmwu77vtG8VB0aFhJEN9JJmzQe+oWmvAG47IghBEY44y7KInb4+VeKcGzF
 RcEm+iOzSewFJAJmo1g==
X-Proofpoint-ORIG-GUID: kkw16akFLjuNlnvnfq8pfP7Z0PXzAmfM
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bdddc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=aeXNbhhOpW3SYJoWk14A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX0taBdZoZPMKo
 Kh34l7XJH/Ja5L1Mnd+nfWg0+kbZn8tI9AwIE2e1e/knelED//MC/GN6TsdiOAS1JynYZSYxcoQ
 nDQKesAlBZT8hYjc2D4PoIZcuBx137w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

page_check_range() may race with pageflags_set_clear() as follows:

    T1                                     T2
    -------------------------------------  --------------------------------
                                           p = pageflags_find(start, last);
    interval_tree_remove(&p->itree, ...);
    p->itree.start = last + 1;
                                           if (start < p->itree.start) {
                                               ret = false;
    interval_tree_insert(&p->itree, ...);

leading to errors like

    fail indirect write 0x72f0a659aff0 (Bad address)

in vma-pthread test. I am able to reliably reproduce this on a machine
with 32 SMT threads as follows in about 25 seconds:

    jobs=32; \
    seq "$jobs" | \
        time -p parallel \
            --jobs="$jobs" \
            --halt=now,done=1 \
            --ungroup \
            '
                _={};
                while ./qemu-s390x tests/tcg/s390x-linux-user/vma-pthread; do
                    printf .;
                done
            '

Also wasmtime project reported a similar failure pattern in their CI [1]
with a similar reproducer [2].

There are other races like this. In general, region bounds mutating
underneath the reader are very hard to reason about. So fix this by
preventing mutations and creating copies instead. Use RCU guards in
readers to avoid uses-after-frees.

Now, when the reader finds a node, it may fearlessly access its fields
and be certain that at some point in time the respective region had the
respective bounds and permissions. The downside is slightly more
expensive mprotect(), but complexity reduction is worth it.

Lockless field accesses should probably be wrapped in qatomic_read(),
but this is a pre-existing issue, so do not change it here.

[1] https://github.com/bytecodealliance/wasmtime/issues/10000
[2] https://gist.github.com/alexcrichton/f14f23a892ffb9df2522754572d51b1c

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7704e4017dd..55761cacf65 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -239,13 +239,16 @@ void page_dump(FILE *f)
 
 int page_get_flags(vaddr address)
 {
-    PageFlagsNode *p = pageflags_find(address, address);
+    PageFlagsNode *p;
+
+    RCU_READ_LOCK_GUARD();
 
     /*
      * See util/interval-tree.c re lockless lookups: no false positives but
      * there are false negatives.  If we find nothing, retry with the mmap
      * lock acquired.
      */
+    p = pageflags_find(address, address);
     if (p) {
         return p->flags;
     }
@@ -301,15 +304,15 @@ static void pageflags_create_merge(vaddr start, vaddr last, int flags)
 
     if (prev) {
         if (next) {
-            prev->itree.last = next->itree.last;
+            pageflags_create(prev->itree.start, next->itree.last, flags);
             g_free_rcu(next, rcu);
         } else {
-            prev->itree.last = last;
+            pageflags_create(prev->itree.start, last, flags);
         }
-        interval_tree_insert(&prev->itree, &pageflags_root);
+        g_free_rcu(prev, rcu);
     } else if (next) {
-        next->itree.start = start;
-        interval_tree_insert(&next->itree, &pageflags_root);
+        pageflags_create(start, next->itree.last, flags);
+        g_free_rcu(next, rcu);
     } else {
         pageflags_create(start, last, flags);
     }
@@ -371,8 +374,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     if (set_flags != merge_flags) {
         if (p_start < start) {
             interval_tree_remove(&p->itree, &pageflags_root);
-            p->itree.last = start - 1;
-            interval_tree_insert(&p->itree, &pageflags_root);
+            pageflags_create(p_start, start - 1, p_flags);
+            g_free_rcu(p, rcu);
 
             if (last < p_last) {
                 if (merge_flags & PAGE_VALID) {
@@ -394,11 +397,11 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
             }
             if (last < p_last) {
                 interval_tree_remove(&p->itree, &pageflags_root);
-                p->itree.start = last + 1;
-                interval_tree_insert(&p->itree, &pageflags_root);
+                pageflags_create(last + 1, p_last, p_flags);
                 if (merge_flags & PAGE_VALID) {
                     pageflags_create(start, last, merge_flags);
                 }
+                g_free_rcu(p, rcu);
             } else {
                 if (merge_flags & PAGE_VALID) {
                     p->flags = merge_flags;
@@ -419,8 +422,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     if (set_flags == p_flags) {
         if (start < p_start) {
             interval_tree_remove(&p->itree, &pageflags_root);
-            p->itree.start = start;
-            interval_tree_insert(&p->itree, &pageflags_root);
+            pageflags_create(start, p_last, p_flags);
+            g_free_rcu(p, rcu);
         }
         if (p_last < last) {
             start = p_last + 1;
@@ -432,8 +435,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     /* Maybe split out head and/or tail ranges with the original flags. */
     interval_tree_remove(&p->itree, &pageflags_root);
     if (p_start < start) {
-        p->itree.last = start - 1;
-        interval_tree_insert(&p->itree, &pageflags_root);
+        pageflags_create(p_start, start - 1, p_flags);
+        g_free_rcu(p, rcu);
 
         if (p_last < last) {
             goto restart;
@@ -442,8 +445,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
             pageflags_create(last + 1, p_last, p_flags);
         }
     } else if (last < p_last) {
-        p->itree.start = last + 1;
-        interval_tree_insert(&p->itree, &pageflags_root);
+        pageflags_create(last + 1, p_last, p_flags);
+        g_free_rcu(p, rcu);
     } else {
         g_free_rcu(p, rcu);
         goto restart;
@@ -505,6 +508,8 @@ bool page_check_range(vaddr start, vaddr len, int flags)
         return false; /* wrap around */
     }
 
+    RCU_READ_LOCK_GUARD();
+
     locked = have_mmap_lock();
     while (true) {
         PageFlagsNode *p = pageflags_find(start, last);
-- 
2.54.0


