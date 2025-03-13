Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C8C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWo-0004to-64; Wed, 12 Mar 2025 23:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWE-0004hQ-Jr
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW2-0007pB-BH
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22398e09e39so9293745ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837548; x=1742442348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgy7Frrje2t1MTErBx2JzRotfnpwAVUP1jY7+Gvqxiw=;
 b=jCg6m6flM9FYKu1hX3MRvqtOOCaIMS1q2b7l0IZPt/Qm47DqJLxhp95pSetYl7rvDm
 HRA+0myEtPVmtJp0M3bP1GECq7iIg5frFjKcP4ANIIvIzR+VRkvCI3neg3dtRoQARoDC
 OeUl3WqyUE4dyZzwRHchrINEn/nKib3pP6KqVtgmjkbx1HwTSts1lUdyNJQr3NsT4RaA
 wSrkYDxi9IhlWCCfzg6BIpKGhD9ORFTL68xNBVJlKIqwPcSy3hCwiVr9xZhw4yjZFChK
 YVli/0J3bZZ7TVJj7eO5D0+CLmo9XNEsJzdodTmEOqcCxd2ofrNftvVQAo/YXKW7LCns
 qI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837548; x=1742442348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgy7Frrje2t1MTErBx2JzRotfnpwAVUP1jY7+Gvqxiw=;
 b=LxGoaw8woNSkCRCS/glaiRCA+G9H+wMgv8RHqjr9NbVUFRDj0OWOWMsrljbesQs6Kv
 aTGasNdUQ0gUxTqylzyGH5izr9ZuPKFJql9cmBAMq9D1Zb81voJj4TkoC+f2rAxQMKsi
 v3DZXeaAgzjVVcjRIsh351tS0FYLDCoAUumzGlkfYKjUe/VlF85luszTS6sYrr7/ga1y
 ssyKDhzrXxO3MjO/2rKkswasmokchA4c+FlY6Xj2bRdtEMW93ScQu6qyKL6knLmKyQy3
 toGqphCW6tBrf1YiiM3YT6PtbGAqxyezKd3B2XJzPQ7CeYHwE0B2LLpgl2G+87QxNWL0
 iZGA==
X-Gm-Message-State: AOJu0Yy/YzNUTUB0tnIEGjDOxw8WBeM6JPLpgIHsuMUOpTmuru8pX117
 erL26ryQCJY1t0GkeXAGCR1B5SDA97+x+rcytUWfhft009C8nTRaHDSVCil1r8PMLjqQaTj/f2N
 f
X-Gm-Gg: ASbGncu61vR7Qr0XzQHx+WQIzrf/H2/ZEECCGHHTaNuLgqJNAIzt0snDSy6SFAM6eIs
 ODYRPD/U1Ohr8aqaxRSPdwEHS5CcpcgVEsLkpHnXER7GgdYaYTWix8w0apxhfk0DXhIm0RzmzxL
 hFmGhEfVb/WtESv4wmzvV7Rg+lB/G2dD5lGT7Enhjd07tS8Lo7/t6809wVyeExObBYRvysFcL41
 D/Aotgd3Uz1L3fN0MPvtxAAHB5M1LoNbp5yKeqkhqD7nVe3NPV2ZmsrEG3CvUFrkGQsQ98zcHLN
 jS9FgGFxGWHi0+/1W0xHM2XrkqmVzW0y0qPadIbJmB3MF+Q7lVmVJLm+cs7KikkU2wLA2rTnQe7
 A
X-Google-Smtp-Source: AGHT+IHiXKlN17uQTvsHX6yMUNllNykEMLFbCw0PovuReYEiFhq08y4QESZDyTvYHe/YYUjDUtcgTg==
X-Received: by 2002:a05:6a00:987:b0:736:6151:c6ca with SMTP id
 d2e1a72fcca58-736aa9e7350mr34966098b3a.4.1741837548653; 
 Wed, 12 Mar 2025 20:45:48 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 28/37] plugins: Move api.c, core.c to libuser_ss, libsystem_ss
Date: Wed, 12 Mar 2025 20:45:08 -0700
Message-ID: <20250313034524.3069690-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Headers used by these files require CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 3be8245a69..5383c7b88b 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,5 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c', 'api.c', 'core.c'))
+libuser_ss.add(files('api.c', 'core.c'))
+libsystem_ss.add(files('api.c', 'core.c'))
+
+common_ss.add(files('loader.c'))
 
-- 
2.43.0


