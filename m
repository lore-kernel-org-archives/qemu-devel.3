Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CE7EE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqim-0007Tx-Lj; Wed, 31 Dec 2025 02:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqim-0007TW-2O
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:16 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqik-0001A6-GX
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:15 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so4754321b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166453; x=1767771253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWGWE4Bxa3lEYhB70C/OA4M6WCFI551z6buXxUEvQJY=;
 b=pxtW75eMpa0XVCS8qg1z6b3Kz23kZ6iXHH2q70pO6vjNfb6vUKazSS2YZFe2wyN1GQ
 jo+2/nVuBukc6+DlTkiTotp+dZodG6qzYEt6q7Rd6ESIdfofaz6kUrwY8maPfIXSBruI
 HxkRwaJ4s1zrXuiTIVvxjJl6mhURkRM+FdzPQlxV8K06d4dou4BflaR+Yv4rLdsZo4iU
 9NSXQuJnO6KH90oy3a98iMo2nRq9vGYZxo96Mm/sQ2wGLZZ4vHQBaHlLQI4lsMF5nl6f
 oYGM76ZNBxhTEeeuWeca82xK5C0aZlnEVDNZ1vG+8A2urYlYyWTEZrHW3aStN0gg7aac
 qjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166453; x=1767771253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RWGWE4Bxa3lEYhB70C/OA4M6WCFI551z6buXxUEvQJY=;
 b=VUsvAIfN6MTBEH7dU99xMtGTPaxR3klJkEcRqsORZbC1P1PC1rHqnkX7fVLteySyWa
 Y207TEOM8RE3jaQhDxe5Nfu+Lt30rIDh2JaP+PPmiABr8r1Jr9ZT1zYDPpT7F4vtSPGI
 jSUxdErmpwOETMQNn5q3JsQ1SfDNDA3zMoaNEiliSp0vzmG8twoBQqWdw2R7fPfMTuQt
 tq8D9Qocl+Z6xMfcahbCQt27n85P0cw/6h7Py1G8bcMxjwUDPDmcWbWrOFQyLio5s03p
 FA9VCaNqvjorxmei/sm4jga1ie3wuXq3TYZJ5Ypcei4wu4zEEpo/FaUFLezFoo1BB52w
 WXug==
X-Gm-Message-State: AOJu0YzC3jzAQfNBN992xKIj6UeLtDD/4ium4t22LSMGS6yvNhzEBG0T
 /yOoaVZ6D0wwYtiBbSCnH8HjAi1kj0YvS54tLg8IPszBjg9rt3iAIy5oU3Bqvx/fbvM2AW5uoDg
 gLcDy
X-Gm-Gg: AY/fxX6FwFoTy5N1ySPyk1QlRxxWaHjeM8BCKEKjMyfkMYs8wnn4ILdH7pAwNIM5Fy/
 NOT3kZGfps6R427hCFdn+uwZ/5mECSvWOM3HwnofgOUG12quXmbIiwZiWav2lo5pX+3D2gzIT72
 rtbNUwnlcbiCB11z+dUevjel+zHuIrwQ/RdIyv1nj3MSDE6B0gh9OV/Zngewq0ZUKk8M0Q0yEDY
 dOnZyo2JZnMzeTf2GsO3xO3ujNPR1KOpELNZfVhcnOKyPhkK30nEepHT+yxtKmpGZsiVS+xWP2M
 BRMyutWnN3OoU0ybFKv3Q+f/NuPyZMoeQunIy3l+Ha4CxzM7sAOm51iWKFUquyDqsDCxjToDUoe
 cjuLaJ11jDcLDIv0b/lPSQ+8sVl3P1p2rhmd+4X+xjywQxFpBntUWDhW+Yk0wTDN0hOOC3wkDgL
 Tp/BLe//AYaSTMgpTzZlNF/o1jwxKVz6s1n+e2VE4kdwwfSoz+pkJFt8jEY4lkD5D6
X-Google-Smtp-Source: AGHT+IEcHV+01P6dEU2BOzXLglU0iSiESN18oqQZl3UaCqlszfR2qYtOALS5gArj0J80WqVxGO6Yow==
X-Received: by 2002:a05:6a00:340b:b0:7e8:43f5:bd4b with SMTP id
 d2e1a72fcca58-7ff6725a0a3mr30428933b3a.55.1767166452989; 
 Tue, 30 Dec 2025 23:34:12 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/11] plugins: use complete filename for defining plugins
 sources
Date: Tue, 30 Dec 2025 23:33:53 -0800
Message-ID: <20251231073401.2097765-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 12 ++++++------
 tests/tcg/plugins/meson.build |  9 ++++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 8f9f0257ee5..3d2d7862e0c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,16 +1,16 @@
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
-                      dependencies: plugins_deps)
+    t += shared_module(fs.stem(i), files(i),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c58f2e382ae..303f97f9679 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,8 +1,11 @@
+test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
+                'reset.c', 'syscall.c', 'patch.c']
+
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    t += shared_module(i, files(i + '.c'),
-                      dependencies: plugins_deps)
+  foreach i : test_plugins
+    t += shared_module(fs.stem(i), files(i),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


