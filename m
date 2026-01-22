Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1961D6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2th-0006EO-8Q; Thu, 22 Jan 2026 17:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj2tf-0006Ct-E5
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj2td-0003Jd-IM
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769119878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PKtJn8c2MQEyJjk0IWT+l4K60Rh1a/2U2zxZXpc5Pls=;
 b=Y+eLa4Kf92NWoXIvK8uJ1yoeMei9ci3Fc9VtXWIeRPiWh/8LmYDKBjtbgDiOPQevr82gMo
 nb2+uvGHM0ir7l2BPAjOuiWQ4KzcpGwjRGQkKR/5p/+J4fyiIBYCCEhXzC2EDjaWv12ttf
 0IA0d/8VNS2J+/Ci5kJjn5jeMc6NUys=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-J6wBuahtMo6tC6gmT0NUfg-1; Thu, 22 Jan 2026 17:11:16 -0500
X-MC-Unique: J6wBuahtMo6tC6gmT0NUfg-1
X-Mimecast-MFC-AGG-ID: J6wBuahtMo6tC6gmT0NUfg_1769119876
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8946b186018so59729906d6.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769119876; x=1769724676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKtJn8c2MQEyJjk0IWT+l4K60Rh1a/2U2zxZXpc5Pls=;
 b=VqU+EjdVKDpdo6lCiyPmWuUPVvYJrY1ml+EiLWUIvD5VHcWtRB5i+d29AItoRNwaeD
 Agk7CJ3DSvjnOmWrTPzwPLHFaGfmokMnT2zZd/3c79oD7nWB8+DXhVWxmaZjPbGDp0va
 ygO8QHBBP66HesdP94SgE8jL5yiPzKZ9qB+UZC8vL25PjzivEHM0RUnb4M+Mzbuo0uVI
 YjJsea/nhEVncWFQvzB39pMBMuj1gCtHC5ZZPMBAXCQQWHmmKCDgzc6dL23K0VBIZoOQ
 IOyTqXmPL9gXP3wUI4puI9W+TzY93RBHGPXEoQgkAHV+oLgSn9AvQTtVmcziMo1eASC5
 fcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119876; x=1769724676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKtJn8c2MQEyJjk0IWT+l4K60Rh1a/2U2zxZXpc5Pls=;
 b=UtUaIJanfFqb5JjrjJhBhBW9/LT9GZ4KN9pA/nGAGGtUcfzK4Cb65zddmFJckcNeYL
 DXDM0k4q0xjjEiUcLoBpRtuXHZi27zeZhY/f+k4vOSQ142OL3U9004sCfAi4K5PH4q8f
 hfx25M1mt7b4SYOkUO6U5bqMa78O3VeIMzbziq5iL7Fl6owRT3QyWyRypBDyPwT9MBKk
 k18d6flE4IeObT9u2oPHVfMeMgQPrhBUZ11vRrV+bZ7rPEompQIPLNyZMdC3ob3Mq45L
 VIjTJKtHJfLfWPkVBTdw68oBviYCuCB3RV1y0VnSHJESYF0Hk3Mfh7FrGgcVc2hjYrNH
 TvqA==
X-Gm-Message-State: AOJu0YzvX3wVf+wgbBV36NKH+B9Aixuos8uludgxbDjLtZJ54Oh7UAlw
 IQlbhn4KyBqKJWwWl68Z2/cyBg4dBO1q7RRjTvLTILm6tn3kkLZ+TK4EtRS6KHCABH9HuE4FbpO
 gn24RjJeKVk+EjtfXLlKk7lVDiY8Gl7Ba3VZvLDc5mG0qDMgAZLHOEHm+e20qSzWTWtp/NN9w4D
 PQU+jObYhv6mfr46s9UMyDamyz6+li68+yeml7ug==
X-Gm-Gg: AZuq6aKi200+R+C1AW+yH/0tu6rheU0/ODTxZE4M7SvIBLyMXBKX0aJ3O66ppHATL+O
 6T5l1+jUaiTX6TRmSJ/vMZEUvlsg6hhE1yncizkl/TQb8Nr9+raatK5M1oHeKbdnIABLfQ9Mee1
 g8npiczJZDPB0ou+ph75wxTMzdl++FOaATf7eujqpW/j+Hq7LZWK2xfebkQIQ1L2P1bSoK7YDBl
 BNCA8/jjfxNFaUn29MUpHr3E/S91+Qr3xgy4QcMREMf7MTwParZ7k+gf5jKua+Vd/vlzOlDVXRO
 b7lqzYbHI2zvNUk3x20yEsLsciN/ea46cUNynubpN8VP3hifXREqM1VKS1gwUmz6an+umWZpSSH
 H
