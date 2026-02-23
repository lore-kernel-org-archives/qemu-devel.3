Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E5E98E0A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSX-0000lt-BI; Mon, 23 Feb 2026 03:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSK-0000HJ-5B
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:18 -0500
Received: from p-east2-cluster3-host9-snip4-3.eps.apple.com ([57.103.77.134]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSD-0002F0-Jn
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:11 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 C6AB71800209; Mon, 23 Feb 2026 08:38:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835888; x=1774427888;
 bh=fg6ASREgM8H3KqayXNpjqghODmRREAt5H2XvAof8pXs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UIlcicBDFslAQf/64hwP1H/MIU63ucp8NlaLB0teWUR8caGXbKGucbmp34DLsb3dSsvYI4I/Y8B6xwBLMJWxLFMXy3ZfwAXRmy/g/47InxQWr5td5MWQYR3k0IZD2z3WuNTM9Ek3mYo3mS1r0o/UTxKesOGQtcpR56KgxzTDKQhxiKtDW+kWd4GYqbjb4An2/YjqJH8XW+rx63gSP2DvRaL3Yjx85xLvfH4GeT6t9OmEgbfucdngEwv+cC66srxHJ4o3b/xrXCLt1dM67L0GqdO44qUXo5XjdYrdcH5o0ssoKu8SKCTtMJMLO6HngPcZVg39ye4ORuMs0mqfUXgjhQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 1AE2918000B5; Mon, 23 Feb 2026 08:38:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 11/27] whpx: i386: flags conversion for target/i386/emulate
 internal state
Date: Mon, 23 Feb 2026 09:37:17 +0100
Message-ID: <20260223083734.48533-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX+GDBw3xxXUPF
 laKBXr7+oJVTL/qMvoPz4bnZdU4J9lh+mQ29P6BRNwt1vauAi0wqZS5uiYqDNbmKeS0iAbQvpmk
 UXI15WcpzeaY38qZa1YyE7AZaiO9U/0UKibP2FREOop0/0rWlwMG+MScyxnrfEU1FkUwGehQQuJ
 KbyLrMpRdmGvWT94PJLrOeogwblGrsleyhBY1Pdf0WTlg1/vjIkCiXX9hY09mggyi9VANLwHg4k
 MM+bsir+86sjUyVu2tVOo0txHPATp2990XIIaeJhrdEstJRYaY/yGJBh/m/ty0h6H/Hg07pllqF
 peCwqSahNbMUt3VDhJlD/KnXPPC6ulwFQknmbj6E2DfA74glm0rOuZ5U66n0KI=
X-Proofpoint-GUID: knrFs6kCT28b9cqWXSWgwkkLm2J3PjlV
X-Authority-Info-Out: v=2.4 cv=RYadyltv c=1 sm=1 tr=0 ts=699c11ef
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=GO8j3Qv1z8u8_yQncx4A:9
X-Proofpoint-ORIG-GUID: knrFs6kCT28b9cqWXSWgwkkLm2J3PjlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 suspectscore=0 adultscore=0
 mlxlogscore=817 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABsR+s+VedhzlgK1KO6fe5lNyVWSoo7elinTKThp+T189L1EjPb83dr3shc34hmfgC9HObYbJdHIg9ZrOq29X0dga/+n8YVejAibFzJiEz5GvOz3XDiZJOtE2zTEiQMR0kyYatv/uwYZAaWx7g6OADOsZb4Vm4Zw/uVZvfSgw2TN8Zu+A19+GNBKN2inMl6SqflpDfpzNcnLYDQBGI1C4/56p4cwITwaJhp3KassaBZCpglLlVQaKhyNzE1HzmXiWW9aYgtT+v/v3O56BFtsD7IfXDZv4+1+qPaTb+FSXsvx6KLBaJ1SOtUEGNeeleD9kILul31xZZZc/vN6f4jMKk3vfjBhfmFP4wqQDXN9XSvayHxEgDVywO7B6XfyYvI5w8uUQjJPDAN/fXc/b4hAcfCWKB0JcjEvn4j5qQy4B0Q2cgG6GrrdafQVdMBalyFWQRBpuYexnhfHSqcrIRkYGAuZLjEv1JCMGMABIOySXWVaYWT75kMO9337H55+Iqi6cZRnuwAG89KYl2zzIVCWwrvuaTCbbBqsHt74UjEzXTU3OmHDSIdCbcYU2bv2KWRh6QbMHKXqX1USzk6B8nwIgDFvsBRFhYfakFQxv1CfCZKeUx+F3nGo0KR0VmRiYqoXVP1iPUmCvkhH/hdo4nO+RKqpQoWqBTQWXEemawz9fcyAyBf/u6J4vBGO9KcGpBjbBKc5qugXniOis8vlq9gcUFV9o+X6RLaMsXjqznkCK9tpGSr9RgNiFRglaqBcmTrSrM568XqTXDRCJXRBZtOgEDCCaM5rsZPKkMeRpQbaKpwPK43khoaw==
Received-SPF: pass client-ip=57.103.77.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index eb6076d2f4..0524885053 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -412,6 +412,7 @@ void whpx_set_registers(CPUState *cpu, int level)
     vcxt.values[idx++].Reg64 = env->eip;
 
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
+    lflags_to_rflags(env);
     vcxt.values[idx++].Reg64 = env->eflags;
 
     /* Translate 6+4 segment registers. HV and QEMU order matches  */
@@ -637,6 +638,7 @@ void whpx_get_registers(CPUState *cpu)
     env->eip = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
     env->eflags = vcxt.values[idx++].Reg64;
+    rflags_to_lflags(env);
 
     /* Translate 6+4 segment registers. HV and QEMU order matches  */
     assert(idx == WHvX64RegisterEs);
-- 
2.50.1 (Apple Git-155)


