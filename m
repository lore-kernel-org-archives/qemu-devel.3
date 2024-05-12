Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCA3C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s65zs-0000bT-Te; Sun, 12 May 2024 06:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s65zq-0000au-73
 for qemu-devel@nongnu.org; Sun, 12 May 2024 05:59:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s65zo-0004kr-R8
 for qemu-devel@nongnu.org; Sun, 12 May 2024 05:59:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4200ee78f35so7908365e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715507994; x=1716112794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y/uBphHmmPv9z/as7JOnNYaoi1OreX05Ww8SM9wCY5Y=;
 b=b5WsUk3NgeZCcPXOcVN6UWFuCLL3c47dlBejh6SfJyOx+pW9lISWqDqoshpudYmQC3
 idxnBlpXB5RjHbjISFTqMtoE7QcPs/FMpS7/+frYR0T1mFn1PiZDlf0mtQI5Lz75we4o
 Q9eXZvNBA//YDuFRDW0EN4DwDps3KLkYo1tw7lPRK9jLEY4xe1vhrK9y66RRpup5nybr
 m+7RZjS/5GHUmPu7oknCCWXJLXoi0SuO+h8R3CZ38GUpaHNRBCXuX7N+0cVKC9PbJmX6
 CfCmtZ83ls5L4gq0/WMUfNRztWf04YnrteV9oNnTlepJZ7+Wukd6FPbMnwWxVIZU1j+7
 xb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715507994; x=1716112794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y/uBphHmmPv9z/as7JOnNYaoi1OreX05Ww8SM9wCY5Y=;
 b=R20GgC44wG6sHFbzhiA1Gbqytzlj6+Zu7m/VH9DWExTVc5V3NAi5tPQaiv28S9yXlq
 C9Tqvs52hIsH4Bj5Ejl7zkavRgVHhAY2WDAH2RNVJdXj8Vzv42W9qQnAfN+sji7Z+tfS
 45jmWatDVpnBQTdjtKGl4ck1r9bP8gJv1VX8YETVye8P2oZdp8iXBpqtMBuB/nz9/JVg
 RP9qTrStVmqSveesyDD5b0ZgBORLzU4Qw2ZEElxUTe31CCEpWHj16swlebxwybLoRONA
 87tNnU+jbteGSPB4IWcYormdaGvMp5fb8rSdpKC/qZUYgj1pijWW1vJzbDUPgFEv0hw/
 MoXw==
X-Gm-Message-State: AOJu0YzAAAJNaMZH/R1bFu8Fwe3exfAia2EhPklMhQVQ4RXbsCcAIkJa
 Kg5IkzjloMH63fXXDZH0A92UzVOh5LFSoqJLMpqp1QW39JMtHLVkeBByvg==
X-Google-Smtp-Source: AGHT+IESiivUqtrQZKxwA4NJCNj8T1iqwjkKTvP5P1dxxlZMVSjfQndiveeqqSSetk6IUJNCxy6bOg==
X-Received: by 2002:a05:600c:4487:b0:41b:60ae:7827 with SMTP id
 5b1f17b1804b1-41feaa443d4mr71865915e9.24.1715507993913; 
 Sun, 12 May 2024 02:59:53 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-209-238.77.191.pool.telefonica.de.
 [77.191.209.238]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee934csm122175715e9.38.2024.05.12.02.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 02:59:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] ui/sdl2: Allow host to power down screen
Date: Sun, 12 May 2024 11:59:45 +0200
Message-ID: <20240512095945.1879-1-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

By default, SDL disables the screen saver which prevents the host from powering
down the screen even if the screen is locked. This results in draining the
battery needlessly when the host isn't connected to a wall charger. Fix that by
enabling the screen saver.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4971963f00..0a0eb5a42d 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -874,6 +874,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
     SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
+    SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
 
-- 
2.45.0


