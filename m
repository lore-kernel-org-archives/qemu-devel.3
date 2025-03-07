Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B2C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 17:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqbTy-00086R-H3; Fri, 07 Mar 2025 12:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqbTt-0007zH-G3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqbTq-0005Kh-Rx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741368443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmM3lfsxtHt5Zn+w27ccz0wEtI56PLeRhGRPFWWdWEM=;
 b=KVsZFkL4tR9zFiMZmhkkCSp8O7ySIh3AJlSG8A+ko+UMMDo5aMTzGPDo+Z24X1yrapk6wt
 iwOAZ24A8dfl/EX/fAOntdQUhTWQXP3VcoxAZLH3HJE9gDwvESdVIjZym9h/20etc+GO05
 Lrj01Ugp0RbGwPgl4W4CubMnvWvTWgc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-mWVWdgBiMNWBrFeVDeqPag-1; Fri, 07 Mar 2025 12:27:21 -0500
X-MC-Unique: mWVWdgBiMNWBrFeVDeqPag-1
X-Mimecast-MFC-AGG-ID: mWVWdgBiMNWBrFeVDeqPag_1741368440
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4751be23f57so40741111cf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 09:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741368440; x=1741973240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmM3lfsxtHt5Zn+w27ccz0wEtI56PLeRhGRPFWWdWEM=;
 b=YE3mGG+tI+9rBcuLfiT0i4/FuRXiFFQ+5CKUocMQHevjBJ6pKqFsEbpEN0zYACIq3M
 gjIrCnFYQAuGr6fwunuQ1fB7aNCu18bVvqtP+XfL2EckcwfE8yoTdKPzWIa+wlYlIIcD
 ff+/EwiCH3H87s2lQxvM6ZUYGPckj51oFwOwHYA6f9vvaaxslwq6+DfdppRypknm4c9e
 JFWE9bIhgEg2ZnOvwrgyDpY1zqvGDte5r5jffSx2RTrkKVSriiQ3JGbk972r6GkdBMZy
 xmq7wU9jEyEaWjORR2nXUFYlmH8ErYF0U/ooZ/rCYFYXrZrE2g4YoTfxwMFv0lJCDhJ0
 OWDQ==
X-Gm-Message-State: AOJu0YytaBXtIN/AYaTmHjXJZmw3Nff9z8nIU/Acx3D7Zv12GMRbfIJx
 ffjeF/fpGU4equf0SWRGRv24bMbV7MTZcMaIyUBqHoO+0UHNuC7FIRhHpces+A/BGW1VblXklv5
 ek9HwAGG/N7AqBjhqAsuFG4QNeocwkOLSFUA3mEv9cUv0i2IytGZA
X-Gm-Gg: ASbGncvD7um6dxjkYbWnUf/Y2fDx46jAV5ZTwRfAjjpZMDvyapjFuX3fE4wwCf94zAb
 lU68dVAxQPJWDOjdOKN9zpNBbHtOrYQHu7fyiH+7X7kSRmGnUSV+ZkK7/FbeOVmvWr9Xbm81rFt
 oYX7xZ715QIEvTGTyLzovVzkK5gg8qvSHTsOS9kOpDB0wwaH4KlDyW3zA16XRtdOkV4Uj0gX03L
 m32/P0sQVl0Aefntyze8idJZ77LA9PaGBSx38aJzpkQ5GKXs65h3p+Lz7bFlseUSta36XDjDGoK
 3bi5+cE=
X-Received: by 2002:ac8:7d48:0:b0:472:8fd:90ee with SMTP id
 d75a77b69052e-476109820c1mr54585901cf.13.1741368440344; 
 Fri, 07 Mar 2025 09:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Gc3tn1wY2x5o7Dk3NoHZ1divXTZsC0hvYIoDuICxiafMPZUKdcy9v0XDwdfZ0Tqj4KmYzg==
X-Received: by 2002:ac8:7d48:0:b0:472:8fd:90ee with SMTP id
 d75a77b69052e-476109820c1mr54584811cf.13.1741368439128; 
 Fri, 07 Mar 2025 09:27:19 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db2f9b6sm22419991cf.58.2025.03.07.09.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 09:27:17 -0800 (PST)
Date: Fri, 7 Mar 2025 12:27:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
Message-ID: <Z8ssc0NETt9KJjTG@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307134203.29443-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Mar 07, 2025 at 10:42:02AM -0300, Fabiano Rosas wrote:
> There's currently no documentation for multifd, we can at least
> provide an overview of the feature.

