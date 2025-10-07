Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DAECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R7-00069f-8s; Tue, 07 Oct 2025 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qz-000665-KM
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qg-0002PW-1g
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so63472575e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846350; x=1760451150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ciHin1nXK1LBMprXq5HBDqiTlLNb84vyWLyK9s/zYjk=;
 b=g9FbfbD4RUEzRP/C+8UDAthjQrQgai19Im4zEs0by1xcQ/84dLcx40e7nSBEatLqvZ
 HQq1uOHZX9Mddd8sXXazdWfN0DzLiyqino3Lhz2HWKz69R8fllFhMmOQOXhq7sA8McaF
 7P8cTPxWej5CZoJn80C3AR/Ko2kBZUYWVgLClhdIbRr2sXB/qY34ijPyj20ijWX6Qjrt
 6fzZzKm3GaRq+jX3zeozVhLfBMfW3GPjP7MSpo/xJyHHa+dxHE8SvjiPnK35F5t6txHj
 4pkLGUTjtoYoJ7Upat3+pgPAxT5dtuGMKBGI8y1AvHcFYLBT9Wpg9LZpSXefn4WB4RNZ
 RzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846350; x=1760451150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciHin1nXK1LBMprXq5HBDqiTlLNb84vyWLyK9s/zYjk=;
 b=UwwIT/Mb15COVP2w73ImRZnQfSkFu3fc2zfIqO/6x1b4G2zNKN6Om9ih+3Oz+jl8U6
 21FjsgGLUNRxfOeclcF4yxWQwIgcf+zuP9A5j+ki78ee/57Cb7Jk40oZ+S+t55dKuI4J
 WR9+nZw+ybhl2FvqRUeso30gfgJ4Xg9I1bKhcWvWAdCs91insUikLyJ/rSInWlzP6GlS
 yHElXf+5SVAY4kNlApztLNRZwz66V46TnjvoGiJ7wTxY3zLgDIb1zoZwxorXBDe8Ofjn
 4YXWdrsocDdeDoq2CkML6HI6NM6BVgEoKKW0HD8fBCGVD9vyQYJ9ZYkqIlAozEncvNe3
 xDzw==
X-Gm-Message-State: AOJu0YyTFKYjGggoMghRBn6WG4xgLlZBhKtKPHutOKht9wxRKA54rP8R
 q3sCRyqchP1tRi8ROF2sK8qbpcGqYEMmGWwTfczDFRuhJjjh7E9E3NJZPqj8OC1QkICn/Eez476
 9S+dB
X-Gm-Gg: ASbGncteYEK7lC+9eBiGx8tvImSFji/JWjnaBQUcDBIVLJi+NDruLLkyUtBgaYJCz4z
 fJR/iSUmEqapzXcapHyyhlrWPP3LkbQafdL3aS+sd38+3pvUGBJtVIuzCd14FuorcRKFQBaBZ8W
 io1E9H6RzonjYy0Eeb9DDJqk6+fPm9+0Cuki0BfWf1ssJEgVekvkKv9E/NpBZTOxWHbTcr3kKN8
 BaaFgf5YFe8SEl279t9BlVUkWb6WFJ8DYz7oe0Wj8U9mIN/3zC/KyYiw4x0xaEng8lFKqLNWCwA
 a106gkdsO7LHhVRDgZrDsObE3rlCDLlo0Pf07y3/yYC6YXkD6nqGWtx/birUY9ZQj5SRj7eyZq6
 1ilT97nfET5uF6BowO5l3JaZin8rtyBy58DfJrPwnvcvfLwFur/2c8ljRiiuQYlqS8OE=
X-Google-Smtp-Source: AGHT+IHwfu42TezPFenRjB9SCO/BMAkKj/4kYBmx8B9DuBGdiZ4F8LUuJeixdEVr7zBz4KCdHYU7Ng==
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr132491385e9.17.1759846350526; 
 Tue, 07 Oct 2025 07:12:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/62] target/arm: Fix GPT fault type for address outside PPS
Date: Tue,  7 Oct 2025 15:11:20 +0100
Message-ID: <20251007141123.3239867-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The GPT address size fault is for the table itself.  The physical
address being checked gets Granule protection fault at Level 0 (R_JFFHB).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 36917be83e3..236c3a9569b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -413,7 +413,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         if (pspace == ARMSS_NonSecure) {
             return true;
         }
-        goto fault_size;
+        goto fault_fail;
     }
 
     /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
-- 
2.43.0


