Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BD606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=kfTWd8ZN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDS6-0005nl-JK; Sun, 08 Nov 2026 19:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRv-0005jg-Q7
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:27 -0500
Received: from ci-2003a-snip6-11.eps.apple.com ([2a01:b747:3005:200::d]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRr-0006Mj-SN
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:26 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 4880D18007C0; Mon, 09 Nov 2026 00:41:18 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-98c2-78dd-bf35-50d57d0f7a7d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXAdGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184878; x=1825720878;
 bh=VU83oDCgFHA/p3V3FO5ZcurDhJlE6enRQJTLmsz1zhw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=kfTWd8ZNH22CGgtrqLyn4JrNBiHgNOvw/s9Hu4wRR3GI2gkzbTuBV/N4TdF5pXklIGTxOEWiMvLe9IbD/z8AKi8JtUqJd0wKu6K0x9CPGn9M6slWUBweeqWqcSnGCnaM8zzV6Agl6L696kLLIUiR5IS+MF8f+O5rFrqoKgqbtn+zQx/zw84c5QCq3sFkoB2x+jFUFK3v/+/Py3NatfVWd0hk6GL1vW2yq3PTyXd8o25UyBGy5CRAMvBr4qpewYd1DPDxLiQLZivUSVz2cmQ5H7mOujbwdiW5szqEaMKHs/ZvltYaKcomn7XDo35xgiTXOfRj/ioDBJbH/ugiOp6zOA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 9802018007C2; Mon, 09 Nov 2026 00:41:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 09/13] target/arm/whpx: handle processor reset
Date: Sun,  8 Nov 2026 17:41:04 -0700
Message-ID: <20261109004108.85808-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QvaVmyHLKX6Pv1JfY4KDN-DQynxhsNXV
X-Authority-Info-Out: v=2.4 cv=LbwxKzfi c=1 sm=1 tr=0 ts=6af116ae
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=loPyruWHUH_f1C729x8A:9
X-Proofpoint-GUID: QvaVmyHLKX6Pv1JfY4KDN-DQynxhsNXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfXyyGtcXS0wBiL
 oNTPgpCHj58tSmDkxla2BqCEB783wOnQcfzWaOIPoubnFh9NK3yfyvYOxhDnCed17OfYTOfxBuG
 BX6bHnNChuiHynRvz01LMQpS/O7SUL+tIzXNVA1qv4qfrZsQMwKyoeTRd3Zd+ipmCcEAbzY48uR
 4b8yjJy8JySPNapLwQBiDG+vO2TiaW9sv16GKKvQZlCE376wsDFvUXaBYFzmFHNhaIK6e2coR5o
 jmJPUFqK0rPNlz/mmMijK9hsmb7QS/TlHNkceUPJo/eRWadrOO+s1WfiYji5aQ7ale3ll44zPQ1
 J9X0h+Dy9ubq5hvjlH2OasglkL6vbOb1a7dUEA77ZNK1TXVqtXUnW0zXKKz6ao=
X-JNJ: AAAAAAABLWmhJ6rvd+F/aDCZcicJwh3haNuE0tUu6d9Mup1sGQ7XJqIri9govgaoZubpOE
 5iv/1sY8DK47Xjbt/a/d8rMmeXVH4FGb8xjAyz6Wij3yY7Df9SwIR6bVkqhWy9ZE/3hVh/
 DhlfH2KgvyvkLYIwNOSKHb/67wsOH7+HiK62iddfVA+WPltDTOTNec0C6e5qXj2Saxn4Vs
 b76mAC0R1XIqHLm8YMu7XJ43xG/XhXjblUYF5iOluROt2Zj9CF5Un70M6mdoSCpniDOYho
 ylRdXZcUpLqE6aIMsURXXZauoLjTNe4fIwFTvwfXqYfNTAOHBu9o1VA/JIJiXcwEbfSSjG
 e/YkbkEA1QLbSzjaQCmO0NJHg1J9cZ6/d27R4TNg1mFNV6q91T4TQLWeosvlPfJxAGOTht
 Vr3kXf4mVSdXmEphkcU+M0BWolKhJaC1AqH3kYmUVNMUrdhN3auNWqNpjvTvAd7338FBdo
 TR27rYyEdECG+12BE/mbSExoIpsI9xFmMD0PRG1Y9HeZ1r+BJKoRlUHay9GGBgz0L6J9xq
 ouchzmiJAKpUlYXAsXbsTeOdeKbPEZhOfl8vzCWl0/xEF2yPZCcarQB++9bv+MdvMtd66K
 IFPRy/3VmkxDwPcepu9jddLAE0EN/QzVeWqlmwSuoE7KCZJW4VqPYv58GJZgkzAxvCjss/
 xWJ+bLSaNt0TEKXgQuo4y3e0JbXjIJpyJ7xmjjNX02GjKi2WJuyUqFiBQ9NBMBaQo9F9lC
 it9SJil09c0MxH1Wab6P8Ex+cgdm+xLLZoAVE=
Received-SPF: pass client-ip=2a01:b747:3005:200::d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move WHvResetPartition to where it's effective on multi-core configurations.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index ded42c980b..b702dfa8e6 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -471,8 +471,6 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
-            /* Partition-wide reset, to reset state for reboots to succeed. */
-            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
@@ -573,6 +571,14 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
+    if (level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
+        hr = whp_dispatch.WHvResetPartition(whpx->partition);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to reset partition, hr=%08lx", hr);
+        }
+    }
+
     for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
         val.Reg64 = *(uint64_t *)((char *)env + whpx_reg_match[i].offset);
         whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
-- 
2.54.0 (Apple Git-157)


