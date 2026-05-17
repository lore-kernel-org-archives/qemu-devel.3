Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422A7CD4F49
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSy-0001Wu-AN; Sat, 16 May 2026 20:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS6-0006wq-1c
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:55 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS3-0006pO-5S
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:52 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso421672a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978029; x=1779582829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeHqaA4eUNZ/cnZls9YTWTYizcqfhEo9ShP2VlzzQbM=;
 b=YGaBvQVz8ec3BVLT9ThJistVJyRKVGMDiGYrFg5fmSfo8qGBs8jqGPI+xfM8vOgCoB
 XsQ9oLEXZxZN5rHTkoU5VOA/FHkBjB7j+7fLcdqq2d5A7Bf93hwgGThM7YAEqw5B3eai
 PE07FiP7rMbxCoezHG9gVZAEHoBDBjC7CYb1180XreTsys/kkkbd2NuTmX9M3hwe3aec
 wmj1xjze2lq/dbovaDln7sC+Lleh4o2AHh99+831465xfqGnPRkTNbTeSA6/UNzZJQTt
 6je92y8z6DPWcymAaVRNgFZp/ZkloZQHGA8mFDQhcJ/WjNoQa2mMP2EGY2q0CDaREwBo
 opFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978029; x=1779582829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeHqaA4eUNZ/cnZls9YTWTYizcqfhEo9ShP2VlzzQbM=;
 b=GH6EdDquXO72DR+yiShpBDXLClvu4HCfr+E0xLMlg2gSeO6J4Z11Y0tCqXT6H/IR1b
 vueRDptPfSHGztzr3EGNWgqW033H0BebkJ2t/dVVze/M32dKCMwArI+J7T0g+JtjtteE
 6+HN2KoW42uRF4pyGVKCxg3FDOG5c6szkufoOMwBOhydr9HuuMBkg2tPHGTFJN9GTN5E
 VTPfHk/Hgc2/CQywSy194etqQvXh4OqOyAiqjE/cfRv9BKoUV3R1yellW6xulYp00XrK
 c+ON9Cw7lwmY1WIE6Z6lwdTh6Sim+DJTCdQwLNBQn/6Y2KnrUZ5hx5cYLHV+yFE4TsAK
 lE7w==
X-Gm-Message-State: AOJu0YyYwC/JSZ1F3ICt6rsTTt5hjQoJMAwWr9KnYKDbC4ad9+D5fE68
 vbRFUXPnKYRry2Bmy/SzTsimkj6optdN38yoGwCT5LSKl3hznlx+ZI4X5uOvJK8FuYjba9QE2kw
 fofZH
X-Gm-Gg: Acq92OGRzNXhmcrbBWW4+6zbZ+KVu9mfSo+sVcQxMa0+yrb+1eG/8eTvpz5nt5UBbLK
 5VUNxdyyG1zBx4+Q/xorTLpR7YtUDF0DkskZZnFR7Lv3ODEIMGfcOzDp5xEoFZsoN3iPDm/LNM5
 gTcVfw0RT2rCUr/7sHfJsr6HpNxAFZMoVNGYpxnU5vSOwrUPlkBG7Whug1OGLWIRjM0NiCzpCPV
 Gs4eE0zc81IyazOO1jYabBiAfra9ofsw1Qc4CRoIYze5I8ILAKdnbo6H9VKsGcOB80U/CNvEmuL
 +qwhUEJV5fA/EAnhADnLmYeNi+vK9wOvsirRbVGr5qR5ZotSmp9cD26V0mfDt7mtImUh9k2yxry
 ckn+bk6d7M7vsCsWOK+yI2QOJcTlGWRBH4a2JlBnEugu4M/pvfFsrizBitxtVuqhVi/7Ms251+G
 vzsLaHGoa5e7fngdlU3PSveTkP79j97CNSs4IdtD0=
X-Received: by 2002:a05:6a20:3ba9:b0:3a2:d79c:416c with SMTP id
 adf61e73a8af0-3b22ebcaf08mr8225101637.32.1778978028853; 
 Sat, 16 May 2026 17:33:48 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 48/63] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Sat, 16 May 2026 17:29:47 -0700
Message-ID: <20260517003002.321430-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index aa785fa0c3..e23ca43f55 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8369,3 +8369,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


