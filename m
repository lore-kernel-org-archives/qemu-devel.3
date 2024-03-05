Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4A6C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdh-0000Wb-TU; Tue, 05 Mar 2024 06:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdg-0000Rd-46
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:16 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSde-0002uB-AI
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:15 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d28387db09so65579051fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636831; x=1710241631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3wQ/LWJs/H+DafgGjzo37DBcyLizBxzZHb4EPua6Sw=;
 b=W2N9GqTmi8rGCgSqf2G+ARoitzqYMt80TQWc2z4+71hWMXPZv+DXCQgua+oSQyr+73
 8oGa7Emb+MEwRsLRAKpsruGczGDlknV+2TUNf9hbXm9LG2zBZ4xs/UkzbsSknLvbrM8M
 /vjB0v4tjfxzALnDu8TidEOgxcPVMi5Tz62jLPObX49zp49LjFLHCmDEy4iP8GJqtUR7
 7SqLZ/BVMglkBLy4p1Uz9wkhzptOIUkDgLx9DyCOuAcSI6EqECS9b2bau5repujxNbAc
 DHRMiR5UYuhpPcMTKY7oE54F4S2Bcl8rNGQTTTYcl6PusgM7VSG50kgt8uhT38Bd9Dmk
 140g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636831; x=1710241631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3wQ/LWJs/H+DafgGjzo37DBcyLizBxzZHb4EPua6Sw=;
 b=SW8zp3+a8cVkhXnDdOW7CaOcgyvMzyk1Sw1eJxlcjw1jAC2Jn/O0cOLSZ6cccvCWOs
 IErKrSqQvzbhpk4v8BpzWJkSE/dOaTtxsU7IvjScpva8W+3qX9yB1ne0qbYUpfLGYYBe
 dSKYXJxA5r62emeyoREYmyTdXq9QqCR8jjdezAJcMkWqvyJ28Fu44c+4oNrV5BdBV9zj
 vSSRu4yO1vSKxxDn11g2f711uhuHufCUiIoVjXUVDt8UL6JvMIFK3UqNOinONnmLbQYq
 Ni6+ksIBhroUM9AI4iRCbRt3cIV180CmWK+W1irnH4p+mLle9eeYT/V3AcWt18DrmWsT
 JjMw==
X-Gm-Message-State: AOJu0YxdsosV9RKcBTjym2EkqCaPhvuvtFACWHuCf9yAhQNHjCWq31ra
 YcFqHcSg5SvJyZDILNesF5e4Yoalsh3+SOV9N6bwp+O8FDsybDRIvD3jfGmeM4IYg9mFBHznbGY
 p
X-Google-Smtp-Source: AGHT+IF/Od8YsPMigSl/3Jv6onNSpx5hL5sYrZ1/bkI+4kj631kUY+kpFsgw45LHxVaXbjHAdWkcmw==
X-Received: by 2002:a05:6512:34d3:b0:513:46be:2465 with SMTP id
 w19-20020a05651234d300b0051346be2465mr944433lfr.55.1709636831178; 
 Tue, 05 Mar 2024 03:07:11 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 jw11-20020a170906e94b00b00a455d78be5bsm1945750ejb.9.2024.03.05.03.07.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:07:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 10/12] ui/cocoa: Make window resizable
Date: Tue,  5 Mar 2024 12:06:05 +0100
Message-ID: <20240305110608.21618-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

The window will be resizable when zoom-to-fit is on.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-8-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index a891e76345..6c9efa0c20 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1356,8 +1356,10 @@ - (void)zoomToFit:(id) sender
 {
     stretch_video = !stretch_video;
     if (stretch_video == true) {
+        [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
         [sender setState: NSControlStateValueOn];
     } else {
+        [cocoaView window].styleMask &= ~NSWindowStyleMaskResizable;
         [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
@@ -2024,6 +2026,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
         stretch_video = true;
+        [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
     }
 
     if (opts->u.cocoa.has_zoom_interpolation && opts->u.cocoa.zoom_interpolation) {
-- 
2.41.0


