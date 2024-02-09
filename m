Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1504CC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRWV-000449-5z; Fri, 09 Feb 2024 09:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVu-0003Lg-QW
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVt-0004Oi-1n
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8q6WNuCQ5ujhz+esbtmOnu3eU7hsG3E8wvWMwRZVAYc=;
 b=XKCDSeZw3x6YAA1uaJ2BMBq8aph0DCpdzQpyOOyfrm9L1N1y8y+GQFxfyof/Cn+sbcBm+9
 ay4Qxdn+30KB/4qt0j1TxJRqNl7fhRBtk6/hJACAuAnusBOJ7qe69N0V+Z4udaINGTQ0bm
 EZfnesvycufioUPoqlMZyPCwJXQf1+M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-U8DyuTC9MZGk8xWqqbXPLQ-1; Fri,
 09 Feb 2024 09:05:54 -0500
X-MC-Unique: U8DyuTC9MZGk8xWqqbXPLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DA3529AA3B7;
 Fri,  9 Feb 2024 14:05:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 225D4112A1;
 Fri,  9 Feb 2024 14:05:51 +0000 (UTC)
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
Subject: [PULL 16/17] crypto: Introduce 'detached-header' field in
 QCryptoBlockInfoLUKS
Date: Fri,  9 Feb 2024 14:05:04 +0000
Message-ID: <20240209140505.2536635-17-berrange@redhat.com>
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

When querying the LUKS disk with the qemu-img tool or other APIs,
add information about whether the LUKS header is detached.

Additionally, update the test case with the appropriate
modification.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/block-luks.c        | 2 ++
 qapi/crypto.json           | 3 +++
 tests/qemu-iotests/210.out | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index ab52c9dce1..3ee928fb5a 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1271,6 +1271,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset_sector *
         block->sector_size;
+    block->detached_header = (block->payload_offset == 0) ? true : false;
 
     return 0;
 
@@ -1895,6 +1896,7 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
     info->u.luks.master_key_iters = luks->header.master_key_iterations;
     info->u.luks.uuid = g_strndup((const char *)luks->header.uuid,
                                   sizeof(luks->header.uuid));
+    info->u.luks.detached_header = block->detached_header;
 
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         slot = g_new0(QCryptoBlockInfoLUKSSlot, 1);
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 22c6cce3ae..ad8dd37175 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -317,6 +317,8 @@
 #
 # @hash-alg: the master key hash algorithm
 #
+# @detached-header: whether the LUKS header is detached (Since 9.0)
+#
 # @payload-offset: offset to the payload data in bytes
 #
 # @master-key-iters: number of PBKDF2 iterations for key material
@@ -333,6 +335,7 @@
            'ivgen-alg': 'QCryptoIVGenAlgorithm',
            '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
            'hash-alg': 'QCryptoHashAlgorithm',
+           'detached-header': 'bool',
            'payload-offset': 'int',
            'master-key-iters': 'int',
            'uuid': 'str',
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 96d9f749dd..94b29b2120 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -18,6 +18,7 @@ virtual size: 128 MiB (134217728 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -70,6 +71,7 @@ virtual size: 64 MiB (67108864 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha1
     cipher alg: aes-128
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -125,6 +127,7 @@ virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -195,6 +198,7 @@ virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
-- 
2.43.0


