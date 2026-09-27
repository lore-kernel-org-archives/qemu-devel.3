Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CFC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkN-0002TB-Uh; Sun, 27 Sep 2026 05:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkC-0002Q0-AZ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkA-0007Or-Q9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:24 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a2adb9bc3cso142380a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499620; x=1791104420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EyvfVIpbqiYFMjTw3EigaFciwRRnh2+tfSMPM9zFtlc=;
 b=mnQV393IWI6oCYmPLU8ZBqzBzZiHS3Za16xfL42WE65WXA80/os4mSFGlzVwRjD0xr
 6fAYz7AQ7y1i0/eoXHW/8wbfI/vjE3yipMITtbVLxb9H9XrIddzUZh9+Frac9X8YdIC5
 o3o6f5f/Honwd0tc0FgYceZ0jm5B3v3dzMKXnmKR0bsFJtuVhePX7l+hQdh3yfOaqDzb
 Fgh5xt77PxbUYmlfQKbabkCk02vmc8zo8wQxrI4rHFN8B8hbR5/nqNVEEkzdVRRIiGvl
 MysGWcGJFHV6TtfZnsTW609flzYYl0GuJfpJCTEitMfZdUfTXm4q0P7iR89jUVWXBXe3
 pNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499620; x=1791104420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EyvfVIpbqiYFMjTw3EigaFciwRRnh2+tfSMPM9zFtlc=;
 b=0pWBPSh9dDZ/ogwZ2niSGeIpZPiJqDyUsNwPBy3Vz/9aXAcMj0/5D546NUl/wirc/J
 j0+DZlpVVxeRCEobFnnfufTiS+e7yYr2IpGRyFQJJkXXiFNj8pWAnoMOzNSgRlyLw5Zy
 3mKiwstvcQor/a9CIy3M+PCguoaW2pLUslODJXPCP2Pv58KNvL40XymnxLgh9RC2bx5q
 t0orWasJ5b5E5Pklbuh5Jc7T0s8fvSWf+nb1ClctxPSiFz1f2lnlrSFKk7r7uUCAddGf
 UvCXCrTw62Km9PfjR5nD6WoBqaGshr6k+g8uN5iqsmcLrvKeWErGxTIT0U/Aa88myH41
 nXDA==
X-Gm-Message-State: AFq9FYK5K6dlYMQLEoR7JWBTG2am1V+Mg6l4pa6VE2bA/0ESC5AtexYD
 M6qcWJeTWYlZBW4HNBt/3p5IuUTAYAgMNwR34E7TVB5aPAIOSbLAPnyUExdXU7J5U/Z5tx0xG42
 rNGzf
X-Gm-Gg: AYBFou3fDuSxdQfm5XT780fBUa7koWDEtjZu9yNqpt0zJdPoj/eUEgV5zuGMkPpBv22
 PdxrZNrXQEzxpZ7ixlS8WMCLKRKsPEoE3RC9V4Yc6NnA9JGilC5mdA/Iiz5wPOHgi/w8R393Umd
 WmY2W+5W8WAO+/0qY7LAmWTZG9zA5VGkED9vy02Bk1gQc61yWwQLn2lbOKiI9RdU4wlUCgyvNCc
 MJPzVI+NyMwNTZIbvaSnKXjWjGf8Gg8YyPp7qiAQITp1+v3IwoOVETR1LjFq2xl3ej1DExiUPPi
 tLHM/NF7kHGb9cE3hIWW/yV78O7SCNfRy0b3Bt4vNjQmD/mvCn5/S0edjw6Em6ctS3wsasGDl20
 8yL1Geb2qyNZBtrSQox5uZNa/2LzevfRFpoEfZ+IOJognBia1c0zOUmwqJOT4cAy2jEN6zCiE6L
 i9LALon6qS1rIFOtzj8M9rymYAkHG1igzv2hFDoiu5eYJFEiRoIABtko/gkf88amdTDbvZfuqqQ
 EbRaUxJOTb4yC7e8aqU2fO9d8XD1A==
X-Received: by 2002:a17:90b:3c87:b0:39e:6c68:1556 with SMTP id
 98e67ed59e1d1-3a098aab6b9mr6941718a91.30.1790499619770; 
 Sun, 27 Sep 2026 02:00:19 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 007/101] tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
Date: Sun, 27 Sep 2026 01:58:37 -0700
Message-ID: <20260927090011.10724-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e826b62574..888f00d5f24 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -497,22 +497,22 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-TCGv_ptr tcg_constant_ptr_int(intptr_t x);
+QEMU_RET_NONNULL TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
-void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+QEMU_ARG_NONNULL void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
-void tcg_gen_discard_ptr(TCGv_ptr a);
-void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
-void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
-void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
-void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
-void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                         intptr_t b, TCGLabel *label);
-void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
-void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
-void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
-void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
+QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
+QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
+QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
+QEMU_ARG_NONNULL void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                                          intptr_t b, TCGLabel *label);
+QEMU_ARG_NONNULL void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
+QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
 #endif /* TCG_TCG_OP_COMMON_H */
-- 
2.53.0


