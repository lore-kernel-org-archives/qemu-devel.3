Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EAEC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZon0-00020K-Bc; Thu, 10 Jul 2025 06:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomh-0001rA-DU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomb-00078F-On
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so845244f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144338; x=1752749138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03riluX1eJMP4tE7cuvXHWS+nhsiBt5c4p7l9wITSeg=;
 b=Jowrm6VxFUvDcJVugFCepGpaIrpd+2h6nhV6uA1nu3AfO1WZUSdKxH+W+sQsmFjV0l
 /0JpKSU6nv56CgroJaEU7jqQA6wWM36+1l5z+Q+sCuXoHdLwsR1YB2UbYP15pT227qsQ
 c3d21HYoCBIIRV88ZAUoOqgyHDnvsiU1Khzk5bDPsH/tJIERRLjIxpIyYD85NEfV4UgZ
 HFuMgsv3+NmtzNcfslznrQFd52jg2tYvhKImKBZHCIMOrvNXv1W+X0r2L9zhRZ2SCPq6
 /0aAE7BoalRSjg/k4iBvIZOZvymgmMjdZh0grFsKhq5qk4yOsYbz4PjU4bcmnmHZ7ovj
 x81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144338; x=1752749138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03riluX1eJMP4tE7cuvXHWS+nhsiBt5c4p7l9wITSeg=;
 b=xJBtzvXFqYnmxkdjrQ79hoR7Pd3+YKEVnSXWR1L2auYn6l4yvej75FUfhV/CNcuyV1
 rBR7aXzaMhWfrDWzkJPHzrSm4kYRFUZ1QW1E+NgUsIy/tYYKaqh05HZRZMeucTWr/QIz
 AlS+gp4hiGM/soff9trzJ3U8yuUHDRPmReFhExhEz4AbLlCMaNG7h1UnWnIG3O1dE3zU
 vHRV6n9UOQO6RWPERfX4OhX1VZRTWAfHShf3TeBlzMoRlHgemz4avxOVitQ8VDrPOy93
 z1Fapq8LPAJ3NTc8V4yZ6cSvqlLIGjd/maAP8pQp6/nguGKEQNwri8rLnLhjcF+t8OH+
 FXTw==
X-Gm-Message-State: AOJu0Yz7IlhUPuoM9AqjBrnTU47IH9bx6iuBf+LCRLHjkq5pAh5sWy0w
 qn8DNLFxFY4FeNQc1OE0CD9ov0eflKvbumgdFWYgd8zPToVvlLkqCrr9nVlCDXQYsqRvivU4QAw
 ArDiCCFI=
X-Gm-Gg: ASbGnctXik4w+HHAtfk1N4qjZffj95oCX0cEbvpTo3ROnsrgwwbRVadsmTyQnHZPA7h
 18YR22yjdr3Tp8AnMvrM5IA0QEXu87UbvYbyUzSdZDrOe1vFMKKOe0HThYrz6a7PxeokQbIqmxS
 X1rRNJNLwk9F8/5+QiY31cBKfP44cOHgTlyckChP7bqKjgLHbNKSdblhxyA/lWT6ccKRRPntmeA
 PoRkDdwwpFJ96zmI0327YH979LssdgZxONWeSNWaQSA5nXNO+7Qv1/L6UGG44na6IOS5XYkze2H
 AeYMkGMXY7g2Fj9g03sqJhAoA7wOVpXfQstujunmJGtIsid/MZexKKkWumOCx8A=
X-Google-Smtp-Source: AGHT+IEkEpkDYS8h/LJ2ZSr33jWevjNrhMbuaEHbfGs/a7uc/uvM735BxMXl8DxT4/jFQVEIpL2HQA==
X-Received: by 2002:a05:6000:41ce:b0:3a9:dc5:df15 with SMTP id
 ffacd0b85a97d-3b5e866f829mr2057765f8f.13.1752144338218; 
 Thu, 10 Jul 2025 03:45:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd474a9csm16086125e9.16.2025.07.10.03.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ABC495F8AD;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 5/7] plugins: fix inclusion of user-mode APIs
Date: Thu, 10 Jul 2025 11:45:28 +0100
Message-ID: <20250710104531.3099313-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In 903e870f24 (plugins/api: split out binary path/start/end/entry
code) we didn't actually enable the building of the new plugin helper.
However this was missed because only contrib plugins like drcov
actually used the helpers.

With that fixed we discover we also need some more includes to be able
to extract the relevant data from TaskState.

Fixes: 903e870f24 (plugins/api: split out binary path/start/end/entry code)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3014
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/plugin-api.c      | 1 +
 common-user/plugin-api.c.inc | 1 +
 linux-user/meson.build       | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/plugin-api.c b/linux-user/plugin-api.c
index 66755df526..8d6fbb60e0 100644
--- a/linux-user/plugin-api.c
+++ b/linux-user/plugin-api.c
@@ -12,4 +12,5 @@
 
 #include "qemu/osdep.h"
 #include "qemu.h"
+#include "loader.h"
 #include "common-user/plugin-api.c.inc"
diff --git a/common-user/plugin-api.c.inc b/common-user/plugin-api.c.inc
index 5b8a1396b6..63f3983271 100644
--- a/common-user/plugin-api.c.inc
+++ b/common-user/plugin-api.c.inc
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
+#include "accel/tcg/vcpu-state.h"
 #include "qemu.h"
 
 /*
diff --git a/linux-user/meson.build b/linux-user/meson.build
index f47a213ca3..efca843369 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -27,7 +27,10 @@ linux_user_ss.add(libdw)
 linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
 linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
 linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('semihost.c'))
-linux_user_ss.add(when: 'CONFIG_TCG_PLUGINS', if_true: files('plugin-api.c'))
+
+if get_option('plugins')
+  linux_user_ss.add(files('plugin-api.c'))
+endif
 
 syscall_nr_generators = {}
 
-- 
2.47.2


