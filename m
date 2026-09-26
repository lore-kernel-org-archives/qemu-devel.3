Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F66C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAcFs-0006Vc-Gf; Sat, 26 Sep 2026 19:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFq-0006Uv-GC
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:30 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFm-0004O9-Pl
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:29 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0abca97c0so1036586a91.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790466985; x=1791071785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bzXbNAmr51YidYXbmZg8Y0lX6KNq+4GQ5EKwzzDhIKw=;
 b=D+N+ZoyJarPmZqrvxZusthbIQhaXttRSk63DD25u2sstvl6btYZtj6oWLC15ggjpaR
 2OtO4kGZZcPT8b8rNprIa4aku87UmAPljj1DkAeQhXD4Jl4bmyUkVtsc4emkRzKvodiT
 jeeI4Dmn4f0qYMiKzYyihWcRuQah0XCkoY49Udoj9X8Eyd3m/2K53GL4Y1fpfBpmRxv/
 Q/yrvNADnU4GkS/oFBnLKke7WCQ7/iPbltOBzNF+oHMyYM8GKCl9PFLINNjv9vwZltEv
 QzMnCD1ggc4UdYtehGbTFmjpa85djfsylF6rcME0KJMyAXfkGiw/BAvLfHyzpX3edSeI
 utJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790466985; x=1791071785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bzXbNAmr51YidYXbmZg8Y0lX6KNq+4GQ5EKwzzDhIKw=;
 b=eBpFupy86WykIHQlRXe4E8moTV7+Sm4ybpJZYpa18nl781/l2R0UMDcgGkyBxyjAag
 KwKsQi836zliHXqPAxrAkKCkpoGSYv/oe8wT1dSnrMUa/UX32xVo7fHd/+BbH/ugQCX4
 Jxj02dr2AxY5f8lAj5hCmtiCVj2mbZBXR/Pb0RyvF+RSNm0KwbQUP/dwZGh0+PtPJGF/
 lr76RR7sugXlgkd35MQcEfAdwFHAGAJLFM31/DuBhIZshS2EEO44mVJlTEPNAbz//K7d
 1R8iw+AqK8nM4poTuqVsExAa5fHcGU0/xrcE7fhrD/NYCIlLAwuOGqE/eHxuDbb8oxOL
 6NqQ==
X-Gm-Message-State: AFq9FYLDunouggXtmJiX2bVC4VuUHee5HBT8m0HmGu9oW4d09g8GqU5B
 Tzx+1q5AHSQMX107iPhDNvml3wIOBjD2LlYFUGNzs+LxEShdQ8yHoSqGOpNB5CJF1jaDP6Re8HY
 x1LQY
X-Gm-Gg: AYBFou0VYPPCXnH7cPsdQzhNY+QXzOUuTsThzIX8alXURTU1cK6hdZhKlgHFd/4s2y0
 UN0EDQW7QvfcE2dNwcO5S/mdIEPnOC/bRxSf3xvDYB5kAIWEseqCFUoru3mm9xUVKm6FxexgZRU
 x4YgSvXe7IVtckncuNJDkbTQjrfuNGktYFo+xbwgvXgDUIKz2Gzirr0dVHkTrTvJwryJMtP7TiM
 zN7h19WO6vmTvsmBr0VIw36pXQV2swvFpUtqypRSFrB1kgj9duMXZuykvvUdl+kVIyNtXD0T/o4
 IidV/QNqEkcIyGFYb2dGJ5s/wT8dO1aj7LSgbTYPPEguujHdgHEoLrMTLJphLMXc5GGZ7gb6jSY
 rXvFSpFz7q3pLMSsCn0ivrb0ajq8UZmwlt9lE5ZhFZKVyfgPfn5jD/eepUTGZP9E57j6eygfIl4
 cCTeko9OWJmaJspTh/Pb7rimAltPBAF892tr6uI60XT/B2xs68b7z7R7hfA5jmlAUyoBK8LV9q3
 fkPXkBCmAOZwtyz3tJP2isRMt5RAQ==
