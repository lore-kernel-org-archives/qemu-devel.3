Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CC9C624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnY-000078-CC; Sun, 22 Feb 2026 13:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnG-0008Ma-0U
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:58 -0500
Received: from qs-2007h-snip4-7.eps.apple.com ([57.103.84.208]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnD-0000LP-V6
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:57 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 2AB4318004FC; Sun, 22 Feb 2026 18:02:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783375; x=1774375375;
 bh=Ajm5wvw79Vw9L0B+loVcxnLQ5Hp1DddrxTh1ozEZLIw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GyClCUyg0wVDWERVOfFfwjxuXrwyFg9aGiWcP6j4GvFYbftZjBGMHpyVvW3QqfAMT+9WtyRy5rhzgW9ND7H5HtfG4wbNMRNrlOuIJpv8yNxQJHhaiuahRiCbImsIu3jNLBKTucGFo1nM610jSpEWVgE6zyXkZSqTVoYGeg1TeexEU78vQzeADu1Um9w9dZOoRIVoODOuH3k9NE00ErjCHf+rlABuoY50HnekaqwG2g46IRY5SphyJKMNubeSXza7px6UVGDN7X1Ar0RxndIv1zb9cQPvwveaE9WjkoQiKVZJUFXLHVBEnTsgQC/h1jZj/lV+GE18VYR0L/r/shaD6A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 7F7FC18004DA; Sun, 22 Feb 2026 18:02:49 +0000 (UTC)
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
Subject: [PATCH v4 03/16] target/i386/emulate/x86_decode: Actually use stream
 in decode_instruction_stream()
Date: Sun, 22 Feb 2026 19:02:27 +0100
Message-ID: <20260222180241.14621-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=b6K/I9Gx c=1 sm=1 tr=0 ts=699b44cd
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=s2ha6HylF4ed1T9rlyMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXw6LpvivwMiTN
 TE/Vo/59TbcXmSTi1n01LcynPiRssr8a8t7wKP1eFpoWGEplh4Kdo9NARYJKAXsSWDOLGK1sgPe
 i4dVattgzc/Nagf4/PfE6vZGroEFrdKOj4UbrDryBQHputN0FmwSJfSyZcrDc+dfON9DDaMHfV/
 1VnRrvukvXKRxcYSK3r3Pjhcyln/gmwindGMhDzapHG+GOhr5nIP51ZouTu+2EkADbQb4cqNtZO
 dWmFKjDTPJVpOSwLIm94ptsk9MxrALQfV+ZrJUYwo3mmGBNHDRd6Hg+m9bDnjKlf8EJHlW3xxyj
 tyN+ZJy9ax8a+S1Cp6kwUmK28w6aCV1nJvOmzvlkr4tNQEQBVtaDB6IpW+9RXo=
X-Proofpoint-GUID: VBQ3hjYmv0zZrEXlIHkSU0J9pkJj_vDj
X-Proofpoint-ORIG-GUID: VBQ3hjYmv0zZrEXlIHkSU0J9pkJj_vDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1030
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=856 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABYRBybq9NILXycdEBRDHWStAcRqTtXQfn/fKgKd1vHed0V5fJKSxeTJzHlIPRig1+QeWH9l0tvZzjywSM/lrciEabfr9zrEcX7CHUV9HqkiVYcLs2gULeyHS6Hl+v7Fapullswuug3eI63E/sKsdC4WREGmYcQgLWv8OBaDpTqbvypqMgvuRYJrl1E6zsmKPPzT1qq3kE8mgCl+lAT9MJmvfrDYshUkpvgbplJh8nwEQdJdSqcTSFzMSSkT4c4gFHLd05hBrW7JVjJQ9a1DZ5nFKSdsh1raWkVbdpGTGuwWcdewqgslBvWsU6UtfVhpeIzjFU2kjsowDRSyqEH8dp1jN1P6REe+p1oUL6ZV0l/KWOgmPWCOHRpSQJlrkrOwh+V8E+0NE9huNk6X/8Wy0ozhJvdkwh9WJRb/7HVj1quXPFqIdcFsgvyVtqCh6L8cj8BmJcvBb/5yVeAfTaCaB6u7amWkt7bTmbnbcW2Xe6bBNHILscYV1F/FgYH1WDsKUO9AOIBci7JuM7aaatLsn13QiVBnFzQtuJSYTHuWNwpBjkqCj/nPJLPk8XoVdv4Xt0XzwlA3+dbTgL/DwbiLdtx0R9a5I45+6pGMX9/nMR/pXsNR9+TbCqZd4DUAggHRtyXHAcMpeNj7WcAuaCUZDpI2JsajWR9t7IDcIZcW67GbX0jgq2NXWCRFyw25R0fzDcH1QZzeB2IJD9Ra2vHXROhygnoQbefU0SOnpKbL0Snyvr+r6cop279YrcuCs0/QItikvLj5ybIrYJxYkmxTuHT0XZFn3hnfuaS16F639j/5geciyXBx7rWA==
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

From: Bernhard Beschow <shentey@gmail.com>

Compared to decode_instruction(), decode_instruction_stream() has an additional
stream parameter which avoids some guest memory accesses during instruction
decoding. Both functions defer the actual work to decode_opcode() which would
set the stream pointer to zero such that decode_instruction_stream() essentially
behaved like decode_instruction(). Given that all callers of
decode_instruction_stream() properly zero-initialize the decode parameter, the
memset() call can be moved into decode_instruction() which is the only other
user of decode_opcode(). This preserves the non-zero stream pointer which
avoids extra guest memory accesses.

Fixes: 1e25327b244a ("target/i386/emulate: Allow instruction decoding from stream")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Tested-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/emulate/x86_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 6ad03b71b0..7bbcd2a9a2 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -2088,8 +2088,6 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
 
 static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 {
-    memset(decode, 0, sizeof(*decode));
-
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
@@ -2101,6 +2099,8 @@ static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
 {
+    memset(decode, 0, sizeof(*decode));
+
     return decode_opcode(env, decode);
 }
 
-- 
2.50.1 (Apple Git-155)


