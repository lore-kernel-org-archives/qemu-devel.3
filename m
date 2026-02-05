Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D74AECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1Ev-0004Gp-KC; Thu, 05 Feb 2026 10:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Em-00045A-Mg
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:49 -0500
Received: from p-west2-cluster2-host6-snip4-10.eps.apple.com ([57.103.68.243]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Ei-0001xb-Mh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:43 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 CC133180076D; Thu,  5 Feb 2026 15:25:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305139; x=1772897139;
 bh=c9xkU5JKUppgK3M6NvIGvHRbHv9MZvro5B1lYG+DJ2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=clBMVJTiXYJmPvRRopm10x/CGex9EJuI/SE7qUyw7XWCCt0+ybYuIK2I6bFz9rf9y3qr8pS4XO8w93lNtJGY8Nz2HJOTgWwiLQr8IWejgtHkUJ1PtlCgmN1gyiGoNWGuQcBDciSb569hAw7DQgnkbCgor10lDrU1KtggCZwzdNnd/PY+hskXgQYPqKmitz6d/48L+PyATksQc2H/KGQHnci/mz/peCA31zEBfw2wOuhCou1VI/bsVqup253PO/i/qVX0XYmcTCiRUXcmrEgOuqNzhZhpnPheRqFkmP+xbF0yr8Zthze4xCXXiNzsNalSVNSZII+AXD61tTpHNWInZQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 3D8ED180018C; Thu,  5 Feb 2026 15:25:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 12/22] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu,  5 Feb 2026 16:24:15 +0100
Message-ID: <20260205152432.78208-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=6984b673
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4JESfsFHUK0Za1XDgooSILq_JIl7M-KA
X-Proofpoint-GUID: 4JESfsFHUK0Za1XDgooSILq_JIl7M-KA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX5jXA4uxlfIjG
 4pDnSWH+AdyDJwv15zr7K7DyDYfQQ0stpyijq1I/iQla8Vk9BHtdS7YboY4/Q9HGToBBMWP38Ol
 BrY2rg5iSNZFDBsQXkxVz2Lp6s+K+Lse44mvxqEwP2/hF09BbdgxQiRpTxU7hgZbyXellODdsIh
 128xbd/cA1JvtquS1aBDof4YFW1ER408sCWzwVhK8FZi/gir5z7wT1NRH+BLN9m2+AFzftvqLR4
 1mnlpJUEo/cVXL0g2Z0gwDobXK7+LPFsd9QD16DnUqxN5PfevqPzYb+N2kC/m37tQ2m08qxSRTx
 7SDomldwoqq6atlhdlGKv//9TOE1OWTU+aGDB1LwC471057jdtCe0S59K44PYs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1030 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABstmH7B+SU31Ddn8PLvUG8a5AB0rad0AabcKol4ImpC2ZOde2K5bDBgpelMTj8Znixf7C2yuEmpoP1v3t6GKylJFPI9YsHHpKa8IlYf17WlyOIRtI0EzxEziQscusmA+980/Isd2r9DtZBgzDQ6Oa/vjpCoXAf9WFj0muOZr2W930qXicPDyrFCIpd+l+OGrTV1VDd3Wz8vPZi6fCqCEH/71t4/2DG3kESEcw2A/vAjxF2bUy3opQ5xTbsMWNhm+Mh4OqyczINSMHOtxbPoGVNJUUByFPPJZVvYrxbHmRfKyaNo7awOnpRTI3LoC2N/VgU9/1o/owt1CLq5gAclxk0yvouplSQgnf7WeoN0vdWVHNnGyyN9qsV2YocFRNZ3ZNpSz1hjLgUT3ja6jfkS4TxkeK8UuZwTRwIY2jia0BsiGH2SswBZ29awZeFMDbXLOfsMKaYoW3bn8P/zVNQDtK3ubt3z75HsjhaVcxfVYFIUS18V78375nHycYRYr7dYBEsaCYcrj4kG85yUSO+7OrXEpUZ/ldZD+B2o+WoXp/X1N13diJY2uMh1GhHKE2HN1caW9t9bmvV6bmsbABJ9/7DFT93Wn0QK38TIx1faydTN5oSL78VJb75rqvW+ddC/6xk6QB8iWO3AWepGjtb134rq+RrwPbcUudFe/+i6s7A63z1D9WthKgAxtqV44FccP4Eo8AFIbLm/Rg1w6ZSkrgQOehi/+JJtDuzdeulvRp8ga2eWgE3C1II9BImTjnKN9LzXFvs+NJYoFaDu1ZpBcxkgv1+v1bwD58K5HekwZtMr07RtcjyhDkb95bUy4M/R+go6RLApt2a7qlNQZ1MCZFVmDVo0F2HOSP65k/TgWnFZtgZUuI2GoDxtTYJoWESBYvOPBk9ST5ZJxkEoA/0Ls21MTsuss8x7hTuz+T3wq+FqitiAb1AONKxqRUYLxG7xG660fL6OT5Cu5yCA==
Received-SPF: pass client-ip=57.103.68.243;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


