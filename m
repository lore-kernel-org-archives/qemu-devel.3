Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC3AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXyB-000054-99; Fri, 07 Mar 2025 08:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqXy2-0008WT-G8
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:42:22 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqXxz-0006j0-41
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:42:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3039B21187;
 Fri,  7 Mar 2025 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741354930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1acmbyN7hw77B7uhQGgM8HCASgSYuRnYegMTQr1WPCU=;
 b=jyB/PcJb1q4U/QJkcoKg1tCIAr9izbNX4H0CmlUVgmm/ewWR6U43phiJ+ylLVOUzrAD+nm
 7gy6D2fayA/tfJwQai6fSGLJrA4jogOORe1gmdvo3I9B1MbNQvvJu6QKO1Ae3cCPC6HB81
 CBnnFyla0c3FEYeIJ4hlhdiDC2s6pyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741354930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1acmbyN7hw77B7uhQGgM8HCASgSYuRnYegMTQr1WPCU=;
 b=W/8AgnRvvS4URELZgZzuMo8kZAW7PPQz9kCGrTtSntji4l2JVAgtFIzNKftwmeeAO4MS0n
 KffEGnoueTq1UqAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jyB/PcJb";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="W/8AgnRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741354930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1acmbyN7hw77B7uhQGgM8HCASgSYuRnYegMTQr1WPCU=;
 b=jyB/PcJb1q4U/QJkcoKg1tCIAr9izbNX4H0CmlUVgmm/ewWR6U43phiJ+ylLVOUzrAD+nm
 7gy6D2fayA/tfJwQai6fSGLJrA4jogOORe1gmdvo3I9B1MbNQvvJu6QKO1Ae3cCPC6HB81
 CBnnFyla0c3FEYeIJ4hlhdiDC2s6pyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741354930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1acmbyN7hw77B7uhQGgM8HCASgSYuRnYegMTQr1WPCU=;
 b=W/8AgnRvvS4URELZgZzuMo8kZAW7PPQz9kCGrTtSntji4l2JVAgtFIzNKftwmeeAO4MS0n
 KffEGnoueTq1UqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FFC413A22;
 Fri,  7 Mar 2025 13:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uN0AD7D3ymfJHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 13:42:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/2] migration: Add some documentation for multifd
Date: Fri,  7 Mar 2025 10:42:02 -0300
Message-Id: <20250307134203.29443-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307134203.29443-1-farosas@suse.de>
References: <20250307134203.29443-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3039B21187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There's currently no documentation for multifd, we can at least
provide an overview of the feature.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
Keep in mind the feature grew organically over the years and it has
had bugs that required reinventing some concepts, specially on the
sync part, so there's still some amount of inconsistency in the code
and that's not going to be fixed by documentation.
---
 docs/devel/migration/features.rst |   1 +
 docs/devel/migration/multifd.rst  | 254 ++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 docs/devel/migration/multifd.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 8f431d52f9..249d653124 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -15,3 +15,4 @@ Migration has plenty of features to support different use cases.
    qpl-compression
    uadk-compression
    qatzip-compression
