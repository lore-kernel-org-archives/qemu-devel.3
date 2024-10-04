Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E6DCF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl41-0003pB-90; Fri, 04 Oct 2024 12:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl40-0003kD-0f
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:21:56 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl3x-0004IH-T7
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:21:55 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fabe5c8c26so22485441fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058912; x=1728663712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OOxOqFJJ2HqgakCTfYbfryttytdC4aA+0dIobma124=;
 b=PlIFSrh0yxcgXCr7mZVxqYAKhAT3qUeLGN30iQtSfFphmadQFpOWytjUbPxsrRQWbM
 82pDAMitaOC/fCLMxP7XD9JMwdQL3pBx6hYJzrNtVNxFViaEunDr7W3ZmcziMuhmWrqd
 w1JWpmHJnYSFziEGsXvYQl+sonDZWdQg5G8gyj1sjwL0QrBlKKUqxn3AG7Heb+MNTTPy
 fB6Oxwv8+Jvw7ONBGukuxMj1HkT5e0KEBcEIDUAwj81WDRucOUbL/xFoNR071DEt+jGh
 fGX6tn39k7ts4UBS3XUydKRpAcGuTp7jvNp3ux+cgcIITpYQetcj3VVkbIHSwtqsiYRH
 xGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058912; x=1728663712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OOxOqFJJ2HqgakCTfYbfryttytdC4aA+0dIobma124=;
 b=CdZPwYZGP/HnxXW79BzO+AEzEcU3iZsb9hvnyrSFFmVC+bG9kYk0CIGbLJCq60L7gg
 pcuP312gh9DjsRt7s4iggD3FDRnTMT9oHW7PTkEnDGrapy/oHmiCQvgUns+A6yQc3DSg
 reW10WGqj3Lh+oZnXqXBLLY8WTND1bq/1PnBwgsQ0Ym9oV9nXrh/HUUnzAuSnfuOEbyO
 AD3i1dv1eiKF8mRFnLAnRJ0ZR+bJEBbQlxXOuksxIHdxhgVg5w1yT/bFgIbElEygD4Ka
 vLbgP4We76BTlre+g0JRopg0H9dYohBnx7Mnb48k48i9GPI0oRd87w0W1Q/++qy/DI+J
 M0zQ==
X-Gm-Message-State: AOJu0YzKlr8GGVnygPi0b8ki359uWrFPVjUwBl6kLp9IpthE1Fo81KiJ
 2br2GRDym14kNnUpH6Akr0D8v4c/cxpSCG7g8M5sGH8WB1Vz+WKGQZyZARM7t/MPn8pP7rmSVqZ
 AosAq451l
X-Google-Smtp-Source: AGHT+IGaFBUw3LE4B93koRr0LTRyf7pT7g3wbCUSWTVzGXSE6v03WVJje3dU/Fj+fz9bIDFLA+Ocbw==
X-Received: by 2002:a05:651c:1994:b0:2fa:d296:6fbf with SMTP id
 38308e7fff4ca-2faf3c1419fmr17307381fa.1.1728058911540; 
 Fri, 04 Oct 2024 09:21:51 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b329a7sm146481fa.104.2024.10.04.09.21.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/8] exec/tswap: Massage target_needs_bswap() definition
Date: Fri,  4 Oct 2024 13:21:11 -0300
Message-ID: <20241004162118.84570-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Invert target_needs_bswap() comparison to match the
COMPILING_PER_TARGET definition (2 lines upper).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index b7a41913475..ecd4faef015 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -28,7 +28,7 @@ bool target_words_bigendian(void);
 #ifdef COMPILING_PER_TARGET
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
 #else
-#define target_needs_bswap()  (target_words_bigendian() != HOST_BIG_ENDIAN)
+#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_words_bigendian())
 #endif /* COMPILING_PER_TARGET */
 
 static inline uint16_t tswap16(uint16_t s)
-- 
2.45.2


