Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5730C624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnW-0008VO-2O; Sun, 22 Feb 2026 13:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnG-0008NB-QN
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:59 -0500
Received: from qs-2007g-snip4-5.eps.apple.com ([57.103.84.196]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnF-0000MO-42
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:58 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 026591800509; Sun, 22 Feb 2026 18:02:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783376; x=1774375376;
 bh=7itu/O5CELa9iPuSolCH3YRKKsdLS4pTb1/OCKKFmrA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZWsNXHaE/Hoy2FAJ+omh69eC7WZYA33vkRmPxcAv/2T9Bhl7bwQ9y/Dmmo/6CsqBHhwkCmxSGu1rR8JySudZvDAxHJVKdFq4syDNpjFWaFpbbfCZGJtcQIZRHcxkAI8k7layFX26Yq2HIEzqBvsZIcVL9k2kgL6/aC6jB1oXLEGqXHE4ylW8kFUk7i/9Qyp6PDYx3OqoIWOD1XUhxpPxsSFRC7f3q4swko7qKHabTzlQFpcMGYxniMt/eK360vhyJFc6fVruaaAknca2T94dIKle8W+IqC4R0X8KTpdn+vo4NPKmYtqHzzjXBdN2CYn7+LsQBYAn5mAVLDLI21FY7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 7F5EF180011A; Sun, 22 Feb 2026 18:02:51 +0000 (UTC)
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
Subject: [PATCH v4 04/16] target/i386/emulate: rework string_rep emulation
Date: Sun, 22 Feb 2026 19:02:28 +0100
Message-ID: <20260222180241.14621-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ElkNTvSZuP2vLwAqrIL3Ys-x2n-dRg8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfX5gjUHMilNKyG
 waFAMrsBoG1XWHjwVtcYrkGB74yN2rEDSeHhrLjlsO4RGzMAWqlgUNrPUWupnA33gQA0cV0opKY
 KFv2RuQ/UQe12wWiCfRJdSx5Myf7IKe7E5zTZe+/Z+V9Fa958R7rTjKDuBoHj4rjL3aFpnsobBg
 oOe/Uur3AtysuebaUDQCzmkDDqmJIhxAcrdNhr4RXGW6/H4pUL8Y/PeanTrHg86YdMS5qEJTJHg
 Nsgc3osEWMGPx/kvTH61OAf1wVU7STOBX82HUjyOUw9SpfHnoOGbFAoOZ50JgkytChk5SGRnpO7
 r+inHwB47uPZNOt8dYUQdRzbHShInJQkX8uXdXseFQxyrP7hExODzSrEU/6fl4=
X-Authority-Info-Out: v=2.4 cv=WItyn3sR c=1 sm=1 tr=0 ts=699b44cf
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=6_-HZhw-fp-CqYksV2EA:9
X-Proofpoint-ORIG-GUID: ElkNTvSZuP2vLwAqrIL3Ys-x2n-dRg8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=870 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABNie4RdAPSx70dBVrdFCq4ua5+6t+VdtgTuwfSSi/GAYZAknz2sW2RTm39Liu6+7H1Op9FGNTOVU4++rzyO5YTcVbElE5N1iW6jZv4VM+zbUi4Lq7eEsBGD6u+5sYRtwENW8rfDpfIvubaIloInJSQQr9zTSYpB3vjUrF2tQa8AsDKOVZij0nq4p9gEOpsfuZE5S23GqNFjaQX1q9KhcmHU7afe8zvtU42S06/MgZX5xZXGl+TxC6Y5UirBnIIxVEAGMaYbqjcGV4PInONomPEq8kBqAx5y9kf1CQXWThmYmAP8K4w6HonwdiI1vSs9A4iEWae86wmbvb74C0ENXFpwh5S221ui9PQO0a6GIFRZfKiTx6WEJDzwTn4FJzJsHuRk2NGGJOC3Iux3NUwr/wkeXORIi7J1edKL9rr5EI7Z3smtk6Wl1avWiAWXnlUooDPZEkZwEoJYvVAs6Mb8wu0Cft6Krdmg2gkXul41mq1htL5tkdc+N3C5Ea/pakyDUcVEWGuwW5Pps43Ce0eWW2Liscw4RGW6IO/l15clFYIh3uAL5pqH+cBPjWwBSV7tyyywfyhTILhIy1bwq7uI/p3vhOBEfKALuHve4k/FpgIhL5mmN8wIItBW3ZLkmDVHvRsuSXlDn+GwhCgT+bTTxO8r8JIBCrYvm0kKu55jno6uwkPNVxmt69WHN5qmvypl/Prdqq93S7elVxHbMf9JUC3Q+5hQrwPIrkaMAjkyUM2HN6wwVse5SMx+w1tiko+K9kWeaQQJIRYl5bwJn4YRuNtvHn4YBzBw==
Received-SPF: pass client-ip=57.103.84.196;
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
 target/i386/emulate/x86_emu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 4409f7bc13..bf96fe06b4 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -466,18 +466,25 @@ static inline void string_increment_reg(CPUX86State *env, int reg,
     write_reg(env, reg, val, decode->addressing_size);
 }
 
+static inline int get_ZF(CPUX86State *env) {
+    return env->cc_dst ? 0 : CC_Z;
+}
+
 static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
                               void (*func)(CPUX86State *env,
                                            struct x86_decode *ins), int rep)
 {
     target_ulong rcx = read_reg(env, R_ECX, decode->addressing_size);
-    while (rcx--) {
+
+    while (rcx != 0) {
+        bool is_cmps_or_scas = decode->cmd == X86_DECODE_CMD_CMPS || decode->cmd == X86_DECODE_CMD_SCAS;
         func(env, decode);
+        rcx--;
         write_reg(env, R_ECX, rcx, decode->addressing_size);
-        if ((PREFIX_REP == rep) && !env->cc_dst) {
+        if ((PREFIX_REP == rep) && !get_ZF(env) && is_cmps_or_scas) {
             break;
         }
-        if ((PREFIX_REPN == rep) && env->cc_dst) {
+        if ((PREFIX_REPN == rep) && get_ZF(env)&& is_cmps_or_scas) {
             break;
         }
     }
-- 
2.50.1 (Apple Git-155)


