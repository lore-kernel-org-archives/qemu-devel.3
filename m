Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AC6C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4K8-0007Xw-4f; Wed, 12 Aug 2026 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K6-0007XR-S0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:30 -0400
Received: from pv-2003l-snip6-10.eps.apple.com ([2a01:b747:3003:205::78]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K5-00052y-Av
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:30 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 83A4D180096A; Wed, 12 Aug 2026 08:28:25 +0000 (UTC)
X-ICL-RepId: 019ff516-45e3-755e-a964-dd6a1574f0bd
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQAJGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523308; x=1789115308;
 bh=UmbgY7zx2YTbIb9NF7G0shV9RsqD0iTOLo1LbE0fZvU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q2HgJeLwI+OF/gdjCnV4avjPVyXDLxG96vreArkta2bKOqvw4siNEfvKLpgmrzpQ696jgFnoraZXorrBRiibcs4peD67daLCu0R3IInkdMUvrDCBJHeG/KhoTQ2LxsCvZxoGKwyNk0AdyF2/JgXiSPYgx/ZIuSrJaoeEw7yNgiV1u1vnCMLj0/6m4ll4n+ilwr22lFcDxC8xMjFQXwQUG+sBR9kw4DZ5nh6mByUKG9wqBDgpCm39uUOn9LSepR5ctAHdL7Xx6w32DMs2AN1GcLsVrx6UiQgZ32fDhZ+XWU4v6/HKvkTLWBgBErDCcKf4Oj3srsKTKgUlheV6SI/NDg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 989621800950; Wed, 12 Aug 2026 08:28:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/6] whpx: i386: synchronise PAT too
Date: Wed, 12 Aug 2026 10:28:12 +0200
Message-ID: <20260812082814.27217-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JTnvClEPrnBC1RQLsnUEqwn0rnt6Rj20
X-Authority-Info-Out: v=2.4 cv=VtYuwu2n c=1 sm=1 tr=0 ts=6a7c2eaa
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=pUpLrfO9kievb6knzj0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX5/V52c2xYpJk
 SD9rKIz6K4pDX9qzOdBpeu++rz7gZ0QxLwKhjB2NKDv0s+uloDCZay9Brwi53RHvDbvDxrDOiEL
 qWUJTNEfZKFM/TQDEbllQyt+js974gRbfOE8ZQTpGhTxiIHfrVNuXgCvHp3y/TJspYP7M3Ti2SW
 +jXVuHvyVY91Ohm7DAmdWDpocIGA2ahhWKN7KlB6F/2RedlP7snXWa6n4erPOFavVRP43LF/iGn
 YlJePawCP06Sv0G9r5w8VLH7U/A5hpu0NFu523+3FBDXqtWuT0wS9hijj4+bMpEPeCqEs1mBqiQ
 OH4UOXkR26nkZlunYDURjgqjKcg66a/HmLWP6HqRF0B90tdTPR1lO1dG4zoTgw=
X-Proofpoint-ORIG-GUID: JTnvClEPrnBC1RQLsnUEqwn0rnt6Rj20
X-JNJ: AAAAAAABkhA89YGtKz2+Sp1TAcqiAByNvZHdp5hgPhKOmX8kkMmLzXxzN2oRbwb2Nzn26DizaLj0ANh1pS+ABsOuDmvwvMzEmGmWf6PRmbEs6gF4qxbfzWCRd2NRsDdO89IkNgX9fGysYRA9IawF+S7vPbhjecvccoiCWJnPn8r3d+MQDplRDQ1xBbEgo1xHMQi17dXbUroTRwAvjQ4x2qPSR/cZwjjDiQpROqqbz5pRJVgBm/k11Ietr7BcQCcYv4xizu6PiK+JzPFYTjenvMgISOCIXolBqaaxyu257504vQ/6nJWjqlQNDmSuk0V+dJV2v+U6GOeDuqL7IuSFb1F0nliRKLcWf79DUKgIqHi0ZVapqPuG9jWpZywMsb8qrgxk7nGHnOKcrlV5zd143/fhj2QxXWiabibHqt3PLgsAge1ExXeVscZKA1QWywznTWnVIaFP1TpOVGPmuvYoBH+feUygG28FIkQSNcLeGO1NMOyYaZfkxrnNo/ETfp6GiW+nOYgQTlonRhnB67oP7u9qbUQs9hcrNP+Un+dOw4HhRp+Z2+36wlMHesmkW3icZu7tLePc6qA69+2/6UWUNa4dRU1JVi+FNIkVj0hO95j6rlDPEv2zvAag1SEsJU4DiVkdFXazdueiu9qDkz6sSvp1369VX61Ic8uXio0UUZ9IoY+tOeT+wkJI1WO/ImqB53HknbcpEz6doh2Mpurg7T/xsDIc+45iC508LaRJd0hb
Received-SPF: pass client-ip=2a01:b747:3003:205::78;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

https://github.com/cmspam/winq-emu hints that
this might be wanted for some use-cases and
it's a step towards full state sync.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 1800ba8eb1..2739a80da3 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -115,7 +115,7 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
 #endif
-    /* WHvX64RegisterPat, */
+    WHvX64RegisterPat,
     WHvX64RegisterSysenterCs,
     WHvX64RegisterSysenterEip,
     WHvX64RegisterSysenterEsp,
@@ -624,9 +624,8 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
         vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
-
-        /* WHvX64RegisterPat - Skipped */
-
+        assert(whpx_register_names[idx] == WHvX64RegisterPat);
+        vcxt.values[idx++].Reg64 = env->pat;
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
         vcxt.values[idx++].Reg64 = env->sysenter_cs;
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
@@ -962,9 +961,8 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
     env->kernelgsbase = vcxt.values[idx++].Reg64;
 #endif
-
-    /* WHvX64RegisterPat - Skipped */
-
+    assert(whpx_register_names[idx] == WHvX64RegisterPat);
+    env->pat = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
     env->sysenter_cs = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
-- 
2.54.0 (Apple Git-156)


