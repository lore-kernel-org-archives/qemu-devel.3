Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C93E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZu-00008B-A6; Wed, 11 Dec 2024 11:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZr-0008JU-2d
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZp-0000Zg-CN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZI5/v+/ln/vWvbd1neY06KNWkby6DmmwS0Dx52j1Hw=;
 b=IfF9Zb7n06oCIM+oRAdDPYhvvhcBSI6fLQbP1xfOv4eOlP0iZ0ESUNjwveDD9A2ZeQYK8s
 HDFs/qEAYafWcqlFtD0O3VgR6JucqXVaYVLrLi9q3DyaDugbYmHvrQX7xzB5JIP+1gqdAQ
 7Du4r9ML6aJ209O0iQwKx6NW8jgIgko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-r4O7GqSgMCCFhFrvLSfQYw-1; Wed, 11 Dec 2024 11:28:39 -0500
X-MC-Unique: r4O7GqSgMCCFhFrvLSfQYw-1
X-Mimecast-MFC-AGG-ID: r4O7GqSgMCCFhFrvLSfQYw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so1927886f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934518; x=1734539318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZI5/v+/ln/vWvbd1neY06KNWkby6DmmwS0Dx52j1Hw=;
 b=WiexRJjjWuH8ruqWaG7PFUElx8tnHy/ugIp9MI2mYfwarn5OPS0abB8KkhoXFj+XPS
 9UdjvVZAnrNlIVC9JVd0jb6FrsfQ+RymC5r7cl/d7jGLkLe1cKjk+BW9O27hKgYCmQ9s
 vKoRX3KiD5251m1215GIiVMTbEURqCQsIwTwNlsQA8PbU13mwXVbZG2iGoLuLGs0ERUQ
 kmz6a2bFXNqq1wvGtCSpZ5Mbqrh7oO4+wgZlKArxsUh1ttvCaIRYk09kCwmW8YbINYRD
 VyBiPYvRLdlDDKTeXIYpheRpglSF/2SF1bZeayL6rWhdHf11Nf4fr5FODU99F2TNCT0l
 zkTQ==
X-Gm-Message-State: AOJu0YxAaI67b3DNcUatycUMmyx8OGlJ94EpZOaKbAwBC9pdq/xfPPBC
 3x6vCpzWC5m4P0Tf14rXN7VqUCoF6UD1anvePnnEEfL2yXUSynmooyMzX+pR3JFPkE+UJZUEjDk
 DV+CH6bl/LWMMGDPHm4wWMM3MO244GRLItd/WC10ypIbwMtbIwwsZZPrL9ego7zHK5m9/EsNs3W
 HN6iKCPodkNohn04+Ns4QEHbT2jC9/Juq9yTcp
X-Gm-Gg: ASbGncsQZg6QSWd7EpQcsaBkPhTwx0VtbCH4vGlbteketwcvzzwwG5rjepje2TgwQ85
 147Njuf6FDQbudP125vaeaJfXSzZHoHnL9B0BSMQ4f8lFAfyF/jTqTvcYWcEuOIUGSsJMgBVe9E
 mUNz/MT36LKB3T4Be7rCC5jjK/m3s+8o3woU8CezFn41agY9sGIC79S8QRzROsyKAli/BUqgyXG
 SBGeljQ7JWNA9oCqNUXdU3+ToV9Pes5RiubD38RNUY2vCZwB6b+XgeK
X-Received: by 2002:a05:6000:1f82:b0:385:f56c:d90a with SMTP id
 ffacd0b85a97d-3864ced1f55mr2797834f8f.55.1733934517853; 
 Wed, 11 Dec 2024 08:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjRpGkHppd0mFWYrc+FcWiiiOkRrj6DgQZcIErh/S+ASQeDpQJRSljSSFhgD7C21QMjMIIXA==
X-Received: by 2002:a05:6000:1f82:b0:385:f56c:d90a with SMTP id
 ffacd0b85a97d-3864ced1f55mr2797814f8f.55.1733934517458; 
 Wed, 11 Dec 2024 08:28:37 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f440sm1622353f8f.17.2024.12.11.08.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/49] ui: Replace type_register() with type_register_static()
Date: Wed, 11 Dec 2024 17:27:02 +0100
Message-ID: <20241211162720.320070-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-15-zhao1.liu@intel.com
---
 ui/console-vc.c | 2 +-
 ui/dbus.c       | 2 +-
 ui/gtk.c        | 2 +-
 ui/spice-app.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 53fcee88f4a..fe20579832a 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1073,6 +1073,6 @@ void qemu_console_early_init(void)
 {
     /* set the default vc driver */
     if (!object_class_by_name(TYPE_CHARDEV_VC)) {
-        type_register(&char_vc_type_info);
+        type_register_static(&char_vc_type_info);
     }
 }
diff --git a/ui/dbus.c b/ui/dbus.c
index 7ecd39e784a..d60b59cc546 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -476,7 +476,7 @@ early_dbus_init(DisplayOptions *opts)
 #endif
     }
 
-    type_register(&dbus_vc_type_info);
+    type_register_static(&dbus_vc_type_info);
 }
 
 static void
diff --git a/ui/gtk.c b/ui/gtk.c
index bf9d3dd679a..f9a53ea78ed 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2540,7 +2540,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
     keycode_map = gd_get_keymap(&keycode_maplen);
 
 #if defined(CONFIG_VTE)
-    type_register(&char_gd_vc_type_info);
+    type_register_static(&char_gd_vc_type_info);
 #endif
 }
 
diff --git a/ui/spice-app.c b/ui/spice-app.c
index a10b4a58fe7..2a93ae59184 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -173,7 +173,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
         exit(1);
     }
 
-    type_register(&char_vc_type_info);
+    type_register_static(&char_vc_type_info);
 
     sock_path = g_strjoin("", app_dir, "/", "spice.sock", NULL);
     qopts = qemu_opts_create(list, NULL, 0, &error_abort);
-- 
2.47.1


