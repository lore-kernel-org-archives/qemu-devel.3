Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E67C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggir-0007W5-Bq; Mon, 06 Jul 2026 06:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggin-0007R9-OL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggik-0003WX-Vn
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493c55d5c7aso27577375e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334317; x=1783939117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SzAZgvAhDLLRTgNUADlWm2n67mSAFWUklRqCzz3wzmU=;
 b=oo5JICLvyixkyhFXMXXqImNRR3dwiGl4MtkRo7Ww0gikM5O1XaicccOBW1O/4zLfok
 iZjOCcGqrLIe8L6TggRw++yplNo6Wty9EOJc5xSgQp4epTJyZQAVz0JfRk+7LD9aml4w
 dA5RSndOOFIon3Z2ucOIjZd+bschjhQtWZEpN/bQmDZFB+azy0k98aFqWNnG59RUUgl3
 sNsRM7t/7XTQH56Yx3MqgQYGeIflH2jLqlGwYAQtzLhkfOL5S8FQVpS19QpRfT7H+vWj
 ufaVSMOsq1O6UOcRtn7a2WTy87EMAS6mRMo8xGy/aDYt2PDY6N8ztoQ09IN6jTXpFScU
 KGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334317; x=1783939117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SzAZgvAhDLLRTgNUADlWm2n67mSAFWUklRqCzz3wzmU=;
 b=eQDxKSo4Tb8SxIPKQ4KA3sd3kH7FTU+5NiKVO3a8P8LSbKM/EEkSbTS44y9PprJiDF
 hhvq6GwOK7Cnv1RNXqu2JVyNyRkKFESlKffuhW/lDvOmvKmx4DMmWcqr1K5C7D/u7b3t
 a7nv8A2NrFzPTcDDzti2WrGyDrrQ+H2hFC7su5DPJdlgMAEnRRjmI51eWpwURmxhqG4K
 9xn+lLQIQOM5IRTW2jwU2YzVwNplQAC223TfJEyWSNX9WmeLUlE/4UZ70esOKk7rBo9W
 lpkyAxUzj+/Ij4iRmSYIr119KB2v0SzARtCNXItS/AJmPi0vZkKB/hMw1lUJZvJYrg96
 rXnA==
X-Gm-Message-State: AOJu0YyeGGmE+zyKuq6gDw7o/X4qBZ2JvHnNnjrGlUBnul28w5sQVtf2
 SfnX+XNFMuGcA7955hkB75D//neqmAfmNHn4ei9kwEIZ/939CG/lbKQOZbctMGgZYnIDTJaf8nk
 Mcvk3Obpz6Q==
X-Gm-Gg: AfdE7ckKRoESfPPZeQn/28szwnDnFhnEbW/MDpVdmh9l2bOApghP4Tgzf0SriXDsG6g
 gRrsLXBFuOCuVsfi5EpqU7UubzE4w9IwIR8o3fRcIUUstaGz+Bff1ltpIV65YL5QRbZlb9JnfK+
 340fAbcRvdlA0thNtB2diMwTjfWqsBIPeSCBlgOgtp+zbgEu7kEUwIs6zFyY+BvNK4JyWueJuBo
 /v/iuCxgAxzqzohggZDAgzaEgwqFlsmX0AmqFhVono675vyx9uAkUtYWXQPlollQ28dPmPp3WSI
 bLCpi+BUY2wXVFvRaPV9N+9/wVGMr70onZHjutX16fGm0xbOt8zgo4YrEaIWd5PZlAS45CWG3AM
 w7I7ALwfseeh6yZhhcOx0cDO+xHJi3Imxz0FnWS3GON+NRAc+MUa+8SQFlOm9Dtp007OBmn+r3j
 4P9awiHnDk2YoPZ8/tYGFxAjwoxb4xQMDi4tJ7WuCSVGEsUAz57p/JZkBup5N1XSyHY9enp+UXB
 /vqxeK3DrgZ08XkhDBMU/Gx01dTi/2r
X-Received: by 2002:a05:600c:4a22:b0:493:c3e0:c4 with SMTP id
 5b1f17b1804b1-493d11f1593mr69431615e9.22.1783334317534; 
 Mon, 06 Jul 2026 03:38:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/49] target/arm: Implement SUMOP4[AS]
Date: Mon,  6 Jul 2026 11:37:44 +0100
Message-ID: <20260706103752.320511-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Message-id: 20260702204314.79224-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 070a1a2c1d..3da40d9f33 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -386,3 +386,8 @@ DEF_HELPER_FLAGS_4(sme_smop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_sumop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_sumop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_sumop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_sumop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 16f86a9d2d..aef3fae8db 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1120,3 +1120,6 @@ FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
 SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
 SMOP4_sb        1000 0000 000. ...0 1000 00.. ..0. 00..         @mop4_o2
 SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+SUMOP4_sb       1000 0000 001. ...0 1000 00.. ..0. 00..         @mop4_o2
+SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 11d9d509ec..5a9e3b8398 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2972,4 +2972,9 @@ IMOP4_4WAY(smop4s_sb, -, int32_t, int8_t, int8_t)
 IMOP4_4WAY(smop4a_dh, +, int64_t, int16_t, int16_t)
 IMOP4_4WAY(smop4s_dh, -, int64_t, int16_t, int16_t)
 
+IMOP4_4WAY(sumop4a_sb, +, int32_t, int8_t, uint8_t)
+IMOP4_4WAY(sumop4s_sb, -, int32_t, int8_t, uint8_t)
+IMOP4_4WAY(sumop4a_dh, +, int64_t, int16_t, uint16_t)
+IMOP4_4WAY(sumop4s_dh, -, int64_t, int16_t, uint16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 6f3806f4de..fce07b2565 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2114,3 +2114,8 @@ TRANS_FEAT(SMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sb : gen_helper_sme_smop4a_sb)
 TRANS_FEAT(SMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_smop4s_dh : gen_helper_sme_smop4a_dh)
+
+TRANS_FEAT(SUMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_sumop4s_sb : gen_helper_sme_sumop4a_sb)
+TRANS_FEAT(SUMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_sumop4s_dh : gen_helper_sme_sumop4a_dh)
-- 
2.43.0


