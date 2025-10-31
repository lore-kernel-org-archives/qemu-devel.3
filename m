Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D28ACCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEeew-0005FE-13; Thu, 30 Oct 2025 22:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vEeeu-0005EF-LK
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:14:32 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vEeek-0005vN-71
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:14:32 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-430abca3354so15829195ab.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761876858; x=1762481658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHBh4sfMHS3WxddSSw4wXbBZtVAKEG+HZPV0N4S5SJU=;
 b=ac0zpk+rHxUCvORhMNycoC2DotsoeKUL3s5hMC34M6rEtNg7vtmXPYr9GP/piXiK+x
 7R0fERQI74Qqw9myXJXXBOjfqpM4my0zzOjsit62F+qFV2sAwZijdox3CCqc2nX5T38A
 Rhr22q/xggWAKbQNdceFBIVFGhBa6zuC+lvY5qN9C6J1as8e2eG2yZRvjZGgg5S3qu7G
 usDmkX0I7T+Gw82Rr3j758UyofGWT0lloimSrXDZBcTsrej3S+xq/JHb8d5+RXYg2kCj
 DSM5B0YZsDSbkj0onf5KLE+s/j//VAi4ePSNDdzP+ZfexJfG4pT03BOQmNSPBtfhbLRd
 9KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761876858; x=1762481658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHBh4sfMHS3WxddSSw4wXbBZtVAKEG+HZPV0N4S5SJU=;
 b=HtWtSgSjAlpCv9CjLyNlsusSX6EZlxk/ePOSRpoQcfivYCrbq+Zy7WAE9R2ixHe4Tu
 aeUJkJCeCoa4Jr5/rF3owMPUSrXcSoshkehVd3xwI4Fh6QVTyE565ocKLQS07gehnzJs
 jtEffHkpnq3yf258jxyemAavEfn/cvoLbGAvF+IUcPw1eQ+SIiiyd9YvZHycHLituluB
 sFmBsHeGsQlyduX+3qMiPXQQxWb0DmbToPTZQDWbS5k63fepMnkE3MjjYkIwClwpfKcw
 9mIIhW8eImar4WbxX08S5MeI+iBNRBYhX3rA9bpL+Ygyw1jTj+SDG3tsIGz/DbLNTHuX
 URbQ==
X-Gm-Message-State: AOJu0Yyj+HfBFagrWAOaNz4U0FJKJP03Cuyx+P13ZACgM+KX5vG+bdm5
 bLtsdTYHrbw6Ayb2ymvG6hVg81gm1jL8sRbU/hC4Y42GWILr6NcoSmsqJTt4c/gI9i8=
X-Gm-Gg: ASbGnctZPBuVP6pwr6QEObeSmAxM/BR0THObRckKdSJ0JdgW0BhNCJBK5IfoqxmClm6
 4preII/XxraBHxcc2OfZ8qUPnsP9FXgo+mNXM85WZ1QcisKAvy+UkK0cGSbIPJeVJzcsloKplNO
 Qpfx6DsuLWD1QHZetbqORLttnc32K/kTugWBeDX/HfKatGayQgu69/KM7G+VFEglHJmlHjGXAiB
 hsyERrHQ2ClsozloSGPw7MBaTFifXlCNElgyUQbo8l2umuIAipt6EwBzvKFRO4EsnciUFpodz1A
 vjnGBfYdsr9hNTf48iAbkjqpsvTAgQ4HAmf48ru5cwOmTYsO6xSM71STsCt8qXcSZRCye/Vai8Z
 8gQq5H9noqj7pYiPDM7BVvJeu1GLfTNCAvFN1+MElaSHbDxa94br2YiBUpglrocofBgPZUUeTg7
 n4311NiNjRzVqVRgkllM9njoP8zGFgO84OO7Thl8FvUjn3RvepqGbdxq5yk6QYc2YcQA==
X-Google-Smtp-Source: AGHT+IE//aCgl7j94hWzj/ZdRmq1GEPtphVAfqFnu4umviUlRNtl6d9lFjgzrlTY8ppXpiqzX2DEag==
X-Received: by 2002:a05:6e02:1d9d:b0:42d:86f3:a2d1 with SMTP id
 e9e14a558f8ab-4330d1c9dc2mr30966255ab.25.1761876857600; 
 Thu, 30 Oct 2025 19:14:17 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-43310274e21sm1631055ab.9.2025.10.30.19.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 19:14:16 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 1/2] Hexagon (target/hexagon) Add pkt_need_commit argument to
 arch_fpop_end
Date: Thu, 30 Oct 2025 20:14:10 -0600
Message-ID: <20251031021411.111365-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031021411.111365-1-ltaylorsimpson@gmail.com>
References: <20251031021411.111365-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x132.google.com
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

The arch_fpop_end function converts the softfloat fp_status flags to
bits set in Hexagon USR.  It is hard-coded that the packet must need
a commit.  We add an argument to the function and update all the helper
call sites.

In a subsequent commit, we will change the code that forces a commit
when the packet contains an floating point instruction.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/arch.h              |   2 +-
 target/hexagon/gen_tcg.h           | 114 ++++++------
 target/hexagon/helper.h            | 114 ++++++------
 target/hexagon/arch.c              |   3 +-
 target/hexagon/op_helper.c         | 287 +++++++++++++++++------------
 target/hexagon/gen_helper_funcs.py |   8 +-
 target/hexagon/gen_tcg_funcs.py    |   4 +
 7 files changed, 294 insertions(+), 238 deletions(-)

diff --git a/target/hexagon/arch.h b/target/hexagon/arch.h
index 70918065d3..c295a86600 100644
--- a/target/hexagon/arch.h
+++ b/target/hexagon/arch.h
@@ -28,7 +28,7 @@ uint64_t interleave(uint32_t odd, uint32_t even);
 uint64_t deinterleave(uint64_t src);
 int32_t conv_round(int32_t a, int n);
 void arch_fpop_start(CPUHexagonState *env);
