Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEBEC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WzJ-0005JY-Kw; Mon, 07 Sep 2026 06:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wyz-0004l0-Nk
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wyv-0000Bw-Ll
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6vrjuUsW0IUCsWO5EIC9UzfJOCruMJfcXBwYhCOGcY=;
 b=EYDALVpTnlkwfHFAPwdmeWVIf8qVeQHlpjjJvitoumegnPPciS8lBR9j7bpN2+hWPIBQ59
 RuMcCIhaUUem3DRfumnxhhzqTBomat8eRrZI0QC1rP78brx3kdcDUi8KTNuN+H5AvocHFa
 iYiEiTZ1vWo+tc+cEZvxqOV70St2Pfg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-HdpWlTbTNSuVXwpVkAFo_w-1; Mon,
 07 Sep 2026 06:53:39 -0400
X-MC-Unique: HdpWlTbTNSuVXwpVkAFo_w-1
X-Mimecast-MFC-AGG-ID: HdpWlTbTNSuVXwpVkAFo_w_1788778418
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D376180AEBD; Mon,  7 Sep 2026 10:53:38 +0000 (UTC)
Received: from berrange.fritz.box (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F27C1956049; Mon,  7 Sep 2026 10:53:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL v3 10/12] crypto: deprecate the AF_ALG crypto backend
Date: Mon,  7 Sep 2026 11:53:08 +0100
Message-ID: <20260907105310.497730-11-berrange@redhat.com>
In-Reply-To: <20260907105310.497730-1-berrange@redhat.com>
References: <20260907105310.497730-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Linux 7.2 has deprecated the AF_ALG crypto backend:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a67afb1884ba815079bd43d5c998e155e03b08b6

And has documented it to be always slower than userspace crypto:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5624ea54f3ba5c83d2e5503411a31a8be0278c1e

as a result of dropping support for zero-copy and hardware
accelerators:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7524070f26d8d347c26787dc297fb844baa26abf
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffdd2bc378953b525aca61902534e753f1f8e734

The main use case for the AF_ALG impl was to improve the performance
of virtio-crypto with the cryptodev-backend-builtin driver. In
practice this did not matter since 'cryptodev-backend-lkcf' can do
offload to the kernel via the keyctl syscall, and 'cryptodev-vhost-user'
can offload to an external process which can optionally integrate with
hardware accelerators without kernel assistance.

The AF_ALG backend has no user visible configuration options at runtime,
it is unconditionally tried with any use of the cipher APIs. So it does
not strictly have to go through the deprecation process, however, it is
left available initially in case there was an unexpected use case that
relies on it which may be faster with old kernels before the above Linux
commits.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/deprecated.rst | 21 +++++++++++++++++++++
 meson.build               |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 05e4ce8cf1..98c32991c9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -434,6 +434,27 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
 and NWFPE emulation, and they will be removed in a future QEMU
 release.
 
+Build features
+--------------
+
+Crypto AF_ALG backend (since 11.2)
+----------------------------------
+
+The use of the AF_ALG backend for cryptography has been deprecated
+with no replacement.
+
+The AF_ALG interface is deprecated by Linux 7.2 and all support
+for hardware accelerators has been removed. It will thus always be
+slower than userspace crypto due to the overhead of copying data
+to kernel space. The GNUTLS, Nettle and GCrypt libraries supported
+by QEMU all include a variety of hardware optimized crypto
+implementations which should suffice for typical needs.
+
+For the virtio-crypto device, the 'cryptodev-backend-lkcf' backend
+can offload some operations to the kernel via the keyctl syscall,
+and the 'cryptodev-vhost-user' backend can offload the device
+backend to an external process which can integrate with crypto
+accelerators.
 
 Backwards compatibility
 -----------------------
diff --git a/meson.build b/meson.build
index 2a022c4d85..ec9b05414a 100644
--- a/meson.build
+++ b/meson.build
@@ -5059,3 +5059,9 @@ if not actually_reloc and (host_os == 'windows' or get_option('relocatable'))
   message('QEMU will have to be installed under ' + get_option('prefix') + '.')
   message('Use --disable-relocatable to remove this warning.')
 endif
+
+if get_option('crypto_afalg').enabled()
+    warning('Use of the AF_ALG crypto backend is deprecated, ' +
+            'since Linux 7.2 has deprecated the AF_ALG interface ' +
+            'and removed its ability to use hardware accelerators.')
+endif
-- 
2.55.0


