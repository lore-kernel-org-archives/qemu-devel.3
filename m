Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A08C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yC-0003hM-Q7; Thu, 20 Aug 2026 12:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yB-0003gR-1v
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5y9-0005NK-6B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTmJhe/AusBDZv/xlRqegxoTU1hoDmEdKft2Fbuo4m4=;
 b=KUy27QGO5Zp5E+kAe260XCnXB1d1CUEz5a6itQzx3au60GX1oMp677dQ0cJ3vrJJGifA9r
 JqLijhQ31U3T/bTmRjU/KyhpU5j55cx/QqPE1UGhKteS+xbFUTz0nwGEI63anCfSJ1aMsZ
 bpbMKemIu44o9MGtxTqCYe+jt+O4Mcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-HGycR6q6OhGG22nfKRBTJg-1; Thu, 20 Aug 2026 12:50:19 -0400
X-MC-Unique: HGycR6q6OhGG22nfKRBTJg-1
X-Mimecast-MFC-AGG-ID: HGycR6q6OhGG22nfKRBTJg_1787244618
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496b6f97676so220885e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244618; x=1787849418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fTmJhe/AusBDZv/xlRqegxoTU1hoDmEdKft2Fbuo4m4=;
 b=iymXFyhzbsjDShJfRlen/buRJeDCvZP5nKtZ0mK4GSlGvjPLNqR7TKhG4QPYEamWHF
 CSNM4z6PITpvlRCiLQrq7WO0zekMPfwbQvI7p5VAXR17z2qS5UV70KvA2u/TIpWCgyOy
 1B6zIfgogT0Hpd5yKYNDXmc2Dk7iJmp56JKe3X+0ETH7G9Gn9/u3iwh9yznSOp/J9ZW/
 kWXEN5EVpVwZovkZkTPo9DkuAOwz5cOQkUomEz1bJWCMK/lQEXvAjptgWUzqWDT+FTCE
 4mHER58z+e6jtIfrPAJYMN/lDcIIJe5vDJFSfUZnXAZx/X4d69SeNJJlQ+vCncelqXyB
 dGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244618; x=1787849418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fTmJhe/AusBDZv/xlRqegxoTU1hoDmEdKft2Fbuo4m4=;
 b=s5ddroxLB3rgU0773k9RjVSzlXHBLgXTQ6Dz20aj7rKrnN8Wwf8vM97wtnee02NTOb
 AjG1US18U1r98y+v0vSdYwtvrwpf9vvr4m1gobpDkLwo+1CsvB91yW4Pp17yz1q2DrrW
 qwLyma90QvJ1VOvVI383j520uoTr8eS6aSkcJ6o7P7NhEQzrpHqt65xXD8gJCP9s4UyZ
 uXn1JjTuoYtrPaV+DVo1jJIeaSO9sbU5hnGCJxd3U7AqeVZaGGy1XL4uNMXJK3JV2gI5
 ma7qIQA7WWKj9umzleFGPqOWbQsq/cgm+3g57athuvGuOPXCc/ZP/OZCeh1/zTCgjei1
 eqDQ==
X-Gm-Message-State: AOJu0YzVYbbxa+nRExnl48u3q8hZvDSYOO4vmqFF7hEnDW1pQZUcVorN
 AXEBR+jMhLZx8Ze3e2ahoRQ/ze31APhIpTDLUfTMOTA1O88UEbDvADSOtGlBsRNkym43EXe8/y5
 Au26exJ+oOGAMX1Y7eKmFPedfyfxHrS5bnsldG42eLh7lW+Iy+tEAIiOQfaYaEejmh2SxR7aegS
 1dhU98QkzSKcc/bMoHTH0YK0gBbDU/fij8tw+4sD8M
X-Gm-Gg: AR+sD12Ul1wwgjwLIHaqTZW+KOCWqak5FvcHVJa5b8N8cwWhUuLAjEqxEo9ov8U+9iL
 CSkn8SziH+DfCeLGRDcH9zdH3D1yYv39DPENvn6k0lancoOcyt20EMc4aiK16DCMmS3gJUOHjMH
 TfchekMc/5LxPdAwVKivsFiSTVr+tUCTlIsemNOpAviyXwUmzeoX794rY94ImXB7cLHt/yGzcXW
 GiVonPel1pM98wvYIVSASzxhIvbPwIVVal07LDTa0utTW+eoLAWqt//YLx/k2+RwIYI8gEq0nEV
 8askUhWwtxW9/lcNbOOWA8aFFI2FOmxQHLuRB0K9D1gOEHatn72Nuvu0+PAnKtUCPEcm6LUW22c
 TIKrDTyD+6ecngyKH8ZAHdjFHbIAhYNWpyQZdhBGIHnHVpE+6JktgrtErEWnxzxANzkIK4HRCFs
 btp6w=
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr3057545e9.10.1787244617823; 
 Thu, 20 Aug 2026 09:50:17 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr3056705e9.10.1787244617361; 
 Thu, 20 Aug 2026 09:50:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b35386sm45588625e9.4.2026.08.20.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Craaijo, Jos" <jos.craaijo@ou.nl>,
 Yudistira Putra <pyudistira519@gmail.com>
Subject: [PULL 05/53] target/i386: fix long mode segment override prefix
 decoding
Date: Thu, 20 Aug 2026 18:49:08 +0200
Message-ID: <20260820164957.1895963-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 target/i386/emulate/x86_decode.c    |  6 ++++++
 tests/tcg/x86_64/segment-prefixes.c | 25 +++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc    | 16 ++++++++++++----
 tests/tcg/x86_64/Makefile.target    |  1 +
 4 files changed, 44 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/x86_64/segment-prefixes.c

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
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ac5964b95de..faf74b00bbd 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2816,16 +2816,24 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
-- 
2.55.0


