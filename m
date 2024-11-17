Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B242D10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqF-0002iJ-Qi; Sun, 17 Nov 2024 14:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqE-0002hs-7Z
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:50 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqC-0005tG-Qx
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:50 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkq8-00000002GTt-37PJ; Sun, 17 Nov 2024 20:21:44 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 07/24] migration: Document the BQL behavior of load
 SaveVMHandlers
Date: Sun, 17 Nov 2024 20:20:02 +0100
Message-ID: <e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Some of these SaveVMHandlers were missing the BQL behavior annotation,
making people wonder what it exactly is.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 39991f3cc5d0..761e4e4d8bcb 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -212,6 +212,8 @@ typedef struct SaveVMHandlers {
     void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
                                 uint64_t *can_postcopy);
 
+    /* This runs inside the BQL. */
+
     /**
      * @load_state
      *
@@ -246,6 +248,8 @@ typedef struct SaveVMHandlers {
     int (*load_state_buffer)(void *opaque, char *buf, size_t len,
                              Error **errp);
 
+    /* The following handlers run inside the BQL. */
+
     /**
      * @load_setup
      *
@@ -272,6 +276,9 @@ typedef struct SaveVMHandlers {
      */
     int (*load_cleanup)(void *opaque);
 
+
+    /* This runs outside the BQL. */
+
     /**
      * @resume_prepare
      *
@@ -284,6 +291,8 @@ typedef struct SaveVMHandlers {
      */
     int (*resume_prepare)(MigrationState *s, void *opaque);
 
+    /* The following handlers run inside the BQL. */
+
     /**
      * @switchover_ack_needed
      *

