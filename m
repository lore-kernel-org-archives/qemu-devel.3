Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F3C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLg-00045M-C6; Thu, 16 Jan 2025 11:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL2-0003WE-CH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:20 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKw-0001Et-30
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:20 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so681030f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043392; x=1737648192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhwKvA93ejBJ40tAMFljSMFt/CmKzPuSCWuyLymZVmI=;
 b=uSkP9TjKXfJqoxKvzG6YsERo4txhPnOTPC+XAvRL5hfDDXzQQ6WBdMQPhoata5ioMy
 3OKaT8u4+aC1YD5gUlDiAKwy9+btW/wUmvr3KedV2EO3y6KwqIjuLiNq9f+QQ0syREu6
 8Z7HekoHs+WbdqmyGBvk1rTx19Hhw2q5Rl54MGxeDFVgfpPTWzuaNWUzqNIhIC7BwryL
 YiKemPnKL9dbbZSD7bvBn3r8NW+vbf9kwV6/9FIvrwXx6HzrHVcYRCLxtm4nuOyB/kZE
 cpIWv1C+nxJ6rn/aE++/AOw1G6fE75MxnY7iITeZ6sH/WY55onXCaXQ+jJCCN2DVyOrG
 kDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043392; x=1737648192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhwKvA93ejBJ40tAMFljSMFt/CmKzPuSCWuyLymZVmI=;
 b=FWEbOi4H0arJ70BqeTwvtAOoVgQHxSyhbw/neFOpURQa/RUmvEyFZwp5nafe3p5IKr
 Fio11qkngLbK8eIjBD43f5AcM6qHKkOJ1IJsC2hz8Vf0ODKVTUoghcP0/a4bfxAKcdL7
 xqCWDHssZZcNdXF0PSDmZM3OW1F+olDH4BH2BwqRuwS83xgKytGRIUhH5Bydly+sOVoL
 MaSp9sGZIMNCSnAANmgP/WhYoWk0yEzpR/1A1IQhtxqep299iaAZjpJLOVFjRjEpk8HB
 hs4lL/Dw0NbWyUp7qmicbyEdHNLIYeidZewKRDa/Uo58BmcGwW3JPsXIrdAjvBawKj94
 TmBw==
X-Gm-Message-State: AOJu0YwMXCHHWKAUb3Bh0u/dhqA28DyRTj7JWi4+J+kdSw7MB3XFl+iC
 tS4jPtIbvsHg9QnFrqMO4NwmDJKW1gVs6L2aF3Ye+arMI2NpGZQ5Qx27N/P4G9g=
X-Gm-Gg: ASbGncuIjBBwwVlD3acJjXaQ8qv+arStI9NmY0+8aahU4NIPPAIbyHEjeA4G/+bJ/k+
 ZVDVDt8N11+dB09vavL2wi7aUqZSBRdzcdJfQjUBY2ZWb8rseVy72y9heDFhrT+cUSl5jIZbrGE
 jqPnZ0mZdEhOTspZeAGRfR7+qW4QR0rgmqYJQQUSHkKdyFgtccfTGW7bXQ+IIH+jQBH70YgRRkv
 PN46zO1dyawmgGLBl2kuHXiGmciX50jDtxEcfm0d4/zTSRWneqmYnU=
X-Google-Smtp-Source: AGHT+IEexRp8/BKveDXaMvhxTCD4HM6D/TXPum//8qDbUNzo/BIZYynsN//UHLhqqaVxBsrabAcHgw==
X-Received: by 2002:a05:6000:156a:b0:38b:e26d:ea0b with SMTP id
 ffacd0b85a97d-38be26dea6dmr11873885f8f.25.1737043392199; 
 Thu, 16 Jan 2025 08:03:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3278f06sm200649f8f.70.2025.01.16.08.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 461816086B;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
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
Subject: [PATCH v3 09/37] system: squash usb_parse into a single function
Date: Thu, 16 Jan 2025 16:02:38 +0000
Message-Id: <20250116160306.1709518-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We don't need to wrap usb_device_add as usb_parse is already gated
with an if (machine_usb(current_machine)) check. Instead just assert
and directly fail if usbdevice_create returns NULL.

Message-Id: <20250109170619.2271193-10-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/vl.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 22c1444da4..02795c5135 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -811,31 +811,17 @@ static void configure_msg(QemuOpts *opts)
 /***********************************************************/
 /* USB devices */
 
-static int usb_device_add(const char *devname)
+static int usb_parse(const char *cmdline)
 {
-    USBDevice *dev = NULL;
+    g_assert(machine_usb(current_machine));
 
-    if (!machine_usb(current_machine)) {
+    if (!usbdevice_create(cmdline)) {
+        error_report("could not add USB device '%s'", cmdline);
         return -1;
     }
-
-    dev = usbdevice_create(devname);
-    if (!dev)
-        return -1;
-
     return 0;
 }
 
-static int usb_parse(const char *cmdline)
-{
-    int r;
-    r = usb_device_add(cmdline);
-    if (r < 0) {
-        error_report("could not add USB device '%s'", cmdline);
-    }
-    return r;
-}
-
 /***********************************************************/
 /* machine registration */
 
-- 
2.39.5


