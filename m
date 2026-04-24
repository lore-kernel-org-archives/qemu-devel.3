Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEF9FB44A7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Cm-0008A0-IH; Fri, 24 Apr 2026 00:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CJ-00072c-06
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:30 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CH-0002pB-3d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:22 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4670676ba03so2222130b6e.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005079; x=1777609879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/eF6UxrydbmzCRXNoWVc07UBJDv6wjeDkTY/rB2YuA=;
 b=aZPv0wcWRKB0WCLuIIrGtjUFdMQUUyVL+Anzpa1y5ycsmj+THOSTvz+q+XertMzDnq
 K0xp7EbiyHKTqqr6LJQJrMpLIVhoKtDalP2OMIvBNsovLJPhCSXCh+9rpG2Yld4tIZFW
 iNzSdwV74PoCAV3vpmtW/epMLb8x481ua/AFF5HJctq3g/pwE+ICyPpCRqj75J7v5zRR
 TbS1IggoTx83R7/Ap140CJbVayPYpQGnEIGveRLas4tT5nP+TDRqKxasG1FrzlHcL0RA
 mHqQaiUFiZECzn8B0IVwtF/KQ3ou+JDbRuxSsdHKmv3mgXpkMtz92vlmyViLM5gEcrbq
 OTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005079; x=1777609879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/eF6UxrydbmzCRXNoWVc07UBJDv6wjeDkTY/rB2YuA=;
 b=ClHOdF5LyDt/xPUfLLfki22DoM6OPMK0pRYo7K0jeTeDEl+yEK25TGY+FCiH9py34N
 JPxUkfoduTo4oovl6TFGbRvj/QYMMTncyd2W2hpIU5HPA/GXnTncR8AI3g2wIqdmAtbD
 j1NlvWkM5b82ii+XAdeUhLpH5erEwwz3mL9Anga9e3SO0tvxZLa5GNaY2Fio/eza3AHe
 yuGppbOapd3mEmVLTovaeuQPdlhk6lD52pQ7th6De1IiF7eG7A7ojKHQFMNutwlVtBdN
 SooJHZnT8TlsIqZUuzJOz2d8t8/D2nAXsBH+l6SMkK3WZQTBqx769GXPMxKgNAB+pGd6
 OaBg==
X-Gm-Message-State: AOJu0YwAlmO4lVDzK5g3rKoWe9lpMPxVXBjpuJ38FZz97FW0RxrFvRbf
 Gu3YNFBG3gUO0q976uzbrWE5w8GWWTWr+lTZYHFgkuidzK4Fz4+EZsFHHcczBkSr0+lrQYVJt2S
 Eolee3XY=
X-Gm-Gg: AeBDiesjZxZuwdHNd3XhmtVohHIepmQ2Jn+vge8+VnGX5sFJocnLF36EOJlIaF8HjbF
 7HyhK/BteFXdHMRjyVG+J7JUbMoOX6i6yN+uHKt/oXO1mtidR3fFmLxr5mVIv7lxqM1GhUXLfxc
 N0YLuCrdGhvHil832K1k+ZPWz36yp1iKNsyyeu3T12eXUXm5ak8Mb+Ayt7ei3Qc9m0FD2CrYQj2
 Sn+wFcNpnBfQiZidNImsQgcR3qgblo+VLt9pKf3kKFzY1/tY/xIVuaqdi+ps0VgHOJ3dJSTC2GD
 OA0QDw/4Xr4jbgUEnOBazyDuYD4FRf0HEm8qMu8+uZuxh2FqfunPFssxo4E+yU7U/6ekfCXBLee
 tHsWQFy8T1cd8ht9eyHaqqqanrZJd+M42VTQE4Wn7TlvB7eJAZJeBWgfoU59UpdxVyyvfM+HW0k
 5XHj/0TwIooLmFgGSRgmQldP4uyChQyBjnEq+uesZn5T0kqw0JMKz6nETmSFeVlQ==
X-Received: by 2002:a05:6820:2916:b0:694:9910:f77e with SMTP id
 006d021491bc7-6949910f852mr8608586eaf.4.1777005078698; 
 Thu, 23 Apr 2026 21:31:18 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 13/40] target/arm: Trap direct acceses to FPMR
Date: Fri, 24 Apr 2026 14:29:47 +1000
Message-ID: <20260424043014.46305-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ef6038e98b..d132e051ca 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2898,6 +2898,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


