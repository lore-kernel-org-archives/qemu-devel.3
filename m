Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F30E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xz-0001bT-MF; Tue, 07 Jan 2025 03:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XC-0000Mp-GZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X6-0002zB-3n
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21636268e43so41679255ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236906; x=1736841706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H4Xdl/MZQtUYR6zeSRzBxVGkp4PPbb2VkTCymJGNP4=;
 b=UolTK6rzS52XYzsl5FUNOg7yw6G7cOO84Q+MQXE/y5h5gZ8NXcilyVYcKCAbPngwjt
 lTiIrzijw1h3D1SV0GW38XiduKx6BRcG7JLKwP4vVgJiyB4nts0aHPdt3qRJubb80Vbe
 VMghgIC3kKAkCrJZFrNWqHZf6PPaNy3+RVLnZ9ZRXWo1GcURPwiT9D1YsfBBo3XKEmb5
 w/tosRGTUYm3ZmuiJPcrJz2+jIdLPZvETUkO8YfdgYF0JnkOEmc+7rGZvKAK4QGsWya6
 ih0pCygdb6Wjrjcfi0Y0TYmJwcLwo6ZyuZu2Hk7spJ68Fpi6qHcsn6PDAquzj3SUcsze
 fbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236906; x=1736841706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H4Xdl/MZQtUYR6zeSRzBxVGkp4PPbb2VkTCymJGNP4=;
 b=p+Faa323m0RJJO2+9PV7hKHOOA7Uu2kG7s48TFcf69EjmPx5L8azoVjWKqUV5vCvto
 WnNF2xhmBODHMPteqDMJl+zC0I2b11zcyxgHK0F3tkXopRDZxAj8kkB8o5saQI+besJ/
 CoSN3nnvnFbjqbZLPgJmOlbM41OFHth9zHikRrPQTkBog6m5jpG3Y0WWmn52mQ+KBnyF
 eOB10Rv0beiAkZUAw3tFtWOPjQOlD2Y2uPs1ZG4tPSHkYkBAvWHO48QiqRG7Rgt04Cux
 rMWwBcuJhU6A/0GN9xjQjldnxtMglqz55zbhJLDu77kelgRoMW3GoRzv33aQes2XxWUt
 SIkQ==
X-Gm-Message-State: AOJu0Yzqbwx0BCS/uZq+C4AESwpHiO+G0rMIYqsmyRmkwDeGDCVcM4Uw
 TIGTzipORAhGPHEnwrbJEylzaEEx8upGelsD12+W4xffWQWkXHQTjcWjnNGBxT0kXU/g851Oxop
 M
X-Gm-Gg: ASbGncu8sFUHvw1SS1rVR8OkfHNZoZ622aI00C+n1259jbeiswboDJlK7Gmtq7VZPnG
 l7mCPCyBeoj1tbt4FlgEKDZkJYfathgJgyrdh8U0EoczcRAlgMGnJemZcsjD5VTLsPUtKAzwi1E
 ME32wCCgBdRB9FNuMEWclgTKdXhH/5ttMDFEOpjhD02MwcF7vqlXUeib2uO5YLQOXmIM7Rl9x4e
 /3T/pyrYwyx9fqs6XUHZnErEoMMmtZDzwDI9P6hR5olC+uc/w2Lp+Fy/al2JDCIaGqj5HF4TkvU
 PVyqVi6TZs/hAP9BmA==
X-Google-Smtp-Source: AGHT+IF7Fw0lBSGc+9iKv0Ym2s2yW+23KgSTrt37qhAZHhH1E1IOR1CHn28nD8ZfEcX4J0xXysz77g==
X-Received: by 2002:a17:903:2c6:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-219e6f262admr870574065ad.45.1736236906280; 
 Tue, 07 Jan 2025 00:01:46 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 31/81] tcg: Replace IMPLVEC with TCG_OPF_VECTOR
