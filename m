Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0F10F284F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AOq-0006GN-Ty; Fri, 27 Mar 2026 12:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOd-00067j-9U
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:56 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOa-0005EL-6R
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35b905e9dc0so1464151a91.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630251; x=1775235051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2jhG0JdJkpzPMpSo2GG9wEa3WbWFhcOQfxGH9DnApU=;
 b=qsQYPpep2DnEQYrzVKFrtgLV0OW9JJ6lgHZirmk7ns7sWKT28zctfiUGiTFugjH3t9
 NZjNYAJLwVSViKWcFRyH2EGGIDy1sIt7G4VEWCZKvSMtL5KY/8HkJw2f+8x1gS7nY9Lv
 vTchGr6zJNR57NRqxgBuPzQJ7V4OU1zcgGS2Bhvfy80qcWLru8DA4TNTg2OrD3bbJu3T
 EdyI95/xJlR6Y/mbixAHkmijUlNmts31IeoKpf8J7HKDvhh3mTUusdiLZBEh/wa+HWvt
 pzUD4j9thVxfN5Mb315Nce+zaRJsTNKBRbcWojL6CQwrRRS7HEguM2Xxalh8yb0eu5r1
 Dnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630251; x=1775235051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r2jhG0JdJkpzPMpSo2GG9wEa3WbWFhcOQfxGH9DnApU=;
 b=bV01q8ppzyU35J2MnjlF/b+QDr8huSikwIuYOFcB7xrLPBBC2uiHKypLa1R25UcA1C
 zEnPVMfNgWaTwezOBMCQMaSW98RAqAwxKf+SHQgF+eoTnsJnlwFJc0wGH+YPFWued9e+
 LmG89UKzrAWbt1lH3fbyd4PllsiKKyiJpykyPDyRNfAFpgnrovzIz5mghSUMpQhcbh1Q
 9Dp01SeLRQKu2EASSB/h3Lg9f50nH441Zy0FJq16L5YG8Y/H3IGsSFdnjRcZcY/YwSxo
 nP5Aqq9Z1Nx+pHMYn44no94+NN2uYbWE0GhuLSizeSho4TH8Wpft+uDtPJ1O3pYWGqye
 F82Q==
X-Gm-Message-State: AOJu0YyOzPZqVNi++O96SDFHckXNlbD5LvYQ14iYcO5ufXTZZgvX2NYS
 cbi9KzVsq/JAZ/Clem7CL4EOcelw6Ag4ARjaLgY2eruRr4GmXZ3D/sw963xVDCq8FSk9DVtj6Kv
 dRS3CKws=
X-Gm-Gg: ATEYQzx2Vu4Jfnq7vbPtrYGmRca4/frdC0d60zQCw+unNjz14GlOAgWrw4gLNp/F0Y7
 LABLf0cEpQlw5o+ueXtkTX2VqoWRjdsVWYW3vA5eUmcGB7xwrnqEO0oHaPznAEHvSfHpNctvC5o
 7e8oeC+Rk6jJiOuubUBdgZ9NTzuUXFOEClXrvUtsdQ3Pq60f4KwUNzNJbPJ6V7dLLiVDdAt2KlF
 LBGOK7Wi7E3uwEB6bo6KS+SltxJDgCCvPyYieCBBMO73EjYcwyc2/G1FJUrAYeD94sxplCwn2DT
 rBkxcnA0/0rn/oK0+rwDoBY+qGHldES+HpfnYGcAKSP9/30z6XeaO34ZaXNleH4lWXvJ/cFThXu
 JkkEgvI/iNk0qIbCEnxEh8aQfEaDN4tUePlogHkjyXYtPZEyTjJmQa8ZL8s8SlIe403cwrDNyRg
 lGn1ZlIOTbTWobdcOYIo4QvzMLWdnnzw0KLWSE/9poDa6MgWH05LBMoKHfsilkugyUeVTxhOaqu
 L/A
X-Received: by 2002:a17:90b:5291:b0:35b:9dba:be26 with SMTP id
 98e67ed59e1d1-35c2ff602demr3046656a91.10.1774630250622; 
 Fri, 27 Mar 2026 09:50:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 03/12] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Fri, 27 Mar 2026 09:50:33 -0700
Message-ID: <20260327165042.604105-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


