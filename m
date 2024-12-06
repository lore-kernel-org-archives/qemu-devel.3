Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E79AE77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOln-0006pn-5s; Thu, 05 Dec 2024 22:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlj-0006o1-NB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:39 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlg-0004RV-1W
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:39 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71d40003870so442270a34.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454755; x=1734059555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAFMQwec2hggzP3Ei7JJvD8wcLKXb3I/l2oaVPF1T4o=;
 b=zbkMfSUEaYQlXoySq6Za1SY47Rcmifo7O6Hk6C3bfoPNwZG0gF4hteFLxfh5+hwmwv
 lX2J9hxXq8AnWXJr8n4gMDEXhJleyjw2sDNRYsFM8WGy78YxfY9dnTOcQ/JSsvTf34nd
 QJ+lra3y/Ap+RotA1ogPeA7ZEiFeS+IrWQMJlCFnG9zQSFw3CkNB/03EwewD/EaI2z1y
 J2VQsjY4CGyFDfgagmg5pFfG5Ofy4raSoq1z8qcPUUTUm69nU6RVENaRfqd2ELV8dAcZ
 +6zNQ4lCOz80YMSmtnnidgAQVtO99uyTPLpgI+JWai4y0BB2mJwfK2Ejy5vjoho6nG2D
 DCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454755; x=1734059555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAFMQwec2hggzP3Ei7JJvD8wcLKXb3I/l2oaVPF1T4o=;
 b=ZU7iJxrryNUf4bZratwZcukKL4MSIv34zcF976s/Lvm9A50u36IDRE5yG/bkGV0Opt
 oEH6armKwAB+gs2VEsXvlQWRSnCnoT1p1HJosmv/PuCULmCTodD0J23j35qt12iE+giG
 /3i6ErXwo+Nug3DsLT6JJWKGii82vZtunh3lAtRjJYoX9YrK9RDsSj2Yl68Es6bC0PxJ
 TQ+AJ2Tcq3AAIrC4kIXUTgIcVmCHAT4mf69XIICFNH+TGJWQApNwMT0NJTamjvBKU8Gj
 ivota7OC3W/oBJ1PvgbiyPqP5eOVRnWFsZBAXt7WgxnyTlgcvGFVJOF6UCp2Re8/dlwA
 pF8Q==
X-Gm-Message-State: AOJu0Yy75H33uE+6VmnHIOP/V82iqAdl1OuGVV9uLrs0tvlHmmZ5rMwy
 h3Ri+lijLRwlzbL6hxwb3Cm+Swa1jZCjQUQkTmdGZZTLQxxyVG14guEXCLCzTZNQdnFpNwOCnel
 c6FYzm6Os
X-Gm-Gg: ASbGnct40fC0m0sJSRdhsEu3B61jx9qqVHhJpuvOxjBk0kwHpwMKOGW9IhWYqMdWV8+
 cB8CXSAdmA18fLaHrdqTY4jhuRMOiHzO7toPTbjkr8vRSsdt91NBbd9hW8nO9DaJNbnyrEfTm2q
 7CT0I/v4KpbNb4nescVgg8L5Vaq8n29nqFivxRFyInbixMSDXoAELu+o9wcD1sWQ9+5Lwcm6ls/
 X5BT4Qv+RTET1Rn8Se6OJlW2Y88lfHJlKWv7Jcu5EmUme4wpn2Omre6ydqcfrBQFy3hbX8XivRq
 nZLFyL35rbMO9w6HeVgSJm8f2MmfvNjJOqw9
X-Google-Smtp-Source: AGHT+IHkRE4DlPS26UsBx+FlC4afUybjhBu5p0UU0i6QEynB5B2itb5bkGAcUdIdopaUXKDdHDj4bg==
X-Received: by 2002:a05:6830:6386:b0:71d:6543:e83f with SMTP id
 46e09a7af769-71dcf4d97bdmr917996a34.11.1733454754492; 
 Thu, 05 Dec 2024 19:12:34 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/9] target/arm: Convert vec_helper.c to fpst alias
