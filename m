Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F212606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=NomFIuK9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gw-0002nS-CL; Thu, 22 Oct 2026 19:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gt-0002mA-GW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:23 -0400
Received: from mr-2003e-snip6-5.eps.apple.com ([2a01:b747:3000:202::2e]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gr-00028q-Oq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:23 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 67AE2180011A; Thu, 22 Oct 2026 23:59:18 +0000 (UTC)
X-ICL-RepId: 01a1660e-094e-7338-9ff0-369166ecb072
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAZbHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713560; x=1824249560;
 bh=Cv0uGdAdTyBVyxmHOQprx/PeKa6pk7/GKJjhXwUfb1k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NomFIuK92nmxK+iGwdaoZ5YmE5dQpov2tlEo32sweqB5fb9lLGIktNDXJzcUkfkz/xDUn/xUy0jY19XhTsXvHTdgg4wwyQkVm6aYtksuD8nNm2P4GoSkXoOgXaQqayKS9Pbf6tFfqJVmq+iyxEbxf/hs6aVc8mtwVkAwmOkmO88YD9zgjK1DetoZbMN7M9fTsOBVBJdoEkornkg9yRh0iD0GVnS1HdfNrYdLcccJGE+tICh63a/U8fk7h8d3FADCGhPLuNKkfEK0w/RD53ljoirO7RocOkKT6HqFSijkA208+/TOzNCZ+tNPONgvy1aHhFcpfNolpeNEei8HPL9nVA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 7B557180024B; Thu, 22 Oct 2026 23:59:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PATCH 09/11] target/i386/whpx: handle processor reset
Date: Fri, 23 Oct 2026 01:58:57 +0200
Message-ID: <20261022235859.88753-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AJhZ9O9ZxTy302jlGe7JEooJiIKspg3U
X-Authority-Info-Out: v=2.4 cv=d/X4CBjE c=1 sm=1 tr=0 ts=6adaa356
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=eqzMyDhjfWJDk1Qr7fMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX/gMKhvrC1OW8
 X1KrC9gHfZEh2oy/ApEE9OgXyzldJTol0anckq+LBZq3SURZWjt/rU3YIQqiGeLHnWzzl6MhtFD
 oVhYC5T1+aiPFe4zcpNvvfYBIHvuW5v1D3AhwK0NVsBCP2tNTxAVXipTMda6myNkmN3rk0PxqcV
 hylRyvDIHY8UY8KWnIVv1HVbJ4kwfJn4h4McS3JXCHhs/zvvS3J7zJ7LybXRFL/AOQ65RBUQkm6
 CZz28/NB4IPwVncwZ8xiQOWgmlDgMIDQczJdSvzoFaUq5/ZI92R2KD5AWz+gGUGNQ/lSyq78Tme
 C1V2PgZUovjG+UZefhxfkzYvd0GfezLp9wk1SFPMmTG3cqTijhP2i22zeelHVk=
X-Proofpoint-ORIG-GUID: AJhZ9O9ZxTy302jlGe7JEooJiIKspg3U
X-JNJ: AAAAAAAB2IfVGWNPP1MUNU+xTZxEnCjpshTaxnqWYbYcz9q2wSX6SWF+xVcDqrvyKTRNvWByf689/b0dBbW5aBEC+008I9d7x2WPhFTBahETxwrgS87m5gCj+gSyLMzm/kHVrGksILGqFA9xCbYBrG2gzIVyvERYLhILw4IUpsC4q+ujbbLRKBwLmRJrreiggQt6QZ0yZStfvdEetQjl9agmU6s/Vx9dh9mATFvw0JpFwpwZs+2razp95ie/2X8aBGJ7HhrD3m98bcNIbJNI8uYwkaBXenq19mLVtliOUhTGhOxL0CvNiigNNhDqROBKeCsLT3MayMsc7lZ1aCBsjyk4BnJstg92a2ZFhaPzLI5ZkEwpHGJaTfxpPgcP4KKC9I9AuWjaoUi/XeUxfeWMUMWa6wPpi3oiBgb8Wowciu6antO+TGiKEAiC/dIvRUsn/VTsHSgg+D+6eAHchDfEFM9QVdeKEFXb2ClEZ/o7tMPz4dh5LJxmD7gUUKXQ4RWVmo22lki2kmhGiPsBoGoXB3j+z0ImAKOIIf/mMq4AOxr0sA13iPfH/uQa7PJi+R8oLFC3hjXwmZFc+Mb1LZvaVrf49FV+7Rsbnulb9TjnbFTdqvoGjdayAhR8MOjMc5T4lSGmf4CY3+EH2t0h+2yXRnOnMoGUe6RTBAj1IbBBvlSxD+m6urzbiNcrZJKDPdcy8bwAkGCnYaY/fDE0YmqWN+qLwuC+TR1u7FDaI0qBD/wcuYpoAe9V5rVvUdwqwhyIoWAsLGduSp5x4cPG+YNOofDYydusZ1nj9liH6/7bkt7ruJQc
Received-SPF: pass client-ip=2a01:b747:3000:202::2e;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>

WHPX is not properly handling processor reset:

- Does not reset partition, so several registers (e.g. Hypercall,
  GuestOsId) carry values forward as "Locked" into the next session.
- Does not clear hypervisor-managed TSC deadline (live-lock).
- Does not re-arm the wait-for-SIPI trigger, so all CPUs start running
  immediately after reset.

Some firmware may tolerate this, but OVMF does not. Typical result is
that boot hangs or ends in triple-fault, e.g.

  qemu-system-x86_64: WHPX: Unexpected VP exit code 4

After this patch, I am able to boot to Windows desktop, reset, and boot
back to Windows desktop. Tried many times in sequence with no problems.
Used several different reset mechanisms (OS shutdown menu, external
"reset", watchdog reset) with no problems.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2402
Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 478a890c9e..de4d444368 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -541,6 +541,35 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
+    if (level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
+        hr = whp_dispatch.WHvResetPartition(whpx->partition);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to reset partition, hr=%08lx", hr);
+        }
+    }
+
+    /* Reset hypervisor-owned TSC deadline. */
+    if (level == WHPX_LEVEL_RESET_STATE) {
+        WHV_REGISTER_VALUE tsc_deadline = {};
+
+        whpx_set_reg(cpu, WHvX64RegisterTscDeadline, tsc_deadline);
+    }
+
+    /*
+     * Re-arm partition's wait-for-SIPI state.
+     * whpx_vcpu_run() ignores cpu->halted, depends on SIPI for this.
+     * This must follow WHvResetPartition.
+     */
+    if (level == WHPX_LEVEL_RESET_STATE && whpx_irqchip_in_kernel()) {
+        WHV_REGISTER_VALUE activity = {};
+
+        whpx_get_reg(cpu, WHvRegisterInternalActivityState, &activity);
+        activity.InternalActivity.StartupSuspend = !cpu_is_bsp(x86_cpu);
+        activity.InternalActivity.HaltSuspend = 0;
+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, activity);
+    }
+
     /*
      * Following MSRs have side effects on the guest or are too heavy for
      * runtime. Limit them to full state update.
-- 
2.54.0 (Apple Git-157)


