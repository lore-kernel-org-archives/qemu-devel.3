Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4925D58E6B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwxAP-0008E4-6H; Mon, 02 Mar 2026 01:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9S-00083L-Eo; Mon, 02 Mar 2026 01:53:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9P-00027G-Bb; Mon, 02 Mar 2026 01:53:09 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621Bj2Jv888437; Mon, 2 Mar 2026 06:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=04qlyX
 wLUehgeLgWiY9+JrckLY/vDoAz7Zmb+LcwV+U=; b=CcMb0c15O7Z0CtYNOdCwzX
 LN4so2pPbLZhjjlxSAc2Zj/+6JBcB3wAQ+gI5WsESdT0fcrhNw02ATxSOps+tOIV
 WiTBKmgr9VsYLB6vHnMRhsfE2gQV+37zKQ74nSFbeB/o7PE7RPVYpMvm/kka52G9
 +ESm/wwBYd1MdT+QKTCyFzUbk/zC3+Dh/BMnSB6lm5ISGytS7Z6JDlGO+4TGVvFE
 DDspvjuMQOo0HpTq3NtFVbbkhVIMRsdabKjF3Lc9Rc3rHMAJ8WBadSCjbSacNpCh
 3kprglPeTrrbFSe4YPUhWVY9CnNfQdSVWhQvESqhsXlT1OZxMhzBxxL9fX/9iEsQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcn99q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:53:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6224MvoH029748;
 Mon, 2 Mar 2026 06:53:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaprvu97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:53:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226r1Mo50135436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 06:53:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83EE320078;
 Mon,  2 Mar 2026 06:53:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 500A520077;
 Mon,  2 Mar 2026 06:53:00 +0000 (GMT)
Received: from Mac.com (unknown [9.124.211.120])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Mar 2026 06:53:00 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/4] target/ppc/translate: Fix TCG debug assert translating
 CLRBWIBC
Date: Mon,  2 Mar 2026 12:22:14 +0530
Message-ID: <20260302065230.56220-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302065230.56220-1-harshpb@linux.ibm.com>
References: <20260302065230.56220-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nGidpWxOVA2mf0dBJL4Ul5C5-f5899Mf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1NiBTYWx0ZWRfXyGzbf8uHSbXJ
 eFQVLMuGMTyNkAXKwP8LQ6SkQ4I5LxuC076zeEqDDfi2yNKvkG2tGtK1i0xIlOsXmNjvdVEw5z9
 bZ5+Sm38+53E0i1tdavERGQRVWBeWvnZHfNHAkb+CqKF/f8L5KPGktcTUloxicnLBtmrsmrtMDA
 zgjDu2hYe17/RoBcRGWo97OLItWZApxvYu5NBkGGEtpwFo8eBqL0VUAUYB383QbBsampbS5Obhy
 viE93dVGbxoFyXXsyNJyh6dvsvcDdwxp75UtQzLig0PrDVdjvgphO9tEiQW4jwIbGvZQcyCnYI7
 VveU1qfWg4JvlkoxSvduxpuEv3ZQM5NwUWL211PJwIOSOCuwfaXkaTmm/kk6JQghiLCoE3YWNhj
 S/oesTwifX/DimiZ2CiGIEoeyEXMqUNpHJRDC/HgXn+jYrJQpgMkjMwCayFA3cnCunTNHTQH2m/
 rHlnYUwJqzHIQ4ko7QA==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a533d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=71Y4eyVMNZ21z9qsmbUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: nGidpWxOVA2mf0dBJL4Ul5C5-f5899Mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The test case in the ppe42 functional test triggers a TCG debug
assertion, which causes the test to fail in an --enable-debug
build or when the sanitizers are enabled:

#6  0x00007ffff4a3b517 in __assert_fail
    (assertion=0x5555562e7589 "!temp_readonly(ots)", file=0x5555562e5b23 "../../tcg/tcg.c", line=4928, function=0x5555562e8900 <__PRETTY_FUNCTION__.23> "tcg_reg_alloc_mov") at ./assert/assert.c:105
#7  0x0000555555cc2189 in tcg_reg_alloc_mov (s=0x7fff60000b70, op=0x7fff600126f8) at ../../tcg/tcg.c:4928
#8  0x0000555555cc74e0 in tcg_gen_code (s=0x7fff60000b70, tb=0x7fffa802f540, pc_start=4294446080) at ../../tcg/tcg.c:6667
#9  0x0000555555d02abe in setjmp_gen_code
    (env=0x555556cbe610, tb=0x7fffa802f540, pc=4294446080, host_pc=0x7fffeea00c00, max_insns=0x7fffee9f9d74, ti=0x7fffee9f9d90)
    at ../../accel/tcg/translate-all.c:257
#10 0x0000555555d02d75 in tb_gen_code (cpu=0x555556cba590, s=...) at ../../accel/tcg/translate-all.c:325
#11 0x0000555555cf5922 in cpu_exec_loop (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:970
#12 0x0000555555cf5aae in cpu_exec_setjmp (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:1016
#13 0x0000555555cf5b4b in cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/cpu-exec.c:1042
#14 0x0000555555d1e7ab in tcg_cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/tcg-accel-ops.c:82
#15 0x0000555555d1ff97 in rr_cpu_thread_fn (arg=0x555556cba590) at ../../accel/tcg/tcg-accel-ops-rr.c:285
#16 0x00005555561586c9 in qemu_thread_start (args=0x555556ee3c90) at ../../util/qemu-thread-posix.c:393
#17 0x00007ffff4a9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
#18 0x00007ffff4b29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

This can be reproduced "by hand":

 ./build/clang/qemu-system-ppc -display none -vga none \
    -machine ppe42_machine -serial stdio \
    -device loader,file=$HOME/.cache/qemu/download/03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8 \
    -device loader,addr=0xfff80040,cpu-num=0

(assuming you have the image file from the functional test
in your local cache).

This happens for this input:

IN:
0xfff80c00:  07436004  .byte    0x07, 0x43, 0x60, 0x04

which generates (among other things):

 not_i32 $0x80000,$0x80000

which the TCG optimization pass turns into:

 mov_i32 $0x80000,$0xfff7ffff             dead: 1  pref=0xffff

and where we then assert because we tried to write to a constant.

This happens for the CLRBWIBC instruction which ends up in
do_mask_branch() with rb_is_gpr false and invert true.  In this case
we will generate code that sets mask to a tcg_constant_tl() but then
uses it as the LHS in tcg_gen_not_tl().

Fix the assertion by doing the invert in the translate time C code
for the "mask is constant" case.

Cc: qemu-stable@nongnu.org
Fixes: f7ec91c23906 ("target/ppc: Add IBM PPE42 special instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260212150753.1749448-1-peter.maydell@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/translate/ppe-impl.c.inc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
index 0a0590344e..1c27facb89 100644
--- a/target/ppc/translate/ppe-impl.c.inc
+++ b/target/ppc/translate/ppe-impl.c.inc
@@ -424,11 +424,15 @@ static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
         shift = tcg_temp_new();
         tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
         tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
+        if (invert) {
+            tcg_gen_not_tl(mask, mask);
+        }
     } else {
-        mask = tcg_constant_tl(PPC_BIT32(a->rb));
-    }
-    if (invert) {
-        tcg_gen_not_tl(mask, mask);
+        target_ulong mask_const = PPC_BIT32(a->rb);
+        if (invert) {
+            mask_const = ~mask_const;
+        }
+        mask = tcg_constant_tl(mask_const);
     }
 
     /* apply mask to ra */
-- 
2.52.0


