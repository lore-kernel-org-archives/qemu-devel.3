Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC09C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2kV-0002qG-HF; Mon, 03 Mar 2025 05:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1tp2k0-0002W0-NR
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:09:44 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1tp2jy-0003Mr-II
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:09:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390ec7c2d40so2650224f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1740996575; x=1741601375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VB4EA+GoraG4SscM9ds2AMb9vPcxtM1/M9OFPAdl16Q=;
 b=Mr9I+pm9XDWYlVum8rqbss3fTUAWSKD0x/vGwRX5rpZV3E5SqT7GPc0a+aO8vu4HeU
 pOSq+5e5SqmUT4vwVNCZMRjCdM2R3QEVaYi7LRPL9cCXFE71CoiAf0GQh9aKKyjhs+cZ
 gCihLFU63vlI9dG0oC8SQxPxXykqFXnOW+I+oTEpXIqBjysFX8c9MwtraJV4ZzISkIW8
 hq3IIt4gTBCDdbcKgNg4bmSu3vZfhcMBxgVD+9WcJOnFFa2VxMvlXiE+2Tui0FFRNo9g
 jBQ0uCHDMaSxKZ76e473BJ9ajMNNY+pApJd2lz/wGboZXwwcNXIOh1CgCmjjXFtIOp8m
 sCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996575; x=1741601375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VB4EA+GoraG4SscM9ds2AMb9vPcxtM1/M9OFPAdl16Q=;
 b=K4/ZJZLwV7a+VfblAXgcWoT1+CA44559vEyWO+7GUWSPTTmq2mjPpVz01whE30reqB
 Pp3pybzHnw3j37ni3RlLvnshwtaopJZQGBWNUVFNmumTSHLCYOt87+NtwKZ4N2rY+z1s
 MG/lAcBDKERXnsZ9VAbTlOyyUt38DTVQvMMOI2n52EtnOLKLewE76BowMeySBj3wLTQB
 USFZhWaJIT5XOYMUMVaEFMRexyZCl5vabyxxAKoMMVYTvCgQ3vrFQIFzeyixsfSRsZCr
 7UipE+bVjE9V3YPorCaJrx2KWn3U5KPu1qZVbIOwLA+hpuhxWZHCzQZ1TBJypKXQFeV7
 3B3g==
X-Gm-Message-State: AOJu0YxZRq8NGvKa5gBmyl2tvZ/KfNoQ9oczqGcs3FUmwM95cG36w9de
 taeh7rQBKrZEhRDBqJM2xnOGQma1LmZNg9tDcUygLiL59lFEzbvWjQeFEmPSedSCv3gGn+QmfXl
 C
X-Gm-Gg: ASbGncvAsQiK4Y0MxQORpBdsQXjKV4gHrv97dVXW2KgZf0OIux9Yr5rFHxy6EP/CWCK
 Gl4fcNDZ8qisqCGgjYY5xBYkrT9kU3HxUFFdWq/41E9qb/3VEf8+zTHN5yTivT38U2VuETDYuUY
 Wazm8QK9wghWy9P6J/QP5qpiKSQku2oC+L8ubWR77vb7AFVs0Mbtktn9rHe75WcMnPjrNsYphkv
 dD7uFGM8Bffo/Zz2rmIhcf0yyBOrkDhlTTdJQUNWPhmMKnhI9U0q7sMwlPxIjVdpUWTfARfvJCu
 PBaF2RdM9YTdsCk/knxrkU9+x6SSjwQ9rFjklBkv2QvHr3qf/pSWUwmOSzVodIS47aTa1Y9Qcim
 1m0TKfGKlwHkNzuvC8qCgqlfSrVHP0g==
X-Google-Smtp-Source: AGHT+IFYIjbu4uFelcFuT7RF0uWDEWga7nmqfjSVbcs6aD4VhPzqARjsMDPCJRp7jymSV8EEa/EuEA==
X-Received: by 2002:a05:6000:156d:b0:390:e8e4:7e3e with SMTP id
 ffacd0b85a97d-390ec7c6065mr10196249f8f.6.1740996574862; 
 Mon, 03 Mar 2025 02:09:34 -0800 (PST)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7ddesm14130464f8f.57.2025.03.03.02.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:09:34 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Wang Pengcheng <wangpengcheng.pp@bytedance.com>,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH] contrib/plugins: Install plugins to moddir
Date: Mon,  3 Mar 2025 11:09:27 +0100
Message-ID: <20250303100927.3443321-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-wr1-x434.google.com
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

Currently the built plugins can only be found in the build directory.
This patch lists them as installable objects, which will be copied
into qemu_moddir with `make install`.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 contrib/plugins/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 82c97ca0f5..c25a1871b7 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -14,11 +14,15 @@ if get_option('plugins')
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
+                        dependencies: glib,
+                        install: true,
+                        install_dir: qemu_moddir)
     else
       t += shared_module(i, files(i + '.c'),
                         include_directories: '../../include/qemu',
-                        dependencies: glib)
+                        dependencies: glib,
+                        install: true,
+                        install_dir: qemu_moddir)
     endif
   endforeach
 endif
-- 
2.47.1


