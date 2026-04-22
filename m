Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F63F9B60A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUen-0007DZ-DE; Wed, 22 Apr 2026 06:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeM-0006yr-74
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUeD-0002Mr-Nh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:17:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3662288f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776853047; x=1777457847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
 b=EBhtq0Thxa3UEOH1ExBQBxahJvatpOmpfzKJM0j7Enjgt5REr0VkNqJB0/gJfqZiSW
 HJQanXenqRwRqEPLyB5YrmDtYYcD9SbDR7pOY1t9IiXBzxsSMlDBTECCGslHlItg+9WT
 7xCrocsQ7K2fJ3zvzb8bhebSceLj1YJyPdZjTHGTvIdCApAbPtPbW6oi3/xIKHDW8K3J
 QbS3+PsnmnaZUr3q/Dy2faycyA71u/pKkgVoFc5tQJxlhjN/sPfi4DBpwoa1QOTGMk2x
 Gf6hWY8491OTlgFPO4pJ+1jHWt+LZZd8aUO50QiqMZGP51H58xAeEvL7jHVkS4E8d1P9
 a18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853047; x=1777457847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
 b=o5/V9IVwddIT8s2ea/8DOxzO06oFhCVhajD1FGiimNc39gdxAst7fObvF0AmaZfrXf
 DgMKipR2GuoHezYCs3S+OLDebGZiQo0tUFEPtM0rhmpV0TbKlYAc/rwDFIODxwI0TNrE
 WX9F9W+aZOuxD8GFNndCFNG6y1fScdYlJ6BQjtOxlpyqURUxl5UHtikPxi+zbKgKX/5O
 RMCQczIXgBjjZdehLTI/8lA52CaMhHyHp9eRVH7/A9U8dDfOjEtfK6t3P6tC5OyBGjko
 0pNP3UqgOb4isSgANO/ZP6TDRQPynAypcGDqdz5GYvmQZsQvdOCmtM+4lFROKZcJMJuw
 TVIw==
X-Gm-Message-State: AOJu0Yz7e5a1iL8rIFRDWfyzdBB7Og055DbBU33JdXIeBU84BC0IxV7U
 WqXItom/IJ8hjxe3gr2VwbFV/AQE9w7jB22s7C4pOU0EUNPRtfjXeNwdUmZV46omACQ=
X-Gm-Gg: AeBDies66J1IRp6NG3thWkzgiAcPtAPMczhiYqPIa9CsWgQg6+ex4yYd9gu6ehavbIp
 OZOZmAn8bRO5NczkdEayBdcGTc1rSFAIxvDsGsUmVv82rNUkxf/Vy3gjAMz94KsjFiFxSy3oNrx
 SNfVImJdqEV9KkEQgZa49pYuF+ePAEQkNgqcUfOlozGa085WyCwryb3SKXEbfsjY2rUdyV8sNs6
 EeUqDxwVIXs1wexmK3nf8QJM/A03LZSFKM5NDc5BHUiZc/cezXlepsBZkvdi2B0p8Ia2PaScexW
 URNd4cy+ojeYz0c+uGLrwzQo6XoDj+LIpA0nvMMtrzU4xYeT94Ng+hMoVluhMnsDk9JZisa8++p
 8CaVl9n57hptYef5yXwkm0jzMzwmg47A0k9QONkrvMKhygFFZUDFraMWeOTX5NqfOKndGk1CRg5
 Z3gFlZl8HJhuJg7J34wMX0CsjFkSydOZeGlrhRoxUMdIhb
X-Received: by 2002:a05:6000:24c8:b0:43d:70b3:7edf with SMTP id
 ffacd0b85a97d-43fe3dc5386mr35212015f8f.12.1776853047494; 
 Wed, 22 Apr 2026 03:17:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d525sm42572233f8f.31.2026.04.22.03.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F18F614A7;
 Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 22/31] target/arm: remove old syndrome defines
Date: Wed, 22 Apr 2026 11:10:33 +0100
Message-ID: <20260422101043.1234229-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Now everything is defined with registerfields we can drop the old
defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - remove stuff dropped earlier
---
 target/arm/syndrome.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d4dfab8cd15..04a71eebcb5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,15 +106,6 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
-#define ARM_EL_EC_LENGTH 6
-#define ARM_EL_IL_SHIFT 25
-#define ARM_EL_ISV_SHIFT 24
-#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
-#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
-
-/* In the Data Abort syndrome */
-#define ARM_EL_VNCR (1 << 13)
-
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
-- 
2.47.3


