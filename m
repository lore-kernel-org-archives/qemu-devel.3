Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58222C7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTc9X-0003jP-5b; Mon, 23 Jun 2025 04:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTc9V-0003he-6A
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTc9T-0005R4-Kz
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750665818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KlwW7rHPzgnSyCV2eeGFhISA6m3Qw0iFumgdKkgm52Y=;
 b=KTocSDPDK0obPtlMBPffkb2cMHoonhbBxsjL/5Gg8Bl7BPIcKxGBFrL8EVztDp38KQbtBi
 ZLQAmLV81NPruCfdxo+luayBohtJ7xbC76dHtGDUAJ473L1u/8hH/cXmHrppDSY4VpyKCS
 GWHcEiYPiExPY8IpVhgWTY8pX91IgSE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-BxMdjGyOP6uyutf5U2RSRQ-1; Mon,
 23 Jun 2025 04:03:32 -0400
X-MC-Unique: BxMdjGyOP6uyutf5U2RSRQ-1
X-Mimecast-MFC-AGG-ID: BxMdjGyOP6uyutf5U2RSRQ_1750665811
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68AB31956095; Mon, 23 Jun 2025 08:03:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA5CB1956096; Mon, 23 Jun 2025 08:03:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] i386/tdx: Fix build on 32-bit host
Date: Mon, 23 Jun 2025 10:03:25 +0200
Message-ID: <20250623080325.462255-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/i386/kvm/tdx-quote-generator.c |  6 +++---
 target/i386/kvm/tdx.c                 | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-quote-generator.c
index f59715f61751..3a31a4a68365 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -113,7 +113,7 @@ static gboolean tdx_get_quote_read(QIOChannel *ioc, GIOCondition condition,
                                      task->receive_buf_received);
         if (len == 0 ||
             len > (task->payload_len - HEADER_SIZE)) {
-            error_report("Message len %u must be non-zero & less than %zu",
+            error_report("Message len %u must be non-zero & less than %"PRIu64,
                          len, (task->payload_len - HEADER_SIZE));
             task->status_code = TDX_VP_GET_QUOTE_ERROR;
             goto end;
@@ -143,7 +143,7 @@ static gboolean tdx_get_quote_read(QIOChannel *ioc, GIOCondition condition,
             goto end;
         }
         if (hdr->size > (task->payload_len - HEADER_SIZE)) {
-            error_report("QGS message size %d exceeds payload capacity %zu",
+            error_report("QGS message size %d exceeds payload capacity %"PRIu64,
                          hdr->size, task->payload_len);
             task->status_code = TDX_VP_GET_QUOTE_ERROR;
             goto end;
@@ -166,7 +166,7 @@ static gboolean tdx_get_quote_read(QIOChannel *ioc, GIOCondition condition,
 
         if ((task->payload_len - HEADER_SIZE - sizeof(qgs_msg_get_quote_resp_t)) !=
             msg->quote_size) {
-            error_report("QGS quote size %d should be %zu",
+            error_report("QGS quote size %d should be %"PRIu64,
                          msg->quote_size,
                          (task->payload_len - sizeof(qgs_msg_get_quote_resp_t)));
             task->status_code = TDX_VP_GET_QUOTE_ERROR;
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e809e4b2dfa2..c98109dadc2e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1035,8 +1035,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX 'mrconfigid' sha384 digest was %ld bytes, "
-                             "expected %d bytes", data_len,
+            error_setg(errp, "TDX 'mrconfigid' sha384 digest was %"PRId64" bytes, "
+                             "expected %d bytes", (uint64_t)data_len,
                              QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
@@ -1050,8 +1050,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX 'mrowner' sha384 digest was %ld bytes, "
-                             "expected %d bytes", data_len,
+            error_setg(errp, "TDX 'mrowner' sha384 digest was %"PRId64" bytes, "
+                             "expected %d bytes", (uint64_t)data_len,
                              QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
@@ -1065,8 +1065,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX 'mrownerconfig' sha384 digest was %ld bytes, "
-                             "expected %d bytes", data_len,
+            error_setg(errp, "TDX 'mrownerconfig' sha384 digest was %"PRId64" bytes, "
+                             "expected %d bytes", (uint64_t)data_len,
                              QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
-- 
2.49.0


