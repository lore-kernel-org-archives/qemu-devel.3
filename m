Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592B21125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEM-0007TL-3U; Wed, 11 Mar 2026 11:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCt-0003Vl-CL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:46 -0400
Received: from p-west2-cluster3-host9-snip4-6.eps.apple.com ([57.103.69.69]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCr-00068e-3L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:42 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 2B44E1800FB5; Wed, 11 Mar 2026 15:10:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773241839; x=1775833839;
 bh=4icJ72AU1OOM5tOrqHPkWr3ogIPSAmTNwYbIOrNfOTo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Zzmy5bYt101PVnWTD4+CDcunetntJWbqXhAR46xGPQqoYmrdFj5lSJv1a5jlN2qbM/HyF0dBKkgoQpZNz5joh1ELJSxavnKHajLP/aArfwQfB7hU4PJAe+Fe4pVqYt1/gW+FH2E/zmWKcATyg8nA5RlVOSkdG1ASGdcMY/I7CUbwsT9ElponvbLSrUXrVDnmSPlA54nZK8nE8qHFvNDn9DaZyj8eskvqn/PBG4Bqnjp0fKhx6fWzvmCfH0VQNM9zzZb57bFPRFpCcD8vZ5IA49momP4VjYvdRLIcNMjN7eVTf2zknBMD1VKZ6JJmbif0CAEZRZ56dhTkd28PcZVybg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 967B71804E40; Wed, 11 Mar 2026 15:10:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/5] whpx: arm: add EC_DATAABORT assert for
 WHvRunVpExitReasonGpaIntercept/UnmappedGpa
Date: Wed, 11 Mar 2026 16:10:11 +0100
Message-ID: <20260311151014.55915-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311151014.55915-1-mohamed@unpredictable.fr>
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: azrnpYiJsT2gFNFSbzJG4vboOO9_Mb0t
X-Proofpoint-ORIG-GUID: azrnpYiJsT2gFNFSbzJG4vboOO9_Mb0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyOCBTYWx0ZWRfX2p9HmN3vs4Qd
 QG3WLoVnLmYZ2AdcFWQqdVcRvNaJMjkoou9ArTPhDPYAVqnWXb7O7a9Ry+D5HrSu/DJ81Qo9AJo
 5NZC0WLFJcr6eAEWFLYjzqXfwc78+W8cAQ9XOAJAXk6KAlF+7O7zK82/9K3W0MDe2TjSVWh9oU5
 2v9Ge2+WufMFEZEzd/YYenlHiWPIEw1ujD+Bm6xNyvKd3km4Up/XGgY+4jIkjSEk1qDWypbjV4c
 ZrPP2k1ku/XRywSHBBWXedayVLjA1tKyZbb8ZENpp4+BHcWXk+lKRf6PO+n7BA8BXHHcAVJO1Om
 54UOtJrIE6q4ZO6Ji1aF7Gx/3+m7AhW+xyvyN+VmaFSri1Q5GV7Bj82fGCaZq8=
X-Authority-Info-Out: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69b185eb
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iF5FY4ceKisILDQj2E8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=659
 suspectscore=0
 lowpriorityscore=0 clxscore=1030 spamscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110128
X-JNJ: AAAAAAAB+8OTMr/my65dSUzA9MN28twdwIxmI3M0J2kxSUzBsKLLymMxIklEOkW3IubX9beGo+/KD6jHiNNadaZ1vUpkv6kCIrfXpmr6CPADKQhDazewAzQzs/WZely7XCk04QW5Tp3uKKnC5yLv73qohgezkgvE0aNL1BA06KdH1QLRkMbLdDdu2NADOGbFPF0gK6oJxMOGZwk5aY9eFY3lsVLgcS/mKTQe6wjOK5PwLQPGMQj7OgGOz560D8fSrV1e8fSbqNGi35VDRnUC8QQk3r8x4ubvTXheaHAuYYiu0/PYCdRHB9FeKeGNgAvT4xHmALZlV0jwDyix8SvoBH3WiVqylYxMXh3xYowiNjE8UI//hizXTA0+sWntJSE2Y9ibCjRubC2phWEthEBxj0ovK4jQo+R0jpbdiGquMkJZk5ZEZT2OwAktra/4KNyPDK6F6QlXl0qN8/CVGLIRmi64hKrgJB/R31wG36AQt6M2Mav6XoIbEQ34FCB4YmynGhz7RKmUQgxxJQIJRnKdm3I/w56Y4mQRz85r6lyW6KiNS2MFqcu6T9InDNqBkSDJnvrgdl4FGwXKvuetGVydWaiYpHfvBdelxINxhSTziG492CI8rWGOwKwDX4y3+Vh5hzlcorecHttaoUxF/2pyxHj02fGJxU4E2GfdjR+8yQWl8Vbn+pHmFDiIYgaaOlpP7FSiGKYknTBZu++HPVpusACUBQ==
Received-SPF: pass client-ip=57.103.69.69;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

If we get anything else from Hyper-V there's a problem, so enforce this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1..3df60a950d 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -439,6 +439,7 @@ int whpx_vcpu_run(CPUState *cpu)
         switch (vcpu->exit_ctx.ExitReason) {
         case WHvRunVpExitReasonGpaIntercept:
         case WHvRunVpExitReasonUnmappedGpa:
+            assert(syn_get_ec(vcpu->exit_ctx.MemoryAccess.Syndrome) == EC_DATAABORT);
             advance_pc = true;
 
             if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
-- 
2.50.1 (Apple Git-155)


