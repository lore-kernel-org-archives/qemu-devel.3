Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18099D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunO-000184-UD; Sun, 01 Mar 2026 23:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunN-00017E-40
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:13 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunL-0006tl-NY
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:12 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-679501fac3cso2723218eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425330; x=1773030130;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay9FcTJRWmqeizwpgSBZXd/bub2PVaGHDw3ZhG2MNLc=;
 b=WatmM7vzDZXvQx6YMEH8QpXQm00LQ6SA6Xjg9dq+dMud+jgap9dPfIv1q3KP5teyTt
 r1FzlLXg6OuTWmJboCyOYB7+sSJPrDgL1kixFME7HgYmxr3jZz6MdVl3AcFmOPR3MNw7
 mYtY2MU5tx+x6XPEv85sEwqEnTWel4evMafCpqnULz4G5utHp0gbliqT1ah1EYsHmU/f
 Hc54ETSIm86s/DZdu90EkXZYW76qMSZ+Nx8lZ1lrUoVV6lypYbPdvi2Y6szDoaj1e6kx
 NLN1/7m6/wj6KCNHFlRCBUY3q/IPAOXFvEPyG3Ez6lWr41il1qssQ/lIb0UvNJH515Dl
 6FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425330; x=1773030130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ay9FcTJRWmqeizwpgSBZXd/bub2PVaGHDw3ZhG2MNLc=;
 b=JFF1S3ACpw9wvkObPTiOBdpMwQpbSKXxQJ13VSSYjyfu4E7+y8BuoQoLMI9ZttpMAK
 qhDM67vlvMC+cMVV74rbwEwHRG1FcTdUvea9WR01VeHY/QV7IYAx21TQ7Ch/EZEEeYj0
 vUCyFJHg/03+MQ4MvhoX99YKDSXwpIxPZzPN9Io7qwQ1X6DyvC0CFj9MVw//7ZmEbfWU
 mFA8sZQ5jGsW0WtjfAsOZFZSCCdXQuSMDacldpvfLPqiJWTY0+QDHF8T/0r7JRAwIfK+
 OfJBiGWXWkQ6xrNpMT+erPy/kdu6wSQOlPMiRXHhqnCAR/a8/rPGJ1adHBBZmTeRiesT
 UwFQ==
X-Gm-Message-State: AOJu0YyDYCbUSvtV2QQneBDUtcVm2dA4Ho8UrNCBbrXReIkYadoPFdOq
 BQ0n7h1DmH/xRlpr33KBNFRcqlqut59PWSzfcXpHf9khe0w5m4lMND0uH/zFEi4sTmc56nMHBPo
 dcD21
X-Gm-Gg: ATEYQzwRcCncKQpc+Ly9JWuc/PV+SArL+GYiBAF0GGQHN7qtrWtcJBgisxx28e6Z1oF
 36SXrRh+EPRSqUcUgqKazclR3/lgreSs1n8lyk1Ubi7X1vnA4MF4l/4/gHz1cf4bsZaWCydrVV9
 uEnHh2uGxhWtiickIYUE2BbJScgn42oAh4Cuto237QkQiYlaVNiZibOXUJUwZ/yQxps3xkW26d1
 m3XeV+SGtBXBWoz9dKSzIRIBcTJekzLICshJQ/1gZVdqutgd/yeaOBsA8jKXXk7zYpPIZiLBAyg
 ObYp9mENQhTCB9uczVvS9L0Zdzcec9CJqS7Kn8nih7PoGKIsb+eMn3m8v2k4OhSrStBPhEM3L3z
 mGotXQpoaKbD8W/TDi2Lzw7patQSApaAlN4at6NiUaCMwUycyBE0mVY6lYaLzPlWRWxMvdWdt5r
 rKXvA2mGiBPw==
X-Received: by 2002:a05:6820:808:b0:65c:fb86:8a8e with SMTP id
 006d021491bc7-679faf118cdmr6442952eaf.36.1772425330240; 
 Sun, 01 Mar 2026 20:22:10 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:09 -0800 (PST)
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
Subject: [PULL 24/27] bsd-user: Implement System V semaphore calls
Date: Sun,  1 Mar 2026 21:21:12 -0700
Message-ID: <20260302042115.83410-25-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2c.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Wire up semget(2) and semop(2) syscalls to get System V semaphore
implementation, as well the undocumented __semctl used to implement the
bits of the interface in libc.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4c1191b8f4..234bd78fd2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,6 +36,7 @@
 #include "bsd-file.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
+#include "bsd-misc.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -878,6 +879,21 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
+        break;
+    }
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;
-- 
2.52.0


