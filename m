Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7F9C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhj-0002J0-Li; Wed, 02 Jul 2025 08:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgA-000816-5n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:10 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfp-00015Z-Dh
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:07 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso1833827fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459687; x=1752064487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjUNsC/tPxG2dLETLc6CC9CFxkrBSGpmnmuEo26OYIY=;
 b=J2jLuiblf/ylvBSf4bfRG74b77Esp820Lv5S0FkWu61io9vmelfYLCxixnuHKF+y1b
 q7VgH/RP6JHH9viYDvOjBBjLYiQEUR9BkeP/tc+ad2No5OujJ8/GkYEYzEK3M1PQHWQU
 AhmqLDmsSJj/qUCIEFfdjs86nIMXZStnZM+eH+lN1qv5dFuoickyQTsffeMjCHm1pe39
 PvESZrNHVsgFE7hl+lNeH3q8mp7GBmCMvPcTzxlqfC6lmP43s/NMx/2K7M7xG1hbEeav
 OyqBJ99wryYSta6lD4ByFYFPfgILsmaAJhlZPlzk0o6VZ9si/4PUxzBKlw70Cqd/lWtz
 U0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459687; x=1752064487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjUNsC/tPxG2dLETLc6CC9CFxkrBSGpmnmuEo26OYIY=;
 b=I/EV48mwryozVOoGkv1S0o36xuIEXNImRruOA4HUSgudFUJE7vWrD6gz2FmedYt7Ze
 txcGCFdr01qQYh3NnERp2tss44QjKCRXMz5ZaLjWHFPCcI4QLTakt/NZMoOfQT5lFZKZ
 eOxA1F/X33GXfbMHaJt/wnmm0AMGyHUJC+eyTaLaMGVtcivozMhumzSBk3X0PX+7X1hf
 Z1sfmYcGKecJdYCaKDoLu+TpEfa+36K1leVX8tWcw2MsrD1/QgE1J8aguyNUCYUDB3/j
 upDBIoZM9TEWmExDGo8dNXwxZK2emarxXQ9hb1/X4BPL+hGcfLhSQYsSG/9mtps1AZsc
 rsEA==
X-Gm-Message-State: AOJu0Yxtjy1EQnHe5vPXYLUp5U+3tGxsYH698/j0/SpKR0IwG829TTAN
 +qLICuNOj/2sGbuwSZQLMFGrPfewdl/VMdPDYZuZih89Pw/wcNEFAMLNF9dYgMgx+NxKpQxaXD9
 VlwxFmnw=
X-Gm-Gg: ASbGncvQU9NB0oCBsVSbNG2UWf3mTgtDYanR046jwni2wZlQ4zGUyxX1NZm0Gr42bt1
 GVyEKL+qaSuJXsQhlKle4IXlqENA/hl4QoSybttCRtnBiRXnjDmI+WW3/fsXwnaHn98YIgUL0UK
 u8HXjYPv3/Gss2nQeAAD71sarFHvddaaj0RNBUooxGzhh/UW1EcUHPXZQE2Odp4jgxbrAw4L/ui
 VmQcSSZhvGsHaQsXsnqfqN7RUVcEiKHmNJCHP2m6Yo4zzlG0k16zSOMohLeiAu4AoL3YkvnY3fZ
 fVJ8v8lBTtQji2dtCpFasT5TzzxzUYtkoYyX1aSJhvRW9Xn8EaMEXSv4kpDudOuH7bp4Gg==
X-Google-Smtp-Source: AGHT+IFV0zV4ti6S8hHGrMLn98nU2xcMcA0+RkwQiiMlX1CGF9AwSJc0UpetSd49RZdBWR0NLmDWwA==
X-Received: by 2002:a05:6871:2881:b0:2ef:9aa7:becb with SMTP id
 586e51a60fabf-2f5a8c97853mr2020632fac.18.1751459687449; 
 Wed, 02 Jul 2025 05:34:47 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 28/97] target/arm: Implement SME2 BFDOT
Date: Wed,  2 Jul 2025 06:33:01 -0600
Message-ID: <20250702123410.761208-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 17 +++++++++++++++++
 target/arm/tcg/sme.decode      |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 761584c90b..965a49465e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -921,3 +921,20 @@ static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
+
+static bool do_bfdot(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 0, 0,
+                         multi, FPST_ENV, gen_helper_gvec_bfdot);
+}
+
+TRANS_FEAT(BFDOT_n1, aa64_sme2, do_bfdot, a, false)
+TRANS_FEAT(BFDOT_nn, aa64_sme2, do_bfdot, a, true)
+
+static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, a->idx, 0,
+                         false, FPST_ENV, gen_helper_gvec_bfdot_idx);
+}
+
+TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a2b93519c4..18e625605f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -288,6 +288,9 @@ BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 FDOT_n1         11000001 001 0 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=2
 FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
 
+BFDOT_n1        11000001 001 0 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=2
+BFDOT_n1        11000001 001 1 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -328,6 +331,9 @@ BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 FDOT_nn         11000001 101 ....0 0 .. 100 ....0 00 ...    @azz_2x2_o3
 FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
 
+BFDOT_nn        11000001 101 ....0 0 .. 100 ....0 10 ...    @azz_2x2_o3
+BFDOT_nn        11000001 101 ...01 0 .. 100 ...00 10 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -365,3 +371,6 @@ BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
 
 FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
 FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
+
+BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
+BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
-- 
2.43.0


