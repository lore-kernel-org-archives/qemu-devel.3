Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6190EC54E92
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhjR-0003aP-OC; Wed, 21 May 2025 07:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjK-0003ZS-CZ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjF-00011Q-Vl
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfYPO1yivZj59r4kdmpa9effDikIteX3GGVpxfn4DKg=;
 b=eBLwUYIz1BGiilh0MmwAYUECqXLru4mn9iHus+DO7OlEKIxioWYpNfaQXzp0pidKUyfTTw
 n5GuERjQaJwwIiD3/114PrsO8fNk939L26QJOgnyipAHIBqgkQY0sSuzxx9eMO3DdQy/kf
 b9VfMuDWg+5xaITPx64A6W5BeMZVGGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-dLQ_FupqP-CVCB8jxXCjpw-1; Wed,
 21 May 2025 07:35:17 -0400
X-MC-Unique: dLQ_FupqP-CVCB8jxXCjpw-1
X-Mimecast-MFC-AGG-ID: dLQ_FupqP-CVCB8jxXCjpw_1747827315
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A16D1850D04; Wed, 21 May 2025 11:35:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A438A19560B7; Wed, 21 May 2025 11:35:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 02/16] migration: introduce support for 128 bit int state.
Date: Wed, 21 May 2025 13:33:56 +0200
Message-ID: <cddc725f0a59e2888613d50735ad8c7a34cd67ba.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio net driver.

For platform natively supporting 128 bits, introduce a 128 bit integer
state.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/migration/qemu-file-types.h | 15 +++++++++++++++
 include/migration/vmstate.h         | 11 +++++++++++
 migration/qemu-file.c               | 16 ++++++++++++++++
 migration/vmstate-types.c           | 25 +++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index adec5abc07..094ace5bb2 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -92,6 +92,21 @@ static inline void qemu_get_8s(QEMUFile *f, uint8_t *pv)
     *pv = qemu_get_byte(f);
 }
 
+#ifdef CONFIG_INT128
+void qemu_put_be128(QEMUFile *f, __uint128_t v);
+__uint128_t qemu_get_be128(QEMUFile *f);
+
+static inline void qemu_put_be128s(QEMUFile *f, const __uint128_t *pv)
+{
+    qemu_put_be128(f, *pv);
+}
+
+static inline void qemu_get_be128s(QEMUFile *f, __uint128_t *pv)
+{
+    *pv = qemu_get_be128(f);
+}
+#endif
+
 /* Signed versions for type safety */
 static inline void qemu_put_sbe16(QEMUFile *f, int v)
 {
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a1dfab4460..9695d4ba06 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -903,6 +903,17 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
 
+#ifdef CONFIG_INT128
+#define VMSTATE_UINT128_V(_f, _s, _v)                                 \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint128, __uint128_t)
+#define VMSTATE_UINT128(_f, _s)                                       \
+    VMSTATE_UINT128_V(_f, _s, 0)
+#define VMSTATE_UINT128_TEST(_f, _s, _t)                              \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int128, __int128_t)
+
+extern const VMStateInfo vmstate_info_uint128;
+#endif
+
 #define VMSTATE_FD_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_fd, int32_t)
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034..3dc7645d3e 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -825,6 +825,22 @@ void qemu_put_be64(QEMUFile *f, uint64_t v)
     qemu_put_be32(f, v);
 }
 
+#ifdef CONFIG_INT128
+void qemu_put_be128(QEMUFile *f, __uint128_t v)
+{
+    qemu_put_be64(f, v >> 64);
+    qemu_put_be64(f, v);
+}
+
+__uint128_t qemu_get_be128(QEMUFile *f)
+{
+    __uint128_t v;
+    v = (__uint128_t)qemu_get_be64(f) << 64;
+    v |= qemu_get_be64(f);
+    return v;
+}
+#endif
+
 unsigned int qemu_get_be16(QEMUFile *f)
 {
     unsigned int v;
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 741a588b7e..120ea1f9cd 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -315,6 +315,31 @@ const VMStateInfo vmstate_info_uint64 = {
     .put  = put_uint64,
 };
 
+/* 128 bit unsigned int */
+#ifdef CONFIG_INT128
+static int get_uint128(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field)
+{
+    __uint128_t *v = pv;
+    qemu_get_be128s(f, v);
+    return 0;
+}
+
+static int put_uint128(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc)
+{
+    __uint128_t *v = pv;
+    qemu_put_be128s(f, v);
+    return 0;
+}
+
+const VMStateInfo vmstate_info_uint128 = {
+    .name = "uint128",
+    .get  = get_uint128,
+    .put  = put_uint128,
+};
+#endif
+
 /* File descriptor communicated via SCM_RIGHTS */
 
 static int get_fd(QEMUFile *f, void *pv, size_t size,
-- 
2.49.0


