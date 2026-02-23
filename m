Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8428EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXp-0007bv-RJ; Mon, 23 Feb 2026 18:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXm-0007Ov-Dw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:50 -0500
Received: from qs-2003i-snip4-2.eps.apple.com ([57.103.86.85]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXk-0004Td-1r
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:49 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 3194E1800171; Mon, 23 Feb 2026 23:40:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890047; x=1774482047;
 bh=hfNR82VI32cF33QTS3FopfW+BPdUa6X/9gAEMrrkmf4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cVGvAHL/5tlKAZxj1qZEmNfKlIPuCbAXUzkVwbEY+KFUBbFnAl23PIyXn5Tewj2tfSp0iTui5zIqToMEOpoGRTjqrdKh80+4/sf5hDkiZdrCKvNK/LGlVSRqpDptjFNitIqVjbMjt/G5yU4HFbiflWTAAMGsLGus5SB9EUK/IAl6xjYHnaHL6BC41kS0WkeswWc7XXA5LuIBzb7AziqfBkFYydIPKs/P1UrV/+V8tTIiNFr0xxeocdt7JUbcxHQk5gr8aAyA003TP3U3yzor711vHuUoQ13XI3TzHNpN0kkUykbHE3+cqpkZp1qvn5ulKRXvv4LLohN+q5kcZL1yqA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 DED451800168; Mon, 23 Feb 2026 23:40:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 25/28] whpx: i386: inject exceptions
Date: Tue, 24 Feb 2026 00:39:47 +0100
Message-ID: <20260223233950.96076-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=NszcssdJ c=1 sm=1 tr=0 ts=699ce57d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=41a--giXCHF2Chj7mBYA:9
X-Proofpoint-GUID: nNES_yIzQVcEctk2-nUZ--CZaQ7uLMQx
X-Proofpoint-ORIG-GUID: nNES_yIzQVcEctk2-nUZ--CZaQ7uLMQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX/ReEPGUAWwF4
 i3fUxyehWmz6PQEpyh9mcPFfJ1lSwblCyARHMVeik7LJLcW9S4KCGK4PtHsg4STIcslnOO+VY/u
 iIeV/iHppEHHYPvUz7Oxxa3l49DkV8QNjPrCG+gEaZ2eBcYHTjmFGAxzcFS/dmwQ0nsKTvk9m/1
 24tEV/AouxoAPLECMaKXqM3D0bZfVSpB1ABS80ZwyZ/KTpfxo64KSZoebN9srx9f6Cy54HV/INN
 3PUQjsYbj0vcUcIovXTmXDfWm46TOe0jpCoTkypxoMJk+/Oq5PLla7Ax1MQKHzpCfXk2sYePmtD
 I9OLK3HD/IcmlUZykhsPZ/642jXcDClb1ikkeN82zVfZDK8jeMSSiIFd4WTIzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0 clxscore=1030 phishscore=0 lowpriorityscore=0
 mlxlogscore=994 spamscore=0 adultscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABvRRhNHzOYfSa1IiCyDPKcnmEZiUAc6ar+eGLiRYIHyybiII2L0LGlm5kWmiCPhSWz9BfeJRCVEjKAMO9t8K1Js39bkOaw38pFAEAZnuuIctUu80tjoe68rNt1xC5nD4+i5yK5OTZUL3u/xukTpdlxFM2Sh2biWdaMHGSoV/F0Vr0UM/DOR2U7LgKImnSK3s0C6BjDYrzEC9sA4ikAAJh+fhwt+qYSZXC+1uTi/shAx+PYz3fwK4TmG5TOXrtMDKtmuZxnqiDfg3DKYRFTAJSge5D9zXjRtKG5qLQRmROLvHTqOpbqS5SkEBvH5qcZ/gYpvvZHx57bEHFO6HPrC+fnwvQlogwDRORbdDx1+PvLaIWtS36pQeqNkSdXFesHP9+4Aya3+7cCx02CGu5pO9PG0j3Fe1tcV3/2vYCy9F9iKWzpJ8a4BgQlJs4dvV/Se8ys6DegAVRB+KcpdPirPK4BXvqG/wN0OnOrrJ1DTRtbaKQPs8QBt5RoOQvkFKD2O2owuGh6lmLTpQtZvRcLnh5TnpWEAuJeoeqQWWOxpPBDTnV7OBtFMg1U4o9AZXubV7pfljIvOyjZwe1I/AMyNWgulBLtE6pJ8ZZ+ROknJDTvzpRHig9MPY9IOCKqKFrFbn8j3ZyQvhbROnd7LQuC1GkgCse8VZu8ESPUi0yTCHG/0hK6vUDGSSBiRuhMJb3RFP17lMpiar1rsGaehptVXB2kmoV8Vx0f02mrDlBCm5tcOemFeIOwj9KAcpWEp8+S6zRaIGcWlHPKROQ2TvTUA==
Received-SPF: pass client-ip=57.103.86.85;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 561a48206c..0259782a82 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1506,6 +1506,26 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 }
 
+static void whpx_inject_exceptions(CPUState* cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (env->exception_injected) {
+        env->exception_injected = 0;
+        WHV_REGISTER_VALUE reg = {};
+        reg.ExceptionEvent.EventPending = 1;
+        reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+        reg.ExceptionEvent.DeliverErrorCode = 1;
+        reg.ExceptionEvent.Vector = env->exception_nr;
+        reg.ExceptionEvent.ErrorCode = env->error_code;
+        if (env->exception_nr == EXCP0E_PAGE) {
+            reg.ExceptionEvent.ExceptionParameter = env->cr[2];
+        }
+        whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+    }
+}
+
 int whpx_vcpu_run(CPUState *cpu)
 {
     HRESULT hr;
@@ -1600,6 +1620,8 @@ int whpx_vcpu_run(CPUState *cpu)
             whpx_vcpu_configure_single_stepping(cpu, true, NULL);
         }
 
+        whpx_inject_exceptions(cpu);
+
         hr = whp_dispatch.WHvRunVirtualProcessor(
             whpx->partition, cpu->cpu_index,
             &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
-- 
2.50.1 (Apple Git-155)


