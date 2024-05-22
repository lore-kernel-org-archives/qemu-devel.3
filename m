Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EDCC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jRF-0003ID-C9; Wed, 22 May 2024 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRD-0003Hi-IE
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRB-0001fk-V2
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f304533064so5361295ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374592; x=1716979392;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwpNU0IOG2gR/Zc+cT2zm9xVHtaU1yJX2qDLOGZQyH4=;
 b=WgZyBhfz/DoemXZCh1bHl6/ywXEeZsMJRHdF4k20Tv2Jk8HldJJ52yu+YmG7DDv5rF
 6YARuGmfrOTHT7h6dXt8YyG9IX9fonp7+W96gJ3g5sldcL9SOnDnJ0r/4IdGFgDg9VQy
 RnzFblfYw49CxMHGLa8w3fCyqRGLpr6FB8/qabkryqEe3rmMWDC5KbbkKa0CA/w3xXSa
 l4xtK9sxTEp3ZHsmn69hSHRloSTTkJjPPclNmCPvc9uJyvLt+WSJrYhzEU5ySs8kDvhp
 LM/qQl+ilGj4ezJMPBHfh8y0M6yYyKhUaJv9AqpqRjTymfghnSOqAJC3ZsCZSZvg6dBW
 LT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374592; x=1716979392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwpNU0IOG2gR/Zc+cT2zm9xVHtaU1yJX2qDLOGZQyH4=;
 b=GPEGuu0OHKMzmUSfwgku4nMio2DAcc+3qqVTO5Oh5BrAwXc2/JFXg+i+De3HLl2yGx
 ytbYpqKD2JHebpDkQUSVon3/MWbVBEhC74LItdtsQZkjEVHKzqJN0x3MI88dI3OGYZWH
 HqHtv1w71c4EtIGMl3ROc9pCoXLbauSUMGSuczXoxIHcazLcgf0kSo+5nhXzMR7si+ML
 /gHMA16G3DgVWPrRBqjSE5OYHPcuKEonvcU5uq5J9JgVgvBZ2hw5GV6iHq6SxBfoE0BV
 fWZduloj7yu98WmjpDSGBQLMJviM00dLKROAhGS/BUqweYD5q/xL1kVfbq7NPlJiqehF
 ncsg==
X-Gm-Message-State: AOJu0YwX6kUbcXE5PTfj6FmbAi5xYUqbzzE2defrEEczVwKAPDNnHIJY
 d8sMYpPa9GiqM2U8u8TnrC2ptV2rRQoFKtU36cfDXK6urBGz9ymDiSTlddzBFC8=
X-Google-Smtp-Source: AGHT+IEsqkWo7HnC/L30/fddVqzLgSu+dGeNbKSy6TrvEAgPtcGanF99HwgQD5KZXN/mAT1tMSQRcA==
X-Received: by 2002:a17:902:cec8:b0:1ec:8206:626f with SMTP id
 d9443c01a7336-1f31aceb165mr25082255ad.9.1716374592134; 
 Wed, 22 May 2024 03:43:12 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f3033d8e1csm48952925ad.56.2024.05.22.03.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:43:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 22 May 2024 19:43:02 +0900
Subject: [PATCH v2 1/3] qemu-keymap: Free xkb allocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-xkb-v2-1-67b54fa7c98f@daynix.com>
References: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
In-Reply-To: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes LeakSanitizer complaints with xkbcommon 1.6.0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-keymap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 8c80f7a4ed65..7a9f38cf9863 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -237,6 +237,9 @@ int main(int argc, char *argv[])
     xkb_state_unref(state);
     state = NULL;
 
+    xkb_keymap_unref(map);
+    xkb_context_unref(ctx);
+
     /* add quirks */
     fprintf(outfile,
             "\n"

-- 
2.45.1


