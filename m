Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC4C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLd-0005Xg-U2; Thu, 01 May 2025 02:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLL-0005G8-CJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0007P5-L7
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so936711b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080655; x=1746685455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFKnCJEsWbUz8XpZfd99k3cLIjXrE+Y/dzrUU3M9eY4=;
 b=WSiqCSN5PouVD97aWiG4zR8mnn8iysX1XS5In8RWdGwdQxCvrn6l8aATPs89jrgwRt
 HhQLQU2wyOg36jckH0vgvxl9PmrsjafCnFN1e/Wm6vY1m3PkqbeG5ZghDT+q+Q2tASLm
 Nn3HJfaoo0W+7v2BCh5/a36nDLN1R/W0QRFdjNeZZV8GsIxSII15nSyphjSJuhnIGBOG
 NnxyWclqIeuMK68LUeThlAS2zGFjqRSBypCeQooXxhiJPOGpKX4uUUEvnmAq601VpJUb
 uOl54RJW/z2EuHrKC7zEX6MkKICQP/5QIULC3OEEYz6FGhjDzl41r9xY6yf12AjvbvUE
 HoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080655; x=1746685455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFKnCJEsWbUz8XpZfd99k3cLIjXrE+Y/dzrUU3M9eY4=;
 b=N0xmtaJNczXRaMklcGwTbf07/PCkCXoONT8kb5pc41aSzgMLvTdO3pn0QywP7ve3xj
 N4gKx6sJQlKBEmooHMn0HOg6nOUrNDb3C6Pdd5RdB3L+yV2WPK9Ft5XwpmL8YLfntMIG
 mG02YfhuSRsq0xL46esPxabLsGoZVjWtktkvbcUB69u18shGzWM4o0BgiyDHPl0dllGu
 EwOuTshySjvuhncsONPkgKbR7b+SIovtQEdKbYUnbJMN1w+02gFQerd1E/qglBeaVfuA
 ETBvpCiufsrKxv7NbxudXqjiCnZN700U8A1c1gYg2ocMr8sCVrEPWZtxxW8c1lsj5USz
 dkkw==
X-Gm-Message-State: AOJu0YzdWPewqn77UE2JycYW2ic7oL2r187KAoY7677QTwdyskKnZmE6
 5Zd263XfLDNWUWl7fjU4nzlZICJnBLPICr/IjNxEPuo68PXAByvO+5llKH1HMvazSrQqzeyyP1f
 z
X-Gm-Gg: ASbGncvcDSSKbCtmK5VJn4JUIde34U7mcmsh9/gROEDOg9ESo+ujICocT3vjVLYlWyu
 qpWc9s+yJ2mnOg+YdTeuNpT8fDVFURqW0/xj5PFi8aChrJ/ior+UL0VK8OFQg0iwCn+vyOSNtbt
 pKHzXVMy20JP+erDURc9axuznwHFlaqSdB3BDCxsenH1jPZK7f031Db6khjdDxz0rzWCf9BhWE6
 +5CNsOENsp4s5yt5BAvn9Oiqyq3EhTrFMonDouk8JnoDJs6VrS03DYUNF0Rzrv7gEr+HEueYo7Y
 0EFBS3pxeb6aAvuE1FY2496vvcr9NBksrEgRClB5
X-Google-Smtp-Source: AGHT+IHRt4EsN5RAvnHPj8pBa6/Pz1ailx/SIo7/AvzZvxJwjfgrzXqyG2+jW/OA7KvO7RhZpbUhTw==
X-Received: by 2002:a05:6a00:2d1c:b0:736:562b:9a9c with SMTP id
 d2e1a72fcca58-7404924ee9cmr2371669b3a.18.1746080654733; 
 Wed, 30 Apr 2025 23:24:14 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 26/33] target/arm/arch_dump: compile file once (system)
Date: Wed, 30 Apr 2025 23:23:37 -0700
Message-ID: <20250501062344.2526061-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 06d479570e2..95a2b077dd6 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arch_dump.c',
   'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
+  'arch_dump.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


