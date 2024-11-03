Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A883D110C2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 14:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7bgW-0000SH-2R; Sun, 03 Nov 2024 09:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7bgV-0000RG-6L; Sun, 03 Nov 2024 09:34:31 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7bgT-0001wr-RG; Sun, 03 Nov 2024 09:34:30 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ceccffadfdso983268a12.2; 
 Sun, 03 Nov 2024 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730644467; x=1731249267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQqur4ICLRRHD8Fc52q1dC6WTnMWn9RJygPTgDiWU8I=;
 b=Xc+NpWIq1JRjN+xsraS9D++v+aQEbg+fO1viMC3UvoIY3tSDn98RCh3c4mOVgUlioQ
 chVGSw13idnBvWAkT7H59IDhNdlkmzcyazOUJ9eAqm3c5qPNgiryd/Ad+0eY0MMqJMWD
 jW/Jrwn4Jt2ZhIde1oF517dvRfAIkFI6KevwpMp47juO3e4zpVoUIzF0f8TcJIH1rdUP
 IKX3O1ukf+CCC1Do6/0kDz88rr0i6hOSUtWBK5G3hr+8LWSLfIOW1x/Cg5NjmdiNbMxW
 OtsPvlyeNBWy25+NKhnYO/nUc2XUkE/j7rNjT/NAiP4RbAGFrNSuYJ22pJbAn6IrXPzb
 UnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730644467; x=1731249267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQqur4ICLRRHD8Fc52q1dC6WTnMWn9RJygPTgDiWU8I=;
 b=WwlsmBIXPzJdVYL97517FrztQRx/ImwiBugyGMmPQJRY164XN2fbUqVP8WRLxG/Dbq
 yHULaHbn1HNoE4Ih02pT4epzmmFtsCrHTsFLC6px/BqJ6iHNU5fS49po9DgsFH5Jh4de
 DCuWZlk+GLVzZMX3ePiDavgOmPd6y3U0cJa0xvk1zzNH4HUvz8OgyrE7EndOi0ue1Nms
 TCXDPnNTaetvaGqXiQhZHkBTktBBVVZJtCwJHaQxwbpcjzp1o6yqvuluEwYtCX+s1Ajn
 v+XKM77z+6KP5oK/gdnDOUA0mGl3Q/IADgW6QQDer0QurMhEZCr8MNlTCMQUZfkPvj0c
 epDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4mZjY8CZlwI6UzZeNCyINIlDp9sGwi2eR+MRXeH9AJI2fO3MmvgzPcBCtT7MhgdcxBtjW5V4YQQ==@nongnu.org,
 AJvYcCVR1gzRgiRAtyFTWw+Y7ELARcm7w1gHqAFIMTFmuOSJT8/QqoBKo8hVq3GttJPxYHzvWIv9gtce85pA4fGg@nongnu.org
X-Gm-Message-State: AOJu0Yw/QmGrjbd7YykhgHvOG20rHGjg29icZ3QrL49htx3MSJRGLXaK
 tThLNaLABcIA0wHN/cMcMxydUrAXQfafqd7WMV4/lLyk80NYXciJjMWRsA==
X-Google-Smtp-Source: AGHT+IEnVh9PaahL0QIiANBx4wv0jvr0LzdLsXaHuQP9Aa50Y5IxO5U3TVqbLXn7SjxpjIzy94LWvg==
X-Received: by 2002:a05:6402:274b:b0:5ce:cffa:2ba9 with SMTP id
 4fb4d7f45d1cf-5cecffa2c90mr3010800a12.24.1730644467110; 
 Sun, 03 Nov 2024 06:34:27 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac74c667sm3350723a12.20.2024.11.03.06.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 06:34:26 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/4] hw/watchdog/wdt_imx2: Remove redundant assignment
Date: Sun,  3 Nov 2024 15:33:29 +0100
Message-ID: <20241103143330.123596-4-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103143330.123596-1-shentey@gmail.com>
References: <20241103143330.123596-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The same statement is executed unconditionally right before the if statement.

Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index be63d421da..8162d58afa 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -39,7 +39,6 @@ static void imx2_wdt_expired(void *opaque)
 
     /* Perform watchdog action if watchdog is enabled */
     if (s->wcr & IMX2_WDT_WCR_WDE) {
-        s->wrsr = IMX2_WDT_WRSR_TOUT;
         watchdog_perform_action();
     }
 }
-- 
2.47.0


