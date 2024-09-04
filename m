Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF58CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNc-0005Ar-I5; Wed, 04 Sep 2024 08:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNa-00053U-LE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNY-0005bx-Qn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 859D91F7BC;
 Wed,  4 Sep 2024 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41Iha+9TwuH9aA17NRpJF0mKGVR2kS9cNIKotE3QSTI=;
 b=UeDvBcKUT2mrQ4jnp6MiZ2IW40AHBfoK0wiFW9u0MDnEdDS9HwKBZyvWQt7lv19wTqVI7O
 iszFKzFvhstTc3MVqbLxKpH0ng6yO7mmoYwApIx6Wx2d7NDrGykrc3teGqs8FuZsFaT1pa
 Q2lmJ9PjIj4ZE76h0L/I6gRWQGPYaUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41Iha+9TwuH9aA17NRpJF0mKGVR2kS9cNIKotE3QSTI=;
 b=Ah134rsl1/L5QvShycM3S1Irze3QLKpaTRnlspM4LNenyBXK7qJD6zIOPxJOZ2QyJoE/ub
 cADVgS8TxnKvXmDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UeDvBcKU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ah134rsl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41Iha+9TwuH9aA17NRpJF0mKGVR2kS9cNIKotE3QSTI=;
 b=UeDvBcKUT2mrQ4jnp6MiZ2IW40AHBfoK0wiFW9u0MDnEdDS9HwKBZyvWQt7lv19wTqVI7O
 iszFKzFvhstTc3MVqbLxKpH0ng6yO7mmoYwApIx6Wx2d7NDrGykrc3teGqs8FuZsFaT1pa
 Q2lmJ9PjIj4ZE76h0L/I6gRWQGPYaUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41Iha+9TwuH9aA17NRpJF0mKGVR2kS9cNIKotE3QSTI=;
 b=Ah134rsl1/L5QvShycM3S1Irze3QLKpaTRnlspM4LNenyBXK7qJD6zIOPxJOZ2QyJoE/ub
 cADVgS8TxnKvXmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B9DE139D2;
 Wed,  4 Sep 2024 12:44:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6H/fCEZW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/34] migration/multifd: Remove total pages tracing
Date: Wed,  4 Sep 2024 09:44:03 -0300
Message-Id: <20240904124417.14565-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 859D91F7BC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
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


