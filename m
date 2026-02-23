Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD367EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufX9-00067x-TI; Mon, 23 Feb 2026 18:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX7-00067G-H6
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:09 -0500
Received: from qs-2007d-snip4-11.eps.apple.com ([57.103.84.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX6-0004Mu-4U
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:09 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 C143D18003AE; Mon, 23 Feb 2026 23:40:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890007; x=1774482007;
 bh=7itu/O5CELa9iPuSolCH3YRKKsdLS4pTb1/OCKKFmrA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Mw28RG901SCuc8BRGulMfNCfn4uCikYY9l3+c6ndUQCovz2eHqEpE/0gnyMB+Rf1YTOYFFkiTkiC6naNDaO3rdOo+VtXZz6UtuJk891UE31W/i7Uh/FNJywiHmMvyybPMaGc3TAMswTDv0m1xyxnjiifFalO8mjtaG1d4OXWAVYU1TZ07yrD73gFG14GsCuNVP6cC+Zu3PzIOb0F2TIYLf05hpIPSYgP4so9UJVza8HJjj1hWl51h06gtUBWRFKxhuW8p5KYROtOU/7z1bIfLnFPLn4kdzIKo2GfQ19xW3aO0PBC36Y1CLDI0sPfF/+YHVlAAnUGJK4USEHZn5JiCA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 0A29C1800161; Mon, 23 Feb 2026 23:40:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 04/28] target/i386/emulate: rework string_rep emulation
Date: Tue, 24 Feb 2026 00:39:26 +0100
Message-ID: <20260223233950.96076-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=POQCOPqC c=1 sm=1 tr=0 ts=699ce555
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=6_-HZhw-fp-CqYksV2EA:9
X-Proofpoint-ORIG-GUID: FDYl9ZctD-HwWAlGmsKB2rMNbZfivCyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXxW3ouirZgKzF
 Lq8FNzJ8R5Xt00veutn8tkGWtHIqFnfN2Az6Q1AspJH3cSkkh8mGbJDvVEXSb46qA+9CwEcHIv6
 /s70FzjEqaFvzinqZ4z/iiAvsHL1ZSSodm/XSaANunU7wN1mMAOqKLPYnCeLfQZbXVHQe4UBIA2
 IA0jnf5z6G/u3pH2EXKb4OPPmyoAqDJUplqebqZ07xseH3QZRRYkH787nUk2H+kFhJud9Hyh+HX
 v7jjx2nnQBL9HC9+xv4i5MF9PT5e48p2ABEL0o6zT2ZAUImfXbMenwTTqXv5nInMpdWcv9gyFB6
 grgVnBr1wv/XOo822SjKWTu0qd/OLm65AUwgyDeedOawCnIvIMa/wpT6t5QL60=
X-Proofpoint-GUID: FDYl9ZctD-HwWAlGmsKB2rMNbZfivCyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=870 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABsYeyPJI9PNc97jIRAHq8RFbnyaFlmdQ4Gqiu5Qt1C1U7V3Grb4knLE5JcOfsHI112qfxVnJuoZU9a62G70apTjUS0ci3ad6W2q+gKSFrPjbGYUSL5StgbeO2EVHfSIfFy6fJmPpACAxxlTik+12OoYZgKQ0VJ/gnXz7UXV3WD+9fKprgyBYTR+5xKnbTVV0EYW8J3qXSUdiYjzMxi04FJXm2slOR+LKQUSrdopFMuhjDkcHzoAbEfJONhZGuLuDP639f36o4PhEv+7sAGqnQ3LgZZSITWAoSZvwQ4BNiDbJKej49IWxFF3EU2yQ1WdGqwIRCeaK9GTnEijYadjmVVjePSv9qBvjmSD5b2t41ujo1XEwzfaj5gbXQBasqrn3gFK7gOnNmtfk4a6AXJT3aB+21HiI02G6hhriUMF2zefsOEWE0oOFc4C3oMBDRLAE6n6rsheaMimdA4TvE28kaX00VARoiCSJG/XGepfJ8o4EH4rki4hYnzxFdY4as1Z+7Zu7lZTfcAj/utabkG0OiritOe6F0DNku/iCBBkOzlcE+gOozMeD6dq/JtqpxMB4ta5SiwJXA1DrKYfuyHovpUSb7KKNqi7Gesi+ksg0ghw6TspmV1/l08Xf8W/XgZp6yhH9VZp6uoIQXklTeBXHUMQ9aP3l5zs35Tj3GhtKvxEYqRc8ZGb9Z2D8p3irEL82DjMtQqo9CfKYu6dptPJG4urYah6v4V++7ErakNrcWmK57Yz/6wLSuGAdlLxAKS6KqwUJ3S3ANSmT/pXCYpgNc+DXUBos=
Received-SPF: pass client-ip=57.103.84.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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


