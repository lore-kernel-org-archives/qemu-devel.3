Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68E1C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYGK-0000Uu-9G; Fri, 23 Aug 2024 13:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG4-00085n-Pc
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:32 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG3-0008VX-01
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5D6A226F9;
 Fri, 23 Aug 2024 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81tP/aKEBIf2EC/3EZNKuAbedenBFiusjSKO/NpXx8I=;
 b=AXwiIiZE0wtARBgU7TqEY3JlAoqJsLDj9HOPQkMHvj5zrqVx3mVIL3mjFbcPNB/mrMQ0Ya
 oQe+iHYkehaIJ4WphqZ5+Tlj9Qx+1MBvryT9YsQ/lzedpXAnExme6j8eINodLjqzRfGx3T
 MKY6uqhDW2pUs8f2FYV73T7bJKDEHOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81tP/aKEBIf2EC/3EZNKuAbedenBFiusjSKO/NpXx8I=;
 b=nnOfXZD3663UDSx3rmPGD2zPT37UZM2/ZYya68WcuXxax1dJIwpUFhCkIcdneOR53qYHhV
 yEA7ObxYIQeUzsCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AXwiIiZE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nnOfXZD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81tP/aKEBIf2EC/3EZNKuAbedenBFiusjSKO/NpXx8I=;
 b=AXwiIiZE0wtARBgU7TqEY3JlAoqJsLDj9HOPQkMHvj5zrqVx3mVIL3mjFbcPNB/mrMQ0Ya
 oQe+iHYkehaIJ4WphqZ5+Tlj9Qx+1MBvryT9YsQ/lzedpXAnExme6j8eINodLjqzRfGx3T
 MKY6uqhDW2pUs8f2FYV73T7bJKDEHOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81tP/aKEBIf2EC/3EZNKuAbedenBFiusjSKO/NpXx8I=;
 b=nnOfXZD3663UDSx3rmPGD2zPT37UZM2/ZYya68WcuXxax1dJIwpUFhCkIcdneOR53qYHhV
 yEA7ObxYIQeUzsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C6E41333E;
 Fri, 23 Aug 2024 17:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YLjMEFDJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 09/16] migration/multifd: Remove total pages tracing
Date: Fri, 23 Aug 2024 14:39:04 -0300
Message-Id: <20240823173911.6712-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5D6A226F9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.62 / 50.00]; BAYES_HAM(-2.61)[98.27%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The total_normal_pages and total_zero_pages elements are used only for
the end tracepoints of the multifd threads. These are not super useful
since they record per-channel numbers and are just the sum of all the
pages that are transmitted per-packet, for which we already have
tracepoints. Remove the totals from the tracing.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 12 ++----------
 migration/multifd.h    |  8 --------
 migration/trace-events |  4 ++--
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 410b7e12cc..df8dfcc98f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -453,8 +453,6 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     }
 
     p->packets_sent++;
-    p->total_normal_pages += pages->normal_num;
-    p->total_zero_pages += zero_num;
 
     trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
                        p->flags, p->next_packet_size);
@@ -516,8 +514,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
-    p->total_normal_pages += p->normal_num;
-    p->total_zero_pages += p->zero_num;
 
     trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
                        p->flags, p->next_packet_size);
@@ -1036,8 +1032,7 @@ out:
 
     rcu_unregister_thread();
     migration_threads_remove(thread);
-    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages,
-                                  p->total_zero_pages);
+    trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
 }
@@ -1561,7 +1556,6 @@ static void *multifd_recv_thread(void *opaque)
                 qemu_sem_wait(&p->sem_sync);
             }
         } else {
-            p->total_normal_pages += p->data->size / qemu_target_page_size();
             p->data->size = 0;
             /*
              * Order data->size update before clearing
@@ -1578,9 +1572,7 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->packets_recved,
-                                  p->total_normal_pages,
-                                  p->total_zero_pages);
+    trace_multifd_recv_thread_end(p->id, p->packets_recved);
 
     return NULL;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index c2ba4cad13..9175104aea 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -162,10 +162,6 @@ typedef struct {
     uint32_t next_packet_size;
     /* packets sent through this channel */
     uint64_t packets_sent;
-    /* non zero pages sent through this channel */
-    uint64_t total_normal_pages;
-    /* zero pages sent through this channel */
-    uint64_t total_zero_pages;
     /* buffers to send */
     struct iovec *iov;
     /* number of iovs used */
@@ -218,10 +214,6 @@ typedef struct {
     RAMBlock *block;
     /* ramblock host address */
     uint8_t *host;
-    /* non zero pages recv through this channel */
-    uint64_t total_normal_pages;
-    /* zero pages recv through this channel */
-    uint64_t total_zero_pages;
     /* buffers to recv */
     struct iovec *iov;
     /* Pages that are not zero */
diff --git a/migration/trace-events b/migration/trace-events
index 0b7c3324fb..0887cef912 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -134,7 +134,7 @@ multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
 multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" PRIu64 " zero pages %" PRIu64
+multifd_recv_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
 multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
 multifd_send_error(uint8_t id) "channel %u"
@@ -142,7 +142,7 @@ multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64 " zero pages %"  PRIu64
+multifd_send_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-- 
2.35.3


