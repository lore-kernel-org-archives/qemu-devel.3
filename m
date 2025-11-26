Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A247D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM2G-0002Te-Vm; Wed, 26 Nov 2025 15:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2F-0002Sg-7V
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:43 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2B-0002M1-Qk
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so753745e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188558; x=1764793358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAqfvsVIcjwHAuhiU/dToFTFFR2CADcUi9XfVzvrfd4=;
 b=FpfB+UXnujMSSXL8vuDIy/do6tTug+FyD/QLNIQBZk5hR1nJd/6UWLhdMYx1NFNL2U
 CSCuKf/+FTLBflSqPxJIJRdnJfNkjH8Ji+PwBhnVlxX43nZA5p2JkJXc0qk6HbDakgZR
 0IOtpBky76he1rUavwFgHmQ/RFX4DTNk9cGInFXXgcVjaD4VVxW6dbRDw0S6W+0vkIxq
 g2L37E2jow2l0UlejYCZEOue9IonRb2Tl2wIc1EXRVLgl/bqWb8/QOSafYGtOQ/Q+kEL
 1vFl2Ngm3W+RFib+gQkDj2bRvLNvqLvzK2xWziaENyS1Vx740oSyr1BVlJ+RYB00s0QF
 GOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188558; x=1764793358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dAqfvsVIcjwHAuhiU/dToFTFFR2CADcUi9XfVzvrfd4=;
 b=sNiBD3ezIW6Cqwps6SAcVfxuGINpL7Pj8sDDgGHa8cD5Y5e2fwpfkr/Gf2QEbbPv+h
 R4Hvr+sIV1hpNqxeMMqLvGcleAa4iup7ZYRplxw0h9eQjw4FcCQlBsXH7FC+2nvHuTIE
 K596BafA/ap4eegIRf6SGUiVGgidTP7DuKl+tNUcuajJw8pgfRFLE8ZHKJ2a7PaKOTDw
 CpX7al3bUSopPX+V2aGVuCrQOncPxUCAWkRq0inQJPEVKN/g2ch/dB3BsbnTlSiuNIzb
 5lJ6NUjUExB44Iy0NxTdq+p9jOL8cC6n8B6d9xtsdTw55dEw0NfLVXQgs85h42puNQ+M
 D2bQ==
X-Gm-Message-State: AOJu0Yy2Tg1vFRNTr6/cIdj9OJDdcPeb43qjRWmG57fg2d8ZgkqYw/r9
 8VExuDVQivMuxYQ2isotqBzi0er17Co9aY+McUk4GqofiGozAEFii1Lj0DNXVzUK6X4ZbE8D1+9
 VEKVjWGC2piIjzlA=
X-Gm-Gg: ASbGncs+aJHamzS73Sa4A5H14Kw0+vBlbmIyZfnjP933JhrVOiN4QgCbEIpcybWtrnr
 U+KyRZ588GTPywb09FhgWGe42JAH8oDbEtHcZ4WECDCPr1RF7vu5Vych3x0EGK4M2lBwVRJTyvy
 I64B5R+jX/B4q9iQFRZUlLFD1P1i3tZzQoe3Z6z9TDeogkqF5uEmmKdfZKIX/4PBMATObl6+I0d
 39lFNJrK00zbeC9CFfatAqjyjbg+Do+0he9bavkCSuX/q1cXGdnaVK1sGiR27AZsyoooA3QyPhI
 l0Jhx8UL8gnyOhNfHqxPn2tt+OSceY/qmIxlsM/SRTaoQEodxkAHY2W2B2nx6lUX4farOJDOvVi
 n4j2FmF6w4F0v+HHKhtCVzm5G4H32uMobxetzoq6ossTibr4xQABRshVDilbim2t2v1oP8oCjo2
 Nll1rd5vL1r4F3Vq1ZZR2odk5JHMBSayXyG3o2FPN5DqM75SwZ3iNkKR5FahEZ
X-Google-Smtp-Source: AGHT+IHHCw1zr++UZGhj5lhemx43tT0bRnF2hVouNOEDTVztXnT8TzFZmSG/itIcgtELXhB+lJFmDQ==
X-Received: by 2002:a05:600c:1c8a:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-47904acadd7mr88663525e9.7.1764188557821; 
 Wed, 26 Nov 2025 12:22:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052d9affsm49573545e9.4.2025.11.26.12.22.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH-for-11.0 v3 05/22] target/tricore: Use little-endian variant
 of cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 21:21:41 +0100
