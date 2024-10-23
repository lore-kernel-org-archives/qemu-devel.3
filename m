Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACA0CFA47E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3iu3-0000np-OE; Wed, 23 Oct 2024 17:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3iu0-0000n1-Mz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:28:24 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3ity-0007cv-Sg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:28:24 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a4dacfda3eso1083595ab.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729718902; x=1730323702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlBPxw/KrsdqzVVePdKmZM4R4b6YL6msvYP62z27iUY=;
 b=xNqVJKpE1VuyB82Pw0udfAJbbS+CTUHPsVJdnkXRv38sbx/XnWpUVi68a6G/bkLgLp
 fToE6HGmD+KT53f3OVUdctobGIRYpVF76ZMLudqjyy4SHtuqCXSQ4c80PLdtLGgaA9x1
 nvu82y/E/2t1PiXfyYJYyO5M3G8HAqEpqk/Awlw06zC8cv0y1SLFisSfsKJ5Sywrdgjy
 IC/W9Mo0NCPeMziq9XQ7mDtUN1LeRQlW/xs7eOZl+zbduoKZjw9CudKjVruWoDkoeOUO
 CQCGUApS9kQbz9a/MSexvzhboQcktpHevd+FOiaDoTsA2/tHuTxs+DZOMpHyUbSnkIH0
 mACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729718902; x=1730323702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlBPxw/KrsdqzVVePdKmZM4R4b6YL6msvYP62z27iUY=;
 b=SQVWmQBqE4rsqiDdN4lxm5A/a65wxXei5XdW+4NRkvxK6loEJQWEpxdfk3Edn0vvbx
 I5GX1oK2af6RCoFnEUl9/OXd5CPK5baxzwKUrrN85WsJLo/jpYHWOo9eGRlSCwPy8c7B
 erLwdoFSEAKqeYEoocVLwCHZh3i5Qqjg6C1uuAe/tDqje41ULvsCnCz47Q9gjlHmlHlD
 R2N5zb2LnjaCMKqwRBHHc/oFrUZfTi006gncEKUgkh2osog9mfZyDULR0ztPOev+ILTY
 g+5hwjyFrd6gtyFs5CrZgyK384+wZiBtZE5ueJUVRsM8Ze/3T77GmQ2CeIr7uGyl7fQY
 pKPQ==
X-Gm-Message-State: AOJu0YyIEk41V1dBhH/ebcw7eoGnckxE+iJJEb0fZ3fbE9KW6+5y1sMD
 1aVDIHTleknmR48SC7KfuN/tllkcXqXwZ/J1NAwlB8TV+Tb+AXw5IGTiTb/40ZiP//LOPV2a8Tg
 6bcSs2A==
X-Google-Smtp-Source: AGHT+IFtStuVyRB27pK5J0eIsrodHevjtPaNOZ57Ia9cOZ8iSHPb9DUTY3eiP/pN7RRVfekVLuEQeA==
X-Received: by 2002:a05:6e02:164d:b0:3a0:9238:d38 with SMTP id
 e9e14a558f8ab-3a4d5961cccmr42474985ab.10.1729718901676; 
 Wed, 23 Oct 2024 14:28:21 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafab5esm7228137a12.17.2024.10.23.14.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 14:28:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 2/3] meson: build contrib/plugins with meson
Date: Wed, 23 Oct 2024 14:28:11 -0700
Message-Id: <20241023212812.1376972-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
References: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x12a.google.com
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

Tried to unify this meson.build with tests/tcg/plugins/meson.build but
the resulting modules are not output in the right directory.

Originally proposed by Anton Kochkov, thank you!

Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                 |  4 ++++
 contrib/plugins/meson.build | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 contrib/plugins/meson.build

diff --git a/meson.build b/meson.build
index bdd67a2d6d1..3ea03c451ba 100644
--- a/meson.build
+++ b/meson.build
@@ -3678,6 +3678,10 @@ subdir('accel')
 subdir('plugins')
 subdir('ebpf')
 
+if 'CONFIG_TCG' in config_all_accel
+  subdir('contrib/plugins')
+endif
+
 common_user_inc = []
 
 subdir('common-user')
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
new file mode 100644
index 00000000000..63a32c2b4f0
--- /dev/null
+++ b/contrib/plugins/meson.build
@@ -0,0 +1,28 @@
+contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+if host_os != 'windows'
+  # lockstep uses socket.h
+  contrib_plugins += 'lockstep'
+endif
+
+t = []
+if get_option('plugins')
+  foreach i : contrib_plugins
+    if host_os == 'windows'
+      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        dependencies: glib)
+    else
+      t += shared_module(i, files(i + '.c'),
+                        include_directories: '../../include/qemu',
+                        dependencies: glib)
+    endif
+  endforeach
+endif
+if t.length() > 0
+  alias_target('contrib-plugins', t)
+else
+  run_target('contrib-plugins', command: find_program('true'))
+endif
-- 
2.39.5


