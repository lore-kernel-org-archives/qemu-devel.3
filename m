Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16473C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUF-00078G-TZ; Wed, 12 Aug 2026 18:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUD-00076O-UZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:49 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUB-0000sY-NQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:49 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbee846deecso1283229a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573906; x=1787178706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jeJX87NnsGGIkeAEcQsojJtmNxSWouUKxNl3QLgCqeE=;
 b=SaKZShKNesx5kprPUKkmvGJquXK+E/9sEDDrstxyutfkWwguGBZc2M81zTSfbizlBf
 qKnz/Ce/cI1h4iuQQ1J/kdzXWWEBhhZ6WjriovCybfVHlwy01I3KN2XGSWLUtbt5amf1
 mnwaD6CWjHU1d3W0c7LnPKiwe4UFOyIt1waZkK6PSjnbyimO6Ym0rxzqCnOxXam0YgHT
 O0wc9L3gfh8BH04Ms4HptO/J9YsZYc1aqvDjJJX1vQUHUShvImpxyfa6hETOK9X+y5sE
 vI+gk5oNM8SNC60GoP00FbkV3kR7hAdgpNQ/z/NXtyNmlXK4xpzW0RqP+0ivfirMIpRR
 adtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573906; x=1787178706;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jeJX87NnsGGIkeAEcQsojJtmNxSWouUKxNl3QLgCqeE=;
 b=glKnP3ahmRXiNpGFpWuoABlWaR7p0lgMREqylJgXc+8Rb8lJsRf943494vNk33t9vu
 4AKRhY7BH0OGJTyIreWDEZfthVu68KNVov807+gBXgPNpI+F+B5wFPoQDADTSw3nR8LX
 KaZcgT14d4OdWVnl8oSwALf3+euQSuKDJQDpacRu8b1QuXvqDvZmRDTCzh4UWe0OtLsv
 aLTs9vu9FAxka6PmjRi31nIPLtFwmpRSGHZt2PDfapwYto1pTfb8T+fienWOYENq/3te
 3lzRbS+xtopqxutYFjOgb9EznFA6CzldYJ6GE4NBD9nH2JWL/816tbSznbw213+qXsg8
 AjVg==
X-Gm-Message-State: AOJu0Ywk3nTsLp5gJTsde2BPt8vRrnX11Yz8vVrTaDK82zS4lbttjwKf
 g1bJxG5z2lmfhMPFsLpij/qTbJlvgwUgvV4Ad6PJv/op3r3roSQZqeKL6h1nKVBDdemAA4dwPnM
 JD7mG
X-Gm-Gg: AR+sD13zSNqDPJr3vkN49MgfBEHRmU26qnE43VBpNaWUt5nkQeV+FZYllOJTRCC0UUG
 LhE1LmQdy7ZbE4x2z2NtkzzAPCAhqjZPoVFkX7ct9634hXBE5AJRRnwDGFa/4qQ9kzxPDngJk2w
 IMv9l1EZ6dMcaNxnvUTVs96SfnYPcXwyh2IskVTVsESJq1IK6BuqVZ92fyxZWdjQgdc02v5pwnQ
 kHnOunD4ASFXIJPfNZUF1M1jR4yL8QEwaYEmHu4PFYbAusM4BAoyvzQB81AKhdS6RBdhAjPte8i
 WzMSh2EqfnLu9nUOL1r183GHyzPXlT7nHgxHB+BKqsrYau05RVi4PMW2qdHAL0WeZ+QP282vFMR
 QltBE4vNdOlL2uTrgIO8FbAEagu5BJEslXFjvkim8TDrJJ4FhcjZb2SfenbdhIpQC2pSi7t6IqE
 aUud2SkTnC7sijlTyR1Xx3K750A3U2iq1ErOS2MssP3Yyvu/KuqTMoxza9sEFOqlAeiI6jj2+9Q
 96y24E480wh9Em+vVKw
X-Received: by 2002:a05:6a21:7489:b0:3c3:88a5:83e4 with SMTP id
 adf61e73a8af0-3cc54fe45a1mr2222371637.10.1786573906147; 
 Wed, 12 Aug 2026 15:31:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 02/52] disas/riscv: Reduce rv_insn to uint32_t
Date: Wed, 12 Aug 2026 15:30:52 -0700
Message-ID: <20260812223142.349142-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


