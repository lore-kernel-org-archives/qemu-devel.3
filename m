Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8E3C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVo-00033D-03; Fri, 09 Feb 2024 09:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVj-0002tk-Dg
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVg-0004MF-C7
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJYcAf0Y5sYGj5/vIgJLjZ1whtgFXwC88K3zidLTLyE=;
 b=OxA0OpKCjnl/86xklhK9mPxWDe/bbzncMEEu9FepFyWHGD5DiQkNwxeWv/xhRIiC2HedQM
 Ch+85dHizabCAF4ZQ6tO/BWPm841UYdZwpBCQFSTMgsKQ7krqW9ZXF7cKMi4V7+Zgz3ZH6
 t20gUJ5HQ40auzRgi5hPR+ABTI6o+nA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-4YPm45gDMJ2NVWyUYAPlvg-1; Fri,
 09 Feb 2024 09:05:40 -0500
X-MC-Unique: 4YPm45gDMJ2NVWyUYAPlvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F10B1C0F478;
 Fri,  9 Feb 2024 14:05:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA0C1111FF;
 Fri,  9 Feb 2024 14:05:36 +0000 (UTC)
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
Subject: [PULL 11/17] crypto: Support LUKS volume with detached header
Date: Fri,  9 Feb 2024 14:04:59 +0000
Message-ID: <20240209140505.2536635-12-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

By enhancing the LUKS driver, it is possible to implement
the LUKS volume with a detached header.

Normally a LUKS volume has a layout:
  disk:  | header | key material | disk payload data |

With a detached LUKS header, you need 2 disks so getting:
  disk1:  | header | key material |
  disk2:  | disk payload data |

There are a variety of benefits to doing this:
 * Secrecy - the disk2 cannot be identified as containing LUKS
             volume since there's no header
 * Control - if access to the disk1 is restricted, then even
             if someone has access to disk2 they can't unlock
             it. Might be useful if you have disks on NFS but
             want to restrict which host can launch a VM
             instance from it, by dynamically providing access
             to the header to a designated host
 * Flexibility - your application data volume may be a given
                 size and it is inconvenient to resize it to
                 add encryption.You can store the LUKS header
                 separately and use the existing storage
                 volume for payload
 * Recovery - corruption of a bit in the header may make the
              entire payload inaccessible. It might be
              convenient to take backups of the header. If
              your primary disk header becomes corrupt, you
              can unlock the data still by pointing to the
              backup detached header

Take the raw-format image as an example to introduce the usage
of the LUKS volume with a detached header:

1. prepare detached LUKS header images
$ dd if=/dev/zero of=test-header.img bs=1M count=32
$ dd if=/dev/zero of=test-payload.img bs=1M count=1000
$ cryptsetup luksFormat --header test-header.img test-payload.img
> --force-password --type luks1

2. block-add a protocol blockdev node of payload image
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> "filename":"test-payload.img"}}'

3. block-add a protocol blockdev node of LUKS header as above.
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> "filename": "test-header.img" }}'

4. object-add the secret for decrypting the cipher stored in
   LUKS header above
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type":"secret", "id":
> "libvirt-2-storage-secret0", "data":"abc123"}}'

5. block-add the raw-drived blockdev format node
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-format", "driver":"raw",
> "file":"libvirt-1-storage"}}'

6. block-add the luks-drived blockdev to link the raw disk
   with the LUKS header by specifying the field "header"
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> "file":"libvirt-1-format", "header":"libvirt-2-storage",
> "key-secret":"libvirt-2-format-secret0"}}'

7. hot-plug the virtio-blk device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
> "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> "drive": "libvirt-2-format", "id":"virtio-disk2"}}'

Starting a VM with a LUKS volume with detached header is
somewhat similar to hot-plug in that both maintaining the
same json command while the starting VM changes the
"blockdev-add/device_add" parameters to "blockdev/device".

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c         | 21 +++++++++++++++++++--
 crypto/block-luks.c    | 11 +++++++----
 include/crypto/block.h |  5 +++++
 qapi/block-core.json   |  5 ++++-
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 921933a5e5..68656158e9 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;
 struct BlockCrypto {
     QCryptoBlock *block;
     bool updating_keys;
+    BdrvChild *header;  /* Reference to the detached LUKS header */
 };
 
 
