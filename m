Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85364C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pa-0002El-8e; Wed, 19 Jun 2024 17:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PX-0002DR-OB
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PV-0000Mg-9A
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f44b594deeso1812395ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830802; x=1719435602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhyNM0nowlES/o7n9KDkbawcZ8ZSGRcIDHABB3fsnYI=;
 b=bGatzLX7hVAtX+hgXv6+7a+Fz+Inn1+CzmIl1sDVbdOiMsbO0OucNag2T6zc4jfYVP
 9nfynAJvzwiPo0pPv6TPFiDZ/GAToC853X0mC1vaITwIbKLAplVm/FcI5RAail17G2Ja
 lf5aE4q6nejN3fBxrvokSmlrXJcrDcZveq6sQn5s7v4TBMBCNCcM+7rbptNEvYNWXRNA
 Ueo6ctVAb9a9c7md23ByuKAI5fRVkf5lUEc30K+pJaQ0p997FxkvMgmu3i12RwFkKssd
 r/n+MCVhfoFknjJsAxWn0O7reHscnKPVWTyjmUeya+ScXOb7iEMumrCoQyLsvUPssrtz
 Vtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830802; x=1719435602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhyNM0nowlES/o7n9KDkbawcZ8ZSGRcIDHABB3fsnYI=;
 b=WW3ZdF7FvA6hXAAVpnBykTPisfzExLW9rSeLEXEP0apXuXSWnwRibul1NMvf9DtnFV
 UwZwwbxpusDUQOLv5wS8zjg/i7h/F/SWyhWB6xzLhUL7Zf/B1FkvJIUExORMr3QnUOx5
 HaD+rOlrafZCOSCAs35BKAy7yxcFi+U5yGdzG+LPAZVkVY9b+YnPB81ViGn7+Q/hvJJR
 5hMVN1cYaU3hg2TK00in72QI+8EYBQLOlm9v7nMECDReqrgaIBJwRen79VH2mfnYfS8p
 s1vBrhj16WlfselhrCGlUbIgyf5YKJj+NtchaRZw2j6575Cpj58Z2Jp9Dq69oPkWokEG
 a//Q==
X-Gm-Message-State: AOJu0Yx7SdP/HBpCLg19PnZJEPtayBNyrZ9LnAWK7RvgCsv9F/Hvv3bS
 JHzxnRkDR6gf//YpDPm8tIEq5qsxCosDixKZzKxUmdICDzWLDwn70sx/6Li3+IhEfpGuZ1Zciiv
 D
X-Google-Smtp-Source: AGHT+IH+kvVYH5BfM3EGPeaPwp4OqaImzVGn5t1eHeylZWcYAvR+orhmCwS+yaLHDMlftr6uV4QfTw==
X-Received: by 2002:a17:902:e5d0:b0:1f6:daa6:e77b with SMTP id
 d9443c01a7336-1f9aa96847fmr38612705ad.68.1718830800574; 
 Wed, 19 Jun 2024 14:00:00 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 08/24] tcg/loongarch64: Support LASX in tcg_out_dupm_vec
Date: Wed, 19 Jun 2024 13:59:36 -0700
Message-Id: <20240619205952.235946-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Each element size has a different encoding, so code cannot
be shared in the same way as with tcg_out_dup_vec.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cc54bc4a53..1e721b8b20 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1690,8 +1690,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    /* Handle imm overflow and division (vldrepl.d imm is divided by 8) */
-    if (offset < -0x800 || offset > 0x7ff || \
+    bool lasx = type == TCG_TYPE_V256;
+
+    /* Handle imm overflow and division (vldrepl.d imm is divided by 8). */
+    if (offset < -0x800 || offset > 0x7ff ||
         (offset & ((1 << vece) - 1)) != 0) {
         tcg_out_addi(s, TCG_TYPE_I64, TCG_REG_TMP0, base, offset);
         base = TCG_REG_TMP0;
@@ -1701,16 +1703,32 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
 
     switch (vece) {
     case MO_8:
-        tcg_out_opc_vldrepl_b(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_b(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_b(s, r, base, offset);
+        }
         break;
     case MO_16:
-        tcg_out_opc_vldrepl_h(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_h(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_h(s, r, base, offset);
+        }
         break;
     case MO_32:
-        tcg_out_opc_vldrepl_w(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_w(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_w(s, r, base, offset);
+        }
         break;
     case MO_64:
-        tcg_out_opc_vldrepl_d(s, r, base, offset);
+        if (lasx) {
+            tcg_out_opc_xvldrepl_d(s, r, base, offset);
+        } else {
+            tcg_out_opc_vldrepl_d(s, r, base, offset);
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


