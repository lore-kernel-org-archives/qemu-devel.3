Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E57C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pc-0002F8-3t; Wed, 19 Jun 2024 17:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PZ-0002Ds-2G
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PW-0000UG-0H
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f9b364faddso1613935ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830803; x=1719435603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qLKoP392rGR/GwS6GK2IRdnJBtGIxW6JKIsV0GtUk4=;
 b=kaQE3RY9haltpv7tsT3jxiEdorhGA5ZkJp1FMtTIrqvnA5JEelCuOAieEmSayHkdPF
 st7bgMFfyRvn/3ezflGSADSEbpfnJQbzt4JIib2fDrld2WkG+R6B74ILSVYvgyB724Nw
 9GLbB8iDUfvU4OTqYnHZ1DkMRZzfh4dBe6x9JQamDf4+dlN8Y7BmvB6HO/F0DZABadhW
 LPqGtbHt6jwY39IOpJEhTPe1FwcpglmNLYnI23DWkivnl1g1gnPiEVjP/tw9NPx7TqdH
 svTgq1fLJ9ceESYZBT1Z6gSW+PD3CR+yRzZQ7RxDgXYSdV47Vzxakku0huGcAPH7wcIk
 o+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830803; x=1719435603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qLKoP392rGR/GwS6GK2IRdnJBtGIxW6JKIsV0GtUk4=;
 b=ClEvREwiEnCGbbjAxfVXailGGXg8qvMbucmpikhxmGVZlf7jFTOQoYutiAviN8Cta/
 2wQe314oaj85u53iqfHfI/a8etksy/gsoI8dX76Yl1hybu4eRw42yUi4RSIuQamFcwcp
 4swZ7oQ/dSpXj0bxykrKmhE0WD+p9xCpHw9gvyfmjgDpZhS8sgDHtEYtas0imL+EbnOg
 EyJjiCCxxWk+0TemoGlwFKyT6v+f7zr/+dg7KDuEx0YNEcjiVVF/B4MfR7tlbGhepiDy
 asr4FBWp/ull8NkvHH5kZQL3dMqGBtqAAWMuoryJD98L0NNv5B9akCxakU8nUVHGOpzd
 HZoQ==
X-Gm-Message-State: AOJu0YwUMo8jVSWZkSpY+gWCPKNSbAiS608O6pjS0TnuCTRMCBS8Mi1+
 kHiPgijAoe4eQ21yLeNyipbedMf91tKTbZ9UMz3w7Ew5GxqeW6l6a3vGM17QMJl0H/85NqPxDDO
 V
X-Google-Smtp-Source: AGHT+IFI/lVS+OhemSZz68sngTjzwlQkFkkn10Z4RRoir3l2AmVOkBhmVpZnxHqCKKihKEPztoLMYw==
X-Received: by 2002:a17:902:d2c5:b0:1f7:2bfe:87a2 with SMTP id
 d9443c01a7336-1f9aa4734ccmr44844475ad.62.1718830803389; 
 Wed, 19 Jun 2024 14:00:03 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/24] tcg/loongarch64: Use tcg_out_dup_vec in tcg_out_dupi_vec
Date: Wed, 19 Jun 2024 13:59:37 -0700
Message-Id: <20240619205952.235946-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1e721b8b20..9a8f67cf3e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1749,24 +1749,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
 
     /* TODO: vldi patterns when imm 12 is set */
 
-    /* Fallback to vreplgr2vr */
     tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, value);
-    switch (vece) {
-    case MO_8:
-        tcg_out_opc_vreplgr2vr_b(s, rd, TCG_REG_TMP0);
-        break;
-    case MO_16:
-        tcg_out_opc_vreplgr2vr_h(s, rd, TCG_REG_TMP0);
-        break;
-    case MO_32:
-        tcg_out_opc_vreplgr2vr_w(s, rd, TCG_REG_TMP0);
-        break;
-    case MO_64:
-        tcg_out_opc_vreplgr2vr_d(s, rd, TCG_REG_TMP0);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_dup_vec(s, type, vece, rd, TCG_REG_TMP0);
 }
 
 static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
-- 
2.34.1


