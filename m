Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C6C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVU-0008Lr-FX; Thu, 16 Jan 2025 11:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTw-0003m1-9V
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:41 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTj-0004Wx-Hr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:29 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso880794f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043938; x=1737648738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8aoZ+4wIpFt1loPUkrjNZIwpI4hyfnz2K8d4L8ae9I=;
 b=dyGCsp8MXtoz1cxO0M2BIymsCRCpWD5xJg6dQGTg8oSihysF2KUVO++6c46OzaUPIf
 0WGTFQ24V4WyLhgJmxnxylJ1Yicx46rRsWxvXhdfPr5OlRLEJxMUlQBq6D4Bf6Zjg8X3
 zOEPP3T12Bmt1BlsyFRSJ4aHBLvghh/kLMSdZaQrKBwm6LAHKbavd8mrlbd3bKHqUgWy
 g+3zRNGROStNfYR3/v+C8QJnTIFZ/VKZ6ScdQl0HsSb2KAoj5Yam1zNu/q6gII7a69lB
 OTYXJw9cWK03X6aB8oDAn/jcWpbrNREgwSpc6Lk18Q84ykxhYPbEx//OpPc/zQjL/j2w
 RGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043938; x=1737648738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8aoZ+4wIpFt1loPUkrjNZIwpI4hyfnz2K8d4L8ae9I=;
 b=N0Hvy4+hin5+7v5cnkrgvC6t/7X9eQEY7LBYuw4ZVcnMaKAl1aXXnccF5vPseWChC+
 I+OfVZYat0tTOEYwbewZ8hS3ygnMn/fIFO2A94btZqcIHqW/hYhQ8mAzRLjpoFRndOiM
 TOXF/dNDiixOGOQbnX7TI8rjrYUGCaDkqA+yoUkAXi+o9LOoQL68S6lzTIG7yMPioSJB
 JBffh2bC6j4tGlOJEuS6Y1Ygt4azmvPSbcP6BuJacl3NcaftHriLt9F9UmaKJRFB6OMw
 ooyDB040XNpYTKIlj+i67FYmxg5M3cOjOSiLqGGXzuYJX1wwCsnfF1kbcnMf/7Stf31U
 tYRA==
X-Gm-Message-State: AOJu0Yze4eBzpO5rSJdYobLnJKwjFsbNgQodyby7Pz3ZlPRmjoG9HLSC
 sDCwnlOXCFvwcq4q9HM4rFFQNEij8I2CKHa7kfOT6OndNwdPY4NWp6ehDglMfB0=
X-Gm-Gg: ASbGncveAtGryZo+FzpCCdN4DsyOSSkzpDrMl7n14cPgjCEiuDFpgDS9leZ0bQyjgOb
 v3jQ71ZXxp+yuiLeLMsU8Oc6iLcqArPH4/wB4lJZxdQoS8MwAlB5hVksIRGYLND4QsPvyQP1aZ4
 8iBIVWJIxWFE0If2nyD4nZnKITrNsaonisWXgmp5qBaXyWBSg5Lql8F/8bRe7I23H4mA2bDAikj
 /slbqowVD4FJm/lb051qlxsP7wT4FsKZiDmrLFJBrnEqFnpOOLHt6g=
X-Google-Smtp-Source: AGHT+IFaB1wLQxQYs7LjX16DzCaYtwmpePr9HH7XSW4w/QdpdC0d/9H4WPpLX9h8tVZERkhRdWPAYw==
X-Received: by 2002:a5d:47c5:0:b0:38b:ed6f:f00f with SMTP id
 ffacd0b85a97d-38bed6ff21emr2468045f8f.17.1737043937822; 
 Thu, 16 Jan 2025 08:12:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221b5asm238633f8f.21.2025.01.16.08.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1806608D2;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 23/37] win32: remove usage of attribute gcc_struct
Date: Thu, 16 Jan 2025 16:02:52 +0000
Message-Id: <20250116160306.1709518-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 meson.build                               | 5 -----
 include/qemu/compiler.h                   | 7 +------
 scripts/cocci-macro-file.h                | 6 +-----
 subprojects/libvhost-user/libvhost-user.h | 6 +-----
 4 files changed, 3 insertions(+), 21 deletions(-)

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


