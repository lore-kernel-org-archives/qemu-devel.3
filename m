Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E669C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSlp-0002qS-Qm; Mon, 11 Aug 2025 09:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulSli-0002fu-QI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulSlZ-0006h4-Dw
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754919641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8ifXcbcW3LahlNhz9WFHoplhn53S+cE/3EcIegOCnb4=;
 b=P1aro1B0JbPstFDPVxnAkswDICnHo09DgQQqUqWEjiri8UaxKtsGgTtw/gDWDYLvsIwtuI
 mMHwJy5wB+ficJ2TRtxKf/KnhLzDfVgyMmhmJhmknr1qRB14ssthbNPXLhop+bS1CvMZJx
 y/sw7G9jLTa89zTJJMEigfBjM+dGLW4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-vyfeHHlrPVaAiwVugN1kMQ-1; Mon,
 11 Aug 2025 09:40:37 -0400
X-MC-Unique: vyfeHHlrPVaAiwVugN1kMQ-1
X-Mimecast-MFC-AGG-ID: vyfeHHlrPVaAiwVugN1kMQ_1754919635
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 057F21956058; Mon, 11 Aug 2025 13:40:35 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.151])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE2581955F16; Mon, 11 Aug 2025 13:40:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, idryomov@gmail.com, pl@dlhnet.de,
 eblake@redhat.com, armbru@redhat.com, oro@il.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH] rbd: Fix .bdrv_get_specific_info implementation
Date: Mon, 11 Aug 2025 15:40:10 +0200
Message-ID: <20250811134010.81787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

qemu_rbd_get_specific_info() has at least two problems:

The first is that it issues a blocking rbd_read() call in order to probe
the encryption format for the image while querying the node. This means
that if the connection to the server goes down, not only I/O is stuck
(which is unavoidable), but query-names-block-nodes will actually make
the whole QEMU instance unresponsive. .bdrv_get_specific_info
implementations shouldn't perform blocking operations, but only return
what is already known.

The second is that the information returned isn't even correct. If the
image is already opened with encryption enabled at the RBD level, we'll
probe for "double encryption", i.e. if the encrypted data contains
another encryption header. If it doesn't (which is the normal case), we
won't return the encryption format. If it does, we return misleading
information because it looks like we're talking about the outer level
(the encryption format of the image itself) while the information is
about an encryption header in the guest data.

Fix this by storing the encryption format in BDRVRBDState when the image
is opened (and we do blocking operations anyway) and returning only the
stored information in qemu_rbd_get_specific_info().

The information we'll store is either the actual encryption format that
we enabled on the RBD level, or if the image is unencrypted, the result
of the same probing as we previously did when querying the node. Probing
image formats based on content that can be modified by the guest has
long been known as problematic, but as long as we only output it to the
user instead of making decisions based on it, it should be okay. It is
undoubtedly useful in the context of 'qemu-img info' when you're trying
to figure out which encryption options you have to use to open the
image successfully.

Fixes: 42e4ac9ef5a6 ("block/rbd: Add support for rbd image encryption")
Buglink: https://issues.redhat.com/browse/RHEL-105440
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |   9 +++-
 block/rbd.c          | 103 ++++++++++++++++++++++++++++---------------
 2 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ebbe95b3d8..cbd2bc84fe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -159,7 +159,14 @@
 ##
 # @ImageInfoSpecificRbd:
 #
-# @encryption-format: Image encryption format
+# @encryption-format: Image encryption format. If encryption is enabled for the
+#     image (see encrpyted in BlockNodeInfo), this is the actual format in which the
+#     image is accessed. If encryption is not enabled, this is the result of
+#     probing when the image was opened, to give a suggestion which encryption
+#     format could be enabled. Note that probing results can be changed by the
+#     guest by writing a (possibly partial) encryption format header to the
+#     image, so don't treat this information as trusted if the guest is not
+#     trusted.
 #
 # Since: 6.1
 ##
