Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB4CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYj-0003j3-3l; Wed, 10 Jun 2026 12:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYh-0003W9-62
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYf-0006Y1-B2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef82204c6so3904687f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108016; x=1781712816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hAbiCdrvtj6+CXCYH3qGTMb2Ur68vZqF4sQTbfSpP9c=;
 b=hUkxdpYudAy5U56HFmfsM1BegSdtFVwEdlZIpcuHBOijrZ+MA+zfH01Fv5Jm6JgoBe
 kpIOviuEDP9BqS1QL5Rk1q63TnuDkOu9k7h5JarARLk+n4jWF4FjehpF88Ru53+BLUJJ
 5TBRvlKa5DKsvmApHbzqJEQTP3d1j1TEH1ZLMgKbqdKJXW7QLrbX5Ax18/6B0JVhJ6pw
 5HjGGa2n/sVrRctAku4lZj4n5fS/TKzyA1uqFXt1ocmeCr1eK631CrZneYi285XMSiek
 R/vE0nXANrO/C8IG4uKODcKUmi/fapbDFqEdtVOjxbXlX2rDx7OW9SNKt0WvRKa72/5J
 2rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108016; x=1781712816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hAbiCdrvtj6+CXCYH3qGTMb2Ur68vZqF4sQTbfSpP9c=;
 b=lR8qJPZlvxRUMOk5at3xCb1x7S0fOePWeeLplQoU9FaBrjXWPkuY/mk4K33/D5EUVI
 MsrgNs++fR4nYsxNyRKWz0vA7ZoZ8B1zVCIbC1cKgerplrzcbC3yo7fk+1dj4Vs896hc
 B8Wdw1KwkDYgvbXMyvRCe/G4+vw5518EAfCO+WjeJwYdQSIDVE6DXB6DGKPEcI+IsyPy
 VhPApqoJXvwrjLDrMfFR9L6IZ85hVVwfkjtt5LyudPP3j1js/vY8nidIYp/S80955iep
 Zw5sinGWVy0i7LATAtbJqkuivP9wmfnhgJrgteDZTjBMY2koohQz7/R51w6aqqBEYTm9
 9VxA==
X-Gm-Message-State: AOJu0YxOc0akZcwBZ4O/m5vco/o9vmR+8UuU3Tq4+uqYbyRtBjSNjWbs
 dEih3wyqsTE1BnFLV4OPx+1KcXVtC3PKDcZM2PyMxrXuJJUg6VhSwduqRRsM25/VkqqIZaTyxtF
 fOwXD
X-Gm-Gg: Acq92OE03gCCCsuaunlWaBFwpruwMXe6wAHTnFwncIglQoHt0yIUIN4G4jX0e0E5+ZV
 euAmZHSyQgWuzdZdSe40aLps1hlhvHtX6KvclsS0RfRbLGZqUChNGGQKwhULmOtQMGbAgbxM78Y
 sjbR3mqHOFApMoVJzxylgV0CfCCxvvpI2CM6IeQ+RExl/ydh2HK3NWNy19T+OX6Nqg++fwJj5k4
 rmqLmixz+BHh/rzGeRphM45/lT59opoz1054T+om3T+oYHdymMXtsz81GYD6AmW/BjaUOuv/r+w
 XHUXPCE0ifdSOvYx5nRgjt6dAKAt8Zus0Lw7ycoDkSX5yi/bzaU6aAlIbf2EFlnTh7YM8b3T39O
 KIEPWE2itmKu/JQIJHnHHOHfwR9KEWeW9VhpddFF7gQpyZgIbNV7eCXnpII4/VWkuMXt6frMrgb
 4lPjbRz1xDIdAYB2boEi0By+Y7yXAvSdexpkzNFZZgre5SlGFwpwwEH5OApQilW6HkablSqxN1g
 WxbKIIkiophvlJkX5Jfh3F7w2yKbRPFy4xHCOf57M4Z/wJM770Pfg==
X-Received: by 2002:a05:6000:46c7:b0:460:e0f:8d19 with SMTP id
 ffacd0b85a97d-460302e3193mr26420647f8f.9.1781108015971; 
 Wed, 10 Jun 2026 09:13:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/71] target/arm: Implement FMMLA (FP8 to FP32) for SVE
Date: Wed, 10 Jun 2026 17:11:58 +0100
Message-ID: <20260610161202.2235298-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-42-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sve.decode      |  2 ++
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index be3db5300f..67e9c3bd33 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1718,6 +1718,11 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 26b3c7697a..6610432528 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1808,6 +1808,8 @@ BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
 FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
+FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 Memory Gather Load Group
 
 # SVE2 64-bit gather non-temporal load (scalar plus 64-bit unscaled offsets)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2cc5e129e9..f6705ee95d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8461,3 +8461,19 @@ static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 TRANS(FDOT_hb, do_f8dp2, gen_helper_gvec_fdot_hb, a->rd, a->rn, a->rm, 0)
 TRANS(FDOT_idx_hb, do_f8dp2, gen_helper_gvec_fdot_idx_hb,
       a->rd, a->rn, a->rm, a->index)
+
+static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_sb)
-- 
2.43.0


