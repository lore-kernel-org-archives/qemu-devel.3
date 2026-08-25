Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45319C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn4H-0005MK-PQ; Tue, 25 Aug 2026 05:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn49-0005Dy-FN; Tue, 25 Aug 2026 05:03:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn47-0003A5-AN; Tue, 25 Aug 2026 05:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=sEStakM/b1LSpMaZuQpLTd2+8lpTXq0OXwPMNXwamtM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JnWOZcos+66DzzpYHqZPF7ZaJTXBzPsVA7KsW/qYG14TQOA5t6+p6a7EQC8fmGNUR
 3a7S5Yh3jI1yDHQ7f00b3qz/ymVXRvilUJddM5y6Hve0AjsOiEwjQ0FuTbO7A2rKM4
 vLjdZf5vuVqKWVQhwnMdgJWXrHe/i+xqxyhCUwxdrO8owXO99hpviYKUGqJB46U+9Y
 5lbCSFOCyW0vna16F5LZXawHGOMiGVe8WN0hNSgWhT6E7EmY4lLLzfJ8i4Vru2Ivy/
 mIBQaS0eMu5226PwJBhHnGoWk+HjJVCestlVyqC6m2HAnsK0JorrgpOUAwm2Ro0OPj
 7Rjd1YcpqMmXQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4BDEF1CE3B1;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 374F9416173;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B5EE63254B; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Craaijo, Jos" <jos.craaijo@ou.nl>,
 Yudistira Putra <pyudistira519@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 167/196] target/i386: fix long mode segment
 override prefix decoding
Date: Tue, 25 Aug 2026 12:01:24 +0300
Message-ID: <20260825090157.471948-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Craaijo, Jos" <jos.craaijo@ou.nl>

On x86, the ES/CS/SS/DS segment override prefixes are null prefixes in
long mode, and should be ignored. (AMD APM Volume 3, Section 1.2.4)

This patch fixes the prefix decoding to correctly ignore the prefixes in
64-bit mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3391
Signed-off-by: Jos Craaijo <jos.craaijo@ou.nl>
Tested-by: Yudistira Putra <pyudistira519@gmail.com>
Link: https://lore.kernel.org/r/20260623-fix-x86-long-mode-segment-override-decoding-v1-1-26d9d4b5804e@ou.nl
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3589cd995b4facf34071e944fd8ec2294524e25a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index bae1dd4d6f8..34dcac155aa 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1851,6 +1851,12 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
         case PREFIX_SS_SEG_OVERRIDE:
         case PREFIX_DS_SEG_OVERRIDE:
         case PREFIX_ES_SEG_OVERRIDE:
+            if (x86_is_long_mode(env_cpu(env))) {
+                /* ES/CS/SS/DS segment overrides are ignored in long mode */
+                decode->rex.rex = 0;
+                break;
+            }
+            /* fall through when not in long mode */
         case PREFIX_FS_SEG_OVERRIDE:
         case PREFIX_GS_SEG_OVERRIDE:
             decode->segment_override = byte;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 918f71c8ac0..3d300dc9523 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2831,16 +2831,24 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         s->prefix |= PREFIX_LOCK;
         goto next_byte;
     case 0x2e:
-        s->override = R_CS;
+        if (!CODE64(s)) {
+            s->override = R_CS;
+        }
         goto next_byte;
     case 0x36:
-        s->override = R_SS;
+        if (!CODE64(s)) {
+            s->override = R_SS;
+        }
         goto next_byte;
     case 0x3e:
-        s->override = R_DS;
+        if (!CODE64(s)) {
+            s->override = R_DS;
+        }
         goto next_byte;
     case 0x26:
-        s->override = R_ES;
+        if (!CODE64(s)) {
+            s->override = R_ES;
+        }
         goto next_byte;
     case 0x64:
         s->override = R_FS;
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index be20fc64e88..c48767fef85 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -15,6 +15,7 @@ X86_64_TESTS += vsyscall
 X86_64_TESTS += noexec
 X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
+X86_64_TESTS += segment-prefixes
 X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
diff --git a/tests/tcg/x86_64/segment-prefixes.c b/tests/tcg/x86_64/segment-prefixes.c
new file mode 100644
index 00000000000..a7e6e285b2c
--- /dev/null
+++ b/tests/tcg/x86_64/segment-prefixes.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/work_items/3391 */
+
+int main()
+{
+    int data = 0;
+
+    /* Ensure that ignored segment override prefixes are actually ignored */
+    asm volatile (
+        "wrgsbase %0\n\t"
+        ".byte 0x65, 0x26\n\t" /* prefixes: GS + ES */
+        "movb $0, 0\n\t"
+        ".byte 0x65, 0x2E\n\t" /* prefixes: GS + CS */
+        "movb $0, 0\n\t"
+        ".byte 0x65, 0x36\n\t" /* prefixes: GS + SS */
+        "movb $0, 0\n\t"
+        ".byte 0x65, 0x3E\n\t" /* prefixes: GS + DS */
+        "movb $0, 0\n\t"
+        :
+        : "r" (&data)
+        : "memory"
+    );
+
+    return 0;
+}
-- 
2.47.3


