Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C61CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBN-0006vR-Sa; Sat, 20 Sep 2025 10:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBH-0006rb-SZ
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:15 -0400
Received: from p-east3-cluster2-host10-snip4-10.eps.apple.com ([57.103.87.231]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBE-00088q-EP
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:15 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 4096E181728B; Sat, 20 Sep 2025 14:02:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XY0aRLNzrnTUVd3ei9jMIMiM8ijXecVFkp2kgf3sj3c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OHWza0wWHPN30Qtil7dIADzp4dI4xpGPyVb2b1Y+MLtWLZ5B/HJP75CVBMhQPOGy62SbXSpsNrsfaSZqfn7E6/vRJ+/voXe8LbDImLm78dB53AvxTTVlmYSRvkRCAcfROu+blo0L0xKyyO+FlzATC/9ijcOliRCL3NoJFaIZR8a1tI83tdC2tfmCJwaG52zlUwHxC2yRcpUohbQY/03DwIKYS5AgcqoG71HbQIKW8Sd/QzVVGAa+scbJRfsgjk0nvilu2HZPdwlQTx0Wy9hS9fxen97tlzJAk1NV2gH+WETRLUHmWEFYiU+Zo7PhvAnznQfbWUgH3Rk6DUJDn5KAdw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 D2F561817259; Sat, 20 Sep 2025 14:02:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 18/23] target/arm: whpx: instantiate GIC early
Date: Sat, 20 Sep 2025 16:01:19 +0200
Message-ID: <20250920140124.63046-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfXxQE5hbPt32T1
 9DYVTZC+XyB5R6ztg0GaHbir5PTenhacAIcoRR+jU9Fb2+C4fwdusDinhjoMper1kEGZ8B7zC58
 Yj0ZeP2ha2UF7Lveg1zsuAgoo12bVVL5GjjPn7KQNb6rwIKBluu9lWAV56GfMBGZ/QJl1v3LSG9
 GiL0ILaBHbIN5U8wF6ypsr6Kkqyyxcv9FhqQ98a63Tpf5iN63jOAlnA9ETjRiJHWVKBSgxuvy4P
 zX9xOUtTl96uWnxJRQMmfmq0LIaUHCBopURn+1Bz4M6HGarg8lwiU7tRcIr9zXhYCCNiNFR5k=
X-Proofpoint-GUID: glISlhaAf-JTEsHPh9NP4d3NmfnhD0Ya
X-Proofpoint-ORIG-GUID: glISlhaAf-JTEsHPh9NP4d3NmfnhD0Ya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=685
 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABfoo6CgdnrX60Q7q/eqA+O7e+kWLHOL1YXUA1abD6Ku6DluC3vq9rxUhQ0AKD8IuWb4jZE6W0WFdtNJvIl+ZX2vgaHHbS3B7won4eoaixv/k/rwjpbn8q+M/cF4cBFBwoQV1mPcEIrSskS+xu7cS4Gr+KiQNCtY2vmDAw8nPvy5CeTpwpDnjEEmT0C5e7NO+yYxTjq7MYWCxE2hdKzLjYT42ooUVDfDFor1oHGY4fNezZ+5lNWfH4egSNx2gQjLNPlrg5SRrR2Opsm77610pWJBDUYOQsiYBnRWd2xlstua5VALB8kRMSidcOwNMUgG/qwqhL0GV0ZtBt40m4an9XpBHVGLxbVZGi3TTd8bKOGhcs7I0JtDHpTGPnTxLZLGidQGBgI1xnxqYF7xOIkqcxzpqoq2TBx+kjD9Myk62+ExdeC13fVYaUzqC5mrwJA59WPAXsUtM3pvn8o/izscyILFYttOhAkBcLUDfzV0QhqPdjmnEYahw/NmB5FIKOZqI6VV7XAKTt/CtSi4s39pH+dWTgX6Xsu9aVcRJy0WVg+jKEZ5BGqVjNhEpq+qJi0oknCXt3f7Yth2Kr1GonOn/3N9U0JZAevh81LMP5ZdcNaFSMJPnhDdvpJluUn9UyOhAoNIFfUqtj56SWkyGnTf9iu0ug8aVeG3TPx+brtne18LmYrdbjEEuqHgtJ6blpt4dXfz5SlK31NkuFzqod2zQ79kfBhgZPbUKujI6hDlH6X5ktGAgbi2xSOLcOMiptmH4E+7Wm4H5E4vJ4s75NOroMRhsrKWNFvaH+5yoC8U33mUZ+hvt2DkPqv+hYmX6repSXH5R/sWOfQ2u6hDKCa6mdKkwAmW0JgLabUhrfNorJkSgIutf2jDtB
Received-SPF: pass client-ip=57.103.87.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 680954f4b5..12d397f35e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -976,6 +976,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
 
+    WHV_ARM64_IC_PARAMETERS ic_params = {
+        .EmulationMode = WHvArm64IcEmulationModeGicV3,
+        .GicV3Parameters = {
+            .GicdBaseAddress = 0x08000000,
+            .GitsTranslaterBaseAddress = 0x08080000,
+            .GicLpiIntIdBits = 0,
+            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
+            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
+        }
+    };
+    prop.Arm64IcParameters = ic_params;
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeArm64IcParameters,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


