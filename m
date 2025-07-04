Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A027C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhPt-0003oi-NB; Fri, 04 Jul 2025 10:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLu-00046X-IW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:27 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLn-0007xk-WF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:20 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6116d9bb6ecso676353eaf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639114; x=1752243914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61hUKPP4NzlChuyDFmm/IMVLnPZIGc8U0gNoQgzlADg=;
 b=YDkPtjI1Qo9twiZFFyVnuuawQUwA0ncqd5q7cghQMU6XvFksBriHHz+BMiDWGdFD+z
 +BFhSlTBpsvcZtt3ma4NDDooUTgSnW9wNOpSmjULXmcskayOlu+MiubyCNyYCcAd7iXd
 zmukG443XvApbN+ifWXvYT2CXrIVwiOeoDXcihBJ0DGbJsrqD79eVCGS6P13FBnwYM4t
 qX0EThneZ00N1zrQLt8nHv4FZLjv7aTej0tbufqpGjpRQTUJEIgsqDm8pD6/5D7UW33o
 rI9kthq1qxpo++tB3JoHFwcEuYVSgXWMAgoYoYYIQwgp3BRubt7/pVc2xO/Vf/nI2Omt
 Oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639114; x=1752243914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61hUKPP4NzlChuyDFmm/IMVLnPZIGc8U0gNoQgzlADg=;
 b=waZCTLLdE71h+yfmhoRHQC0tu9WMg1WnzUWa9ce6j1LpmKIX+bn21vuQqqwcSjnSlQ
 Vo28Nu+jjTOT7LB4EceKprWdrrYmscWwTpl+k5X65nmAVjX5WweY8EMbwpm5fmTwSlKf
 jV4E2ArmfHqNWhGx4OuhtlNMwZWNF3MbbxzlbnnGPc0p9OD9Mja+zK/x2CyGwgsxbSZP
 pH4qwe5n2QkemlOwujTV4vD+hN0VprjU/3n1WHr6+hOZTfvViqnYAq7k8TOTdJzwKhMn
 1fV/TZlIbi27VBDDCcaJLzHPpi9Wwvh5E59oduat46GEU3KFLQCtryO7fsKs8Q4sc7Ps
 xDhg==
X-Gm-Message-State: AOJu0Yz7nJe1dJmd2Om4ZO733FR0ZbBIAGJsZKimmRwEKPbnDNFMezhj
 U7egRlIndjHab9rzfYRS//dNcWuLw010hRHQZVQ+xt+t2mhEm/kAcm1g6sb85b7c0kTkhEBZYTg
 uvpSHm9M=
X-Gm-Gg: ASbGnctwm2JCcrZxIxhAMeclUbmDVjApkRc71/c/ENmGN01H6M5+mwJpnOuVDR0j7zx
 OsLJmd0E4TkydFnT1Y2Q3DtgTKVfURCZdyK7evNidDdhvf7FOF2y0fvICX9M+mDX24M+tkf+OCq
 n4RQJY6/8UGtTA/pSqMfRlEFXq3lXpf/0ypSzIVz75zyzPffAarEED/XTI3Xa1hXx+f3Ltz/oxE
 v+qF9i0kK2NdLhMa3s4I7Zk7jE8uzr6V1tInpbuwm4LLOGEvwqF3iqDEVUNRxLdZJGdNl+h0wsM
 bpZQAejWVvPlAhpvDrxS+VryFZqKUyyjM/4Qxe9g+gLTpnUZLlaHq17geqnwaWw/dOfuFXtzObh
 faMYElFwZTjP1V1VY6R7dpnWQU2Bk5bgaYem+LCpYjFw8JOt9
X-Google-Smtp-Source: AGHT+IHHQ6Cdv++M4l+PRCGbRZoQEGYB5lx2t0bKDCpP3JF4u4aJJNW1Savx5tYqng8mI0GN21qZiw==
X-Received: by 2002:a05:6871:8302:b0:2c2:3e24:9b54 with SMTP id
 586e51a60fabf-2f796a5834cmr1688497fac.11.1751639113962; 
 Fri, 04 Jul 2025 07:25:13 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 055/108] target/arm: Implement SME2 SCVTF, UCVTF
Date: Fri,  4 Jul 2025 08:20:18 -0600
Message-ID: <20250704142112.1018902-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/sme_helper.c    | 22 ++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  5 +++++
 target/arm/tcg/sme.decode      |  5 +++++
 4 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index be4621f2d9..6314ad7e01 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -219,3 +219,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_scvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_ucvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c696246d15..d3841400ee 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1636,3 +1636,25 @@ void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d1[H4(i)] = v1;
     }
 }
+
+void HELPER(sme2_scvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    int32_t *d = vd;
+    float32 *s = vs;
+
+    for (i = 0; i < n; ++i) {
+        d[i] = int32_to_float32(s[i], fpst);
+    }
+}
+
+void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    uint32_t *d = vd;
+    float32 *s = vs;
+
+    for (i = 0; i < n; ++i) {
+        d[i] = uint32_to_float32(s[i], fpst);
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3bf2b6935f..dce3b56de2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1370,3 +1370,8 @@ TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fs)
 TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fu)
+
+TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_scvtf)
+TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_ucvtf)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 79df2dcd2b..449d97bd28 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -746,3 +746,8 @@ FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
 FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
 FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
 FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
+
+SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
+SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
+UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
+UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
-- 
2.43.0


