Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E8D5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hG7-00078Q-6t; Tue, 29 Oct 2024 04:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hG4-00077q-OH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t5hG3-0003vf-7g
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730189237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZjB3Af3Eu7jTZIe/vhr6IHTcD6ismi5yenfs4fh47Q=;
 b=OAZDNqlw5QGtI7P66fbx1+ncMWK999KyGvpuKRwLgYnL9MUsREXewESbfrtZdg0A71xPlU
 /+Zcnp7D9XzXLNIZHdkdn/Z8/a0ZPI2qcMwsS255zavl5msvYN1R+8Ai7/5NPoIupm6EBu
 aPB5UGvfwCL/ZFE9PQvi2vilhODlaQI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-_9t5xDVFPZ-mOBR7Ad9T-w-1; Tue,
 29 Oct 2024 04:07:15 -0400
X-MC-Unique: _9t5xDVFPZ-mOBR7Ad9T-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF88B1955F10
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DB6A1956086; Tue, 29 Oct 2024 08:07:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/14] net: fix build when libbpf is disabled,
 but libxdp is enabled
Date: Tue, 29 Oct 2024 16:06:52 +0800
Message-ID: <20241029080705.3238-2-jasowang@redhat.com>
In-Reply-To: <20241029080705.3238-1-jasowang@redhat.com>
References: <20241029080705.3238-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 meson.build     | 10 ++++++++--
 net/meson.build |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index c26c417de1..9432c5f173 100644
--- a/meson.build
+++ b/meson.build
@@ -2164,8 +2164,14 @@ endif
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
index e0cd71470e..bb97b4dcbe 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -39,7 +39,7 @@ if have_netmap
   system_ss.add(files('netmap.c'))
 endif
 
-system_ss.add(when: libxdp, if_true: files('af-xdp.c'))
+system_ss.add(when: [libxdp, libbpf], if_true: files('af-xdp.c'))
 
 if have_vhost_net_user
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
-- 
2.42.0


