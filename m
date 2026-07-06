Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE694C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgh77-0006FH-KW; Mon, 06 Jul 2026 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wgh73-0006Eg-Bv; Mon, 06 Jul 2026 07:03:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wgh71-0001Mz-BF; Mon, 06 Jul 2026 07:03:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669ILml3151332; Mon, 6 Jul 2026 11:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5o5XWdgPq9rHSafYv
 Pw5xydqCTMb2BI5zpTiZWNKpss=; b=cc0aYpuegrCHexBRlwXausTuNnutnDtJ7
 peiu4tMR6JgdBoYX5xd5O02hkDFKCuU36t6s9/rfDHBI5yGwnVD0l63D8RQdNFZn
 ze4dAtdPtjUY7KRUFTBqxbwwrmzUlAa9hMRnhbbrkbW1o+skAUs+4obiBfC1QMG6
 pRsDKR0BE3EVD8/H4V0KGlH01324me1F4xp6ei3atGAdxbuSAzLVFvpZ8Hgp5ofz
 6LSQa121xALZ+y0O3hYhBVgNF4LQJgGap10fdxqUfniFTJ5V9Qj6s2N/AxX2wQJN
 vzzMeN+fvJuDKhftyyQ4JOAERZZlmywenaCvUPjNCs09P0w1z8UGA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdhpa1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 11:03:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666AncbU002940;
 Mon, 6 Jul 2026 11:03:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfw1jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 11:03:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666B3YsV50397498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 11:03:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D0EB2004F;
 Mon,  6 Jul 2026 11:03:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2484420040;
 Mon,  6 Jul 2026 11:03:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.23.52])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 11:03:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alex Crichton <alex@alexcrichton.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/1] accel/tcg: Retry page_check_range() on itree.start
 inconsistency
Date: Mon,  6 Jul 2026 12:57:25 +0200
Message-ID: <20260706110330.4150026-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706110330.4150026-1-iii@linux.ibm.com>
References: <20260706110330.4150026-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b8b8b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=vjliLWF1AAAA:8 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=EA-HjLQVFIEyDo_wN94A:9 a=3erKlr7R_9HjozMBkBTY:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwOSBTYWx0ZWRfX6U1bF4nvmn6Y
 diTthcFmJUILUuCXVRN/xPGx57xZ5Ey7p8ezFCvtJKwrT3l6y4ORiCo0RFazSztegiQ4hPvNbIZ
 emjxORTsrENxzyWtDdEda8TRBI4UfbLBwuirE+z9gbcNbzndaSiH0HSiJQhJoD8xnL24EJ2xdtQ
 PrsRPhC21Yz95uuPXhuFINDdfsYrYjT9zwMv8BR8L+sEwNtYyBHZFWY8xnedegKypqvQ9AVJCAn
 LMk3izNsJB56z4X6oPZ9BQj8gnDupn2+0i7XA+86kmUdSoUUPYU0ENqIgrygknJZLvcFU31ITfP
 +ZIgNZUthA0rjij1NvMY9Bkq3XpoYXQgtjxxmIAKkElhCY/o5tNUv3y7mkd49tvkLlh3Sujix+d
 El3ZJGKneooyCcz59NuxmsAYCKOT/Xk7effR5WW46eG3dBMwD3nT7vw8XEgHm0HmjnHr8E+XhVX
 DfjNf2L3dYZwNar/p7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwOSBTYWx0ZWRfX0iLKMA/JaXgk
 2PpsRlxVOyt1tCEh+CZHihLSsaeTFwhYQrtPMFaEwInTmlDyxtO/0rFGsdinsYrmStVONnvuEVL
 EU44rrV72NiH47jtWiZyIMBx++/HeD4=
X-Proofpoint-GUID: S9Jx6w5OtwCy8RCS28Ac_A8aLPjRprTD
X-Proofpoint-ORIG-GUID: S9Jx6w5OtwCy8RCS28Ac_A8aLPjRprTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Fix by retrying under a lock. This makes the failure rate go down to
roughly once in 50 seconds.

[1] https://github.com/bytecodealliance/wasmtime/issues/10000
[2] https://gist.github.com/alexcrichton/f14f23a892ffb9df2522754572d51b1c

Reported-by: Alex Crichton <alex@alexcrichton.com>
Reported-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Fixes: 67ff2186b0a4 ("accel/tcg: Use interval tree for user-only page tracking")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7704e4017dd..b70955697fe 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -510,24 +510,23 @@ bool page_check_range(vaddr start, vaddr len, int flags)
         PageFlagsNode *p = pageflags_find(start, last);
         int missing;
 
-        if (!p) {
-            if (!locked) {
-                /*
-                 * Lockless lookups have false negatives.
-                 * Retry with the lock held.
-                 */
-                mmap_lock();
-                locked = -1;
-                p = pageflags_find(start, last);
-            }
-            if (!p) {
-                ret = false; /* entire region invalid */
+        /*
+         * Lockless lookups race with pageflags_set_clear() and may have false
+         * negatives:
+         * - The node pageflags_find() was looking for could have been
+         *   temporarily removed and not added back yet.
+         * - pageflags_find() could have found a node which was subsequently
+         *   removed and whose itree.start has been adjusted.
+         */
+        if (!p || start < p->itree.start) {
+            if (locked) {
+                ret = false;
                 break;
             }
-        }
-        if (start < p->itree.start) {
-            ret = false; /* initial bytes invalid */
-            break;
+            /* Retry with the lock held. */
+            mmap_lock();
+            locked = -1;
+            continue;
         }
 
         missing = flags & ~p->flags;
-- 
2.54.0


