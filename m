Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD830112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNC-0003Sg-P7; Wed, 11 Mar 2026 15:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PN0-0003Gp-OM; Wed, 11 Mar 2026 15:37:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PMz-0000Q5-0z; Wed, 11 Mar 2026 15:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=QbV5kzJABNYAHlYOieplc3Hn5dbU2xz3lMqVEkf4yoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LaTGl/GNGttorzstmDXgLm78tQ23gUZ1Gwdg1PakzO80BCVZy0QbBBCnbvKzFXKmM
 YKfbtVpqnbBXGZGMsK/L/HAe5P4LHxsglL5s8R+dnq5a7AFVdYRxECSDh/6mdr/eoc
 mnyeDS1GaDrNRoKV7dTIXaY/0a5v+oIiLnxJlvd+eJbrQBxCubJsZgBr0mu0yvkEgV
 E++SIKKev75Gs+h2fRzl7V4QHSH0tYKXD4LIfP3BBqSGHHwMCBBfy5t5ipNWj4x8RP
 Mmgbl7YSCcxCioCzfCIdOJMK4wihF2rkgEAQXkVbXq9lZhbGGHN0AWcAkVegSZX5lD
 s4TStBcqvS+sg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7AF10192105;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B947437C46A;
 Wed, 11 Mar 2026 22:35:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Wei Liu (Microsoft)" <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 29/53] target/i386/emulate/x86_decode: Actually use
 stream in decode_instruction_stream()
Date: Wed, 11 Mar 2026 22:34:22 +0300
Message-ID: <20260311193449.1096110-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
Link: https://lore.kernel.org/r/20260223233950.96076-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 1b93832f55927b1b76a6587ca75a5a35676188de)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


