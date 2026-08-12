Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D907BC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7su-00044C-PI; Wed, 12 Aug 2026 08:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7ss-00042A-2W
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sq-0008Tq-1g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so7804585e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536994; x=1787141794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XX9Q/w9ZfxideWA+DTVIJKg2uIM7w0m1Tf/rmMndDAE=;
 b=NhoVKHjJ633Gkv1pya2Gx5wc/uJabzn5sXNrEn5ALujKZR0+ua/5BAUT1ObEMAsDju
 Vipc/BD0M4uB5N6gDHzWpxpyjz6antZOnmGDN6fkTo5Mjnm4F42zFCqn53DmYf9kHwy1
 T5J7MccCc3qkOvrf/z6eLwR67AJLWUHNzbEMVzuDsREJpuiel4oWar7/d5cajJ6r846p
 zwM07XZRCMdP3YgY0h6T5scV83kH+FHczRxt/gupImqZA/WPz/Or0eWjZ8UGdk4gTjeO
 OVhQIFBgKdJ5a4jrBPyTyLKoIMEHt4kzqXd4DCHArMrP40Edgp63Kk3SqfwDVXqMEWAr
 eKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536994; x=1787141794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XX9Q/w9ZfxideWA+DTVIJKg2uIM7w0m1Tf/rmMndDAE=;
 b=niFaVGVg4r68ubjZMuS9WpkecorRR9MC3kN8DFoT7TbMTRQOaryzr/stUK6Ndd3crY
 VP6PcaySDtmTuOrAy2/qp/IlYlQpZbUxDx2PEdlYTfL+3DvC2+Wx+zc51KQUOA+W2G73
 rH70vBvntN/UsEkUuteyaYyC8kI10p9KTRnUcAndaakdCRCBfvAWHeLBj4CNSnUpW/7W
 3dRrycvjdWEdaIiPoO6osDHWQmRaHbPm8vTSIbCXaroU8Pc2dDZY3FwDQI3NIvDEViJE
 VC/HDKM+7R61S9XjtrZwC0wrVZ7Iff/kzvuyVorkgsJnK5KWIH6vCDNp9OA6GAnAvz8N
 YzAA==
X-Gm-Message-State: AOJu0Yzh4Y4NMhsLumuv3Gaj/ZBl6VJwsFfMkS/IM+4IxeMAcWwmczja
 ZenBJaIepXbf281cS2esnb6aWkqRZB/9+F55WrcsJtoXJzx3GsuQIpdtl4FFmkF/mdIOhIh9LRB
 OUG1j
X-Gm-Gg: AR+sD10OWCjXn1vd9HalZKFEzJrthcn2yzvPjjj1eL12QpTV5r5hS9z8UrSmE6TmI6s
 YemTr0zkKpq0t8FJhujVrFrKltHaEVT7hS6kMvjC+s+Ob2EY4GUXb9Hro6uWtFvhtfNs/prr3Ga
 c63m2vGjrEJ7+iFf2DnsZUbtW60ZTTJ0q42Saj3SUxh4Wd9joSz+FtMqQAbJHYQA0NO/GyA6dbO
 BQDBC8zJhxyygCw4TZkDMkPp5l8BrsFpkudt9DWOdTDW4PevJgz9OIuISQ11Lngjo/6lIk32VNG
 UvxEpShx1uNsUxgzlTd4r5v5aTqXgfHa5NhMdKdrPHIiRDguupZCXo7pOIYFuGqwL7WghPvdngt
 Kg6JrtskZ4NO0f4y/mIO5YU2lyVQDMU8EHdkxGJUK4XC4MDCZLjo8ZlMVDu0N+BBSzANk7gkHRG
 2jBcqMGj5sT7WxpXHdO8zfn9wimL/WOpZrz6ZXDGn4hwpaSzsN7tFWG+mwqQBQj7a9YtcgaEje2
 ge4XBjLH39zaM8P7uQYuP6rq/VjxoFz++L/JiyHM3OYYD47pEnnW4sbBIp6aH7Xremn0w==
X-Received: by 2002:a05:600c:8489:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-4997c12bc20mr67240745e9.11.1786536994277; 
 Wed, 12 Aug 2026 05:16:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] target/arm: Implement FTMOPA (widening, 2-way,
 FP16 to FP32)
Date: Wed, 12 Aug 2026 13:16:01 +0100
Message-ID: <20260812121622.649730-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 1 +
 target/arm/tcg/sme.decode        | 1 +
 target/arm/tcg/sme_helper.c      | 6 ++++++
 target/arm/tcg/translate-sme.c   | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index f05b53f412..8a959447b2 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -410,3 +410,4 @@ DEF_HELPER_FLAGS_6(sme_ftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fps
 DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sme_bftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme_ftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 49af8fd19e..5c453ea729 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1147,3 +1147,4 @@ FTMOPA_hh       1000 0001 010 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 BFTMOPA_sh      1000 0001 010 ..... 000 ... .... .. 00 ..       @tmop_o2
+FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 91447d9c0e..c2b7c23d6c 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -3020,6 +3020,12 @@ void HELPER(sme_fmop4a_sh)(void *vza, void *vzn, void *vzm,
     sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_fmop4a_sh);
 }
 
+void HELPER(sme_ftmopa_sh)(void *vza, void *vzn, void *vzm, void *vzk,
+                           CPUArchState *env, uint32_t desc)
+{
+    sme_tmop_2way_sh(vza, vzn, vzm, vzk, env, desc, inner_fmop4a_sh);
+}
+
 static void inner_fmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float32 *d = vd;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 66bba48d99..8a55b79727 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2165,3 +2165,5 @@ TRANS_FEAT(FTMOPA_ss, aa64_sme_tmop, do_tmop_fp,
 
 TRANS_FEAT(BFTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ENV, gen_helper_sme_bftmopa_sh)
+TRANS_FEAT(FTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
+           a, MO_32, FPST_ENV, gen_helper_sme_ftmopa_sh)
-- 
2.43.0


