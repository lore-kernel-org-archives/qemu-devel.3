Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81499C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYdI-00045n-Rz; Wed, 24 Jul 2024 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYd2-0002sL-BH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYd0-0003dG-P1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooTB6o0l7fGaiBxn6orHO8iTdyy+G4GW6L0eIcZK+Cw=;
 b=QabUqpbWL6GBUFPuOx3QOO5cUaneTFgYhkwrzm4uKPmAJ9dOcbmxFRjevCzsI6EfbJJeOI
 dPpWUQEVgXh6xT09NCC76yq5vBZAmzjc0WozY97sZ3vFE3dMOWuQkqkfpwz1SdfsX+6Llw
 L9ENvaMI7sUG3RTtLxhl6BW2nRuqO5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-EK_4t7FcM-iC7K03Bt4tKA-1; Wed,
 24 Jul 2024 05:48:19 -0400
X-MC-Unique: EK_4t7FcM-iC7K03Bt4tKA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48901955D4E; Wed, 24 Jul 2024 09:48:17 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54B0919560AA; Wed, 24 Jul 2024 09:48:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Yao Zi <ziyao@disroot.org>
Subject: [PULL 05/11] meson.build: fix libgcrypt detection on system without
 libgcrypt-config
Date: Wed, 24 Jul 2024 10:47:00 +0100
Message-ID: <20240724094706.30396-6-berrange@redhat.com>
In-Reply-To: <20240724094706.30396-1-berrange@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yao Zi <ziyao@disroot.org>

libgcrypt starts providing correct pkg-config configuration since 1.9,
in parallel with libgcrypt-config. Since 1.11 it may also stop
installing libgcrypt-config in some scenarios. Use the auto method for
detection of libgcrypt, in which meson will try both pkg-config and
libgcrypt-config.

Auto method for libgcrypt is supported by meson since 0.49.0, which is
higher than the version qemu requires.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4eca361319..ec6fb7d69c 100644
--- a/meson.build
+++ b/meson.build
@@ -1696,7 +1696,6 @@ endif
 if not gnutls_crypto.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.8',
-                        method: 'config-tool',
                         required: get_option('gcrypt'))
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
-- 
2.45.2


