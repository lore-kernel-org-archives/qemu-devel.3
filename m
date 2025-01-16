Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D29C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYXTi-0002Vs-IK; Thu, 16 Jan 2025 16:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYXTa-0002VJ-UX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:32:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYXTW-0004sf-LE
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:32:29 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GHuIJY021162;
 Thu, 16 Jan 2025 21:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zKoqoi1bAqdiCNmDp
 38xSazsbzL/KCEiDUtGPwFUcVw=; b=YmOxosnq/labP3wI5hlarjrUJ2EDVANA8
 NbBVgMgRaDfT7rYz/QlaK/5wMy5+rkoiyOE35vRabSPyV7lc//bJSNX96GmDym2d
 0lsNbqFR6wk5VUweoUoEjOIymZAXInBRLNr+GU619yoSUaLOu2IDrSzqWJI68I6C
 RiIEHtrEd+ijoMr+1HWyo6XSdSQ0uHhfCbO/hej7ymWTj7Cf01fzThlPp+pEPU3r
 84r7OoscVTDBSXjcMwaVLaA/fdAeq1aVbFcOHNMOTZJw9KVnwcJQBaPQXrSnXKqV
 743uxRncfARuTdlFRdQdzDpuon4Jo4MHNEe5ILvmmqudneVaJY8vw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa3bt22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 21:32:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GKbcFo002693;
 Thu, 16 Jan 2025 21:32:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byg0cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 21:32:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GLWJ1G41222420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 21:32:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91D7920043;
 Thu, 16 Jan 2025 21:32:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33B2320040;
 Thu, 16 Jan 2025 21:32:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.62.46])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 21:32:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 2/2] accel/tcg: Call tcg_tb_insert() for one-insn TBs
Date: Thu, 16 Jan 2025 22:31:33 +0100
Message-ID: <20250116213214.5695-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116213214.5695-1-iii@linux.ibm.com>
References: <20250116213214.5695-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZxdIxz8YZHWelRvUUXpdt_bmJyEwLz6F
X-Proofpoint-ORIG-GUID: ZxdIxz8YZHWelRvUUXpdt_bmJyEwLz6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=764 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Currently one-insn TBs created from I/O memory are not added to
region_trees. Therefore, when they generate exceptions, they are not
handled by cpu_restore_state_from_tb().

For x86 this is not a problem, because x86_restore_state_to_opc() only
restores pc and cc, which already have the correct values if the first
TB instruction causes an exception. However, on several other
architectures, restore_state_to_opc() is not stricly limited to state
restoration and affects some exception-related registers, where guests
can notice incorrect values, for example:

- arm's exception.syndrome;
- hppa's unwind_breg;
- riscv's excp_uw2;
- s390x's int_pgm_ilen.

Fix by always calling tcg_tb_insert(). This may increase the size of
region_trees, but tcg_region_reset_all() clears it once code_gen_buffer
fills up, so it will not grow uncontrollably.

Do not call tb_link_page(), which would add such TBs to the QHT, to
prevent tb_lookup() from finding them. These TBs are single-use, since
subsequent reads from I/O memory may return different values; they are
not removed from code_gen_buffer only in order to keep things simple.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/translate-all.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 453eb20ec95..7ec1c53f240 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -531,23 +531,32 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         tb_reset_jump(tb, 1);
     }
 
+    /*
+     * Insert TB into the corresponding region tree before publishing it
+     * through QHT. Otherwise rewinding happened in the TB might fail to
+     * lookup itself using host PC.
+     */
+    tcg_tb_insert(tb);
+
     /*
      * If the TB is not associated with a physical RAM page then it must be
-     * a temporary one-insn TB, and we have nothing left to do. Return early
-     * before attempting to link to other TBs or add to the lookup table.
+     * a temporary one-insn TB.
+     *
+     * Such TBs must be added to region trees in order to make sure that
+     * restore_state_to_opc() - which on some architectures is not limited to
+     * rewinding, but also affects exception handling! - is called when such a
+     * TB causes an exception.
+     *
+     * At the same time, temporary one-insn TBs must be executed at most once,
+     * because subsequent reads from, e.g., I/O memory may return different
+     * values. So return early before attempting to link to other TBs or add
+     * to the QHT.
      */
     if (tb_page_addr0(tb) == -1) {
         assert_no_pages_locked();
         return tb;
     }
 
-    /*
-     * Insert TB into the corresponding region tree before publishing it
-     * through QHT. Otherwise rewinding happened in the TB might fail to
-     * lookup itself using host PC.
-     */
-    tcg_tb_insert(tb);
-
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
      * TB visible in a consistent state.
-- 
2.47.1


