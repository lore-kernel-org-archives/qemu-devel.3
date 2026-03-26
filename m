Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE5B10A88E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n9H-0004LC-0m; Thu, 26 Mar 2026 12:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8z-00047l-Tx
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8t-0001is-Em
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMru4Qfm3nT6VSkibmFm1sG+p6Wk3D7PhAvTfNGTNEw=;
 b=fZisstkyKFhTUNYwo7jixkCZc+oeqegnX1OSS2sk0gVInGPFFUIbg6RSAfM7kaea2YSUu/
 iKhlxK4Lkr+W4vq+AYbdDsmfK5upROl4KgPGllkSIlD64fZMX8boJIxtPh7a+GUIxByVWY
 7vBeOoWqUVAKl4qaUsdFgE1GnhdMWf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-km0SbM33OqWLGuISLG9tXA-1; Thu,
 26 Mar 2026 12:01:04 -0400
X-MC-Unique: km0SbM33OqWLGuISLG9tXA-1
X-Mimecast-MFC-AGG-ID: km0SbM33OqWLGuISLG9tXA_1774540863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5C7618002E9; Thu, 26 Mar 2026 16:01:02 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0217130002C3; Thu, 26 Mar 2026 16:00:59 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH 6/7] storage-daemon: use same link arguments as other tools
Date: Thu, 26 Mar 2026 18:00:32 +0200
Message-ID: <20260326160033.68318-7-kkostiuk@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  8 ++++----
 storage-daemon/meson.build | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 711dafa9ce..e1baa0ea80 100644
--- a/meson.build
+++ b/meson.build
@@ -4496,15 +4496,15 @@ if xkbcommon.found()
 endif
 
 if have_tools
-  link_args = enable_modules ? ['@block.syms'] : []
+  tools_link_args = enable_modules ? ['@block.syms'] : []
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               link_args: link_args, link_depends: block_syms,
+               link_args: tools_link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 5e61a9d1bd..fc088cbea7 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1,14 +1,14 @@
+assert(have_tools)
+
 qsd_ss = ss.source_set()
 qsd_ss.add(files('qemu-storage-daemon.c'))
 qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
 
 subdir('qapi')
 
-if have_tools
-  qsd_ss = qsd_ss.apply({})
-  qsd = executable('qemu-storage-daemon',
-                   qsd_ss.sources(),
-                   link_args: '@block.syms', link_depends: block_syms,
-                   dependencies: qsd_ss.dependencies(),
-                   install: true)
-endif
+qsd_ss = qsd_ss.apply({})
+qsd = executable('qemu-storage-daemon',
+                 qsd_ss.sources(),
+                 link_args: tools_link_args, link_depends: block_syms,
+                 dependencies: qsd_ss.dependencies(),
+                 install: true)
-- 
2.52.0


