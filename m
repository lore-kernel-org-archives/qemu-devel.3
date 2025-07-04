Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A083C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhKV-0008EC-Lu; Fri, 04 Jul 2025 10:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIA-000503-D9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:32 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI7-0005Qk-Ib
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:30 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2f77591f208so515719fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638886; x=1752243686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zli7CnBxcZoWcfFlVjjdFH46Lnu/RU9mJkmtTaLHjlQ=;
 b=rwe5smuho1ybzkHBJBiZzDjCm3Xr9PJocSCrqiXQaOox75fi2rb9Sqr3sdTT1Mi/+R
 XwuPetp7Hhl8HoNDvb3AQzHpM5iMyumWJBjnUgwkNfVogMIAxSFeZiO8LAhBZeyutW1M
 hsVFWk3U8rCRsp3o0L10MQ+OPCGC21SAfirEXGJDwzX6yTjwhcpc2ZpAK4a0MYqL0+Av
 KY8IYnNuQ8oCKtD9G6NzR3MsmtPElnJ+hhrBrkllbAf2rvfIw4E1vHxqsSkovyI65v0K
 6/vZ9XuUbgCHfhhJ3TXntv7KU2yMnjy4lFpJNP+dmdIQCm2HZVD3Vwdya/1ing7LZq+M
 9ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638886; x=1752243686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zli7CnBxcZoWcfFlVjjdFH46Lnu/RU9mJkmtTaLHjlQ=;
 b=cAekeXgapr32HPU8P+2BZ1y7N3+bTv2b5Jj6Sv6dH9x7CamUcdsab/eH2xsgUOLfLY
 4C3ZxrE2UZCHYFcsglvgdkHhEXZWmj2yXMqBTerb2PekoZHCacEpHSiMwjWsc0wspVx7
 NnnyMIf4xxPdd9xhjLz592bLyTymVJfPVqlfeyteMAjOSff7hN7yNbQQ6WMkaaH2cSUE
 Sa2lOkDfixgl9MJ4Gg2VixZmtaoy0Av8kT4g1k40qIuqu91FjD5ct101RhSG+cGMC7V/
 3VgFwudszF6f86G6biFCP5wrL/leLlA6NoKnCR8EuCi1XTPLoPopcu6lDw3OwZDbq6VA
 woZA==
X-Gm-Message-State: AOJu0YyqzBDZPDrL3IQ2LMRt8IlrndOpKAejsJm++v1316mu0laP5zD6
 QV6vl2ad+AuuyI8E5U69gd8D0VhYrq2r/BgCSYakl5aYExaeS1P5ikxOtlyAxWugJJAYJ1goai2
 ljmdCtXo=
X-Gm-Gg: ASbGncsJXKJtxShoS2L2em4foIfOsf+E/9MWH+ljEKawIK22CONqkJkNXSoRAcVZ1rd
 jNyFPQbrMViJb/6cuGmsPu0aaCFEQLjZO0mYCmJbB9jFmxVL98KFPEWBpzAKWGFvk56q9Hw+RkN
 g84TNnYHlH2gj8Sxu4VrDkgAY9b3d3eJB/0UD7rf9gTEsxKV8O1NP15yeWt4wms+BQyIHH//oXS
 YT7cB1CrhlwUfPvpt7WvG2wQ+eqcvzc+OjGl8mRhpg6MYPdbZzc3SnyZ+QJOrTlJpkE8FCNKDQV
 kptbMCVDOIDxCznMlMFBu5vnFjtiKVB+BU0f5fMuq7vdkMdFhW2/W7C0trh9CCR/DSZUTgfcqNt
 pEhj9QCZ4b+cuH2c01aZ0nD9f2qhpfu99JopW9DZSZxByM2ev
X-Google-Smtp-Source: AGHT+IHYjHRamIYHXSMNeTIZ1EdnaL9nhwbnOLmAbma5vi0NPG8ytkaYFy9039nT6nQJpjfkwQdunQ==
X-Received: by 2002:a05:6870:e243:b0:2d4:e101:13f1 with SMTP id
 586e51a60fabf-2f791fb366fmr2213415fac.13.1751638886254; 
 Fri, 04 Jul 2025 07:21:26 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 010/108] target/arm: Remove CPUARMState.vfp.scratch
Date: Fri,  4 Jul 2025 08:19:33 -0600
Message-ID: <20250704142112.1018902-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

The last use of this field was removed in b2fc7be972b9.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0338153923..96a4907266 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -669,9 +669,6 @@ typedef struct CPUArchState {
 
         uint32_t xregs[16];
 
-        /* Scratch space for aa32 neon expansion.  */
-        uint32_t scratch[8];
-
         /* There are a number of distinct float control structures. */
         float_status fp_status[FPST_COUNT];
 
-- 
2.43.0


