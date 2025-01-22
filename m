Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7E4C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUfE-0006VF-BR; Wed, 22 Jan 2025 01:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUfC-0006V4-OG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:56:34 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUfB-0004qh-Bi
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:56:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso45305225e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737528991; x=1738133791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhkcSpkbNbYstwLK+TiU/Bm2tD0SpN+f7v0biaDhmNE=;
 b=guVkWcuqYr5F7cZ/cXNo/bUddijd2zEoQltMpIho/5lIPLtLObUlSYI7F28wNb3Aqo
 ZlExEzDLfH1yGb4wMcGLNW014YctihBSvjyqBTAIGwDIB3EpY614c1ND2qWYqOd7zOrx
 8qZXkJ8XAsFhUEsE89iarp8T6hKTjyIQAoVOLvncVsSTK8pskMO+r0ecZBD4Bv7FqhMf
 /z8RdUZVP08XVNHrypfpe532wkoUmHnCfRc5NwuD6EKA/XtaLxU1osRzeW2I5SY21czj
 uQ2b9qI84OAaWw/OsQllumU5Qrnw6h9gIC9vkFF90WH/Gth47QAsH8B0zvxPGG4eTEpK
 OSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737528991; x=1738133791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhkcSpkbNbYstwLK+TiU/Bm2tD0SpN+f7v0biaDhmNE=;
 b=AXENNwI7F12M/INKHymeR8q9N0b9FGPMPZQfTRo2qQY+RE2Rw516O+q8A5Ab1VLYck
 M6tQIZZtL/F3cS6AAILhaWCvBWBE6meSpa8lb/jFjBEaaOeffsMowkXLp9EeORVwtCC8
 +toPo2OA5dtA7WXVvtXLV/IxOfMt09LQIkfdgU7TrzHOYj3iLMGIvkwKWY2MGjTaI07H
 AIEAKzG1XWO+yRe4KyUqOgi15ad2JhQN3WMFcV9s5shiUkuPKxy/KMAia7frQ+gedYF2
 C10RqNAnxvp841GE1i1L5N12kQ9URTByFbBqhXmiIcYVQFdD0gxKt4nnzT/LYfT65Vse
 9Prg==
X-Gm-Message-State: AOJu0Yy8nd5GYp+qbvrL7ZlXd2+G3aqWv2zYi/W12d/M6WotvZWFnPpa
 sTP6zcb2DmBwerPRobqg/0ptDkNBhCJM5OVx6OIL7eIGYiifvFbozkC0Q/y0LQ6Rid3rHPk05BY
 OM5Y=
X-Gm-Gg: ASbGncslHYTWr+QrxyD1yNsylB3MrBdkIu8wEH4VkDvmoHzDGaTmHFGrOMaAfNP5Vy8
 C1BMe9ZwLu4iFXhSwKq2OfiB8kqSFHXXhW6XceVdFSzsOemOAT+dlcVd0em+NundFMCT+VqGyfV
 1PT7wSOXwujKWGQ62aWTOoFOgJZLzKguYpaaVoR/JKxpuuPk+22BT3YEMjD5oTt5iN8qBp+7BGG
 dVPI+dbpC64IT9Yv2ywIeLKtEYZVltdPM3AyBYf51LFNOhVGocJr104A4iMmk1RHUuKm53UyoLV
 9uTyiqt5TfO79q/bCPReknjo/qsMuu3VL1HDy1HQ+2z7
X-Google-Smtp-Source: AGHT+IGk+AzCzbLFNo3X3cmkkkiX7tCwzcWPzjy+oQAFAVs3yXTJKV1aUguqtWlTyEe0Sn0Ym7+XTA==
X-Received: by 2002:a05:600c:450e:b0:436:1ac2:1ad2 with SMTP id
 5b1f17b1804b1-43891427485mr161877285e9.19.1737528991492; 
 Tue, 21 Jan 2025 22:56:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31af70dsm12479435e9.18.2025.01.21.22.56.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 22:56:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/cxl: Remove unused component_registers::io_registers[]
 array
Date: Wed, 22 Jan 2025 07:56:23 +0100
Message-ID: <20250122065624.34203-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122065624.34203-1-philmd@linaro.org>
References: <20250122065624.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Avoid wasting 4K for each component, remove unused io_registers[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cxl/cxl_component.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 945ee6ffd04..ac61c3f33a5 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -218,7 +218,6 @@ typedef struct component_registers {
      *   0xe000 - 0xe3ff CXL ARB/MUX registers
      *   0xe400 - 0xffff RSVD
      */
-    uint32_t io_registers[CXL2_COMPONENT_IO_REGION_SIZE >> 2];
     MemoryRegion io;
 
     uint32_t cache_mem_registers[CXL2_COMPONENT_CM_REGION_SIZE >> 2];
-- 
2.47.1


