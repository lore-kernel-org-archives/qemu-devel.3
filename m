Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B3EC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdo-0005kx-1e; Tue, 21 Jan 2025 06:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdi-0005gf-Do
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdb-0003Qs-1f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso56670195e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459695; x=1738064495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EBvExqekhvI6jcPU9fttVcHOfFc5T0tfJ+EZdg5nMg=;
 b=qXcuvQ8KDvy+Sqgb920fqpJBtbf6OFybJQYhK6E7vU0IVBzr0IlVvmqtOPHjn8jryR
 XRIN7GpHiDDPWJkT9B/cV6WertJz5Xaosrzat+WDqJRGm0Tsj6WotZfbKgVfsIfl2aVC
 a0HLjrdYbLFsBq31Hb7MNCptjANTuabUccZNZJnPSksINW9KqsFs9y6Peq+RzNNmTMro
 n1z35uhECZnjTR4+2alVZAjarNTnj7dW0nyuJcCheC1SY7bNRGkaKFxX1j4XpSmXF1ZL
 r5+0R8CpGtDQ0ZwUcjwO2a12rdcb0xGIZQLxCKQUX9fIbYteLXMiiXP5kujDFS77X6Kz
 B4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459695; x=1738064495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EBvExqekhvI6jcPU9fttVcHOfFc5T0tfJ+EZdg5nMg=;
 b=N4vSNR0crA4tXLjS9ke1QkscJtkszGiXU0Zy2OVj0ymUF3+ORMPmIWOg9gDMaZvB9U
 cZ019X+MugW77zO7N6DYNFi30Zd2I13/yhwHAH7wYgAKY1HHYMNXl7Ee3eYQIhbfoHza
 GWfoGwiPgwTxAJl7SMoap5smCyQIPeuK7NS0sdrE/KV7fB0/kDDmrDsf2atyPVXx1xe6
 SyyfsEWvlFEa+BHNG5sq7XxwR56NnmxUR6Kh0eQhSrptfPvfr01RJ+NDkcWADFHSzgtd
 nb2xyQZqulB9ws/LUGPbZouaHzMg+bWsk/91jbSoYneGbeNswBFDNJ72Kp4JGeQnG96r
 qY0w==
X-Gm-Message-State: AOJu0YzxYyiN6Wz6tYeOEgapAWKS5v5MBwVZ3esFej7rDqPdG9WFPjn2
 0lnWMs1I+U1dUDnNlC+NkUg3qhDVJBjDP/Hbr73yd+d3Bgtpu8e5ApYKvdBkffiEEwb1yVwW8kS
 Rj5o=
X-Gm-Gg: ASbGncu2THvvlFKSH0SljSV1rEwOwuuPVyrdmy5DUJGmjzD/kSVb5EaWhaAlKPEcAUT
 44YMPC+45ImYQLsz5srL2QmQZGliY+JIRfN0pZfZdomRPAH7xrxzJK9gChMk0dADl5G8/3gacZF
 FYKyFoYTIHAG7TiIMp7wWjUHfMAwLfBITCudB6S1J1Ps5i+wvLhvip2XxtM45H5O9+p7lgFoL57
 EsQeJBYiKl9+VTBukn9JJ3u1tRG5xGrHv6CKpsuIbu0QUDfAIvuXryY9+J0ovg0OnxEFTjXYEGZ
 dczTGwRs/RekZpiQTMbr4f7HXcNtt4beRrI1/kMpMhKP
X-Google-Smtp-Source: AGHT+IE+K5MC6VWNvBNlmvep3x60OHi1bN+kYIodq+lGzOgTwLM8ACjm1FxvjtkMJ+iiA85448mYhg==
X-Received: by 2002:a05:600c:511b:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-438914304a8mr123262745e9.25.1737459694869; 
 Tue, 21 Jan 2025 03:41:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438a46b0497sm109750045e9.28.2025.01.21.03.41.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/11] hw/core/generic-loader: Prefer cached CpuClass over
 CPU_GET_CLASS macro
Date: Tue, 21 Jan 2025 12:40:53 +0100
Message-ID: <20250121114056.53949-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/generic-loader.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index fb354693aff..0ddb3a359a2 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -48,11 +48,8 @@ static void generic_loader_reset(void *opaque)
     GenericLoaderState *s = GENERIC_LOADER(opaque);
 
     if (s->set_pc) {
-        CPUClass *cc = CPU_GET_CLASS(s->cpu);
         cpu_reset(s->cpu);
-        if (cc) {
-            cc->set_pc(s->cpu, s->addr);
-        }
+        s->cpu->cc->set_pc(s->cpu, s->addr);
     }
 
     if (s->data_len) {
-- 
2.47.1


