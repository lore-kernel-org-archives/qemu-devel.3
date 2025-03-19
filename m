Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F6BC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusrg-0000RY-Cl; Wed, 19 Mar 2025 08:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnull+n.shubin.yadro.com@kernel.org>)
 id 1tuoJT-0006Fy-K8; Wed, 19 Mar 2025 03:58:07 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnull+n.shubin.yadro.com@kernel.org>)
 id 1tuoJQ-0003dg-Cp; Wed, 19 Mar 2025 03:58:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A09561146;
 Wed, 19 Mar 2025 07:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 773F8C4CEEA;
 Wed, 19 Mar 2025 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742371074;
 bh=mE2MaBr2QtIINHy+w5jhliGc0m4u+0PDxW2SPqeU2j4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oRFa/G3t3tcD6yuqUbS0yEv9KX3oSsd2Jr5IFd/ilSqjmvis0qWHHC0ycb1gRGHPW
 61o7UUqgJT2OkhhBwhW543+AYnDwzqkH61jcWPSZVoILzpyj9D9kRR/MyccrIX0YWY
 PIM7c0S8ZI/ywYtaYB8X1UirqcZrnPHRiFqlq6HJ/BgP2K5Db2yV318bh4s+SSKB4p
 yh5ySBQtoo90ugPtBVw7yiF0HGrcr/JqPaxRa6aZOH/r3EQASFNro++Keaa2YL829M
 0Vv+kbmdqgIApBm+aBG+EfdagvziFjiIaVWBLTtIvQC0ggC0U6t9AhaWhWOD+G8puZ
 WTyxOrWNG8D5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5A718C35FFF;
 Wed, 19 Mar 2025 07:57:54 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Wed, 19 Mar 2025 10:57:51 +0300
Subject: [PATCH PoC 1/7] QAPI: gpio JSON
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-gpiodev-v1-1-76da4e5800a1@yadro.com>
References: <20250319-gpiodev-v1-0-76da4e5800a1@yadro.com>
In-Reply-To: <20250319-gpiodev-v1-0-76da4e5800a1@yadro.com>
To: qemu-devel@nongnu.org
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Enrico Weigelt, metux IT consult" <info@metux.net>, 
 Viresh Kumar <vireshk@kernel.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Nikita Shubin <n.shubin@yadro.com>, Nikita Shubin <nshubin@yadro.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742371072; l=2476;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=yL5seaoNiRVlQ6Vi3YlxRJ5NFJn0Q9alBbQrrB7t0Sw=;
 b=YB9LbqclbLblyvFQXTTPw/d9jF1oOaso31QxGYcWBQPr1gC5v09w3qjV7m9K+tTJgMICur3vS
 HLPawi1W6dXBIfx7TEeM9Pftlkni22KryLNBv10MIdhlql2w9loRq7J
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=devnull+n.shubin.yadro.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Mar 2025 08:49:30 -0400
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
Reply-To: n.shubin@yadro.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nikita Shubin <nshubin@yadro.com>

Signed-off-by: Nikita Shubin <nshubin@yadro.com>
---
 qapi/gpio.json        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 3 files changed, 70 insertions(+)

diff --git a/qapi/gpio.json b/qapi/gpio.json
new file mode 100644
index 0000000000000000000000000000000000000000..1c2b7af36813ff52cbb3a44e64a2e5a5d8658d62
--- /dev/null
+++ b/qapi/gpio.json
@@ -0,0 +1,68 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+
+##
+# = Gpio devices
+##
+
+##
+# @GpiodevInfo:
+#
+# Information about a gpio device.
+#
+# @label: the label of the gpio device
+#
+# Since: 9.2
+##
+{ 'struct': 'GpiodevInfo',
+  'data': { 'label': 'str' } }
+
+##
+# @GpiodevBackendKind:
+#
+# @chardev: chardevs
+#
+# Since: 9.2
+##
+{ 'enum': 'GpiodevBackendKind',
+  'data': [ 'chardev' ] }
+
+##
+# @GpiodevChardev:
+#
+# Configuration info for chardev gpiodevs.
+#
+# @chardev: chardev id
+#
+# @size: buffer size, default is 65536
+#
+# Since: 9.2
+##
+  { 'struct': 'GpiodevChardev',
+    'data': { 'chardev': 'str',
+              '*size': 'int' } }
+
+##
+# @GpiodevChardevWrapper:
+#
+# @data: Configuration info for chardev gpiodevs
+#
+# Since: 9.2
+##
+{ 'struct': 'GpiodevChardevWrapper',
+  'data': { 'data': 'GpiodevChardev' } }
+
+##
+# @GpiodevBackend:
+#
+# Configuration info for the new chardev backend.
+#
+# @type: backend type
+#
+# Since: 9.2
+##
+{ 'union': 'GpiodevBackend',
+  'base': { 'type': 'GpiodevBackendKind' },
+  'discriminator': 'type',
+  'data': { 'chardev': 'GpiodevChardevWrapper' } }
\ No newline at end of file
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db307f0c54a7a1f2471a063c78346810cc..13d255adb8e6d823356fe0ecae0b585688320f9d 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -35,6 +35,7 @@ qapi_all_modules = [
   'dump',
   'ebpf',
   'error',
+  'gpio',
   'introspect',
   'job',
   'machine-common',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 2877aff73d0caff9d4ed681de0690c24a268cecd..03cfa1ed4a0438d00a6151d56167ec929467f15d 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -52,6 +52,7 @@
 { 'include': 'block-export.json' }
 { 'include': 'char.json' }
 { 'include': 'dump.json' }
+{ 'include': 'gpio.json' }
 { 'include': 'net.json' }
 { 'include': 'ebpf.json' }
 { 'include': 'rocker.json' }

-- 
2.45.2



