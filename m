Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FCC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57X-0006yM-Dl; Mon, 05 May 2025 19:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57C-0006SB-Q4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57A-0003eR-Lf
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso59555425ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487247; x=1747092047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=k6T60VQgdXDMYJy3PZEN9lXMy9lrzI/Gbcjf7O06DAt6EzB1DuwPAhoqcpLBPptft7
 c7EX6+hOdUgbNc0eZmY45w8n5etDoGAl5r+TAi44gg4ECNdk5zE1dEe/oNhuophLlgg8
 8OyFKK/8arNm0vInBqLyGPxVVwlYM4SCqB2c88yFqGUCL3L1hGkQjMvm1gDwan/hL78s
 ksRuHg4LcYSFU6aiAXW600V/RLMro/jed/zHKEf3kUqBrvGVU6gVwiYgItTX1hUGKlLO
 xsDjUovUxMFbtGpK+wyk2dji8y0K8lllITmHQ/PArAEl8JomnQcAHLCu8vKPo+ODDY1h
 uVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487247; x=1747092047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=C5qS+0rxJRMbXB0n+frNUkkE7R0SU1M8KmfTQ6EFJYM/urZlgh3ZG0cRjZaUSKN68t
 KpMft8E/IyyH6cz6iTgLmHQCewiNUT+RssoPp19qnoDNdgyobSIxHI5HABy5tEr5h7hC
 36wDGDrE6vbTq3hnFCPOkuFGSpe06NIvBbSLqFSIV1Vzllp0VXU+T0zTzHqwx7rOySWd
 NaRU10h48RCMetM/FNzTauWUM78BIglPvVXI1+NVDuc97Pu8JoA96W+5200PiS7Jl4uX
 DSdeslWWwMzFX6kXNgMLp3aMWNEKIhm/MFKHgMHojvU3EYNBI+SZ+/OgxVU6tgmUzetF
 db8w==
X-Gm-Message-State: AOJu0YxANnXy1+9qLKPggpkZpvjdvIkcbWs7fB1S1ocEX3sPxp+pjovI
 q4FfJi2Rj9pPOcVFu5S3ITOYyH8UT017sjTjwqWGb45omz4EBaNS5BxhYgRrbQ24e1qVKdy6ZiS
 myAY=
X-Gm-Gg: ASbGnctGhrYgMy5p0xMUxDeOJfM4op1wbP/IKYI0Ik6xJezACw6vDY6U2Adoo1Sz0/E
 19uRO4xrhxIQ833zbaBxQYD7WT9uyIU4d3U88ZJjb2WfU/nnm7x7yFVocQrxXw8lG3WUCuR9fyh
 sIWjaPYeK+0UYJdbC7rF3xdz/NQzVMZufZq0vazc81afw8EYvhqZQ7ueImV7cG9VAm0Z7EWjznC
 aJRjSmDJN2hO7M0U9E3CFuNCyRV9NZF138WelCCYx38MscjGjN2EM3z/P5u2JITAlHZz5zXda3N
 P1+jkTlAVtl0yDAIo/ZpfuO4eY4qwVuEqJmtDj7o
X-Google-Smtp-Source: AGHT+IEMmS6ciWk/Y5QYiejcijVDCumZ8eY2Sx72qIxgeSdq7SZvIl1V5RaehgZdSDls9z4ASH3d6w==
X-Received: by 2002:a17:902:d585:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-22e1ea79d91mr141126175ad.43.1746487247181; 
 Mon, 05 May 2025 16:20:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 30/50] target/arm/cortex-regs: compile file once (system)
Date: Mon,  5 May 2025 16:19:55 -0700
Message-ID: <20250505232015.130990-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


