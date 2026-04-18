Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B53F99C9E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFC-00075r-7E; Sat, 18 Apr 2026 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEm-0006Ke-P5
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:10 -0400
Received: from p-east2-cluster3-host5-snip4-3.eps.apple.com ([57.103.77.194]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEk-0004yD-MD
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 2CB981800208; Sat, 18 Apr 2026 22:34:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551641; x=1779143641;
 bh=XYfcVLNP4XKUf3qEh2m3HXpH6E0h6AgTscZ6AUjxiTg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Itbuvod/Rjn/3BdJcy93m+CoKuhi9XYM88j7kIfjxudpMd7BpjbuXFRr/AyVvz0pJMlDAZAEkYPPjVxp8cRdPbd/QaJI2P5Dl/1Cd/F3PUdKujGU9vA8FK62NgN3AL02KBLl+wtZPFh9NTUCS+ZngE20Jt/g+bseVXlhm+tqjYo+Iu49V4onAX8moW8d0JWEg4GxMP0i6MRIErbiAoOICGtX8luiD3+Na6qId+KIjH9/+Le+pnpzCAQKIs5urv/wQPRXnnxwE1tZZAaQgE55TJwNBpUzA5u17R7prdE16DH2Q1o/eB4q9SsEqQ0M4Qmr1tH4GyGIPqkvjyKxHc9QUg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 09F381800219; Sat, 18 Apr 2026 22:33:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 19/38] whpx: i386: tighten APIC base validity check
Date: Sun, 19 Apr 2026 00:33:01 +0200
Message-ID: <20260418223320.51330-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AoEA7PRthxS3YNrHZnqeqpVyNva14PgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfXzYRUxd/l6Amp
 z69Nk+1AD+L63PF+8FOp4oxz+p30RFgDMPH3UtYu2Tl32VnvCPfwANJcXo4LAJrVtfHGFpoqSUM
 iXsXRp3RpaLI4fVo2A0x+vemZXM2i8f3PeLm0QR+i7NSHHU1qSwD2aMEpbcgsWklE+gErD7UAov
 SF9iEBQ+OLymyNFrno0pGy1d5aFjjKcN6jlYk+MMd0JtxYWw2MS0OxdwBe+qT8ZFk2PJBAcpO0y
 2JP5TsSeLDQTv8Lcf31XyvbNeITDtjorQxhm2Mn4Yfgmh9ULfsat328PyXVduTUvV2ho8X3NOy/
 3AtZ/r+tzsJ6KYc10hL1Lo/mSjxGZIVPYxhLpf7nfjFawK4s75wuuNwq+9f4p0=
X-Proofpoint-ORIG-GUID: AoEA7PRthxS3YNrHZnqeqpVyNva14PgQ
X-Authority-Info-Out: v=2.4 cv=T9mBjvKQ c=1 sm=1 tr=0 ts=69e406d9
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=687 clxscore=1030 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.194;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f856022a87..f31eabce37 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1993,6 +1993,9 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
+                if (val & MSR_IA32_APICBASE_RESERVED) {
+                    x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
                     abort();
-- 
2.50.1 (Apple Git-155)


