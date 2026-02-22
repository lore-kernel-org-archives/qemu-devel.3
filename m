Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07B6C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnZ-0000B7-Bq; Sun, 22 Feb 2026 13:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnX-0008W2-3s
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:15 -0500
Received: from qs-2007h-snip4-7.eps.apple.com ([57.103.84.208]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnV-0000Uk-57
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:14 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 504D918000E2; Sun, 22 Feb 2026 18:03:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783392; x=1774375392;
 bh=fg6ASREgM8H3KqayXNpjqghODmRREAt5H2XvAof8pXs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Zw/fjh3g8FnAKNNvP+IoaiRdNsZ8G5daA9B+QaMePx4tCpLcxnz+bVXzA9+pHQ2kG7RSohH/CfM662ovJ5Zq6u0TwT4IzlV30SdBzkKJ15BWJc4otuZtjM81wegHie15f5u1SJjzlG07OExPRkC6xQKigg9aL4bXcp0sRd0nFUL4M/XEldluPm9EVTLcTaEHCP5/Sv6HfHWGckxKbRrMKSblmlT6DeHyKtsyAGSWCYqYXtVcbL1NAsBOdAA/EdKBaNDtJaf60J7WQUZUdvsiwkkrAS5Op5qv8XiHN6Wvxqjw2kdt3nkgcvKmY4bWeU2P12dqZW3wjb/8wZ0BdPI+yA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 8B36A18004F1; Sun, 22 Feb 2026 18:03:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 11/16] whpx: i386: flags conversion for target/i386/emulate
 internal state
Date: Sun, 22 Feb 2026 19:02:35 +0100
Message-ID: <20260222180241.14621-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=BPy+bVQG c=1 sm=1 tr=0 ts=699b44de
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=GO8j3Qv1z8u8_yQncx4A:9
X-Proofpoint-ORIG-GUID: nzJSDyIUptqyp84W4rV8wETr1dsTZXQ1
X-Proofpoint-GUID: nzJSDyIUptqyp84W4rV8wETr1dsTZXQ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX02dseSEsPheo
 RhndbgWV/1rPh7/4AC0bJeV5DjP2wKdknTenZkOj4ZHsvEbqM5ccfmccdMgsIEgdIx3nMDL7InZ
 IfFQ9z4t8zB4eg1MMPz6SSWC0epfaV41EeE+Zc98fs4jZjwxqfvrhIusRYtUEb8h+zTnwnYP04i
 2QpZpVL7j+RvdNCd5sZMMyEQb36U9N9jFBB0E+s+HXoysOpHmZkUpM1luYWSw1fZa3AQEIAaDQh
 Cn9MRgPLIbUi649B3BTfSYjoFWjv9VOYiMygox5VeiTczwGZe75Rm/vjhvnR8bFgumGdKDtJPFN
 zCz0wsuTvT7MQlCXYeeQGaCtK5RhW3Zm58uWHTUokyiBmp7K68sFC3GdI+Bqq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=818 bulkscore=0 clxscore=1030 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABxQSIYkd0uZEcOtE+wOOwSaSYD035zHoWdO8YnxOpTgtp8aTUEEFo2ml9t2vWR6sXrJ1ya4Y/rQ4pfVG/GwNcjyp0zb/0rIn/+KGeOX0s6CBl9mJSAxoTveT20FKCTM9yPKKGpymqw9vAD7etB/bjj71BqKGJwzbsrNAVDDvMtZc+016rdS8Ux+6fVNAps97hlgQz3/05O/ZYGfxDVccF+iLSd79O6Zke6Q4hZTRDnJEKuzobCNn7qVjAfRXxpJFhneoAQwdD024Zg2SGRPf3LbxJo/W83J9PDNsoVwsjId0BtSSuE6+Zj4beZbKAlwKQNy8wmgHqgwGqg8koOrC//yIQW/ElQHgQ0h1Mr1AFv9gigEnYQ9+rWnuxEGkHsoUe2DlwvzvbexLvVNOsu7TA89BpvGl3khOOwVByrJWbjAqQWmbhB8waQhmt9vMEUXTcrvfGA/N/yOZBjHDexwu4ZaqPuf2ad0UGbtb/0EuqLCYzTIhx34FHBo7qIHclvzTY+0C9D00dbEMW2AZAQiYMxra31bHWDRTMXMIY1c3wSeW4L5VXO2SlsLUGnrUvCRVycY1paiKqoAikEFDQsdz7SGkNi8wzzvmRrDivvLtusXwslXsTXiJDyw0mZ8ZDvnWoZzQC52PrztSGX2rJ62HJ290sw9HYnbvyQ8eqLVMmRN9MGHxK2c2Jt9P/L7uRp603dmvN0wZ0M+NvjRa1JOarRuv7nJlavZZD3zjFYcmNVxb16yn5KFEF1g0ojk2NhL4JuE7mgSAEUyy3yYyzHFST0UvmQfHCIZkzzc8MXf6glg==
Received-SPF: pass client-ip=57.103.84.208;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


