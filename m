Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9860C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVn-00033I-W7; Fri, 09 Feb 2024 09:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVj-0002u7-Tm
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVi-0004MY-BV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWD1cQ61IYdvGaG63O+Jbvl1sac9ZVC9mpJpAjayZWA=;
 b=Ond36+5kmFfz2FcR+wZ418dB/0KT7TaE4jrHEuOYN1uQZc9I9VQHaB2c8Qct+aDYx2r3CT
 w4xWzeHvfT2ePe7QZQgUqUEcEqm1xHl8gEnWYKHCsijp8yWlxp5HQqi+nBmo/BJC4/2dHQ
 6QQwhdxCFLchpXlF63tRHPwTX40IVBM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-h_T02WLePrynvOSBVZ8gYg-1; Fri,
 09 Feb 2024 09:05:43 -0500
X-MC-Unique: h_T02WLePrynvOSBVZ8gYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B05EA1C0515A;
 Fri,  9 Feb 2024 14:05:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE59112A1;
 Fri,  9 Feb 2024 14:05:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/17] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
Date: Fri,  9 Feb 2024 14:05:00 +0000
Message-ID: <20240209140505.2536635-13-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

To support detached LUKS header creation, make the existing 'file'
field in BlockdevCreateOptionsLUKS optional.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c       | 21 ++++++++++++++-------
 qapi/block-core.json |  5 +++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 68656158e9..e87dc84111 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -663,9 +663,9 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
 
-    bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
-    if (bs == NULL) {
-        return -EIO;
+    if (luks_opts->file == NULL) {
+        error_setg(errp, "Formatting LUKS disk requires parameter 'file'");
+        return -EINVAL;
     }
 
     create_opts = (QCryptoBlockCreateOptions) {
@@ -677,10 +677,17 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         preallocation = luks_opts->preallocation;
     }
 
-    ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                         preallocation, errp);
-    if (ret < 0) {
-        goto fail;
+    if (luks_opts->file) {
+        bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
+        if (bs == NULL) {
+            return -EIO;
+        }
+
+        ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
+                                             preallocation, errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
 
     ret = 0;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e7d4fb539b..77d1f50d55 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4955,7 +4955,8 @@
 #
 # Driver specific image creation options for LUKS.
 #
-# @file: Node to create the image format on
+# @file: Node to create the image format on, mandatory except when
+#        'preallocation' is not requested
 #
 # @size: Size of the virtual disk in bytes
 #
@@ -4966,7 +4967,7 @@
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
-  'data': { 'file':             'BlockdevRef',
+  'data': { '*file':            'BlockdevRef',
             'size':             'size',
             '*preallocation':   'PreallocMode' } }
 
-- 
2.43.0