Date: Thu,  5 Dec 2024 21:12:19 -0600
Message-ID: <20241206031224.78525-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
References: <20241206031224.78525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
 target/arm/helper.h         | 284 ++++++++++++++++++------------------
 target/arm/tcg/helper-a64.h |  18 +--
 target/arm/tcg/helper-sve.h |  12 +-
 target/arm/tcg/vec_helper.c |  60 ++++----
 4 files changed, 183 insertions(+), 191 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9bfb5048c4..3e78b90658 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -628,190 +628,190 @@ DEF_HELPER_FLAGS_5(gvec_usdot_idx_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_fcmlah, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fcmlas, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_tosszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_uitos, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_tosszh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fu, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hu, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_vcvt_sd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_ud, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_ds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_sd, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_ud, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_ds, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_du, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ud, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sd, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ud, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_vrintx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vrintx_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcgt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fcgt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcge0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fcge0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fceq0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fceq0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcle0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fcle0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fceq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fceq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fcge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fcgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_facge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_facge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_facgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_facgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
@@ -1062,9 +1062,9 @@ DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
@@ -1084,25 +1084,25 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_faddp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_faddp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_faddp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_faddp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_faddp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_faddp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fminp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmaxnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fminnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(gvec_addp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_addp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index f1bac6688a..4d70493914 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -129,14 +129,14 @@ DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
 DEF_HELPER_FLAGS_1(guarded_page_check, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, tl)
 
-DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmulx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmulx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index cc4e1d8948..1fdfb84d4c 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -959,18 +959,18 @@ DEF_HELPER_FLAGS_4(sve_umini_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_5(gvec_recps_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_recps_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_recps_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_rsqrts_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 768f745828..d2d9d5e829 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -873,13 +873,12 @@ DO_DOT_IDX(gvec_sdot_idx_h, int64_t, int16_t, int16_t, H8)
 DO_DOT_IDX(gvec_udot_idx_h, uint64_t, uint16_t, uint16_t, H8)
 
 void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
-                         void *vfpst, uint32_t desc)
+                         float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float16 *d = vd;
     float16 *n = vn;
     float16 *m = vm;
-    float_status *fpst = vfpst;
     uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = neg_real ^ 1;
     uintptr_t i;
@@ -901,13 +900,12 @@ void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
 }
 
 void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
-                         void *vfpst, uint32_t desc)
+                         float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float32 *d = vd;
     float32 *n = vn;
     float32 *m = vm;
-    float_status *fpst = vfpst;
     uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = neg_real ^ 1;
     uintptr_t i;
@@ -929,13 +927,12 @@ void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
 }
 
 void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
-                         void *vfpst, uint32_t desc)
+                         float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float64 *d = vd;
     float64 *n = vn;
     float64 *m = vm;
-    float_status *fpst = vfpst;
     uint64_t neg_real = extract64(desc, SIMD_DATA_SHIFT, 1);
     uint64_t neg_imag = neg_real ^ 1;
     uintptr_t i;
@@ -957,11 +954,10 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
 }
 
 void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm, void *va,
-                         void *vfpst, uint32_t desc)
+                         float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float16 *d = vd, *n = vn, *m = vm, *a = va;
-    float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     uint32_t neg_real = flip ^ neg_imag;
@@ -984,11 +980,10 @@ void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
-                             void *vfpst, uint32_t desc)
+                             float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float16 *d = vd, *n = vn, *m = vm, *a = va;
-    float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
@@ -1019,11 +1014,10 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm, void *va,
-                         void *vfpst, uint32_t desc)
+                         float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float32 *d = vd, *n = vn, *m = vm, *a = va;
-    float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     uint32_t neg_real = flip ^ neg_imag;
@@ -1046,11 +1040,10 @@ void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
-                             void *vfpst, uint32_t desc)
+                             float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float32 *d = vd, *n = vn, *m = vm, *a = va;
-    float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
@@ -1081,11 +1074,10 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm, void *va,
-                         void *vfpst, uint32_t desc)
+                         float_status *fpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     float64 *d = vd, *n = vn, *m = vm, *a = va;
-    float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     uint64_t neg_real = flip ^ neg_imag;
@@ -1187,9 +1179,8 @@ static uint64_t float64_acgt(float64 op1, float64 op2, float_status *stat)
     return -float64_lt(float64_abs(op2), float64_abs(op1), stat);
 }
 
