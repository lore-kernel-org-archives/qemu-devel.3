Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326DE98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRS9-0000Ei-4t; Mon, 23 Feb 2026 03:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRz-0000Dx-SO
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:55 -0500
Received: from p-east2-cluster4-host6-snip4-1.eps.apple.com ([57.103.78.202]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRy-0002CG-A6
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:55 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 31E3C1800168; Mon, 23 Feb 2026 08:37:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835873; x=1774427873;
 bh=7itu/O5CELa9iPuSolCH3YRKKsdLS4pTb1/OCKKFmrA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KuOgTakSONpfOg0EiMNahmp1PZHJk5rIFWrtJ4+zj6RVv+cZ1ksqQrpcZJrPlD5veCsZXkUp5OwtQsHfWPvEpgPuXWog3jq3cc6nEAobCkJW6fNobCJ1yCK2kgPOETlTAu+ztz7ksMMySaxdO7ODHKWEMYj4yiTEYL3PzoKd0HWdIzehIlKV1AM+kGZAfKdX0iWb64wavqPIOibDfMAqEssyEcDAjfcnYZ269J/f5t0XcGipyN3+RqxruBErVuaXxZjvmoAkms2WdPGcbGUP8DuAlsOGD3M6+GVYsCisTxA043GTLlASF7CrRVjghTuTOwxcxvGZB6M7XoyO4icklg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 1A25118000B5; Mon, 23 Feb 2026 08:37:45 +0000 (UTC)
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
Subject: [PATCH v5 04/27] target/i386/emulate: rework string_rep emulation
Date: Mon, 23 Feb 2026 09:37:10 +0100
Message-ID: <20260223083734.48533-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NefzN70ZlL6Rnq_K8K5B1KJ3EVfllTcZ
X-Authority-Info-Out: v=2.4 cv=FuQIPmrq c=1 sm=1 tr=0 ts=699c11df
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=6_-HZhw-fp-CqYksV2EA:9
X-Proofpoint-ORIG-GUID: NefzN70ZlL6Rnq_K8K5B1KJ3EVfllTcZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX/uycO2ZU5TTH
 UBKc8P1olTHk22RtARjXsuSl5oEKsPriQAaQZKi8a66loEujzUMPlS7KDx1amaTM2i7BOsNt/OP
 dIkMiDkVZ4ZEP880vxJVmB6ch+rqF73WNfNaUuDHoIBcPxO/8ZIY/Kaw8vgNzs+sEfEnuyHH/2H
 040T3szS1X6bZ3EmI8d41Krz5Oa7mw9wjdf1CJl96qmm4V8s66Idwr+DNsIWuO2RLIlBhQUTZMZ
 gvsaggyeKAyRrmt2cMMaBA2Q2hYqC9Kj8KiYRbOiW+GYtfWTMVU87uKeHTUWHwi9AU9xXZfEmzn
 THWMnJh6REDUZ4FVPbzNPy12hYnC3oUr/9sx7JcmD7Kw+gSNMWAxGvPxMdn32U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0
 clxscore=1030 mlxlogscore=870
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAAB+NMK96lWwLstnPjkwfOEP1/cEaebUSAu5fOmz7tJD0rpkUna2eNcEin12OGX8UyBieTJzKh+xWWn4TAIg2+SNN7pCYhvfXOYfFNG0Uz3T4ZgSw7qtoAPhKVyRRnUe1xuXZvW4bbyPDAR1MSs2POFTfG4O4DQkpLpjkjqG9DN8DJQgtq8CJ+q3HR72HHfuPmHnXNlnJn3UlrHoHnSbzKwCxOWiyLASX4mGvNbwUKO+w8fAAVDJmW9uX2itTmC0deaOqjW3VTs4MWvKr6j08ieU+Vr830VLmsZ/hbxvy5XDVido2dsocs1yQtFS+KM9TMOHVdVmmy5EvupIwpBpMRYHfKnRKCfunhSafhqpQ+JWV+JUedWA/VP7dojBRMQK0T8O2e5tq8FQtV0J0Tg+2pK7LbqEFhBrutmsDPb1or9xh/yN2jARzTuM6V5wJqqNro7rVfuTMEODki+qVKwPrZ2jhbsxAlRINMONDCoQ2NRL8JUA1pDl9ast6dA2TugNG5ZG/N5Cx+cykA08LBduaLVlOXtpIkmiqoFV+5aO1YFCthVglenNNR2mt9Jg2uej/QuggddGaCHm3as9lBjE4zWvf6QFQZ3/HrgACbf9K2TXuJ1j/26SwFFFIc+M3IJ2eZbqhOf0Ak2lNS/nuCMFRNNt1b6O8xBDad00a2Ht+J6duAf6Tko70d/CyIFcS6Sp05VDIxg9utKnB9txfuDYJSQ8vFwbTVTbTkR8UZFM34ANDa4tfZM8O3BF2RrOEDwlEFNRXgeSbmmnvKPxJ6pW2M9HsYCE2KpIn2MzuDjtg==
Received-SPF: pass client-ip=57.103.78.202;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


