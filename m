Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B57EEC2AF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufX8-00067T-7E; Mon, 23 Feb 2026 18:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX6-00066d-4E
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:08 -0500
Received: from qs-2007k-snip4-8.eps.apple.com ([57.103.84.239]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX4-0004MV-Iu
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:07 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 D6D87180013D; Mon, 23 Feb 2026 23:40:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890005; x=1774482005;
 bh=Ajm5wvw79Vw9L0B+loVcxnLQ5Hp1DddrxTh1ozEZLIw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a+uTLF+HfebeM9snXIBu+MU48YqSMY8KH/QMl4OV9Byx185G4t0gJUhFPl23JtILb8K2TjWifPm/ZMsOCgbKNgCP/KuvZok9lnKWr3t0Pd8SKJ1rq+58iCn+7ctMC0mgbW+l+c7z92dXqqBNDpHTaNj4V4C48ItrOuMcTq4M713cnD7m7ESrhPCdgmobgO9GD8B3EFn+DZ5tdyGg2SoKMxGFssyQaUqJQ+w9hEbKjTRgKqd34XHSbZR3VtUjuk/VubiVkDfh/oy4GAFCMNHHw6LZ2yMS35rvPtGI0yAK/XQ1g7/C+p9aLnh4yp3XD6R1clNXEdnLOPIh29ZoG8HcjQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 1D52218003B1; Mon, 23 Feb 2026 23:39:59 +0000 (UTC)
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
Subject: [PATCH v6 03/28] target/i386/emulate/x86_decode: Actually use stream
 in decode_instruction_stream()
Date: Tue, 24 Feb 2026 00:39:25 +0100
Message-ID: <20260223233950.96076-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aCgJPN1nJTqY9rFw9VSAXrZAuzmdLmxQ
X-Authority-Info-Out: v=2.4 cv=I7Bohdgg c=1 sm=1 tr=0 ts=699ce553
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=s2ha6HylF4ed1T9rlyMA:9
X-Proofpoint-GUID: aCgJPN1nJTqY9rFw9VSAXrZAuzmdLmxQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX63Oz7cWZEaGz
 Vp9NqGxMS6PRMMToRLvgxCnhMDDQRPRWHFFi/vjJA8BTqVu/m20nPSNIamYCo+HIzOyYJhlP7ew
 WT5INyCMqhv1/u9U+2ZhMngMZ8xxXH8cPCYowKo2WP6U742qpzvYcjaTTW/Esw65ICw8kB9Fa5m
 vDLRHxDgnPFwpi00swHdOBLeGJvEWzZ6HkiFYQKIVGiqwhuTSdD51vGlI54RrWEw7melCHMj6e3
 N3fPiZZO6zQ4dHaTzMpiFOnc7RRPBJ46txZX5DEFySvm7uQXRPwiKecM+gRzw8I2tj56Y7rmJwQ
 j1a2asvGo+1ITuuZM3/13Q4T7dxDDniEe7rGpXZG+KKk2Sd4Pz43cME0Ys4NUk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=857 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABNSH1VyixLOSEV2kMzEt3jzt1MzB1ij/U78XYxqdO+YGPXq2Ck42YouivTeYecF5FtP+b0UBdC6ddL2DV9DYHukNxCWgsQ0ucM3189yjgT0Gn/Tam7nE5ac5jEKZe/dK3pZpZcSyY0pZUqFOO+AR7nr+CZoSN9VmjLL3ez0Im/Dfu4dCwJRps4Y1HPzSi7r0QtHMpXEik7uy2bXFNplJLBJ3ffNO5jiHodIAOtweEHtLfusbhbrwwl5ADcHjr/Af/vid9ePDNBb4tcbYFozfg6JJQ/mztzR7XkSvGcumpu+agBNwohoojsAvq3evhOuuGGZ0hk5HXitUtF8BZEyEofuNubCiGMTvAyPMG82aAt70mphUQqU1vnTo/6o6CG0JTZvkNqEFtrEVvNqSHuCP8upmDIYf7G/sFr+A7uOfoTEr/S9L9QkXGzfCi6gT9LNtm90p7LM9BJ6jum1DZX4R7Jh6AfFitYhllFX4D3pJ/8ZQnmqp1WlR/MwiEdCni0Yve05MpP38ranKGzqXg0kx1DmN3g8WXHl5Grs0MYmBtrViSK6x2vbcRn4huzk0Rh3WEOlGxAwt7y/Mz95RpsH5wNO6my9sWPM+PlkdZ/vSDrixqQpGC89Jh04hf64oIh8UD/MI5dkm+fcwMwuLppog+Hq7rGbqbCnFrvjUnTldyxAAgKF9Wfmc85sF8+xSCjZ9/Qm1Oh/6YN15+RFvevwE7KzU6arL9qNoe9IXnl17lNZqGT6/aotCZFbU68Y+QGxuKPn2yMTd1KkMnPtAyXX+rhpJXPXusw9C6kYPe6yglF+6svsdjsH4=
Received-SPF: pass client-ip=57.103.84.239;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


