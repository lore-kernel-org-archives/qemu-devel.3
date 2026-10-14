Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E4CCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGue9-0005UM-8y; Wed, 14 Oct 2026 04:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGue0-0005Nw-92
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudy-0004YS-KT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNcN8qWHBnBxaCUAyi9IZQKU123r3Q1m9fzcP/y+4hY=;
 b=VL1dQcKVM8vr0yNX8EVogZKYFeB1uFw8AqB5lmqumNcwmItAAlWZuUh1epai8/LdrMpKIS
 SNHWaMnslxesr4+bzbcBIvbe5xVRP2ochyI7Z42v3M8meS9E5b3tPFwBxR48Rb6V5y3hWU
 zST0tBeZBcD6LH1cPp1HTq5gW4D70zM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-E6Hpcus8OIOHyHBQnPJqRw-1; Wed,
 14 Oct 2026 08:47:18 +0000
X-MC-Unique: E6Hpcus8OIOHyHBQnPJqRw-1
X-Mimecast-MFC-AGG-ID: E6Hpcus8OIOHyHBQnPJqRw_1791967637
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B748E195609E; Wed, 14 Oct 2026 08:47:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3249B1800495; Wed, 14 Oct 2026 08:47:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 04/17] igb: Add VF state serialization for live
 migration
Date: Wed, 14 Oct 2026 10:46:42 +0200
Message-ID: <20261014084655.127254-5-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the migration blob format and the SAVE/LOAD command plumbing.
Define IgbMigBlob with a header (magic, version, VF number) and add
error codes for blob validation (BAD_MAGIC, BAD_VERSION, BAD_VFN,
BAD_DATA).

On save, fill the header and report the blob size via DATA_SIZE.  On
load, validate the header fields before touching any device state.
Subsequent patches extend the blob with register, TX context, RA, and
VLVF substates.

AI-used-for: code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.h |  4 +++
 hw/net/igb_migration.c | 55 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index 34d643854a28..d05252992f9e 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -73,6 +73,10 @@
 #define IGB_MIG_ERR_NO_BUFFER           3
 #define IGB_MIG_ERR_DMA_FAILED          4
 #define IGB_MIG_ERR_BAD_SIZE            5
+#define IGB_MIG_ERR_BAD_MAGIC           6
+#define IGB_MIG_ERR_BAD_VERSION         7
+#define IGB_MIG_ERR_BAD_VFN             8
+#define IGB_MIG_ERR_BAD_DATA            9
 
 /* Shared buffer constants */
 #define IGB_VF_STATE_MAX_SIZE           4096
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 174df22232a5..de982909bbf2 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -19,9 +19,36 @@
  * Per-VF state serialization / deserialization
  */
 
+#define IGB_MIG_BLOB_MAGIC        0x4D494742  /* "MIGB" */
+#define IGB_MIG_BLOB_VERSION      1
+
+typedef struct IgbMigBlob {
+    uint32_t magic;
+    uint32_t version;
+    uint32_t vfn;
+} IgbMigBlob;
+
+#define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
+
+QEMU_BUILD_BUG_ON(IGB_MIG_BLOB_SIZE > IGB_VF_STATE_MAX_SIZE);
+
+
 static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 {
-    int size = 0;
+    int size = IGB_MIG_BLOB_SIZE;
+    IgbMigBlob *blob = buf;
+
+    if (!buf) {
+        return size;
+    }
+
+    if (size > buf_size) {
+        return -IGB_MIG_ERR_BAD_SIZE;
+    }
+
+    blob->magic = cpu_to_le32(IGB_MIG_BLOB_MAGIC);
+    blob->version = cpu_to_le32(IGB_MIG_BLOB_VERSION);
+    blob->vfn = cpu_to_le32(s->vfn);
 
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
@@ -29,11 +56,35 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 
 static int igb_core_vf_max_data_size(IgbVfState *s)
 {
-    return sizeof(s->mig.mig_data);
+    int size = igb_core_vf_save_state(s, NULL, 0);
+
+    g_assert(size > 0 && size <= IGB_VF_STATE_MAX_SIZE);
+    return size;
 }
 
 static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 {
+    const IgbMigBlob *blob = buf;
+    uint32_t magic, version, saved_vfn;
+
+    /* Validate blob header */
+    if (size < IGB_MIG_BLOB_SIZE) {
+        return -IGB_MIG_ERR_BAD_SIZE;
+    }
+
+    magic = le32_to_cpu(blob->magic);
+    version = le32_to_cpu(blob->version);
+    saved_vfn = le32_to_cpu(blob->vfn);
+    if (magic != IGB_MIG_BLOB_MAGIC) {
+        return -IGB_MIG_ERR_BAD_MAGIC;
+    }
+    if (version != IGB_MIG_BLOB_VERSION) {
+        return -IGB_MIG_ERR_BAD_VERSION;
+    }
+    if (saved_vfn != s->vfn) {
+        return -IGB_MIG_ERR_BAD_VFN;
+    }
+
     trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
     return 0;
 }
-- 
2.56.0


