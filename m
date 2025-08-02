Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CC2C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLr9-00030h-GX; Sat, 02 Aug 2025 19:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnV-0004h1-7o
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:54 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnS-00062f-QY
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:52 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-741ab3e03aeso295882a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177869; x=1754782669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q74k1doV7rOJwdP5GZXviD3TwtdNF1EHpji2am7Z7NE=;
 b=ZQL8Kj07eEBwfWJtwtURAX/DDGreAnWOqSLo/MlZ5e0cCBEdCbGAdwUOiqEbpkUsaO
 KApC5mUn0u0Oua95VmwSgSsPofAh663o9HlFItkCSitIDcIUNX0YsfZBrhopyjQE503a
 TTwc+Qw1G1hAoPEQSfgMo/YzkwTk5hr9yFyrzn+1b3DmmGYUQp1bObIV1S83VVn2792D
 yXYsoOrrHsSz6L6NyT0xB2KmE9ra66rZ4R0i/vgbYOOZ2qfv2/wmXNxBVti64YAsE8iM
 fp/sP+g9LR7EgtXTj3ODuHUpXfTl1PvdoBG+JsRg/GAseBsEUDTLwe+AiUnhnmWaPJXM
 zKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177869; x=1754782669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q74k1doV7rOJwdP5GZXviD3TwtdNF1EHpji2am7Z7NE=;
 b=aRHVlLRN08+GlPRm63QqMY8rdl70TeDcVB5ykazuf2M+TQ3MV5Mc3VdzmWS0kjkmGx
 2jSB5Hy4Az9G5yFnyMpQ5V3CFYgplZ/CaguTNQd0unjtcM6RYy3Fk3dD8H5/Pyp/b9PU
 PMtVIuQ6dX1jRb8HOIyXhitdazKWzRgINNua1aMzJZxkwbEPJXQFaAiMfPLew/FCH+c8
 TdTgh+LtSERAkoBrW3wtsYIlN3eNECOqmMKybL78mLX6Bh1E55FOBwYp+o9A7sesuDQA
 o4DNa1BuV8izspn9un1uBoy4x7bEMA8aQFoHKGtJElPeEfuL9VRXc9+8ZGNZ2qXKpPsi
 F3Uw==
X-Gm-Message-State: AOJu0YzEUd1fEuxYY5SMrasFuPulBXqNcb29E2oHIwdK0X58YliBnHJH
 bt8jz7F3dYr+8khLIl3zc4H9P9jLKD5alIkJSc36zKF25kANPvncRtJc0taEp1Sp8vNg3fNuK5v
 0Ky/Uw08=
X-Gm-Gg: ASbGncshXed1g3ZvSrYKUC5iTiyCY23y/q3BDK5iAW8amkM67f+7s2PiaLrNWQXeT4g
 usI6NdwEk4mGM6yjtdA4nv7ZpAl64O/YKHUDaOBhlb5p3boXUzCYvHIou5zlMiFj5D+g7AtNmK+
 L3thusBS0QHPQ4e3JHmnu0jhjlbic3d26jUmkg5XT6Scs7oNGIIFJcFQnIiepWhgQ9NcvR2kKe5
 C2Sqj2ZWMbqA7irwUIXFv+9KJ2GY9kM0Hhc5qlIUT4Oov13QNqrVikkJoy7U/Gb/kyX+NRLIDoC
 9tIsigmBvU8JCPAyoh4uC7ocfSYUEZMB6zaBs/Y/Czer1CfdtsEh7MuccfTaHDHQ0KP5ifdF3pc
 cuNwCZweYJhss9nhsEFI5Hajyga9ReW8IALXnYRgJXAb0W03xy3by
X-Google-Smtp-Source: AGHT+IHZRjP/K3CZXIuG6xGZ2kt+rDHARV5zzqL0huNPKjDiVDU63pHJl/sFZoivCUaNwhZ65B1R9w==
X-Received: by 2002:a05:6830:26d6:b0:741:9157:7179 with SMTP id
 46e09a7af769-7419d2a511amr2394469a34.21.1754177869467; 
 Sat, 02 Aug 2025 16:37:49 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 60/85] target/arm: Implement GCSPOPM
Date: Sun,  3 Aug 2025 09:29:28 +1000
Message-ID: <20250802232953.413294-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 93358e6123..9b19520346 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -48,6 +48,7 @@ enum {
     ARM_CP_DC_GZVA               = 0x0007,
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
+    ARM_CP_GCSPOPM               = 0x0009,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 38987372c9..74a1697840 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -85,6 +85,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
       .access = PL0_W, .accessfn = access_gcspushm,
       .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
+    { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
+      .access = PL0_R, .type = ARM_CP_GCSPOPM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a5810be2f7..0279111cd2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2502,6 +2502,27 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
     gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
 }
 
+static void gen_gcspopm(DisasContext *s, int rt)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPM, rt));
+
+    /* The value at top-of-stack must have low 2 bits clear. */
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_qemu_ld_i64(value, clean_data_tbi(s, addr), mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_TSTNE, value, 3, fail_label);
+
+    /* Complete the pop and return the value. */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+    tcg_gen_mov_i64(cpu_reg(s, rt), value);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2783,6 +2804,12 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_add_gcs_record(s, cpu_reg(s, rt));
         }
         return;
+    case ARM_CP_GCSPOPM:
+        /* Note that X[rt] is unchanged if !GCSEnabled. */
+        if (s->gcs_en) {
+            gen_gcspopm(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