Date: Tue,  7 Jan 2025 00:00:22 -0800
Message-ID: <20250107080112.1175095-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This is now a direct replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 89 +++++++++++++++-----------------
 tcg/aarch64/tcg-target-opc.h.inc |  4 +-
 tcg/arm/tcg-target-opc.h.inc     |  6 +--
 tcg/i386/tcg-target-opc.h.inc    | 22 ++++----
 tcg/ppc/tcg-target-opc.h.inc     | 12 ++---
 tcg/s390x/tcg-target-opc.h.inc   |  6 +--
 6 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 559f5971e6..9383e295f4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -221,66 +221,63 @@ DEF(qemu_st_a64_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Host vector support.  */
 
-#define IMPLVEC  TCG_OPF_VECTOR
-
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
-DEF(dup_vec, 1, 1, 0, IMPLVEC)
-DEF(dup2_vec, 1, 2, 0, IMPLVEC)
+DEF(dup_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(dup2_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(ld_vec, 1, 1, 1, IMPLVEC)
-DEF(st_vec, 0, 2, 1, IMPLVEC)
-DEF(dupm_vec, 1, 1, 1, IMPLVEC)
+DEF(ld_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(st_vec, 0, 2, 1, TCG_OPF_VECTOR)
+DEF(dupm_vec, 1, 1, 1, TCG_OPF_VECTOR)
 
-DEF(add_vec, 1, 2, 0, IMPLVEC)
-DEF(sub_vec, 1, 2, 0, IMPLVEC)
-DEF(mul_vec, 1, 2, 0, IMPLVEC)
-DEF(neg_vec, 1, 1, 0, IMPLVEC)
-DEF(abs_vec, 1, 1, 0, IMPLVEC)
-DEF(ssadd_vec, 1, 2, 0, IMPLVEC)
-DEF(usadd_vec, 1, 2, 0, IMPLVEC)
-DEF(sssub_vec, 1, 2, 0, IMPLVEC)
-DEF(ussub_vec, 1, 2, 0, IMPLVEC)
-DEF(smin_vec, 1, 2, 0, IMPLVEC)
-DEF(umin_vec, 1, 2, 0, IMPLVEC)
-DEF(smax_vec, 1, 2, 0, IMPLVEC)
-DEF(umax_vec, 1, 2, 0, IMPLVEC)
+DEF(add_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(mul_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(neg_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(abs_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(ssadd_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(usadd_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sssub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ussub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(smin_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(umin_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(smax_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(umax_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(and_vec, 1, 2, 0, IMPLVEC)
-DEF(or_vec, 1, 2, 0, IMPLVEC)
-DEF(xor_vec, 1, 2, 0, IMPLVEC)
-DEF(andc_vec, 1, 2, 0, IMPLVEC)
-DEF(orc_vec, 1, 2, 0, IMPLVEC)
-DEF(nand_vec, 1, 2, 0, IMPLVEC)
-DEF(nor_vec, 1, 2, 0, IMPLVEC)
-DEF(eqv_vec, 1, 2, 0, IMPLVEC)
-DEF(not_vec, 1, 1, 0, IMPLVEC)
+DEF(and_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(or_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(xor_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(andc_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(orc_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(nand_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(nor_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(eqv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(not_vec, 1, 1, 0, TCG_OPF_VECTOR)
 
-DEF(shli_vec, 1, 1, 1, IMPLVEC)
-DEF(shri_vec, 1, 1, 1, IMPLVEC)
-DEF(sari_vec, 1, 1, 1, IMPLVEC)
-DEF(rotli_vec, 1, 1, 1, IMPLVEC)
+DEF(shli_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(shri_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(sari_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(rotli_vec, 1, 1, 1, TCG_OPF_VECTOR)
 
-DEF(shls_vec, 1, 2, 0, IMPLVEC)
-DEF(shrs_vec, 1, 2, 0, IMPLVEC)
-DEF(sars_vec, 1, 2, 0, IMPLVEC)
-DEF(rotls_vec, 1, 2, 0, IMPLVEC)
+DEF(shls_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(shrs_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sars_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotls_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(shlv_vec, 1, 2, 0, IMPLVEC)
-DEF(shrv_vec, 1, 2, 0, IMPLVEC)
-DEF(sarv_vec, 1, 2, 0, IMPLVEC)
-DEF(rotlv_vec, 1, 2, 0, IMPLVEC)
-DEF(rotrv_vec, 1, 2, 0, IMPLVEC)
+DEF(shlv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(shrv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sarv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotlv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotrv_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(cmp_vec, 1, 2, 1, IMPLVEC)
+DEF(cmp_vec, 1, 2, 1, TCG_OPF_VECTOR)
 
-DEF(bitsel_vec, 1, 3, 0, IMPLVEC)
-DEF(cmpsel_vec, 1, 4, 1, IMPLVEC)
+DEF(bitsel_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(cmpsel_vec, 1, 4, 1, TCG_OPF_VECTOR)
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
 #undef DATA64_ARGS
-#undef IMPLVEC
 #undef DEF
diff --git a/tcg/aarch64/tcg-target-opc.h.inc b/tcg/aarch64/tcg-target-opc.h.inc
index bce30accd9..5382315c41 100644
--- a/tcg/aarch64/tcg-target-opc.h.inc
+++ b/tcg/aarch64/tcg-target-opc.h.inc
@@ -11,5 +11,5 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
-DEF(aa64_sli_vec, 1, 2, 1, IMPLVEC)
+DEF(aa64_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(aa64_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
diff --git a/tcg/arm/tcg-target-opc.h.inc b/tcg/arm/tcg-target-opc.h.inc
index d38af9a808..70394e0282 100644
--- a/tcg/arm/tcg-target-opc.h.inc
+++ b/tcg/arm/tcg-target-opc.h.inc
@@ -11,6 +11,6 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(arm_sli_vec, 1, 2, 1, IMPLVEC)
-DEF(arm_sshl_vec, 1, 2, 0, IMPLVEC)
-DEF(arm_ushl_vec, 1, 2, 0, IMPLVEC)
+DEF(arm_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(arm_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(arm_ushl_vec, 1, 2, 0, TCG_OPF_VECTOR)
diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/i386/tcg-target-opc.h.inc
index 4ffc084bda..8cc0dbaeaf 100644
--- a/tcg/i386/tcg-target-opc.h.inc
+++ b/tcg/i386/tcg-target-opc.h.inc
@@ -24,14 +24,14 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_psrldq_vec, 1, 1, 1, IMPLVEC)
-DEF(x86_vperm2i128_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_punpckl_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_punpckh_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_vpshldi_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpshldv_vec, 1, 3, 0, IMPLVEC)
-DEF(x86_vpshrdv_vec, 1, 3, 0, IMPLVEC)
+DEF(x86_shufps_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_blend_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_packss_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_packus_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_psrldq_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(x86_vperm2i128_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_punpckl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_punpckh_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_vpshldi_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_vpshldv_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(x86_vpshrdv_vec, 1, 3, 0, TCG_OPF_VECTOR)
diff --git a/tcg/ppc/tcg-target-opc.h.inc b/tcg/ppc/tcg-target-opc.h.inc
index db514403c3..c3635831b5 100644
--- a/tcg/ppc/tcg-target-opc.h.inc
+++ b/tcg/ppc/tcg-target-opc.h.inc
@@ -24,9 +24,9 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(ppc_mrgh_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_mrgl_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
-DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_mrgh_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_mrgl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_msum_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(ppc_muleu_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_mulou_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_pkum_vec, 1, 2, 0, TCG_OPF_VECTOR)
diff --git a/tcg/s390x/tcg-target-opc.h.inc b/tcg/s390x/tcg-target-opc.h.inc
index 0eb2350fb3..61237b39cd 100644
--- a/tcg/s390x/tcg-target-opc.h.inc
+++ b/tcg/s390x/tcg-target-opc.h.inc
@@ -10,6 +10,6 @@
  * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
  * consider these to be UNSPEC with names.
  */
-DEF(s390_vuph_vec, 1, 1, 0, IMPLVEC)
-DEF(s390_vupl_vec, 1, 1, 0, IMPLVEC)
-DEF(s390_vpks_vec, 1, 2, 0, IMPLVEC)
+DEF(s390_vuph_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(s390_vupl_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(s390_vpks_vec, 1, 2, 0, TCG_OPF_VECTOR)
-- 
2.43.0


