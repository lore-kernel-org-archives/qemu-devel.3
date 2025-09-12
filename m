Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A6CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 23:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxCjZ-0006DW-HB; Fri, 12 Sep 2025 18:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uxCjV-0006DD-KZ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 18:59:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uxCjQ-0000UG-J3
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 18:59:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3e7622483beso1307722f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757717942; x=1758322742; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KmUOo69WzwC072Jvm++5Youc4HUmFm4m8fLKP/tsHbM=;
 b=kFNgjMJmcP/ZQ9K687sjGLxI0OOVPm3cRyX37c8nBSg0NC+D+yq9VlNAEyQLYurp5L
 v5Df0IUBH8fo5tIMK4c64ppa8TaEx453/KUtdQdiyoAHnf0/F2bMok+3c0/Bst5Zbb5L
 HyGBDTspkeAtiCKFF3d3lip0to3q/LhTQyQZL9SJnDngtMaqWrijjHL7rO33wPPNRZpL
 mLciFHiqFq5GsYZhhLOBWHFn7uGV8lLsYE93Bo+0sQLM0rILSjYvdiEMcJgdf6Q0YAAK
 2iYIuG2ubr/WSpB78KYW6VVYgaXaDDlzSx18KjI0KY/IhrlG3YCI+AEZwplibjgKA8El
 UDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757717942; x=1758322742;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KmUOo69WzwC072Jvm++5Youc4HUmFm4m8fLKP/tsHbM=;
 b=kQqVgRqkmKvwg8J7/vyyoxzK73K706jRqeComKxnLObKxytNophMYPydemx78ChzfH
 h3fQfX66KU7PnhGuGyEMjgBsDOvfWckJfcTio9K/ljhsqUNuvSaW/+jRXYNZdg8uZkgs
 CRUn4CJBxyRUXmMRgyaZA9QwNimG7UdsYWEC5IEcZLpriof1v+1jG41gBauc5xvBe8Vd
 kKvulTqjsA4H7gEMt4BAhgCK+LjY7ipUlHiaDG9GNCu16AMMkpBHCIYLDA458WJfFpZT
 /a9I9Hk7NnpR+GkOdqgoVF633pAd6c3kkFMHrxC9tF/SBouaeMtbcwUNGTBFxkSoxWk1
 nS5w==
X-Gm-Message-State: AOJu0YykliyGSaCu3F8/rgRdbZOuCXHnjtugzGN3BB5xO6KxjTSKVfSO
 /ky/b6GQy7ZL9VX2jMLYKme234PdkzxbLx2sb6a3eekh+LhUv0ooFuRM
X-Gm-Gg: ASbGncvgUKjv+qThpp/a789iiLDg9+IOQfHayW3xqvzRBCI7MEiJwF9k7OCoPuIpoIl
 dtF0APe4qy5BzKeKO2VMTrok6F2rPoIIMYERaNK62TZdgCEBQrIJrV+5sPKJguwIv0XOuNl9M7z
 rNiS9LmfHPhYU3VbUFzO/YGAyeIOfqydFieDhrucRF5kUj6wESlOIbmjc6xgVSOnkdR1in6Rh1U
 0Sq5/VSFEaEb94xbNKWvwxSqDupXPjcBfuUjbh03DQLFsTrUuWLwZwHbzMQQOq3iBJfBDfHZMIv
 7ncpPW/I+KkQy3zSCSDFd4ZeQ8H/W65xSowAmzdpd2WrToB2wmvgRLVD6EmkxCQmg2/fFu6qaVF
 ZpSfAxinwoUi6AiNQB+gVIsTmlbwzv2FTLivDqDWjn7AlY/mJS9cB
X-Google-Smtp-Source: AGHT+IEpOQhjHA0tH9/BXvvkpiR8QVg+WODIMHq0ix15PUjSE3OAMaro9D6CSkjKWUizs46LgGyN+g==
X-Received: by 2002:a5d:5850:0:b0:3a3:67bb:8f3f with SMTP id
 ffacd0b85a97d-3e765a1b215mr4369688f8f.53.1757717942234; 
 Fri, 12 Sep 2025 15:59:02 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e760775b13sm8300696f8f.10.2025.09.12.15.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:59:01 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sat, 13 Sep 2025 00:58:35 +0200
Subject: [PATCH trivial] ui/gtk: Fix callback function signature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-fix-signature-v1-1-974d16871432@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJqlxGgC/x2MSwqAMAwFryJZW+hHQb2KuKg21oBUSVUE8e4Gl
 8ObNw9kZMIMXfEA40WZtiRgygKmxaeIioIwWG1r3RqnZrpVppj8cTKqxplQabSjbCCfnVGEv9f
 DwXSRX2F43w/dNrgCaAAAAA==
X-Change-ID: 20250913-fix-signature-831d40e2b091
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-trivial@nongnu.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757717940; l=1252;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=arIkyYNvci6r1zmxzaeWUAvH2l07YUKB2o3HLSS+2LI=;
 b=23PJvUQ1PkY3u3WnnSDCDO/jnR3zPtzOImr/ph8Ig3l3gruQOf1y68BBjWfNEid9FbOELjK3B
 BqHT50SHq4WDsJ2d4ap9nPajdL6Ns34TPcMxAPvYjtSJTX4fBxMjJA4
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The correct type for opaque pointer is gpointer,
not gpointer * (which is a pointer to a pointer).

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
This fixes a small mistake in callback function signature. The mistake
didn't cause any actual problems, so this patch is just code cleanup.
---
 ui/gtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index e91d093a49e5d05c10f1dbea5b9b94ff1389b456..f1d44402d8cd69045e0d2478b5f7a58b65d3a56c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -766,9 +766,9 @@ static gboolean gd_render_event(GtkGLArea *area, GdkGLContext *context,
 }
 
 static void gd_resize_event(GtkGLArea *area,
-                            gint width, gint height, gpointer *opaque)
+                            gint width, gint height, gpointer opaque)
 {
-    VirtualConsole *vc = (void *)opaque;
+    VirtualConsole *vc = opaque;
     double pw = width, ph = height;
     double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
     GdkWindow *window = gtk_widget_get_window(GTK_WIDGET(area));

---
base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
change-id: 20250913-fix-signature-831d40e2b091

Best regards,
-- 
Filip Hejsek <filip.hejsek@gmail.com>


