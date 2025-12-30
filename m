Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3E9E94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNIM-00020N-9u; Mon, 29 Dec 2025 19:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFc-0007dJ-RR
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:18 -0500
Received: from p-east2-cluster2-host4-snip4-1.eps.apple.com ([57.103.78.114]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFW-00044m-Eg
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:10 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 9E4B218010DD; Tue, 30 Dec 2025 00:06:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+MsdZaXBCYAcv52ZMhpRqZhO9PBpFu3UYyQ8HifZlzo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M15zqNQXqfGtNAuoOgV3/UVtuwKy5FV9kiXetV3gjH3dzWZl3HvcGkzx0e3JtmiNxCzWzGT+rjJftFBrXqlTs2vsmbsVVFwNzsRoGrTpf+wbygGCjvxjIrxOU2T4j3rtP30EsHyES9TPeevFQgDHm2gYcYzFf6+/iUz172mILukgxS+SdkxosyBLs0bjBjf+8LPyXmDx9tBLhFtmwg+ydEpiCmyCGuWX1gLWF6jDencBFSxjJ+044iofNszi7EQkvx6nEyY7wZFlvPDF5w/oru10Z8dICyRyjTuW14Gaxan67B/cjgEOOmnIuM75N0Kaao5H9CWABdRXdjqKTzgyFA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 518C418010C3; Tue, 30 Dec 2025 00:05:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 22/28] target/arm: whpx: instantiate GIC early
Date: Tue, 30 Dec 2025 01:03:54 +0100
Message-ID: <20251230000401.72124-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ic1pj_-3NS7-XbO85S11Mb3Z9WmFkN1J
X-Proofpoint-ORIG-GUID: ic1pj_-3NS7-XbO85S11Mb3Z9WmFkN1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfXx/mIAEv+WB2+
 9BWtlinZtlT9b4aCJ4q1Irir5hhyI58K8BYA5k4t2Y+lXpsEnFbji7HMfSQ2x4tDCzkKkPslke0
 ckCqufmEU/2FAUCBmABbKdoKOJXHxtd9rj3KpG2ydE6L/mjFZ9umIiX+lMNgUWk9jMUG4NXq8Uc
 NflhMEIstmTXhsWuf3JANB/U3IJSamD+lQUA1qkOcBangEfS/VQxUJwzMVLTw7JESt93JTYf/R4
 +fqu1kOKKpsgB0oakEk3ej7ljt1CSnDDOIjZBLUGmjMiPcpoKnE3TnoeyCXT3V2DVZT0i7knrba
 syTyZApQ6Vmy3QaeY9n
X-Authority-Info: v=2.4 cv=SYz6t/Ru c=1 sm=1 tr=0 ts=6953176b cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=731 adultscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290222
X-JNJ: AAAAAAABt8zchQicPg8swT8o3lt0r7xSk8VIKLVxABu8jp4+Ob8U6puJmrFy4l0tcXYJjS0ucFEFEWuIer+S2EDJk9nyI5SaI5134jhQlRVkGQnn/9kDRf4zcKBXwL2z9qq2PzWX8YmALEvY+NHMzRIE1HI9TR5BK2jqJOL0iGc2VnQ2OV2Q4FyBfg5PwNrhO8DHMtODdcpAuAfwnYQ3zofDyxY6GS0Yf/cbV5FmzeKqHRB0aU1ySZJCSNiVMJTl8dTEUaQ3GCMBrrn+31FbPbspmG/pHkyhkxf0AwbqK9g4DLuVm+1ZuMmEgnWD3L8qcjVfjmHio4QIDg9ADI4YJxKydaEnTG9yJbIaArAB3BFcgN7phFzVsi/nnPKrumAMdw+bHk+P/sdFjWlyV9ojDPTXldIccSJ8XqH0p3ogozIrx/dFzM+qu0kaMCayuIBG2DgLC/wMpf1j3O1Ei6XPabOpRdzX8ohBwV3vvmZpwXX959HwIRIqZr2R4d1x7/MuCItQ31WKMsZRRc8lP7zkKwUkBSJcPNr0MMwcbD1VX9lJzxOCGGZ20S4/uWumpy/zNM7n/DVgcUYpbWZZyuiAketRTrMm6g8s7aipZdMXC1m+IgtvdC2qArGpYdDzULmcCAleOCtLxuDFwOYc8SojRozgDn2fhhYAj7F9UYjwr9GszpHu1kmEgsiQLDWu4fLo+kc7nwWS/IyMQpW/y8IMCNnrhSS4x3YICB+zJxzjRieAhDAKq5nAP45gkFB7K+3OG6VPFFxIYrFVaRGG9BHZqS/u+66ELP3rEIUcaQMvg61KE1/XCnj1L8ag40Q2irEpRi4UYKu5dXxolD4d/Oky1WbyoZsL6f7DslDF428xzw/ATWVDN4Da4QXzE7Yqja5BcV2RuWlbr4ij7XVKUYrACDh72dOgA+EtzjrRfVXMWBrTXyUk+zRq1KW9FtPAQg==
Received-SPF: pass client-ip=57.103.78.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 07bb6fae5d..eea20f5e5e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -973,6 +973,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
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


