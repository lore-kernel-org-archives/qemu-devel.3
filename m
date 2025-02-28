Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677DFC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 23:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to9wP-0003Z3-6F; Fri, 28 Feb 2025 18:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to9wM-0003Yq-MK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 18:38:46 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to9wJ-0002FU-Bq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 18:38:46 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE23221179;
 Fri, 28 Feb 2025 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740785920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rywHJk3CNffRWQQGq5KqZy2B6/7C8ZLZMWoJDjYC7DA=;
 b=tbQILsUKWsuXaXRxT1to4oz6trXU6K0tdnSA7ug4QDOW1MTOC1GK7wcrcUBmbv4IwoS8BU
 qLGX9GeGyLr8zVP4Jvgl+07Oy+YFEFW70FtmgXKbNjNrMKL0RrZMYk7y3Uk13qIltNTjqA
 0T+Qb2JSfVv2i7GcqLnJAUZdBzgVaDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740785920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rywHJk3CNffRWQQGq5KqZy2B6/7C8ZLZMWoJDjYC7DA=;
 b=FctYFjrTDERcniUqKB3zq8KDLbrzMNEfvAoqkHytIrdpBbDLO3pmPY8vkZUJdfu4iTQwM0
 pAi49lQ/z0LzwaCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tbQILsUK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FctYFjrT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740785920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rywHJk3CNffRWQQGq5KqZy2B6/7C8ZLZMWoJDjYC7DA=;
 b=tbQILsUKWsuXaXRxT1to4oz6trXU6K0tdnSA7ug4QDOW1MTOC1GK7wcrcUBmbv4IwoS8BU
 qLGX9GeGyLr8zVP4Jvgl+07Oy+YFEFW70FtmgXKbNjNrMKL0RrZMYk7y3Uk13qIltNTjqA
 0T+Qb2JSfVv2i7GcqLnJAUZdBzgVaDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740785920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rywHJk3CNffRWQQGq5KqZy2B6/7C8ZLZMWoJDjYC7DA=;
 b=FctYFjrTDERcniUqKB3zq8KDLbrzMNEfvAoqkHytIrdpBbDLO3pmPY8vkZUJdfu4iTQwM0
 pAi49lQ/z0LzwaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 177581344A;
 Fri, 28 Feb 2025 23:38:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wayUMf9IwmeMXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Feb 2025 23:38:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 36/36] vfio/migration: Update VFIO migration
 documentation
In-Reply-To: <a7f66c0f-1355-43e6-b20d-eddaef6fb1d1@redhat.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <2031790b755aa95b61470b286fa787b78be08107.1739994627.git.maciej.szmigiero@oracle.com>
 <cbebee68-f891-4946-885d-01a8ed24e6c1@redhat.com>
 <7c41add3-72ad-4aec-bd74-3c9715fda5c7@maciej.szmigiero.name>
 <a7f66c0f-1355-43e6-b20d-eddaef6fb1d1@redhat.com>
Date: Fri, 28 Feb 2025 20:38:37 -0300
Message-ID: <87frjxvdvm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AE23221179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 2/27/25 23:01, Maciej S. Szmigiero wrote:
>> On 27.02.2025 07:59, C=C3=A9dric Le Goater wrote:
>>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Update the VFIO documentation at docs/devel/migration describing the
>>>> changes brought by the multifd device state transfer.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>> =C2=A0 docs/devel/migration/vfio.rst | 80 ++++++++++++++++++++++++++++=
+++----
>>>> =C2=A0 1 file changed, 71 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio=
.rst
>>>> index c49482eab66d..d9b169d29921 100644
>>>> --- a/docs/devel/migration/vfio.rst
>>>> +++ b/docs/devel/migration/vfio.rst
>>>> @@ -16,6 +16,37 @@ helps to reduce the total downtime of the VM. VFIO =
devices opt-in to pre-copy
>>>> =C2=A0 support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>>> =C2=A0 VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>>
>>> Please add a new "multifd" documentation subsection at the end of the f=
ile
>>> with this part :
>>>
>>>> +Starting from QEMU version 10.0 there's a possibility to transfer VFI=
O device
>>>> +_STOP_COPY state via multifd channels. This helps reduce downtime - e=
specially
>>>> +with multiple VFIO devices or with devices having a large migration s=
tate.
>>>> +As an additional benefit, setting the VFIO device to _STOP_COPY state=
 and
