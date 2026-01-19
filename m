Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240FD29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufK-0006n2-Fs; Mon, 19 Jan 2026 14:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufH-0006ll-7m
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:51 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufF-0001TY-KP
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:50 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so45089905ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849908; x=1769454708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEmhWV50Bdw75mIkmSTg87b5KWsClkrsHwxNSDCjPXY=;
 b=y8R47WsY1612kmWU6uRzHx3GV3pKQYhrEiymKTPEw3ZjQyq6sRj7zhzoaG3eNsjraH
 6V52XaCbTMaKnkf9jekQNIhov9j2i5kJ+YzGbmSXxgT7aanJpQOjQdn6J5+E7SMEsfE5
 VKrCqki2Oua3V4dQrG3GuKFx6TZ8v+3hdjPTMHvLunB067KlEcuvQUfh1ZERC/qa6jKl
 QPsc31mWE9bSM8bffZkPzQZpOwIEjMC6BfgAzW4bEwEGyGPJ0D5RCnkdmO6rY7iEdXhR
 e/iZFurhDc7i2iAkyvM8tDh1C18QEkQHAO15QFrA27s/9Msp5bSdCgbam8NIVQGwxiGT
 DOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849908; x=1769454708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEmhWV50Bdw75mIkmSTg87b5KWsClkrsHwxNSDCjPXY=;
 b=A7yV1LcOXTSvYlI94ibj/CChkkuwHBwYeXYF51PM+jxAe1t/tDgZ6itUqaLCgSjyef
 BZWY4tIJZCGS3Np/RLlB+rBnQXMrQXmJjr6K1VyuI5bHFfDlYixj8Xydz0/liAxmEPPO
 73N1kxaHRvO0cgNn5n289Go3SMnZbKap8E8fhjwRH6jCgHtMhPMPb872iXFBLRQujNCI
 D95pGYY5xujRotGCwbZwKhtJ6TRMibP/8+STZAREUUwzZ+j5c4SlUGjcNzmN4fEn7L8W
 PNTJAksk/EMdwPsW3FxFcVG6tX69m1S3GDLIo6k/iINUbROH2DwuvTADWtdHrE4xkqFO
 M0IQ==
X-Gm-Message-State: AOJu0YzRidBrZqHQFri28MDRNA18Yk2P4QwxKA/ldB6sHrvdjkzUicvH
 0NQHPkarZ2Ru5Edh4riBdoNNAkdA91gIvXBxWGSO+LcIAANMV6jyHN6WEwPaUiHjEKML/XxFVB9
 ct7VI
X-Gm-Gg: AZuq6aJYH0uZE+nNKVYxHEb9rx4p7s/95AERv5eweeBtHly438e9CouCKDtSQKKQ91g
 xXIsJjX9njoQz+PyRsQX8r1OLr0uMCD5Y2MbstOZOr7u/HWsEwElvfOWsFZmQoAP/uwO/Soj1ho
 y74VtPNstL281r+NeqHdmDZ/AXPEPOEDslPVBzFCFfU72oaMItsBMeSS4ccZ4OwaLiXaZ1SEu7a
 3TzT66vU/9BGOsIDrI2WHxU6ENJwRrCVFnbJMdPie2zFWh6uQGGDuYF6NzCjd63SL7hoQr2Nvvr
 RM2++MaAlKkzL7hXj17mKL0a/+CqaphPiazwAHh9GnC7Mc9kxOWqAuq8CCvJTPbQQCpo5XUF2xt
 3KSvpr6FPjmfBFUF2ndxgDbkOF9tUccuHXgeaDLZo/I4C6hpGUijuoj/B2qU6LSvPBhXH7stIF4
 gu6PazDRwzQshtUCvgAjOoaXrJzxUveGPtJz5ZFG4TjLm568+zF8RJ0bpQjmuzPMyL
X-Received: by 2002:a17:903:1b0b:b0:2a5:8c1c:7451 with SMTP id
 d9443c01a7336-2a717808c8cmr124205795ad.58.1768849908129; 
 Mon, 19 Jan 2026 11:11:48 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 03/11] plugins: use complete filename for defining plugins
 sources
Date: Mon, 19 Jan 2026 11:11:29 -0800
Message-ID: <20260119191138.811069-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 10 +++++-----
 tests/tcg/plugins/meson.build |  7 +++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6915ffa5fbc..3d2d7862e0c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,15 +1,15 @@
-contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'traps', 'uftrace']
+contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
+                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
+                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
 if host_os != 'windows'
   # lockstep uses socket.h
-  contrib_plugins += 'lockstep'
+  contrib_plugins += 'lockstep.c'
 endif
 
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    t += shared_module(i, files(i + '.c'),
+    t += shared_module(fs.stem(i), files(i),
                        dependencies: plugins_deps)
   endforeach
 endif
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7823704616..303f97f9679 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,7 +1,10 @@
+test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
+                'reset.c', 'syscall.c', 'patch.c']
+
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    t += shared_module(i, files(i + '.c'),
+  foreach i : test_plugins
+    t += shared_module(fs.stem(i), files(i),
                        dependencies: plugins_deps)
   endforeach
 endif
-- 
2.47.3


