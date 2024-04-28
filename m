Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11717C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPI-000316-0z; Sun, 28 Apr 2024 17:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPE-00030O-Vd
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:56 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPD-000165-B8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2db2f6cb312so58652121fa.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340993; x=1714945793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC01nZRb2MKVtNO33LPQtbldUV4P1Yct1l9n3dXwvXo=;
 b=MOHdQYdnRkKDo8m0djngcRxet7C75lmd90rYEuNtyeXdQlC9usNABt59p9Uld0Fzpt
 29FVtmcU+0s6jTR2VNup5YxBLiWWqCTZ+tmDhGW1VFreeTr94UmTaOuYRg2lYO3LPlZE
 V8TaAqpT9uOinSCWr7uy5MgK1+SOAIR+t0tCM7Dvfo4J0xRl4w6zxM1A4DiP7bi8KT3R
 jybjsGvq5uoGLKeni0jCmvuiHuc7qHJUXf5CUaI57d52tTm6aGHO3mfK6Qmzk2GtTkUW
 QyYCeaw+QOenrfJJc5sY+ekwWL8a/rNR2I4BFywvnLjL6Wu9wtakTL3PHdlD15/cxBOM
 daaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340993; x=1714945793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC01nZRb2MKVtNO33LPQtbldUV4P1Yct1l9n3dXwvXo=;
 b=S/UvKf3AFQnMQ1I2qJ2C6UKKS1ycY6WiFabm2EcyneO23XN0z7Towa64VefNv3KdX+
 DaaovW3NKDEFuFIc/0paUNTW1VemFBGUfHIgOTPBsLkkCZb+QdSWVr3Q55SJrCYSH+NV
 RbZegemgJK2gMrpQzhG/faFMkCcdLE9vZfxbFQ5GOMvFqYJ2pUjkyNfNq065czuYrZl8
 UQt3+4XNGaGXoz0E/pjMCbA3tVyeaCH1Nd8UlRveVblkWx0KRn9xNvliK0e5wWeFDRy2
 xC1Jg9nh760eJhPrj3LAC7pJ9+8hpDXPuhagsxmZ74eiWgD4NBf/rGppTMQLbjOPVbI+
 fd2g==
X-Gm-Message-State: AOJu0Yyg596yrIF3TXRlF+x3WU0+ROdYqHXg+otW3Vv8UNNCHg58nrFu
 qPyBnFmTQESjvUHY/wyFLW0uzCAoiYBrQDCQUvlpPdE+fGrTP2wQZ/TR/CeBTFsIhsf27opNYVc
 7
X-Google-Smtp-Source: AGHT+IFg9O4STYvbixyN3lpsb7hGIT8psemBgm2oXtX1RkzIiDn1dBDV0DuXckWtze2i5745ot6RFQ==
X-Received: by 2002:a05:6512:3254:b0:51a:df97:cc8d with SMTP id
 c20-20020a056512325400b0051adf97cc8dmr6630270lfr.26.1714340993509; 
 Sun, 28 Apr 2024 14:49:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 bn16-20020a170906c0d000b00a51dcdca6cfsm13140044ejb.71.2024.04.28.14.49.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/12] exec/cpu: Remove duplicated PAGE_PASSTHROUGH
 definition
Date: Sun, 28 Apr 2024 23:49:09 +0200
Message-ID: <20240428214915.10339-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Missed in commit 58771921af ("include/exec: Move PAGE_* macros
to common header"), PAGE_PASSTHROUGH ended being defined twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-8-philmd@linaro.org>
---
 include/exec/cpu-all.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5ea8c4d3ef..8c3ad7153d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -157,12 +157,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-/*
- * For linux-user, indicates that the page is mapped with the same semantics
- * in both guest and host.
- */
-#define PAGE_PASSTHROUGH 0x0800
-
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
 
-- 
2.41.0