>>>> +saving its config space is also parallelized (run in a separate threa=
d) in
>>>> +such migration mode.
>>>> +
>>>> +The multifd VFIO device state transfer is controlled by
>>>> +"x-migration-multifd-transfer" VFIO device property. This property de=
faults to
>>>> +AUTO, which means that VFIO device state transfer via multifd channel=
s is
>>>> +attempted in configurations that otherwise support it.
>>>> +
>>=20
>> Done - I also moved the parts about x-migration-max-queued-buffers
>> and x-migration-load-config-after-iter description there since
>> obviously they wouldn't make sense being left alone in the top section.
>>=20
>>> I was expecting a much more detailed explanation on the design too=C2=
=A0 :
>>>
>>> =C2=A0=C2=A0* in the cover letter
>>> =C2=A0=C2=A0* in the hw/vfio/migration-multifd.c
>>> =C2=A0=C2=A0* in some new file under docs/devel/migration/
>
> I forgot to add  :
>
>       * guide on how to use this new feature from QEMU and libvirt.
>         something we can refer to for tests. That's a must have.
>       * usage scenarios
>         There are some benefits but it is not obvious a user would
>         like to use multiple VFs in one VM, please explain.
>         This is a major addition which needs justification anyhow
>       * pros and cons
>
>> I'm not sure what descriptions you exactly want in these places,=20
>
> Looking from the VFIO subsystem, the way this series works is very opaque.
> There are a couple of a new migration handlers, new threads, new channels,
> etc. It has been discussed several times with migration folks, please pro=
vide
> a summary for a new reader as ignorant as everyone would be when looking =
at
> a new file.
>
>
>> but since
>> that's just documentation (not code) it could be added after the code fr=
eeze...
>
> That's the risk of not getting any ! and the initial proposal should be
> discussed before code freeze.
>
> For the general framework, I was expecting an extension of a "multifd"
> subsection under :
>
>    https://qemu.readthedocs.io/en/v9.2.0/devel/migration/features.html
>
> but it doesn't exist :/

Hi, see if this helps. Let me know what can be improved and if something
needs to be more detailed. Please ignore the formatting, I'll send a
proper patch after the carnaval.

@Maciej, it's probably better if you keep your docs separate anyway so
we don't add another dependency. I can merge them later.

multifd.rst:

Multifd
=3D=3D=3D=3D=3D=3D=3D

Multifd is the name given for the migration capability that enables
data transfer using multiple threads. Multifd supports all the
transport types currently in use with migration (inet, unix, vsock,
fd, file).

Restrictions
------------

For migration to a file, support is conditional on the presence of the
mapped-ram capability, see #mapped-ram.

Snapshots are currently not supported.

Postcopy migration is currently not supported.

Usage
-----

On both source and destination, enable the ``multifd`` capability:

    ``migrate_set_capability multifd on``

Define a number of channels to use (default is 2, but 8 usually
provides best performance).

    ``migrate_set_parameter multifd-channels 8``

Components
----------

Multifd consists of:

- A client that produces the data on the migration source side and
  consumes it on the destination. Currently the main client code is
  ram.c, which selects the RAM pages for migration;

- A shared data structure (MultiFDSendData), used to transfer data
  between multifd and the client. On the source side, this structure
  is further subdivided into payload types (MultiFDPayload);

- An API operating on the shared data structure to allow the client
  code to interact with multifd;

  - multifd_send/recv(): A dispatcher that transfers work to/from the
    channels.

  - multifd_*payload_* and MultiFDPayloadType: Support defining an
    opaque payload. The payload is always wrapped by
    MultiFDSend|RecvData.

  - multifd_send_data_*: Used to manage the memory for the shared data
    structure.

- The threads that process the data (aka channels, due to a 1:1
  mapping to QIOChannels). Each multifd channel supports callbacks
  that can be used for fine-grained processing of the payload, such as
  compression and zero page detection.

- A packet which is the final result of all the data aggregation
  and/or transformation. The packet contains a header, a
  payload-specific header and a variable-size data portion.

   - The packet header: contains a magic number, a version number and
     flags that inform of special processing needed on the
     destination.

   - The payload-specific header: contains metadata referent to the
     packet's data portion, such as page counts.

   - The data portion: contains the actual opaque payload data.

  Note that due to historical reasons, the terminology around multifd
  packets is inconsistent.

  The mapped-ram feature ignores packets entirely.

Theory of operation
-------------------

The multifd channels operate in parallel with the main migration
thread. The transfer of data from a client code into multifd happens
from the main migration thread using the multifd API.

