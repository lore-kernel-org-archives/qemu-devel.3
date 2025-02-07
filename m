Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C1CC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 19:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgUQj-0003EP-E9; Fri, 07 Feb 2025 14:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQi-0003Dx-BT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQg-0000OE-7q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED5511F452;
 Fri,  7 Feb 2025 19:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSjRU2VNAe3A6rnQ8+ypeWaUSxZ5QR0PVmBy7NqdhVU=;
 b=skqCoS6pqMRnLeA56TOZGQ1N74F/MY2y7aRJY1yVRMoxTPOauSamIaBTZy6+xwsbuZOonS
 EqzcNevr003Wp1WmcktA3kvLzyhwu01vHcjHI5gJi+H84Ok4cfpNanbqvZzmCIohLkXtIU
 FpUjS2T7XBPUxVBKb/sgcWR4H/1NB20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSjRU2VNAe3A6rnQ8+ypeWaUSxZ5QR0PVmBy7NqdhVU=;
 b=SdPszgvIUoiGuzLbSgu0bmnpQUcY3X13ccMw8c4q2A+ncnw0eEKVeup21i/wwME2VHix+a
 kFj/+w5nqvsQGXAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nu3nJM4W;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w3I6jonx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSjRU2VNAe3A6rnQ8+ypeWaUSxZ5QR0PVmBy7NqdhVU=;
 b=Nu3nJM4W+eZi3JsJsMQ7MKds+b2Eqysu5HheRVq/6H8qCIZ95FMrjZINzr57u0ovfL5mq9
 3Z77yjpDXgpihaGiMncRiEhP28sRryk39oNTPj8m97YMmeRutWY8OVyAsCz7hvKxfZT4ZA
 /z1RBVSV5mZj6InJ8ld5xrzxltau/Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSjRU2VNAe3A6rnQ8+ypeWaUSxZ5QR0PVmBy7NqdhVU=;
 b=w3I6jonxJDBWMc/4ds7/nRPsfmWA9G5q9Cvu/GRU8wvUCPXfHSyMKtre8saVCTu8Ja8+Bq
 kkj8LAxlSscOHoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F04C513694;
 Fri,  7 Feb 2025 19:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EiuKulkpme1GQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 19:54:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC PATCH v3 7/8] migration/multifd: Add a compat property for TLS
 termination
Date: Fri,  7 Feb 2025 16:53:58 -0300
Message-Id: <20250207195359.17443-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207195359.17443-1-farosas@suse.de>
References: <20250207195359.17443-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED5511F452
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,maciej.szmigiero.name,habkost.net,gmail.com,linaro.org,huawei.com,intel.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We're currently changing the way the source multifd migration handles
the shutdown of the multifd channels when TLS is in use to perform a
clean termination by calling gnutls_bye().

Older src QEMUs will always close the channel without terminating the
TLS session. New dst QEMUs treat an unclean termination as an error.

Add multifd_clean_tls_termination (default true) that can be switched
on the destination whenever a src QEMU <= 9.2 is in use.

(Note that the compat property is only strictly necessary for src
QEMUs older than 9.1. Due to synchronization coincidences, src QEMUs
9.1 and 9.2 can put the destination in a condition where it doesn't
see the unclean termination. Still, make the property more inclusive
to facilitate potential backports.)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/machine.c     |  1 +
 migration/migration.h | 33 +++++++++++++++++++++++++++++++++
 migration/multifd.c   | 15 +++++++++++++--
 migration/multifd.h   |  2 ++
 migration/options.c   |  2 ++
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 254cc20c4c..02cff735b3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@ GlobalProperty hw_compat_9_2[] = {
     { "virtio-balloon-pci-transitional", "vectors", "0" },
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
     { "virtio-mem-pci", "vectors", "0" },
+    { "migration", "multifd-clean-tls-termination", "false" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/migration/migration.h b/migration/migration.h
index 4c1fafc2b5..77def0b437 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -443,6 +443,39 @@ struct MigrationState {
      * Default value is false. (since 8.1)
      */
     bool multifd_flush_after_each_section;
+
+    /*
+     * This variable only makes sense when set on the machine that is
+     * the destination of a multifd migration with TLS enabled. It
+     * affects the behavior of the last send->recv iteration with
+     * regards to termination of the TLS session.
+     *
+     * When set:
+     *
+     * - the destination QEMU instance can expect to never get a
+     *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
+     *   message: "The TLS connection was non-properly terminated".
+     *
+     * When clear:
+     *
+     * - the destination QEMU instance can expect to see a
+     *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
+     *   whenever the last recv() call of that channel happens after
+     *   the source QEMU instance has already issued shutdown() on the
+     *   channel.
+     *
+     *   Commit 637280aeb2 (since 9.1) introduced a side effect that
+     *   causes the destination instance to not be affected by the
+     *   premature termination, while commit 1d457daf86 (since 10.0)
+     *   causes the premature termination condition to be once again
+     *   reachable.
+     *
+     * NOTE: Regardless of the state of this option, a premature
+     * termination of the TLS connection might happen due to error at
+     * any moment prior to the last send->recv iteration.
+     */
+    bool multifd_clean_tls_termination;
+
     /*
      * This decides the size of guest memory chunk that will be used
      * to track dirty bitmap clearing.  The size of memory chunk will
diff --git a/migration/multifd.c b/migration/multifd.c
index 0296758c08..8045197be8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1151,6 +1151,7 @@ void multifd_recv_sync_main(void)
 
 static void *multifd_recv_thread(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MultiFDRecvParams *p = opaque;
     Error *local_err = NULL;
     bool use_packets = multifd_use_packets();
@@ -1159,18 +1160,28 @@ static void *multifd_recv_thread(void *opaque)
     trace_multifd_recv_thread_start(p->id);
     rcu_register_thread();
 
+    if (!s->multifd_clean_tls_termination) {
+        p->read_flags = QIO_CHANNEL_READ_FLAG_RELAXED_EOF;
+    }
+
     while (true) {
         uint32_t flags = 0;
         bool has_data = false;
         p->normal_num = 0;
 
+
         if (use_packets) {
+            struct iovec iov = {
+                .iov_base = (void *)p->packet,
+                .iov_len = p->packet_len
+            };
+
             if (multifd_recv_should_exit()) {
                 break;
             }
 
-            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
-                                           p->packet_len, &local_err);
+            ret = qio_channel_readv_full_all_eof(p->c, &iov, 1, NULL, NULL,
+                                                 p->read_flags, &local_err);
             if (!ret) {
                 /* EOF */
                 assert(!local_err);
diff --git a/migration/multifd.h b/migration/multifd.h
index bd785b9873..cf408ff721 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -244,6 +244,8 @@ typedef struct {
     uint32_t zero_num;
     /* used for de-compression methods */
     void *compress_data;
+    /* Flags for the QIOChannel */
+    int read_flags;
 } MultiFDRecvParams;
 
 typedef struct {
diff --git a/migration/options.c b/migration/options.c
index 1ad950e397..feda354935 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -99,6 +99,8 @@ const Property migration_properties[] = {
                       clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
     DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
                      preempt_pre_7_2, false),
+    DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
+                     multifd_clean_tls_termination, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
-- 
2.35.3


