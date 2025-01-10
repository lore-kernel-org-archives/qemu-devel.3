Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2C9E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWF0b-00024e-Hy; Fri, 10 Jan 2025 08:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz7-0008OJ-Nx
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz4-0005dW-8s
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:33 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67333f7d2so318370466b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515408; x=1737120208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zvC2v/Z6LchXqkhZz4BfmlqHg7jDvrODLCcjeSGZBI=;
 b=atfixG5s6vMzFbHYtQKYvsYeeE2qOwDh89asFdU1BAXJRIWJzZIVQSuw11s44U8xuQ
 IkofD3iBwtY1YJm3YH14O3tCQ9MuyiuLkNNd+bvBeMYruK9Mzbm9XuDxvtZLzeQYcNx6
 ie5781M10HeTiJY711UKj4hRktGJcDOLTKWNE+jr8kC5BZx0m6dn4blMCngS74EDK6az
 /ROt/9hOEwYJjaYjTPC8edHCdSpGrIKVBS6Ly0aR3M5Cq4hBsr5Zn1PLTHF0KPr0gfBT
 9Y/wy/BiTE6e1OUb9vXvmb02+Z96jTVIm+ZkhNjoLURQCOiJR3c/B0Em+rwV3AJbjK6X
 1yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515408; x=1737120208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zvC2v/Z6LchXqkhZz4BfmlqHg7jDvrODLCcjeSGZBI=;
 b=YL4f2tfUdmLuPWKCPcSaDsU/N7fvtFjpl+EdHqcrd/pWOoBn8x0h4i4NIKLmUVGO7o
 nr9B72aTXBOqm3nwivkUIhA7I6Rwie54EO/nfFoex9YTwRnVaGWVQbSetiJrhNeoC0yj
 dao0YYWhROgSYBvxJDOruhd+sugUkE0i1YB6jglTK1VuL+NVpbUfNYv3K5wB5DYhbNnD
 RBgd7UWxncgxVTyOH+iLTNKTtc/jjZofbUNSvNpOODAN9x2ul/wY0xNGUkOB12V4DJ6e
 az3o4pTEnlKmH+9bLKe0oASWgjrKsLFsCp7sNomG1OuEn7r2GvArg9fGFwkobFiPMbX2
 ZDKg==
X-Gm-Message-State: AOJu0Yyn/xrXceivw8lZUu/S0facTV/P6+eY7V3yqFxKSx79rQXIhZWD
 aq4cGz2xmrZ8VpsjWrehSnPXRJ17tAudx+cOa41KCbTZdzMc7RX7UeYe2UXCy3c=
X-Gm-Gg: ASbGncvVJW4/yTKO4jSth2fl6nZ2Jfz+qhfvJNd1Z2/2Ni0vJjK4zbJrDx/21FsfJ1y
 /hHLNU1NRmulFj/TaOCRk22v5M3tKu78XEAGqlSOGg6v5hvQ3jHAob8ePVTZA0jVODXL8boTOeZ
 j6SephkPquVf3ti/tLIrrwCThM5OiQ4G2Iy+lTzBhbdbZGNtJl0SzUUCLM4ad4aWc+SrMD+lLGv
 M1XdvvZTyOH9WyzEVpvWlC1ZntIn9KZxBLzd4fh5lHcZF79XP0oeUQ=
X-Google-Smtp-Source: AGHT+IH4xDlBmwBIoKdSTwYRVcqlK+ySzVVE0FNx3OLXNMv7ITzgAzXcGCmKqh23KnnS3/FFZsNGsQ==
X-Received: by 2002:a17:907:9622:b0:aa5:4982:abc8 with SMTP id
 a640c23a62f3a-ab2ab70b387mr881246966b.22.1736515407831; 
 Fri, 10 Jan 2025 05:23:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b1d53sm164082066b.152.2025.01.10.05.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C93F461866;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 30/32] pc-bios: ensure keymaps dependencies set vnc tests
Date: Fri, 10 Jan 2025 13:17:52 +0000
Message-Id: <20250110131754.2769814-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

I was seeing failures on vnc-display-test on FreeBSD:

  make vm-build-freebsd V=1 TARGET_LIST=aarch64-softmmu BUILD_TARGET=check-qtest QEMU_LOCAL=1 DEBUG=1

Leads to:

  qemu-system-aarch64: -vnc none: could not read keymap file: 'en-us'
  Broken pipe
  ../src/tests/qtest/libqtest.c:196: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

which was as far as I could tell because we don't populate the
$BLD/pc-bios/keymaps (although scripts/symlink-install-tree.py
attempts to symlink qemu-bundle/usr/local/share/qemu/keymaps/ to that
dir).

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-31-alex.bennee@linaro.org>

diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index 0bd8ce0077..a79a09b276 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -39,19 +39,18 @@ else
   native_qemu_keymap = qemu_keymap
 endif
 
+keymap_targets = []
 if native_qemu_keymap.found()
-  t = []
   foreach km, args: keymaps
     # generate with qemu-kvm
-    t += custom_target(km,
-                       build_by_default: true,
-                       output: km,
-                       command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
-                       install: have_system,
-                       install_dir: qemu_datadir / 'keymaps')
+    keymap_targets += custom_target(km,
+                                    build_by_default: true,
+                                    output: km,
+                                    command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
+                                    install: have_system,
+                                    install_dir: qemu_datadir / 'keymaps')
   endforeach
-
-  alias_target('update-keymaps', t)
+  alias_target('update-keymaps', keymap_targets)
 else
   install_data(keymaps.keys(), install_dir: qemu_datadir / 'keymaps')
 endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c5..f75c1057a4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -383,7 +383,7 @@ qtests = {
 if vnc.found()
   gvnc = dependency('gvnc-1.0', method: 'pkg-config', required: false)
   if gvnc.found()
-    qtests += {'vnc-display-test': [gvnc]}
+    qtests += {'vnc-display-test': [gvnc, keymap_targets]}
     qtests_generic += [ 'vnc-display-test' ]
   endif
 endif
-- 
2.39.5


