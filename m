Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05945CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9k-00047w-Lr; Wed, 08 Oct 2025 17:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9i-00044j-A5
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:06 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c95-0006eb-Rm
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:05 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b633b54d05dso164933a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960583; x=1760565383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ud9vGgDdoT6jxZodqNWxrrBEL296XjYMaUJkjzXXc8=;
 b=TnJ6DlJv0eE4sod6Nu3uprVJl2ssi3Sc/EGXprGISAxvR2te+BvTejRzKg8nkc47se
 NlMnU5fKj/DblBFUonEBPuNZBQmbAa2Ga8uyXufjs+Fikm33ENB6VjTAAymgIyL6LeWj
 0wpX4gY3NzTDtsdrcZAeNN2XXRszv5rwRue2LZ9bxhQoiVdFk39WDJO9Sp7yvQpw/mOE
 VyIrOi90HTI6sj1BYAHsr2jrOh4slbvYxEQsHpEPhpKFnKAcMk30zce8J9suvCqLcn73
 ZPb8DGv4vfqYC38uOoaOLO9ff1fv/oc0fjW9XE/1lNxClKhCfgFh/jPcHlFBfSSg2Pja
 kXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960583; x=1760565383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ud9vGgDdoT6jxZodqNWxrrBEL296XjYMaUJkjzXXc8=;
 b=qrhDPsVzq2IKBNK/YdM18L//AOG5pIf9KFk2IlRylu3oMx3kz5HzVY/GbgUh7tceHs
 3HEQygL3cMorn5gzGJnOXrlfvWizHk3xaevfWstr2vAxZsP2aRLbQ7/IQm+ewuXybaO1
 sl///CGCLdNTxv00SwbB8kMnFfpIdvigx+0R/U1t+kkwHMdEP4WqXTazgUqT6opcp7ts
 szStUmGbjGRLkwN/1Toic7L78CyubfVHoEMk/1v2B6HPogYn7ggDaO8oOfxkcqJUhldx
 W/dFmcTH18ApOo7BTzVcfNNxWpVxGvlijBa4F+9JWmKWIaS58iwMcxue6d+297UtYuss
 Xf9w==
X-Gm-Message-State: AOJu0YwLeeuW9Oy8wqZo9O41Mgz1layJYlCZs1i6qfLhHuVOzESrzNvA
 4Klstf9pNDo9JWYD9om4qrjNs54fHpSPlmMGXkP1rMEmqVRLdIRMPOYJoMIc7CUoQq7k5KW30wl
 6UL2+D6o=
X-Gm-Gg: ASbGncs4gUg9FBtP+/UaxQoB40afQmFIkrAmFCNgudEIpd82XVdVniUDUXV9k0BWaEe
 yMGIftwhzNumsdfdP8lK1TOSLU1zC+GNWzpDxXMW8zFdieT+mmzaMfRQ6FsLDVZGSFv2izmcmUr
 kN4d5uY0IMdAA476wkaO++RYmDfNKAPFd7i+cwydkd+np23hXCf/NFkoRnguGbsV4aFZu4YeGuQ
 AKOLWL35p8DkHJmE0JcPKHNg32qXaaxrcfd48IBv5oIyWoA1klkKC3OC0mvOA50Uvws2EYo4cZd
 jrVSOsKbTIoWpj0K3MZdEOHkkKQLvAtTlK9NaE1sqGo6ofJuAnWnnctlt75iGRH4uFQZveIY4nh
 N4uho9to/Nhp4c62X7H0cNsHIzrUpSIG1bKcoCteSYnqEM/RMDTfmdXQK
X-Google-Smtp-Source: AGHT+IGtW3HUHCMOpO6gAGqW4C7T7rObNClbEPu+KsdQaPx9O0fcj/O7WjMhenl835XYvshj+vyrag==
X-Received: by 2002:a17:903:9cb:b0:28e:caee:40dc with SMTP id
 d9443c01a7336-29027237d65mr61947215ad.14.1759960583551; 
 Wed, 08 Oct 2025 14:56:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 13/73] target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu
 max
Date: Wed,  8 Oct 2025 14:55:13 -0700
Message-ID: <20251008215613.300150-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8c617fe37b..f024db1d29 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1327,6 +1327,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1aa0a6e4c3..c779a50570 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -123,6 +123,8 @@ the following architecture extensions:
 - FEAT_RME_GPC2 (RME Granule Protection Check 2 Extension)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
+- FEAT_S1PIE (Stage 1 permission indirections)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
-- 
2.43.0


