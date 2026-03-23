Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BFEEC01BE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cg9-0007CI-Mh; Mon, 23 Mar 2026 06:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4cg2-0007Ba-MO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:38:31 -0400
Received: from p-east2-cluster2-host3-snip4-6.eps.apple.com ([57.103.78.109]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4cfx-0001TB-DE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:38:30 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id
 2246E1800C12; Mon, 23 Mar 2026 10:38:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774262301; x=1776854301;
 bh=a6pV38Vc8867vdB+wMASeULNxeNxh8/rfWCvj1861Pc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=T3EcgMqr7DUEZs4UKtgP6UOM+ZiTkHoyiPk08sNqxf5sTzwuYhBPGv6T/tgLgTjeWp/69G6vLS/GVM8scdh9niGBgWX5Mg7j4M8rjLUptdAU2xU2Kf/reo8AJj3u82YtmKpson1NJD2r8ws9u+NOIl8mdp1cIJdX1mXW+YIFvXkLK80TdmCj/KAFUTUINXnbwM7iaQeDUu0AJQvD0Le+V6aadFigu3iDMALrudk6U2HIMAg4UTTyzFC1Lnk2+o/r7gheLW2nYvQovyTvtUtojTDyt9M8mTJcSnsSC4J+iI+CugTLiJMm2Qk4Zyn3pSYhIeXCXAzw7DR2LGrQqbfv2g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id
 D439A180012F; Mon, 23 Mar 2026 10:38:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] whpx: i386: skip TSC read for MMIO exits
Date: Mon, 23 Mar 2026 11:38:05 +0100
Message-ID: <20260323103805.97592-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JhTOg3Dhg0ewXXDccFJDUOwN9ubWOZpB
X-Authority-Info-Out: v=2.4 cv=K6Qv3iWI c=1 sm=1 tr=0 ts=69c1181d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NP4je1IWzm4tDGSucAQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfX7y45FqrmLxYY
 vFheSNjfTQpK1z+QllUo+YY+uYDtrB+2sVUJrhNi2Pv4t2jc9Tvdt3ATrCPpArn64wBl9gdFpDH
 83/T7z+kiDECDamnTfrrbHgjv7DUXdS+kwyHf8i3mhyCvfhd4+iT2jtgHjt5pVUXc8pURZK6sG2
 fBVhknsSP6G8zM8f5Hs88Ku5G7HroS5C7FwBnLLDfjxQfTyon0wyXrk5EyARcKIG/H9y61Nh090
 N8uiaXxkshuRtzUktGED6VGjlvJIR2x0iqtEYi8P5rk7yEQ2fvU4GEtWUDQdl4JHzPZ6nPZfTOp
 bw0OTeRPqf3DHNKNoxqtYK6XBTWADhiUms6LyGt89yDRjfTCKKFYBlVuO6v2Jw=
X-Proofpoint-ORIG-GUID: JhTOg3Dhg0ewXXDccFJDUOwN9ubWOZpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxlogscore=678 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230082
Received-SPF: pass client-ip=57.103.78.109;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The TSC value isn't needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 015c0f1dc9..5ac7fbdf7a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -606,7 +606,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    if (!env->tsc_valid) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && !env->tsc_valid) {
         whpx_get_tsc(cpu);
         env->tsc_valid = !runstate_is_running();
     }
-- 
2.50.1 (Apple Git-155)


