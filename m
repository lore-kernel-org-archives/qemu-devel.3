Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B3FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFEJ-0007y9-E1; Wed, 29 Apr 2026 20:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDo-0006V5-Iz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDm-0007Yv-1J
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so174910b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508736; x=1778113536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4jpUR3TlL8yGAheKTyKt8861n/irmD9eb1yDY+JyNk=;
 b=tCVcN01YXE1Eqsvu5uewt07Qe/rHOuGA2wEMFWb69gedTP6TnImEpRmTjh1dx/7Mmx
 +DxJXQjJAUSONN5pijgUPtAiokpNXWbI/M+pwjujTC0Hriou+kza6hmlCg8BrTaU42vl
 V5iX3L6KTciXDVqtsRFmmmVZaea88sa5FR0YLOQqH0cW09m0BqSzTPeO+HofjkIBZkFp
 /xsVRAdDOgEk2Oqm+QWgQyDtbUbYYy//1Atb96nxJtEJNQfWb2Aq9qJKbUoBwgy/BCoW
 O+AqN6TRwwP+qKpOSjEhhkDDOGXGPLoc6Y7pADCVUdKxIL5qSbM8cM8EYcZKUFiq4ev4
 FuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508736; x=1778113536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z4jpUR3TlL8yGAheKTyKt8861n/irmD9eb1yDY+JyNk=;
 b=LCh/d08ajFuAeQXMfc2WZ0JS6vVaY/JJ1SdcVBYns0LZ2I2K31fDPBhRQJHGV43KFb
 BTr6yofQwBWcVYEZpexEeGFV5PrbbShanaR5C8x0W1Y03BH1dNNA7ZtyS/Q6BbLY9Ujm
 CLu3qzqQnJ7jG3tT0sL9gt2R0BepOu0YgftsCBfvRSiARrQVqLX1/ZQUZlWndqtqFHDY
 gOKwBFW4wzdWLPpzfnshIT0ekkszC2JR91jvlj5KsXKjL+35ane+78cy+NRhftZwQCuz
 0MKV9E0QSyNBPvvrJnnPxuhft4utZYJALy8kBTMgvlBBpPzmqr8crqIhMifOOPU7fgrW
 JCow==
X-Gm-Message-State: AOJu0YyhthXIH6djygqvOc8UvTPu/S8FLmJxC9v/IuUil2IBPQ6FnfoS
 fkb3um9gJhHEhcL+B4S44I86BDPiKNJQ5eICdN0VKLq4kJRainJxMkFA3hlA9yRQW7ExOlSfnyr
 SH1hEa6s=
X-Gm-Gg: AeBDiesq+aRjZ7alvkQNti1HKTNAbK2CimYsO0aGcQLo+NLlMqr5Emz7t5Vqvye+MxV
 Xy+QpNVddM3IktNce+MBo0lvJ/5wU4B/3AL8mJq3I7Y0kqGIGIbai4IM6kP0eu3w/gd2FB1U9e3
 WuwnUdoDEu4zFpojsEGyzUAmap+xA03iIzpj8TvWdLTv/y3MdhGw4kVYzdIpB8BtdvFVyGMVB7e
 sEoZXFKwDjtxjVPhHrWy114TSt/xaYl2tlb0cXfZinPq9nIJ3cQwm+kLzxQogUK6WLbIOYJRN76
 CnRtVGoPXlC727Ow7hTl6BBbB/nNO4x1a2T56XFRkdjMlPLKGu071vTJWG7hyLgVsgwcO7ULabm
 EMgn4tX/ceOmh62FBpHHG4UqH2ZZImlvhHQpDQXbsS+ysCDD++u7FxOIJopIoj6KfjtTm9m9rwB
 k5ntA89eOQjXz4MZnkySjYsw7g2nT4HxoB5OW9dbzD
X-Received: by 2002:a05:6a20:728f:b0:3a2:d629:16a2 with SMTP id
 adf61e73a8af0-3a3cf3fdd3cmr649260637.10.1777508736074; 
 Wed, 29 Apr 2026 17:25:36 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd64f21b4sm3204112a12.21.2026.04.29.17.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:25:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 46/47] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Thu, 30 Apr 2026 10:20:45 +1000
Message-ID: <20260430002046.59739-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index aa785fa0c3..e23ca43f55 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8369,3 +8369,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e6c8e8fec3..c93d8db71c 100644
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


