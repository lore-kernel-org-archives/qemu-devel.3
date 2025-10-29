Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A81CCCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6F-0004GB-Ja; Wed, 29 Oct 2025 13:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5q-0003np-BI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:22 -0400
Received: from p-east2-cluster4-host2-snip4-10.eps.apple.com ([57.103.78.171]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5U-0003Se-8r
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:18 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 56FF01819EFF; Wed, 29 Oct 2025 17:35:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=yaziaz//KfkV1qB+UvLaS9dqmb7Qx8vSQ/YVwpl0DrQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Okg1Ysq6GKITUn4GRJ89GJrwb2Qt61V3Xyu8UN9MQUgn4R6/n6kYRmiOBK/KvuWSs8qvRC7RyDFZQ0ryBVK9olsHYOEufATMPDbkqPtEoUh4QrMRlxPNE2CCgversWqMe83ChycBakVej3HJ2ksYlLBPnwqQjlcHOFeL2tNmUEzfCq8KwEpaUtAjeRf3deplzioXDQNPjL0WxZaoHuTzVw05LUxi3kR6yD05iD8mmeKn/9mRa7RSCwYSYbCAl/1C2PQmX61ZpP01jubXd93DmXEvOin33zdewB4GxoUcYid0jLxVIPa0Yiv5ds9ESdWp7XFpoT+PIsTf2EMjytYwgw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 E058F1819DCE; Wed, 29 Oct 2025 16:55:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 22/28] target/arm: whpx: instantiate GIC early
Date: Wed, 29 Oct 2025 17:55:04 +0100
Message-ID: <20251029165510.45824-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9RUrTVtd-tEMB2yVjVvwteGQaxYB3VL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX01CqKE8864TV
 /4/SLBatpNli1Tyg1zKgB3lfbhHyJ9f1bJOWqCE5zw7LZKVdaxrBna2WO6BqhzyosMU2vnnJQIt
 Op+VS3wsnm91ZFJW1wWKQiT06iGtAVeTH0NjqBg1WO3lBTHe8NZPI29iDkR65LnmDijvAI8uOmk
 QWa7odymwWadkS/x57vB31gFSK6e23dGbh/GCaKay4JNYPbbd2mK14VZp7v+LCl7hXKf3LlHKNn
 MgljAk/+NX1vF+6OpzIoLxF/fZYH8B+ge9nXc0ppHZwrE9eD6rtwuPHfDQ2FC5191JSsC8a0E=
X-Proofpoint-ORIG-GUID: 9RUrTVtd-tEMB2yVjVvwteGQaxYB3VL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=506 phishscore=0 clxscore=1030
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABS2/51uYAdIPoFS0VD7yXJ9nlPkGwVRNrdYtpYeYxPMNlSl1smlj+Kxkq9vdQ3WMGNihLFmVmkFzS2O9RaCvXawYXWD4o5t6EAGBT/y/poq/jmuTTdO8OS7/loD2AgebTZ1NCvPy1nPQ7G3ALghsI+QafOVpCf6g6ZGAML68Y5woA9y8jwHazSgCNCM98QnmuqDJhi3A07tXcV4bF3KuU3uoca35H6FIja4vwV/TsceZt3TJl2/hWn/GfBIYNb+T8gYHboYo0YLntjx7/owi80E9ICYspFJeep32sOSrHY6rPW3fJYfr4eCrVv6CsdVszU1/D4JFuIJNEGwW5Yg/T9KS/6AQsI0A6T53MrbURbmj44EewZ7WycCHVlNO6XlqlomBx3oNrdxfedLPTM2bgC7KI+g3qy5hxddyI6kNo3pG+bypRAwdlK878agVDv3XrHn9cFiQfrdQle3/uPJvW9WywCopmeATnuXhU9mPgkxX+xCTHsdEthcPBGRFlw6v+Eqgsi8P8UgJI/ZDwGcI4PCe+05ZFgWDX9AdP46QPwVinV/L0R5W21cnU7+bY9Vf4e30m6SsvL9abSzZEuLesd/9Jz8z1cKR+D/fClyM5BUQfpHbBK2EB0Y35lLfJaDEgdE24atQpH1Mk5LvCz8M98sQafG3kqgyqMFlg3v1vniZ8YRS/mRhKPpa/6WCyVsS/jzaa0WVnzLt0VXkUvDsrA6Goy3N2rwPcAEdnA8oYwFoUEoIrVJV544O9C/vQOwCkrBn/OKGfHxX4Vg==
Received-SPF: pass client-ip=57.103.78.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 8f0a54f080..4d58e5e939 100644
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


