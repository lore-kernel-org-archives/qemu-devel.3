Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCDEE98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRS3-0000EF-Ky; Mon, 23 Feb 2026 03:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRx-0000Cu-QL
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:53 -0500
Received: from p-east2-cluster4-host9-snip4-5.eps.apple.com ([57.103.78.216]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRv-0002Bv-Ng
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:53 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 B0A011800201; Mon, 23 Feb 2026 08:37:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835871; x=1774427871;
 bh=Ajm5wvw79Vw9L0B+loVcxnLQ5Hp1DddrxTh1ozEZLIw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A0IAW/dKIrEMacrVracfAlO2AKJLHlGsliuoNOSQtomI/KYTEwOEqdl1CtVI84rTfj6AB+bpAjGKVVgv4ZszHoubvzhi4SQKw/nIb7YCbXMqJYEcZ83mjPYOINl+8/h6s0pQXhcht6wPFYEh0vsC4crkkAdg5VlX9FnCTw1gUBKSKSHHFLvAI8b4ZNrsM8fTzpz+CG9/X/JrHfCacftsjuhSG06qBS1KwYt7ndSgabeWKVV7LnZkNREHVhXCawVu9PqcKVIuznbM7TKNqCzzOsLaaY1rMvoGB1SBywfgoKDp2tj5db6a76BLLkIsqEchbRnzMDv6AiaCgRq+WV4hCw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 A86CF1800204; Mon, 23 Feb 2026 08:37:43 +0000 (UTC)
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
Subject: [PATCH v5 03/27] target/i386/emulate/x86_decode: Actually use stream
 in decode_instruction_stream()
Date: Mon, 23 Feb 2026 09:37:09 +0100
Message-ID: <20260223083734.48533-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7l0suOC8UDg1QYPT_sF6TPUMy2yclX8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXw7D8SeGzJtjz
 pVK/b+0SwIM1fc5MLvJ7JtqJ3gUNb0bIQD95JpcX/BglguoD1Q8mKUgVnhGCb2Wv2GBskXZYYUc
 +JDY69fXWYo9bcSATqVQ2Mxaqxe5AMA04N+bWEjLw0v4JTKGB0K6LmbZDeI2OXtAG73q1eVprry
 Xx+swJiF6O4S5XcedtF8T1dK7HqdzyulvTDmJvdBtjAYyhuembVIiC6ULgj09Xk7UNQIuxUVxf0
 j7+Sd8/Km0f2VzzZoWRGSm1XXzsqdUNVH1wlA4hVgub2bvd0GZYvnyTlr9XiA0ZyrUiTumrBc2P
 eoiYAMN3w1T8oe+b/gmt2KhWmDLDrrLh/U8kmLdiB/5YuW8K+8UAdrFhbS2bp8=
X-Authority-Info-Out: v=2.4 cv=WItyn3sR c=1 sm=1 tr=0 ts=699c11dd
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=s2ha6HylF4ed1T9rlyMA:9
X-Proofpoint-ORIG-GUID: 7l0suOC8UDg1QYPT_sF6TPUMy2yclX8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=857 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABG8YMpFYHGnBMqygvkW/3tlLgcPUjW93IlZmWqOE8kraR3r3P0EOgrB9t7ARGnYluwtrHZ4akEkBOx5EemuAdl5aiidQ1LF4DbwaTW9HVr3axRlMjT9D7i/6jiK/GA32VIMnp4d3zceGqH3TmR+ymAbOTFtSMSwqaOjQ8iw0wkjwyvKVS1ThSB3ZLSyM3L/WJLcW2ER/Mq/wLZkrmYJ0QVObVISSlGydzGCkoBdv98s6xkxdO1ZxXW1PMZXpG3TmEdjibNLGPKBv/aH61dn1HOQFgWcB9LPIuRxB8H5YEnRwob9WvrIQTiKaX4TnFp5tieElF3kFv8HLqb4osI088N6O0nk5ChaJ+8kEfv54kk+fnHouMyMsAsFCRG8mtARwGmdXJ1DC8U69+XJjVPt1Bb/XJ5myXF9gugB5bJtnxfQQtrmkDBFqSTMDQfXbgiAphsw7w2DEZWgS2IlnCy9sc1zcOTCh+aZvEIrZaJZRvMVpRDgkcJrw7dqWhYgSLazprEPMwhCkqg8SfoYKVYuKU8+L1RQT2ecCaM5PjCOTwKhsp5b/0WqEOJfwLLlPs1oQqDgb6B9MudZxso34CDAwSK1qmaSH3gtEU0zSkA1wF5jcWEbzVm167vZiLxij/F+K8i5EzEsV2F9LpSIXmremdvP68kw0eUl7dJcNtPQVDB/ZX5AaM0W83t8fl6uAKXDjqzgxepCog8BozGagMOg3FJY8kdPDRk6AWCjMOfgRxDmMa1OqejzF0dBHA2/riPq5RLl1IZkg//HSbaocNAXBtK4frKGB/TtOJvkAoXx41EXg9xtHNnO/u3P8tYQ==
Received-SPF: pass client-ip=57.103.78.216;
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


