Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DCBC5B561
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7e-0000jM-29; Sun, 09 Aug 2026 18:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7b-0000hN-FB
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:59 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7Z-0007IR-KL
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so872049a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314956; x=1786919756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AxawyJF+CxMbbSAkKOZ1E7lL9hppsqaxpuxPNg9KJhc=;
 b=KBlX4Yn3lhVbATv0LMArVnh7PyxytRQk1UEcnG9ykl+OENXxAXyA6LDVhYtNZOUSDV
 rMR0ciCmhTD4YguRA9WRXT8Xcpzg3EEhYeH3bY96HjeY8R1XaNA/V2XwfFg/L3MR97gP
 SfiFnMrql8fA+/8LgUURVtk15VsgNZF7SrLOCPsZbka71CFpeC1iJNyFofngZiAPvctA
 DLyP9RtDCXMhIpd1oZKB2uP2P9D2+JZAwl+e5X4rP7hrQuXVIjNykIWuNtXo3Ox50E4y
 ZDuBNGuXbvcw9Ru8atsUwRHv5HGXG5PhL75NQX5ynE3pf4K4hramu2NmEm8Wj5AQg5RU
 31TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314956; x=1786919756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AxawyJF+CxMbbSAkKOZ1E7lL9hppsqaxpuxPNg9KJhc=;
 b=lqbHeabAr2UnkFaCwI2W0M9zh8RwVo/Li+N7fQIzsB15y9MTkpbJOX3lN+701Iqu88
 ijmHHQBQPPtXmsycU0RmVKZvRc8NmqAsN0Vy55ZPuMxSRtf7kaDrcLrgj/QkV5E5RFE2
 eUlhCX0sctrz51r3ectnrZbVIuxdb931rQraIT29R3H8s2yc6MnVW23PY1oMRnMxA3JU
 ZJzLAz/+yn1GOInMs/7F8QFqF1B61/lb+0bamUrsXC6gl/Fmj7eoO1hkNniX3HsL+BzX
 iX+Y3ALN8A4wcUsdG5LXZnILYQrC+cq68eFPCzKfflmIqmk4v2+nfndMzTPvTOVViXJo
 B6Sw==
X-Gm-Message-State: AOJu0YzVPlB3wKxr2zZ9eAca/FcEGDpwCmfaOaNdlP/w8O8TTfNvdlK1
 MamZE+MZWVyOPa05kAYhNwWobsn6lr0u5QcJ1nzxVmkRHlObFbd05t9A/mZJzKGRY+Jt/AWPNsh
 8tfga
X-Gm-Gg: AR+sD10H2sywSKn0TQCWHhNVXO+WRd9OXUWa7BMwf1pj0hWBuNYAbUul76JbA919PQH
 0GS1LCaiP2cwQVJH4VLgQn5Jm3vB+z2xa+odTqpYsFFTx0FgztB0fyrgQD7lZAc3/9xSSkZFLyB
 L+h3dyYJOZIHi3bKKu6TsnLDLTfrOg1+/FmorF8kgFskOBhnkb4BMvU2RCT1LyM0Lt2A3HkvR0e
 XfYFuVxKVNzehDXj4T75gE8jPOBhpSf8QhGS3zg0knPw49koVIvvhPY7qfgYo8u3/gzYrSh7MZ/
 YseO5xQf9z2jj2UAnxuZ+uToINQT60cT7zX+2ryKVGluA6Exnx47cAIeP747U3a+sAeRECj1TyC
 IN5NNRccwkVV0Ml0oblJA+xXmSqHXoi3DTjrcQF/9TeKmIrOoPHf2Kaj/xRG2HN27zQRMHhjDei
 Uq1gabzw1HXOoOHnu8P5+e2+SwNSZLWXs73oIrYwyrXDWQ9rWRNb+aiJk/OfLh/RciKqqenfD3F
 7vGKofGfcJc2pUcTrRD
X-Received: by 2002:a05:6a21:329d:b0:3a0:bc61:62e6 with SMTP id
 adf61e73a8af0-3cb85dec66bmr39506448637.8.1786314956275; 
 Sun, 09 Aug 2026 15:35:56 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 07/56] disas/riscv: Reduce rv_insn to uint32_t
Date: Sun,  9 Aug 2026 15:34:56 -0700
Message-ID: <20260809223545.730664-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since 758dce9c98a, the only possible values for
instruction length are 2 and 4.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


