Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1125E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLhz-0000WC-JP; Fri, 10 Jan 2025 15:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLhx-0000VR-96
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:17 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLht-0005ex-TI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166022c5caso39480935ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736541252; x=1737146052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZZWVjzYh3oSJqK7qwXbLdnBf+l62UVrcXWqFU7n58A=;
 b=ZtJLJF/sdiQduEcA3HnIbwqcStbqBStAfAbynBpqHwLBOh0a5jNHW/KMqiWiuJBQNS
 gdanlAie4zClc0O1n1hIrIFLUkJ8EnIhpnEAchHpCfjY2kS1jxQD3COemD6S7baaQPj4
 ucNsGG3LdJ8lfe7JDYIB2XKc9U/b9sIwrpGn7ogW5yovlYr7qI8u/EXWrreHbHu11H38
 KOZclF9BIaljV72XDI+ku3/GKrten1M4Fv2bXip5PVzFJjKZnW7m0ytkbWmtyqHpe200
 i795TVYhNlt6PvqV5+1rJDv2Wk6ARv09me25ZAJTbgOspphyxp6fWRC4zUn/NVZWjCEU
 LLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736541252; x=1737146052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZZWVjzYh3oSJqK7qwXbLdnBf+l62UVrcXWqFU7n58A=;
 b=RUzN57NGOw7s1Pqqhjjs51que/8wXIGX7IpnM4nF3dDk1R+Y476gvPVGAfGkSVuUJ8
 SqgQvDVEGKy4Uu7IjT+3rEbGb2BFnKAnNi1Y7RJ4KcuggAKRNY9Ukau9AYcfrfCMVlvm
 KWhUUMghuOUo+Zk60t9iqOw+ANg6wyJnzk4ZVjDgLGRTpMoapPC+2jBdxOLsvRnXvajd
 XPsvxYDrPVRStQybgtQEOFjl3Q7N+S3D32pLKWFMQ2M68bf3XONXDw3g/bONx6+wowlG
 2M+VYaOzRgsyBq8zHqhbPZTs71AowanDPHHZ2cYvdBIiJ+0T83hXvqSbhRKnP+idywMa
 gTJQ==
X-Gm-Message-State: AOJu0YwvuNrXi+JFLEHTrQJ031XIs5ANqPJl+WY1twuOTWq0ufooMwS9
 XrrMTV478+dR03mIR1O89C4GL4Cdl6YSlfVTN4w8tfOGw0C1Zlk5J6NFCI73omllkTCgGDJ/fSl
 wOvbNxg==
X-Gm-Gg: ASbGncsTFtp5ACAQIE/gXbMtYvYudnSo87V2hd3UkAiK8vm5a6xoppo90SLl1A3487l
 NRVgTqPDxg+3pFd/MTk9WiaEDyU22Z1D9tdraBY/tfv/RKU6DlKuNLDj7VNS4x4enwAB/zUVhN3
 yVBl8otxmP2A+9GTPDh/y4MqFIS7bJ66pv4eeTmbpF4zqaNbbLZMM3eip5MBoZ2brtZFQGZJXD+
 OaUQzTghGGR+VpwIFSBFPV76JNPMIVsoGWUpTUjCd8nuFlCuLJ8BpHl
X-Google-Smtp-Source: AGHT+IHE946Nv1pp1lwHv92vIOQaiNJtrdMdf0zUsxrksZ9cVqb4CSI8INoI+7LH3Ltp055zDaNMLw==
X-Received: by 2002:a17:902:ec83:b0:215:7ce4:57bc with SMTP id
 d9443c01a7336-21a83f54a5cmr175214205ad.16.1736541252281; 
 Fri, 10 Jan 2025 12:34:12 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a318e8ecacfsm3215947a12.38.2025.01.10.12.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 12:34:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 1/3] win32: remove usage of attribute gcc_struct
Date: Fri, 10 Jan 2025 12:33:59 -0800
Message-Id: <20250110203401.178532-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                               | 5 -----
 include/qemu/compiler.h                   | 7 +------
 scripts/cocci-macro-file.h                | 6 +-----
 subprojects/libvhost-user/libvhost-user.h | 6 +-----
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index d06f59095c6..da279cc1124 100644
--- a/meson.build
+++ b/meson.build
@@ -377,11 +377,6 @@ elif host_os == 'sunos'
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


