Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14C8E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUs-0002eF-Fq; Thu, 19 Feb 2026 00:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUq-0002cl-Tw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:40 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUn-0001PC-KG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:40 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso377839fac.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478556; x=1772083356;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JWajiu7+6Li/Z2n7tE5/Bl8dY0WWrnqo2SsP4r+FkAo=;
 b=Ev1IPv9mUguwSSn3nbWShzA8UmHZ/iJ8ytKGhgoe64i/O7JQgkTyqq2GvIvVrOH2hE
 riu5dQdNRPwOIMUtpHnl43ziwJd1EvJB8sWEf0dUumOTkX+kRTKS46nJt6sIvWyQGSF5
 3g/HD1Zd7jm/vA0bTy5unMD/oqXMf2okptPsgBJCadV30JZMwIzqvUM6khU0ZyO6a7EB
 deui8GJCcpNmRJ2FdlmJYqiMvwNa5qTIpk/4i/2ih30BOWuGGExUMQcuZJ+hUq/at5FY
 mC4jqVTV6WcODyX2Z28FkbpqJyMFUYQWBrV59Fze4EOEYcXkqs2Y8UUdux06rcm/GeJl
 mKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478556; x=1772083356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JWajiu7+6Li/Z2n7tE5/Bl8dY0WWrnqo2SsP4r+FkAo=;
 b=fA9ZKTwcYplZKPqxiea/ueI+fTAQHr0qYIythDC6ZjKIzEvSOGltuAERrqdniIcWsn
 HSBNiWwwPRu6MiPWRKuHUFS2dbXy/WpUSYiYnxNSfw8A8gEIu5/N0AcbZsIReHzbtTEA
 ELD0wmtEoSE+WMTOEPaajlgan1dBrGaJ84nRa6EHiA1zZe9WDMclcGMcCqk4aNoo6yjh
 IyTOR6AX/0ERQ6yPcEyfaDd4w16AIhVOU34Bt2ppXFCShTg9VkJiRY9NzOSWjBEjjoz+
 jRUkyr4mYS24W7arXaQrpvICjFXm4mu1S6aisI6A70hAb/XkmhROZB6dFaNmIyCMhahg
 KmCA==
X-Gm-Message-State: AOJu0Yyp6lR4PQcCsHIfQibtNInZf9vOr/OzoF+O7xMIRIgqDBALpB/O
 DtEK1PJJw1TW+eQoizWd2KB57R6WNLhnAteZq9LT6v9NRZXZD4wMwloKB1aVCHPKpi8=
X-Gm-Gg: AZuq6aJcMg4DoVEg/q9AV2vpi44Go+6XyEKCVYH9EXoFAWS7afN/Zdf8TXZGGG0thWP
 ldKIcG4ggfGibYm38ZvDO0+KiJJsNE5eNrNUpqL7q+BdJlfYpKWusht02bW+yysADneUTKXdlbL
 /6vLJpXHmt7zGW+mJz/cqYNC37DVozDkAh9CK+xAu45Y1gwbcTNqsno3Zm0G3njCisIXUb+NqW/
 w6VoS0QXMeh1v4bEsP3UFuFrlsmWrKs/5s/H8ZqpF1c8GOV4qttyOROULs6e6KfxQa25cC7YcEv
 G8S8vANiyvoqJhoxk9bmLJtPJBUJBBAUpTYWuRiE991koVDOSaRGcohS/npOuqc8ze8w9Oe+oAQ
 CQnFbsKfx5x7ZI38+mWZOjYcTesSpcl+RPEIrP8apTBOC+5xe9Xgx1m0gEerkldtpg9WCOdbzxW
 /P2ypd2yVIFA==
X-Received: by 2002:a05:6820:1ca9:b0:66b:ea2:afa with SMTP id
 006d021491bc7-679a71d204cmr2330236eaf.20.1771478555664; 
 Wed, 18 Feb 2026 21:22:35 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:34 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:24 -0700
Subject: [PATCH v3 01/24] freebsd: FreeBSD 15 has native inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260218-bsd-user-claude-v3-1-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=A8Xu2GH0df3mztwb9ktNR6IhIDm3nnJR1zxZK4VoUK4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4rzQFYxLxmbU37d4rWWKy6IeF+FjO0ZDBqo
 nB9DQDTO3mJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 ADITEAC0LoAFN1MzoNMDubPZCkh46O+sbi7XZRPO0yBjm+8UeYbFTikaHj2ieIzaT3pFJ10/Mbj
 jHDerZJZsnwddA4sO/HYYuR9ENNs1rtf6V14esV3rhtE6kwv4wIkJYKXfMamy4bJZmAWxq9jz9B
 cfBVDndx41mmf9/xfLkW4oaPOg0nn0R03oSWdKko7zqcOnNu3j6nfps6Swhqcf2/tIHqcMhbPv/
 zrGeBcw2bypf0WjdmvJuE1YqZXlKtLw+IubSJiOnaTGKeNu0kkuWuf1jGFDL8okYvcp8tFYbxdo
 TZ7sm4avSukinft8HlLYdIBqLsT2fmnSGvAKP1V3PEYyLUzBgXYdngLXX2AApXXj2vVIPmHjkvn
 f7EejbA2of52N1TGJX6gktbID6cCLY1uNLhOWyDINOr5Cj0claLivqdynvEMsGBFbXvLpNHRyyA
 5lpeSiQ2NEfhfvT99QHYkdj0u0WFSrQ8FtSAIOm0KhC4p/AbEHwqGNuWZ+KRg6O2c4lkcV7xzRy
 kaFgNPcjR0kUKNUBa6h/veCq2RRaEYwPFrjmmckkditvK0BxBgRj3qJx5VJXk//jSI92d+PGKIn
 hwYqU+zFnW16egig7oLqBOwhYBqGYhM87guLOUcupMAQD6qiVnTMw5E0Z2nLPjZLseGk8nG+G6e
 xKUhrgoKVYb5TwA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
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

Check to make sure that we have inotify in libc, before looking for it
in libinotify.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 meson.build      | 14 +++++---------
 util/meson.build |  6 +-----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index 4af32c3e1f..3d761f89b5 100644
--- a/meson.build
+++ b/meson.build
@@ -2664,18 +2664,14 @@ else
 endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
+inotify = not_found
 have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
-inotify = not_found
-if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
-  # libinotify-kqueue
+if (have_inotify_init or have_inotify_init1) and not cc.has_function('inotify_init1')
+  # FreeBSD 14 and older need libinotify-kqueue wrapper
   inotify = cc.find_library('inotify')
-  if have_inotify_init
-    have_inotify_init = inotify.found()
-  endif
-  if have_inotify_init1
-    have_inotify_init1 = inotify.found()
-  endif
+  have_inotify_init = have_inotify_init and inotify.found()
+  have_inotify_init1 = have_inotify_init1 and inotify.found()
 endif
 config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
 config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
diff --git a/util/meson.build b/util/meson.build
index 7c9445615d..e7a2a2a64c 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -102,11 +102,7 @@ if have_block
   util_ss.add(files('throttle.c'))
   util_ss.add(files('timed-average.c'))
   if config_host_data.get('CONFIG_INOTIFY1')
-    freebsd_dep = []
-    if host_os == 'freebsd'
-      freebsd_dep = inotify
-    endif
-    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
+    util_ss.add(files('filemonitor-inotify.c'), inotify)
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif

-- 
2.52.0


