Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568DBC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp90J-0004hc-2a; Tue, 26 Mar 2024 11:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp90H-0004aT-9A
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp90E-0001Kn-V4
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ed6078884so3745541f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467977; x=1712072777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKAyA2esITL8SITZAGwcUVQdYshhyjFMl3HKToYcoDk=;
 b=i4zmYjjG1xzs3zNKPUYNQtTU1BmRmnUMbSv+JeR0bH3YUiy8jKIl8tnzxHHcNQpM/i
 PNj55eiQpmjt69RIxk27TbIZKSH+tC5YfBB8MJotm0/heCuytKJB72S31gaRyfj51NpY
 h5Zpxo40GhCZfC7GJvrTQ4svDi26YeSzwBKjT5glJgfDCGsP7efU/UzmdrufJtH7CrH6
 cgec837rsHSIKPmJ5VJYEvThfJ59Ya+6o6mjS0OqYwbw9guvy+KyuxHEgigxoqA5rdl0
 AnP6sc6ObVRM5cXRFOAoFx1JZUlpCckgIic0ytMFedEen1O9Fh7Il32RzC6zfIwCuqs0
 UXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467977; x=1712072777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKAyA2esITL8SITZAGwcUVQdYshhyjFMl3HKToYcoDk=;
 b=nitbiOv1yT/5pif/3Y2vHcp1Arm6Ow0fM01FOrfNKI0qx+kjAeRiEC0vbhdrKtdVyx
 8aI+OdnenPjHyuHnBntVWiTeCeo3DkGp/e3VUgOGJPmyvTixbOCIYSrCmcSfFbgvIFiF
 ONQ0RW+lpuPJDqCrF5CjqoMap7RxHK5x+2FCe5CTLUgEX7bwIi+RaRu6cHeiXdjv9KAK
 y+wQNVxZqJCUAYTTWlvRmOdTId0XOhYDk/pMW1e81KZ2OfUDxXfd2qXYqHqCg+23SVPm
 RKH+nAuhNLLw1OffZR7s4I5Y/IB2tgE8mgh1O6Mi/1r+oUw9yOTw6RmvKZB3sNSVhQTa
 5K2A==
X-Gm-Message-State: AOJu0YyS++cf/drzHQiUNy6Rpg1QCkdpNFW9fWv6xAyrbUjVw+YbeRim
 /ycftD8S8SDZ6pHRquHe1EcHWwvV97AWB5E+DCJ/zUjlGudmIpQiaogENpSbO5bPb1Zhu3rFaZJ
 q
X-Google-Smtp-Source: AGHT+IGuG161w7COZ4emrF+kCSV8goSGF9Ii0pUevHckrbbaDT9yTceX9WgTQ2BJtqwaWmW8pJH07A==
X-Received: by 2002:a5d:5505:0:b0:341:b5ca:9e9c with SMTP id
 b5-20020a5d5505000000b00341b5ca9e9cmr1642466wrv.25.1711467977141; 
 Tue, 26 Mar 2024 08:46:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 az7-20020adfe187000000b00341ce80ea66sm5309912wrb.82.2024.03.26.08.46.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:46:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/13] ui/cocoa: Resize window after toggling zoom-to-fit
Date: Tue, 26 Mar 2024 16:45:03 +0100
Message-ID: <20240326154505.8300-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Resize the window so that the content will fit without zooming.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240323-fixes-v2-2-18651a2b0394@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 17e125d66d..3efa8ac1a9 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1408,6 +1408,7 @@ - (void)zoomToFit:(id) sender
 
     [[cocoaView window] setStyleMask:styleMask];
     [sender setState:styleMask & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
+    [cocoaView resizeWindow];
 }
 
 - (void)toggleZoomInterpolation:(id) sender
-- 
2.41.0


