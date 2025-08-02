Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B938C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLrM-0003Jy-As; Sat, 02 Aug 2025 19:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLng-00050K-PG
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:05 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLne-00066V-Rk
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:04 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74177394e77so2382715a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177878; x=1754782678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFYULMXdmph1Fy+p8frpDVXsvxY/1zoPtIAPaTVVJgc=;
 b=eZHyBC6Ol4S5SOsuqRI8KpcarId61sOhsEIghXuiNlf77kpYRuidi+hJNpyw6s7fWF
 vd/4Lw9EYDfw1KvvIVCBXB0b1RIMWqvBZBsQHNAg5WUuC55xLrKm21wVEIgeXbF15Omj
 q4KZpOBlYd4Zp9lvQbTF2F2LQ9yg14fjeAYtWIALxL1BgkflUerUKpKa728I/7k1tKeQ
 WlJ27HLDEmeWEuAQ617SXw3K9ShHlwpIip72U0boa5ixVenv9HYJWR1+Vfrtet31zADU
 fufPob0AmA0lP4Gvxv1IcaLDhk5G0yotfpy8W1JMQ2toJjLV+5KaLfiC/EXxClKUP4iQ
 ldOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177878; x=1754782678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFYULMXdmph1Fy+p8frpDVXsvxY/1zoPtIAPaTVVJgc=;
 b=bwNKYrdxD47zhwYkCUagh8wF5YTxuGTyiOp/KIfDPP5PRnZGFstz9e0VpdPJWe2o9D
 P6amRKee0WRUoy+ATg3LhD8geoRafI5pNM94lRZnUpeHCVmgBLMy7VocGIqJzZHX2l2L
 X30D7cWAskra6Qbm5b6Y0AXwKcM2x1TD0W58WfGXKmA9fmBAJZeYS6xg9KSDO8lLzcDy
 HUVVJthsgd98fcctBuqvJor7uBYmwwi+XMTjoBAONfCPn4vEeo8oDwL71IE5S7i/snGb
 T59CExa0osKN3D6xZXfyjdS6E2QxhL7mXj7zzd6adVPDQLECfBGNund4V0ow6bBHiXnK
 aaoQ==
X-Gm-Message-State: AOJu0YxzJ0g4VyB+Bq1/PfpAkshhDg7mM0wFE/yp/dVRmPnONiqAfDlS
 hC6PUkr1isSauDGuv4IATfrZISaFAToTLftD2wobtb8a1ly2jCRbsvdnrTQ0NbOYgrP7KLUwOA9
 itQOjUUw=
X-Gm-Gg: ASbGncsZt1+56908IwMR8OVJvjVd0l45PcorweexDh2eY5JLyvi6W7qUqFeQpqFIMAH
 owICQzQXVKYkXfRXliyv2pM0BuzbrqMLxZWMHA9A7d8iJSdfZ2u9J5Cely4X6JjNzmbcBVoaXNg
 +gEWLm/eECo/hfbyQtaob3t1RWgaotYKuHOe4eK/ag6LgXYNzKIZIcWlK5MTDGzwM97cZRGNgAu
 eQChPCu3c4nYg45K84/idqFqBgthhElPpdRJm1Ccht2nI+AuVe1oRQ9Nan8h8VDckflaGJbhAWT
 jeeLDa1PqT+TGdGAvuPis+VwKviTSBWwx3fLGlgAZXPWM5SfbtRvPsKXTRx+ScZ7P+UxPCa75U4
 KoDF1FRgvA8vMUuYixZYkOMrw2VH6WwzqwVdfylukuVi4V9us+Lvn
X-Google-Smtp-Source: AGHT+IG7VwlykyFJ/WATYH+//r8SW5N5oBZkPQAbHJep5aZRzhj1BMqX7pl8Dfi7F8pJfavlScZLuA==
X-Received: by 2002:a05:6830:2b25:b0:72b:974f:de49 with SMTP id
 46e09a7af769-7419c638ce8mr2984751a34.7.1754177878351; 
 Sat, 02 Aug 2025 16:37:58 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 62/85] target/arm: Implement GCSPOPX
Date: Sun,  3 Aug 2025 09:29:30 +1000
Message-ID: <20250802232953.413294-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3d76afd20b..084ea00e51 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
+    ARM_CP_GCSPOPX               = 0x000b,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 6f25543426..2bdd41c796 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -105,6 +105,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
+      .access = PL1_W, .type = ARM_CP_GCSPOPX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 732d65f54e..773ed3044d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2555,6 +2555,35 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopx(DisasContext *s)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 0b1001, fail_label);
+
+    /*
+     * The other three values in the exception return record
+     * are ignored, but are loaded anyway to raise faults.
+     */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2850,6 +2879,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


