Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9657CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIX-0007Fa-0V; Tue, 02 Jun 2026 23:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIE-0006pJ-2z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIC-0003kH-5l
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8422871b42dso2080840b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457359; x=1781062159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZVmPJQCSPqi58Jv5BnxHTf+Z6+QxTnKCJHuK8VCAuk=;
 b=ynCqUh6nhUCaFSucmGK4lG3bI0HfyK/6Q1IdzwMCNb1cMPvnGBIY6NNLBoQe336HTK
 9aRWp1B76AJpjMdhueiiJBVdXaqgzf9JRELj4x2i87/oB/eZCKO9paGhjC4TktMD8Y/g
 tefXdfLfMijyJs+x8vYPhgMNBKT9q1Hlx2CFQPU2S4p8u2Qv5t9k01Ob7m+36iiZ+uSi
 GUbsM5LkrkQ3kcuxgI8AEcuWGsemCGc6RgehFBqvLdoqUVVnVPTvPQb97J/yqM8O9aP/
 ir2Az2FiVWfGRbylKo4ADBYQzCQos6M8/LxINXEkeZW7LpRaZG2e6N6hqGJHPkRPK79T
 zM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457359; x=1781062159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kZVmPJQCSPqi58Jv5BnxHTf+Z6+QxTnKCJHuK8VCAuk=;
 b=GONikzryFXtfeRY/dWzwVHoudB3qJNEBvfIiH1Hp0xYTkqK9AtNkQNd7srRh3xH3mh
 75vivZTPRZRPw3rGj6HMoBh5u72qvdwttwB1SOTuohbcs3bhfC0cl9e/VcuUajFuKTah
 Sa8ZAZIgbYt8+sBx42yZK4vExGf1KLUjWTwDBA6F95s923IgEps5zXAj3einhnF1dh0c
 7sPMIYu23EJQ7V9mnRfcvz2UCtorSFzjzmFP5bMTmjhyeFzQpsqPxgWJa4AZ6dYB/hfc
 rmyyYz2kLJ64Im44p7SVX+AiBJGN8R88yA02XN/494fvV5pNDLoCvCjjKremWPfWm18U
 sclA==
X-Gm-Message-State: AOJu0YyvArfbGtIZHE0alTmYX62HjD8cakXCh7aW188zppY39rYqhyy/
 5lQsu/6OUNl0NyeIFEBA/DLfekBZ9YAUcWnevysoKPvhOhbhdbFJPqlUxZp4agzoqvJJaRI/KA9
 3uI/8dqY=
X-Gm-Gg: Acq92OFjPGY8PetjxeVUOe6qPA/F/Uf3E/N7bE7SG4h3ghHGfVnbIUeup+uGQWW99Eq
 Yt5NfQgtoOqgwmcQT1U6ldt8EAtwVkbpoOylB64l/YGTaYGnxzcLQ1vJrUK/y4cV1xn07gJuXDZ
 EILm0ok+RtG+aXFmufxnja1/1felNEImFoxVwybRaP4YrpKVrMNm+olWp3aUHI5ByQ1IFQyA6Uq
 TAEjDjkgNep17Myz8hVbzuRlxIDTOkVzMP3ZEg6i3s5KSLQZ36Q5UBcvl+vxJEqVOiyJOIbiAa1
 XLbht7zahDrsZVSPUB/0XUIIQNjxQeFmQPdUbVX4qhJrlOoHMMRjkq6B9seYE9SwKiXVbKdILy+
 JbE4a7nTugy8trEU+JEyKJA89gi9A8rcdm8TTrWsUBJQX+qY+7zYDWJDA6zC6f//IWx7rw9LIGa
 o8wA75ictQcOnxouNZNA4CHcaACIdxraml0YBOU44QeqkiFjoLyQ==
X-Received: by 2002:aa7:8882:0:b0:842:38d2:a35f with SMTP id
 d2e1a72fcca58-84284e8dc75mr1683502b3a.31.1780457358562; 
 Tue, 02 Jun 2026 20:29:18 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 32/45] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Tue,  2 Jun 2026 20:28:41 -0700
Message-ID: <20260603032855.106930-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 78ee893f4f..6c4e372b67 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8388,3 +8388,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
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


