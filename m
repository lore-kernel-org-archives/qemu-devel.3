Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F44C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 18:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRxfz-0002cn-VL; Wed, 18 Jun 2025 14:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uRxfy-0002bk-FI
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 14:38:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uRxfn-00048L-Pr
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 14:38:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IF0Zem008391;
 Wed, 18 Jun 2025 18:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pfV9xdcLyeIY2wvFFqGHM4uLO1Hufp6WBz2LkdkmM
 zc=; b=UmnNSclyMixtwGKCluVXKshgJJ4Zjx8GdcynLsvUDBbLaIqhmSJDhjJZa
 F5xjTL9k49wy1DL6WrkZ/7wpY+c/e0TiHBlUwpQtAId45bTCR/ZbGyvTJM4NgxL4
 529mz2WUiBsyb/etgQjoZvNpwErPaL7w/IT5kGA/ZPoM/PgjQ+Cjn5NGnpzOAoWv
 IPfLN/TF/cKGPD6jPM2OtcqeaM0Ka+1CTxAhnXKbfGIlB0oIVsWZlcxlmrdo8vE4
 abXhgBDOGlea5sMz1z4ZPAYFBts70AMwiEFhkhutSSdT6w/dwot888vbmbLwpd8B
 GBuRVnjLg/JbvGODOCEkUFpimrYLA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygngenh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 18:38:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55IFxqmr000752;
 Wed, 18 Jun 2025 18:38:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdpa9sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 18:38:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55IIc2XN19071460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Jun 2025 18:38:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2EE020043;
 Wed, 18 Jun 2025 18:38:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD30920040;
 Wed, 18 Jun 2025 18:38:01 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.53.145])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Jun 2025 18:38:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] tcg: Remove NULL arithmetic in tcg_malloc()
Date: Wed, 18 Jun 2025 20:37:35 +0200
Message-ID: <20250618183759.9197-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE1NiBTYWx0ZWRfX/mAmMGM4TSG1
 cKZj/RJFI7VCgtUvBDkIeT0bFxJxEdXZvHFSuZSmiMqrk8u4t95RvPCBI9+GWLQp4jx/snG+bfK
 gLgJ8eOjSsh7t1qfyrPSAuBh+2It+2E07/pG9Gt+CDl7dNbIFM9WStZMPY1XTSUQBng9PB7AsRS
 6JRiwfCKXKA0+3+sjSiAnXUvpNOvec+lYuOODZ56jnrDn/5NakPiUlX9NY8SlaipEcv5iXURIkt
 Lf3UnL12ub+FXChWikgOx0h96sYZQpuU2gHa/sX/DantYGjvHU1YNtAhUW+ZDEfl9m5BPOMfaTS
 wb3tutHJGpYqBxNylMyqw5kxhNlN+IXjbPj5ENhzaTfOosxQuqs+CcjEgBgpodSR6tepuKxUIr9
 2cREwkOu5QzAcVG4y+7eANga7lgJCH2V8SG1K5/5L0EnWGTmyhtQnQFRY2XDWUuBYTViixfa
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6853078e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=w8pzoHujezk9OHy1q1AA:9
X-Proofpoint-ORIG-GUID: GW2yovYye4OcUQrynxRbuPoKfvskcyCL
X-Proofpoint-GUID: GW2yovYye4OcUQrynxRbuPoKfvskcyCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=764 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Clang 20.1.6 (Fedora 20.1.6-1.fc42)'s UBSAN complains:

    qemu/include/tcg/tcg.h:715:19: runtime error: applying non-zero offset 64 to null pointer

The code uses NULL as pool's initial start and end, with the intention
that `pool_cur + size > pool_end` should trigger the allocation.
Unfortunately C prohibits adding non-zero to NULL, even if the result
is not dereferenced.

Fix by using a dummy pool and change the allocation check to
`pool_end - pool_cur < size`. Both are required, because creating
pointers larger than one past the end of an array is prohibited,
as well as subtracting NULL from NULL.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/qemu-devel/20250618103555.2020-1-iii@linux.ibm.com/
v1 -> v2: Also change the allocation check.

 include/tcg/tcg.h | 9 ++++-----
 tcg/tcg.c         | 3 ++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 125323f153a..4190e8bdbc9 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -706,17 +706,16 @@ size_t tcg_nb_tbs(void);
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
-    uint8_t *ptr, *ptr_end;
 
     /* ??? This is a weak placeholder for minimum malloc alignment.  */
     size = QEMU_ALIGN_UP(size, 8);
 
-    ptr = s->pool_cur;
-    ptr_end = ptr + size;
-    if (unlikely(ptr_end > s->pool_end)) {
+    if (unlikely(s->pool_end - s->pool_cur < size)) {
         return tcg_malloc_internal(tcg_ctx, size);
     } else {
-        s->pool_cur = ptr_end;
+        uint8_t *ptr = s->pool_cur;
+
+        s->pool_cur += size;
         return ptr;
     }
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d714ae2889c..afcc7ec8849 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1358,13 +1358,14 @@ void *tcg_malloc_internal(TCGContext *s, int size)
 
 void tcg_pool_reset(TCGContext *s)
 {
+    static uint8_t dummy_pool;
     TCGPool *p, *t;
     for (p = s->pool_first_large; p; p = t) {
         t = p->next;
         g_free(p);
     }
     s->pool_first_large = NULL;
-    s->pool_cur = s->pool_end = NULL;
+    s->pool_cur = s->pool_end = &dummy_pool;
     s->pool_current = NULL;
 }
 
-- 
2.49.0


