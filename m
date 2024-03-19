Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78A4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPqS-00055C-Hl; Mon, 18 Mar 2024 23:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqR-000552-5A
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:08:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPqP-0007X6-MP
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:08:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6f4ad4c57so3379509b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 20:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710817731; x=1711422531;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XowM64zrU2NjONErBWF/HPd63ZVWSh7A17WtT67xQVs=;
 b=UDxzwMh2//+rbj7pLtf4IFc9dsCrQcMGDvwCSkLMsRONl5if9tHgh5WgGkskV/BqmA
 9I4G+1shLVHweAK0ixIMRx8EBaGl9NDH8zKgkgjFWEI15mKOX74dgatR7D4SvQSKuBYo
 PmJHf9pxV1HNa032Clm+N3tiYFrsT/PyJwAJgdxJr/NKZTxowxwrhdYXHL5sVkqEQYKD
 RbEYHx1wp8/V2mwINklgUD6hkCatLLS3Oo5d1hX6sxKe7SBFCyC8a78j6jxr93E7XRsi
 RS2uuTkeI5f+F1d5Te9HQbK4OJX7UPr1qMfIgXg37+CHwc/2CC2MsY82BZqfSqomK7+L
 zEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710817731; x=1711422531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XowM64zrU2NjONErBWF/HPd63ZVWSh7A17WtT67xQVs=;
 b=Pi7rnToZtqT28O/fAHEpum2G5dxiUk13xGq7dXwee8g3ietrq0MLBgSrzBnMf/RXGf
 fGPH459m9vBf6eOGBzYVGTg5B0Em9mX+ygeQvhebihf6iAOn5+zZTO8ujnw3597VxFH3
 2yisOCCtQ0C7j/14c3k6R3bi/NvHpDzuo21gVCOx42CeSvpkq284Gk4urZhbM/1x3hOe
 lCImPeKiUv6M22+WH19n8rjj5BVK6aJGVH9Lj4CGFFTZ0fFFZkT4OMVUAeD2htXgoSyz
 buxz9vaHGQ8/jJ2r853geKToQb2MRr6cawFDmAgpajCJandqTK7dVMfb8/rNlnqctsKF
 BIZA==
X-Gm-Message-State: AOJu0Yx/7ivW8NfgjoANFGdilbw5P6WsKtBFGs4ShwSiLXut8eVjcXRH
 cZvvFT6LRj33Nmqcw3tew+98WX/PgbCnZCLDiaKVAKkwNf/ybhIPyThnb5xgVTNaxMFtmoozfQ6
 I
X-Google-Smtp-Source: AGHT+IGtV933BcJffZU1qTV9Ixf4+VPPA5piGnjMLrRQ3aix02TYS/kwzuEvPGu89EsblQj0Jv0tBw==
X-Received: by 2002:a05:6a20:3c9e:b0:1a3:4e19:1831 with SMTP id
 b30-20020a056a203c9e00b001a34e191831mr1679132pzj.13.1710817731154; 
 Mon, 18 Mar 2024 20:08:51 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 a6-20020a170902ecc600b001dffe8a22aesm5475837plh.262.2024.03.18.20.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 20:08:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 19 Mar 2024 12:08:39 +0900
Subject: [PATCH v2 1/4] ui/vc: Do not inherit the size of active console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240319-console-v2-1-3fd6feef321a@daynix.com>
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
In-Reply-To: <20240319-console-v2-0-3fd6feef321a@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

A chardev-vc used to inherit the size of a graphic console when its
size not explicitly specified, but it often did not make sense. If a
chardev-vc is instantiated during the startup, the active graphic
console has no content at the time, so it will have the size of graphic
console placeholder, which contains no useful information. It's better
to have the standard size of text console instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 9c13cc2981b0..f22c8e23c2ed 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -990,8 +990,8 @@ static void vc_chr_open(Chardev *chr,
     trace_console_txt_new(width, height);
     if (width == 0 || height == 0) {
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
-        width = qemu_console_get_width(NULL, 80 * FONT_WIDTH);
-        height = qemu_console_get_height(NULL, 24 * FONT_HEIGHT);
+        width = 80 * FONT_WIDTH;
+        height = 24 * FONT_HEIGHT;
     } else {
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
     }

-- 
2.44.0


