Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B5D1CDDF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZf-0002Ip-7h; Tue, 22 Oct 2024 06:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ6-0001rU-7v
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ4-00026O-DC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso812869566b.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594596; x=1730199396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59EXaptdsAtTsnL7N0QHtzvibi/ktz9wJ6DO/DYK14s=;
 b=Bc68p+6hpnuftkBuFHQxm1WhLl1f7/VxrrXXNItalKXkNBaBWOsre4i30t5qdd7Q+j
 Un2yT30GPG/2xnbZS5MuYX9jZvAQtBRBsOcmi7A3mATdlOgcae4kFf279NC5gS/7Hzp+
 5eNl8I3nCEHgbNkjXF9b4WV5aZCE5+38CdMBJgnjwvzkwj9zDEC3T/q9J37akU0m2U8E
 RL+c4EtzKszmc5Wagpc4kT0ysbQUH4wqywEF/pU18sE2jhgzxxrH9GiQDvjiy55jdFrS
 sJbpgjYTaJbaKdAIcLmsXcCL9JAHLXfMcr5d4G+fX79qeH+wYqiCCN4XZEI4Fp/mA7QA
 SLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594596; x=1730199396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59EXaptdsAtTsnL7N0QHtzvibi/ktz9wJ6DO/DYK14s=;
 b=I6vkeJdgUMuGmoWfIcJXk2D61AoKsFOxGDFO/NPEuzALYpwuC6k88WVeROpvfNCF2v
 pp10hqUb9h660AzYA96qiD8oecVjgdkd185ZP1avyJ/eZ0CcHlYNVA8YjF9AMG3k8WTo
 hqat5igKo3RVRg9TohAkm4zWLwytaKJbaZDmnp305M9/pceKmU8Cp+dlkyxCYbBPBdXF
 hlnAn0Cp+3YbWtsyuEtGG5w9XaLIOHv6ir9I+Jfu5AqYOTG7gtO+ISB6Fjc+CftS3I0q
 HZ7RIeYkDBmPo9OgndfZ6An6ny/6UesXme+ILS2dFB26VpC2Jl1o5EdPbTR1YUwP/6tF
 NnsQ==
X-Gm-Message-State: AOJu0Yy3mYlZ01xXNCh7UDY/4nEAAW3sAznSJvTjYJ6LhS82vo4x+6MT
 EVcjX9k+B1OsM1xSIFGFT+PXTMzuxiw4CJRH+W8utbHvO73rMZYTWYPKIr8Dkr0=
X-Google-Smtp-Source: AGHT+IESzzC72mFFjVxSlJ9yKckkgejJYGt9NcC+1VBYY14emqGj0/mOgmagBB965bWs6j/k5E+0qQ==
X-Received: by 2002:a17:907:d2a:b0:a9a:5e3a:641d with SMTP id
 a640c23a62f3a-a9aad376421mr153636366b.59.1729594595748; 
 Tue, 22 Oct 2024 03:56:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a915a48aesm326490066b.221.2024.10.22.03.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 394875FC3D;
 Tue, 22 Oct 2024 11:56:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 18/20] meson: build contrib/plugins with meson
Date: Tue, 22 Oct 2024 11:56:12 +0100
Message-Id: <20241022105614.839199-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
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
Message-Id: <20240925204845.390689-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                 |  4 ++++
 contrib/plugins/meson.build | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 contrib/plugins/meson.build

diff --git a/meson.build b/meson.build
index bdd67a2d6d..3ea03c451b 100644
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
index 0000000000..a0e026d25e
--- /dev/null
+++ b/contrib/plugins/meson.build
@@ -0,0 +1,23 @@
+t = []
+if get_option('plugins')
+  foreach i : ['cache', 'drcov', 'execlog', 'hotblocks', 'hotpages', 'howvec',
+               'hwprofile', 'ips', 'lockstep', 'stoptrigger']
+    if host_os == 'windows'
+      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        dependencies: glib)
+
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


