Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B079EC54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrO5-0002Bt-AI; Sat, 24 Feb 2024 07:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrO3-0002BT-1q
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:15 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrO1-0006x0-MU
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:14 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d944e8f367so12560125ad.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778652; x=1709383452;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XUF9MB/GVHxuW0Msr+KnJ49oqKxKjgQPdnE3teHps84=;
 b=VPzkYaF5kwD+HNMcUSNirXthahSgeeq30cw/URwT4N+DJoMLucu+p48nxcH2C5GBmZ
 9esAvodsoFcDJeB2DtlVQnOQut67EjRPbC4o3/QhX5iWt3WzBwt655sQz4baJilXT3F4
 0tnchL+w95QoTlnfWfyvvkFMjkI+IfyUlioU51Ulj6rR0V0na3FrtXLRyijg92oYeA5F
 H8x3slciW4M8AbpioTNXJJV8blVduHI8Yv5Q/y59AtnU8YcsS7MkJLtfJvFevw3WV93z
 zU6rb8JRkah0XKerbM56uNcjL91iHrsUwViXnKUKn9hgtM6cThu8zeds+sUPC8yu+pky
 Pf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778652; x=1709383452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUF9MB/GVHxuW0Msr+KnJ49oqKxKjgQPdnE3teHps84=;
 b=DdfXULs3bCw2mM5/0MviIMhBq1v7W3L4hr5FTtdmoGDIyZUMFDlwz/ugYgL9VA0INA
 zm9eBASVd73ngOOYrEn4CMP7t4xOhyfRR36d0RDr68y1KxlORHigDfFJ+WgXhKpIdED2
 FXmNwcNkBIntLKm3Zv0vW6nBMEjQpBm38R8yZ9fRzbGuSGsnFLVSvgCobObVvNPd3UqB
 kFB/tTWiJ3zO1E50Hekxl0v8bVv25t/0XELdGT/9/Cy1i/sxyDhERQfMv7i3w4GX61gm
 GIUJthQd/MJSb+NZS0qQu1xIkaKiRwPxUbWkTFEttLhWmOln+Nk9L9fcQwYL0Pp9ROvB
 Clhw==
X-Gm-Message-State: AOJu0YzhyZoUnsZEd88OfR1efxH2Pp01t0HM6BkRjUmZGYqIxwogVJdd
 WOqRnRUulC4crDzXvN/i2bE+WL8fjKhBktdkexZ4vVEzuCXJFHaAR9inb5O1HvA=
X-Google-Smtp-Source: AGHT+IF6yzYv+1j2Qxz3JW308dryYtd20ZDnnZjARd9eWkk8ZK/47FUllbvekFT4B+n5XgbzJP75IQ==
X-Received: by 2002:a17:902:dac1:b0:1dc:5edc:61d2 with SMTP id
 q1-20020a170902dac100b001dc5edc61d2mr3453558plx.59.1708778652229; 
 Sat, 24 Feb 2024 04:44:12 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 bj12-20020a170902850c00b001d9c1d8a401sm948119plb.191.2024.02.24.04.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:44:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:40 +0900
Subject: [PATCH v12 09/10] ui/cocoa: Call console_select() with the BQL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-9-e89f70bdda71@daynix.com>
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

[-QemuCocoaView displayConsole:] can be called anytime so explicitly
take the BQL before it calls console_select().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index cebfae04d9e8..33d31b82bcab 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1360,7 +1360,9 @@ - (void)zoomToFit:(id) sender
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
2.43.2