Message-ID: <20251126202200.23100-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only build the TriCore target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=tricore; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Then adapting spaces style manually to pass checkpatch.pl.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/op_helper.c | 152 ++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 2c8281a67e0..fde2c0f8383 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2451,84 +2451,84 @@ static bool cdc_zero(uint32_t *psw)
 
 static void save_context_upper(CPUTriCoreState *env, uint32_t ea)
 {
-    cpu_stl_data(env, ea, env->PCXI);
-    cpu_stl_data(env, ea+4, psw_read(env));
-    cpu_stl_data(env, ea+8, env->gpr_a[10]);
-    cpu_stl_data(env, ea+12, env->gpr_a[11]);
-    cpu_stl_data(env, ea+16, env->gpr_d[8]);
-    cpu_stl_data(env, ea+20, env->gpr_d[9]);
-    cpu_stl_data(env, ea+24, env->gpr_d[10]);
-    cpu_stl_data(env, ea+28, env->gpr_d[11]);
-    cpu_stl_data(env, ea+32, env->gpr_a[12]);
-    cpu_stl_data(env, ea+36, env->gpr_a[13]);
-    cpu_stl_data(env, ea+40, env->gpr_a[14]);
-    cpu_stl_data(env, ea+44, env->gpr_a[15]);
-    cpu_stl_data(env, ea+48, env->gpr_d[12]);
-    cpu_stl_data(env, ea+52, env->gpr_d[13]);
-    cpu_stl_data(env, ea+56, env->gpr_d[14]);
-    cpu_stl_data(env, ea+60, env->gpr_d[15]);
+    cpu_stl_le_data(env, ea, env->PCXI);
+    cpu_stl_le_data(env, ea + 4, psw_read(env));
+    cpu_stl_le_data(env, ea + 8, env->gpr_a[10]);
+    cpu_stl_le_data(env, ea + 12, env->gpr_a[11]);
+    cpu_stl_le_data(env, ea + 16, env->gpr_d[8]);
+    cpu_stl_le_data(env, ea + 20, env->gpr_d[9]);
+    cpu_stl_le_data(env, ea + 24, env->gpr_d[10]);
+    cpu_stl_le_data(env, ea + 28, env->gpr_d[11]);
+    cpu_stl_le_data(env, ea + 32, env->gpr_a[12]);
+    cpu_stl_le_data(env, ea + 36, env->gpr_a[13]);
+    cpu_stl_le_data(env, ea + 40, env->gpr_a[14]);
+    cpu_stl_le_data(env, ea + 44, env->gpr_a[15]);
+    cpu_stl_le_data(env, ea + 48, env->gpr_d[12]);
+    cpu_stl_le_data(env, ea + 52, env->gpr_d[13]);
+    cpu_stl_le_data(env, ea + 56, env->gpr_d[14]);
+    cpu_stl_le_data(env, ea + 60, env->gpr_d[15]);
 }
 
 static void save_context_lower(CPUTriCoreState *env, uint32_t ea)
 {
-    cpu_stl_data(env, ea, env->PCXI);
-    cpu_stl_data(env, ea+4, env->gpr_a[11]);
-    cpu_stl_data(env, ea+8, env->gpr_a[2]);
-    cpu_stl_data(env, ea+12, env->gpr_a[3]);
-    cpu_stl_data(env, ea+16, env->gpr_d[0]);
-    cpu_stl_data(env, ea+20, env->gpr_d[1]);
-    cpu_stl_data(env, ea+24, env->gpr_d[2]);
-    cpu_stl_data(env, ea+28, env->gpr_d[3]);
-    cpu_stl_data(env, ea+32, env->gpr_a[4]);
-    cpu_stl_data(env, ea+36, env->gpr_a[5]);
-    cpu_stl_data(env, ea+40, env->gpr_a[6]);
-    cpu_stl_data(env, ea+44, env->gpr_a[7]);
-    cpu_stl_data(env, ea+48, env->gpr_d[4]);
-    cpu_stl_data(env, ea+52, env->gpr_d[5]);
-    cpu_stl_data(env, ea+56, env->gpr_d[6]);
-    cpu_stl_data(env, ea+60, env->gpr_d[7]);
+    cpu_stl_le_data(env, ea, env->PCXI);
+    cpu_stl_le_data(env, ea + 4, env->gpr_a[11]);
+    cpu_stl_le_data(env, ea + 8, env->gpr_a[2]);
+    cpu_stl_le_data(env, ea + 12, env->gpr_a[3]);
+    cpu_stl_le_data(env, ea + 16, env->gpr_d[0]);
+    cpu_stl_le_data(env, ea + 20, env->gpr_d[1]);
+    cpu_stl_le_data(env, ea + 24, env->gpr_d[2]);
+    cpu_stl_le_data(env, ea + 28, env->gpr_d[3]);
+    cpu_stl_le_data(env, ea + 32, env->gpr_a[4]);
+    cpu_stl_le_data(env, ea + 36, env->gpr_a[5]);
+    cpu_stl_le_data(env, ea + 40, env->gpr_a[6]);
+    cpu_stl_le_data(env, ea + 44, env->gpr_a[7]);
+    cpu_stl_le_data(env, ea + 48, env->gpr_d[4]);
+    cpu_stl_le_data(env, ea + 52, env->gpr_d[5]);
+    cpu_stl_le_data(env, ea + 56, env->gpr_d[6]);
+    cpu_stl_le_data(env, ea + 60, env->gpr_d[7]);
 }
 
 static void restore_context_upper(CPUTriCoreState *env, uint32_t ea,
                                   uint32_t *new_PCXI, uint32_t *new_PSW)
 {
-    *new_PCXI = cpu_ldl_data(env, ea);
-    *new_PSW = cpu_ldl_data(env, ea+4);
-    env->gpr_a[10] = cpu_ldl_data(env, ea+8);
-    env->gpr_a[11] = cpu_ldl_data(env, ea+12);
-    env->gpr_d[8]  = cpu_ldl_data(env, ea+16);
-    env->gpr_d[9]  = cpu_ldl_data(env, ea+20);
-    env->gpr_d[10] = cpu_ldl_data(env, ea+24);
-    env->gpr_d[11] = cpu_ldl_data(env, ea+28);
-    env->gpr_a[12] = cpu_ldl_data(env, ea+32);
-    env->gpr_a[13] = cpu_ldl_data(env, ea+36);
-    env->gpr_a[14] = cpu_ldl_data(env, ea+40);
-    env->gpr_a[15] = cpu_ldl_data(env, ea+44);
-    env->gpr_d[12] = cpu_ldl_data(env, ea+48);
-    env->gpr_d[13] = cpu_ldl_data(env, ea+52);
-    env->gpr_d[14] = cpu_ldl_data(env, ea+56);
-    env->gpr_d[15] = cpu_ldl_data(env, ea+60);
+    *new_PCXI = cpu_ldl_le_data(env, ea);
+    *new_PSW = cpu_ldl_le_data(env, ea + 4);
+    env->gpr_a[10] = cpu_ldl_le_data(env, ea + 8);
+    env->gpr_a[11] = cpu_ldl_le_data(env, ea + 12);
+    env->gpr_d[8]  = cpu_ldl_le_data(env, ea + 16);
+    env->gpr_d[9]  = cpu_ldl_le_data(env, ea + 20);
+    env->gpr_d[10] = cpu_ldl_le_data(env, ea + 24);
+    env->gpr_d[11] = cpu_ldl_le_data(env, ea + 28);
+    env->gpr_a[12] = cpu_ldl_le_data(env, ea + 32);
+    env->gpr_a[13] = cpu_ldl_le_data(env, ea + 36);
+    env->gpr_a[14] = cpu_ldl_le_data(env, ea + 40);
+    env->gpr_a[15] = cpu_ldl_le_data(env, ea + 44);
+    env->gpr_d[12] = cpu_ldl_le_data(env, ea + 48);
+    env->gpr_d[13] = cpu_ldl_le_data(env, ea + 52);
+    env->gpr_d[14] = cpu_ldl_le_data(env, ea + 56);
+    env->gpr_d[15] = cpu_ldl_le_data(env, ea + 60);
 }
 
 static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
                                   uint32_t *ra, uint32_t *pcxi)
 {
-    *pcxi = cpu_ldl_data(env, ea);
-    *ra = cpu_ldl_data(env, ea+4);
-    env->gpr_a[2] = cpu_ldl_data(env, ea+8);
-    env->gpr_a[3] = cpu_ldl_data(env, ea+12);
-    env->gpr_d[0] = cpu_ldl_data(env, ea+16);
-    env->gpr_d[1] = cpu_ldl_data(env, ea+20);
-    env->gpr_d[2] = cpu_ldl_data(env, ea+24);
-    env->gpr_d[3] = cpu_ldl_data(env, ea+28);
-    env->gpr_a[4] = cpu_ldl_data(env, ea+32);
-    env->gpr_a[5] = cpu_ldl_data(env, ea+36);
-    env->gpr_a[6] = cpu_ldl_data(env, ea+40);
-    env->gpr_a[7] = cpu_ldl_data(env, ea+44);
-    env->gpr_d[4] = cpu_ldl_data(env, ea+48);
-    env->gpr_d[5] = cpu_ldl_data(env, ea+52);
-    env->gpr_d[6] = cpu_ldl_data(env, ea+56);
-    env->gpr_d[7] = cpu_ldl_data(env, ea+60);
+    *pcxi = cpu_ldl_le_data(env, ea);
+    *ra = cpu_ldl_le_data(env, ea + 4);
+    env->gpr_a[2] = cpu_ldl_le_data(env, ea + 8);
+    env->gpr_a[3] = cpu_ldl_le_data(env, ea + 12);
+    env->gpr_d[0] = cpu_ldl_le_data(env, ea + 16);
+    env->gpr_d[1] = cpu_ldl_le_data(env, ea + 20);
+    env->gpr_d[2] = cpu_ldl_le_data(env, ea + 24);
+    env->gpr_d[3] = cpu_ldl_le_data(env, ea + 28);
+    env->gpr_a[4] = cpu_ldl_le_data(env, ea + 32);
+    env->gpr_a[5] = cpu_ldl_le_data(env, ea + 36);
+    env->gpr_a[6] = cpu_ldl_le_data(env, ea + 40);
+    env->gpr_a[7] = cpu_ldl_le_data(env, ea + 44);
+    env->gpr_d[4] = cpu_ldl_le_data(env, ea + 48);
+    env->gpr_d[5] = cpu_ldl_le_data(env, ea + 52);
+    env->gpr_d[6] = cpu_ldl_le_data(env, ea + 56);
+    env->gpr_d[7] = cpu_ldl_le_data(env, ea + 60);
 }
 
 void helper_call(CPUTriCoreState *env, uint32_t next_pc)
