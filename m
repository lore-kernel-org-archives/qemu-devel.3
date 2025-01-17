Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC615C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdU-0001Mi-69; Fri, 17 Jan 2025 08:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd1-00012Y-33
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:15 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcz-0002Gz-2d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso398624366b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121391; x=1737726191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5nQGY+sbeCS5yMC9j5SrutOVhuXnWOJMgjZQS915h0=;
 b=QZajQNUQ+DnTg/Zp/11okea2Mjcx9WgWrEzyzWRxZEeyGdiCMwlmUhC5wV7s0ki8Qp
 WL965c8BERXupc0t5LCjxcVeHg8EISZgJ/vOizAgcOPvdjZeI6RoD/ZXXGCeCA3Qn1OZ
 tEIoyjs1aGUZ7iWjWwKNRrryi/xkvn4sg6VWqHI0Oex8fHBh/574Dk32ppX9ZSVZqeGV
 oKfcQJB9QZ3omNO4ZUVLav4Zs6EANogc4VN5p8CDlbdTpyvyGYeMmHsiVzxh4WbUZVDr
 9Liq6TOvIK/6rjxuy76bquqQbY46iiLWIArRZdoQM25OaIM4hm7BEY1qbqwryzw0WU3R
 PUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121391; x=1737726191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5nQGY+sbeCS5yMC9j5SrutOVhuXnWOJMgjZQS915h0=;
 b=o9oVH7IpCjWgbEDSVX/UOtiMyWbHpRTPvLYyCDjvUt5UT3JAXN31wsbGIeaa/umso/
 NzvxP/WSGEMTzWhIuEVvXgaX5WdveUOln3WZFZGmCziGSaCfxaHQK9PzJyKOo/2V5Ut8
 FV1iNO5+ddbV6Rwc5X9GYgZKdukZIv/UkZ/kmycsqsmTfwvorhIOU2Sjb9qDljC1hD4L
 4d/XIWgIw5PtvZuAy2KFhnyJRDvhqgb93F/XrpM9nbIyDTxZqywYXO/EacK04cGiH2Zq
 kT1Ihri03BLJE0jX0xlGjtY92oOPWxsEU/9h4Ha35BFQY9dWbh3YdyFibFnVwJ8Zzp97
 Yv6A==
X-Gm-Message-State: AOJu0YxEIwWUMVp8IaIU+kE1Yn9iU6utEAbJsM8xDMw70ecIge9R2CyH
 Kpi8hFNNE5lk9bci63WK3FocxvcU6EZgdcCTvo/Hki1pV3iF2Eeyzq4LqqjPHiM=
X-Gm-Gg: ASbGncv6m9CMUwEKGzIkexYha50OBuUg52lPE8zRpkYiGbwtXrEU4C6DSsfM6nWApMw
 kSsF4IrtIbN+MdX9PkSff/sfQoAsD9JReLrpewjpsjocsmdQtb4UnXciWHjN7le1gdMO7mhiNIi
 MVLkQAYko+LFM6nzBBtkV4H1ENR25n82BhLpaij4Xp3uWadhHQbA8IX5yP4toODS4cy3kekLuyL
 avhuPj0ItWffoGiTj5+WazfsvcXGonZs5APLA/9X7Bbgb2VUhc7eHk=
X-Google-Smtp-Source: AGHT+IGCdPNfpgDJtPz/ahOLKkFUK4XEW7GUwdcjHc+3mT0LTTg6LP29PDcA4vjcCjgP/+YXedQbJQ==
X-Received: by 2002:a17:907:969f:b0:ab2:d721:ed8e with SMTP id
 a640c23a62f3a-ab38b42e688mr319241966b.39.1737121391459; 
 Fri, 17 Jan 2025 05:43:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c743e9sm174955466b.10.2025.01.17.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18222608D4;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 23/37] win32: remove usage of attribute gcc_struct
Date: Fri, 17 Jan 2025 13:42:42 +0000
Message-Id: <20250117134256.2079356-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250110203401.178532-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-24-alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index d06f59095c..da279cc112 100644
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
index c06954ccb4..d904408e5e 100644
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
index d247a5086e..c64831d540 100644
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
index deb40e77b3..2ffc58c11b 100644
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


