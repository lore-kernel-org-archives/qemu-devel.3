Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECAFE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRZ9-0006hS-Ha; Wed, 24 Dec 2025 11:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZ7-0006gm-Hv
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZ6-0002BT-4A
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso39560475e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593098; x=1767197898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dg0Bhd95cbd1L38NFYSJxFXh7H8x/MIo/EaWoG2HpcM=;
 b=dTvNz9IlTwp6DpObxHs97/dwIuRyf18UVgBwAUsQ8ht2SfALTXKlAICoBKG7JBGZzc
 KGHcLqSwl3szWp7IcsWb1fN1gH0NCigrZt8TqKIssbn6LF7SHrEVNpAIDTQYIgozsEIZ
 iKsMgiAkEFsQbGVgPEb//xp9rg1Qh65UkzPAGJnAEbuN6rOv+z6xQdTd0C94Osh5CNCy
 l6sD+UvA7LnMGpEwaqGmGzOCX/6+OzgGre6SyQEhsANtElyVD3K6vABSJoNeCmLmG1oO
 MJEWt369GATs2HAohc5ejH4WFc8Tfj7k029umZK21Jk4t83oI7503pCW5wkllYyiJv+w
 toAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593098; x=1767197898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dg0Bhd95cbd1L38NFYSJxFXh7H8x/MIo/EaWoG2HpcM=;
 b=gHBhojAaugMN7gbwL5hMPQ1sTufBbVyzlK+OLmsDZAlgprqOXWt/ED+ZG1HiD6v3BB
 oFHnkLMze2piZ069bpqfMfqX/Dhd8mTTAjgi3Qv5jFzj3iUrtmK6AlPzDbRAv/uEKiAK
 lWeXZ7+lWT9yBkXdyLQ3a4paxZ3eqZ4NxHh8KlUsV6MT4k0M06LJxE4tmfcSy06wJ6FR
 cqxxf3ltNTTipBenH5LYXcO3k1cCifI1+//gFv33O9a+lvKPnq832yPrw03sNXOmpVZC
 Htz/7Pnn27PCGAOcY23xLkq2IY9AlAWk1e8LirBvt14SrZlf+ohExuCK6Cd6QZNykT5X
 4r3w==
X-Gm-Message-State: AOJu0YyAAP2fprRnkPpMw+J3UAppoSNGQvVr6pYjzUBirTVIs0rMZseT
 UXAbUiorAjCFj/7CoHILDXZD6OIO7BtTBO1C76N6VjfDdE+YX+9key3YN7e9TYNYG++Zvckyr+/
 1bpgtd0Q=
X-Gm-Gg: AY/fxX5RaAYnYgsHbiVhjN1gsOkKIANzRJJlPCwrF0+UMENYLk4K+cyzuCOQ65HlKy3
 E3nVrGzr9aYgsQ2YXUmpyCrUygfyGRJHREvy2KeZRiqzThGIgthPKydthUPiQIvcTR+t7elgRpj
 mLnMJBhp9m1iibwazH0y/lqochH8GsrWUqIJ7EcUwZPm3NADWqMLqrUR2jiGOf535r90cFdYRn6
 xVCLjve7Gq/VuxBktq+nm4TdrlH0gAn8g3nPXlzYRTHvxwD+0LCHnY4kRWUExYbPSHCGky77rz4
 VnCnJpMQwj35VWr8BGe1dMhFn8qPc0+retVze1ybOV1ifk6Hj8GIANP4nv+kr0Zx+Azr+9Fw2Y4
 Ni8brDqHkGBLps1/KwKocMDJ00Rhb9cvsCoXPlgh861Y2RuhRFcnIE3fFDiJorbTyC9mDa9wmaA
 0ouMQUWctr9POlDcnU/YqO0le1kXDli2WZu5L/RrHowNUY2N2dx4wWN/z3udyBBQayTQ==
X-Google-Smtp-Source: AGHT+IGlOu/Rb/vtwE7kfY3E2zFRos3p/BCrivWSCrWuPLafoshd7uHKRRznC+nyatOkZ0wAIARYVQ==
X-Received: by 2002:a05:600c:1991:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47d1953318bmr177283805e9.8.1766593098208; 
 Wed, 24 Dec 2025 08:18:18 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm34995704f8f.24.2025.12.24.08.18.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:18:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/intc: Mark OpenRISC-specific peripheral as big-endian
Date: Wed, 24 Dec 2025 17:18:01 +0100
Message-ID: <20251224161804.90064-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161804.90064-1-philmd@linaro.org>
References: <20251224161804.90064-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The Open Multi-Processor Interrupt Controller (ompic) is only
used by the OpenRISC target, which is only built as big-endian.
Therefore the DEVICE_NATIVE_ENDIAN definition expand to
DEVICE_BIG_ENDIAN (besides, the DEVICE_LITTLE_ENDIAN case isn't
tested). Simplify directly using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/ompic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 047c367478d..ee34501f675 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -96,7 +96,7 @@ static void ompic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
 static const MemoryRegionOps ompic_ops = {
     .read = ompic_read,
     .write = ompic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .max_access_size = 8,
     },
-- 
2.52.0


