Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34404D6555A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2wh-0001Vr-1e; Tue, 26 Nov 2024 16:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2we-0001Uy-Dj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:04 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wc-0001aq-MZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:04 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-724f383c5bfso3074046b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732655881; x=1733260681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhU83W89p+RCeB/hbc2plZMB5afwgNr/zybcZ8PE9c0=;
 b=fvUjHhUMAyznJHel/DwOISGBKS/JFDnYzdmpq7m1sORcZQj2eDrIIgPFaeuOaMI5T3
 WckLyYjbCYMpZs0OOo1OMR4gvtIdP/S0XFiANuYHkqaxX5y9C54eOaL4ave8CyMCgANK
 oIrNHkqgYiH78Jd8s5eQoAjmK8Wrcv9/SbSfZwj/SAIE3Yv96Vi4D6qu3ORea/PkL3tQ
 dBDuKVv1ul2Q31tCuHxRQN/ZMCUbBkuDMmp4NwvaV8R93h2PFT0ui1EdWE9P30wZwKRa
 y85ubiOeFU2VYncPLVxtW47EpoMXW17iixvlIMDYQ5iQ9y/X2SgORL4XXZxfRpT03ojT
 8kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732655881; x=1733260681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhU83W89p+RCeB/hbc2plZMB5afwgNr/zybcZ8PE9c0=;
 b=H3okOeD3x+AM/rVXzkrR4darzCuD785t21tVMtFyPK6juHdjiWoznt3ddvmNnFTp9R
 gTe0XayBk0GXQde/akuZesyhONytCs1+zW+g+dgLB2hEnxG0qLVFKm3Ud4d0wNjJclHO
 etsq4ZeEYqMwMnPeYk8hO30QvfTunLz+CWbBTPb3SfWcubZtp6QNbEyeClbeYa8rjPHq
 HNtMc9Dydx9Vw0oyuxLLf/1P6UqMF5f0FrshfkW8MFQNu8Z1Uddb9qhpreAtcRohS4PV
 SJjHOcQOGzv/mvOyfDb0jgcsObdHmygnbwIhhOCLvL35cvbmWG9fqYDRp8KMz+lJEHGw
 zcPA==
X-Gm-Message-State: AOJu0YxtePeQHZyTB2MzZqw3IHm66/Wx3Dy8tpsOeHDowsliKJjQOh5F
 4zN5p/tW5b91ZPCg3e62B+t0PX+3jkXK03szdNpEt4S3HYtt86U90yBL8RaHQRN5nI4979yPqgt
 jkX0=
X-Gm-Gg: ASbGncseRhEJPvQ9v8p0+50AHGIb9+ckYCpMH2QFq7pi7125dHi1uzQfyVEjelmO12M
 0qWUJE6me+1zFHbXBGyJ0BBL62DkJ1Z7LwyoCwIjxotBjXXjfmcZ9u6iGitPsvG6U8mRCbUu56o
 WFsMCt1YaDjuH8mbqU1J2zjshdW3HeOrNOUrNx0Bycep1PJqxELQyORSL1sRJyWoCqPwZSC33Pj
 6kO404EM2dTY+unKDkCNqqEAuDVCeFex4In49L4tN8I5RkwA1+ZtVBEFOArdmXvrf+mXTgxbPjl
 0bM6T92eJn0nEg==
X-Google-Smtp-Source: AGHT+IGXTVZPNfbgU8mK3eOWSPjuZabooPf3zHxauX8N8bFxXIy1olis0fm8eKVa/eZAY5fzLhzuWw==
X-Received: by 2002:a05:6a00:928e:b0:724:f1c7:dfbb with SMTP id
 d2e1a72fcca58-7253001aa22mr1020702b3a.7.1732655881402; 
 Tue, 26 Nov 2024 13:18:01 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724fd95ed01sm5811766b3a.8.2024.11.26.13.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 13:18:00 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 1/3] win32: remove usage of attribute gcc_struct
Date: Tue, 26 Nov 2024 13:17:34 -0800
Message-Id: <20241126211736.122285-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

In the future, we'll forbid introducing new bitfields in packed struct.

[1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                               | 5 -----
 include/qemu/compiler.h                   | 7 +------
 scripts/cocci-macro-file.h                | 6 +-----
 subprojects/libvhost-user/libvhost-user.h | 6 +-----
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index e0b880e4e13..fa6d24e1233 100644
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


