Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3815C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNah-0004RO-Cw; Mon, 24 Aug 2026 01:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZU-0002Pm-VD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:13 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZT-0002O9-CI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso2068349a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550610; x=1788155410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qpYDuVLamBiG/Q1V6ktBM2fQXQo2lFRXtyDFj85aeY4=;
 b=LeVcpwzrs3mNABH2krg+KF1ytpCu8yHnAFxgvFxoqLyJ2M7apzwQQTO6kb1nDKytT3
 wSo3z1gHEdV0WMGn9fMMLWH9Dk194dwD80m6xRplRT/cMmtuelDHm9eJ59hMMUTiF+1v
 LSqTI0X0W5uIwVYHmg6Y/hgYq49NYIcHyJKqFS6WqnPZkT+PIntmtHscOYeeKqeaU819
 rDXqHnONGOj4MEE8vcinI+bQRnBVgRMAT5ZpoADvDmvlRr37WqSInkejzgbvoAm10rqu
 lu0lEXin7p7fsLft+jv1Q0I/92zs8U85aPRpciWpfNBU5Ky7MnF/aNLXTBqU7tj1efxO
 yS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550610; x=1788155410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpYDuVLamBiG/Q1V6ktBM2fQXQo2lFRXtyDFj85aeY4=;
 b=PvTuX9C2FPZdTgMImfB4pkfqGW8hpGY3RuIHLUr74uFCZTsyXo1YB3lSGNlYt8HCk7
 ZlBH9/cZHePTvFpn+Y/Q4/nNNzMmPhqKcQUjxnJfJXwkGlgfWM0rL6ffPFo8tz1n388I
 ih4VHkK266Oi0AdqY0RKq/ErffP3/bKsP2UoYEtWyR8D0uezHi8xa4M2qfrp7eE9Q6Kx
 uHiRXhD/NnCwydx9vN8voQoE5oWB594Em/450sw6MhfHm1eWw+Db3BnEA7arMybHjlpf
 fSep9Bmqwm4hcTvcz4YYcihZh4oVyEo1c308sKDGylOv3Bl5cCGIbfZLw+99+9FjkcuB
 sVmQ==
X-Gm-Message-State: AFuF++ls7ElKtQaV3rn2xkVba622Pi3FVGQGV8rfiDEV32o9+RXEgKOe
 tKE6gT+7bGOPrg9g7QVZuN6OhREOWAi0/xv9/xUj7AhoE+p/2zR4NEs9+PwJEA==
X-Gm-Gg: AR+sD11UCBi6QOpnIyULU1kiMGPhDTFbZ8zsN43euSwlY89gociBEuht8SG6i3PTM00
 wMfaH/6UDlOrwoVMWwaeUN+jz+/RtmDHptCDDYjjcEywROWiwNN376ikyz0DMmAUXoodAn1Qbfg
 j8fMG9trLdCTh0iNDKlhviFNnacI9sA/IPeUibZasy/jnBBobO8mM4kknIBJpRW7RW7bJQF9z1y
 Ak1nJvvM/hllwlKuuCGDqQ77oIiTD1AO9ZsVmPkD+oV92UsCNBVCXwXXuyeNXLHUTVvCozw2GDj
 FFKrO2w7rtZfEpi4R+ah8GG/a5NkQsA0oVpiRwm1egnZne5CClltLJgoOcM4/i7uiKtA+nNtzGZ
 xE43TpKT+XZ3jAtLAoxt6MQyjeJlYQb0n7o66GqfBZx8sjLEWRno8Ztbpk+PYkXSl1jgw23LFVg
 YZC7KTk+mqOKK/ftszHNtlXi/RGzb7agx0rYhkk6fItRA+2OBSyIEhgKCbFkWQ24jCLJu7irkAu
 osbCxZSX0M48XR0kMXDMA==
X-Received: by 2002:a17:90b:224f:b0:381:1f51:1ff0 with SMTP id
 98e67ed59e1d1-395c354d445mr39273613a91.2.1787550610009; 
 Sun, 23 Aug 2026 22:50:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 35/96] disas/riscv: Reduce rv_insn to uint32_t
Date: Mon, 24 Aug 2026 15:47:05 +1000
Message-ID: <20260824054806.2790041-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
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


