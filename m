Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E710CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cQf-00084z-J6; Tue, 30 Sep 2025 11:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cQc-000838-2e
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cQZ-00046v-2A
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yo5IocHLZdZiThmLsO1Wu54wj47MJ5ty/FP2hkgmeI=;
 b=ZSQNhRMScWPxUGpUDhbDgp2lHou3p6SS/iiFyxt+Il/go4VCHzLfrAfbtuToX7trreOSZF
 bxhaJme/lIWtowwwCmItWlmws7eyr+ikINrISWvxOgsQbExvi8QNRIQWQPv7A2pQIUEfG/
 woYuhb7zw6IAayh5IsgGEVceClNBiIU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-cUTKGEYWO_ynEwweMg5zZw-1; Tue,
 30 Sep 2025 11:38:00 -0400
X-MC-Unique: cUTKGEYWO_ynEwweMg5zZw-1
X-Mimecast-MFC-AGG-ID: cUTKGEYWO_ynEwweMg5zZw_1759246679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2704C19560AF; Tue, 30 Sep 2025 15:37:58 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EED930002C5; Tue, 30 Sep 2025 15:37:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/23] build-sys: require -lrt when no shm_open() in std libs
Date: Tue, 30 Sep 2025 19:37:22 +0400
Message-ID: <20250930153746.573875-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fail during configure time if the shm functions are missing, as required
by oslib-posix.c. Note, we could further check the presence of the
function in librt.

This is a minor cleanup/improvement.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250924120426.2158655-2-marcandre.lureau@redhat.com>
---
 meson.build | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index bdfb6214e6..c08e2df6bb 100644
--- a/meson.build
+++ b/meson.build
@@ -1350,7 +1350,13 @@ if get_option('spice') \
 endif
 spice_headers = spice.partial_dependency(compile_args: true, includes: true)
 
-rt = cc.find_library('rt', required: false)
+rt = not_found
+if host_os != 'windows'
+  have_shm_open = cc.has_function('shm_open')
+  if not have_shm_open
+    rt = cc.find_library('rt', required: true)
+  endif
+endif
 
 libiscsi = not_found
 if not get_option('libiscsi').auto() or have_block
@@ -3812,14 +3818,10 @@ util_ss = util_ss.apply({})
 libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc])
-qemuutil_deps = [event_loop_base]
-if host_os != 'windows'
-  qemuutil_deps += [rt]
-endif
+                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res,
-                              dependencies: qemuutil_deps)
+                              dependencies: [event_loop_base])
 
 if have_system or have_user
   decodetree = generator(find_program('scripts/decodetree.py'),
-- 
2.51.0


