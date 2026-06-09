Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8936BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28s-00063A-8O; Tue, 09 Jun 2026 15:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX22I-0003kj-G8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:23:05 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX221-00048S-L8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:48 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36b8e1760ccso3754499a91.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032896; x=1781637696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oDrRjtg5nfZ5vjh8T15V/mP3P6ZgZeyczIb6aAmmMA=;
 b=UY0fxOCxvUCHCappii3i6dVTuBjs8ZDBloUfitr0o9TQQFY0eHk5yI7jvg9W63MF+Z
 G5cczdIYd5xRYMMFx70ciGyRLkIPkobiCfu5HwkQl+ZNe3+JQqzert92TIUvMAZFLS29
 93gjkoi+0Nteise+0eRQAGrfSEL8Wce/b90471CnaAUz0Bh/J50SrqntjSCj7jyppcVJ
 XIX63hSxy8RN6wkm7emkZW8MSjrEwW0YIa1/S8xUgYlp4aCKzFyn5m9l4AA2rEhPZg9e
 Mk0VAY8DFhq3f7WcKb8yg2V2V8M0ltf1HfloWInzIJSr0Awks9NgZavDvivrXGh/wAI9
 wDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032896; x=1781637696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oDrRjtg5nfZ5vjh8T15V/mP3P6ZgZeyczIb6aAmmMA=;
 b=nGQnARXpSQn3UZ3ZkM/DxvF1lcrmcai8tbq3hRPcXn8SpYbyXhN5tlIDMs9Qxb1e8t
 rurfVAJERvbs++PgpJsm+vt68SPwPIK5FpEiR72LMKNvwhMMSvwjUhL7qbMfmw9L4wW1
 +lp4s8MK0ctSl8dNGKsCC+QBLWEmOdvlegS6Cm3id7Z6Z61X3lABEBTZ6iXmCkuD/Fdb
 rOyUC+w4E5nvDeKo3tYktXMdbT5zClmdT8E/k6WSZ3mJXGZ00DuacDggMqEN/mR/RqWv
 Xl3ynIVSlIjSo6pg4rJsA1AN8roXSBsC5ixQK55BPQQJVFzWr6AX1NzI5woWgvJaJ0Ra
 LGlQ==
X-Gm-Message-State: AOJu0YwgeST8g6Hy5nwn8sU7E6XMxUhUP+AKyka0RMzFL15oDg4rc3cu
 KNZQr5NSE6TH/MFuaKrRQQMkzUuedXcmK61scFw8KpKhF/DebrP9IliiAaHEjUXptCbQpLcRbfJ
 5S56iKIE=
X-Gm-Gg: Acq92OE0fNTrUM91H80gSq8pg4YIXlu7dM1Tc+KuW5Iu8q84cSdM1qVAJCjDy+N2E2n
 mwjk+dSyG2lcEffuNkE0Y4NDc2H1aNP1YW++SOk9rftGsZlyxNA33sbBE8UrIM7C/0kItSmRtTo
 Q/JHy8aSDzqSWRON0P1Y6uayApTWme0u0VPquTlZWCxNkrH0akfoN9/BZ0YCkUF7bXIUX6BC2Si
 uL/8KReoFFnq02Uy+HAbjsxafD/AHHi7kDnL3vww/pyJYRjZe2aQun131DJoe+tvvg4HlCquU6u
 Rnx5xP9dso05EQayXX8yP5lH9m5NGHbkXXiZ0wQKmUkWndWF2YfP7Sse2YsNfMaFLNriNFD+k0r
 Xj5iWIRG0hXdsNDDePGrPgy1WLaKC6a41Qk3NNM4T8JymYlnqFYPLI71/gb6zDQ/i4Q4JiglWB4
 E+lnwdUzACbOBAa5MNXlH+hPvBVqDzZYBq2oQI8VM=
X-Received: by 2002:a17:90b:548e:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-370ee33d323mr24806792a91.1.1781032896021; 
 Tue, 09 Jun 2026 12:21:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 32/45] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Tue,  9 Jun 2026 12:20:56 -0700
Message-ID: <20260609192110.752384-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 453bae3a0e..9f207a32b9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8388,3 +8388,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