diff --git a/block/rbd.c b/block/rbd.c
index 951cd63f9a..8582bc8360 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -99,6 +99,14 @@ typedef struct BDRVRBDState {
     char *namespace;
     uint64_t image_size;
     uint64_t object_size;
+
+    /*
+     * If @bs->encrypted is true, this is the encryption format actually loaded
+     * at the librbd level. If it is false, it is the result of probing.
+     * RBD_IMAGE_ENCRYPTION_FORMAT__MAX means that encryption is not enabled and
+     * probing didn't find any known encryption header either.
+     */
+    RbdImageEncryptionFormat encryption_format;
 } BDRVRBDState;
 
 typedef struct RBDTask {
@@ -470,10 +478,12 @@ static int qemu_rbd_encryption_format(rbd_image_t image,
     return 0;
 }
 
-static int qemu_rbd_encryption_load(rbd_image_t image,
+static int qemu_rbd_encryption_load(BlockDriverState *bs,
+                                    rbd_image_t image,
                                     RbdEncryptionOptions *encrypt,
                                     Error **errp)
 {
+    BDRVRBDState *s = bs->opaque;
     int r = 0;
     g_autofree char *passphrase = NULL;
     rbd_encryption_luks1_format_options_t luks_opts;
@@ -544,15 +554,19 @@ static int qemu_rbd_encryption_load(rbd_image_t image,
         error_setg_errno(errp, -r, "encryption load fail");
         return r;
     }
+    bs->encrypted = true;
+    s->encryption_format = encrypt->format;
 
     return 0;
 }
 
 #ifdef LIBRBD_SUPPORTS_ENCRYPTION_LOAD2
-static int qemu_rbd_encryption_load2(rbd_image_t image,
+static int qemu_rbd_encryption_load2(BlockDriverState *bs,
+                                     rbd_image_t image,
                                      RbdEncryptionOptions *encrypt,
                                      Error **errp)
 {
+    BDRVRBDState *s = bs->opaque;
     int r = 0;
     int encrypt_count = 1;
     int i;
@@ -638,6 +652,8 @@ static int qemu_rbd_encryption_load2(rbd_image_t image,
         error_setg_errno(errp, -r, "layered encryption load fail");
         goto exit;
     }
+    bs->encrypted = true;
+    s->encryption_format = encrypt->format;
 
 exit:
     for (i = 0; i < encrypt_count; ++i) {
@@ -671,6 +687,44 @@ exit:
 #endif
 #endif
 
+/*
+ * For an image without encryption enabled on the rbd layer, probe the start of
+ * the image if it could be opened as an encrypted image so that we can display
+ * it when the user queries the node (most importantly in qemu-img).
+ *
+ * If the guest writes an encryption header to its disk after this probing, but
+ * that's okay. There is no reason why the user should want to apply encryption
+ * at the rbd level while the image is still in use. This is just guest data.
+ */
+static void qemu_rbd_encryption_probe(BlockDriverState *bs)
+{
+    BDRVRBDState *s = bs->opaque;
+    char buf[RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN] = {0};
+    int r;
+
+    assert(s->encryption_format == RBD_IMAGE_ENCRYPTION_FORMAT__MAX);
+
+    r = rbd_read(s->image, 0,
+                 RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN, buf);
+    if (r < RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) {
+        return;
+    }
+
+    if (memcmp(buf, rbd_luks_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
+    } else if (memcmp(buf, rbd_luks2_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
+    } else if (memcmp(buf, rbd_layered_luks_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
+    } else if (memcmp(buf, rbd_layered_luks2_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
+    }
+}
+
 /* FIXME Deprecate and remove keypairs or make it available in QMP. */
 static int qemu_rbd_do_create(BlockdevCreateOptions *options,
                               const char *keypairs, const char *password_secret,
@@ -1133,17 +1187,18 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_open;
     }
 
+    s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT__MAX;
     if (opts->encrypt) {
 #ifdef LIBRBD_SUPPORTS_ENCRYPTION
         if (opts->encrypt->parent) {
 #ifdef LIBRBD_SUPPORTS_ENCRYPTION_LOAD2
-            r = qemu_rbd_encryption_load2(s->image, opts->encrypt, errp);
+            r = qemu_rbd_encryption_load2(bs, s->image, opts->encrypt, errp);
 #else
             r = -ENOTSUP;
             error_setg(errp, "RBD library does not support layered encryption");
 #endif
         } else {
-            r = qemu_rbd_encryption_load(s->image, opts->encrypt, errp);
+            r = qemu_rbd_encryption_load(bs, s->image, opts->encrypt, errp);
         }
         if (r < 0) {
             goto failed_post_open;
@@ -1153,6 +1208,8 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         error_setg(errp, "RBD library does not support image encryption");
         goto failed_post_open;
 #endif
+    } else {
+        qemu_rbd_encryption_probe(bs);
     }
 
     r = rbd_stat(s->image, &info, sizeof(info));
@@ -1412,17 +1469,6 @@ static ImageInfoSpecific *qemu_rbd_get_specific_info(BlockDriverState *bs,
 {
     BDRVRBDState *s = bs->opaque;
     ImageInfoSpecific *spec_info;
-    char buf[RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN] = {0};
-    int r;
-
-    if (s->image_size >= RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) {
-        r = rbd_read(s->image, 0,
-                     RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN, buf);
-        if (r < 0) {
-            error_setg_errno(errp, -r, "cannot read image start for probe");
-            return NULL;
-        }
-    }
 
     spec_info = g_new(ImageInfoSpecific, 1);
     *spec_info = (ImageInfoSpecific){
@@ -1430,28 +1476,13 @@ static ImageInfoSpecific *qemu_rbd_get_specific_info(BlockDriverState *bs,
         .u.rbd.data = g_new0(ImageInfoSpecificRbd, 1),
     };
 
-    if (memcmp(buf, rbd_luks_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
-        spec_info->u.rbd.data->has_encryption_format = true;
-    } else if (memcmp(buf, rbd_luks2_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
-        spec_info->u.rbd.data->has_encryption_format = true;
-    } else if (memcmp(buf, rbd_layered_luks_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
-        spec_info->u.rbd.data->has_encryption_format = true;
-    } else if (memcmp(buf, rbd_layered_luks2_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
-        spec_info->u.rbd.data->has_encryption_format = true;
+    if (s->encryption_format == RBD_IMAGE_ENCRYPTION_FORMAT__MAX) {
+        assert(!bs->encrypted);
     } else {
-        spec_info->u.rbd.data->has_encryption_format = false;
+        ImageInfoSpecificRbd *rbd_info = spec_info->u.rbd.data;
+
+        rbd_info->has_encryption_format = true;
+        rbd_info->encryption_format = s->encryption_format;
     }
 
     return spec_info;
-- 
2.50.1


