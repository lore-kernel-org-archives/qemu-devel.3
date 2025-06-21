Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41F0C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT86e-0002At-QJ; Sat, 21 Jun 2025 19:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85i-000619-06
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85g-0006de-38
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so3493861b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550263; x=1751155063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N88cjofwZUW7i7YGrHAuBv+y8g1SSzRmtZKiC8EFWrE=;
 b=DsUTlhCJ2OcCOWTcFMImxNXMqIvyMQWrdkQtMjSZ3L+2eF1lZ23slxwJpHLvLfx3U/
 VxvoVeqeBdDXnriCL9Sg6LpLZl+7bpEu92ljJRqQoqd9uxp+zbXS2XncVpMEoMrcuIFF
 9Dh4oOhaBdH+s5ECO1jGLJ1+fx6bmvDgt8N+Z+GhE4mOHk0DDCqqGDMlosz0Z6BBgomn
 xEVsnNZrPqf5PbC8x5p3LNNqWJgwP5YFZtEFXS4R+5rh6jpxql3ELJCyOXCY1AUo1mmx
 hMK7XlyYVC2rq2uGhsZDUbVjsucfaK+4gc+7Ek9A9AdOvtmYvQF5eVhUFUGPato72dB3
 Nwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550263; x=1751155063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N88cjofwZUW7i7YGrHAuBv+y8g1SSzRmtZKiC8EFWrE=;
 b=tmgi6Jrt1f8IAazYrOwNYA7AZYwEj2rLeNjEyJMwaE34Z+twbSsq6sTjQVj1QP8X9Q
 SRZwxtyoCF/T0oEG7gGpj24VpW+hKng/XGpOlDH9vWBiiIMH4cyYa2pYs+saq/jol++U
 VR5lUAmFverP37EE0QKDKTVbSgOuvcFBcQ7+UExLmwp7llcA4WJFF7wzuuE2w3MAfOI/
 0PmhYL0uc+8JiGlrawxmTst5A/dXuiStoexNeZMusD4ADNfqx3YndHF/IFbjHaAUmIgu
 NtTA8cIDmHa151+4buEznTN95wdRYRdBINTicvD410c+gghrs9K0CmM65Cvr3YmTYaxD
 AYQw==
X-Gm-Message-State: AOJu0YxpXZDMF8YXUCwNbZZ+32l/yeZhKlM57HHRk5Wt3Wk3kmcCrdA5
 jk3DxfxJ/1WjDHOlSunZ7BbyafLyGFCRlwugRoG6yAoxMjmmWFkZ420n8Z/NNYy/upa2dgu+9BR
 pJwAOHbs=
X-Gm-Gg: ASbGncvB3AbQLYrrPGLAr/TcbVxuUo748VN+yBkpXUBNmnxpzHrGdkSWVnzkeO70RS4
 3FWtHW4mDvR/+XcRDSk0QrZBkbFPQPrpWq8mypd/Lat8ZYiUSwZW7yrvlr+WZSR53tKFflCFiy6
 ZDNaRbZ3l/pkdaX/CV1cIETu1CIexniYXvGfjynwcLFZlesJPZob8uwHh30DpQyaRorq7He/Sky
 NHtRUyqcTUEJoEVob9I5nqyeTDw3lgA91U2sbXcKmHUCw3xYC//U+YwyLqlg9jrQQa/yrjW+8Ty
 1Wy+9kZcjGXHnD/5zcfwhCyumnlOLCXd8GPDHl0mg2g13lXchA1eEbheGlKla7/uGH+twWiZ9ny
 6gB5O86/2ArwwFut5R3oj
X-Google-Smtp-Source: AGHT+IGFgg3OxRp3LJs2zG2595PsZfpVdk4e4aRlBuXhEW9GsXC4gP7S/XJdJYqFp8UQRMmMZmSIvA==
X-Received: by 2002:a05:6a00:3d01:b0:746:3200:5f8 with SMTP id
 d2e1a72fcca58-7490d6911fbmr9955613b3a.22.1750550262704; 
 Sat, 21 Jun 2025 16:57:42 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 099/101] linux-user/aarch64: Set hwcap bits for
 SME2p1/SVE2p1
Date: Sat, 21 Jun 2025 16:50:35 -0700
Message-ID: <20250621235037.74091-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 linux-user/elfload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2add1665c7..6a7b4ff9d6 100644
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
+    GET_FEATURE_ID(aa64_sme2_b16b16, ARM_HWCAP2_A64_SME_B16B16);
+    GET_FEATURE_ID(aa64_sme2_f16f16, ARM_HWCAP2_A64_SME_F16F16);
+    GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
 
     return hwcaps;
 }
-- 
2.43.0