@@ -2566,7 +2566,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2632,7 +2632,7 @@ void helper_ret(CPUTriCoreState *env)
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
@@ -2662,7 +2662,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     ea = ((env->FCX & 0xf0000) << 12) + ((env->FCX & 0xffff) << 6);
 
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, A[11], A[2], A[3], D[0], D[1], D[2], D[3], A[4]
                            , A[5], A[6], A[7], D[4], D[5], D[6], D[7]}; */
     save_context_lower(env, ea);
@@ -2726,7 +2726,7 @@ void helper_rfe(CPUTriCoreState *env)
       A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
     /* M(EA, word) = FCX;*/
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
@@ -2744,10 +2744,10 @@ void helper_rfm(CPUTriCoreState *env)
     icr_set_ccpn(env, pcxi_get_pcpn(env));
 
     /* {PCXI, PSW, A[10], A[11]} = M(DCX, 4 * word); */
-    env->PCXI = cpu_ldl_data(env, env->DCX);
-    psw_write(env, cpu_ldl_data(env, env->DCX+4));
-    env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
-    env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
+    env->PCXI = cpu_ldl_le_data(env, env->DCX);
+    psw_write(env, cpu_ldl_le_data(env, env->DCX+4));
+    env->gpr_a[10] = cpu_ldl_le_data(env, env->DCX+8);
+    env->gpr_a[11] = cpu_ldl_le_data(env, env->DCX+12);
 
     if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         env->DBGTCR = 0;
@@ -2794,7 +2794,7 @@ void helper_svlcx(CPUTriCoreState *env)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2837,7 +2837,7 @@ void helper_svucx(CPUTriCoreState *env)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2887,9 +2887,9 @@ void helper_rslcx(CPUTriCoreState *env)
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_lower(env, ea, &env->gpr_a[11], &new_PCXI);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
-- 
2.51.0


