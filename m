Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D161AC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjn-0001kj-FX; Wed, 19 Aug 2026 23:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjl-0001cV-1v
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:41 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjj-00045J-H5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:40 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38101f85591so406959a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197598; x=1787802398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qpYDuVLamBiG/Q1V6ktBM2fQXQo2lFRXtyDFj85aeY4=;
 b=pG1B9OSch9F0d/jYbPID1z2OrZn1K2no6m6wabHhgmujkJK6JJ2a2DeXoBWdmIy9P7
 R8uYrhL+wWAaeaPyPHlEZUmisq8NNjKU61/FeGXqwjumwX76fCL8jG015ysK2nJBMjU6
 S4IrKTxNyWLPaX3IHw7GF7Sa3UX6Z0kNIemr5yXILo2oCMGd+pSdFmgFNFu2m8W0zNlt
 PmnQqZo8XluuT46SZSrU7naLnO0O7PzWUlmDyfSBIHLBKfJuixftlVvk7wDksi5wJPzH
 v8f9340eFxm+2OscOJkPDHaD1dka30twC6PGKpLFlmGs/ZXoZUFsGqgM2Zc7HVRhvAVk
 5haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197598; x=1787802398;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpYDuVLamBiG/Q1V6ktBM2fQXQo2lFRXtyDFj85aeY4=;
 b=P4OFMafIh5Bc+gWPqJ6VpYXre+95olQ8L/Fh+PjEuhgNUqDPr03bq6oPmB0Zn0ZgzD
 jdGMFpJM2EuTwcXsCtT0uDOzlo8CrTJQMSfOsZC6P+59qlBjQVWnbUMkFcXEzp+zG/+0
 jTQIrsCQnMp2NMOhKp6xhp0duP3P0gltezJrlLhHjzL0DRXxhMD+oNgMn9levqyPDdjr
 HTiZCuR5oxJUFX3fuK/1W8SPF/YRdPVD0ctdG/v8RlIlXZ37SrR2/uFREcp65JnnvLz6
 cS9DzWpMWx7kVMQbhzPEbhKn3SRfyX+HXLy1rrSDSDl+wSCAIORE9OKXPj0tmGO2lKQf
 SoPw==
X-Gm-Message-State: AFuF++kNVqOi42uiJYF8AzM3I082Z3Trp7c25zc+8R7oejfxfz7xha7z
 GJnaJwhhti3WoTcTkrsUjAYjGeD9j66sKPtpCm/DcEazHFC5AYruJEm3ksWXNQ==
X-Gm-Gg: AR+sD132Fg0UWmGsNgpJOUfyy5dyenLoEj2mm7wNS+lKrHgdvLLbjv9KsfIAwm6RZsn
 yYxPlCevmYbv3mX5hnkajYRaLMPIGwZ+33r29kqBrhfvFooiVS0Ea8BJFLfWJHcQF9Xdv1U3X01
 jYdVdYsGg7DtEts924ZbgySpbtEr63dYYzrHVhXt5cJUUEbYwcW0S77Y8PJqDRZdsgiiHM79rnN
 PHEqlAv8JNxVwYWuTbBpkvQyn8daLCZo/V1KOJUhfgBiD3AiXhWRWDcasdfLmG3Y7eBgery8UFf
 twP5DEImbRFEMLHfIFiQ690m+cU8OsI7pyoV3KjuD4r1zouq0FvBBGZOQ9myV3OIIII7fWZLZmg
 /UaVLk+W48E88YZe34AVN9rrviLD/D3VsqDuKUBobyUda7jlXjWapZvRNZZYo7JjG0XYyRCQUOy
 3dG+xs07cCqqt5nHF/WOYlziKsWq62naF6xt+0am9jxWuJ4jDm6XunEdgptYWX9h88Tk8+GcE4j
 5p0Tot3aIMRCEfC
X-Received: by 2002:a17:90b:3bcc:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-395a06bc47amr4469463a91.16.1787197598057; 
 Wed, 19 Aug 2026 20:46:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 38/93] disas/riscv: Reduce rv_insn to uint32_t
Date: Thu, 20 Aug 2026 13:43:35 +1000
Message-ID: <20260820034430.1186695-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Since 758dce9c98a, the only possible values for
instruction length are 2 and 4.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-3-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  2 +-
 disas/riscv.c | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 91ada8b531..eabe193b4f 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -11,7 +11,7 @@
 
 /* types */
 
-typedef uint64_t rv_inst;
+typedef uint32_t rv_inst;
 typedef uint16_t rv_opcode;
 
 /* enums */
diff --git a/disas/riscv.c b/disas/riscv.c
index e3fbc26626..012f90fce6 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5491,10 +5491,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     return format_inst(24, &dec);
 }
 
-#define INST_FMT_2 "%04" PRIx64 "              "
-#define INST_FMT_4 "%08" PRIx64 "          "
-#define INST_FMT_6 "%012" PRIx64 "      "
-#define INST_FMT_8 "%016" PRIx64 "  "
+#define INST_FMT_2 "%04x              "
+#define INST_FMT_4 "%08x          "
 
 static int
 print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
@@ -5530,12 +5528,8 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         case 4:
             (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
             break;
-        case 6:
-            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
-            break;
         default:
-            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
-            break;
+            g_assert_not_reached();
         }
     }
 
-- 
2.54.0


