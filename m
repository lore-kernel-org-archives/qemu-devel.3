Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF12D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxv-0003h4-Ku; Mon, 02 Mar 2026 03:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyx7-0003J9-DX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyx5-0002F8-MJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmxuLXSQjpx8FYdfBKGNckzov1k818273nQJiPB8cgA=;
 b=KXGxohiR3aymXsaT8YvyHXpgOkZW00KOdcLaFHs3YNcD+dbpO+UYQUTavZIDqN35dGJG9H
 eh5D4sW7X6HZzoTjQ/4pUj/Ro3ToPhsRb3TZGujYMFhNlSbYu77Bmtkab8aWuI2/Tlz1Nz
 SLOs+wPGlpqQ8iYz8+7sh+yzAR1mLRE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Dzw9ACeIMhmX_iWRf4Qsrg-1; Mon, 02 Mar 2026 03:48:30 -0500
X-MC-Unique: Dzw9ACeIMhmX_iWRf4Qsrg-1
X-Mimecast-MFC-AGG-ID: Dzw9ACeIMhmX_iWRf4Qsrg_1772441309
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b6c9766aso741884f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441307; x=1773046107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmxuLXSQjpx8FYdfBKGNckzov1k818273nQJiPB8cgA=;
 b=EjBIBZodECUVhJg2pwrvjjIQR35JcilCfsI4GC9DbowXIQid8fwOoJ1NRBPSs2LSMe
 sutungkccWzOnWg7Gg7PSK6wNTnXMm/KPawBWMfraqaIGCNU/d4uSaJI1I5zUW/UfmDv
 Dt/2CbP0wN5Ld6ShszVimtYri6d34txFanpmyNaXvxUDCSOBo5EGEKDag1BVZvWHM7ON
 R+GIoXyR4Hj+TVy6UvXm+p7n72+/f+Iz8CqzSpMk0S7R0b4HNhOCveneLL7PNgpHIQ9s
 vyucnYZ984dWIWlsbGp0MydxpTkE/jbW0msudvoVB6TK0hu3tRm0Tr/MSF9s/rpyW6L9
 x6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441307; x=1773046107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmxuLXSQjpx8FYdfBKGNckzov1k818273nQJiPB8cgA=;
 b=Vi/I4LV8sPVSobOn3+4rD4cH9WyXd4jchUibPWIM4zFNN3pZD0n8sOr1XYNPg+kASI
 13gO8KCINlwCe2Peh9pzISsqsV3ivK0rJZ9/eExkoQ5+DK7eTwa257ZSoNkflhOHWB14
 XYRFGAgwlFWLqNWt0pjV9s9A4D0yLr+4CR/uJR3m4Hx0Fif62NDHz//hk6zTZUSFMS8K
 0eQ70fNwFzQ4VDa0YmrkxwHNqbEaqs0bJ7IfxWpE+0ixTeTiG6R2Lx6ch6qxqKistKSv
 dEsGbUWhnFZeyPVhqd+vUFtrX14iDLTLdq1E+UQ9J80iycw5YUgb3KvYPa5vL0nvLWh5
 r9cA==
X-Gm-Message-State: AOJu0YzNCZm7tAVJn6tSwaYWWc1agA5ULjlggsI+h38QX6gNxjKErxrr
 /5PGRY2qEozLXq/cPFYNdkXVa8YO1EHqPGT7bd0LP1lmLWgT+DeV3+/4LGup4MgmtDBQFht3yGm
 I59hvdjFkbBV8TJVwPz2Q1Strqjk3r5SPFEYaGiD2i7LFS2cWGbqa4VeEm/+migGiupodfyNfsG
 87bXHA1fI9+9SoHBcI44X2aDH2hO9ysyBs3mwZJcwm
X-Gm-Gg: ATEYQzzIxWydeTrCQavHP+92C9GfYqsedvJsWAWJSXfTGspPYMWRXGVFBdnyeYAEWjL
 fwFQopyRiZLFpKu/bRyH5OShxWwhXDoeL8+dIrBc3BVIodroqlwuIu9IbT2UhTADRArsVb5dtnO
 75NB8FUSC2li+BsJKK4m7KOGoT1xE2S7n0wYieQlA/qLQsoJajEhOqsF68JztNiBqfdYPBX8vzT
 RGVEW8KHtyzCWtn+H25yUlrDYpJvT/oPslXDVpQR1sHapmTI3Bo1VL3Z73X/pBzyTgfJougGwWY
 ZnNExdj5jHGeS8d+V31ZhBu957AOD2jOqr3FdN2E43/1XrOQ2oS1suHRykdcX5QmNgcLAVS67iF
 XfP45Ee39/HGd+FAjck9FFCLRJtFk3tAFVJqhdT097iYI3jECU0RieqxBhBOZRMazTbT3q4AWRE
 zFnkkwkTm2yM5ZzWaJxXS8g+cR5Qg=