We missed this for a long time indeed..

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> Keep in mind the feature grew organically over the years and it has
> had bugs that required reinventing some concepts, specially on the
> sync part, so there's still some amount of inconsistency in the code
> and that's not going to be fixed by documentation.
> ---
>  docs/devel/migration/features.rst |   1 +
>  docs/devel/migration/multifd.rst  | 254 ++++++++++++++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 docs/devel/migration/multifd.rst
> 
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 8f431d52f9..249d653124 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -15,3 +15,4 @@ Migration has plenty of features to support different use cases.
>     qpl-compression
>     uadk-compression
>     qatzip-compression
> +   multifd

Considering that it's one of the main features (e.g. all compressors above
are only sub-features of multifd), we could move this upper, maybe even the
1st one.

> diff --git a/docs/devel/migration/multifd.rst b/docs/devel/migration/multifd.rst
> new file mode 100644
> index 0000000000..8f5ec840cb
> --- /dev/null
> +++ b/docs/devel/migration/multifd.rst
> @@ -0,0 +1,254 @@
> +Multifd
> +=======
> +
> +Multifd is the name given for the migration capability that enables
> +data transfer using multiple threads. Multifd supports all the
> +transport types currently in use with migration (inet, unix, vsock,
> +fd, file).

I never tried vsock, would it be used in any use case?

It seems to be introduced by accident in 72a8192e225cea, but I'm not sure.
Maybe there's something I missed.

If we don't plan to obsolete rdma, we may also want to mention it.. in
which case it doesn't support multifd.

> +
> +Usage
> +-----
> +
> +On both source and destination, enable the ``multifd`` capability:
> +
> +    ``migrate_set_capability multifd on``
> +
> +Define a number of channels to use (default is 2, but 8 usually
> +provides best performance).
> +
> +    ``migrate_set_parameter multifd-channels 8``
> +
> +Restrictions
> +------------
> +
> +For migration to a file, support is conditional on the presence of the
> +mapped-ram capability, see `mapped-ram`.
> +
> +Snapshots are currently not supported.
> +
> +`postcopy` migration is currently not supported.
> +
> +Components
> +----------
> +
> +Multifd consists of:
> +
> +- A client that produces the data on the migration source side and
> +  consumes it on the destination. Currently the main client code is
> +  ram.c, which selects the RAM pages for migration;
> +
> +- A shared data structure (``MultiFDSendData``), used to transfer data
> +  between multifd and the client. On the source side, this structure
> +  is further subdivided into payload types (``MultiFDPayload``);
> +
> +- An API operating on the shared data structure to allow the client

s/An API/A set of APIs/

> +  code to interact with multifd;
> +
> +  - ``multifd_send/recv()``: Transfers work to/from the channels.
> +
> +  - ``multifd_*payload_*`` and ``MultiFDPayloadType``: Support
> +    defining an opaque payload. The payload is always wrapped by
> +    ``MultiFD*Data``.
> +
> +  - ``multifd_send_data_*``: Used to manage the memory for the shared
> +    data structure.
> +
> +  - ``multifd_*_sync_main()``: See :ref:`synchronization` below.

When in doc, it might be helpful to list exact function names without
asterisks, so that people can grep for them when reading.

> +
> +- A set of threads (aka channels, due to a 1:1 mapping to QIOChannels)
> +  responsible for doing I/O. Each multifd channel supports callbacks
> +  (``MultiFDMethods``) that can be used for fine-grained processing of
> +  the payload, such as compression and zero page detection.
> +
> +- A packet which is the final result of all the data aggregation
> +  and/or transformation. The packet contains: a *header* with magic and
> +  version numbers and flags that inform of special processing needed
> +  on the destination; a *payload-specific header* with metadata referent
> +  to the packet's data portion, e.g. page counts; and a variable-size
> +  *data portion* which contains the actual opaque payload data.
> +
> +  Note that due to historical reasons, the terminology around multifd
> +  packets is inconsistent.
> +
> +  The `mapped-ram` feature ignores packets entirely.

If above "packet" section does not cover mapped-ram, while mapped-ram is
part of multifd, maybe it means we should reword it?

One option is we drop above paragraph completely, but enrich the previous
section ("A set of threads.."), with:

    ... such as compression and zero page detection.  Multifd threads can
    dump the results to different targets.  For socket-based URIs, the data
    will be queued to the socket with multifd specific headers.  For
    file-based URIs, the data may be applied directly on top of the target
    file at specific offset.

