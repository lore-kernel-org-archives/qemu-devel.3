Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D53BC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNij-0007KC-Bk; Sat, 02 Aug 2025 21:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNib-0007Aj-AZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:57 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiX-0004dw-L6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:56 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71b71a8d5f0so21128747b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185252; x=1754790052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpTKcmqIXZhcFkcloKTAjB6pW68SlM02QmXcOabdBB8=;
 b=G0RpP7YYyu8OOETKXzmKFmI4pvu7/2HemMRRvXRW2M6f0sBE7ZE8r8XLUQIwN3MWoo
 K1Oie4+iJ7frdDQMcn4FLUJVCY5Sd6cfGs7SGqKHT2HzEVjO0Gld/T+0vYvMtSL93AGx
 tpW8RY8Ml7HT8qPNCnQ78Cy3DBvqSSLYstczvhUGhmI14uy+0VozyWI8v+pwe6hgC/ud
 KbgCZZOp15iBWJlaqXtGB3jzKU5mToUaplYofriZjquu6TkQgUajrd5RjEDsUzMcTDIX
 CmZ4cx15+zt5YVIuS25oh7knGxYcYXg5+egtquPUAA2WiWPFK92u7Wvb+Ds6/Ev37YJO
 4/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185252; x=1754790052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpTKcmqIXZhcFkcloKTAjB6pW68SlM02QmXcOabdBB8=;
 b=mMEBNdKgK9EGuXAvAA/kytF7eYHekfgSMeX3jAjcIc+xMjiMfHc6vWrlcsvniP8+Am
 zJTOt8LK97dtG65OyfapW66ciqSjcSe9jHVrwRfY0tCGer86gPxXv99ljjGuJpsE1SeP
 PonsXxOM8AD4zKvd5FCBtcJ1RxfwzIFeU9sZ+fni+b+j1FQHK4jFTS/fOk9BUjrbi+6z
 rmkYhV7uWWI2nBMtCReJio6VxYLxpJ70VMNuJLQ3PlJyLJr7LcH88t/67480QqQKGGiw
 ki0PPOyIQ+eTiN1GY/P9T/A9y18id2lG5bxWbcsxvRt1lKJ1dw9rzaSg6yPUVHM3wl33
 Tglg==
X-Gm-Message-State: AOJu0YzfivJF7Hx666UMB63klQR7ZMeBFwECkqA57L1tbW4lHX5QUk7+
 LTAri2QF+CUu/BUuteII409vH8fnfy0F0R+7nB8yhW0jGpmrvyG6Ttv12qvNY0aZelc9I7UIwPb
 tAgpEarg=
X-Gm-Gg: ASbGncvw2FvTHzQsr1iV3aRRyUopiAM9u9hdcwl+UbRp49Pc8Gvp82xbgBHccdfr+vq
 BqD5NRoMnm1YrUjlfG7iQhjD8rdOaYei7StkNUGxjiW0oizRLg5U5IItriSDOBynU9FFrVTnKLv
 6JHfy4pHJqtTNx4ayuAx1PDze7a8UmgltbBnKjthJEhuRBNxefzH3Tiz1cbeSjBMWvnginLrwxD
 JM9Q5E0CMEg7FC5IuFRcVGZhKM7M+zV2wEUu5t7MfuUBG9jwgw1axiQpZQfgfPIpjNkV9THvdco
 QaedrZMicbWrUbuhXD7dJq3EfMcoBLwO6I2LRLsF+tLLQIcUed2h7Xbp+VEcrvc1B6+cedL3MMJ
 klUN70YznQyMntRI5aWsaCRUp44xzCTDqjD+TVFS6AN8q7yzNljfbhQoq288t3Fs=
X-Google-Smtp-Source: AGHT+IF9pDAZHuKurz3a/hpzaoKN7pR3e0mPTMen0Oi9o+xLMoyQULuLIsO0DSoQOW7LFgluJuJ2hw==
X-Received: by 2002:a05:690c:13:b0:71b:6628:ff1c with SMTP id
 00721157ae682-71b7f569f43mr59372717b3.41.1754185252053; 
 Sat, 02 Aug 2025 18:40:52 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/11] target/arm: Enable FEAT_CSSC for -cpu max
Date: Sun,  3 Aug 2025 11:40:14 +1000
Message-ID: <20250803014019.416797-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c          | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..baa618d6c2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -923,6 +923,7 @@ uint64_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_b16b16, ARM_HWCAP2_A64_SME_B16B16);
     GET_FEATURE_ID(aa64_sme_f16f16, ARM_HWCAP2_A64_SME_F16F16);
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
+    GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 35cddbafa4..d4c021e34d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1178,6 +1178,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 890dc6fee2..b9b11e82b3 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -30,6 +30,7 @@ the following architecture extensions:
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
+- FEAT_CSSC (Common Short Sequence Compression instructions)
 - FEAT_CSV2 (Cache speculation variant 2)
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
-- 
2.43.0


