Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BC8CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RJB-0001ee-UB; Thu, 16 Oct 2025 12:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RJ5-0001X1-4W
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:28 -0400
Received: from p-east2-cluster1-host11-snip4-5.eps.apple.com ([57.103.76.48]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIS-0001gI-WF
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:14 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 31CF318004AF; Thu, 16 Oct 2025 16:57:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XY0aRLNzrnTUVd3ei9jMIMiM8ijXecVFkp2kgf3sj3c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=G5fbOyvHJVvgmn47PEMp7WVDlwecLoNfGzreo6Ra1tG5G9dXBpnH+HBzlIIoE2Q3h4mlwGsBzbCs+TJ28RVpf/wtI1FxhP6nWXJehu897bNb8rQPJfVEFZm/aILvM47OQWa9XGV1dBoHZhj1vHEmsrDPj/wzcNu9E4uEkjZh5WJt6GhgwV0kz3wtut+BdvMpulXBO4fW2cj+qn/Ew96tJtb8mnboZiUyJpo3RaEbXNa+Jl9JKFpQz9I8QLk2GjkWpQiHlOHVhxwKZkw4k92+bxjAJbYeXgN/Lh2KCs367PvXaBEfBTrETXLJEt+8y0LIbfeq5vqbRzey+m5WqssPsg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 4E7CC18015F9; Thu, 16 Oct 2025 16:56:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 20/24] target/arm: whpx: instantiate GIC early
Date: Thu, 16 Oct 2025 18:55:16 +0200
Message-ID: <20251016165520.62532-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX5RPg22SuOdaV
 ZtTU4QVzU7686asx7bCXjsWGnA7izvNqLIwCdj/7CqqAxyL7JE/2PatujnSg5x5YMQBNLmddTzf
 54acd03G9sAO6QwtiYwOR9GBwBN3vHaOZzJdefLudxb9q4ISDOXv4pTVvAbZWSVZh4enlOEewOl
 l3ooDrDSb+RPU06eAkd/JeHEvFGQoth1+YTpdKa7qb/C1X6ulBgilRLxsbzq+Iu4atTFG4yO0Jc
 Utr/y6SQr+iLLmX9JymHamL2+4b11WRnsl1vNwc8MAtsgKDZEEpC3JRaqdTFSC42YLXt1Wj7A=
X-Proofpoint-GUID: lPwsSiVTqUh4yKtd54TOrkzbe0fpD3CF
X-Proofpoint-ORIG-GUID: lPwsSiVTqUh4yKtd54TOrkzbe0fpD3CF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=700
 clxscore=1030 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160123
X-JNJ: AAAAAAABRqlvR0HOYZmVSAMe64xMp24ydQMh0BLfmwizl1Z6qWJPTXy29Ke4PBngEdTirCepez5QG64/oUzy3Up3ADBkfnYlOWIZwadRqErq76oeLLIXYjKCCH4OXqgGH2Ve5QLQuwUCBtRro6Gxji6lEdiDFjxM19uNyrro7K8AgTvYIjSB18dIJhqRcSbohJIsKf3jZDsDsdSPr6Qo4NMwxSbsusL3B8rlEbia8dqWBoiURngsrBrLfbe6QCmMbP7mWboKRiMwJ+LqwkDDSTAMqgSJWbeFpOfqjxY6Vt8tUg1781WPVLgwSZkxrYGdkugkeAbKLUE25cfLXI7Rooizu7Pcl2pgHuYmP9S0R5vN2y1tmUG92gZbVSEX3JcQpUzltRDX/BBqB8TyvaxFN5w96FXuC6ddtHHYdbDKCXo+zmpAQYkjrfbqJnM6wjFc3Y+ChUsBQA6tTYp/xQDtRrfCDbhVFUsUxi4YZgLL29GoAa0Pt2dAWJe1krh0XqPnmc1bdhBUHvjd4hjuNCO0lagp6GjKgj6432zRJOUqV/kaQGeCAQyHwrJBvGlkccIw/l/5jr5xL6ZzVAciJPdu+XJoO+afX5VvtkHx/CSxgl9pP3nK2LCKyJtUawjWGaCSy8H22FqT59vb4RNvwNAii8sIVqEmWeBenlWqVxBVO1bbBhvy5aCehHqxMlDmnLbVrnaQXEPZi4OwaFYH15P1kvQr/BDpoiyiC7uloHUJPOF9DzQn5QxEBI/Zi1oVkjADUxCtiJmVTmZ/q1xT/nV99IMvWiTQNzYcPr2iyXWOGjSxss2a1LcgrwnKQLfUIXMIXe2+b39jFlrByb07NRDNNxCYPuo/4J2WPVgATItp9K+TaeRwjyIcdC8RrKGxDS+o/KXMhQdiB/KP3AsxxtUDs2Y=
Received-SPF: pass client-ip=57.103.76.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


