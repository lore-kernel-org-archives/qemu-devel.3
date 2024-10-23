Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F03D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X5Q-0000XC-9M; Wed, 23 Oct 2024 04:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5O-0000Wo-SG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5M-0007rC-6N
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWiaMbGEPPIjTAQrv9WLohZ+613Z2lTNgokUWmT+gQU=;
 b=hbB/iWFavry/mRd2/gZhb1KtY5WPZLomBS2Eu5HSOBUK1TrtE41oXSjVv0WHC307/DKeLl
 YLHgJxRS5aFhpLjKgnPplKdDuXXEre3jlYoFylN72OXN9eoHNoOWSUCYHPwPQCQgQe1xyK
 1CKOXhBYVcNsd9jeFBcb4+MmcyKhtjY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-IaYSx5-0MuymXHZlDr-Bfg-1; Wed,
 23 Oct 2024 04:51:13 -0400
X-MC-Unique: IaYSx5-0MuymXHZlDr-Bfg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A5361956095; Wed, 23 Oct 2024 08:51:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44D5E1955EA4; Wed, 23 Oct 2024 08:51:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 1/8] net: fix build when libbpf is disabled,
 but libxdp is enabled
Date: Wed, 23 Oct 2024 09:50:56 +0100
Message-ID: <20241023085103.1980072-2-berrange@redhat.com>
In-Reply-To: <20241023085103.1980072-1-berrange@redhat.com>
References: <20241023085103.1980072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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
---
 meson.build     | 10 ++++++++--
 net/meson.build |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index d26690ce20..a9dfa1f3a7 100644
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
2.46.0


