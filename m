Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948EBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcc1-0006Qi-Cp; Tue, 16 Jul 2024 03:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbz-0006I0-BF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:35 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbx-0006Xy-0b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:35 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-704156d0e0dso2739194a34.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114912; x=1721719712;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DgK+8Ab0My7nZ1jTou6SSJrbwenaRoM5fcR5nlg4MS0=;
 b=1FMd6PeQeNKrl5qqpkI67ydyKuD+WJbzGn2zHz+l25pAN3NgSiL/DbLKxgYFFT0BJi
 0t63+dogfzW9oZyV3iIC89BzS0xFbKTqmorHPy/pxQIdBYXxtTamzQTE4YrY4z56rMLe
 J3a97zyRJw4+o+fErB3BDomYbEMowODcUr6eZNpZpeoWa02BQr2xRLHrCcrQadqB1CRf
 gNWe7NJbO7cTpDL1jSdWiYioZATDNXp8CefXF7+nXDJB1HsSF/zpimMuryP1UEBBew/F
 zf9rgp301hXJSKaDCjwqY+ehfAz+mO3d+ClgEFwe7KkjrtUdQ/WUqwk3RiCov0qk4CHW
 we/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114912; x=1721719712;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgK+8Ab0My7nZ1jTou6SSJrbwenaRoM5fcR5nlg4MS0=;
 b=wnNbjTZ3AQwRDLBPdAlu9V+s3qftdMIPFMGDynXwRBwkVww7IAt1B6mjE7VeFI55vh
 sjdetUdasH6F3yyUj93tujPrz33cdbrdPcFuuWUBa7kgw851BIv3HwC+uL/XFTRoIUS/
 UX2BoZcewlsl2ENJC8r5fwKmEGKjUuiTYeF7Bq7s5nK6XKlTrKvmRilIS7ieZstcqxqF
 L9AtzCrMjWygsybcdhe/DPAcDoKgVpISxiI1ycYKtv9H7ba7Alix5S7A78PEJFfZXPwb
 oj9iITfqG9YeKZ5nLjXN7Q+RjVRqi0JIfMX464J61etBiRdbwtIviwncnv6bYa04gPZV
 XZ+g==
X-Gm-Message-State: AOJu0Yz8RRvZvJH0FuoBruKSerlOtf8vMSy/gsnPv2DEqypnLdMt0rw4
 SjBiFhHysX3K2BIQDaXJZC1UC6BvVhMNgm4INhMC7vpJyH2TOKWxZFzUy3uAYOM=
X-Google-Smtp-Source: AGHT+IGB8zQ/FUrAaZCwGH4mmwPrK3IkiI9TIQiLOyTf/QokXdHbW+L25GnXfVqtiak8fNaYte6LXA==
X-Received: by 2002:a05:6830:929:b0:703:6aa3:d091 with SMTP id
 46e09a7af769-708d99609a3mr1848889a34.2.1721114911857; 
 Tue, 16 Jul 2024 00:28:31 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e3485dcc7sm4400161a12.39.2024.07.16.00.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:37 +0900
Subject: [PATCH v4 7/7] spice-app: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-7-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x330.google.com
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

qemu_get_runtime_dir() provides QEMU-specific fallback of runtime
directory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-9-akihiko.odaki@daynix.com>
---
 ui/spice-app.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index a10b4a58fe74..bbe17358c8d4 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -151,8 +151,8 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     atexit(spice_app_atexit);
 
     if (qemu_name) {
-        app_dir = g_build_filename(g_get_user_runtime_dir(),
-                                   "qemu", qemu_name, NULL);
+        g_autofree char *run = qemu_get_runtime_dir();
+        app_dir = g_build_filename(run, "qemu", qemu_name, NULL);
         if (g_mkdir_with_parents(app_dir, S_IRWXU) < -1) {
             error_report("Failed to create directory %s: %s",
                          app_dir, strerror(errno));

-- 
2.45.2


