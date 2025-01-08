Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3E9E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV4R-0006ON-1h; Wed, 08 Jan 2025 07:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuz-00019X-Rw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:16 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuV-0007M9-Ax
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:06 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so1523961a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338272; x=1736943072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdsXyF3OC+6k01wdvpRGDBTvPRZa71R2EiA5i0mTRfY=;
 b=NcMq+tVoCiDiBx8FLt2ANk/82TR6zKzu87h6qss89EpOWwk0p8HDHWbcYnopXTQcgd
 po3sPOJv5yTm4E5trvAe52697jjNIlPHyQzriwyWjuJlpkOI/7MVV1t3jVEgBzcHVCYB
 AhgPkjBA29bhhjg4QRZ7ekzS73R6p9rMjXmawe3+d+86V+vISLS1i23QdheUukyAdZ9T
 +nI0XkHmFF0Zh2e3Jf12f4U9zYL0wrpQNzf+DlNsapwF7JMMzNhhJRah+BuCEwWXNqWf
 Bn5FQ+Vpj2P3vCV9TWPhy+87W4wh+ULi1pkLVbtfX7/1BtigMq51Ra8KFy/elwyS1KXt
 i4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338272; x=1736943072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdsXyF3OC+6k01wdvpRGDBTvPRZa71R2EiA5i0mTRfY=;
 b=sL1Jg0/D4vopjgJ+Lqccu543GPYNqChg6eyd8KIWZyFDedEIoUtxdyRiBO8hpCdi0Q
 dsLC4FziTkgaNUluRX536M9iYgGS0VHGQiuwJo9l2hZFXJx/fWkSJPSGD+lO7HXPrBnU
 Npqv3O08Xr+/Fiqvd7HQvO2jg6VXDbDluw/Do2iQy4e6vVc5htRzCVcG6IoN4mjCb6qC
 zR15ad+JModJl1qj59QCK12yUHZ3HrlOPWs4ltFs3Bb/QGyXaik8mkJSYhkqfnGj9+hw
 68GT0RmGAYC9jSOcDZLMDnL9O4EC0ypyXZt9+B0VmiO0w+f8e8sKmiFHP26Vzhv7cc4x
 Tm3w==
X-Gm-Message-State: AOJu0YxSpG75mTV79vTMMeclKwdxU6W66nHZbRr0T/DoOz+d+o6DglUd
 r3hbsBZW0SPmkbWu4taDTSWzkmSxP11GFKrLkU/auM8GnrCk7RtVahZtP11EaTs=
X-Gm-Gg: ASbGncsQT96qEXdDxt4tzczCjNBgqHAEKCVuDfw/I7Nz5/oQuYi+35tbnhYunWpbWNp
 4m0Rsg3aosOYK++uA+gVMRBx0ogw5h2eWa4zX2zt1mYOadXnGdII6rbk8a4O0aPE9syoSRedY4X
 Qu5ubuFuJWpTS+i0hstmLOi4IwbRt29G0jY5GqwqQGFuPtmvSxtsyPsqde09alyQ1NoPu8Kt44Y
 M0jLKPQKkvVtgaR1xVg1pcuEMcKyC2c3x+vlsLJkZGr4uKEEQlik5U=
X-Google-Smtp-Source: AGHT+IFyqyGoZ/xuk8ngbKshNkEnRC1VEfUnAYZBz2eWBtCTj5Qh5iWyg+7ZSyAdkuLb5nSAyJ1wQw==
X-Received: by 2002:a05:6402:3593:b0:5d3:eb50:4e33 with SMTP id
 4fb4d7f45d1cf-5d95e8ced09mr5874086a12.5.1736338272274; 
 Wed, 08 Jan 2025 04:11:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c5a4sm25056881a12.38.2025.01.08.04.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:11:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86EC960132;
 Wed,  8 Jan 2025 12:10:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 30/32] pc-bios: ensure keymaps dependencies set vnc tests
Date: Wed,  8 Jan 2025 12:10:52 +0000
Message-Id: <20250108121054.1126164-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
$BLD/pc-bios/keymaps (although something attempts to symlink
qemu-bundle/usr/local/share/qemu/keymaps/ to that dir).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/keymaps/meson.build | 17 ++++++++---------
 tests/qtest/meson.build     |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

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


