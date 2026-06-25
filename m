Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCB6CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfq-0005O3-TS; Thu, 25 Jun 2026 18:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsf1-0004aq-TR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsev-0002L0-Ne
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-845a3c05e40so144419b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426731; x=1783031531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8X1JYqOItFLkLZMSnrhpgKQ+9W/lqS8gJ1yRX2FcVw=;
 b=KiTf3+ukEnwMN1i4HhcaLrtJjlXuq1OaDuUP1b+ztVjofrdZKD9u9wXhkI0RDE6tD8
 2i7+2ygCv2OINeiG8HXxRuFLCwSYhYlQxTPycavD6qVhafZrm64QvAFvh6RsJsDL4flD
 WEYypLfxbL7cpRYIGWom0ULTwm8kZYZ59yNG00hE6CZqqNBMlPJx73IjIsky/NLeXoXa
 ChvMKOqPeGP/lm7nw5usKuP4TbN4eLyUchkqNUSY0X3DYrQEXJSLk26feoaypUH0N7W1
 muu7Tcsj2Nj77wMKUBI6J6jI/m+VLCZFq3rkQ8mInn5Vrrp6jZvxdm79uATC6MRwpAfU
 Fxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426731; x=1783031531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8X1JYqOItFLkLZMSnrhpgKQ+9W/lqS8gJ1yRX2FcVw=;
 b=XqJiw3Qu/TlvXlpcaASMqo/bodNuiMaUYQ+dLcttgnfXkiDBx5xISzVoQQW5iayv0d
 uwVg6JYlKpjEK48YJAF/2dAaftqyIVIMXwetAegwAE8gUZFv2J/VIlEAm3oet0OJHLMq
 eDe9Idl08613MiaswhOI+i5Xi+R1l2OVcnDdV0+5aVxTMRja+rKbjjMiQ8rk0xFh/gl2
 3uojRREVoXF1umWozOz12fEtjlP7GuCO/fr++qsPgxBSvQufz688a7sTE5ZF01Ol1DE/
 xKxqadyevdACg4swnMFjXJh8VnTIqTeIrSg3+5TvE0L6ppYHIV0j+qpywgXegda2tZPF
 q3lA==
X-Gm-Message-State: AOJu0YyNLATKOzyVHsIkyUqsB+qq7rtvbnsvg6CQpw/MZZ/GfiwhUAFh
 wIgp1ORLxAGjCu58RZWQpkg88b5btu3d4oExrCfs5Q9Z9YuC8L5RcLe9esWLa6XxO23x0zJi8U8
 oY6Dn
X-Gm-Gg: AfdE7cnwUw/XKU1oYKlwDVWv0hMUz9bYtmuYZXRHW3gRTCsB6ObDR43B5UepsUnAGEw
 gHAnvSnvPMcbvFfEgM1fZmunOOCTGhjIB0iPR8txuQXVJPuozjTwT9h1g9Cd+GMNvWByBRJbQDn
 IKqdzuHupau0BTiJsUdGc1d8hWWg37/NQX1fHuvE43c2dKSIW2v+a3+1aLq5LnxA3ZiaOaWa/hG
 JMoyv6A7sLymwqJ6JDjrS2Z5WOWc45M8HRCDTcXgwmIMSGaxH5EllEql5OrMO/F8j7TuGv144PX
 PvgD/482HzUyTZY8fIs5Hvt/ur+NEwKE8Fud3hKnkLElVzMFYbW9N2A3N7W+XjSi/VNO/ZAHZdJ
 q7OebstHyZGtST9b4h83Bf5GRGyzyJbmnPhf39voeGfE0yS5hpyxLbd3c1rDgcRxsa0C7vCUAgN
 fHzlcMOIrqjT9y5cmC6l2EOSnIe0A3KDqx5j+bsIMDDM3N8j2ysw==
X-Received: by 2002:a05:6a00:230a:b0:845:42b9:386b with SMTP id
 d2e1a72fcca58-845b3ac2640mr4536567b3a.12.1782426731411; 
 Thu, 25 Jun 2026 15:32:11 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/15] target/arm: Implement USMOP4[AS]
Date: Thu, 25 Jun 2026 15:31:59 -0700
Message-ID: <20260625223200.763198-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 60bc3c6e9b..7fc7129e54 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -399,3 +399,8 @@ DEF_HELPER_FLAGS_4(sme_umop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_usmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f5fa69841d..23bb816b6a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2985,4 +2985,9 @@ IMOP4_4WAY(umop4s_sb, -, int32_t, uint8_t, uint8_t)
 IMOP4_4WAY(umop4a_dh, +, int64_t, uint16_t, uint16_t)
 IMOP4_4WAY(umop4s_dh, -, int64_t, uint16_t, uint16_t)
 
+IMOP4_4WAY(usmop4a_sb, +, int32_t, uint8_t, int8_t)
+IMOP4_4WAY(usmop4s_sb, -, int32_t, uint8_t, int8_t)
+IMOP4_4WAY(usmop4a_dh, +, int64_t, uint16_t, int16_t)
+IMOP4_4WAY(usmop4s_dh, -, int64_t, uint16_t, int16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b14aac2c17..dcc4690fba 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2127,3 +2127,8 @@ TRANS_FEAT(UMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_umop4s_sb : gen_helper_sme_umop4a_sb)
 TRANS_FEAT(UMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_umop4s_dh : gen_helper_sme_umop4a_dh)
+
+TRANS_FEAT(USMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_usmop4s_sb : gen_helper_sme_usmop4a_sb)
+TRANS_FEAT(USMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_usmop4s_dh : gen_helper_sme_usmop4a_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4c61e6ada6..724816570e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1128,3 +1128,6 @@ SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 UMOP4_sb        1000 0001 001. ...0 1000 00.. ..0. 00..         @mop4_o2
 UMOP4_dh        1010 0001 111. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+USMOP4_sb       1000 0001 000. ...0 1000 00.. ..0. 00..         @mop4_o2
+USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0


