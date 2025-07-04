Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F754C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGJ-0007eE-Q6; Fri, 04 Jul 2025 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFb-0005yC-Md
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:27:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFZ-0006zi-Gb
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso848812f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646415; x=1752251215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SRH0loritoMIYj/jPR+rUTfl0mRjYm32LpALRWJqQHc=;
 b=AMljl6H7UrO415TICMd06pNZ7Z0nm9HM9XldB0URrwWsxMXBeBaP0fCMTnH/pa3kG7
 dIQ1pCmOCp5o3JlZCsCPJfi4f3S2/eYMteu8tjrXAuzyn2JueaB0zBAkHw4LbnsleuIc
 d/U4/65MzNjXrw3JZzu5csp3EaiN+ZM68J+L5eccT0kKegWie9F54tJ7TH0sFsWgSkY3
 8/Oa0jHtRDK+CS845yW1UrJKBGnUwFCU4bH35Qzu8gVw1PVSZNAaUdv0A4u0knmr5e9p
 IZluJraACnSVjwsRPaOpL4e2K7kQ0cnC9NsL/SoNSTSw1/aLr6QjiAMZpySVM/HEIyDN
 s90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646415; x=1752251215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRH0loritoMIYj/jPR+rUTfl0mRjYm32LpALRWJqQHc=;
 b=ToLfQDatwuSf1LtWT3SzshEMasY6QNPAYnCgJh6iitRUto9hkljPpgvYJRGzXKYopM
 ENnfhQrBbDsX9xLfsalAytTQmHZJdeiSaDMDcHsWW56KsQCHn1ZZn2h+0jq3GmJtmN5s
 rooopRb85jr0U6hTVQAZ8UIluVE26tvkVuTsip/wkuFoMOn+LRjbGVYDS8hqIATsf8ew
 JuPlUQ6H8i+s3O3M+yNmHejeN3woi0ld8/YW7SdQxOAjvxEUfPJec6aIZTMa0XT0AXQz
 ogaHA3stOHZdkozr0DrLrvIpkAok3vAPqew4eSeV+oXOVy2x5D/dh972ovGoFAu8ugpY
 EWLA==
X-Gm-Message-State: AOJu0YwfLRDFhKBwQO442tpki3c087GV5qZIvAp++H6/LG/dc8mH+AR5
 /HFdIyB7/DoQyMEAWiKJSmNN/LZJ9UUJcztY22nt/1c3ZcrUHpsd+zLsNbJ2aoRKyYQjHTi0L1D
 8/6gK
X-Gm-Gg: ASbGncvDIE4w9u/BBavvxYmpeDzvs/0L2/yt3uedJ8rzwrr16p5rtr9uT9A3bjqeYi6
 RVEkHf50730zaZwIhSom+IxYu3/4zRVyxceB2OaGliLivwl0hHNFaGYeTfj+vJ32FJ+6IoLHwnQ
 kqzzYCgpJGNCE4W3H/IoSvvRLQ180s845tTDl7Ae9Njgb5MvGIxrtk/DXLjbu7Zav3eXV/TAPDK
 JHC467uEEFAryP0xIGZV8qKF7M91CtvF3pnDFKcUu5w/ruu4kWie+YP4h44e9humntEwOFseF7K
 uFMjvbBkPLA66f4cxOU7XsWnuih5v5BPXwg0fnQCRHtgd599EoH6OXdKzwRWbU/bDdY+
X-Google-Smtp-Source: AGHT+IGPOPkZKv/HdueKrLSPYRV5gKqKMTxUFMheGYKcc1zyKtX93MSBI2yXWU47k4ASF+ayJCuV/Q==
X-Received: by 2002:a05:6000:4207:b0:3a4:ef33:e60 with SMTP id
 ffacd0b85a97d-3b49661d63fmr2446143f8f.40.1751646414947; 
 Fri, 04 Jul 2025 09:26:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 119/119] linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 17:24:59 +0100
Message-ID: <20250704162501.249138-120-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-108-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2add1665c75..ea214105ff8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -915,6 +915,14 @@ uint64_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_fa64, ARM_HWCAP2_A64_SME_FA64);
     GET_FEATURE_ID(aa64_hbc, ARM_HWCAP2_A64_HBC);
     GET_FEATURE_ID(aa64_mops, ARM_HWCAP2_A64_MOPS);
+    GET_FEATURE_ID(aa64_sve2p1, ARM_HWCAP2_A64_SVE2P1);
+    GET_FEATURE_ID(aa64_sme2, (ARM_HWCAP2_A64_SME2 |
+                               ARM_HWCAP2_A64_SME_I16I32 |
+                               ARM_HWCAP2_A64_SME_BI32I32));
+    GET_FEATURE_ID(aa64_sme2p1, ARM_HWCAP2_A64_SME2P1);
+    GET_FEATURE_ID(aa64_sme_b16b16, ARM_HWCAP2_A64_SME_B16B16);
+    GET_FEATURE_ID(aa64_sme_f16f16, ARM_HWCAP2_A64_SME_F16F16);
+    GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
 
     return hwcaps;
 }
-- 
2.43.0


