Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B9CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sO5-0001DB-42; Thu, 09 Oct 2025 11:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNy-0001Av-Mg
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNu-000151-JZ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-41174604d88so529601f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760023004; x=1760627804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGa5kqFwhwoIKw1uiLFq1Qk4JSfpOOUmWtfEeqicl4Q=;
 b=mLyPmevY7y4PHzCpmQPS69u3hYqX2WebZxPsPav3KPgaYVA5/KMi/5swqrxF1xyXVB
 ilSDcApIOL25TynhVX8UpLLAQOofcwDKD2oG0tHwBCQZZDitrRSTrAUlI0TsX4vJnegu
 c7BS+LeL2JWreJgghqx9k17k/ec6HndE7JQQuSZbY6KTKDN3tPr7A1Pn4ysx+wAaqrGg
 0y15Zjp60dfuEoXGpb5WTT6if+twkeyEX7Un4+yci1A6yEOuAvI6eVU8/nhzxEGrQfD4
 IzR0wOsEuloJtzeEFA6/wxTQYh9H8HFbaerwuvMGAAnM/q1InEOcLVT2zdtulA8yoFm7
 cMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023004; x=1760627804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGa5kqFwhwoIKw1uiLFq1Qk4JSfpOOUmWtfEeqicl4Q=;
 b=HwiYlfLvdYXynFdlaSsgW2+HspRbnZBB2tBAIKJ0LiOJ4oXm+6vF60fP2ei9ovSX/o
 dM2mGPH3NRgUxunhhEdagP2D/yxm7OptkSZqX7sgmrM/jwlfnPTvY7AuHUlN83lnT7Cx
 7H+GxPVjoXW48aSCEs2AKA6//waEBRzO9Fo37YWVOiOorSzHMyymyvTx7SdKhCvOYAWH
 tWAX5BzcmfCoKDj/0AcrtTxq5VXl3t9MchrhDHQs+cZfJid0SIiNQtE1+3JK02NpMi6x
 DSiWMkYTsxNUM4/2T/8TBEs5m4Z07O6tgBi/nABDilIrQa/6L2JL/8ZFjfZ6PwdtTSvf
 EIXw==
X-Gm-Message-State: AOJu0Yy3UVgjLCRQ5qgoMPpeXU8yrfAsmIO0WlXsPXw04iktjwu/WZnc
 +UbLtt2xc4GIK2pBxUFlIfuQC3f3hgS4HsirA8q3s+IuytuLp5WaxAa0z2BTSvxJGX6tbvC4/J6
 wH/E82zIvmA==
X-Gm-Gg: ASbGnctRFxbCBTRS5KB7Y9aujrUtLaUxEehVWH6czMPmrHr2h/DdIRxa9fMK4f4IX/A
 5EAwkUDkdW8KNYhBNv9w6lSwozHfJpdV/4ExmUv0m21NYfYpfjhxgaRanVSVVD+aeowKPEf7Qdr
 ovchs/pivsy0POYjuExDX8WYb1km13nOnXvC1s7AAq4aLKCZlNKJvMTIi8VG4DxEU0e3dbKQF6u
 K/zqq4fWs3aD0iKbk81ESwxbtoBPhTAjkbHg/wP7fGvKIwnQlNdscG8qGOkHNj4AgxeBzl//tG7
 gBCOAHsXoAuufxGT+bKjX/QAVGqfXQcWorYi9DuVRq1HH/iS19v3G6f0oMx4RtbS1Wnj+B3R7jo
 lcOr9wVizQ8PCSa1VSKS1Ywou4Qjt+i+Zd9lZAnLTJzl81Io/QqUWIhBpiZ+zFG+HUh/8W5F+oT
 FbKioSEkxaHjoBQn6snqF2WfMnDZBlBG2BUI0=
X-Google-Smtp-Source: AGHT+IHUJyT5aeNAGyRzT/PCsrOfFgBGjnjH456eWH/kyRsExnc6fIBvMrTf4098EOQNbUwrsqH2tQ==
X-Received: by 2002:a05:6000:2c0c:b0:405:3028:1bf0 with SMTP id
 ffacd0b85a97d-42666ac2d6dmr5041472f8f.10.1760023003818; 
 Thu, 09 Oct 2025 08:16:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9724sm34985878f8f.28.2025.10.09.08.16.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] target/rx: Replace MO_TE -> MO_LE
Date: Thu,  9 Oct 2025 17:16:06 +0200
Message-ID: <20251009151607.26278-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

We only build the RX targets using little endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/rx-*
  $

Therefore the MO_TE definition always expands to MO_LE.
Use the latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 01a065f937a..c83e7afc60f 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -74,7 +74,7 @@ static TCGv_i64 cpu_acc;
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return MO_LE;
 }
 
 /* decoder helper */
-- 
2.51.0


