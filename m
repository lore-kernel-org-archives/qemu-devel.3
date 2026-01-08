Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B46ED185F9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqmR-00078H-K7; Thu, 08 Jan 2026 09:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdqmP-000787-To
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdqmL-0003Jo-D6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767881656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0fi1pqHYtP7jO9vBODN1intyg953jMq0lsafxoU91w0=;
 b=boO3PXU+WQn2aFx6lhg0wpcZCBW5MHrMjA2fjWA1m0E1LME6T2b52sKsXZYNwpYaE56xvg
 3cJDF/awuP6kU6FU6mWopZyeOEHueTiTU8a7jPCMk7R7zuOmIenMuwMfhqdblCfgLI6hzS
 Un4IOwSuR1PxkZ6R/DfuMVSEnphiIAM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-XLcL8hwDNX2ZEOIVueYvvg-1; Thu,
 08 Jan 2026 09:14:13 -0500
X-MC-Unique: XLcL8hwDNX2ZEOIVueYvvg-1
X-Mimecast-MFC-AGG-ID: XLcL8hwDNX2ZEOIVueYvvg_1767881652
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA6301956054; Thu,  8 Jan 2026 14:14:11 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26E8A1954193; Thu,  8 Jan 2026 14:14:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] meson: disable libatomic with GCC >= 16
Date: Thu,  8 Jan 2026 14:14:07 +0000
Message-ID: <20260108141407.2151817-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Historically it was required to ask for libatomic explicitly with
-latomic, but with GCC >= 16 apps will get linked to libatomic
whether they ask for it or not.

This invalidates QEMU's check for atomic op support for int128
which explicitly does NOT want to use the libatomic impl. As a
result with GCC >= 16, QEMU is now getting linked to libatomic
and is activating CONFIG_ATOMIC128. This in turn exposes a bug
in GCC's libatomic.a static buld which is incompatible with the
use of -static-pie leading to build failures like:

    /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/16/libatomic.a(cas_16_.o): relocation R_X86_64_32 against hidden symbol `libat_compare_exchange_16_i1' can not be used when making a PIE object
    /usr/bin/ld: failed to set dynamic section sizes: bad value
collect2: error: ld returned 1 exit status

The newly introduced -fno-link-libatomic flag can be used to
disable the new automatic linking of libatomic. Setting this in
qemu_isa_flags early on ensures that the check for CONFIG_ATOMIC128
still works correctly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index db87358d62..56df08c10e 100644
--- a/meson.build
+++ b/meson.build
@@ -445,6 +445,15 @@ if host_arch in ['i386', 'x86_64']
   endif
 endif
 
+# GCC >= 16 automatically tries to link libatomic for all programs.
+#
+# QEMU explicitly does NOT want to use libatomic for int128 types.
+#
+# Later checks assume we won't get atomic ops for int128 without
+# explicitly asking for -latomic, so we must disable GCC's new
+# automatic linking with the new -fno-link-libatomic flag
+qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
+
 qemu_common_flags = qemu_isa_flags + qemu_common_flags
 
 if get_option('prefer_static')
-- 
2.52.0