-void arch_fpop_end(CPUHexagonState *env);
+void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit);
 int arch_sf_recip_common(float32 *Rs, float32 *Rt, float32 *Rd,
                          int *adjust, float_status *fp_status);
 int arch_sf_invsqrt_common(float32 *Rs, float32 *Rd, int *adjust,
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 8a3b801287..f17eac2f1a 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -613,7 +613,7 @@
 #define fGEN_TCG_F2_sfrecipa(SHORTCODE) \
     do { \
         TCGv_i64 tmp = tcg_temp_new_i64(); \
-        gen_helper_sfrecipa(tmp, tcg_env, RsV, RtV);  \
+        gen_helper_sfrecipa(tmp, tcg_env, RsV, RtV, pkt_need_commit);  \
         tcg_gen_extrh_i64_i32(RdV, tmp); \
         tcg_gen_extrl_i64_i32(PeV, tmp); \
     } while (0)
@@ -628,7 +628,7 @@
 #define fGEN_TCG_F2_sfinvsqrta(SHORTCODE) \
     do { \
         TCGv_i64 tmp = tcg_temp_new_i64(); \
-        gen_helper_sfinvsqrta(tmp, tcg_env, RsV); \
+        gen_helper_sfinvsqrta(tmp, tcg_env, RsV, pkt_need_commit); \
         tcg_gen_extrh_i64_i32(RdV, tmp); \
         tcg_gen_extrl_i64_i32(PeV, tmp); \
     } while (0)
@@ -1204,122 +1204,122 @@
 
 /* Floating point */
 #define fGEN_TCG_F2_conv_sf2df(SHORTCODE) \
-    gen_helper_conv_sf2df(RddV, tcg_env, RsV)
+    gen_helper_conv_sf2df(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2sf(SHORTCODE) \
-    gen_helper_conv_df2sf(RdV, tcg_env, RssV)
+    gen_helper_conv_df2sf(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_uw2sf(SHORTCODE) \
-    gen_helper_conv_uw2sf(RdV, tcg_env, RsV)
+    gen_helper_conv_uw2sf(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_uw2df(SHORTCODE) \
-    gen_helper_conv_uw2df(RddV, tcg_env, RsV)
+    gen_helper_conv_uw2df(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_w2sf(SHORTCODE) \
-    gen_helper_conv_w2sf(RdV, tcg_env, RsV)
+    gen_helper_conv_w2sf(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_w2df(SHORTCODE) \
-    gen_helper_conv_w2df(RddV, tcg_env, RsV)
+    gen_helper_conv_w2df(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_ud2sf(SHORTCODE) \
-    gen_helper_conv_ud2sf(RdV, tcg_env, RssV)
+    gen_helper_conv_ud2sf(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_ud2df(SHORTCODE) \
-    gen_helper_conv_ud2df(RddV, tcg_env, RssV)
+    gen_helper_conv_ud2df(RddV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_d2sf(SHORTCODE) \
-    gen_helper_conv_d2sf(RdV, tcg_env, RssV)
+    gen_helper_conv_d2sf(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_d2df(SHORTCODE) \
-    gen_helper_conv_d2df(RddV, tcg_env, RssV)
+    gen_helper_conv_d2df(RddV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2uw(SHORTCODE) \
-    gen_helper_conv_sf2uw(RdV, tcg_env, RsV)
+    gen_helper_conv_sf2uw(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2w(SHORTCODE) \
-    gen_helper_conv_sf2w(RdV, tcg_env, RsV)
+    gen_helper_conv_sf2w(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2ud(SHORTCODE) \
-    gen_helper_conv_sf2ud(RddV, tcg_env, RsV)
+    gen_helper_conv_sf2ud(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2d(SHORTCODE) \
-    gen_helper_conv_sf2d(RddV, tcg_env, RsV)
+    gen_helper_conv_sf2d(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2uw(SHORTCODE) \
-    gen_helper_conv_df2uw(RdV, tcg_env, RssV)
+    gen_helper_conv_df2uw(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2w(SHORTCODE) \
-    gen_helper_conv_df2w(RdV, tcg_env, RssV)
+    gen_helper_conv_df2w(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2ud(SHORTCODE) \
-    gen_helper_conv_df2ud(RddV, tcg_env, RssV)
+    gen_helper_conv_df2ud(RddV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2d(SHORTCODE) \
-    gen_helper_conv_df2d(RddV, tcg_env, RssV)
+    gen_helper_conv_df2d(RddV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2uw_chop(SHORTCODE) \
-    gen_helper_conv_sf2uw_chop(RdV, tcg_env, RsV)
+    gen_helper_conv_sf2uw_chop(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2w_chop(SHORTCODE) \
-    gen_helper_conv_sf2w_chop(RdV, tcg_env, RsV)
+    gen_helper_conv_sf2w_chop(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2ud_chop(SHORTCODE) \
-    gen_helper_conv_sf2ud_chop(RddV, tcg_env, RsV)
+    gen_helper_conv_sf2ud_chop(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_sf2d_chop(SHORTCODE) \
-    gen_helper_conv_sf2d_chop(RddV, tcg_env, RsV)
+    gen_helper_conv_sf2d_chop(RddV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2uw_chop(SHORTCODE) \
-    gen_helper_conv_df2uw_chop(RdV, tcg_env, RssV)
+    gen_helper_conv_df2uw_chop(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2w_chop(SHORTCODE) \
-    gen_helper_conv_df2w_chop(RdV, tcg_env, RssV)
+    gen_helper_conv_df2w_chop(RdV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2ud_chop(SHORTCODE) \
-    gen_helper_conv_df2ud_chop(RddV, tcg_env, RssV)
+    gen_helper_conv_df2ud_chop(RddV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_conv_df2d_chop(SHORTCODE) \
-    gen_helper_conv_df2d_chop(RddV, tcg_env, RssV)
+    gen_helper_conv_df2d_chop(RddV, tcg_env, RssV, pkt_need_commit)
 #define fGEN_TCG_F2_sfadd(SHORTCODE) \
-    gen_helper_sfadd(RdV, tcg_env, RsV, RtV)
+    gen_helper_sfadd(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfsub(SHORTCODE) \
-    gen_helper_sfsub(RdV, tcg_env, RsV, RtV)
+    gen_helper_sfsub(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfcmpeq(SHORTCODE) \
-    gen_helper_sfcmpeq(PdV, tcg_env, RsV, RtV)
+    gen_helper_sfcmpeq(PdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfcmpgt(SHORTCODE) \
-    gen_helper_sfcmpgt(PdV, tcg_env, RsV, RtV)
+    gen_helper_sfcmpgt(PdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfcmpge(SHORTCODE) \
-    gen_helper_sfcmpge(PdV, tcg_env, RsV, RtV)
+    gen_helper_sfcmpge(PdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfcmpuo(SHORTCODE) \
-    gen_helper_sfcmpuo(PdV, tcg_env, RsV, RtV)
+    gen_helper_sfcmpuo(PdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfmax(SHORTCODE) \
-    gen_helper_sfmax(RdV, tcg_env, RsV, RtV)
+    gen_helper_sfmax(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfmin(SHORTCODE) \
-    gen_helper_sfmin(RdV, tcg_env, RsV, RtV)
+    gen_helper_sfmin(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sfclass(SHORTCODE) \
     do { \
         TCGv imm = tcg_constant_tl(uiV); \
-        gen_helper_sfclass(PdV, tcg_env, RsV, imm); \
+        gen_helper_sfclass(PdV, tcg_env, RsV, imm, pkt_need_commit); \
     } while (0)
 #define fGEN_TCG_F2_sffixupn(SHORTCODE) \
-    gen_helper_sffixupn(RdV, tcg_env, RsV, RtV)
+    gen_helper_sffixupn(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sffixupd(SHORTCODE) \
-    gen_helper_sffixupd(RdV, tcg_env, RsV, RtV)
+    gen_helper_sffixupd(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sffixupr(SHORTCODE) \
-    gen_helper_sffixupr(RdV, tcg_env, RsV)
+    gen_helper_sffixupr(RdV, tcg_env, RsV, pkt_need_commit)
 #define fGEN_TCG_F2_dfadd(SHORTCODE) \
-    gen_helper_dfadd(RddV, tcg_env, RssV, RttV)
+    gen_helper_dfadd(RddV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfsub(SHORTCODE) \
-    gen_helper_dfsub(RddV, tcg_env, RssV, RttV)
+    gen_helper_dfsub(RddV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfmax(SHORTCODE) \
-    gen_helper_dfmax(RddV, tcg_env, RssV, RttV)
+    gen_helper_dfmax(RddV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfmin(SHORTCODE) \
-    gen_helper_dfmin(RddV, tcg_env, RssV, RttV)
+    gen_helper_dfmin(RddV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfcmpeq(SHORTCODE) \
-    gen_helper_dfcmpeq(PdV, tcg_env, RssV, RttV)
+    gen_helper_dfcmpeq(PdV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfcmpgt(SHORTCODE) \
-    gen_helper_dfcmpgt(PdV, tcg_env, RssV, RttV)
+    gen_helper_dfcmpgt(PdV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfcmpge(SHORTCODE) \
-    gen_helper_dfcmpge(PdV, tcg_env, RssV, RttV)
+    gen_helper_dfcmpge(PdV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfcmpuo(SHORTCODE) \
-    gen_helper_dfcmpuo(PdV, tcg_env, RssV, RttV)
+    gen_helper_dfcmpuo(PdV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfclass(SHORTCODE) \
     do { \
         TCGv imm = tcg_constant_tl(uiV); \
-        gen_helper_dfclass(PdV, tcg_env, RssV, imm); \
+        gen_helper_dfclass(PdV, tcg_env, RssV, imm, pkt_need_commit); \
     } while (0)
 #define fGEN_TCG_F2_sfmpy(SHORTCODE) \
-    gen_helper_sfmpy(RdV, tcg_env, RsV, RtV)
+    gen_helper_sfmpy(RdV, tcg_env, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sffma(SHORTCODE) \
-    gen_helper_sffma(RxV, tcg_env, RxV, RsV, RtV)
+    gen_helper_sffma(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sffma_sc(SHORTCODE) \
-    gen_helper_sffma_sc(RxV, tcg_env, RxV, RsV, RtV, PuV)
+    gen_helper_sffma_sc(RxV, tcg_env, RxV, RsV, RtV, PuV, pkt_need_commit)
 #define fGEN_TCG_F2_sffms(SHORTCODE) \
-    gen_helper_sffms(RxV, tcg_env, RxV, RsV, RtV)
+    gen_helper_sffms(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sffma_lib(SHORTCODE) \
-    gen_helper_sffma_lib(RxV, tcg_env, RxV, RsV, RtV)
+    gen_helper_sffma_lib(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
 #define fGEN_TCG_F2_sffms_lib(SHORTCODE) \
-    gen_helper_sffms_lib(RxV, tcg_env, RxV, RsV, RtV)
+    gen_helper_sffms_lib(RxV, tcg_env, RxV, RsV, RtV, pkt_need_commit)
 
 #define fGEN_TCG_F2_dfmpyfix(SHORTCODE) \
-    gen_helper_dfmpyfix(RddV, tcg_env, RssV, RttV)
+    gen_helper_dfmpyfix(RddV, tcg_env, RssV, RttV, pkt_need_commit)
 #define fGEN_TCG_F2_dfmpyhh(SHORTCODE) \
-    gen_helper_dfmpyhh(RxxV, tcg_env, RxxV, RssV, RttV)
+    gen_helper_dfmpyhh(RxxV, tcg_env, RxxV, RssV, RttV, pkt_need_commit)
 
 /* Nothing to do for these in qemu, need to suppress compiler warnings */
 #define fGEN_TCG_Y4_l2fetch(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index f8baa599c8..64456822bc 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -24,72 +24,72 @@ DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
 DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
 DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_3(sfrecipa, i64, env, f32, f32)
-DEF_HELPER_2(sfinvsqrta, i64, env, f32)
+DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)
+DEF_HELPER_3(sfinvsqrta, i64, env, f32, i32)
 DEF_HELPER_5(vacsh_val, s64, env, s64, s64, s64, i32)
 DEF_HELPER_FLAGS_4(vacsh_pred, TCG_CALL_NO_RWG_SE, s32, env, s64, s64, s64)
 DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
 
 /* Floating point */
-DEF_HELPER_2(conv_sf2df, f64, env, f32)
-DEF_HELPER_2(conv_df2sf, f32, env, f64)
-DEF_HELPER_2(conv_uw2sf, f32, env, s32)
-DEF_HELPER_2(conv_uw2df, f64, env, s32)
-DEF_HELPER_2(conv_w2sf, f32, env, s32)
-DEF_HELPER_2(conv_w2df, f64, env, s32)
-DEF_HELPER_2(conv_ud2sf, f32, env, s64)
-DEF_HELPER_2(conv_ud2df, f64, env, s64)
-DEF_HELPER_2(conv_d2sf, f32, env, s64)
-DEF_HELPER_2(conv_d2df, f64, env, s64)
-DEF_HELPER_2(conv_sf2uw, i32, env, f32)
-DEF_HELPER_2(conv_sf2w, s32, env, f32)
-DEF_HELPER_2(conv_sf2ud, i64, env, f32)
-DEF_HELPER_2(conv_sf2d, s64, env, f32)
-DEF_HELPER_2(conv_df2uw, i32, env, f64)
-DEF_HELPER_2(conv_df2w, s32, env, f64)
-DEF_HELPER_2(conv_df2ud, i64, env, f64)
-DEF_HELPER_2(conv_df2d, s64, env, f64)
-DEF_HELPER_2(conv_sf2uw_chop, i32, env, f32)
-DEF_HELPER_2(conv_sf2w_chop, s32, env, f32)
-DEF_HELPER_2(conv_sf2ud_chop, i64, env, f32)
-DEF_HELPER_2(conv_sf2d_chop, s64, env, f32)
-DEF_HELPER_2(conv_df2uw_chop, i32, env, f64)
-DEF_HELPER_2(conv_df2w_chop, s32, env, f64)
-DEF_HELPER_2(conv_df2ud_chop, i64, env, f64)
-DEF_HELPER_2(conv_df2d_chop, s64, env, f64)
-DEF_HELPER_3(sfadd, f32, env, f32, f32)
-DEF_HELPER_3(sfsub, f32, env, f32, f32)
-DEF_HELPER_3(sfcmpeq, s32, env, f32, f32)
-DEF_HELPER_3(sfcmpgt, s32, env, f32, f32)
-DEF_HELPER_3(sfcmpge, s32, env, f32, f32)
-DEF_HELPER_3(sfcmpuo, s32, env, f32, f32)
-DEF_HELPER_3(sfmax, f32, env, f32, f32)
-DEF_HELPER_3(sfmin, f32, env, f32, f32)
-DEF_HELPER_3(sfclass, s32, env, f32, s32)
-DEF_HELPER_3(sffixupn, f32, env, f32, f32)
-DEF_HELPER_3(sffixupd, f32, env, f32, f32)
-DEF_HELPER_2(sffixupr, f32, env, f32)
+DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
+DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
+DEF_HELPER_3(conv_uw2sf, f32, env, s32, i32)
+DEF_HELPER_3(conv_uw2df, f64, env, s32, i32)
+DEF_HELPER_3(conv_w2sf, f32, env, s32, i32)
+DEF_HELPER_3(conv_w2df, f64, env, s32, i32)
+DEF_HELPER_3(conv_ud2sf, f32, env, s64, i32)
+DEF_HELPER_3(conv_ud2df, f64, env, s64, i32)
+DEF_HELPER_3(conv_d2sf, f32, env, s64, i32)
+DEF_HELPER_3(conv_d2df, f64, env, s64, i32)
+DEF_HELPER_3(conv_sf2uw, i32, env, f32, i32)
+DEF_HELPER_3(conv_sf2w, s32, env, f32, i32)
+DEF_HELPER_3(conv_sf2ud, i64, env, f32, i32)
+DEF_HELPER_3(conv_sf2d, s64, env, f32, i32)
+DEF_HELPER_3(conv_df2uw, i32, env, f64, i32)
+DEF_HELPER_3(conv_df2w, s32, env, f64, i32)
+DEF_HELPER_3(conv_df2ud, i64, env, f64, i32)
+DEF_HELPER_3(conv_df2d, s64, env, f64, i32)
+DEF_HELPER_3(conv_sf2uw_chop, i32, env, f32, i32)
+DEF_HELPER_3(conv_sf2w_chop, s32, env, f32, i32)
+DEF_HELPER_3(conv_sf2ud_chop, i64, env, f32, i32)
+DEF_HELPER_3(conv_sf2d_chop, s64, env, f32, i32)
+DEF_HELPER_3(conv_df2uw_chop, i32, env, f64, i32)
+DEF_HELPER_3(conv_df2w_chop, s32, env, f64, i32)
+DEF_HELPER_3(conv_df2ud_chop, i64, env, f64, i32)
+DEF_HELPER_3(conv_df2d_chop, s64, env, f64, i32)
+DEF_HELPER_4(sfadd, f32, env, f32, f32, i32)
+DEF_HELPER_4(sfsub, f32, env, f32, f32, i32)
+DEF_HELPER_4(sfcmpeq, s32, env, f32, f32, i32)
+DEF_HELPER_4(sfcmpgt, s32, env, f32, f32, i32)
+DEF_HELPER_4(sfcmpge, s32, env, f32, f32, i32)
+DEF_HELPER_4(sfcmpuo, s32, env, f32, f32, i32)
+DEF_HELPER_4(sfmax, f32, env, f32, f32, i32)
+DEF_HELPER_4(sfmin, f32, env, f32, f32, i32)
+DEF_HELPER_4(sfclass, s32, env, f32, s32, i32)
+DEF_HELPER_4(sffixupn, f32, env, f32, f32, i32)
+DEF_HELPER_4(sffixupd, f32, env, f32, f32, i32)
+DEF_HELPER_3(sffixupr, f32, env, f32, i32)
 
-DEF_HELPER_3(dfadd, f64, env, f64, f64)
-DEF_HELPER_3(dfsub, f64, env, f64, f64)
-DEF_HELPER_3(dfmax, f64, env, f64, f64)
-DEF_HELPER_3(dfmin, f64, env, f64, f64)
-DEF_HELPER_3(dfcmpeq, s32, env, f64, f64)
-DEF_HELPER_3(dfcmpgt, s32, env, f64, f64)
-DEF_HELPER_3(dfcmpge, s32, env, f64, f64)
-DEF_HELPER_3(dfcmpuo, s32, env, f64, f64)
-DEF_HELPER_3(dfclass, s32, env, f64, s32)
+DEF_HELPER_4(dfadd, f64, env, f64, f64, i32)
+DEF_HELPER_4(dfsub, f64, env, f64, f64, i32)
+DEF_HELPER_4(dfmax, f64, env, f64, f64, i32)
+DEF_HELPER_4(dfmin, f64, env, f64, f64, i32)
+DEF_HELPER_4(dfcmpeq, s32, env, f64, f64, i32)
+DEF_HELPER_4(dfcmpgt, s32, env, f64, f64, i32)
+DEF_HELPER_4(dfcmpge, s32, env, f64, f64, i32)
+DEF_HELPER_4(dfcmpuo, s32, env, f64, f64, i32)
+DEF_HELPER_4(dfclass, s32, env, f64, s32, i32)
 
-DEF_HELPER_3(sfmpy, f32, env, f32, f32)
-DEF_HELPER_4(sffma, f32, env, f32, f32, f32)
-DEF_HELPER_5(sffma_sc, f32, env, f32, f32, f32, f32)
-DEF_HELPER_4(sffms, f32, env, f32, f32, f32)
-DEF_HELPER_4(sffma_lib, f32, env, f32, f32, f32)
-DEF_HELPER_4(sffms_lib, f32, env, f32, f32, f32)
+DEF_HELPER_4(sfmpy, f32, env, f32, f32, i32)
+DEF_HELPER_5(sffma, f32, env, f32, f32, f32, i32)
+DEF_HELPER_6(sffma_sc, f32, env, f32, f32, f32, f32, i32)
+DEF_HELPER_5(sffms, f32, env, f32, f32, f32, i32)
+DEF_HELPER_5(sffma_lib, f32, env, f32, f32, f32, i32)
+DEF_HELPER_5(sffms_lib, f32, env, f32, f32, f32, i32)
 
-DEF_HELPER_3(dfmpyfix, f64, env, f64, f64)
-DEF_HELPER_4(dfmpyhh, f64, env, f64, f64, f64)
+DEF_HELPER_4(dfmpyfix, f64, env, f64, f64, i32)
+DEF_HELPER_5(dfmpyhh, f64, env, f64, f64, f64, i32)
 
 /* Histogram instructions */
 DEF_HELPER_1(vhist, void, env)
diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
index d053d68487..e17e714a6a 100644
--- a/target/hexagon/arch.c
+++ b/target/hexagon/arch.c
@@ -222,9 +222,8 @@ void arch_fpop_start(CPUHexagonState *env)
         } \
     } while (0)
 
-void arch_fpop_end(CPUHexagonState *env)
+void arch_fpop_end(CPUHexagonState *env, bool pkt_need_commit)
 {
-    const bool pkt_need_commit = true;
     int flags = get_float_exception_flags(&env->fp_status);
     if (flags != 0) {
         SOFTFLOAT_TEST_FLAG(float_flag_inexact, FPINPF, FPINPE);
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e2e80ca7ef..554e7dd447 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -200,7 +200,8 @@ static float32 build_float32(uint8_t sign, uint32_t exp, uint32_t mant)
  * Since helpers can only return a single value, we pack the two results
  * into a 64-bit value.
  */
-uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV)
+uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                          uint32_t pkt_need_commit)
 {
     int32_t PeV = 0;
     float32 RdV;
@@ -217,11 +218,12 @@ uint64_t HELPER(sfrecipa)(CPUHexagonState *env, float32 RsV, float32 RtV)
         exp = SF_BIAS - (float32_getexp(RtV) - SF_BIAS) - 1;
         RdV = build_float32(extract32(RtV, 31, 1), exp, mant);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return ((uint64_t)RdV << 32) | PeV;
 }
 
-uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV)
+uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV,
+                            uint32_t pkt_need_commit)
 {
     int PeV = 0;
     float32 RdV;
@@ -238,7 +240,7 @@ uint64_t HELPER(sfinvsqrta)(CPUHexagonState *env, float32 RsV)
         exp = SF_BIAS - ((float32_getexp(RsV) - SF_BIAS) >> 1) - 1;
         RdV = build_float32(extract32(RsV, 31, 1), exp, mant);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return ((uint64_t)RdV << 32) | PeV;
 }
 
@@ -476,97 +478,108 @@ static void check_noshuf(CPUHexagonState *env, bool pkt_has_scalar_store_s1,
 #endif
 
 /* Floating point */
-float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV)
+float64 HELPER(conv_sf2df)(CPUHexagonState *env, float32 RsV,
+                           uint32_t pkt_need_commit)
 {
     float64 out_f64;
     arch_fpop_start(env);
     out_f64 = float32_to_float64(RsV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return out_f64;
 }
 
-float32 HELPER(conv_df2sf)(CPUHexagonState *env, float64 RssV)
+float32 HELPER(conv_df2sf)(CPUHexagonState *env, float64 RssV,
+                           uint32_t pkt_need_commit)
 {
     float32 out_f32;
     arch_fpop_start(env);
     out_f32 = float64_to_float32(RssV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return out_f32;
 }
 
-float32 HELPER(conv_uw2sf)(CPUHexagonState *env, int32_t RsV)
+float32 HELPER(conv_uw2sf)(CPUHexagonState *env, int32_t RsV,
+                           uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = uint32_to_float32(RsV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float64 HELPER(conv_uw2df)(CPUHexagonState *env, int32_t RsV)
+float64 HELPER(conv_uw2df)(CPUHexagonState *env, int32_t RsV,
+                           uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = uint32_to_float64(RsV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float32 HELPER(conv_w2sf)(CPUHexagonState *env, int32_t RsV)
+float32 HELPER(conv_w2sf)(CPUHexagonState *env, int32_t RsV,
+                          uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = int32_to_float32(RsV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float64 HELPER(conv_w2df)(CPUHexagonState *env, int32_t RsV)
+float64 HELPER(conv_w2df)(CPUHexagonState *env, int32_t RsV,
+                          uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = int32_to_float64(RsV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float32 HELPER(conv_ud2sf)(CPUHexagonState *env, int64_t RssV)
+float32 HELPER(conv_ud2sf)(CPUHexagonState *env, int64_t RssV,
+                           uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = uint64_to_float32(RssV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float64 HELPER(conv_ud2df)(CPUHexagonState *env, int64_t RssV)
+float64 HELPER(conv_ud2df)(CPUHexagonState *env, int64_t RssV,
+                           uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = uint64_to_float64(RssV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float32 HELPER(conv_d2sf)(CPUHexagonState *env, int64_t RssV)
+float32 HELPER(conv_d2sf)(CPUHexagonState *env, int64_t RssV,
+                          uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = int64_to_float32(RssV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float64 HELPER(conv_d2df)(CPUHexagonState *env, int64_t RssV)
+float64 HELPER(conv_d2df)(CPUHexagonState *env, int64_t RssV,
+                          uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = int64_to_float64(RssV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV)
+uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV,
+                            uint32_t pkt_need_commit)
 {
     uint32_t RdV;
     arch_fpop_start(env);
@@ -577,11 +590,12 @@ uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV)
     } else {
         RdV = float32_to_uint32(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV)
+int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV,
+                          uint32_t pkt_need_commit)
 {
     int32_t RdV;
     arch_fpop_start(env);
@@ -592,11 +606,12 @@ int32_t HELPER(conv_sf2w)(CPUHexagonState *env, float32 RsV)
     } else {
         RdV = float32_to_int32(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV)
+uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV,
+                            uint32_t pkt_need_commit)
 {
     uint64_t RddV;
     arch_fpop_start(env);
@@ -607,11 +622,12 @@ uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV)
     } else {
         RddV = float32_to_uint64(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV)
+int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV,
+                          uint32_t pkt_need_commit)
 {
     int64_t RddV;
     arch_fpop_start(env);
@@ -622,11 +638,12 @@ int64_t HELPER(conv_sf2d)(CPUHexagonState *env, float32 RsV)
     } else {
         RddV = float32_to_int64(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV)
+uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV,
+                            uint32_t pkt_need_commit)
 {
     uint32_t RdV;
     arch_fpop_start(env);
@@ -637,11 +654,12 @@ uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV)
     } else {
         RdV = float64_to_uint32(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV)
+int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV,
+                          uint32_t pkt_need_commit)
 {
     int32_t RdV;
     arch_fpop_start(env);
@@ -652,11 +670,12 @@ int32_t HELPER(conv_df2w)(CPUHexagonState *env, float64 RssV)
     } else {
         RdV = float64_to_int32(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV)
+uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV,
+                            uint32_t pkt_need_commit)
 {
     uint64_t RddV;
     arch_fpop_start(env);
@@ -667,11 +686,12 @@ uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV)
     } else {
         RddV = float64_to_uint64(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV)
+int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV,
+                          uint32_t pkt_need_commit)
 {
     int64_t RddV;
     arch_fpop_start(env);
@@ -682,11 +702,12 @@ int64_t HELPER(conv_df2d)(CPUHexagonState *env, float64 RssV)
     } else {
         RddV = float64_to_int64(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV)
+uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV,
+                                 uint32_t pkt_need_commit)
 {
     uint32_t RdV;
     arch_fpop_start(env);
@@ -697,11 +718,12 @@ uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV)
     } else {
         RdV = float32_to_uint32_round_to_zero(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV)
+int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV,
+                               uint32_t pkt_need_commit)
 {
     int32_t RdV;
     arch_fpop_start(env);
@@ -712,11 +734,12 @@ int32_t HELPER(conv_sf2w_chop)(CPUHexagonState *env, float32 RsV)
     } else {
         RdV = float32_to_int32_round_to_zero(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV)
+uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV,
+                                 uint32_t pkt_need_commit)
 {
     uint64_t RddV;
     arch_fpop_start(env);
@@ -727,11 +750,12 @@ uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV)
     } else {
         RddV = float32_to_uint64_round_to_zero(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV)
+int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV,
+                               uint32_t pkt_need_commit)
 {
     int64_t RddV;
     arch_fpop_start(env);
@@ -742,11 +766,12 @@ int64_t HELPER(conv_sf2d_chop)(CPUHexagonState *env, float32 RsV)
     } else {
         RddV = float32_to_int64_round_to_zero(RsV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV)
+uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV,
+                                 uint32_t pkt_need_commit)
 {
     uint32_t RdV;
     arch_fpop_start(env);
@@ -757,11 +782,12 @@ uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV)
     } else {
         RdV = float64_to_uint32_round_to_zero(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV)
+int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV,
+                               uint32_t pkt_need_commit)
 {
     int32_t RdV;
     arch_fpop_start(env);
@@ -772,11 +798,12 @@ int32_t HELPER(conv_df2w_chop)(CPUHexagonState *env, float64 RssV)
     } else {
         RdV = float64_to_int32_round_to_zero(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV)
+uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV,
+                                 uint32_t pkt_need_commit)
 {
     uint64_t RddV;
     arch_fpop_start(env);
@@ -787,11 +814,12 @@ uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV)
     } else {
         RddV = float64_to_uint64_round_to_zero(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV)
+int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV,
+                               uint32_t pkt_need_commit)
 {
     int64_t RddV;
     arch_fpop_start(env);
@@ -802,49 +830,54 @@ int64_t HELPER(conv_df2d_chop)(CPUHexagonState *env, float64 RssV)
     } else {
         RddV = float64_to_int64_round_to_zero(RssV, &env->fp_status);
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float32 HELPER(sfadd)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sfadd)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                      uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = float32_add(RsV, RtV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float32 HELPER(sfsub)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sfsub)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                      uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = float32_sub(RsV, RtV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-int32_t HELPER(sfcmpeq)(CPUHexagonState *env, float32 RsV, float32 RtV)
+int32_t HELPER(sfcmpeq)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                        uint32_t pkt_need_commit)
 {
     int32_t PdV;
     arch_fpop_start(env);
     PdV = f8BITSOF(float32_eq_quiet(RsV, RtV, &env->fp_status));
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(sfcmpgt)(CPUHexagonState *env, float32 RsV, float32 RtV)
+int32_t HELPER(sfcmpgt)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                        uint32_t pkt_need_commit)
 {
     int cmp;
     int32_t PdV;
     arch_fpop_start(env);
     cmp = float32_compare_quiet(RsV, RtV, &env->fp_status);
     PdV = f8BITSOF(cmp == float_relation_greater);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV)
+int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                        uint32_t pkt_need_commit)
 {
     int cmp;
     int32_t PdV;
@@ -852,38 +885,42 @@ int32_t HELPER(sfcmpge)(CPUHexagonState *env, float32 RsV, float32 RtV)
     cmp = float32_compare_quiet(RsV, RtV, &env->fp_status);
     PdV = f8BITSOF(cmp == float_relation_greater ||
                    cmp == float_relation_equal);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(sfcmpuo)(CPUHexagonState *env, float32 RsV, float32 RtV)
+int32_t HELPER(sfcmpuo)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                        uint32_t pkt_need_commit)
 {
     int32_t PdV;
     arch_fpop_start(env);
     PdV = f8BITSOF(float32_unordered_quiet(RsV, RtV, &env->fp_status));
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-float32 HELPER(sfmax)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sfmax)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                      uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = float32_maximum_number(RsV, RtV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float32 HELPER(sfmin)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sfmin)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                      uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = float32_minimum_number(RsV, RtV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV)
+int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV,
+                        uint32_t pkt_need_commit)
 {
     int32_t PdV = 0;
     arch_fpop_start(env);
@@ -903,100 +940,110 @@ int32_t HELPER(sfclass)(CPUHexagonState *env, float32 RsV, int32_t uiV)
         PdV = 0xff;
     }
     set_float_exception_flags(0, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-float32 HELPER(sffixupn)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sffixupn)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                         uint32_t pkt_need_commit)
 {
     float32 RdV = 0;
     int adjust;
     arch_fpop_start(env);
     arch_sf_recip_common(&RsV, &RtV, &RdV, &adjust, &env->fp_status);
     RdV = RsV;
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float32 HELPER(sffixupd)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sffixupd)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                         uint32_t pkt_need_commit)
 {
     float32 RdV = 0;
     int adjust;
     arch_fpop_start(env);
     arch_sf_recip_common(&RsV, &RtV, &RdV, &adjust, &env->fp_status);
     RdV = RtV;
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float32 HELPER(sffixupr)(CPUHexagonState *env, float32 RsV)
+float32 HELPER(sffixupr)(CPUHexagonState *env, float32 RsV,
+                         uint32_t pkt_need_commit)
 {
     float32 RdV = 0;
     int adjust;
     arch_fpop_start(env);
     arch_sf_invsqrt_common(&RsV, &RdV, &adjust, &env->fp_status);
     RdV = RsV;
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
-float64 HELPER(dfadd)(CPUHexagonState *env, float64 RssV, float64 RttV)
+float64 HELPER(dfadd)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                      uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = float64_add(RssV, RttV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float64 HELPER(dfsub)(CPUHexagonState *env, float64 RssV, float64 RttV)
+float64 HELPER(dfsub)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                      uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = float64_sub(RssV, RttV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float64 HELPER(dfmax)(CPUHexagonState *env, float64 RssV, float64 RttV)
+float64 HELPER(dfmax)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                      uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = float64_maximum_number(RssV, RttV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-float64 HELPER(dfmin)(CPUHexagonState *env, float64 RssV, float64 RttV)
+float64 HELPER(dfmin)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                      uint32_t pkt_need_commit)
 {
     float64 RddV;
     arch_fpop_start(env);
     RddV = float64_minimum_number(RssV, RttV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
-int32_t HELPER(dfcmpeq)(CPUHexagonState *env, float64 RssV, float64 RttV)
+int32_t HELPER(dfcmpeq)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                        uint32_t pkt_need_commit)
 {
     int32_t PdV;
     arch_fpop_start(env);
     PdV = f8BITSOF(float64_eq_quiet(RssV, RttV, &env->fp_status));
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(dfcmpgt)(CPUHexagonState *env, float64 RssV, float64 RttV)
+int32_t HELPER(dfcmpgt)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                        uint32_t pkt_need_commit)
 {
     int cmp;
     int32_t PdV;
     arch_fpop_start(env);
     cmp = float64_compare_quiet(RssV, RttV, &env->fp_status);
     PdV = f8BITSOF(cmp == float_relation_greater);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV)
+int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                        uint32_t pkt_need_commit)
 {
     int cmp;
     int32_t PdV;
@@ -1004,20 +1051,22 @@ int32_t HELPER(dfcmpge)(CPUHexagonState *env, float64 RssV, float64 RttV)
     cmp = float64_compare_quiet(RssV, RttV, &env->fp_status);
     PdV = f8BITSOF(cmp == float_relation_greater ||
                    cmp == float_relation_equal);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(dfcmpuo)(CPUHexagonState *env, float64 RssV, float64 RttV)
+int32_t HELPER(dfcmpuo)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                        uint32_t pkt_need_commit)
 {
     int32_t PdV;
     arch_fpop_start(env);
     PdV = f8BITSOF(float64_unordered_quiet(RssV, RttV, &env->fp_status));
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV)
+int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV,
+                        uint32_t pkt_need_commit)
 {
     int32_t PdV = 0;
     arch_fpop_start(env);
@@ -1037,51 +1086,55 @@ int32_t HELPER(dfclass)(CPUHexagonState *env, float64 RssV, int32_t uiV)
         PdV = 0xff;
     }
     set_float_exception_flags(0, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return PdV;
 }
 
-float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV)
+float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV,
+                      uint32_t pkt_need_commit)
 {
     float32 RdV;
     arch_fpop_start(env);
     RdV = float32_mul(RsV, RtV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RdV;
 }
 
 float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
-                      float32 RsV, float32 RtV)
+                      float32 RsV, float32 RtV,
+                      uint32_t pkt_need_commit)
 {
     arch_fpop_start(env);
     RxV = float32_muladd(RsV, RtV, RxV, 0, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RxV;
 }
 
 float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
-                         float32 RsV, float32 RtV, float32 PuV)
+                         float32 RsV, float32 RtV, float32 PuV,
+                         uint32_t pkt_need_commit)
 {
     arch_fpop_start(env);
     RxV = float32_muladd_scalbn(RsV, RtV, RxV, fSXTN(8, 64, PuV),
                                 float_muladd_suppress_add_product_zero,
                                 &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RxV;
 }
 
 float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
-                      float32 RsV, float32 RtV)
+                      float32 RsV, float32 RtV, uint32_t pkt_need_commit)
 {
     arch_fpop_start(env);
     RxV = float32_muladd(RsV, RtV, RxV, float_muladd_negate_product,
                          &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RxV;
 }
 
 static float32 do_sffma_lib(CPUHexagonState *env, float32 RxV,
-                            float32 RsV, float32 RtV, int negate)
+                            float32 RsV, float32 RtV, int negate,
+                            uint32_t pkt_need_commit)
 {
     int flags;
 
@@ -1103,23 +1156,25 @@ static float32 do_sffma_lib(CPUHexagonState *env, float32 RxV,
         }
     }
 
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RxV;
 }
 
 float32 HELPER(sffma_lib)(CPUHexagonState *env, float32 RxV,
-                          float32 RsV, float32 RtV)
+                          float32 RsV, float32 RtV, uint32_t pkt_need_commit)
 {
-    return do_sffma_lib(env, RxV, RsV, RtV, 0);
+    return do_sffma_lib(env, RxV, RsV, RtV, 0, pkt_need_commit);
 }
 
 float32 HELPER(sffms_lib)(CPUHexagonState *env, float32 RxV,
-                          float32 RsV, float32 RtV)
+                          float32 RsV, float32 RtV, uint32_t pkt_need_commit)
 {
-    return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_product);
+    return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_product,
+                        pkt_need_commit);
 }
 
-float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV)
+float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV,
+                         uint32_t pkt_need_commit)
 {
     int64_t RddV;
     arch_fpop_start(env);
@@ -1136,16 +1191,16 @@ float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV)
     } else {
         RddV = RssV;
     }
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RddV;
 }
 
 float64 HELPER(dfmpyhh)(CPUHexagonState *env, float64 RxxV,
-                        float64 RssV, float64 RttV)
+                        float64 RssV, float64 RttV, uint32_t pkt_need_commit)
 {
     arch_fpop_start(env);
     RxxV = internal_mpyhh(RssV, RttV, RxxV, &env->fp_status);
-    arch_fpop_end(env);
+    arch_fpop_end(env, pkt_need_commit);
     return RxxV;
 }
 
diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index a9c0e27a80..6206104424 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -84,11 +84,6 @@ def gen_helper_function(f, tag, tagregs, tagimms):
         {hex_common.semdict[tag]}
     """))
 
-    if "A_FPOP" in hex_common.attribdict[tag]:
-        f.write(hex_common.code_fmt(f"""\
-            arch_fpop_end(env);
-        """))
-
     ## Return the scalar result
     for regtype, regid in regs:
         reg = hex_common.get_register(tag, regtype, regid)
@@ -116,6 +111,9 @@ def main():
             ## Skip the guest instructions
             if "A_GUEST" in hex_common.attribdict[tag]:
                 continue
+            ## Skip the floating point instructions
+            if "A_FPOP" in hex_common.attribdict[tag]:
+                continue
             ## Skip the diag instructions
             if tag == "Y6_diag":
                 continue
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index c2ba91ddc0..91b6a1e9d0 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -77,6 +77,10 @@ def gen_tcg_func(f, tag, regs, imms):
         f.write(f"    emit_{tag}({arguments});\n")
 
     elif hex_common.skip_qemu_helper(tag):
+        if "A_FPOP" in hex_common.attribdict[tag]:
+            f.write("    TCGv pkt_need_commit = ")
+            f.write("tcg_constant_tl(ctx->need_commit);\n")
+
         f.write(f"    fGEN_TCG_{tag}({hex_common.semdict[tag]});\n")
     else:
         ## Generate the call to the helper
-- 
2.43.0


