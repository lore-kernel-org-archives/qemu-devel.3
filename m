Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFF0C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdr-0008Sk-IS; Wed, 26 Aug 2026 13:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdo-0008QA-9w
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:24 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdm-0004kU-Hz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:24 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso1374229a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766141; x=1788370941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SA8NuNbPWvaRSZTQw5oEPqkYFFMVFwD+KRwGTdCfjnk=;
 b=vYdpk1kOfW/jq5olksVv1jcjScgRHVb4iUmoTjCrPMEllbXDXcdhPXNkPXvWEramwN
 OSJftVTFgAl9dFpHoL6OS9kymI/oavLY9928j0IoWDcd5LmmM/mOnVacacPAbqgnLHjO
 DllZsgfJaBSiVNdaRURwgH9BYpLer9anr8i/6eUlC3mEg+m+DYAAxqxY0/1H7wD2ch9S
 4ar4AH7oQ5ZdIbzMdY4dNDUaMeekQkAGCOKG6U6trPwSWUxSZFIn67TR8hpU97USxj09
 hkzCH4KnelWnxPBe4Y4AE9vgC3BZDM3C3qlCmoHLKQ+4ct66PKMbppBx9ib3RDhGiReu
 fYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766141; x=1788370941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SA8NuNbPWvaRSZTQw5oEPqkYFFMVFwD+KRwGTdCfjnk=;
 b=ruQH4ooRtM5MSSUcSEGpSkBAw1Kvuv+oW6OtNq5oz+AffjxMq6FGpEiAud9+WZCM4b
 bBLlz6ng9novS1OeH/y1to78msX0d0JWsRC9Y4g6FIZgiCCqceEQkggIDayViYCFMFYF
 C93iCIm7zPgpIfDL7PhvSCA8S0clmB8j1Gqjp/I8OZAJpT9LyNbxYOoWXGZ0B6+C55b4
 jpX5hbfIv2D9StE6MEMa2leQZCbrYy2GGclJ8ujNF02Uio/ulKQQQsZ8ceoRRRDMXOZ8
 27bygZ1hAk3nIOz09urtKNfVXr584ffR3aNTp/u/beZTTNHoAKBx/mUSl6GbpUqjyIuK
 NP7A==
X-Gm-Message-State: AFuF++nj5qudMPZUsC2dU9LZc5Icj5W2T1SES50/ewSzOCD5I7HwwHmB
 HrNhmAEdhqTlocvy8jpt+uGBafaope/pWzRbFFW/6TZDX9wX3MSuyV/Rz7885irng1VwiFYnBqN
 hSDwE6iE=
X-Gm-Gg: AR+sD12WB4S66vBbUnS+aKmZpgoZwFoRMVe6CJRCsPIgllXBFJlxjbL/0RabDEIQmj7
 DDfbBTrzGiP/b7VHq990Afm1NWHqxa4fWBE9+6m9GgXrBKNAkz2h+qDCWCB847ZTcljz8KitQSO
 TZ3WQYqu85xW6biO+TpQzGZru6MWnd7BTVtj7N+m69/sP62tovJsdbbbIlDalOxEWd6SRTptCJl
 wvK+PkFl6gCxnPSLtc1OthLO7NL9yQznaD+Z32ZIw7VNdwAGsvyWxni80sPzPDcdZ7v1QASHRey
 VQb8oV1qNlayhZ5bMjcHIe0XkEmU80MWkF+psZkFGtjWxV2sE0p9XTwBdZqkVoCXTFigKbl2601
 cimMUtiqGKTXXUouQraDhCWnTkHET81+z7N7QnJSSK3fdgl1OBQYdWN8i70YmvZoGUooeUaXtLe
 uR6DOqaRxxu5LXXoRudxk3sV8ftgs7xWhqWPGbcii159DhDwuOEknc74zIB3+1w9BoK1u0CzSC9
 adOhnVSssiyyHXuig==
X-Received: by 2002:a05:6a20:2587:b0:3cd:99d2:d534 with SMTP id
 adf61e73a8af0-3cf7576c442mr15885012637.3.1787766141003; 
 Wed, 26 Aug 2026 10:42:21 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 04/25] target/arm: Implement FMUL (multiple/multiple and
 single vectors)
Date: Wed, 26 Aug 2026 10:41:51 -0700
Message-ID: <20260826174213.614571-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 target/arm/tcg/translate-sme.c |  9 +++++++++
 target/arm/tcg/sme.decode      | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index db1950f407b..463754b057f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -891,6 +891,15 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
 TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
 TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
 
+static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
+    NULL,
+    gen_helper_gvec_fmul_h,
+    gen_helper_gvec_fmul_s,
+    gen_helper_gvec_fmul_d,
+};
+TRANS_FEAT(FMUL_n1, aa64_sme2p2, do_zzz_n1_fpst, a, f_vector_fmul[a->esz])
+TRANS_FEAT(FMUL_nn, aa64_sme2p2, do_zzz_nn_fpst, a, f_vector_fmul[a->esz])
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e1bef9987b0..60c7cacc10e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -219,6 +219,8 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 
 %zd_ax2         1:4 !function=times_2
 %zd_ax4         2:3 !function=times_4
+%zn_ax2         6:4 !function=times_2
+%zn_ax4         7:3 !function=times_4
 
 &zzz_en         zd zn zm esz n
 
@@ -288,6 +290,11 @@ SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
 FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 
+FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
+FMUL_n1        1100000 1 esz:2 1 zm:4 1 111010 ...00 ...00 \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -361,6 +368,11 @@ FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
 FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
 
+FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
+FMUL_nn        1100000 1 esz:2 1 ...01 111001 ...00 ...00  \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
@@ -521,9 +533,6 @@ FDOT_n1_hb      11000001 001 1 .... 0 .. 100 ..... 01 ...   @azz_nx1_o3 n=4
 
 ### SME2 Multi-vector Multiple Array Vectors
 
-%zn_ax2         6:4 !function=times_2
-%zn_ax4         7:3 !function=times_4
-
 @azz_2x2_o3     ........ ... ..... . .. ... ..... .. off:3  \
                 &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2
 @azz_4x4_o3     ........ ... ..... . .. ... ..... .. off:3  \
-- 
2.53.0


