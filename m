Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A82C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7o6-0002x3-Nx; Mon, 18 Mar 2024 03:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o5-0002vo-6x
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:17 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o3-0008WN-PO
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:16 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c38855957cso601455b6e.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748394; x=1711353194;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gjy0iQjWgIZLIa9AZQWBmLKx4VYA0d/vzgnq4H2fgLY=;
 b=FtETl3gzt1O4YqE4UdqsfNF4cQZdKMAq2x80KaNWaPrAzcajOadsjgNFQ0KZ7g51yo
 j7G89I79pUvs2XfvJHqgeoGEgCO8XtE3yBKYz4ftri0FcGiHJ7FPGpB/Q9l+ul4rHig/
 DXE8VH2ToK2z6L9ayaOWOFIENZjAcLbn8ehFpa6UHEVWNS2mbJ9gafnIDDxvK4MXnVky
 dVOLmzqUN46sofhmrkWNs2I2XZchWN0z1XoTPLcZZjss3jJoGj/R8HrXLKgSdeZuWGtz
 ++fVpQC3cAmfaq65igccdC1T+5lP16+rp7F+022V2hFTPNfokxuZllwmkX3bWPn2VEx8
 hSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748394; x=1711353194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gjy0iQjWgIZLIa9AZQWBmLKx4VYA0d/vzgnq4H2fgLY=;
 b=GwhCpDaVNjdM5OX0hGpzojyglC4g5jDrI0juW2E0E3tfBhLTPEc2R51QDRNQzj90bp
 ftch+abqjQW3/12V9Zye5epaLpsohF9OMgdLdIFgJ6Epe4I47A5tZa0V+ahNaQbQyhJl
 8xSxLDUBDUraCrQRFgpKgxUSkJLaUxV+zrRHH+5wq7s2SYwLF8DlxTOM5J+LnENFoJrz
 /sMmpgQaE8DkeXF9elgTL/mOjBEFUwTWKPSxZvdPwp2inHSanOA6BKJr0isn5tqKvtrl
 5QX7RGlugfQ3aHij/QI6nYE5rEnVKHWwLyxMGpzzcJYN1ZTDZDV8n6xBAULH8xJX7lPW
 secg==
X-Gm-Message-State: AOJu0YxTNvgzvi8XY37V8VBuLm2L7Q5Q0cOo2yFJavflnTRhs06JcJgz
 OBUXvmGMsoJgOgDof221mpBrTdhAe0JIC56GklA8gwcMQDvW6vfg+FnDF6LnnyE=
X-Google-Smtp-Source: AGHT+IFk1eXoi865iE+hGOtbhZmI95vKmzluYra71ibzf54zR27uj+i3bnE6sMJs7NhXd9GH5Izz3g==
X-Received: by 2002:a05:6808:394a:b0:3c3:76d4:b687 with SMTP id
 en10-20020a056808394a00b003c376d4b687mr9730335oib.22.1710748394647; 
 Mon, 18 Mar 2024 00:53:14 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 i2-20020a632202000000b005e2b0671987sm6542630pgi.51.2024.03.18.00.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:53:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:53:01 +0900
Subject: [PATCH 2/3] ui/cocoa: Resize window after toggling zoom-to-fit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-fixes-v1-2-34f1a849b0d9@daynix.com>
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
In-Reply-To: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
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

Resize the window so that the content will fit without zooming.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index d6a5b462f78b..1324be6d32fe 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1378,6 +1378,7 @@ - (void)zoomToFit:(id) sender
 
     [[cocoaView window] setStyleMask:styleMask];
     [sender setState:styleMask & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
+    [cocoaView resizeWindow];
 }
 
 - (void)toggleZoomInterpolation:(id) sender

-- 
2.44.0