The interaction between the client code and the multifd channels
happens in the multifd_send() and multifd_recv() methods. These are
reponsible for selecting the next idle channel and making the shared
data structure containing the payload accessible to that channel. The
client code receives back an empty object which it then uses for the
next iteration of data transfer.

The selection of idle channels is simply a round-robin over the idle
channels (!p->pending_job). Channels wait at a semaphore, once a
channel is released, it starts operating on the data immediately.

Aside from eventually transmitting the data over the underlying
QIOChannel, a channel's operation also includes calling back to the
client code at pre-determined points to allow for client-specific
handling such as data transformation (e.g. compression), creation of
the packet header and arranging the data into iovs (struct
iovec). Iovs are the type of data on which the QIOChannel operates.

Client code (migration thread):
1. Populate shared structure with opaque data (ram pages, device state)
2. Call multifd_send()
   2a. Loop over the channels until one is idle
   2b. Switch pointers between client data and channel data
   2c. Release channel semaphore
3. Receive back empty object
4. Repeat

Multifd channel (multifd thread):
1. Channel idle
2. Gets released by multifd_send()
3. Call multifd_ops methods to fill iov
   3a. Compression may happen
   3b. Zero page detection may happen
   3c. Packet is written
   3d. iov is written
4. Pass iov into QIOChannel for transferring
5. Repeat

The destination side operates similarly but with multifd_recv(),
decompression instead of compression, etc. One important aspect is
that when receiving the data, the iov will contain host virtual
addresses, so guest memory is written to directly from multifd
threads.

About flags
-----------
The main thread orchestrates the migration by issuing control flags on
the migration stream (QEMU_VM_*).

The main memory is migrated by ram.c and includes specific control
flags that are also put on the main migration stream
(RAM_SAVE_FLAG_*).

Multifd has its own set of MULTIFD_FLAGs that are included into each
packet. These may inform about properties such as the compression
algorithm used if the data is compressed.

Synchronization
---------------

Since the migration process is iterative due to RAM dirty tracking, it
is necessary to invalidate data that is no longer current (e.g. due to
the source VM touching the page). This is done by having a
synchronization point triggered by the migration thread at key points
during the migration. Data that's received after the synchronization
point is allowed to overwrite data received prior to that point.

To perform the synchronization, multifd provides the
multifd_send_sync_main() and multifd_recv_sync_main() helpers. These
are called whenever the client code whishes to ensure that all data
sent previously has now been received by the destination.

The synchronization process involves performing a flush of the
ramaining client data still left to be transmitted and issuing a
multifd packet containing the MULTIFD_FLAG_SYNC flag. This flag
informs the receiving end that it should finish reading the data and
wait for a synchronization point.

To complete the sync, the main migration stream issues a
RAM_SAVE_FLAG_MULTIFD_FLUSH flag. When that flag is received by the
destination, it ensures all of its channels have seen the
MULTIFD_FLAG_SYNC and moves them to an idle state.

The client code can then continue with a second round of data by
issuing multifd_send() once again.

The synchronization process also ensures that internal synchronization
happens, i.e. between each thread. This is necessary to avoid threads
lagging behind sending or receiving when the migration approaches
completion.

The mapped-ram feature has different synchronization requirements
because it's an asynchronous migration (source and destination not
migrating at the same time). For that feature, only the internal sync
is relevant.

Data transformation
-------------------

Each multifd channel executes a set of callbacks before transmitting
the data. These callbacks allow the client code to alter the data
format right before sending and after receiving.

Since the object of the RAM migration is always the memory page and
the only processing done for memory pages is zero page detection,
which is already part of compression in a sense, the multifd_ops
functions are mutually exclusively divided into compression and
no-compression.

The migration without compression (i.e. regular ram migration) has a
further specificity as mentioned of possibly doing zero page detection
(see zero-page-detection migration parameter). This consists of
sending all pages to multifd and letting the detection of a zero page
happen in the multifd channels instead of doing it beforehand on the
main migration thread as it was done in the past.

Code structure
--------------

Multifd code is divided into:

The main file containing the core routines

- multifd.c

RAM migration

- multifd-nocomp.c (nocomp, for "no compression")
- multifd-zero-page.c
- ram.c (also involved in non-multifd migrations + snapshots)

Compressors

- multifd-uadk.c
- multifd-qatzip.c
- multifd-zlib.c
- multifd-qpl.c
- multifd-zstd.c

