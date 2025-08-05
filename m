Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FACC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujML9-0002cL-9m; Tue, 05 Aug 2025 14:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujML5-0002br-EP
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujML2-0003VV-EK
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K2C5HNxpTK1ZwGnmlTSnv6GzVbm/PygPvyRzbewSb18=;
 b=KpaFe0IqkMzOLlojQooWNfFv4+bPOmCZzOKvfYpredSJWYRpfhrFHWpVs6klbibHWKFeOT
 sYR9e65AFh/AEwGXkDi3LsjjN1+Mob6KUi270g4CIa8DsebWMocbp9Et0QSOUMj3Bpddsy
 P81pc4fCIFOIuW3BYdhJ8vadc0wgJQM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-Z07dgHveOg2aWICGkIrknw-1; Tue,
 05 Aug 2025 14:24:37 -0400
X-MC-Unique: Z07dgHveOg2aWICGkIrknw-1
X-Mimecast-MFC-AGG-ID: Z07dgHveOg2aWICGkIrknw_1754418276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C2EB1800873; Tue,  5 Aug 2025 18:24:36 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.80])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CE0C1955E88; Tue,  5 Aug 2025 18:24:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] meson: remove 'gnutls-bug1717-workaround' for migration TLS
 crashes
Date: Tue,  5 Aug 2025 19:24:31 +0100
Message-ID: <20250805182431.504158-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The implementation of this workaround does not currently work, so
remove the option entirely to avoid exposing it to users. The code
will remain (temporarily dormant) to be fixed in the next release
cycle.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build                   | 6 +++---
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index e53cd5b413..a7b3c683ce 100644
--- a/meson.build
+++ b/meson.build
@@ -1836,11 +1836,11 @@ if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_syste
                         required: get_option('gnutls'))
   endif
 
-  if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
+  #if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
     # XXX: when bug 1717 is resolved, add logic to probe for
     # the GNUTLS fixed version number to handle the 'auto' case
-    gnutls_bug1717_workaround = true
-  endif
+  #  gnutls_bug1717_workaround = true
+  #endif
 endif
 
 # We prefer use of gnutls for crypto, unless the options
diff --git a/meson_options.txt b/meson_options.txt
index dd33530750..fff1521e58 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -174,8 +174,6 @@ option('libcbor', type : 'feature', value : 'auto',
        description: 'libcbor support')
 option('gnutls', type : 'feature', value : 'auto',
        description: 'GNUTLS cryptography support')
-option('gnutls-bug1717-workaround', type: 'feature', value : 'auto',
-       description: 'GNUTLS workaround for https://gitlab.com/gnutls/gnutls/-/issues/1717')
 option('nettle', type : 'feature', value : 'auto',
        description: 'nettle cryptography support')
 option('gcrypt', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index d559e260ed..0ebe6bc52a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -123,9 +123,6 @@ meson_options_help() {
   printf "%s\n" '  gio             use libgio for D-Bus support'
   printf "%s\n" '  glusterfs       Glusterfs block device driver'
   printf "%s\n" '  gnutls          GNUTLS cryptography support'
-  printf "%s\n" '  gnutls-bug1717-workaround'
-  printf "%s\n" '                  GNUTLS workaround for'
-  printf "%s\n" '                  https://gitlab.com/gnutls/gnutls/-/issues/1717'
   printf "%s\n" '  gtk             GTK+ user interface'
   printf "%s\n" '  gtk-clipboard   clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
@@ -334,8 +331,6 @@ _meson_option_parse() {
     --disable-glusterfs) printf "%s" -Dglusterfs=disabled ;;
     --enable-gnutls) printf "%s" -Dgnutls=enabled ;;
     --disable-gnutls) printf "%s" -Dgnutls=disabled ;;
-    --enable-gnutls-bug1717-workaround) printf "%s" -Dgnutls-bug1717-workaround=enabled ;;
-    --disable-gnutls-bug1717-workaround) printf "%s" -Dgnutls-bug1717-workaround=disabled ;;
     --enable-gtk) printf "%s" -Dgtk=enabled ;;
     --disable-gtk) printf "%s" -Dgtk=disabled ;;
     --enable-gtk-clipboard) printf "%s" -Dgtk_clipboard=enabled ;;
-- 
2.50.1


