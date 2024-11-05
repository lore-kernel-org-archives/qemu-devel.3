Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA85D1267F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H2I-00037b-3y; Tue, 05 Nov 2024 05:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H2A-0002xU-Sn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:40 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H29-0003Qh-7Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:38 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso683759166b.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730803415; x=1731408215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKZMku98sdxCTDahr+TLjNAtOni8kkq03uBM5KKnleo=;
 b=NoXro3/3Ht2iXvyAY3c+jUU8uARqLvKzVfbGuJkvi9j83VeqQ67Fp8zWaZTm41YmlV
 YfkdyYlkzeHzoq4lRL+q8YqLluKucp8uEK6JV/aV8MphcZtSmBQGUEjldVpgx9MmR2ln
 uPvOXUtSLqG5lUk1dPw0/RTGyDTnM3nYrJOMg4ZVgtgeyiltbCrOAh1zJt44HrTWhql1
 UGR1l7EegPbJaOGMzO0IPh+Mqm/Qk1jwwLSQXcsKnJdvCoE4KQXNTBPDiA1PaWecn5Jl
 tbQyRdjrEoaBg8JgaIOZkFkPgsv0PCrIZHjo+rCs3WdLJGe0RPyrfO3pedbQbFccFctD
 cgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803415; x=1731408215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKZMku98sdxCTDahr+TLjNAtOni8kkq03uBM5KKnleo=;
 b=O9I3QH81ZuQ4/N/6QPGyIrf0Gryrok3SwxuXDPJ1SnNKS0dvTBbtOHx7fCo0r93wWM
 idvb0B0KZTHU7LGaW9/wI42fOmb0NA3GRmQqOhhZQ4KEOBfuxYFtkMSkM9uM+PUh1cwG
 7tEYbmVBB4XzSatOkfoZ6jMx4VsVnAM2nBB/EYmw9dciDWpF0hjAfrk0A+eYtYTDCqOh
 UzY0rj8dFpUGoYtsmYzETHW1qIQihEFzVpyzpIQddnAl6YYlDTaBOf2YEtO9NJopK3oi
 yngeWA/FgHRkPvkUbBOZ2ia7hYl1JUAZi4XeB6W5cWXrVpGn1kiqI08OhoU4L7nDaSWh
 cevQ==
X-Gm-Message-State: AOJu0YzHD09xg8GDCtjWb4umOECXcrxry+wuEXL4i2CcdZx5pMDQIjfH
 2cCkeGZQryGxIcIFBEP/ed6Zxwv79VwprnVp2wXSI1jTG0xaD67c1VEgVFzutC4=
X-Google-Smtp-Source: AGHT+IEZxCDTD6nr2VHhfMbRI5ZlFSqsno4SxZFwjLMVcih33SaxLG89VB7REQhimpHqLDzqskYjFQ==
X-Received: by 2002:a17:906:3755:b0:a9e:65a8:b1fd with SMTP id
 a640c23a62f3a-a9e65a8b677mr1282945866b.22.1730803415492; 
 Tue, 05 Nov 2024 02:43:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16a2fcbsm115912166b.37.2024.11.05.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:43:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0CF95F8CF;
 Tue,  5 Nov 2024 10:43:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] meson: build contrib/plugins with meson
Date: Tue,  5 Nov 2024 10:43:32 +0000
Message-Id: <20241105104333.2534823-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241105104333.2534823-1-alex.bennee@linaro.org>
References: <20241105104333.2534823-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Tried to unify this meson.build with tests/tcg/plugins/meson.build but
the resulting modules are not output in the right directory.

Originally proposed by Anton Kochkov, thank you!

Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241023212812.1376972-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index c386593c52..2fe34c4462 100644
--- a/meson.build
+++ b/meson.build
@@ -3690,6 +3690,10 @@ subdir('accel')
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
index 0000000000..63a32c2b4f
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


