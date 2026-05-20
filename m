Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E22CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlbz-0003U7-Pb; Wed, 20 May 2026 14:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZG-0007fH-Ul
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:54 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ9-0000gO-0i
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:54 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so3338596a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301353; x=1779906153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Dz6Qruyij9ET6EEmMISyWGCg1mDrJrkY0VmvnEJBmY=;
 b=jYGW/Ht7Py3Ena6zVfdki3u8bhadJ12r9zs5asiBRaI8GKmjnp0/T+lcQSlumAJKgR
 iDgn+rotpU2kFvYNAQgikNpHgPn1oejBCvWcI9v5xq8zSpRFW3ZPIO6LOH43fzCKhjeI
 dm0yDjiz9ZkPbaHM6QgYqgn6Y9lGrzqLndhI7vWiNHuTetalYoVxTlrL/bS2PAU44FZ7
 00gFQ/tFTB+pcEdujICu+5+qtGzW84pwwktEhscN3HrIvg0n9fmcLH3gVEwHqJ0CXxKL
 sipWFKVLS6tzUC/Ab5tNIiQw4nzcj/bydCqmNbK7GFmgBHKhw3x5X5BRAev1q/LrBpnP
 6qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301353; x=1779906153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Dz6Qruyij9ET6EEmMISyWGCg1mDrJrkY0VmvnEJBmY=;
 b=ZoQ1Y8OtBBhdR0nj+0qnH6NrnUSneetM2NWwtBIGGY+ERi6FvPOUYhyRnVCO1p/6ec
 rE3HHvUSQjGK9ZZ+Xk7YHIo9XwBJ8Hr5TTosJuB74GncU8CigMtkqseDAJmxKNR5qf5B
 ItFShXvwr6Abvn7qCtKxjR+Q4dvLHEEZp3NoZYAYPv0ng8xoWgulvQUvL4+KTMI5jH9U
 QnSH1ErvGBYUgC0TKhXQ3V52jM083gvai2IStemY8uRzOlDVIICgMwHUB/6qK5hleGVb
 Fut5tSqxg9YSA4XhBgxASySX3XdQb4ZRX8iEZn7uEG/DYC0I9Gm1g8+hbukUeCNo3l+Q
 ZQIg==
X-Gm-Message-State: AOJu0YxgO+v0cNA6o0Ig+sSF6NxJDhextLTBdYIcRReahQRxT5FLfzZk
 eCavJ3qEzXkKf+zB6hbcyb7FDQcupnBoMA+IdueBp2JYDcqK4mCA3VXZlxUOWNNRkGAuqc1Mq1Z
 b9ehn9L4=
X-Gm-Gg: Acq92OGOVaiZu4mV1Hvw9eNfoUNixvtIopGpKirjNHnb+yd0JqXQVwK7ZxIbi1dUtir
 kP33Hqoqq1ReMWmefitz+IuQYqJKCBJAyXOUpy5Jgjseiiz3sXPJA5bIePN5gCAge46XVWSURIs
 1oTypurDjQeQ4N5Iv0K06I8ayv0f+2VZn3i+r40FkoBD/tL7WtMkUiyGfbHLSnWv2iDhRUawMSL
 cLu/EkkCwZ8bT66iehbpoSYaizVhNL/fZNMEnDytGKwe37/dZDBglILXhGuqcs8PPj3kJCla6bO
 CoFmKedE85lJgdIrwnVKBKcISicFlub4SK82j+kYuK22MDp+r1i4PyXe+cPgeXNsjEvZTY2V9wD
 GAz4pfI9U90EYteZ9BRl0jERSbYouy29PxhYDO5oVg/NxGFjg7oVNW27NQmSzWe0bvBbWjeKPiS
 n4oRdqH+taIpufAeYICZtKEF9rZZe3
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id
 98e67ed59e1d1-36951895b57mr22466333a91.3.1779301352762; 
 Wed, 20 May 2026 11:22:32 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 26/64] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Wed, 20 May 2026 11:21:35 -0700
Message-ID: <20260520182213.872945-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
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

The existing pattern is BFCVT (single-precision to BFloat16).
In preparation for introducing more insns of the same name,
append the operand sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 2 +-
 target/arm/tcg/sme_helper.c      | 2 +-
 target/arm/tcg/translate-sme.c   | 4 ++--
 target/arm/tcg/sme.decode        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index c551797c6f..01aad4c231 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -250,7 +250,7 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0055e97a2b..a0f03c4671 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1742,7 +1742,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e2d17de165..88c1d78c40 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ee874be1a6..7a8e1abb59 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -789,7 +789,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 @zz_4x2_n1      ........ ... ..... ...... .... . .....      \
                 &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
-BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVT_hs        11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
-- 
2.43.0


