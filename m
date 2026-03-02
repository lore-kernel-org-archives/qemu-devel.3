Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5808D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunN-00017Z-EN; Sun, 01 Mar 2026 23:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunL-00016i-JU
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:11 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunK-0006tc-83
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:11 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d19d3c7208so3085016a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425329; x=1773030129;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WFut1ocwU4YJtiFTSG4WqMYnXp92AfooRd9DndRQQI=;
 b=mMH21VX8hevsIlhTO2DA8fl+0ns7JrGhsQffOi7y6osdEHbvOR5D0rKXBF1MaFB0xS
 DqBxPA/gxd9klc6FMLcZSggekHNfBzQmuBQ8ty680ire8TSfB6azD8v5hx72h0KJLfSI
 yLpg+A+Gq7R4J7hvpssQBVlbKyitTVmD7jItzC7DYN2qV5SfUx9t+75KAbP7vZcXrGzh
 Qx3KjRaDOnHeVEM64tw/V8f/cXI/eBix3sojNIe3EoktUqY1jmgy8aOB1jvu7MW1fxle
 TU/orDHTtki+oeOCSnIEj/rrsTIpr/mfEUc6SDt1x9sX7Z5IoN8Ap2kkFtMcAhrPGqx8
 7rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425329; x=1773030129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WFut1ocwU4YJtiFTSG4WqMYnXp92AfooRd9DndRQQI=;
 b=CIKSFPedsTwGmcUoEcWuXKfe3jkQ2OR0Hhce/PNga9gduiUtESkAlpDCrEz2ToMVQM
 2MS4grP7h+Okilb+EG7rufhfvoxhS6wb6jLnVQ/haNHXQNsBqQkpJizzmJp1nG5+xKE2
 qyQg5bv3zDwm6XWKTfv8isFqe9nhoUmuZ0hhaPGmwDbbSpkRoTn+tz/y/cNjYrsX95VA
 qR0nMG14DMuPM6gMT6+DN/BNEbpZBfUSCkcP7CtJh7dixO3ovW3oiyqpnehO0J1XDZ3Y
 cJe9rXkv5ugthw2OwaKR9RGzdLEtw5eUJKFIkX72CJ2I9P/FX7/s19AgRgCbyQcK0T/n
 4Xmg==
X-Gm-Message-State: AOJu0Ywy82qE12e1TeSjfBk5/ds0xjTNjS3g4YH4197Jwvm88qUe0Isq
 ZgPb9TyGBSIaXv8xYsc/jUAPNScU7FiArihwYAAAbZIgTW4Iu3uDSe8KLl7AQwHX5wXluaAjj0v
 Ujdan
X-Gm-Gg: ATEYQzxs6g9mbXGXiAQDIktNu2Fd3/youW7are2BCPemY3MAonoA7D29cdIRluB8TJa
 sAM8U8jy+rDeeCn6OIzAUYlOg8bfg35xIJgkl2cgGGEZ8oQ3s84A1NOpx4LgXIaQOunbggcMiO5
 DJSNsfIwAA6GQR7fIneEjPbrQx5E/xvISGYfR6aQ3RWnFAtugk2tWDoAD9U26PYjfiW6LOswiXA
 Ndi8yhnYjfC5QKb8zUfRC8qnixxD8ApQTfe/11OktXRD0UEbGcDSnabS3i9J2VZp/ynys/RbwTn
 CEH8rwAairKWh8jmAl9W3kALHbyZEy7Zscn57Vd0HRgW7s8SOlBAdM329IXr4mOW1vK7x4bhQrd
 Jv9DIrjttykVShpyRXg69Sn0XYJuJ/b6UJvZXM4flEMJmJYvzr9WBv+u7iNLVgl5i8xzTRW9Ek0
 K13SAYOGoERA==
X-Received: by 2002:a05:6871:5b14:b0:3ec:41eb:6e38 with SMTP id
 586e51a60fabf-416270284e5mr6482227fac.38.1772425328830; 
 Sun, 01 Mar 2026 20:22:08 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:08 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/27] bsd-user: Add bsd-misc.c to build
Date: Sun,  1 Mar 2026 21:21:11 -0700
Message-ID: <20260302042115.83410-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

Build bsd-misc.c for routines to support System V IPC, UUID, quotactl,
reboot and getdtablesize.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 37b7cd6de8..00428fc2f8 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -8,6 +8,7 @@ common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
   'bsd-mem.c',
+  'bsd-misc.c',
   'bsd-proc.c',
   'bsdload.c',
   'elfload.c',
-- 
2.52.0


