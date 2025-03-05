Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B68C282DC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWI-0004wj-KC; Tue, 04 Mar 2025 20:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVK-0004MJ-Kl
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVH-0007Jj-Ni
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc31227ecso17350585e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137894; x=1741742694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjtx/hAcibicszpFKAaK+qUa1ifgIbMomL8pZ5JTGIA=;
 b=khyBTYv/B/hdA06Kl609oM5Cq8gaBRzXavpkBSiUtj+H/uFm4xHaDxyu/0oQhVAWdc
 LVcyQxI/idMKS124SO2J401d9u3KCjp4JoRoWb7jT1MmKoH5zPv18roH32t4M4QL+zq3
 zlfv4UDuwVQ10rLCMWVs4ypYuuTdkmc0Wcxk4qkDmA8xrZdknzzWFYDQmhX/2WznB0of
 gKmYVPjN1smnazu+cCCLPRAbOP/haWw56R8wGk6PCz5mJwY2KiooxD0n2IM0M/wyaARf
 /TaCV7LhtoMhHqxO3OK1wjcU8OTHHm9Ix8ycHuC07JNqBUnCSioRi3dXRRGe95JWeGkA
 3WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137894; x=1741742694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjtx/hAcibicszpFKAaK+qUa1ifgIbMomL8pZ5JTGIA=;
 b=FF7xwjlFUOR1E3Q1wFi7vr9iNY4Hb04AHmMWo6SOAJWT+Xxq+bcv7Cdb8QhI757F0y
 sP4VztUpFVQECvKt2fs+csK6GYACYpmujrvu+rXji+dely4We96TB8//wjtmFlkGsbUE
 /GQy8v/fIT7Nn7WT9id6zgcNmGVWBhC1jLO8gVNfb/sVmZruNAsrDBPrQCQBDk+RI6Wi
 W008OjphInsvdAhM/e72OgxxUPRNnyBf5gqvdrIztIvgkXmZvo+veACIZn1w5A8dmYZi
 MLRBvIInyWxU9jgQLhai3upy6ZnPeEMoVCrSLs94ewHXshZFRVAvFdoBxer5cpby9dDP
 OOmQ==
X-Gm-Message-State: AOJu0Yw3jPJTPxmpR2pC99s+V7LM4hdcDLmxFkBcPos0P4OOy+sGTB5u
 YDZrnOigxP05gIluEM944vIWXkgP78WNR53fGXETkZC5FU4sr70Vxfaw9BWp9Zy/Bzmso+zHh1L
 0C6o=
X-Gm-Gg: ASbGnct9+oH9B+tlU5jWnbclnomPgd1yBRVoyvcHYIIsHlqI6UAend+vNqt3sj8wRWS
 /EQj6UVFPxIGBPFXvLFWqzpWDF6MRfsKS7i75ZVcusOIhxxbDtm/yc/p87H4G6K6UnzzN4bDyX0
 krBoSYihxIQz/6bI8VKu/HoALn9wJmHhZsN1YccJNsXWbJBiw6qz9hXCB4NhuPVzS8K2GsQ6JI7
 FD/qjgiX8JWBJaeJCPNrobSj0sgbfYWZ+Y3d4hTVBtHJqL1NUh4E8meLm9t48dQ25jAbkDVyEWX
 pdsxZKQYD8QSy1qEJw9RJqoXDGrIE+520A71JM+SU+LrTfWnmpVzf8EjUxn7LNgb1txBg3JqqFW
 TF+H90fVD2Vthbyly8ck=
X-Google-Smtp-Source: AGHT+IG+cYDrRTP153o9OFNSjDAMZKsOIgUL3lAx+KtDLWRjvtqHmJDQrMVsVp63Jdg9Kk57FhsEHA==
X-Received: by 2002:a5d:6c65:0:b0:391:34:4fa9 with SMTP id
 ffacd0b85a97d-3911f58eb5fmr871614f8f.0.1741137893947; 
 Tue, 04 Mar 2025 17:24:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479652dsm19689381f8f.16.2025.03.04.17.24.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/41] hw/arm/omap_sx1: Remove ifdeffed out debug printf
Date: Wed,  5 Mar 2025 02:21:51 +0100
Message-ID: <20250305012157.96463-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Remove an ifdeffed out debug printf from the static_write() function in
omap_sx1.c. In theory we could turn this into a tracepoint, but for
code this old it doesn't seem worthwhile. We can add tracepoints if
and when we have a reason to debug something.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250227170117.1726895-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap_sx1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index c6b0bed0796..24b40431832 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -76,10 +76,6 @@ static uint64_t static_read(void *opaque, hwaddr offset,
 static void static_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
-#ifdef SPY
-    printf("%s: value %" PRIx64 " %u bytes written at 0x%x\n",
-                    __func__, value, size, (int)offset);
-#endif
 }
 
 static const MemoryRegionOps static_ops = {
-- 
2.47.1


