Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C984F3C984
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutaj-0000HU-S2; Tue, 24 Feb 2026 09:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutai-0000H4-0B
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:48 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaf-0001Fy-HU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:47 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d55b97f358so1181960a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944044; x=1772548844;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JWajiu7+6Li/Z2n7tE5/Bl8dY0WWrnqo2SsP4r+FkAo=;
 b=WukdGklzPRNw7WKzucpDb/3Ng1LWgXHJy23kEVXfKhJuYqfNzMemLtAAFbZUIy9LrW
 GMCF928+82Ct/vlLVN63X2HOapsDnrxp18lgCBJTLMHBPXr80RaPBFtzXNHyPbJY4Ztv
 pD64DOVzyYrsAS48EZIkxDAUTL39xlmg6STDZ7QG6qb9uo1H4XrF3H9Xs2kXYaAX7TU2
 /EcPM0U7kZT3fRRjv8ICWirQZkGsdu4P7y4ylKxJv858pcaiiwkaAXkTVyndBYB3/uea
 eJRDOmsko7rC1blnM0GUH8QgFpuzGjBvKxZxltObCbJShOQ8V66y+Kx1IMt9tVGEHU0x
 E/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944044; x=1772548844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JWajiu7+6Li/Z2n7tE5/Bl8dY0WWrnqo2SsP4r+FkAo=;
 b=SANEc1TN2gmMs/HW37Qgr3qoDsdqMNj2RKgcA4PwCCBY11w5miOT3owmateqqIvMqj
 dCVRx/vWr9/jtTi9urIYgWlbF8gEoc+woa2sIcpz4aIwh3OLimlEwOhNXZjjUJYLCx4L
 EyyxbNlx3xFHJqgsz+oAtIqfDEzTrZ9lVSKVBsv6fNo2kCTFp9q676xCfW6FZOymoRJh
 kfGDMTBIv0e5SY09aswa/dLk9oK4H6C7DzEEoiL8R24rBAn8fT1FTmiUIIEM+KNrq94R
 zs/cgmTcSFSn5ogMs1iaukioRI+fizCQGN+HxCljcy6NRArgMIwxBZ4aKIKuoZgsO6HL
 YUfQ==
X-Gm-Message-State: AOJu0YylePPmwitAJdgzArbyapfB0UfgW0n2ov7D+ev151s8FZCwGp78
 tRL7WbhX6pIJrjGshPKbgw3JxIW7GtR5XBO8a99QtSrLECZtadFQpmtj2XaCnBWaeW92z/XBu+J
 Ddlqos9U=
X-Gm-Gg: AZuq6aIiUYvFIT+ewTQ/fHI8AzxZfbwfsx8eAG91JWnVN0lIgwDOGXMVB7kYQr6Oi+K
 rYpiAQSrsJkeYgX9UcLLIFO09QM/XKCIom2IoP6IeOgvcxTlRRsNdRYJ2q6dTeRxk1ogEvs+t1d
 hMNQ2It71s4EM+HzlCkJbWPEVH4j+4NISysiGrTmuZhhhkiox+xou8Fss1IkYpGVQ4MQbuujQnZ
 To3N/890rZADtk4jXuqiq5FWss8O5/0PKvSFvANzwz21Tn3omJKsj0+QFMSZMzwuegYcvy4qn3/
 9ASwcaPOVR3q6WLwKCd+Ua+ice1SuVdlTnjmnHfU9YyUVphlI+xSiMA4++xf0DtI9VUygv90/I/
 AmRNYCGKHJLnIyDJI5Y5BV1fOrZZQ01A0otNA9J3Fflw+8tGsFV90r8x/4C7EYvL6pRkhnDg6vo
 h7EVdy/Mw0ntfBJjFuGRA7
X-Received: by 2002:a05:6830:a91:b0:7c7:5349:4e31 with SMTP id
 46e09a7af769-7d52bf2171dmr6761211a34.21.1771944043784; 
 Tue, 24 Feb 2026 06:40:43 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:42 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:25 -0700
Subject: [PATCH v4 01/24] freebsd: FreeBSD 15 has native inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-bsd-user-claude-v4-1-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
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
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhmfaw0UgLIDnTJQ0ybNpuDM4sLse+kQKMbC
 gOsehfjDUSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZgAKCRBsHNEofbAR
 ACcjD/wPQRAFUWPYpG1HSvSqGnvOCCrbOQ4PFlJSA/cP8VvjlmvTPQY6PJu69wdg54fl18eSkw0
 9SJzJWjLrwdQGPBGTn0wp3+TwXMIb930YYpQA/EFZhRGPkAghNRG/h+CmMnGK98xb/Em6vW/yp3
 ZKpEcO0i+UzBBL+PQvNoeJiUsI6AR3H/9MDMtrnwSweiYnVS5GcL7BgXuzxNbFi2/Tr0g7DDNfR
 jyaScNQOvodiUQYLt1wL++uKVubIvAwfiFwSwaccrHeJ5pzH7hl2keY3sBNSdzPwBGHYnr2QIrS
 erqnQduytt/pEzE/8uO0O33Mvt9neNwIAaTuCZdtoetvBNZBOhCEhisIX+UnPH1wCnBprbou9sU
 bOeVi93uV+ju+74bxV/rD3SQq3SQqGbUSiYNqT7T9fVrBKPrepgQCHQ1FAu6JJ/OpzZ4ATvXlv3
 5NqdlrOxYO1vduuxnN65bgxdDIcf3zmnp8D+W5nAEhQz6qNXbPuvU2W5ljPSmTOC0WAWt8fPDwg
 N4UiqOIF7x33+0Iir26ZADBdg0jX+IMJiwFg2m6I3xBFj1aWcLx58O02Bc0OGtiwOlI7ViF+8g1
 2yAdkV5rFLap7Acy6Er9HDO/yn8385m0riwpjBBQGxXllBFfEXz1vaqUVeTv8EhlR+NLPiGMOYl
 Y0NOmC35HtEPi0w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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


