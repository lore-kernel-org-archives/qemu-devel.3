Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB3FD5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kKn-0002VZ-5y; Sat, 09 Nov 2024 07:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKR-0000jc-Ab; Sat, 09 Nov 2024 07:12:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKP-0004bH-Kg; Sat, 09 Nov 2024 07:12:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2237A160D;
 Sat,  9 Nov 2024 15:07:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B96F4167F9B;
 Sat,  9 Nov 2024 15:08:03 +0300 (MSK)
Received: (nullmailer pid 3295367 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 37/57] net: fix build when libbpf is disabled,
 but libxdp is enabled
Date: Sat,  9 Nov 2024 15:07:39 +0300
Message-Id: <20241109120801.3295120-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The net/af-xdp.c code is enabled when the libxdp library is present,
however, it also has direct API calls to bpf_xdp_query_id &
bpf_xdp_detach which are provided by the libbpf library.

As a result if building with --disable-libbpf, but libxdp gets
auto-detected, we'll fail to link QEMU

  /usr/bin/ld: libcommon.a.p/net_af-xdp.c.o: undefined reference to symbol 'bpf_xdp_query_id@@LIBBPF_0.7.0'

There are two bugs here

 * Since we have direct libbpf API calls, when building
   net/af-xdp.c, we must tell meson that libbpf is a
   dependancy, so that we directly link to it, rather
   than relying on indirect linkage.

 * When must skip probing for libxdp at all, when libbpf
   is not found, raising an error if --enable-libxdp was
   given explicitly.

Fixes: cb039ef3d9e3112da01e1ecd9b136ac9809ef733
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 1f37280b37dbf85f36748f359a9f8802c8fe7ccd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 7a56772136..5cfd7bb2cc 100644
--- a/meson.build
+++ b/meson.build
@@ -2033,8 +2033,14 @@ endif
 # libxdp
 libxdp = not_found
 if not get_option('af_xdp').auto() or have_system
-    libxdp = dependency('libxdp', required: get_option('af_xdp'),
-                        version: '>=1.4.0', method: 'pkg-config')
+    if libbpf.found()
+        libxdp = dependency('libxdp', required: get_option('af_xdp'),
+                            version: '>=1.4.0', method: 'pkg-config')
+    else
+        if get_option('af_xdp').enabled()
+            error('libxdp requested, but libbpf is not available')
+        endif
+    endif
 endif
 
 # libdw
diff --git a/net/meson.build b/net/meson.build
index 9432a588e4..a15855e909 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -37,7 +37,7 @@ if have_netmap
   system_ss.add(files('netmap.c'))
 endif
 
-system_ss.add(when: libxdp, if_true: files('af-xdp.c'))
+system_ss.add(when: [libxdp, libbpf], if_true: files('af-xdp.c'))
 
 if have_vhost_net_user
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
-- 
2.39.5


