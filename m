Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D697DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPba-000742-G1; Thu, 02 Jan 2025 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbP-00070x-Ax
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbN-0005Bh-RT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso160654935ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841240; x=1736446040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DxsckFlG3p2cFxiGRlSLlIHQli30dRC4vVyrqa0wZhg=;
 b=ZRW+h34KOrmp48SlCIy2cUfJYxE31URoo/jhoktjlxVBqdnAT7Pi2TcvRmeZTTQM4m
 7g+x/u5cC/U2NsdXwL6cVsG3otEkNRZm9ZOP3+BEGHgs0+Oe5JU8ymPaLXu4IkLBTpLY
 uzRgoFbLaOXTDV/osYbx8/R62GEN/UKEJSHoqidbjvr/TBevhtV67Vz1bdAjQbuebKdZ
 QBMMTbhDfnOeLZVD8Oplz7GOdcmndjdIiEe9rRuePUDFvUCrNRSxVL/lpquqk5AGkfp+
 GvGQcG95lQ1Izm834ZzMNxPoyO+EntgsKMAkbVoz8InOpc11g4DCJOBHJA/gEjBBhl+6
 VgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841240; x=1736446040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxsckFlG3p2cFxiGRlSLlIHQli30dRC4vVyrqa0wZhg=;
 b=pBjtCUlRTZDU+yEK7W504UJDYZf5mnk9L4q5vMfFkzFm/09v8sm1VAXBThiNrTIWyT
 RGLDuNnJU1vqmFXexAA5nbEwrlhxhojBgov/sm69HgmjxTpFAgqfIdJsQhR/TVqj5YEB
 ZbAq9yCBKvkT/BxEIex4M17RJ69sM0LNG2y8ge3wE7gWmSZWABqluQ8BNoaei+M0wbVh
 H3I1dDbQ2hQNGTLfmCrXFTRey8nEMXjtk5TY7LFKUIJycXQx84B2acdZuBvc1Y/QIuOI
 tmvrLnk2RJb3VZJ4pRVUqeN2bFPEI68e+boGPcQNy0iu4D1ROYOJWU9dpiQ7MFracVgn
 JSTg==
X-Gm-Message-State: AOJu0YxAByaV/Ke/h1BqmPXiJKW7oRY7Z+BLNqx9uYkNhnV0807IRqu1
 Vb2stwYZFDdd/af8pKw88Ztf/bBbI99WoTSjkxxA+strECDRLZzMXZbxkkTARLKbPn/93oQ3hHj
 U
X-Gm-Gg: ASbGncuisHHyqlVvis4etiSKeKD0fByLSfrBz3oTTZd//iudsJVPJ+KMgd7mflB/WOA
 yxcuaqhK5zpImZPPN39IHX3wqGX47TSo9KBWL1mAkKUjyTaPnESCbH9Fz3yiknpUtiFlJkvnW+C
 IhbtVVkqt1Hf9bWmdLlw+Zt7P3Ut3f9LXbBvFLDJI14qyzzE6wId16mM3/taEpU4Ss1sRBXhcSD
 9xUER3tOg/Fcp9gB0CRPxtWRR+mcGHevsK410A5l58jR3xHN/IrYj++/ZqndA==
X-Google-Smtp-Source: AGHT+IGB8fxsMn+yy2qckvoamux5rU8VZbktbGCju8msIE8fw2jLMlRYCDQC2ZRORkWoZ1YFvyVT9A==
X-Received: by 2002:a05:6a21:33a4:b0:1e4:80a9:b8fa with SMTP id
 adf61e73a8af0-1e5e0461547mr68507710637.13.1735841240270; 
 Thu, 02 Jan 2025 10:07:20 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/73] tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
Date: Thu,  2 Jan 2025 10:06:12 -0800
Message-ID: <20250102180654.1420056-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Trivially mirrors TCG_TARGET_HAS_{s}extract_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index bba3694338..d750fccb30 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -90,4 +90,7 @@
 #define TCG_TARGET_HAS_cmpsel_vec       0
 #define TCG_TARGET_HAS_tst_vec          1
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+
 #endif
-- 
2.43.0


