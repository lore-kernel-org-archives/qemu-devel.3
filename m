Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD01BC54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Is-000388-Q7; Sat, 09 Mar 2024 14:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Iq-0002wW-OW
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:16 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Ig-0002hZ-4y
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:16 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so503132666b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012244; x=1710617044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5JHLoxMjL6tDi9iKJsLNg13AWr77+ZJm44MiLunTng=;
 b=MmdwC1MMKT6KDmA3Pn+r4RpSuGSI8C7+rM0SgtGR6cwGOvYgZp2MR4UDT/QG/v19mx
 3NNYJGQCskDz9cjNexhPl2ZbKvYMocnryyygfxtR7gYNLSgMICUk3DsvaOd5V4uoIPwD
 tNAUTcC+OzYhaDoVAOqQ1SH+A4TVqfVS4p96/Vr/ubemvSo6I34WHnJkbmPLNy5vNMf4
 xyZ1ImbyBR/ZN5o0YQeAaMgVvcWOWQhGmwM1IeWh4QCo2/XuvI5pI5f9enyDThF9E7TQ
 uagd9fxoRwoGigd2tDvmwMPBVr8/jeW/3cwXes9XLugzwajlR4o0+ibNl8DxXz7LX17a
 DMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012244; x=1710617044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5JHLoxMjL6tDi9iKJsLNg13AWr77+ZJm44MiLunTng=;
 b=bzFeU5/ZBnjEfqQBWdbEf984Lsr6vfP4oVyF1HLaI7RqjyJiL8RkIkSLew3GlLyJX8
 Va+mVysWQrymEJ4X1X4sWBtMJ/R+Me9h7TNyf7S66q0mVkngF11TXNDQ17yYW27NrNnw
 5W4XNcEyI1tqCxp+EL847qJvVKFp6WPCwi2rqWFij3IMIM0S4BBbG4vSeMTiiFHu7Rb+
 3B7MwwbbBeDtKtRJqM3uB/ONUIfGFwsiF8aKKefyni9w80SGxCv88xLy59LACpZPuTbb
 xlndcHJzN3iDoAkfek+NZvAvV2CQCor3XT4uPSUmVXVXQyMQFzLIWhxHVz3J2PIyNdiO
 jqFg==
X-Gm-Message-State: AOJu0YwUdgZpRSDNVCNAyjQCamRvwndPrZnqWXhigBULKe7x/xdWAN8J
 e4hinR83IzNJn8r6AkisYuxtDUVaEt8WohsjQZO7jDw0uEMuEvs7oTRqZPpAY8qcSHY3xCOtlXT
 K
X-Google-Smtp-Source: AGHT+IEXrInFPh+kH3SDE3Bme3IOcnebaToNGDjHAkJEJb0gjDW/apXugYdiDV8CxRddh/CblW6jVA==
X-Received: by 2002:a17:906:3984:b0:a44:1f3:e474 with SMTP id
 h4-20020a170906398400b00a4401f3e474mr1261620eje.23.1710012244545; 
 Sat, 09 Mar 2024 11:24:04 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a1709067c9600b00a45a72fadfcsm1180096ejo.23.2024.03.09.11.24.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PULL 18/43] target/i386/sev: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Sat,  9 Mar 2024 20:21:45 +0100
Message-ID: <20240309192213.23420-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is the pointer of
error_fatal, the user can't see this additional information, because
exit() happens in error_setg earlier than information is added [1].

The sev_inject_launch_secret() passes @errp to error_prepend(), and as
an APIs defined in target/i386/sev.h, it is necessary to protect its
@errp with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240229143914.1977550-17-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 173de91afe..72930ff0dc 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1044,6 +1044,7 @@ sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
 int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
                              uint64_t gpa, Error **errp)
 {
+    ERRP_GUARD();
     struct kvm_sev_launch_secret input;
     g_autofree guchar *data = NULL, *hdr = NULL;
     int error, ret = 1;
-- 
2.41.0