Optionally, we may have another separate section to explain the socket
headers.  If so, we could have the header definition directly, and explain
the fields.  Might be more straightforward too.

> +
> +Operation
> +---------
> +
> +The multifd channels operate in parallel with the main migration
> +thread. The transfer of data from a client code into multifd happens
> +from the main migration thread using the multifd API.
> +
> +The interaction between the client code and the multifd channels
> +happens in the ``multifd_send()`` and ``multifd_recv()``
> +methods. These are reponsible for selecting the next idle channel and
> +making the shared data structure containing the payload accessible to
> +that channel. The client code receives back an empty object which it
> +then uses for the next iteration of data transfer.
> +
> +The selection of idle channels is simply a round-robin over the idle
> +channels (``!p->pending_job``). Channels wait at a semaphore and once
> +a channel is released it starts operating on the data immediately.

The sender side is always like this indeed.  For the recv side (and since
you also mentioned it above), multifd treats it differently based on socket
or file based.  Maybe we should also discuss socket-based?

Something like this?

  Multifd receive side relies on a proper ``MultiFDMethods.recv()`` method
  provided by the consumer of the pages to know how to load the pages.  The
  recv threads can work in different ways depending on the channel type.

  For socket-based channels, multifd recv side is almost event-driven.
  Each multifd recv threads will be blocked reading the channels until a
  complete multifd packet header is received.  With that, pages are loaded
  as they arrive on the ports with the ``MultiFDMethods.recv()`` method
  provided by the client, so as to post-process the data received.

  For file-based channels, multifd recv side works slightly differently.
  It works more like the sender side, that client can queue requests to
  multifd recv threads to load specific portion of file into corresponding
  portion of RAMs.  The ``MultiFDMethods.recv()`` in this case simply
  always executes the load operation from file as requested.

Feel free to take all or none.  You can also mention it after the next
paragraph on "client-specific handling".  Anyway, some mentioning of
event-driven model used in socket channels would be nice.

> +
> +Aside from eventually transmitting the data over the underlying
> +QIOChannel, a channel's operation also includes calling back to the
> +client code at pre-determined points to allow for client-specific
> +handling such as data transformation (e.g. compression), creation of
> +the packet header and arranging the data into iovs (``struct
> +iovec``). Iovs are the type of data on which the QIOChannel operates.
> +
> +A high-level flow for each thread is:
> +
> +Migration thread:
> +
> +#. Populate shared structure with opaque data (e.g. ram pages)
> +#. Call ``multifd_send()``
> +
> +   #. Loop over the channels until one is idle
> +   #. Switch pointers between client data and channel data
> +   #. Release channel semaphore
> +#. Receive back empty object
> +#. Repeat
> +
> +Multifd thread:
> +
> +#. Channel idle
> +#. Gets released by ``multifd_send()``
> +#. Call ``MultiFDMethods`` methods to fill iov
> +
> +   #. Compression may happen
> +   #. Zero page detection may happen
> +   #. Packet is written
> +   #. iov is written
> +#. Pass iov into QIOChannel for transferring (I/O happens here)
> +#. Repeat
> +
> +The destination side operates similarly but with ``multifd_recv()``,
> +decompression instead of compression, etc. One important aspect is
> +that when receiving the data, the iov will contain host virtual
> +addresses, so guest memory is written to directly from multifd
> +threads.
> +
> +About flags
> +-----------
> +The main thread orchestrates the migration by issuing control flags on
> +the migration stream (``QEMU_VM_*``).
> +
> +The main memory is migrated by ram.c and includes specific control
> +flags that are also put on the main migration stream
> +(``RAM_SAVE_FLAG_*``).
> +
> +Multifd has its own set of flags (``MULTIFD_FLAG_*``) that are
> +included into each packet. These may inform about properties such as
> +the compression algorithm used if the data is compressed.

I think I get your intention, on that we have different levels of flags and
maybe it's not easy to know which is which.  However since this is multifd
specific doc, from that POV the first two paragraphs may be more suitable
for some more high level doc to me.

Meanwhile, I feel that reading the flag section without a quick packet
header introduction is a tiny little abrupt to readers, as the flag is part
of the packet but it came from nowhere yet.  One option is we make this
section "multifd packet header" then introduce all fields quickly including
the flags.  If you like keeping this it's ok too, we can work on top.

