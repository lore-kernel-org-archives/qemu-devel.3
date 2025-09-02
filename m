Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888CDCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnl-0001Ua-GE; Tue, 02 Sep 2025 09:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnL-0000rf-35
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQn6-0004Ve-NF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d75aso1080030f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818673; x=1757423473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h1bQ3YvXHpWdKZQA8th6hBcDTCJDn8e1NCM2+N1lCr4=;
 b=eT2Q4Ev/BFSWYoZgLckHVW+v2pprWe6ETLlJPFGkWOHiN8ZgS+1Ty1Q6P9LFDy7Jo9
 yZWvcY8j+J/uRKsDPURyYKmxelZyDYFHx8f4EWIcuQXAyvDgBYFo4Gj1XLZkzcI/A1mv
 PQ0ZnPVC4Pm6QfRf2oOIk1pbCKJUcUg0vqE2b0vG3r1DTsCAMv9lgp7X/TH7NfrULTxB
 DUB/dvaSfrX41XFrfdZ/hrUEmbqF4MZS0nvaMfaeHYT6YwR1+hWs6tOK8ZNdKQ6P4fl5
 uWIsVoZH1PlLrYxglMN2y2LM4PJsAz3rjHi0LLuHn5+0UE0Jn8AqZBFfkvyegzqfPSt1
 Ewqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818673; x=1757423473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1bQ3YvXHpWdKZQA8th6hBcDTCJDn8e1NCM2+N1lCr4=;
 b=k/CdtWGEpGeHtFjdjAO5m4sr3dAvQia1K/35EbX9uWxZJ7QGNxJhIPb9CQg4WEWHa1
 Xnl6NeEKFQ36FnlULkjiHyhuQ5Tu74ASVC7zHFftkdo1Gz/oZ6AsZ78c546pT7YgDsvn
 9vQbKGml7NUnwxilex0p7y1GkHgGmfgQ/B8v0kiW7lByKKvHw5CTVFzO/kMsjWWPg76H
 VzVf5GF966dftVdaFrM2ATJDnig6t1rg4wdc9TWKfgPNKfDGVyEEzc2G18QTZDzVPXyb
 l6EKoIjZRGJZGNm0ywNR39MZITwusO4K4WOEfob2ejNNZM9B1hpojbQhGJJzCgkFqMm1
 Pbfg==
X-Gm-Message-State: AOJu0Yy/gveK9JO4tCl+lfD7PFNZnFhA9+qZkfo9TqivGLw/s3qOBejm
 xQGScjvkqu84xZJVMAbk2fkYWn3BsTBUkbc3N3+Nu8nSUhP8Vfi7W81QyzO14PzEe3d9NGu5Jy1
 zfjVh
X-Gm-Gg: ASbGnctwjcmClM5fj/lECUK8lXKy4MiCfa+oGBgk/Qs3IDD/K+WBnqd3Tv+S6tszdux
 /40KHq/IzzKXffQCAnD7XLxcYOaLk/rqkhuORJIpNqYQ74DTkV/Z1FIcPCPpUhiDghMKWjGBEVD
 ax4ndB0S7C6pLKCgoAMZ7LIXAzNm4YhBAc+jEOpa3v+HJeUIBcniZZQYmXuWhKbLYoqHC2QSaT5
 IfR8wthd9Ps1u1p+jiPHXfj4B4jKTtasLgXtggPKlXy/8vUBBzq59IZY9pdwZbvGTWYSPuoJfds
 XdBQSpGZnCi2kPeBOzuByKKJqY0cm+XX6AICABFTAZFtwazYYELlqfYYG/lHy++krAOGMSFg821
 Xqxql0TW6q0sFlUyd6S1ycrN6kTaqX6siWzxNo3XB+Z/tGLlfZYuYEn9X9bGLt3mUgvoecGIQ
X-Google-Smtp-Source: AGHT+IHajneaawPqJGVPbngsHpW1dzCmK3xuoE2XLTazpZL7IEuk/CQWZF3UDFRqxoWPYf2r8sBYwg==
X-Received: by 2002:a5d:5849:0:b0:3cb:e47c:5e4e with SMTP id
 ffacd0b85a97d-3d1df34908bmr11490735f8f.24.1756818673509; 
 Tue, 02 Sep 2025 06:11:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493b8csm19233720f8f.59.2025.09.02.06.11.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/39] scripts/coverity-scan/COMPONENTS.md: Add a 'plugins'
 category
Date: Tue,  2 Sep 2025 15:09:49 +0200
Message-ID: <20250902131016.84968-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Cover the TCG plugins files under their own Coverity category.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250811094341.91597-1-philmd@linaro.org>
---
 scripts/coverity-scan/COMPONENTS.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 72995903ff9..95805b536bc 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -147,6 +147,9 @@ tcg
 system
   ~ .*/qemu(/system/.*|/accel/.*)
 
+plugins
+  ~ .*/qemu(/contrib|/tests/tcg)?/plugins/.*
+
 (headers)
   ~ .*/qemu(/include/.*)
 
-- 
2.51.0


