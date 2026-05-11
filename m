Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BDCCD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRD9-0004Ew-CT; Mon, 11 May 2026 10:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCL-0003xY-By
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCH-00065E-3r
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:28 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-67e09232daeso2654647eaf.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508079; x=1779112879; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=flsMkxVZdaULEyDvpuorZkfSVk5CbpOpC/8S7Sou9gw=;
 b=Uit0JQ98woHF3vWhoYDY3Zv+8vnXerk2SDFr9MNuOF98bhz7vPEQijJIOAgfc7FarG
 j3i9jhrHeulnjL6oGRKPpw/Qhh3RMf58hcIuh8f6U5aNUoo+Z1Z2Ojz969aUtEk/qXLd
 Mb/gJwjxL7vPvz256r0fw3EG4gtOZypO/sIBo1vAb+yIrMfBr3azjVI7BOozhaSGUBTo
 V3c2bjtVatz47DunrJmVGcQ2sno+y1J5biBV5usFb4E+1vujIXxJu/DJ1sdFmBYbq+NX
 4cSWxAKAtmbfyE3T6bgaEHZ/9CDGWPi5s3PIpsAlT5ymIgZNvc0StlibEv1wmL9YkX+7
 mFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508079; x=1779112879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=flsMkxVZdaULEyDvpuorZkfSVk5CbpOpC/8S7Sou9gw=;
 b=prTF71MbUeThUT/wpAkELIjr7FRoiPYZSfGV96XELBDpCo8X0ObZMK4CsBtEqAked5
 irqIDvVEUclnwSavyhvZ82s0S9FwcW9QYx5BJXxH22TWDk9CAAH4JYwdae7Mj+ewWH42
 ixN2rtwVo3M4Pg37Vsu2PII/oTTMdRSYTF2Qzlq6A9RS73wjtDdN/Z/wDdk8puWB20pk
 mzV/KHbWeWJfpsZacMKr/qJlaV3E506FsNTGpwXfWkItC1Wjbjts4a8FVHVVv+gyJzs4
 I/CrHld2/u3eTGk8UGOyZxMCyJqirmorQSvNh9YYiDYTwpDkssqfCpB10SedierNaaYQ
 ebzQ==
X-Gm-Message-State: AOJu0Ywdrc/UaMaTARDaVKSoS3K1QNwz2zvHBL5mHUTtKE5A933QR7Qt
 of4jyW8MMOc7NpBajn44exzfqBwzL2fO7ce6RRBrBhG4PIyCnvX0IsLr
X-Gm-Gg: Acq92OGGSyMk51y8KC9KGDWv8N9yCO6KTTVQgebPrQADxV1COQKp35LHQTCJDkQoP97
 IblBfV9diQcMhycrkzbPVH5Hg+Rfyf0O1r8suFHyTtmlOtrkr4SI/QvAh+F04jmpcjM3tnahnHr
 9cthrXeM8417F+ZaNMMcZN1noKOqgwIpi+AjPzQG1/giBCKZjtOHuaRm5OUp9FxCVpANnPE5ctY
 6HRzFYcfdI9N3JRCp5F8iwW0gsO3+QddwbbHyiMzEShW2v1NWrOMVfiTiN8Jhf4ztwvNnF2M56Q
 vyuOzcpWgQT/SeydFNXsNdKygRf7tEFrlRdd7lRQEpP2lNZxo4SwJwOUJe1n+Eyk9SNULZWxKYe
 mFE1ftTt1goJRZjp4qaA/9k/CIwTqXmHnxLVo5RJ/IZKbqndhlrNVzHuwG8RHnyxEu+JQ3mXeYB
 NgWcdZdHFNLaiQl0qN08tvm17y9fFtf48aTJ7Ay8H+
X-Received: by 2002:a05:6820:3383:10b0:69b:569b:e64b with SMTP id
 006d021491bc7-69b569bee6emr1282078eaf.40.1778508079065; 
 Mon, 11 May 2026 07:01:19 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:18 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:07 -0400
Subject: [PATCH v6 09/15] target/arm: load on canonical tag loads ext bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-9-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=4361;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=+Y8JKofNZz02HbynA8gMOZLU9OEkRKp61GT6ZG95lao=;
 b=upB0YcqqUbet/AhhWv5Cqx/DisGx8mgiNKBWp1TWKod6ufddZUnqQZUcLuAEPqgT0swfSwy9k
 lKZxdtyWgsrBXvC5Tj/WVmX4f+3ZIA2XendeCR/jW91Wi7aebtrqyB2
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Loading tags from canonically tagged regions should use the canonical
tags (extension bits), not allocation tags. See AArch64_MemTagRead().

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/helper-a64-defs.h |  4 ++--
 target/arm/tcg/mte_helper.c      | 14 ++++++++++++--
 target/arm/tcg/translate-a64.c   |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 3c3c5dddb7..c08c8c3991 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -102,14 +102,14 @@ DEF_HELPER_FLAGS_3(mte_check, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
-DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(ldg, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
 DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(ldgm, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index d35e3ef04d..c382f0149f 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -304,7 +304,7 @@ int load_tag1(uint64_t ptr, uint8_t *mem)
     return extract32(*mem, ofs, 4);
 }
 
-uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
@@ -317,6 +317,9 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
     /* Load if page supports tags. */
     if (mem) {
         rtag = load_tag1(ptr, mem);
+    } else if (mtx) {
+        uint64_t bit55 = extract64(ptr, 55, 1);
+        rtag = 0xF * bit55;
     }
 
     return address_with_allocation_tag(xt, rtag);
@@ -458,7 +461,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
     }
 }
 
-uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
+uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
@@ -476,6 +479,13 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
     /* The tag is squashed to zero if the page does not support tags.  */
     if (!tag_mem) {
+        /* Load canonical value if mtx is set (untagged memory region) */
+        if (mtx) {
+            bool bit55 = extract64(ptr, 55, 1);
+            ret = extract64(-bit55, 0, 1 << gm_bs);
+            shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
+            return ret << shift;
+        }
         return 0;
     }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cd86178d56..5fbc54de4b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4711,7 +4711,7 @@ static bool trans_LDGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_ldgm(tcg_rt, tcg_env, addr);
+        gen_helper_ldgm(tcg_rt, tcg_env, addr, tcg_constant_i32(s->mtx));
     } else {
         MMUAccessType acc = MMU_DATA_LOAD;
         int size = 4 << s->gm_blocksize;
@@ -4746,7 +4746,7 @@ static bool trans_LDG(DisasContext *s, arg_ldst_tag *a)
     tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
     tcg_rt = cpu_reg(s, a->rt);
     if (s->ata[0]) {
-        gen_helper_ldg(tcg_rt, tcg_env, addr, tcg_rt);
+        gen_helper_ldg(tcg_rt, tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     } else {
         /*
          * Tag access disabled: we must check for aborts on the load

-- 
2.54.0