> +
> +.. _synchronization:
> +
> +Synchronization
> +---------------
> +
> +Data sent through multifd may arrive out of order and with different
> +timing. Some clients may also have synchronization requirements to
> +ensure data consistency, e.g. the RAM migration must ensure that
> +memory pages received by the destination machine are ordered in
> +relation to previous iterations of dirty tracking.
> +
> +Some cleanup tasks such as memory deallocation or error handling may
> +need to happen only after all channels have finished sending/receiving
> +the data.
> +
> +Multifd provides the ``multifd_send_sync_main()`` and
> +``multifd_recv_sync_main()`` helpers to synchronize the main migration
> +thread with the multifd channels. In addition, these helpers also
> +trigger the emission of a sync packet (``MULTIFD_FLAG_SYNC``) which
> +carries the synchronization command to the remote side of the
> +migration.

[1]

> +
> +After the channels have been put into a wait state by the sync
> +functions, the client code may continue to transmit additional data by
> +issuing ``multifd_send()`` once again.
> +
> +Note:
> +
> +- the RAM migration does, effectively, a global synchronization by
> +  chaining a call to ``multifd_send_sync_main()`` with the emission of a
> +  flag on the main migration channel (``RAM_SAVE_FLAG_MULTIFD_FLUSH``)

... or RAM_SAVE_FLAG_EOS ... depending on the machine type.

Maybe we should also add a sentence on the relationship of
MULTIFD_FLAG_SYNC and RAM_SAVE_FLAG_MULTIFD_FLUSH (or RAM_SAVE_FLAG_EOS ),
in that they should always be sent together, and only if so would it
provide ordering of multifd messages and what happens in the main migration
thread.

Maybe we can attach that sentence at the end of [1].

> +  which in turn causes ``multifd_recv_sync_main()`` to be called on the
> +  destination.
> +
> +  There are also backward compatibility concerns expressed by
> +  ``multifd_ram_sync_per_section()`` and
> +  ``multifd_ram_sync_per_round()``. See the code for detailed
> +  documentation.
> +
> +- the `mapped-ram` feature has different requirements because it's an
> +  asynchronous migration (source and destination not migrating at the
> +  same time). For that feature, only the sync between the channels is
> +  relevant to prevent cleanup to happen before data is completely
> +  written to (or read from) the migration file.
> +
> +Data transformation
> +-------------------
> +
> +The ``MultiFDMethods`` structure defines callbacks that allow the
> +client code to perform operations on the data at key points. These
> +operations could be client-specific (e.g. compression), but also
> +include a few required steps such as moving data into an iovs. See the
> +struct's definition for more detailed documentation.
> +
> +Historically, the only client for multifd has been the RAM migration,
> +so the ``MultiFDMethods`` are pre-registered in two categories,
> +compression and no-compression, with the latter being the regular,
> +uncompressed ram migration.
> +
> +Zero page detection
> ++++++++++++++++++++
> +
> +The migration without compression has a further specificity of

Compressors also have zero page detection.  E.g.:

  multifd_send_zero_page_detect()
    <- multifd_send_prepare_common()
      <- multifd_zstd_send_prepare()

> +possibly doing zero page detection. It involves doing the detection of
> +a zero page directly in the multifd channels instead of beforehand on
> +the main migration thread (as it's been done in the past). This is the
> +default behavior and can be disabled with:
> +
> +    ``migrate_set_parameter zero-page-detection legacy``
> +
> +or to disable zero page detection completely:
> +
> +    ``migrate_set_parameter zero-page-detection none``
> +
> +Error handling
> +--------------
> +
> +Any part of multifd code can be made to exit by setting the
> +``exiting`` atomic flag of the multifd state. Whenever a multifd
> +channel has an error, it should break out of its loop, set the flag to
> +indicate other channels to exit as well and set the migration error
> +with ``migrate_set_error()``.
> +
> +For clean exiting (triggered from outside the channels), the
> +``multifd_send|recv_terminate_threads()`` functions set the
> +``exiting`` flag and additionally release any channels that may be
> +idle or waiting for a sync.
> +
> +Code structure
> +--------------
> +
> +Multifd code is divided into:
> +
> +The main file containing the core routines
> +
> +- multifd.c
> +
> +RAM migration
> +
> +- multifd-nocomp.c (nocomp, for "no compression")
> +- multifd-zero-page.c
> +- ram.c (also involved in non-multifd migrations & snapshots)
> +
> +Compressors
> +
> +- multifd-uadk.c
> +- multifd-qatzip.c
> +- multifd-zlib.c
> +- multifd-qpl.c
> +- multifd-zstd.c
> -- 
> 2.35.3
> 

-- 
Peter Xu


