Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DF1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtS1-0002Re-DQ; Tue, 28 Oct 2025 19:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRv-0002Ll-Dx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:59 -0400
Received: from p-east1-cluster6-host12-snip4-1.eps.apple.com ([57.103.90.242]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR9-0004qY-5b
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:59 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 2EECD18034CC; Tue, 28 Oct 2025 23:49:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NOUCweN0BwDWHptjKrVueVuLmTbPgqxKBFU13NRtxRY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MDDPaQX17aV3HRYTDTH8E4FoXvcVl4EcTw2Cc1pB68OyArEfFei3mQqXj9rtmNto1DI62+MQce9ovSRaAdJnUJcmr29DcBXOEUF4YvaJyFxj1bbG6OAOEL+jnNu3BRNtmYU8fTAiQV5JqcxGc/KPykTtYKC88RTpN2mWto17d+U/sCWskpeXJ9F/t85uDgSW56iriHo6SrqYAawFa/Ns1EA33+fpmJsDWqPwoT9S2UY73Q4g7UBqHJ4AZXQkKLuMiJ3Il+mz1px6rGfWlXoDMaDC29q1Dbrio+nJgGGjiKl6YGhvKGLog9l2vv7FKmdRhaCfgRmPDa1/9hi4+ol/sw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 46FC318034DA; Tue, 28 Oct 2025 23:49:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 27/27] whpx: arm64: check for physical address width after
 WHPX availability
Date: Wed, 29 Oct 2025 00:47:57 +0100
Message-ID: <20251028234757.39609-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q180pRIWLh2vrRiXFFtitRwYoTnDSBkl
X-Proofpoint-GUID: q180pRIWLh2vrRiXFFtitRwYoTnDSBkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX2KM4z4Wk+ote
 n7S516Q8zlau66WwP0dBwmLJV/p+1NXhFBcrQxOjMOIeXhUVEhOSSTF24GBg7Y591lAq6Xim84U
 LKtA+kM9FrbXkQtUWQdDOd9MHD679w0AoSZEw54SBgiFTh5R9M6OPlLyY0rgJbk4yu3YkERXNkX
 IFZwmgbefN/KyTC/WiCBn06KuWnqoFXUkT4rDDHmai/moafdIxTy6L5BMSIuaFNvGKWQUlOxtKz
 hit0/bsBm9rc3Swf14iD6zF0P2CWP6wS79YW6MdyjcFfl+8SSdAZsPYsqOQWaRRa25uWH7IBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=917 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABkTyMLHnih2WDsD9g2Xmak0m5J9ZdM6LTu4SvojoZSkg9miz2DpQ3ahICiQ2XIehw8xaJIG2pCwbFHXZcVNyt7BmIMhAcdkNXaWMAVH0lKask/X4sZY26zcrvk+bYcE1g1NUzncCmq6hJYi21LiYncuYlvAsDEuDoH+Ipf5/qT6A6z17VhcHVFxssUi2sJU+RQZMx3D9EU4at3KHIsHSPyAoSY5fDE2GxWnaCDmhRovsXulpGjMf35WALgrZ9JKxWPkZqlt67ztvhnlXHkGf/XGd7lOl47Cpsm+OyGLIP1SpXQIAgFjjuhD6dgZw1egC2pMSZxMyZDMoocYUxvWxL06A7vdg5jmTpdgXTyqZAM8u+vB2S2wVopcQelQ14omGfiMg9fC2F4Z14rkcMVsX9R9sK3n7XEBVpuAAz+uXP7WB2FCQaNAg0WGAONJQXcuKY2b51n9cykj6l7eNwnVz9314KF0eNABUKvXTEDmBYNHTqh5rwS4yu2AGAqp8CcZv2fuBL/r4ioi+NRTJNhuNKDG/7aibzC9S5cnP3nEE4J+OXZ+mtPnSDMMqfzEjWrbdNOTBzUlDPof/gkJJEsGcyOjatcC/gOn6hmWedmnkUDn4hBDr6w4jtLF4REPKbccKuvUiLT63IiUSUZ+6nC+S15BUkKyULPXcmTbJyAgXm38DKfn0RaS5Xtwvttou68VzFRiwaXUUJxSfXNgH+H3IxLD4K9qKFXVJG5n5GOeHS3mM6F/eOn4ptF+YE
Received-SPF: pass client-ip=57.103.90.242;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 4d58e5e939..ce1794952c 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -678,7 +678,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
         WHvCapabilityCodePhysicalAddressWidth, &whpx_cap,
         sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr)) {
-        error_report("WHPX: failed to get supported"
+        error_report("WHPX: failed to get supported "
              "physical address width, hr=%08lx", hr);
     }
 
@@ -909,14 +909,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            return -EINVAL;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -943,6 +935,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
     hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


