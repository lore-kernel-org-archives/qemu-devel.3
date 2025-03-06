Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D09C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3D-0002Qm-60; Thu, 06 Mar 2025 09:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC10-0008Cv-VN
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0y-0001sv-4R
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkN4XUrq6jE3dyokE7nPL9/x74SW8PtHvl3wLbGC1Ns=;
 b=DdxYooD9wnYazeyuxxwCHlTQQSLyDDQLhwW8cytwyPc6pKf59a4NL73CKwC1PpqmtmARq0
 3zALTIKdwROKY2BImsN1Z34wOZ9fPh9acpXecaKn4SYV3RCCkY97WqsaWJYBpZL60VI8kQ
 +c2PSZCsu0J9nin+rB5vPqku49qDdPI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-NZwlYBCqNGG2xeCXCnG01g-1; Thu,
 06 Mar 2025 09:15:42 -0500
X-MC-Unique: NZwlYBCqNGG2xeCXCnG01g-1
X-Mimecast-MFC-AGG-ID: NZwlYBCqNGG2xeCXCnG01g_1741270541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 465C61800349; Thu,  6 Mar 2025 14:15:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24A6C180174C; Thu,  6 Mar 2025 14:15:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/42] migration/multifd: Make MultiFDSendData a struct
Date: Thu,  6 Mar 2025 15:14:00 +0100
Message-ID: <20250306141419.2015340-25-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

The newly introduced device state buffer can be used for either storing
VFIO's read() raw data, but already also possible to store generic device
states.  After noticing that device states may not easily provide a max
buffer size (also the fact that RAM MultiFDPages_t after all also want to
have flexibility on managing offset[] array), it may not be a good idea to
stick with union on MultiFDSendData.. as it won't play well with such
flexibility.

Switch MultiFDSendData to a struct.

It won't consume a lot more space in reality, after all the real buffers
were already dynamically allocated, so it's so far only about the two
structs (pages, device_state) that will be duplicated, but they're small.

With this, we can remove the pretty hard to understand alloc size logic.
Because now we can allocate offset[] together with the SendData, and
properly free it when the SendData is freed.

[MSS: Make sure to clear possible device state payload before freeing
MultiFDSendData, remove placeholders for other patches not included]

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/7b02baba8e6ddb23ef7c349d312b9b631db09d7e.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/multifd.h              | 15 +++++++++------
 migration/multifd-device-state.c |  5 -----
 migration/multifd-nocomp.c       | 13 ++++++-------
 migration/multifd.c              | 25 +++++++------------------
 4 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index aa679d8bbe8358e5cbab0add9c4bf007fa55961b..2d337e7b3b52fd005a6c342fb552975e8f13bdf1 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -115,9 +115,13 @@ typedef struct {
     uint32_t num;
     /* number of normal pages */
     uint32_t normal_num;
+    /*
+     * Pointer to the ramblock.  NOTE: it's caller's responsibility to make
+     * sure the pointer is always valid!
+     */
     RAMBlock *block;
-    /* offset of each page */
-    ram_addr_t offset[];
+    /* offset array of each page, managed by multifd */
+    ram_addr_t *offset;
 } MultiFDPages_t;
 
 struct MultiFDRecvData {
@@ -140,7 +144,7 @@ typedef enum {
     MULTIFD_PAYLOAD_DEVICE_STATE,
 } MultiFDPayloadType;
 
-typedef union MultiFDPayload {
+typedef struct MultiFDPayload {
     MultiFDPages_t ram;
     MultiFDDeviceState_t device_state;
 } MultiFDPayload;
@@ -394,12 +398,11 @@ void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
 bool multifd_ram_sync_per_round(void);
 bool multifd_ram_sync_per_section(void);
-size_t multifd_ram_payload_size(void);
+void multifd_ram_payload_alloc(MultiFDPages_t *pages);
+void multifd_ram_payload_free(MultiFDPages_t *pages);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
 
-size_t multifd_device_state_payload_size(void);
-
 void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state);
 
 void multifd_device_state_send_setup(void);
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index e383e75b1a024c1885b41bcc3aee034fd6f71f9d..64d8ca180167b09abf13c9302326404be236717e 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -20,11 +20,6 @@ static struct {
     MultiFDSendData *send_data;
 } *multifd_send_device_state;
 
-size_t multifd_device_state_payload_size(void)
-{
-    return sizeof(MultiFDDeviceState_t);
-}
-
 void multifd_device_state_send_setup(void)
 {
     assert(!multifd_send_device_state);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index c00804652383ed0496769c134ea2c10e0ae91f18..ffe75256c9fbe459dee4eb4aa8f80ae013ff2d87 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -25,15 +25,14 @@
 
 static MultiFDSendData *multifd_ram_send;
 
-size_t multifd_ram_payload_size(void)
+void multifd_ram_payload_alloc(MultiFDPages_t *pages)
 {
-    uint32_t n = multifd_ram_page_count();
+    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
+}
 
-    /*
-     * We keep an array of page offsets at the end of MultiFDPages_t,
-     * add space for it in the allocation.
-     */
-    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+void multifd_ram_payload_free(MultiFDPages_t *pages)
+{
+    g_clear_pointer(&pages->offset, g_free);
 }
 
 void multifd_ram_save_setup(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index 3625c9a37c0e046b7a851dfe3d94fefa6887534d..dfb5189f0ea3da97370b81e2dcf5a7f86252ae29 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -105,26 +105,12 @@ struct {
 
 MultiFDSendData *multifd_send_data_alloc(void)
 {
-    size_t max_payload_size, size_minus_payload;
+    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
 
-    /*
-     * MultiFDPages_t has a flexible array at the end, account for it
-     * when allocating MultiFDSendData. Use max() in case other types
-     * added to the union in the future are larger than
-     * (MultiFDPages_t + flex array).
-     */
-    max_payload_size = MAX(multifd_ram_payload_size(),
-                           multifd_device_state_payload_size());
-    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
-
-    /*
-     * Account for any holes the compiler might insert. We can't pack
-     * the structure because that misaligns the members and triggers
-     * Waddress-of-packed-member.
-     */
-    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
+    multifd_ram_payload_alloc(&new->u.ram);
+    /* Device state allocates its payload on-demand */
 
-    return g_malloc0(size_minus_payload + max_payload_size);
+    return new;
 }
 
 void multifd_send_data_clear(MultiFDSendData *data)
@@ -151,8 +137,11 @@ void multifd_send_data_free(MultiFDSendData *data)
         return;
     }
 
+    /* This also free's device state payload */
     multifd_send_data_clear(data);
 
+    multifd_ram_payload_free(&data->u.ram);
+
     g_free(data);
 }
 
-- 
2.48.1


