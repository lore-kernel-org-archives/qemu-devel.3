Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E41C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg85T-0002MJ-3P; Thu, 06 Feb 2025 15:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83k-0007v9-Hs
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:17 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83h-0001Bt-QW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:12 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so1895391a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872061; x=1739476861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaA26QwdbT5KEG0jRzmu/uC0u+13aOEkIOvu+re9AH4=;
 b=Px4sCQf6ZXxmx6EgDucHWFT/4iPUKoDlB1hK4TJ6hIbuoaVQ3cMpy+E1jy1UolMsZE
 /nCXNYX5Mxy/XP1emQd1VapGVlwCogf85yhccHHDAMzL5138wjd39x+cV7ErRIE1uYG0
 5HmNsVXfMWfvqvX4l13mIlLAfkYhUFTjRY6Z51CUbNTDF+ZKmiRnVIRA1qwHC7g76kC/
 S28TuVQud/njuPUEZXk2LpcZ0YnlislBDbylsuFSgxXbhvss0uRbdJf8bobs/ezmEna4
 oVAs40m+aMedWo6Tw6NLa3rZoepBpLbODytcZGuMQ1ar2Sd9B9UVxLBeiLl7hJ9VHkrr
 LrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872061; x=1739476861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaA26QwdbT5KEG0jRzmu/uC0u+13aOEkIOvu+re9AH4=;
 b=PjmlS8nNJxqsovBstbzdrBQrualve+oos+5CkOFpv1yXj3n/UPs5HqBXYLrTh+3MoX
 U8JuMwBZ7azshp4iRz/TjCyE5/jXAjioL5zjGAsVDoQrfTgwsfW48m21ISCop4eT/Wo2
 TR2Ig84kiP19Eo+o7D3mwFH0/D9EnLPYKKD1jHOoOIw2yFfUqq6gOm4Ysx29Hz6+659n
 f5+8cJKc7AXn49fY9KN5OXf0gixx7OmxRRi1fRyLANeG1BXa4MFmC09x2brf/6QVi6na
 bxkzW84bzEupTP2Opg0yeARSMyOX/T46lAp8ChJ9YijoLcBRHN4OlNjhQMcgPqHwlu6+
 2VTA==
X-Gm-Message-State: AOJu0YykU2WdNVjsBN48hrpQVYd0O7HK/dNSAIuQd22TugNS6d46e5Zi
 3W7pFWtKCVBwS7rmz01QOES8B0dlFhlSRK42u4WnftPfESTUlbShfHPXZEcHHeIZaBVM5t+E18W
 h
X-Gm-Gg: ASbGncsnPkbx8ceYS1Wfgvn/aN7cgmOdOex5zpzDSWdZ3raDf7XUSksYid98fMhQm7D
 tgEjyz6LBUzSug4KkT0r6Rm5sK4HykqzV0zuPDciaLWon3fEoZVXz1njcFmURux86qgxX4rJaA/
 0aXHTWxRt/NEiKLs9WLgrmDXMec1S1odKbFkwC6qaoYUHE3JJJZlzGbtXqmIZfrgol4JVgE/2Su
 NSNCHgwf2mG2UC2BWxkyZvyTWAT5rrGt7i6Yw5KRHElOfO3Zjtj/jWoLL+rTmdHfzfm08X8HZuq
 wIhqeoE0sVGpDY70lJ+knrvYxrdj/6bcwTDogNzFekorHeI=
X-Google-Smtp-Source: AGHT+IE1FzgIaO8jM68uKeZ6H4W63fQPsfPe/4PeybZ91nJJ6WcpiLuX7MeqOo+bzKPg0PBpgba9Kg==
X-Received: by 2002:a17:90b:4c02:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2fa2406471emr509817a91.8.1738872060934; 
 Thu, 06 Feb 2025 12:01:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:01:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 60/61] target/arm: Implement SME2 SEL
Date: Thu,  6 Feb 2025 11:57:14 -0800
Message-ID: <20250206195715.2150758-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 25 +++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e71e3ec8e3..78bd750701 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1520,3 +1520,28 @@ static gen_helper_gvec_3 * const uclamp_fns[] = {
     gen_helper_sme2_uclamp_d,
 };
 TRANS_FEAT(UCLAMP, aa64_sme2, do_clamp, a, uclamp_fns)
+
+static bool trans_SEL(DisasContext *s, arg_SEL *a)
+{
+    static gen_helper_gvec_4 * const fns[4] = {
+        gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
+        gen_helper_sve_sel_zpzz_s, gen_helper_sve_sel_zpzz_d
+    };
+
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        gen_helper_gvec_4 *f = fns[a->esz];
+
+        for (int i = 0; i < a->n; ++i) {
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               vec_full_reg_offset(s, a->zm + i),
+                               pred_full_reg_offset(s, a->pg),
+                               svl, svl, 0, f);
+        }
+    }
+    return true;
+}
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9bbf89b15c..1d0ac4f09b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -872,3 +872,12 @@ UCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 1    \
                 &zzz_en zd=%zd_ax2 n=2
 UCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 1    \
                 &zzz_en zd=%zd_ax4 n=4
+
+### SME2 Multi-vector SVE Select
+
+%sel_pg         10:3 !function=plus_8
+
+SEL             11000001 esz:2 1 ....0 100 ... ....0 ....0  \
+                n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 pg=%sel_pg
+SEL             11000001 esz:2 1 ...01 100 ... ...00 ...00  \
+                n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 pg=%sel_pg
-- 
2.43.0


