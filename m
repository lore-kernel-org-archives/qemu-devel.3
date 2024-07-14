Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55329C3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 10:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSwgg-0004cv-6S; Sun, 14 Jul 2024 06:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSwgX-0004bJ-Vz
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 06:42:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSwgR-0001Nq-VB
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 06:42:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso2725094b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720953741; x=1721558541;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LGfW6nvB9YgOleIlZQRPqE1bMiV35KTgKrp779sah0I=;
 b=MPtgT9BCMyWhORR4D+450YLFOJ1ZJoUWk1s3ms7YHJZbC8CjiTFQglUZ+9vcitIQO8
 7cIzv0uOWf33PaqYGq92ESn1OALNW0DjHKDDlgXzjLR6jPf9vwCAU3ktq3CG+XfnakEg
 rrwiliLZWaQRBpCHmEZfmxlzP3KxighhbgMRqO18DaUS8SHw8i3BSWxSb7sfONq0INlQ
 7KGmuZfkN363ZPddhNU0PRpORPWKPJL+vit9jgnb3oB92tO/mode19uTv2YpnN8nROO0
 CwHU4t7VRL5p2+Uq6wBU6GB4CGKXPEIYOcCQp3pICFoVIv5lLh5OssMrpmncs2k8V4+f
 HAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720953741; x=1721558541;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGfW6nvB9YgOleIlZQRPqE1bMiV35KTgKrp779sah0I=;
 b=baIHCNAUZNdj+qHasRIH4ZPAfQHQ4gIOF0Z+gEeWv3+udf1zxv5zk1Hzz0r1uMYkCs
 ZOLmB5U04vU+BT9wckIkIFSIiZdPLz+NXPVa/vyRX5iB7IqxaaOcQALjcwvFPIvrqEVI
 MOWvhDEdNXAULIZf/ES8KX7vcbBjEfAJ5XAWJvAyhGNOlFik/SiRJMxJN2hxh3I12Ico
 WnCEtjiPuGmH1yMqJbasTxc3VoC/D9kLrmtIiQZwPRaaa7sXympVBUnygcTLWaIsDmma
 6xzvCoPowDxZiMa6GnQ7Tm+MrIMz+YR7beC+ygo/u2SzfeDiPu5+ueu2OOp2dtVth6Eb
 Ez9w==
X-Gm-Message-State: AOJu0Yz8XUA7M3/xw/RBz8HhXQtCiLwoDRb25x4fCByZcOQqas//6Q/J
 kmdKGy4GMMZksN3ksG2jxT8QqrRDq6iKACKQvMo4Qm0E+Bf2ANalbGtE6KIljGg=
X-Google-Smtp-Source: AGHT+IE/nN2WCyxhuJOBBr3kdpASYhRxXpwwoIld/AUhAnv2Wtct/47GT/OwuNC9v9btoc+I/78Niw==
X-Received: by 2002:a05:6a20:a106:b0:1c0:f220:ed2 with SMTP id
 adf61e73a8af0-1c2981ff899mr23851830637.1.1720953741011; 
 Sun, 14 Jul 2024 03:42:21 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ebd1205sm2470481b3a.93.2024.07.14.03.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 03:42:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 19:42:13 +0900
Subject: [PATCH] meson: Use -fno-sanitize=function when available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-function-v1-1-cc2acb4171ba@daynix.com>
X-B4-Tracking: v=1; b=H4sIAISrk2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MT3bTSvOQSoCJd8xRjo2RzI+PEpKRkJaDygqLUtMwKsFHRsbW1AAC
 h6k5aAAAA
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
-fno-sanitize=function in the clang-system job") adds
-fno-sanitize=function for the CI but doesn't add the flag in the
other context. Move it to meson.build.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build                | 1 +
 .gitlab-ci.d/buildtest.yml | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6a93da48e1b5..80447833f07a 100644
--- a/meson.build
+++ b/meson.build
@@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
 endif
 
 qemu_common_flags += cc.get_supported_arguments(hardening_flags)
+qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
 
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e3a0758bd9e5..a57822d65182 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -430,7 +430,6 @@ clang-system:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
-      --extra-cflags=-fno-sanitize=function
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 

---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240714-function-7d32c723abbc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