+   multifd
diff --git a/docs/devel/migration/multifd.rst b/docs/devel/migration/multifd.rst
new file mode 100644
index 0000000000..8f5ec840cb
--- /dev/null
+++ b/docs/devel/migration/multifd.rst
@@ -0,0 +1,254 @@
+Multifd
+=======
+
+Multifd is the name given for the migration capability that enables
+data transfer using multiple threads. Multifd supports all the
+transport types currently in use with migration (inet, unix, vsock,
+fd, file).
+
+Usage
+-----
+
+On both source and destination, enable the ``multifd`` capability:
+
+    ``migrate_set_capability multifd on``
+
+Define a number of channels to use (default is 2, but 8 usually
+provides best performance).
+
+    ``migrate_set_parameter multifd-channels 8``
+
+Restrictions
+------------
+
+For migration to a file, support is conditional on the presence of the
+mapped-ram capability, see `mapped-ram`.
+
+Snapshots are currently not supported.
+
+`postcopy` migration is currently not supported.
+
+Components
+----------
+
+Multifd consists of:
+
+- A client that produces the data on the migration source side and
+  consumes it on the destination. Currently the main client code is
+  ram.c, which selects the RAM pages for migration;
+
+- A shared data structure (``MultiFDSendData``), used to transfer data
+  between multifd and the client. On the source side, this structure
+  is further subdivided into payload types (``MultiFDPayload``);
+
+- An API operating on the shared data structure to allow the client
+  code to interact with multifd;
+
+  - ``multifd_send/recv()``: Transfers work to/from the channels.
+
+  - ``multifd_*payload_*`` and ``MultiFDPayloadType``: Support
+    defining an opaque payload. The payload is always wrapped by
+    ``MultiFD*Data``.
+
+  - ``multifd_send_data_*``: Used to manage the memory for the shared
+    data structure.
+
+  - ``multifd_*_sync_main()``: See :ref:`synchronization` below.
+
+- A set of threads (aka channels, due to a 1:1 mapping to QIOChannels)
+  responsible for doing I/O. Each multifd channel supports callbacks
+  (``MultiFDMethods``) that can be used for fine-grained processing of
+  the payload, such as compression and zero page detection.
+
+- A packet which is the final result of all the data aggregation
+  and/or transformation. The packet contains: a *header* with magic and
+  version numbers and flags that inform of special processing needed
+  on the destination; a *payload-specific header* with metadata referent
+  to the packet's data portion, e.g. page counts; and a variable-size
+  *data portion* which contains the actual opaque payload data.
+
+  Note that due to historical reasons, the terminology around multifd
+  packets is inconsistent.
+
+  The `mapped-ram` feature ignores packets entirely.
+
+Operation
+---------
+
+The multifd channels operate in parallel with the main migration
+thread. The transfer of data from a client code into multifd happens
+from the main migration thread using the multifd API.
+
+The interaction between the client code and the multifd channels
+happens in the ``multifd_send()`` and ``multifd_recv()``
+methods. These are reponsible for selecting the next idle channel and
+making the shared data structure containing the payload accessible to
+that channel. The client code receives back an empty object which it
+then uses for the next iteration of data transfer.
+
+The selection of idle channels is simply a round-robin over the idle
+channels (``!p->pending_job``). Channels wait at a semaphore and once
+a channel is released it starts operating on the data immediately.
+
+Aside from eventually transmitting the data over the underlying
+QIOChannel, a channel's operation also includes calling back to the
+client code at pre-determined points to allow for client-specific
+handling such as data transformation (e.g. compression), creation of
+the packet header and arranging the data into iovs (``struct
+iovec``). Iovs are the type of data on which the QIOChannel operates.
+
+A high-level flow for each thread is:
+
+Migration thread:
+
+#. Populate shared structure with opaque data (e.g. ram pages)
+#. Call ``multifd_send()``
+
+   #. Loop over the channels until one is idle
+   #. Switch pointers between client data and channel data
+   #. Release channel semaphore
+#. Receive back empty object
+#. Repeat
+
+Multifd thread:
+
+#. Channel idle
+#. Gets released by ``multifd_send()``
+#. Call ``MultiFDMethods`` methods to fill iov
+
+   #. Compression may happen
+   #. Zero page detection may happen
+   #. Packet is written
+   #. iov is written
+#. Pass iov into QIOChannel for transferring (I/O happens here)
+#. Repeat
+
+The destination side operates similarly but with ``multifd_recv()``,
+decompression instead of compression, etc. One important aspect is
+that when receiving the data, the iov will contain host virtual
+addresses, so guest memory is written to directly from multifd
+threads.
+
+About flags
+-----------
+The main thread orchestrates the migration by issuing control flags on
+the migration stream (``QEMU_VM_*``).
+
+The main memory is migrated by ram.c and includes specific control
+flags that are also put on the main migration stream
+(``RAM_SAVE_FLAG_*``).
+
+Multifd has its own set of flags (``MULTIFD_FLAG_*``) that are
+included into each packet. These may inform about properties such as
+the compression algorithm used if the data is compressed.
+
+.. _synchronization:
+
+Synchronization
+---------------
+
+Data sent through multifd may arrive out of order and with different
+timing. Some clients may also have synchronization requirements to
+ensure data consistency, e.g. the RAM migration must ensure that
+memory pages received by the destination machine are ordered in
+relation to previous iterations of dirty tracking.
+
+Some cleanup tasks such as memory deallocation or error handling may
+need to happen only after all channels have finished sending/receiving
+the data.
+
+Multifd provides the ``multifd_send_sync_main()`` and
+``multifd_recv_sync_main()`` helpers to synchronize the main migration
+thread with the multifd channels. In addition, these helpers also
+trigger the emission of a sync packet (``MULTIFD_FLAG_SYNC``) which
+carries the synchronization command to the remote side of the
+migration.
+
+After the channels have been put into a wait state by the sync
+functions, the client code may continue to transmit additional data by
+issuing ``multifd_send()`` once again.
+
+Note:
+
+- the RAM migration does, effectively, a global synchronization by
+  chaining a call to ``multifd_send_sync_main()`` with the emission of a
+  flag on the main migration channel (``RAM_SAVE_FLAG_MULTIFD_FLUSH``)
+  which in turn causes ``multifd_recv_sync_main()`` to be called on the
+  destination.
+
+  There are also backward compatibility concerns expressed by
+  ``multifd_ram_sync_per_section()`` and
+  ``multifd_ram_sync_per_round()``. See the code for detailed
+  documentation.
+
+- the `mapped-ram` feature has different requirements because it's an
+  asynchronous migration (source and destination not migrating at the
+  same time). For that feature, only the sync between the channels is
+  relevant to prevent cleanup to happen before data is completely
+  written to (or read from) the migration file.
+
+Data transformation
+-------------------
+
+The ``MultiFDMethods`` structure defines callbacks that allow the
+client code to perform operations on the data at key points. These
+operations could be client-specific (e.g. compression), but also
+include a few required steps such as moving data into an iovs. See the
+struct's definition for more detailed documentation.
+
+Historically, the only client for multifd has been the RAM migration,
+so the ``MultiFDMethods`` are pre-registered in two categories,
+compression and no-compression, with the latter being the regular,
+uncompressed ram migration.
+
+Zero page detection
++++++++++++++++++++
+
+The migration without compression has a further specificity of
+possibly doing zero page detection. It involves doing the detection of
+a zero page directly in the multifd channels instead of beforehand on
+the main migration thread (as it's been done in the past). This is the
+default behavior and can be disabled with:
+
+    ``migrate_set_parameter zero-page-detection legacy``
+
+or to disable zero page detection completely:
+
+    ``migrate_set_parameter zero-page-detection none``
+
+Error handling
+--------------
+
+Any part of multifd code can be made to exit by setting the
+``exiting`` atomic flag of the multifd state. Whenever a multifd
+channel has an error, it should break out of its loop, set the flag to
+indicate other channels to exit as well and set the migration error
+with ``migrate_set_error()``.
+
+For clean exiting (triggered from outside the channels), the
+``multifd_send|recv_terminate_threads()`` functions set the
+``exiting`` flag and additionally release any channels that may be
+idle or waiting for a sync.
+
+Code structure
+--------------
+
+Multifd code is divided into:
+
+The main file containing the core routines
+
+- multifd.c
+
+RAM migration
+
+- multifd-nocomp.c (nocomp, for "no compression")
+- multifd-zero-page.c
+- ram.c (also involved in non-multifd migrations & snapshots)
+
+Compressors
+
+- multifd-uadk.c
+- multifd-qatzip.c
+- multifd-zlib.c
+- multifd-qpl.c
+- multifd-zstd.c
-- 
2.35.3


