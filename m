Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AAED58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwump-0000wH-I1; Sun, 01 Mar 2026 23:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumn-0000vg-LA
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:37 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwuml-0006nH-QT
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:37 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-463a0e14abfso3364628b6e.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425294; x=1773030094;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLsXbMpf797wxSymu383K8sKKBg+3Qontu+O0yhZ6us=;
 b=wAxNO9FbVJ3rvU21RDb/UiIePGnwhexOJ+f4tDdtdX5Ujy4Wwow3kkeEIc0ep/JPOr
 eF9zmPC1UNibZusr8bSPsNkDlhLwlgYV5H2k3eWe/S+qZUY+G/mt0ADR8N0hPvnHBGHV
 auPx4go26rYhaEaeuIOycUi9XdLsUAonrp0Mxky/NkL35EMow8DLF4sceuwvwltFupOS
 dDUFuNRvNtZxIsWGGJCJ0IgXPW0oM9hymiTSsOIiOa6E3KhD4w1LCQ0DmMV4KtEViDeA
 99cXkO/e/8zRwLxOpAoWpeh8yVNPBhUvxjui4gDCCd8xoHJNtvC8SdVhLLKXm9LeapKV
 z8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425294; x=1773030094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OLsXbMpf797wxSymu383K8sKKBg+3Qontu+O0yhZ6us=;
 b=ZUBjqltKr6WnXQst/nvao54Pplftdku6kfI9bM53nDfNKReXa8w4+hIh0Bodo4Mj7s
 biFYkfQzm5VxsImlI0htiZjLDa5e0+Ij7eGib1vP+NVV91AZLO64JN8CB/Feq4m8J7ip
 ea9W5/ceky+4sxwUrvxeY6bTZKT3lrh5pY+zc1EX0AxGFGBo3TlztloVGKhvjl8aD1Ey
 3Mx742StLo3MokFcXQglwy58y6ulVOrdmTdykey+JKdosWdZ+2Lz4DZVe/ogBrMpKBWk
 YD7Hox+FpRV2KxRnIGxOQrsZnrGJn4A+Vt8joKlzsmriyrYOYViRkAaaXCtnTHL9jVTq
 773A==
X-Gm-Message-State: AOJu0YyLcM8+R7WyNCBk95AzftZ1+m8Es3+eI9rllOCvt+rfqKaoUZQo
 nBQKsDX3/Ln9ZPekXj6WdMG+RKFVy+dRJn2T/Zr5LEWa3PpcpCOhF9yEtbjB2IDby4EV8FwtsqH
 G8HT57PU=
X-Gm-Gg: ATEYQzy6+b9nd8XkHdHMyDy5px5p7WXK/9kZ3wMUdJZEE3qFqJnmJ0LWuhMK/Dib8Hv
 Bhv2f6jx+15r8q/oK6/6obUMNJcD1x6/CpV0ocfb1GWPf8bY0C8PXVZKpYIsc+6dVc0tZ/eI6Rd
 Hc2iHFhLb3K+PMMRMxdt2XCq8VB0d77aMUEC4Uu0YWHBU8211pESGd48naBV/vylvBzunVnc4Lt
 mvLWKAqKiuv0AtERlOlOlw2EsKdh7PN402wVby21qnwpTHgxzR9CD4BH2gcHTHgGLu3Lpab7v6F
 kunYYAsJr37DZ0heoQ09WRD9kUmnWir6XW+/zPjnoyrObCnR+gpQjaHa6ViTBxezXYuv6YvF/OL
 N4ktmCx/ceA34zoWmGN5YQhZ9nr1SxpMxD6+AfwJcGRpJa1zvkFT3R+8z+OXwUHtW7J8rYppH4X
 uw11Vc54VH7gRI6j9gHQpq
X-Received: by 2002:a05:6808:2292:b0:450:6eb0:3481 with SMTP id
 5614622812f47-464bebe2d4amr4834876b6e.43.1772425294158; 
 Sun, 01 Mar 2026 20:21:34 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:33 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PULL 01/27] freebsd: FreeBSD 15 has native inotify
Date: Sun,  1 Mar 2026 21:20:49 -0700
Message-ID: <20260302042115.83410-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x231.google.com
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
index 3cd1d8dbc6..9a19a68ab8 100644
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


