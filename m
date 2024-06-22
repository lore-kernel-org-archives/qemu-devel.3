Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847D3C27C78
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWH-0007wh-Pr; Sat, 22 Jun 2024 08:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW9-0007lU-2J
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW6-0000Ju-Qs
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3658197cdbbso1338314f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058009; x=1719662809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJXw18R+LAKc75qOpzY4VoPBavys2Xc3dbvQaGAdCEg=;
 b=vUCmSNcqAQDdq/9EPZZPvZaJtkXkJqBVQzuaS2ZdHF3OEbMDfLJe6FGcMWXMiqX/kV
 0NS79lClnkLoNCqPwCLMVXVl1T2BDPYn5yd4VHFrMARaFsk3zURmMHNHj7mA33WyXJGT
 0s5FhBXbyE0YRCSB8D3Rm3spumV6whuJE5XjRmzQ6seoRGKK/hP4B0OURIChGWiqwh21
 YainjFZzHLlW2DjGtLzt66xcDLf0DzxGF/Mh+3BeB97zXm/PoOBdju1Dxcfwj9oxWiHG
 xQwFMffKPR6xHDhEZddArTdIxb+JNQ0u/D6KoBjqlPd86HyASVkmr//vjZf8iwcfWQTB
 qQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058009; x=1719662809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJXw18R+LAKc75qOpzY4VoPBavys2Xc3dbvQaGAdCEg=;
 b=wedgqB73hTRbCigeZNpwh31O98+jXgqweSERtWPPEWYUgtAgFFDExepKvqtdoB0eCp
 zHELjZc02Y6CZgosMlZmKeXBAzIRlyuzrmYMevF3YARErzHwXH0BjFF//WGEFuRaBVsr
 36KZdbwduro7UyHXyID9yteBOnoCAquLLZSln1eObVd2MZzO/S3QlRyAGBb/CThHODgh
 mNPcJKZtj2rNQ8bG27c6wL8wmZ+wDZiFQEsYJEi0IgddACESEIlYabS5CyLLdDcMYmXI
 ILGFN9gMws/uYEXem5S+1JA1r9ksgyNHZD3UykwwkmjLdrmKjBUqXFyO9U1Y4+r9lVgF
 myAA==
X-Gm-Message-State: AOJu0Yz/wNlGodvYKpu2DpjZFd4kTnbCVNSZCLgr/nx+ZH5iCXkLGJwe
 ririonPYUFmGdidf7imIIQrtCBKaqT1wn/G9rK9uJCV2AKPC2tY1b5JCUW26bgbYuCOXSIMaK9s
 vnPw=
X-Google-Smtp-Source: AGHT+IF+U24xzRH+md7HIfGh3LoslqJkD30l8YMZlStdJ/4t81Wl+3lyQx5ZbMbwtJ73hV/qniE09g==
X-Received: by 2002:a5d:4b4b:0:b0:362:e71:9268 with SMTP id
 ffacd0b85a97d-363171e23d8mr7559688f8f.6.1719058009552; 
 Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] scripts/coverity-scan/COMPONENTS.md: Include libqmp in
 testlibs
Date: Sat, 22 Jun 2024 13:06:34 +0100
Message-Id: <20240622120643.3797539-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Add libqmp to the testlibs component.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240604145934.1230583-6-peter.maydell@linaro.org
---
 scripts/coverity-scan/COMPONENTS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 3864f8eda07..858190be097 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -154,7 +154,7 @@ sysemu
   ~ .*/qemu(/include/.*)
 
 testlibs
-  ~ .*/qemu(/tests/qtest(/libqos/.*|/libqtest.*))
+  ~ .*/qemu(/tests/qtest(/libqos/.*|/libqtest.*|/libqmp.*))
 
 tests
   ~ .*/qemu(/tests/.*)
-- 
2.34.1


