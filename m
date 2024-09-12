Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7995EEE6451
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhx-0000Os-HN; Thu, 12 Sep 2024 02:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhw-0000Cy-1L
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodht-0003VJ-S9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo518935f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124012; x=1726728812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DoSSTd0j6/NNSb1Pb5Q11FBgrZrs0Txd/Ud1jRinqIs=;
 b=eR8C5yd9t7UnYUYFHfjrJ8HwhqkeZmgJ2EmhX1KKO+KRzNqdqHHXYblrKXZohR6W2x
 Ne8pGo83IhLWlNJBNa2gd76Q1iAq5+w8cRAdvZu4t3zDoTHCmA9afoO8jmsJAU++Q/2O
 BUdluaBeQ96RAkGoJDN6gl83NASqmJGqqZ8iq0QmWyOCzFDEuykWziHFFHi6iGUVmwqT
 2KloM/M8GXJuINFYraLa6Xg0Bsp4YW8pltF+8rNP0+yPOoA7jLEHjnlnVr+CB4sFNpXb
 QUMYtvbg1gBTuJTUZcREXMi6c/KCdBigEoDcWHd0YWVrVPP1jWb5isQZfL7ZU4NwhKAN
 7o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124012; x=1726728812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoSSTd0j6/NNSb1Pb5Q11FBgrZrs0Txd/Ud1jRinqIs=;
 b=a9CmDmuH6GgfHOY+/noe9sq1kmkVx26ONZQMDQMRq6iPKkPFelkWRMI4304MLfESEM
 6EyTR3cScFdTn5TEQbvAzngEqHJhylsfK6Q/iEtrdO2OKRSul0leEgGe0os2N4Tf7zyV
 CVfP/OL91kqUThwpMOZjeNd65qxm7E5hC2xw4zfzFK0sEtJpo7OWVnlb5vmGRy3aOFmv
 edu8ghasEnGHiHcWr/VTJ3dA9smVcK07BKudl3E/I5ZRcMUAP7YbhbJcoCLVmOngIpmO
 rGcfMBqFXQG5qAiLaQ7EeZrps/Koe5dnEYZi6Ep7FKCaLZN1t65AvIiGQoSnU0TnYhoB
 XRAg==
X-Gm-Message-State: AOJu0Yx/hPk3Wv0f8e8l3teSSgvL98faJJlMjHCkEHM1kcixVToavwVY
 W6kdWJ6KghJvA6Wwo91no6Nud9Uzdjd5wq6thl2XfoCKXZj13SNk8hmWIIx5/VwCp5CWS4PIGi8
 c
X-Google-Smtp-Source: AGHT+IEWvJ+tMYDAKBnqTnZ1YsTh4uaNaVDB9qpbnIblB020NjwZZANuM08Urx3+vB701c2mnHQc0A==
X-Received: by 2002:a05:6000:2a8:b0:368:37ac:3f95 with SMTP id
 ffacd0b85a97d-378c2d032ebmr1378015f8f.31.1726124011715; 
 Wed, 11 Sep 2024 23:53:31 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb44473sm162061135e9.26.2024.09.11.23.53.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 56/61] hw/pci-host: remove break after g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:25 +0200
Message-ID: <20240912065227.67848-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            g_assert_not_reached();
            break;
          | ^^^^^

Solve that by removing the unreachable 'break' statement, unifying
the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 33607dfbec..5855741662 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -689,7 +689,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_PCI0_CFGDATA:
         /* Mapped via in gt64120_pci_mapping() */
         g_assert_not_reached();
-        break;
 
     /* Interrupts */
     case GT_INTRCAUSE:
@@ -933,7 +932,6 @@ static uint64_t gt64120_readl(void *opaque,
     case GT_PCI0_CFGDATA:
         /* Mapped via in gt64120_pci_mapping() */
         g_assert_not_reached();
-        break;
 
     case GT_PCI0_CMD:
     case GT_PCI0_TOR:
-- 
2.45.2


