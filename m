Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F2810A88E3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n9K-0004Wu-Ut; Thu, 26 Mar 2026 12:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n96-0004BZ-Kl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8z-0001js-MI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4s+kssxdiz6yzKzC6/rTBLUs0Om1IyNCc7yUiU8Zopo=;
 b=EzzkDJEGuK1sUxpkWEfjJu0Y1PJW4cMZWyVJVRQliWEHBirAslzD+5+w4peUSPsqN2aj2w
 WmGFFv1yTpQjspTHdCNIBchX1yI0bz7kmThb+AV+Xg9NKEJzZBc+MYaSqA7KdcD0+wiEAZ
 lfcBEUtMXhgL+NHAK9UcqT1gGLBZJlI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-d97lcdbUOIO6dAep6i7TSw-1; Thu,
 26 Mar 2026 12:01:07 -0400
X-MC-Unique: d97lcdbUOIO6dAep6i7TSw-1
X-Mimecast-MFC-AGG-ID: d97lcdbUOIO6dAep6i7TSw_1774540866
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FDD519560B5; Thu, 26 Mar 2026 16:01:06 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585B530002C3; Thu, 26 Mar 2026 16:01:03 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH 7/7] meson: Build block_syms and qemu_syms only when
 enable_modules
Date: Thu, 26 Mar 2026 18:00:33 +0200
Message-ID: <20260326160033.68318-8-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-1-kkostiuk@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 meson.build | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index e1baa0ea80..c7ab9c47c4 100644
--- a/meson.build
+++ b/meson.build
@@ -3897,6 +3897,9 @@ modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
 audio_modinfo_files = []
 
+block_syms = []
+qemu_syms = []
+
 block_mods = []
 system_mods = []
 emulator_modules = []
@@ -4012,18 +4015,18 @@ if enable_modules
   if emulator_modules.length() > 0
     alias_target('modules', emulator_modules)
   endif
-endif
 
-nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.py')
-block_syms = custom_target('block.syms', output: 'block.syms',
-                             input: [libqemuutil, block_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
-qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, system_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
+  nm = find_program('nm')
+  undefsym = find_program('scripts/undefsym.py')
+  block_syms = custom_target('block.syms', output: 'block.syms',
+                              input: [libqemuutil, block_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+  qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
+                              input: [libqemuutil, system_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+endif
 
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
-- 
2.52.0


