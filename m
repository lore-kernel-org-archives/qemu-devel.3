Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0289C5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjK6e-0002uE-SM; Wed, 28 Aug 2024 10:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6c-0002mS-M0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:57:06 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6b-00028O-3X
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:57:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00AE121B62;
 Wed, 28 Aug 2024 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfkl4rJMoX4v/Kru1ixqosWtzfnZu4p/EcgbmkHIoEo=;
 b=CIWqX8/7211SEYEpXRhnUWxCv9wy2zdyrP71bu98w6t835K/zVGE/x5TL3bbiTfOqBbqty
 7QtePh7eJZRunaq9omald09ub25yapu473kWM9bNMCoqYsOP3q1hT9RHhrs1lcMJ1kkZUB
 qIwAiqRG7Slj10mbwFd2B5J4pHY03UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfkl4rJMoX4v/Kru1ixqosWtzfnZu4p/EcgbmkHIoEo=;
 b=6o0Lzt2lteYOr+YgPYgH/6yW5p/eNlrxc4E0IM/tSisr8bs9z9dwXMEVOPAGiHgaWuXnic
 gO5b2TNBbKdtBGCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfkl4rJMoX4v/Kru1ixqosWtzfnZu4p/EcgbmkHIoEo=;
 b=CIWqX8/7211SEYEpXRhnUWxCv9wy2zdyrP71bu98w6t835K/zVGE/x5TL3bbiTfOqBbqty
 7QtePh7eJZRunaq9omald09ub25yapu473kWM9bNMCoqYsOP3q1hT9RHhrs1lcMJ1kkZUB
 qIwAiqRG7Slj10mbwFd2B5J4pHY03UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfkl4rJMoX4v/Kru1ixqosWtzfnZu4p/EcgbmkHIoEo=;
 b=6o0Lzt2lteYOr+YgPYgH/6yW5p/eNlrxc4E0IM/tSisr8bs9z9dwXMEVOPAGiHgaWuXnic
 gO5b2TNBbKdtBGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC851398F;
 Wed, 28 Aug 2024 14:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MALHJLs6z2YnRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 14:56:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 4/4] migration/multifd: Add documentation for multifd
 methods
Date: Wed, 28 Aug 2024 11:56:50 -0300
Message-Id: <20240828145650.15879-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240828145650.15879-1-farosas@suse.de>
References: <20240828145650.15879-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add documentation clarifying the usage of the multifd methods. The
general idea is that the client code calls into multifd to trigger
send/recv of data and multifd then calls these hooks back from the
worker threads at opportune moments so the client can process a
portion of the data.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.h | 76 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 13e7a88c01..3bb96e9558 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -229,17 +229,81 @@ typedef struct {
 } MultiFDRecvParams;
 
 typedef struct {
-    /* Setup for sending side */
+    /*
+     * The send_setup, send_cleanup, send_prepare are only called on
+     * the QEMU instance at the migration source.
+     */
+
+    /*
+     * Setup for sending side. Called once per channel during channel
+     * setup phase.
+     *
+     * Must allocate p->iov. If packets are in use (default), one
+     * extra iovec must be allocated for the packet header. Any memory
+     * allocated in this hook must be released at send_cleanup.
+     *
+     * p->write_flags may be used for passing flags to the QIOChannel.
+     *
+     * p->compression_data may be used by compression methods to store
+     * compression data.
+     */
     int (*send_setup)(MultiFDSendParams *p, Error **errp);
-    /* Cleanup for sending side */
+
+    /*
+     * Cleanup for sending side. Called once per channel during
+     * channel cleanup phase.
+     */
     void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
-    /* Prepare the send packet */
+
+    /*
+     * Prepare the send packet. Called as a result of multifd_send()
+     * on the client side, with p pointing to the MultiFDSendParams of
+     * a channel that is currently idle.
+     *
+     * Must populate p->iov with the data to be sent, increment
+     * p->iovs_num to match the amount of iovecs used and set
+     * p->next_packet_size with the amount of data currently present
+     * in p->iov.
+     *
+     * Must indicate whether this is a compression packet by setting
+     * p->flags.
+     *
+     * As a last step, if packets are in use (default), must prepare
+     * the packet by calling multifd_send_fill_packet().
+     */
     int (*send_prepare)(MultiFDSendParams *p, Error **errp);
-    /* Setup for receiving side */
+
+    /*
+     * The recv_setup, recv_cleanup, recv are only called on the QEMU
+     * instance at the migration destination.
+     */
+
+    /*
+     * Setup for receiving side. Called once per channel during
+     * channel setup phase. May be empty.
+     *
+     * May allocate data structures for the receiving of data. May use
+     * p->iov. Compression methods may use p->compress_data.
+     */
     int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
-    /* Cleanup for receiving side */
+
+    /*
+     * Cleanup for receiving side. Called once per channel during
+     * channel cleanup phase. May be empty.
+     */
     void (*recv_cleanup)(MultiFDRecvParams *p);
-    /* Read all data */
+
+    /*
+     * Data receive method. Called as a result of multifd_recv() on
+     * the client side, with p pointing to the MultiFDRecvParams of a
+     * channel that is currently idle. Only called if there is data
+     * available to receive.
+     *
+     * Must validate p->flags according to what was set at
+     * send_prepare.
+     *
+     * Must read the data from the QIOChannel p->c.
+     */
     int (*recv)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
-- 
2.35.3


