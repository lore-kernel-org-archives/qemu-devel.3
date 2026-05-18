Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96E4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSj-0003p3-RU; Sun, 17 May 2026 21:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSP-0003XG-G9
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:52 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSL-0007LE-DB
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:44 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36974221f93so591659a91.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066459; x=1779671259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFWysrdqFoMW2IrtQB94n524fpVGqrr2UPrR7ekmZSE=;
 b=xvqENnbTD2CH6sM1m7TSIaJXXy7uhRMwQePvjUhZjAdaWEvE378ucsjQCWx08kgwdl
 LCjlbKzLUL2rbcqIwq5JWjJj4W6/07Nutj3QTubexZts0lLa05bA9DMOE+gquQR13qYs
 0X9Kv8jnUiygDniuEGIBmQ9YGZnT9F1/EddSTnYq35xQq1RVo0xDjlFOdKy+E3ump8ed
 d/Ju9A/LB7fwI9GxM2gEeG5HFlServL2urZI/p483ZjX3qNRG5peObCSQ/EXd9GCkCuv
 EYdVuUF+Em00iqYKx50k8FhDAcR4KXhHxQ6v/bah674uGoTSBFW1CD0VM2Hmeqt76hr/
 D2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066459; x=1779671259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TFWysrdqFoMW2IrtQB94n524fpVGqrr2UPrR7ekmZSE=;
 b=XJLE+e15pL3UYLrY/uD1+RPuERt/nSQFhaVpQ4u78OHKVZxUWAHifjgQyw8UgpphQV
 Xe/93+Ga6NoQF/qra8xgRgDgM41iT+F+YQjsfFh6biiSZvfWk4AZ3lqme3A0tysADA7w
 aJtmxP0Vc7ntb3uoNZueRCian5sNUrYKDT6kysXneMKh9126eVBYYU7txr7c0ZNXuke9
 LwKmmTNSe3Zd5YfF+gIGt2ncjocglMgUNs/vzncR/GKVwh/DIir9TFBprorcAD4rCBwp
 wD8qFHtNdcdGiUz5febVKFHgujAZsCy+15y5cBraUT1YSwHFpcRnmxjRNnj0GM9rw6I2
 igmw==
X-Gm-Message-State: AOJu0Yx1I4KzrgegRvWDoZxNIKxLtvnxbNd1MDKDWtbF6MyvzQ/Dt0Pj
 lKxhyHikOaMq30oUhoehE4UJtvF9K3gFXLWKZ1ncCzGn3jWwNSXjqKZyleMrblHC7psLA6btf2s
 1XszE
X-Gm-Gg: Acq92OGxYRqYqsHsrq1E8GoyKAgab32fhFu6N3W0pSyU8+90gsboKWRJC93ii+zklda
 t5nXUBOMx6/SKWcr9CN/NAYqkggh3VwPgFtm4a4U7M4c/YBuNsxRab8S2C+EZCdi0d1pn7XGUzB
 4UlWgs/b3zYIGcsFqI5Df2hSnhLLa5eZquOntD8/BFXCcBCdKIMFSsU84P7smMMyPUDlWaECoDn
 1el70cn7dhO7hX1hqK6IRTDkWV35cop9D7mRqY3us8PzbVsYt6Af3/JJxQn7m+0gAM0fLYq4QXe
 abeEslOhWMf9BZA8b4g3M4MxuQGCZ3risjQ6BxBz8v8BTi3VgCRjRDMGtQPaxenxHbaCl2yIGDA
 T2/anWLIfJH45RgHnXVv4KpeXG/io4FpqHMzagLcgwVhaYwdzGjcN1RHkZkJA4qdRT5XR5AJbJt
 1Lh9LKT2E/axpYBJGykttQ/VOq/H0I
X-Received: by 2002:a17:90b:56cb:b0:366:132:fda6 with SMTP id
 98e67ed59e1d1-36951a022eemr12629152a91.11.1779066458976; 
 Sun, 17 May 2026 18:07:38 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 5/9] target/mips: add Octeon MTP instructions
Date: Sun, 17 May 2026 18:07:29 -0700
Message-ID: <20260518010733.502237-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

MTP0 loads the low Octeon3 partial-product pair from rs/rt into P[0/3].
MTP1 loads the middle Octeon3 partial-product pair from rs/rt into P[1/4].
MTP2 loads the high Octeon3 partial-product pair from rs/rt into P[2/5].

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
 target/mips/tcg/octeon.decode      |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 8ebda0ecb3..4c286b34b5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -218,3 +218,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
 TRANS(MTM2, trans_mtm, 2);
+
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane
+     * index + 3 from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_p[index], a->rs);
+    gen_load_gpr(oct_p[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears P1 with P0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_p[1], 0);
+    }
+    return true;
+}
+
+TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index bbd48d1dc6..eeed736c15 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
 MTM1         011100 ..... ..... 00000 00000 001100 @r2
 MTM2         011100 ..... ..... 00000 00000 001101 @r2
 
+MTP0         011100 ..... ..... 00000 00000 001001 @r2
+MTP1         011100 ..... ..... 00000 00000 001010 @r2
+MTP2         011100 ..... ..... 00000 00000 001011 @r2
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
-- 
2.43.0


