Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE2DEF5878
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGd-0005No-Ap; Sun, 15 Feb 2026 06:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGU-0005Ih-JV
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:14 -0500
Received: from p-west2-cluster1-host6-snip4-6.eps.apple.com ([57.103.68.59]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGP-0007yq-AY
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:12 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 718281800294; Sun, 15 Feb 2026 11:26:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154765; x=1773746765;
 bh=Ey38obQgB/4OZtOjl/rhIH61RioqpiOULYFmJqpqNgs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f4puh9C93iTrgtNLgojiz1MVpGMqaRnguyfLYtTNldAHfVT8VQXVX7ARXyP8D/hBGwEq9/WhszIkgqIy/3vB0SJK3KghFh/qlwP685P7+lUPjCIKf5/ULlDwbsrustn+TlEIe8hs73+LIQW/9PSJqST8omofbF51hlh96KNQed+C0wqAfI/OaIf7urYG3HTtx/vqwpyWwEDpjWZH8T9IjffRpwvhb82GHjrdSX34zIWLVz/ZYw/lYsV4dUrQAmlAV+kAm22itER/sgshuTANR58dBECBCHIDpR67BDq+kIghvCoE2jxiuTHvtKYTe2wbFvV6ZQfW7DYNGSpkddy7YA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 188D718004D5; Sun, 15 Feb 2026 11:26:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 07/14] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Sun, 15 Feb 2026 12:25:36 +0100
Message-ID: <20260215112543.4817-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfXzNpb/sJYKMLM
 nJwCyxQpkbF7yKYRAj0hkAVuG6zN401DUeFkK8swoeRDRHwGFI4tTCLsoL6PNUk7MiKrvAuUnHC
 /ZU52xSE2+FBpTQasDcRJfURo6HFdtVdJY7nE4oguyT/IqVYiwYjviAIQSB1Nauf2y4XqLSzLqR
 EBJ/rDcGAa69xa4BVERynKUm5bSke9eF9kmpZA3/+pXtEu3Qz+hJmmywebOdVJahQ0i7Ny+1xmM
 oREbesXUQH+p9lMgkNobGzwt1NMRtn6vF8TFOYBLwmG5wW5q8V98Q83Mk2g1M8XxHgsHXxBkFzz
 8TiTRo87Pxi9lKDNciaaFo+I8keL6RXOvrXEylyfU2rxUH06T5jtdaGiPrPoMw=
X-Authority-Info-Out: v=2.4 cv=F7Rat6hN c=1 sm=1 tr=0 ts=6991ad4d
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=PzQS8Z__MZ2uSZov3vkA:9
X-Proofpoint-GUID: UGxaIlpyHMu97dDHpC5RvXhMCZU-N88I
X-Proofpoint-ORIG-GUID: UGxaIlpyHMu97dDHpC5RvXhMCZU-N88I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=853
 mlxscore=0 clxscore=1030 malwarescore=0
 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABKMl2Sl0+FLoVTdk/j5N14fgyNJsCPv5fak36Tsf88cIpzXok+PDUWOWSeD9BIrbc6EvNTIz/WTGUj1cTvCPdBaH8ec1IN5O7404//J4cX72lDgDt0UHX+ktQt8aHXHWIXY4yaGQjt0F4Ck3Qt/75femD5fL4vEshaecI/e5j3BvGLvdP0KOTieOzpfRGK9mbDFC0xpdwXmi3jLOwPvWNIFWjX31MxmO/zaDkTTOY58a+hZX2UtDTQszPkbfn4Wl5Xk5hblEg8zZwsLhM+kVOLAdGwYZ5UgE1vPnPTUiTczJxzXd4XyD2ShMqAQPKGmd1CkHW3C95K2NmCwtUg+7vOyA5T+VXf6NtZ5b9KzzT8D8Od7dQ7plbCPVie5Tn+fT7e8izkjCVayZUgU8WmC/3U6q1xvuI8lI2s02WTzuoDMHbCFIEDQaxI05sFcYIL7fwxiIb29o3feo3QWqWnls5rT98DIWaaoXfyCxqnFlJfHOBy6i3UCvdDAKOMbpq11dSk2rVganPc20DsLODK+OE4SnTmAp/vzRLB9IWBVFpmdqCaSZy+2QQzGshNCu/ZbM4G0U5c9uuXPQ8T81kGP71Uq+JeSWx9r/sNGUyW0uNj827ZxId6MWdTqtDpkKTWXm+/rGw40xU6U9Tspfj+thYdhcpnwzQRfsgRl69Z2fykdelBhdBPPtTGprvIvtRvjVw8XWOQBzbmtDF8BUYysS2L2M=
Received-SPF: pass client-ip=57.103.68.59;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a80c5f8384..e0a51faf28 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2052,7 +2052,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.50.1 (Apple Git-155)


