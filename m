Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1545C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 21:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubnP6-0006yZ-NW; Tue, 15 Jul 2025 17:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom-bugs-qemu@fnord.at>)
 id 1ubmo3-0000E2-1q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:03:20 -0400
Received: from fnord.at ([144.76.62.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom-bugs-qemu@fnord.at>)
 id 1ubmo0-0005QL-GL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fnord.at; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; s=default; bh=
 uBOpaoUvyajU2bqgrgdrTUy/GQtEq8gw6Zo3TWG2Hkw=; b=wAiQy9wgmd27wJNN
 MUvZAU4PhNYqOib5tx9kxhrCjqeEGw1QYm9GNTqJGsn3KMHPF2BfwlNwhhEa++eX
 Vum5AV8/fwd2BzhEu0nIK92DaYYxvQ+B2bkXPD1Mx6iHXiDyfMQ3Ui357uuESlG0
 Gg6kYUPicn7WetMhTEP2JiSCvLc=
Received: (qmail 1583 invoked by uid 1000); 15 Jul 2025 21:03:07 -0000
Date: Tue, 15 Jul 2025 23:03:07 +0200
From: Thomas Ogrisegg <tom-bugs-qemu@fnord.at>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] target/i386: fix x86_64 pushw op
Message-ID: <20250715210307.GA1115@x1.fnord.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=144.76.62.99; envelope-from=tom-bugs-qemu@fnord.at;
 helo=fnord.at
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Jul 2025 17:41:29 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For x86_64 a 16 bit push op (pushw) of a memory address would generate
a 64 bit store on the stack instead of a 16 bit store.

For example:
        pushw (%rax)

behaves like
        pushq (%rax)

which is incorrect.

This patch fixes that.

Signed-off-by: Thomas Ogrisegg <tom-bugs-qemu@fnord.at>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index cda32ee67..3892ec374 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1541,7 +1541,7 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
         [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
         [0x0d] = X86_OP_ENTRYr(JMPF_m,  M,p),
-        [0x0e] = X86_OP_ENTRYr(PUSH,    E,f64),
+        [0x0e] = X86_OP_ENTRYr(PUSH,    E,d64),
     };
 
     int w = (*b & 1);
-- 
2.39.5