X-Received: by 2002:a17:90b:57c6:b0:3a0:22bd:6ef6 with SMTP id
 98e67ed59e1d1-3a09853a6cdmr6761865a91.2.1790466985168; 
 Sat, 26 Sep 2026 16:56:25 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09773e7c3sm18136031a91.17.2026.09.26.16.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:56:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: paul@galbraiths.ca,
	pbonzini@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH v4 1/3] target/i386/tcg: Add DisasContext.pc_save_valid
Date: Sat, 26 Sep 2026 16:56:18 -0700
Message-ID: <20260926235620.851099-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926235620.851099-1-richard.henderson@linaro.org>
References: <20260926235620.851099-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use a separate bool rather than overloading -1,
which is a perfectly valid value for pc.

Cc: qemu-stable@nongnu.org
Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 192cf43215e..a38cc2c15d0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -95,6 +95,7 @@ typedef struct DisasContext {
     int8_t override; /* -1 if no override, else R_CS, R_DS, etc */
     uint8_t prefix;
 
+    bool pc_save_valid;
     bool has_modrm;
     uint8_t modrm;
 
@@ -471,7 +472,7 @@ static void gen_add_A0_im(DisasContext *s, int val)
 static inline void gen_op_jmp_v(DisasContext *s, TCGv dest)
 {
     tcg_gen_mov_tl(cpu_eip, dest);
-    s->pc_save = -1;
+    s->pc_save_valid = false;
 }
 
 static inline void gen_op_add_reg(DisasContext *s, MemOp size, int reg, TCGv val)
@@ -506,7 +507,7 @@ static inline void gen_op_st_v(DisasContext *s, int idx, TCGv t0, TCGv a0)
 
 static void gen_update_eip_next(DisasContext *s)
 {
-    assert(s->pc_save != -1);
+    assert(s->pc_save_valid);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
     } else if (CODE64(s)) {
@@ -519,7 +520,7 @@ static void gen_update_eip_next(DisasContext *s)
 
 static void gen_update_eip_cur(DisasContext *s)
 {
-    assert(s->pc_save != -1);
+    assert(s->pc_save_valid);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->base.pc_next - s->pc_save);
     } else if (CODE64(s)) {
@@ -542,7 +543,7 @@ static TCGv_i32 cur_insn_len_i32(DisasContext *s)
 
 static TCGv_i32 eip_next_i32(DisasContext *s)
 {
-    assert(s->pc_save != -1);
+    assert(s->pc_save_valid);
     /*
      * This function has two users: lcall_real (always 16-bit mode), and
      * iret_protected (16, 32, or 64-bit mode).  IRET only uses the value
@@ -566,7 +567,7 @@ static TCGv_i32 eip_next_i32(DisasContext *s)
 
 static TCGv eip_next_tl(DisasContext *s)
 {
-    assert(s->pc_save != -1);
+    assert(s->pc_save_valid);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         TCGv ret = tcg_temp_new();
         tcg_gen_addi_tl(ret, cpu_eip, s->pc - s->pc_save);
@@ -580,7 +581,7 @@ static TCGv eip_next_tl(DisasContext *s)
 
 static TCGv eip_cur_tl(DisasContext *s)
 {
-    assert(s->pc_save != -1);
+    assert(s->pc_save_valid);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         TCGv ret = tcg_temp_new();
         tcg_gen_addi_tl(ret, cpu_eip, s->base.pc_next - s->pc_save);
@@ -3433,6 +3434,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     dc->cs_base = dc->base.tb->cs_base;
     dc->pc_save = dc->base.pc_next;
+    dc->pc_save_valid = true;
     dc->flags = flags;
 #ifndef CONFIG_USER_ONLY
     dc->cpl = cpl;
-- 
2.53.0


