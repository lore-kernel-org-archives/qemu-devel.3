Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB9BEF5859
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUat-0000K2-2O; Sun, 15 Feb 2026 00:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUan-0000HP-6z
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:49 -0500
Received: from p-west2-cluster2-host4-snip4-10.eps.apple.com ([57.103.68.163]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUal-0004r7-QF
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:48 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 1EBDD18001A2; Sun, 15 Feb 2026 05:22:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132965; x=1773724965;
 bh=TBcGIKmuSULMyOi4UlYOjKB/stF+pgu+MSF/fkSj9a8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f8YthMz0o4giU9OOIekHnZoZIoz4mcZHFc1W519a9V+A7msvWhhuzdDTgTf/xElK/BESQhK/V/4Q/Bchdq5lRZNBK+NSxSK3QYJPn0qAl9EOqB/42KIoUbOW7CKQSGFoUJBpGXVHG8pDxTPN4p8XjKvmOhCgshYSIYGsYZ09mhZ3fvf+7f8xPrVYTAmhKoteDnrQ/84gt11347PjZYML3GO/HKcpFhrBdgtteiuAWWt182l2uyllWJ2y8F95g0Ce5f7dPaCmibwfilj8tTq51LgBecF1E/GshKN/kN5H3BRZHrP8qe1hIfFJN2rI3FEStm/7lei2XAEPt5hdxPxJjQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 8343C180012A; Sun, 15 Feb 2026 05:22:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 03/14] target/i386/emulate/x86_decode: Actually use stream
 in decode_instruction_stream()
Date: Sun, 15 Feb 2026 06:22:14 +0100
Message-ID: <20260215052225.22513-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b_jBMdWMEkb_6g2HHMyv-q3N5RNHxAce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX7mXjxeSdnX+C
 yS9Mn/juMUpbpzN+61XByqUVIRAUW6vO8kfmny15AOVSyDySlocRgFBe5OvTWHD1lUjfiBRDmpI
 tJkZ8FBOUGR98BhQ/ygxQ2WYbletNNOwAK+UunKKhEQx7lmIRB2fk1hof/1T5/ws72S9W9fKNl+
 xetAYkCEXJSSOg7TAh8oqz78pnB6E2lQfGKAibnBH1BNi1esKhczgXCBef1gPtuLj80eHZiu4CI
 UKoZxbZ4J40TlzqBjZ6Ob7iz6b9sU+iwudMZ1lh1oZ9V6quZXrHfyI+cS5k2gIg5w8Dti4lBoZk
 MvhUbsu/MckbRug8mgcyY88Kv5jRhOuNJVG6WMgTXMKXMJ9cSLCyMCMETug9pE=
X-Proofpoint-ORIG-GUID: b_jBMdWMEkb_6g2HHMyv-q3N5RNHxAce
X-Authority-Info-Out: v=2.4 cv=SPxPlevH c=1 sm=1 tr=0 ts=69915824
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=s2ha6HylF4ed1T9rlyMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=761 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABlnaTh9ysUGhu40BYHDKldA01gyoWpgBGLdMq9ZawTbEsOZ2o28fC5LDYS075yMBI73195JQ1GaPg2IRLQrkNUxir5j2xGm+NV++UHopT7wnleM+St7bz5SM2ZXd8C0wkeJKQig/BGxh/qcLhp2+IoNkFPaYKQNyL3v8C2PbIB6Cy5QdXAuIQ24ohvr2sE1fL0LduQ9UlekKGmeRiEjyTPC7/WOqXjlVTLYvg51HLUCukDjCaxpyj5Eqzn6xkW/y3hink63hKQ7WxXu89kykwVTXrZjoXKO9Y88xE1/w+IXy8bXoHol5wTH/CsRLSQBjPVoRHX1w3SDj7gfl6HSfQsw/RO6URViQFTMyH2c6m0hG5/oGdKPJ+0ewmYlcB2RzTEezHo2mgORGNyyfJQAo1u2FcT9LcgpucQ6BAXlApZKkY5nW1DdFi6eJDmuJsPrukACecgHKJbau8Q0f+Sd7lGVEI8jxgJDiLK1kaYkw9TyqDUWVHv9VtvGSB/xa0eDwI9Jpn4SqZVpQDwYNGQ/9IAsmfGhsQZKmBMXCx3BVDC89zTKFMjAz9g2dwyzIoeC3oqFYmu0xI0X01TSkigXJTzvkxWCqk7GhfN3O0ezeGxyYqiqmtp294d5tqr/46zkbkWtBVka17LZbPYPQ99YwjDEgUWK69ACU46iNmuFxUK71fO7WCM18gj3T/5PJZCNwgYeB0zg+7J9OwNvTqP05F768jucZBJQqnTjWi0KGYkmrNQjc1gBr6fPCGR9ePLArl7r+5gzG5zNioBZyD9gIZ5o+DCpRkqrYNqDfx0CVaCXyE34xp0siwkq8=
Received-SPF: pass client-ip=57.103.68.163;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


