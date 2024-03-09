Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF934C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2IT-0001kb-79; Sat, 09 Mar 2024 14:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IS-0001dB-0l
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:52 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IO-0002e8-TJ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:51 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so410841866b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012226; x=1710617026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjbUGqOjGDJ48BD/FCrBKjFot720kk8N7cpG04DHyuw=;
 b=cEFkM32oD0RRrFmm3ezWC4f/6Ro69Bk3Y2eijHCMbyThd3+mkkvOuxCUxwy+uPWwsW
 swfgcQA4cY4aHghj5zdS1EgxqQLf3Au0sZuadPK+LldR1Df4up2bnlKloPS9XoSy6CJQ
 Vlw0L7J3PdqRE5wj2zNX8NTxLbwmuhLGSRt8vR5wdCgi+3GsENyRQB+lZRecDNjvTLvC
 8asWNO2CUvVTew0msoj7d7d/cwZwabrIbe/xU0hA5BaNU568f6bznJy8YWbNuK20KnOj
 9YVFm4DyLcJ22JxDWMj8v87AMsqdQnvNjAYgP16wi1oKvjh9tLG0KOJS8uK7jfMeNlib
 FZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012227; x=1710617027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjbUGqOjGDJ48BD/FCrBKjFot720kk8N7cpG04DHyuw=;
 b=pF4kWPCRTuRUV6YfQpJ5AcXIKQcY+1PaRao6z4d+sq8k1q2tdSrL5mW2hxThn7i0iv
 5von888oANDKTgX6c2/yAE6WZhRHrlWJb+JVYMaGkkn7kNBUVRTBc7Z4FzWe0jxbvqyI
 M2+1O2kHVbtLNc83Yvo+tUcj1atLsLYtI9jcsFtGlVj9lVynMXnEGX5rZkkWRmOO7mju
 cBHxqmH4uxXpGwKjgUWOtPuk0QL978V67V4f/908j49Uc5GPjVUmRBgSziy+VoJSUgqR
 kFi6jvXs/qyiiUIkDHYDoSXmIcujw/NUEGlmEdRPZ7tPQd98WsiT7JWkRdkxXpXtU/pc
 MfOQ==
X-Gm-Message-State: AOJu0Yww1cvlLX6gh7r6K1M6kHb1TukU0BFFCoQ0lgXoxf/IKVdblT+l
 fyYFoWqA6UmhjxJ02Rr9LjxYZGc21QbkwvvZWBaw6K21l83dnIiXLJSmTBAE3FbZ/wyZ++FSYq/
 l
X-Google-Smtp-Source: AGHT+IHsirtIOeTRkWpIs3e5yCTD71AujDzccS4QPk7Rv1bmDdnDigFagjmowzpwOIomavcvEpokKQ==
X-Received: by 2002:a17:906:b0d0:b0:a44:8c1b:8877 with SMTP id
 bk16-20020a170906b0d000b00a448c1b8877mr1523044ejb.50.1710012226664; 
 Sat, 09 Mar 2024 11:23:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 lt10-20020a170906fa8a00b00a45ab830eabsm1179687ejb.51.2024.03.09.11.23.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org
Subject: [PULL 15/43] hw/char/xen_console: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Sat,  9 Mar 2024 20:21:42 +0100
Message-ID: <20240309192213.23420-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The xen_console_connect() passes @errp to error_prepend() without
ERRP_GUARD().

There're 2 places will call xen_console_connect():
 - xen_console_realize(): the @errp is from DeviceClass.realize()'s
			  parameter.
 - xen_console_frontend_changed(): the @errp points its caller's
                                   @local_err.

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of xen_console_connect().

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20240228163723.1775791-15-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xen_console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 5cbee2f184..683c92aca1 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -206,6 +206,7 @@ static bool con_event(void *_xendev)
 
 static bool xen_console_connect(XenDevice *xendev, Error **errp)
 {
+    ERRP_GUARD();
     XenConsole *con = XEN_CONSOLE_DEVICE(xendev);
     unsigned int port, limit;
 
-- 
2.41.0


