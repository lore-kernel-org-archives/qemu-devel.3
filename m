Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D5F99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEF2-0006O9-0a; Sat, 18 Apr 2026 18:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEj-0006J5-DT
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:01 -0400
Received: from p-east2-cluster3-host1-snip4-7.eps.apple.com ([57.103.77.218]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEh-0004xO-M9
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:00 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 3403F180022D; Sat, 18 Apr 2026 22:33:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551638; x=1779143638;
 bh=4624USsR0p7NklevhZpyiOMKAkWt2GrauvKzkoCskVE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RAMoMLPA3CPmVMfMZxnMGbp+KmhW7TWeoo0EiTToDYOMnduynxvaA9VyF9ONzHh8uLa3Ki744I1Q/3qGgqwSqnHcAUe7yXGWv4nd/NgXx0KL8y6VsVXQ8jZ3zoRWnnhKR3ZgqpW1U7yJSxsNOpdnxqc2oXhhkYDTNmNDOdqsx1faZ8KIy1YVPQTP68QO6G99aFjcTVcvO33hx8kC287a6aLZqb+s5oqp+fBdGBQ+i0r2gxDPMiAPmoPwEL0mFSpYG/LdhS6vzKYHwElKe+ELFUlagToC+1hoQG6xFya8wBGj2PZkIeWdJZ+ssO7bDqKnwCnT3bYLjziGlZY4agRHgw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 9515018000DE; Sat, 18 Apr 2026 22:33:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 16/38] whpx: i386: set apicbase value only on success
Date: Sun, 19 Apr 2026 00:32:58 +0200
Message-ID: <20260418223320.51330-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ath6hSxmO0vdrhsd7QiH7xi9SuHyLSxy
X-Proofpoint-GUID: ath6hSxmO0vdrhsd7QiH7xi9SuHyLSxy
X-Authority-Info-Out: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69e406d5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX3GdIRHfLQlUg
 xQlYg6EJS6IztzIDOzQ3z4W5Bv8AmJW4bTcgDlg36MI8SOr20lzyFtx4ur4U3sCRkp9OuWuwDOe
 HmlGsIFDcHBG92y4AGXDYuC/PzUiXuZB18nBf29qR0rRNw+jA10MYV5C1wGslkyuxdU3/87kBGy
 7l9RPI0qdR73+YtD2Lw+Nj489MFSwL9kdYk9akamwpB0VIB5MD3lnez+A9wHfIF/Bx6qX0QB1v6
 9vQ04p6gh9gMJdQNzX9gQjckJqo7c2JdyODOIGZOp5/wLJreohWRBnhTjwMaTJa6MQ56z7t3BF6
 /D+tsKxcf4rRy9lGKLoNbQTUEeO0PKkZWdpVnR78jFj62ohptPTX8hWGNyTkOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=676 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.218;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c6f4041515..0d72e93621 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2001,8 +2001,9 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    } else {
+                        whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
-                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                 }
             }
 
-- 
2.50.1 (Apple Git-155)


