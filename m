Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4440E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzf-0004lC-Fh; Thu, 09 Jan 2025 12:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzU-0004iF-FZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:41 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzR-0006zn-Sp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:40 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso1221374e87.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442396; x=1737047196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25f+kPpL70YFXNAUtEYMY9S3pngwqu7v/kUd281l17o=;
 b=AaDDNfhq2GJblNOZTwu9syDqYPi6m+rbbpfp+M+VJ5x7XBh15wf7KUJCTUHtTGlW9Y
 hMeZjc+WfBauVfoxc1PQPJYTMiLfdJE0JMIPe6zcpPzJYw6gf63NE0cj8sC0PRLCrpVE
 vn0XeMx9BruVbMUaFltvZi332vNUw01JZkwdnJnIlxco4MrmAbOAUIhBJYXraTcTvHWN
 bQZR0jzbyYvuqSAtvpmGTH9fm9KcRiE4xlPyKD8h1/xUapGQ4dwq8V1wxu9/cn5GccmZ
 hscAgjvndGy+eMFbzZgMpm+aUw8aHVXE2VCaUya910gGDeIFaJSaJXBaH4YCtrdPISNq
 pCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442396; x=1737047196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25f+kPpL70YFXNAUtEYMY9S3pngwqu7v/kUd281l17o=;
 b=RClLXqoZ/TCFQhdDOP56yX91B0DFXCGzF5w4zNP9SeswvBSihGu6XdLT7kxRbdefrT
 QbPo9yi/2rBgYzKvvnVOPEZW6wVcmFXEj7PAVeLkbNQj6W+MKy5h1//2oWSiQpVy53Cs
 QdiTLZehLONrxFYwZcFiubyyseH0v85lH7CwNdUW5qaIPPcr97Xa6ExtHktCsAZsDSyO
 6OTxMbH8TkAtPzGIMyOAQ5GHrPfY9APHXl++6npwDAEGbaIdMtqpUuX57jhB0cNYMm/t
 w8UiR4yKVabyp+XnOf+3v3WdpnL9JL9arHxWf2nAxnr0+eRvguuGehXtwwr8nWHvKWS7
 +HNg==
X-Gm-Message-State: AOJu0Yz+DL4hVrbp1IE7wYRcXC64uR872SqcjRO/guGHvb6iB9dI4zlX
 i2+c/Vz/Ab2FEI4lGaYLlNhiKSSvmrLqz1J6CYPvq1mqTIJpi6QzEqqsyXv1ML0=
X-Gm-Gg: ASbGncsk22KqZly6YeC1XMkHlEz72sB+YlTOuAwskYoyBRTua2kz5j5fg+f8wfly7Yx
 ScwSihBqzMIxxcbf/YUwfXRwVx1vTrKa94eaZXQpuLwP0zy9kaC6C9yRerDeiygkiLqLvjSrNEL
 ZLR1KdF3YsqnYRtTVimvti2SN3fUjYNrlqgUGQWclA4dlZPKt9pBjpVI94ItnuzcWMOECc37vxi
 yTNfgYeFe2GXAT8Oa3ZH2yo8Mb9bPZCm8UtM+Ty5i0VzFU/fTfM2B4=
X-Google-Smtp-Source: AGHT+IF/FcZ+Peani/3QhONnGIVKvQw1wp5QBArGrfTBYjQ+54dkneHTmzNTuNdVwey5+3IjaN5MIw==
X-Received: by 2002:a05:6512:2399:b0:540:1ea7:44db with SMTP id
 2adb3069b0e04-542845b1aedmr2713250e87.4.1736442395726; 
 Thu, 09 Jan 2025 09:06:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9562583sm87989566b.110.2025.01.09.09.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A06125FB65;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/22] system: squash usb_parse into a single function
Date: Thu,  9 Jan 2025 17:06:06 +0000
Message-Id: <20250109170619.2271193-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/vl.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 25d9968ccc..df59cff865 100644
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


