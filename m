Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE9AE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu2X-00071G-Q7; Sun, 15 Dec 2024 14:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0A-0004L4-I8
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:02 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu08-0001Yl-MC
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:02 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f321876499so1615116eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289799; x=1734894599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hiXz53ezNkAih0cAwWg6vh6hXFljD6ps3qWyRrDs8M=;
 b=WHanRsaWWZBHD0i/knf7tN1rOfFDq5EAOdc+6jQm5WkvzQvGlIA147gQHefV4LuIGo
 DpCX03+iLXNeR4fqWvW9Imv1JGYoi/KWYgknWRIgF0LQg8Z4LfoSQtcx4FLVJrim+mLP
 mm9IHXJH5aTH+Q1YxdPgwcApgKgHz0EC0Q5eFaWpGjOeLx9eUL+K8daCvv6abVyJ4tSD
 xHS6Tk4w6eGjFdxxz5h8LRbmX2w0UiOtupmFqvXe4F2KoHHL/rFru8ffRh8fk/yydH8D
 LqB+9wjb0v+ZLMleeGZ9XW8/gnWEJ14qaFr1D46nRKtrfgo9v2BfAmD8/GjEsAq0YeeH
 TM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289799; x=1734894599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hiXz53ezNkAih0cAwWg6vh6hXFljD6ps3qWyRrDs8M=;
 b=dmTJPOiWfreHxW3ZM3Fsmn4hgjDoXBTGIXj3hnaG7Pozy4oj/lozhnNynXL7VP1mUN
 E3llNQw9VlCN6hHMYo9+Nxcrvh1XXP7DuPE+cYFaCm+I/gmYhgV1SuMsga/G0QQ8xtwO
 9iY1xqxkAoypiudJUQZHFuxORS2SIpRKz5ivozLeOxlDI43F/H7OYGjGgjE1DJDrYxAc
 vFuFsD18crEKxBhrLdapCibOX0IR/3lY9EFpMI630ob7/Fi1DpeeFlRiBfsX1XKjFZqJ
 OOjBdQhhqI9rxMLQvca7t6ekMHJ7inrEb/4lWOw3qYeKfpevLzFzTQuYWvf9dXXpCWf6
 Diag==
X-Gm-Message-State: AOJu0Yyhwa730emX8M/fZInswM0jKbloHYdS3J6gWoWavyfyZeMHKOeg
 8ibbwBNMylVkq4Rp39AR5qi4SXzOL64R6gIZSUz5ZNcHjSVk6ko0F7+qRNvsnStf+QR8zUeLWlW
 8RJC/zKzw
X-Gm-Gg: ASbGncv8f+sQm7nZdlcf0emtCAkl/JHVEvbKOaMHBEhc0bZGsyrDz3hTONqFmYBfCDS
 qmk0ndN7AxDOiE4xBAjGlTOXghNicLK3P/DoTKpqtg6ekw1gBvhVgOEl6SogyRsVEs3JHwQVud0
 W22bK3Ww4Wx7vK+fO+MhZ+Gf5NKeCPTpu/N1udZpipcuDJvX9tVmsNYbvdqHynoFuk9oB5Wlk0o
 9tHNoQUIaiiOZjDT1SxXXNhn/lqvsgMiSouWH0RWAB7Nl3NyN2Iv/uymlDnMIE5cI6F0RMnCIWh
 HDXy3lDO+CIjxGAdg5riGfAfVk8IC7PcRPqEeiUuMyk=
X-Google-Smtp-Source: AGHT+IEwFTQ2+E5nAoq7rA15jusrEB4J2k++v/CKnmDV+Jx161KHvfWo0Ktt/eKckBD5H6lTnah9OQ==
X-Received: by 2002:a05:6820:b47:b0:5f2:b1cb:3efe with SMTP id
 006d021491bc7-5f3243464b9mr6052769eaf.4.1734289799621; 
 Sun, 15 Dec 2024 11:09:59 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 64/67] hw/watchdog: Constify all Property
Date: Sun, 15 Dec 2024 13:05:30 -0600
Message-ID: <20241215190533.3222854-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c  | 2 +-
 hw/watchdog/wdt_aspeed.c | 2 +-
 hw/watchdog/wdt_imx2.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 80f9b36e79..2e25d4b4e9 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -262,7 +262,7 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
                 dev);
 }
 
-static Property wdt_sbsa_gwdt_props[] = {
+static const Property wdt_sbsa_gwdt_props[] = {
     /*
      * Timer frequency in Hz. This must match the frequency used by
      * the CPU's generic timer. Default 62.5Hz matches QEMU's legacy
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 39c3f362a8..c95877e5c7 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -288,7 +288,7 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property aspeed_wdt_properties[] = {
+static const Property aspeed_wdt_properties[] = {
     DEFINE_PROP_LINK("scu", AspeedWDTState, scu, TYPE_ASPEED_SCU,
                      AspeedSCUState *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 8162d58afa..61fbd91ee4 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -281,7 +281,7 @@ static void imx2_wdt_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property imx2_wdt_properties[] = {
+static const Property imx2_wdt_properties[] = {
     DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
                      false),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


