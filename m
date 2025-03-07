Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DC8C28B31
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgO-0004zG-PD; Fri, 07 Mar 2025 16:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgM-0004yP-Gs
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:38 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgK-0001jX-Qr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2240b4de12bso22028305ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384595; x=1741989395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOjC5KI63SbLoAcab6C0ugB2QHtpLUMoBslKkCj8HHw=;
 b=XUUkDUbMGyJuArzb25NkDijfrXATtjp2d5nwR6+zg3SzSmk0us3bl5JldelJ82adC5
 IP9QCXApgZwJCp6W2KDAJcsi0eGPNYLztxNaiW1nUO83E1rtHgur+qcd0IcOttedMi6r
 7DoN8zg1feNRki2vvvB0DcgbwupT+8e+bUxqBnjeSDX7x9fW6M8aXnkcL5LCSHU89zrq
 ZrzPVjpYeywXhgFvVufobgAeCFFksYSgdyc/Y/qhVzhAxyq7OMdIIo1n7juM9EcXCvkj
 hgxY1Eawph+z/QOd6orbw1kg4Cl4UDkWI3JLlb4FvUUBRsVpry3+b7mfz0spg1macJSa
 FV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384595; x=1741989395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOjC5KI63SbLoAcab6C0ugB2QHtpLUMoBslKkCj8HHw=;
 b=nNW0bpez6RF3712yqLm/AJbwRVWzIX7Kk2XADcv29p0KQ0hUnu6bAvbeRVqwCbAuL1
 k0Lnw6pICXNnxYAcWsy9vsMRzIb9iCBfxg2C+zGLKOCoPEhoeme0nesOah/VR5uc50Kl
 c7keTIofDVgo4+6Mr6sDoPw6C1P2Wrj/kraKJj6l/96qUze52/QbFkZS0cgf4fFOEHY8
 CILI5rPcz8UsMOCpc3Q5Lsp9V5qrmgYvacxWec/OF6AG7G4Pk2uZApGHCidzYRwoN3ew
 vYRL7a6Gh1rVwvW/cFEEWJIQkrBbhEGMCXo1iZUVezz7fsxzF87usrNA182BmVFmtmgm
 YxDw==
X-Gm-Message-State: AOJu0YxG+TNwHAc0R6gOVAWFyIiSUU9YeeCtnRLSN/+A4NaiBiP1CY6G
 PxMtuZZMLUNjra6NQr+GSSgOh0csdiw3gXraCQrkqYCz2seH6NxUWzl+r0pI/zMz37uAJtHJbce
 O
X-Gm-Gg: ASbGncuTPSyLCajPEAe9TRwXk98Pg2Ow6AUD5AuLXiOjMdBI1Jm5An24zpCyPCQnaI/
 AM2xyRb00Llt+UhrpoeMMyyDKsJiyfApAfRfM7iO/bIA2Rf+Wv6Z7CPGFBiXjkDteXFpEZy38Kc
 iX+ZVP1CST96bF6Me7VQuiD5riDnhnPoC3ixzQ6JDMv4obOyYIghk7BiWR2IBJcJY+JltlT+E7j
 PuLytdfRh+kXka9bgwdY2gCRFtfWaD55PltJR+WH7rHquJ5k/10WZJecPSNS9HDspyaF1sQly1w
 SqRFT9cXsoZBeTV9UfPzZtk4j2TKuDvucyTJtZDHT2Jx
X-Google-Smtp-Source: AGHT+IHbTRM/2LjkgZq9JOrRP/gGIFUxKEh4mQoSru8fsXoQyQbJxwtGO2AS7C7F6sVgYOJOIty0Ww==
X-Received: by 2002:a05:6a00:4b11:b0:736:42a8:a742 with SMTP id
 d2e1a72fcca58-736aa9fe534mr7585906b3a.11.1741384595609; 
 Fri, 07 Mar 2025 13:56:35 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:35 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 2/7] hw/hyperv/hyperv.h: header cleanup
Date: Fri,  7 Mar 2025 13:56:18 -0800
Message-Id: <20250307215623.524987-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index d717b4e13d4..63a8b65278f 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -10,7 +10,8 @@
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
 
-#include "cpu-qom.h"
+#include "exec/hwaddr.h"
+#include "hw/core/cpu.h"
 #include "hw/hyperv/hyperv-proto.h"
 
 typedef struct HvSintRoute HvSintRoute;
-- 
2.39.5