X-Received: by 2002:a05:6000:2902:b0:439:b265:6c61 with SMTP id
 ffacd0b85a97d-439b2656dd5mr7466967f8f.12.1772441307367; 
 Mon, 02 Mar 2026 00:48:27 -0800 (PST)
X-Received: by 2002:a05:6000:2902:b0:439:b265:6c61 with SMTP id
 ffacd0b85a97d-439b2656dd5mr7466917f8f.12.1772441306755; 
 Mon, 02 Mar 2026 00:48:26 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503425asm7957466f8f.25.2026.03.02.00.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 081/102] ui: drop spice-protocol < 0.14.3 support
Date: Mon,  2 Mar 2026 09:47:27 +0100
Message-ID: <20260302084749.474955-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

According to repology, all our supported distributions have 0.14.3.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260211-cleanups-v1-7-e63c96572389@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build  |  2 +-
 ui/vdagent.c | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index 11f83cf05c4..f67f8668bd8 100644
--- a/meson.build
+++ b/meson.build
@@ -1325,7 +1325,7 @@ endif
 
 spice_protocol = not_found
 if not get_option('spice_protocol').auto() or have_system
-  spice_protocol = dependency('spice-protocol', version: '>=0.14.0',
+  spice_protocol = dependency('spice-protocol', version: '>=0.14.3',
                               required: get_option('spice_protocol'),
                               method: 'pkg-config')
 endif
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 7ff0861f3e9..5a5e4bf6818 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -17,14 +17,6 @@
 
 #include "spice/vd_agent.h"
 
-#define CHECK_SPICE_PROTOCOL_VERSION(major, minor, micro) \
-    (CONFIG_SPICE_PROTOCOL_MAJOR > (major) ||             \
-     (CONFIG_SPICE_PROTOCOL_MAJOR == (major) &&           \
-      CONFIG_SPICE_PROTOCOL_MINOR > (minor)) ||           \
-     (CONFIG_SPICE_PROTOCOL_MAJOR == (major) &&           \
-      CONFIG_SPICE_PROTOCOL_MINOR == (minor) &&           \
-      CONFIG_SPICE_PROTOCOL_MICRO >= (micro)))
-
 #define VDAGENT_BUFFER_LIMIT (1 * MiB)
 #define VDAGENT_MOUSE_DEFAULT true
 #define VDAGENT_CLIPBOARD_DEFAULT false
@@ -87,10 +79,8 @@ static const char *cap_name[] = {
     [VD_AGENT_CAP_FILE_XFER_DISABLED]             = "file-xfer-disabled",
     [VD_AGENT_CAP_FILE_XFER_DETAILED_ERRORS]      = "file-xfer-detailed-errors",
     [VD_AGENT_CAP_GRAPHICS_DEVICE_INFO]           = "graphics-device-info",
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
     [VD_AGENT_CAP_CLIPBOARD_NO_RELEASE_ON_REGRAB] = "clipboard-no-release-on-regrab",
     [VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL]          = "clipboard-grab-serial",
-#endif
 };
 
 static const char *msg_name[] = {
@@ -125,9 +115,7 @@ static const char *type_name[] = {
     [VD_AGENT_CLIPBOARD_IMAGE_BMP]  = "bmp",
     [VD_AGENT_CLIPBOARD_IMAGE_TIFF] = "tiff",
     [VD_AGENT_CLIPBOARD_IMAGE_JPG]  = "jpg",
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 3)
     [VD_AGENT_CLIPBOARD_FILE_LIST]  = "files",
-#endif
 };
 
 #define GET_NAME(_m, _v) \
@@ -197,9 +185,7 @@ static void vdagent_send_caps(VDAgentChardev *vd, bool request)
     if (vd->clipboard) {
         caps->caps[0] |= (1 << VD_AGENT_CAP_CLIPBOARD_BY_DEMAND);
         caps->caps[0] |= (1 << VD_AGENT_CAP_CLIPBOARD_SELECTION);
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
         caps->caps[0] |= (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
-#endif
     }
 
     caps->request = request;
@@ -318,11 +304,7 @@ static bool have_selection(VDAgentChardev *vd)
 
 static bool have_clipboard_serial(VDAgentChardev *vd)
 {
-#if CHECK_SPICE_PROTOCOL_VERSION(0, 14, 1)
     return vd->caps & (1 << VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL);
-#else
-    return false;
-#endif
 }
 
 static uint32_t type_qemu_to_vdagent(enum QemuClipboardType type)
-- 
2.53.0