-static int16_t vfp_tosszh(float16 x, void *fpstp)
+static int16_t vfp_tosszh(float16 x, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     if (float16_is_any_nan(x)) {
         float_raise(float_flag_invalid, fpst);
         return 0;
@@ -1197,9 +1188,8 @@ static int16_t vfp_tosszh(float16 x, void *fpstp)
     return float16_to_int16_round_to_zero(x, fpst);
 }
 
-static uint16_t vfp_touszh(float16 x, void *fpstp)
+static uint16_t vfp_touszh(float16 x, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     if (float16_is_any_nan(x)) {
         float_raise(float_flag_invalid, fpst);
         return 0;
@@ -1208,7 +1198,7 @@ static uint16_t vfp_touszh(float16 x, void *fpstp)
 }
 
 #define DO_2OP(NAME, FUNC, TYPE) \
-void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
+void HELPER(NAME)(void *vd, void *vn, float_status *stat, uint32_t desc)  \
 {                                                                 \
     intptr_t i, oprsz = simd_oprsz(desc);                         \
     TYPE *d = vd, *n = vn;                                        \
@@ -1368,7 +1358,8 @@ static float32 float32_rsqrts_nf(float32 op1, float32 op2, float_status *stat)
 }
 
 #define DO_3OP(NAME, FUNC, TYPE) \
-void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status *stat, uint32_t desc)                       \
 {                                                                          \
     intptr_t i, oprsz = simd_oprsz(desc);                                  \
     TYPE *d = vd, *n = vn, *m = vm;                                        \
@@ -1522,8 +1513,9 @@ static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
     return float64_muladd(float64_chs(op1), op2, dest, 0, stat);
 }
 
-#define DO_MULADD(NAME, FUNC, TYPE)                                     \
-void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+#define DO_MULADD(NAME, FUNC, TYPE)                                        \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status *stat, uint32_t desc)                       \
 {                                                                          \
     intptr_t i, oprsz = simd_oprsz(desc);                                  \
     TYPE *d = vd, *n = vn, *m = vm;                                        \
@@ -1600,7 +1592,8 @@ DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -, H8)
 #undef DO_MLA_IDX
 
 #define DO_FMUL_IDX(NAME, ADD, MUL, TYPE, H)                               \
-void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status *stat, uint32_t desc)                       \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
     intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
@@ -1644,7 +1637,7 @@ DO_FMUL_IDX(gvec_fmls_nf_idx_s, float32_sub, float32_mul, float32, H4)
 
 #define DO_FMLA_IDX(NAME, TYPE, H)                                         \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
-                  void *stat, uint32_t desc)                               \
+                  float_status *stat, uint32_t desc)                       \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
     intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
@@ -2410,7 +2403,8 @@ DO_ABA(gvec_uaba_d, uint64_t)
 #undef DO_ABA
 
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
-void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
+                  float_status *stat, uint32_t desc)                       \
 {                                                                          \
     ARMVectorReg scratch;                                                  \
     intptr_t oprsz = simd_oprsz(desc);                                     \
@@ -2495,7 +2489,7 @@ DO_3OP_PAIR(gvec_uminp_s, MIN, uint32_t, H4)
 #undef DO_3OP_PAIR
 
 #define DO_VCVT_FIXED(NAME, FUNC, TYPE)                                 \
-    void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
+    void HELPER(NAME)(void *vd, void *vn, float_status *stat, uint32_t desc) \
     {                                                                   \
         intptr_t i, oprsz = simd_oprsz(desc);                           \
         int shift = simd_data(desc);                                    \
@@ -2524,9 +2518,8 @@ DO_VCVT_FIXED(gvec_vcvt_rz_hu, helper_vfp_touhh_round_to_zero, uint16_t)
 #undef DO_VCVT_FIXED
 
 #define DO_VCVT_RMODE(NAME, FUNC, TYPE)                                 \
-    void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
+    void HELPER(NAME)(void *vd, void *vn, float_status *fpst, uint32_t desc) \
     {                                                                   \
-        float_status *fpst = stat;                                      \
         intptr_t i, oprsz = simd_oprsz(desc);                           \
         uint32_t rmode = simd_data(desc);                               \
         uint32_t prev_rmode = get_float_rounding_mode(fpst);            \
@@ -2549,9 +2542,8 @@ DO_VCVT_RMODE(gvec_vcvt_rm_uh, helper_vfp_touhh, uint16_t)
 #undef DO_VCVT_RMODE
 
 #define DO_VRINT_RMODE(NAME, FUNC, TYPE)                                \
-    void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
+    void HELPER(NAME)(void *vd, void *vn, float_status *fpst, uint32_t desc) \
     {                                                                   \
-        float_status *fpst = stat;                                      \
         intptr_t i, oprsz = simd_oprsz(desc);                           \
         uint32_t rmode = simd_data(desc);                               \
         uint32_t prev_rmode = get_float_rounding_mode(fpst);            \
@@ -3015,7 +3007,7 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
-                         void *stat, uint32_t desc)
+                         float_status *stat, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
     intptr_t sel = simd_data(desc);
@@ -3031,7 +3023,7 @@ void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm,
-                             void *va, void *stat, uint32_t desc)
+                             void *va, float_status *stat, uint32_t desc)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1);
-- 
2.43.0