@@ -63,12 +64,14 @@ static int block_crypto_read_func(QCryptoBlock *block,
                                   Error **errp)
 {
     BlockDriverState *bs = opaque;
+    BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
+    ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
+                     offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
         return ret;
@@ -84,12 +87,14 @@ static int block_crypto_write_func(QCryptoBlock *block,
                                    Error **errp)
 {
     BlockDriverState *bs = opaque;
+    BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    ret = bdrv_pwrite(bs->file, offset, buflen, buf, 0);
+    ret = bdrv_pwrite(crypto->header ? crypto->header : bs->file,
+                      offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not write encryption header");
         return ret;
@@ -262,6 +267,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
                                      int flags,
                                      Error **errp)
 {
+    ERRP_GUARD();
+
     BlockCrypto *crypto = bs->opaque;
     QemuOpts *opts = NULL;
     int ret;
@@ -276,6 +283,13 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         return ret;
     }
 
+    crypto->header = bdrv_open_child(NULL, options, "header", bs,
+                                     &child_of_bds, BDRV_CHILD_METADATA,
+                                     true, errp);
+    if (*errp != NULL) {
+        return -EINVAL;
+    }
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     bs->supported_write_flags = BDRV_REQ_FUA &
@@ -299,6 +313,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     if (flags & BDRV_O_NO_IO) {
         cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
     }
+    if (crypto->header != NULL) {
+        cflags |= QCRYPTO_BLOCK_OPEN_DETACHED;
+    }
     crypto->block = qcrypto_block_open(open_opts, NULL,
                                        block_crypto_read_func,
                                        bs,
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index f0813d69b4..7e1235c213 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -468,12 +468,15 @@ qcrypto_block_luks_load_header(QCryptoBlock *block,
  * Does basic sanity checks on the LUKS header
  */
 static int
-qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
+qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks,
+                                unsigned int flags,
+                                Error **errp)
 {
     size_t i, j;
 
     unsigned int header_sectors = QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
+    bool detached = flags & QCRYPTO_BLOCK_OPEN_DETACHED;
 
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
@@ -505,7 +508,7 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
         return -1;
     }
 
-    if (luks->header.payload_offset_sector <
+    if (!detached && luks->header.payload_offset_sector <
         DIV_ROUND_UP(QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET,
                      QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) {
         error_setg(errp, "LUKS payload is overlapping with the header");
@@ -554,7 +557,7 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
             return -1;
         }
 
-        if (start1 + len1 > luks->header.payload_offset_sector) {
+        if (!detached && start1 + len1 > luks->header.payload_offset_sector) {
             error_setg(errp,
                        "Keyslot %zu is overlapping with the encrypted payload",
                        i);
@@ -1214,7 +1217,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
 
-    if (qcrypto_block_luks_check_header(luks, errp) < 0) {
+    if (qcrypto_block_luks_check_header(luks, flags, errp) < 0) {
         goto fail;
     }
 
diff --git a/include/crypto/block.h b/include/crypto/block.h
index 4f63a37872..d0d97f5d12 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -66,6 +66,7 @@ bool qcrypto_block_has_format(QCryptoBlockFormat format,
 
 typedef enum {
     QCRYPTO_BLOCK_OPEN_NO_IO = (1 << 0),
+    QCRYPTO_BLOCK_OPEN_DETACHED = (1 << 1),
 } QCryptoBlockOpenFlags;
 
 /**
@@ -95,6 +96,10 @@ typedef enum {
  * metadata such as the payload offset. There will be
  * no cipher or ivgen objects available.
  *
+ * If @flags contains QCRYPTO_BLOCK_OPEN_DETACHED then
+ * the open process will be optimized to skip the LUKS
+ * payload overlap check.
+ *
  * If any part of initializing the encryption context
  * fails an error will be returned. This could be due
  * to the volume being in the wrong format, a cipher
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 781c9bd03e..e7d4fb539b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3365,11 +3365,14 @@
 #     decryption key (since 2.6). Mandatory except when doing a
 #     metadata-only probe of the image.
 #
+# @header: block device holding a detached LUKS header. (since 9.0)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsLUKS',
   'base': 'BlockdevOptionsGenericFormat',
-  'data': { '*key-secret': 'str' } }
+  'data': { '*key-secret': 'str',
+            '*header': 'BlockdevRef'} }
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
-- 
2.43.0