X-Received: by 2002:a05:6214:234d:b0:890:7328:7fdb with SMTP id
 6a1803df08f44-8949023c149mr15852936d6.53.1769119874244; 
 Thu, 22 Jan 2026 14:11:14 -0800 (PST)
X-Received: by 2002:a05:6214:234d:b0:890:7328:7fdb with SMTP id
 6a1803df08f44-8949023c149mr15852416d6.53.1769119873666; 
 Thu, 22 Jan 2026 14:11:13 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8949183f7cesm3663176d6.18.2026.01.22.14.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 14:11:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH] migration: Introduce migrate_use_return_path()
Date: Thu, 22 Jan 2026 17:11:11 -0500
Message-ID: <20260122221111.3538536-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a helper to show if we want to enable return path.

We used to imply that for postcopy-ram, that's not normally how we add cap
dependencies, however it has been like it for years.  Add some comment and
stick with it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  1 +
 migration/migration.c | 15 ++++++++++++++-
 migration/rdma.c      |  8 +++-----
 migration/tls.c       |  4 ++--
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index ccc4e536a5..32c2e70205 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -605,5 +605,6 @@ void migration_bitmap_sync_precopy(bool last_stage);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 bool should_send_vmdesc(void);
+bool migrate_use_return_path(void);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 1bcde301f7..f550485ea5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -109,6 +109,19 @@ static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
 static void migrate_hup_delete(MigrationState *s);
 
+/*
+ * Postcopy-ram will imply return path.
+ *
+ * Normally we don't describe capability dependencies like this; we could
+ * have failed the migration request if postcopy-ram is selected withour
+ * return-path.  Said that, we had this as part of postcopy-ram capability
+ * ABI for years.. let's stick with it.
+ */
+bool migrate_use_return_path(void)
+{
+    return migrate_postcopy_ram() || migrate_return_path();
+}
+
 static void migration_downtime_start(MigrationState *s)
 {
     trace_vmstate_downtime_checkpoint("src-downtime-start");
@@ -4067,7 +4080,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * precopy, only if user specified "return-path" capability would
      * QEMU uses the return path.
      */
-    if (migrate_postcopy_ram() || migrate_return_path()) {
+    if (migrate_use_return_path()) {
         open_return_path_on_source(s);
     }
 
diff --git a/migration/rdma.c b/migration/rdma.c
index cced173379..a55c80908c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3186,8 +3186,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
      * initialize the RDMAContext for return path for postcopy after first
      * connection request reached.
      */
-    if ((migrate_postcopy() || migrate_return_path())
-        && !rdma->is_return_path) {
+    if (migrate_use_return_path() && !rdma->is_return_path) {
         rdma_return_path = qemu_rdma_data_init(isock, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
@@ -3265,8 +3264,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     }
 
     /* Accept the second connection request for return path */
-    if ((migrate_postcopy() || migrate_return_path())
-        && !rdma->is_return_path) {
+    if (migrate_use_return_path() && !rdma->is_return_path) {
         qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
@@ -3967,7 +3965,7 @@ void rdma_start_outgoing_migration(void *opaque,
     }
 
     /* RDMA postcopy need a separate queue pair for return path */
-    if (migrate_postcopy() || migrate_return_path()) {
+    if (migrate_use_return_path()) {
         rdma_return_path = qemu_rdma_data_init(host_port, errp);
 
         if (rdma_return_path == NULL) {
diff --git a/migration/tls.c b/migration/tls.c
index 56b5d1cc90..7fb49ddd82 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -90,7 +90,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
 
     trace_migration_tls_incoming_handshake_start();
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-incoming");
-    if (migrate_postcopy_ram() || migrate_return_path()) {
+    if (migrate_use_return_path()) {
         qio_channel_set_feature(QIO_CHANNEL(tioc),
                                 QIO_CHANNEL_FEATURE_CONCURRENT_IO);
     }
@@ -154,7 +154,7 @@ void migration_tls_channel_connect(MigrationState *s,
     trace_migration_tls_outgoing_handshake_start(hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
 
-    if (migrate_postcopy_ram() || migrate_return_path()) {
+    if (migrate_use_return_path()) {
         qio_channel_set_feature(QIO_CHANNEL(tioc),
                                 QIO_CHANNEL_FEATURE_CONCURRENT_IO);
     }
-- 
2.50.1


