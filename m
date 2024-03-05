Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C9C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSds-00011e-36; Tue, 05 Mar 2024 06:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdn-0000pP-7u
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:25 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdj-0002wF-87
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:21 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a450615d1c4so421587066b.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636837; x=1710241637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVNp2XET9C+VfD19+bqo8MRrdyqsLDGvDOE4eeDfw2k=;
 b=pQRGNolctMA3JQfpKZV5EWKQg9zG/6TemFeaDDQlzyhGfLnHynn4ROPTGKNJ2l4f73
 eZob/18pTGxpPhhgM9X6dUga9RCAfjrL/gXGiiIFwbRjrcQF72P+YJGD3zoCFA4/9Qsh
 2G2ZJeE1JDEonc45fy9FkQHUNB31oOJzWEuK1KPamosznrolaqM7ZAncVkVG15kjyc5D
 BqaJrbnKVxhJpMS9ZsGaJCvijoEeUsz/QI/RAx6REx1cIThkdahNUIMHHA7mUpOMMHyd
 GdXjAoTeyNhOiAiSKmpm1rwiiOqYj3hkH3EL63ITx2/8sATNTuHD5PKBuF63CzuaF5Sf
 KfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636837; x=1710241637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVNp2XET9C+VfD19+bqo8MRrdyqsLDGvDOE4eeDfw2k=;
 b=SDVhZcXhNbA2BffuBgS705JlHnCQU3XHmjSZTx15cAhe+pmRC62EpffEhXtybylIJJ
 Beg8XQqCtamaHTTxE7Zkvo7QXqDGcB881s/DM4KRojaxtjGxoCU9llVBi+ZgMinzgWA+
 nu/3+zYFVq6pl59OI/kDsnDhtCjjlJguSth+NIXL0FUCmuDiiakh9ubR/ubOHuwMwnes
 U+5wg6HvR8pw3yR3M4z8KsleY/WqniDW++XQvLTfhB5sVT8xHpcW1unTMUf7H5zCulgS
 wf2w6gfjNDHiI8dMaVzDYEccrfaXpRL+QVYsYeBYQoWljz7cvYAL2Ign3Anor002lsLu
 1WpA==
X-Gm-Message-State: AOJu0Yx7Gv5QsIFlh39HVZCql7nJnPBTiiFmSpMs5BOS1fl2sHSISMYU
 elGZi6EjxXQYKjEsJ3AL8zrXr8siuD5nJOzoqGl0pvTANHQOtGucgjGsdJI3V5ILF5vbazS/G01
 /
X-Google-Smtp-Source: AGHT+IHZrqTnNb67BsfHmbm+qEumpGaeLWpSSOSyK2Fb5rvMI4/587JxbsJl8U1lJfL7kXtu3MmKFw==
X-Received: by 2002:a17:906:16d6:b0:a44:a1f9:3826 with SMTP id
 t22-20020a17090616d600b00a44a1f93826mr2262346ejd.25.1709636837244; 
 Tue, 05 Mar 2024 03:07:17 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 js20-20020a170906ca9400b00a3e643e61e1sm5889216ejb.214.2024.03.05.03.07.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:07:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/12] ui/cocoa: Call console_select() with the BQL
Date: Tue,  5 Mar 2024 12:06:06 +0100
Message-ID: <20240305110608.21618-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

[-QemuCocoaView displayConsole:] can be called anytime so explicitly
take the BQL before it calls console_select().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-9-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 6c9efa0c20..bc63043158 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1379,7 +1379,9 @@ - (void)toggleZoomInterpolation:(id) sender
 /* Displays the console on the screen */
 - (void)displayConsole:(id)sender
 {
-    console_select([sender tag]);
+    with_bql(^{
+        console_select([sender tag]);
+    });
 }
 
 /* Pause the guest */
-- 
2.41.0


