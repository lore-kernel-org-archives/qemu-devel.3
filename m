Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574FED70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 20:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkvA-0001Gr-3x; Thu, 28 Nov 2024 15:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv8-0001D3-3P
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:26 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv5-0001m5-Hp
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:25 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fc41dab8e3so761914a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732824922; x=1733429722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONBBnO5spdOxnYQqxE80/N6XLVKqgeL1XxIVJJ/xyUo=;
 b=ErtqzJMpyXnidmmAbRQ1f3ywP9D6FSg66a9mzBqh2vgZqTgtPohh7XZF4xwFoKpd1E
 3FaMplPuJgLUXmWLqnkS9U27REiWXld4j+087dsuY8fsjEMsFey6QMtND7Ay2T3fIkrB
 vvMz5Co4KJoQzxKV8FD5pb5NyFHAxDe1z6e4A9ayYqa1J+bl+ulTBj7IgroWSghMuHc2
 4BTlpmqB86SdiyLUIopq8D6f6HOXS/YrznfvKgdSEnfBLw40kJ05qhW0ltgESGOt2Pdk
 Gb0Snqa6jH4RVbPWE1yiew26FgJwrDPgghxjSo4qLbp1LbXsdMkX8FF4A9oXF6fx1LWE
 jAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732824922; x=1733429722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONBBnO5spdOxnYQqxE80/N6XLVKqgeL1XxIVJJ/xyUo=;
 b=bX9IBuJlkKtT3fsI3LTVFNVq7zmpcBi/JrZKk1v/iwinLu2ArMvd14iuf4qWG/wnaG
 fEkIhcyMY1HngecXSYNv9vrOK8kYQzqhTPq1lCsuiJSQnBKbXiA7Ngo3ptfQI7Xbr3AS
 nZQRwiXAuErfRhgVhSHza7EvlMV0XHphaqyozLolfLrQuqIfpNPy8/TdNXI6c3WyG2TE
 RITw8FcVD9//DTI6BnugTBKhbg6wLXmWFjygfvYj12hcjv7ghsMIqDEHhkOS/nsWSaq5
 GaPpXI4vAQf47hq3csoClsrIlF60SFFrv2cHSPXR9OpsMa359a0B06jbBKwNAyO4oQkc
 tsgw==
X-Gm-Message-State: AOJu0Ywti3HP0Lj/h36Zf/W3XvL4PJI78tyF0XnI6pyUhq7rUSrkq5/Z
 66Bf8wvWDF0V1UoVdoI3iTGCg7oWtITuyIVoBxnFbum6+HUDHWXgN08j50rBXmx8o0Mszn/aZJe
 EwKc=
X-Gm-Gg: ASbGncv1r/nwXYHB0YiEjdJMDO3/jpev1SJqGP0dXWmfIyMMbnvwcK/GisA9ZJXrY8n
 UmfQ0CZ6/afV/hy/JcbdpAsz1kplpi5V3RFq2fwpfizLKWs89RwgafwVxxv5QCWhVGzke1ZGLq3
 juePQo9hLZTlZ04eTbVF4f4suIIbnQ3CSw9RsEzUR2s8qiJPUDyhOsP/35Xv+jR3cRc5cM917qS
 O9KwczDa7eHiPx8C2zKB0a07451cg4ZRqYnyIp2nhuHNobVAibWF36cZJiNOUP+Cw1rhGeU4DTx
 P5ivAQdUbgT0Gg==
X-Google-Smtp-Source: AGHT+IE6QC9N2wVXvQctDqMdIJEN968PODwLae3RR5eIMlJRLXA7Q7i3IRRNbhIGsHUigZBg2UJpqw==
X-Received: by 2002:a17:90b:54c4:b0:2ea:6f19:1815 with SMTP id
 98e67ed59e1d1-2ee095c0028mr11247829a91.24.1732824922167; 
 Thu, 28 Nov 2024 12:15:22 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fb10049sm3912861a91.43.2024.11.28.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 12:15:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 1/3] win32: remove usage of attribute gcc_struct
Date: Thu, 28 Nov 2024 12:15:08 -0800
Message-Id: <20241128201510.869974-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This attribute is not recognized by clang.

An investigation has been performed to ensure this attribute has no
effect on layout of structures we use in QEMU [1], so it's safe to
remove now.

In the future, we'll forbid introducing new bitfields in packed struct,
as they are the one potentially impacted by this change.

[1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                               | 5 -----
 include/qemu/compiler.h                   | 7 +------
 scripts/cocci-macro-file.h                | 6 +-----
 subprojects/libvhost-user/libvhost-user.h | 6 +-----
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index a290dbfa331..97cefb7cdd7 100644
--- a/meson.build
+++ b/meson.build
@@ -354,11 +354,6 @@ elif host_os == 'sunos'
   qemu_common_flags += '-D__EXTENSIONS__'
 elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
-elif host_os == 'windows'
-  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
-                           args: '-Werror')
-    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
-  endif
 endif
 
 # Choose instruction set (currently x86-only)
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb41..d904408e5ed 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,12 +22,7 @@
 #define QEMU_EXTERN_C extern
 #endif
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
-# define QEMU_PACKED __attribute__((gcc_struct, packed))
-#else
-# define QEMU_PACKED __attribute__((packed))
-#endif
-
+#define QEMU_PACKED __attribute__((packed))
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
 #ifndef glue
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index d247a5086e9..c64831d5408 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -23,11 +23,7 @@
 #define G_GNUC_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
 #define G_GNUC_NULL_TERMINATED __attribute__((sentinel))
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
-# define QEMU_PACKED __attribute__((gcc_struct, packed))
-#else
-# define QEMU_PACKED __attribute__((packed))
-#endif
+#define QEMU_PACKED __attribute__((packed))
 
 #define cat(x,y) x ## y
 #define cat2(x,y) cat(x,y)
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index deb40e77b3f..2ffc58c11b1 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -186,11 +186,7 @@ typedef struct VhostUserShared {
     unsigned char uuid[UUID_LEN];
 } VhostUserShared;
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
-# define VU_PACKED __attribute__((gcc_struct, packed))
-#else
-# define VU_PACKED __attribute__((packed))
-#endif
+#define VU_PACKED __attribute__((packed))
 
 typedef struct VhostUserMsg {
     int request;
-- 
2.39.5


