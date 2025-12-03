Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E183D12D79
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoXZ-0006ST-QK; Wed, 03 Dec 2025 10:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXS-0006PI-75
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQoXO-0002gn-CQ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764774781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NS6w6KdHcQcn4Oa7vFcbay0308A5orW2mHsCXGvv/l4=;
 b=UxYPFMFfYOfZd5sQ75ZOMDzRXq6hbx0iVD6jcPh1h03Bn8u7SExV21C6aq0uWcQkCuCyjw
 O5zkNb73d/d32nOEBb6r2eYR8gzVtbOubzi5qOTNsahnlIvaf1ZvXotICPr+tQSCl52f1j
 t7z5ZEvIYrxxkOL7GrzcBL4Oai5O2ck=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-HXDkHKugPgqbuzpB0jrmqQ-1; Wed,
 03 Dec 2025 10:12:57 -0500
X-MC-Unique: HXDkHKugPgqbuzpB0jrmqQ-1
X-Mimecast-MFC-AGG-ID: HXDkHKugPgqbuzpB0jrmqQ_1764774776
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDBEB195609D; Wed,  3 Dec 2025 15:12:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C501180044F; Wed,  3 Dec 2025 15:12:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/6] docs/interop/vfio-user: update protocol specification
Date: Wed,  3 Dec 2025 16:12:44 +0100
Message-ID: <20251203151249.2707207-2-clg@redhat.com>
In-Reply-To: <20251203151249.2707207-1-clg@redhat.com>
References: <20251203151249.2707207-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

Refresh the protocol specification to the latest version implemented by
libvfio-user. All changes are backward compatible.

Note that QEMU client itself does not yet implement these extensions,
but as this is now the canonical specification, it needs to be kept up
to date.

Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20251010102453.711072-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/interop/vfio-user.rst | 554 +++++++++++++++++++++++++++++++++----
 1 file changed, 506 insertions(+), 48 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 0b06f026b0d745f9f120d73717e967e145f35d38..303fc13d6ec4c32c32bd95604c75239342d85062 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -76,7 +76,7 @@ structures used in the ``ioctl()`` implementation. Messages derived from the
 ``ioctl()`` will have a name derived from the ``ioctl()`` command name.  E.g., the
 ``VFIO_DEVICE_GET_INFO`` ``ioctl()`` command becomes a
 ``VFIO_USER_DEVICE_GET_INFO`` message.  The purpose of this reuse is to share as
-much code as feasible with the ``ioctl()`` implementation``.
+much code as feasible with the ``ioctl()`` implementation.
 
 Connection Initiation
 ^^^^^^^^^^^^^^^^^^^^^
@@ -201,12 +201,32 @@ A server can serve:
 1) one or more clients, and/or
 2) one or more virtual devices, belonging to one or more clients.
 
-The current protocol specification requires a dedicated socket per
-client/server connection. It is a server-side implementation detail whether a
-single server handles multiple virtual devices from the same or multiple
-clients. The location of the socket is implementation-specific. Multiplexing
-clients, devices, and servers over the same socket is not supported in this
-version of the protocol.
+The current protocol specification requires dedicated sockets per
+client/server connection. Commands in the client-to-server direction are
+handled on the main communication socket which the client connects to, and
+replies to these commands are passed on the same socket. Commands sent in the
+other direction from the server to the client as well as their corresponding
+replies can optionally be passed across a separate socket, which is set up
+during negotiation (AF_UNIX servers just pass the file descriptor).
+
+Using separate sockets for each command channel avoids introducing an
+artificial point of synchronization between the channels. This simplifies
+implementations since it obviates the need to demultiplex incoming messages
+into commands and replies and interleave command handling and reply processing.
+Note that it is still illegal for implementations to stall command or reply
+processing indefinitely while waiting for replies on the other channel, as this
+may lead to deadlocks. However, since incoming commands and requests arrive on
+different sockets, it's possible to meet this requirement e.g. by running two
+independent request processing threads that can internally operate
+synchronously. It is expected that this is simpler to implement than fully
+asynchronous message handling code. Implementations may still choose a fully
+asynchronous, event-based design for other reasons, and the protocol fully
+supports it.
+
+It is a server-side implementation detail whether a single server handles
+multiple virtual devices from the same or multiple clients. The location of the
+socket is implementation-specific. Multiplexing clients, devices, and servers
+over the same socket is not supported in this version of the protocol.
 
 Authentication
 --------------
@@ -364,6 +384,9 @@ Name                                    Command    Request Direction
 ``VFIO_USER_DMA_WRITE``                 12         server -> client
 ``VFIO_USER_DEVICE_RESET``              13         client -> server
 ``VFIO_USER_REGION_WRITE_MULTI``        15         client -> server
+``VFIO_USER_DEVICE_FEATURE``            16         client -> server
+``VFIO_USER_MIG_DATA_READ``             17         client -> server
+``VFIO_USER_MIG_DATA_WRITE``            18         client -> server
 ======================================  =========  =================
 
 Header
@@ -486,45 +509,48 @@ format:
 
 Capabilities:
 
-+--------------------+---------+------------------------------------------------+
-| Name               | Type    | Description                                    |
-+====================+=========+================================================+
-| max_msg_fds        | number  | Maximum number of file descriptors that can be |
-|                    |         | received by the sender in one message.         |
-|                    |         | Optional. If not specified then the receiver   |
-|                    |         | must assume a value of ``1``.                  |
-+--------------------+---------+------------------------------------------------+
-| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages;  |
-|                    |         | see `Read and Write Operations`_. Optional,    |
-|                    |         | with a default value of 1048576 bytes.         |
-+--------------------+---------+------------------------------------------------+
-| pgsizes            | number  | Page sizes supported in DMA map operations     |
-|                    |         | or'ed together. Optional, with a default value |
-|                    |         | of supporting only 4k pages.                   |
-+--------------------+---------+------------------------------------------------+
-| max_dma_maps       | number  | Maximum number DMA map windows that can be     |
-|                    |         | valid simultaneously.  Optional, with a        |
-|                    |         | value of 65535 (64k-1).                        |
-+--------------------+---------+------------------------------------------------+
-| migration          | object  | Migration capability parameters. If missing    |
-|                    |         | then migration is not supported by the sender. |
-+--------------------+---------+------------------------------------------------+
-| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages      |
-|                    |         | are supported if the value is ``true``.        |
-+--------------------+---------+------------------------------------------------+
-
-The migration capability contains the following name/value pairs:
-
-+-----------------+--------+--------------------------------------------------+
-| Name            | Type   | Description                                      |
-+=================+========+==================================================+
-| pgsize          | number | Page size of dirty pages bitmap. The smallest    |
-|                 |        | between the client and the server is used.       |
-+-----------------+--------+--------------------------------------------------+
-| max_bitmap_size | number | Maximum bitmap size in ``VFIO_USER_DIRTY_PAGES`` |
-|                 |        | and ``VFIO_DMA_UNMAP`` messages.  Optional,      |
-|                 |        | with a default value of 256MB.                   |
-+-----------------+--------+--------------------------------------------------+
++--------------------+---------+-----------------------------------------------+
+| Name               | Type    | Description                                   |
++====================+=========+===============================================+
+| max_msg_fds        | number  | Maximum number of file descriptors that can   |
+|                    |         | be received by the sender in one message.     |
+|                    |         | Optional. If not specified then the receiver  |
+|                    |         | must assume a value of ``1``.                 |
++--------------------+---------+-----------------------------------------------+
+| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages; |
+|                    |         | see `Read and Write Operations`_. Optional,   |
+|                    |         | with a default value of 1048576 bytes.        |
++--------------------+---------+-----------------------------------------------+
+| max_dma_maps       | number  | Maximum number DMA map windows that can be    |
+|                    |         | valid simultaneously.  Optional, with a       |
+|                    |         | value of 65535 (64k-1).                       |
++--------------------+---------+-----------------------------------------------+
+| pgsizes            | number  | Page sizes supported in DMA map operations    |
+|                    |         | or'ed together. Optional, with a default      |
+|                    |         | value of supporting only 4k pages.            |
++--------------------+---------+-----------------------------------------------+
+| twin_socket        | object  | Parameters for twin-socket mode, which        |
+|                    |         | handles server-to-client commands and their   |
+|                    |         | replies on a separate socket. Optional.       |
++--------------------+---------+-----------------------------------------------+
+| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
+|                    |         | are supported if the value is ``true``.       |
++--------------------+---------+-----------------------------------------------+
+
+The ``twin_socket`` capability object holds these name/value pairs:
+
++-----------+---------+--------------------------------------------------------+
+| Name      | Type    | Description                                            |
++===========+=========+========================================================+
+| supported | boolean | Indicates whether the sender supports twin-socket      |
+|           |         | mode. Optional, defaults to false.                     |
++-----------+---------+--------------------------------------------------------+
+| fd_index  | number  | Specifies an index in the file descriptor array        |
+|           |         | included with the message. The designated file         |
+|           |         | descriptor is a socket which is to be used for the     |
+|           |         | server-to-client command channel. Optional, only valid |
+|           |         | in the reply message.                                  |
++-----------+---------+--------------------------------------------------------+
 
 Reply
 ^^^^^
@@ -532,6 +558,38 @@ Reply
 The same message format is used in the server's reply with the semantics
 described above.
 
+If and only if the client has indicated support for twin-socket mode by setting
+``twin_socket.supported`` to true in its capabilities, the server may optionally
+set up a separate command channel for server-to-client commands and their
+replies. The server enables twin-socket mode as follows:
+
+* Create a fresh socket pair.
+* Keep the server end of the socket pair and pass the client end in the file
+  descriptor array included with the reply message.
+* Set ``twin_socket.supported`` to true in the reply.
+* Indicate the index in the file descriptor array by the
+  ``twin_socket.fd_index`` capability field in the reply, so the client can
+  identify the correct file descriptor to use.
+
+A client requesting twin-socket mode must examine the ``twin_socket`` capability
+in the reply:
+
+* If ``twin_socket.supported`` is false, the field is missing, or the entire
+  ``twin_socket`` object is absent, the server does not support twin-socket mode
+  or decided not to enable it. The client can choose whether it wants to proceed
+  without twin-socket mode, or close the connection if not.
+* If ``twin_socket.supported`` is true and ``twin_socket.fd_index`` is present
+  and refers to a valid file descriptor, twin-socket mode negotiation has
+  succeeded. The client monitors the provided file descriptor for commands from
+  the server.
+* Otherwise, the reply from the server is inconsistent. The client must abort
+  and close the connection since it is potentially unable to receive commands
+  from the server.
+
+The twin-socket feature is optional, so some servers may not support it.
+However, for server implementations that do send server-to-client commands it is
+strongly recommended to implement twin-socket support.
+
 ``VFIO_USER_DMA_MAP``
 ---------------------
 
@@ -1335,7 +1393,9 @@ Reply
 -----------------------
 
 If the client has not shared mappable memory, the server can use this message to
-read from guest memory.
+read from guest memory. This message and its reply are passed over the separate
+server-to-client socket if twin-socket mode has been negotiated during
+connection setup.
 
 Request
 ^^^^^^^
@@ -1373,7 +1433,9 @@ Reply
 -----------------------
 
 If the client has not shared mappable memory, the server can use this message to
-write to guest memory.
+write to guest memory. This message and its reply are passed over the separate
+server-to-client socket if twin-socket mode has been negotiated during
+connection setup.
 
 Request
 ^^^^^^^
@@ -1466,6 +1528,402 @@ Reply
 
 * *wr_cnt* is the number of device writes completed.
 
+``VFIO_USER_DEVICE_FEATURE``
+----------------------------
+
+This command is analogous to ``VFIO_DEVICE_FEATURE``. It is used to get, set, or
+probe feature data of the device.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+--------------------------------+
+| Name  | Offset | Size                           |
++=======+========+================================+
+| argsz | 0      | 4                              |
++-------+--------+--------------------------------+
+| flags | 4      | 4                              |
++-------+--------+--------------------------------+
+|       | +---------+---------------------------+ |
+|       | | Bit     | Definition                | |
+|       | +=========+===========================+ |
+|       | | 0 to 15 | Feature index             | |
+|       | +---------+---------------------------+ |
+|       | | 16      | VFIO_DEVICE_FEATURE_GET   | |
+|       | +---------+---------------------------+ |
+|       | | 17      | VFIO_DEVICE_FEATURE_SET   | |
+|       | +---------+---------------------------+ |
+|       | | 18      | VFIO_DEVICE_FEATURE_PROBE | |
+|       | +---------+---------------------------+ |
++-------+--------+--------------------------------+
+| data  | 8      | variable                       |
++-------+--------+--------------------------------+
+
+* *argsz* is the maximum size of the reply payload.
+
+* *flags* defines the action to be performed by the server and upon which
+  feature:
+
+  * The feature index consists of the least significant 16 bits of the flags
+    field, and can be accessed using the ``VFIO_DEVICE_FEATURE_MASK`` bit mask.
+
+  * ``VFIO_DEVICE_FEATURE_GET`` instructs the server to get the data for the
+    given feature.
+
+  * ``VFIO_DEVICE_FEATURE_SET`` instructs the server to set the feature data to
+    that given in the ``data`` field of the payload.
+
+  * ``VFIO_DEVICE_FEATURE_PROBE`` instructs the server to probe for feature
+    support. If ``VFIO_DEVICE_FEATURE_GET`` and/or ``VFIO_DEVICE_FEATURE_SET``
+    are also set, the probe will only return success if all of the indicated
+    methods are supported.
+
+  ``VFIO_DEVICE_FEATURE_GET`` and ``VFIO_DEVICE_FEATURE_SET`` are mutually
+  exclusive, except for use with ``VFIO_DEVICE_FEATURE_PROBE``.
+
+* *data* is specific to the particular feature. It is not used for probing.
+
+This part of the request is analogous to VFIO's ``struct vfio_device_feature``.
+
+Reply
+^^^^^
+
+The reply payload must be the same as the request payload for setting or
+probing a feature. For getting a feature's data, the data is added in the data
+section and its length is added to ``argsz``.
+
+Device Features
+^^^^^^^^^^^^^^^
+
+The only device features supported by vfio-user are those related to migration,
+although this may change in the future. They are a subset of those supported in
+the VFIO implementation of the Linux kernel.
+
++----------------------------------------+---------------+
+| Name                                   | Feature Index |
++========================================+===============+
+| VFIO_DEVICE_FEATURE_MIGRATION          | 1             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE   | 2             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_START  | 6             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP   | 7             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT | 8             |
++----------------------------------------+---------------+
+
+``VFIO_DEVICE_FEATURE_MIGRATION``
+"""""""""""""""""""""""""""""""""
+
+This feature indicates that the device can support the migration API through
+``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``. If ``GET`` succeeds, the ``RUNNING``
+and ``ERROR`` states are always supported. Support for additional states is
+indicated via the flags field; at least ``VFIO_MIGRATION_STOP_COPY`` must be
+set.
+
+There is no data field of the request message.
+
+The data field of the reply message is structured as follows:
+
++-------+--------+---------------------------+
+| Name  | Offset | Size                      |
++=======+========+===========================+
+| flags | 0      | 8                         |
++-------+--------+---------------------------+
+|       | +-----+--------------------------+ |
+|       | | Bit | Definition               | |
+|       | +=====+==========================+ |
+|       | | 0   | VFIO_MIGRATION_STOP_COPY | |
+|       | +-----+--------------------------+ |
+|       | | 1   | VFIO_MIGRATION_P2P       | |
+|       | +-----+--------------------------+ |
+|       | | 2   | VFIO_MIGRATION_PRE_COPY  | |
+|       | +-----+--------------------------+ |
++-------+--------+---------------------------+
+
+These flags are interpreted in the same way as VFIO.
+
+``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``
+""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_SET``, execute a migration state change on the VFIO
+device. The new state is supplied in ``device_state``. The state transition must
+fully complete before the reply is sent.
+
+The data field of the reply message, as well as the ``SET`` request message, is
+structured as follows:
+
++--------------+--------+------+
+| Name         | Offset | Size |
++==============+========+======+
+| device_state | 0      | 4    |
++--------------+--------+------+
+| data_fd      | 4      | 4    |
++--------------+--------+------+
+
+* *device_state* is the current state of the device (for ``GET``) or the
+  state to transition to (for ``SET``). It is defined by the
+  ``vfio_device_mig_state`` enum as detailed below. These states are the states
+  of the device migration Finite State Machine.
+
++--------------------------------+-------+---------------------------------------------------------------------+
+| Name                           | State | Description                                                         |
++================================+=======+=====================================================================+
+| VFIO_DEVICE_STATE_ERROR        | 0     | The device has failed and must be reset.                            |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_STOP         | 1     | The device does not change the internal or external state.          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RUNNING      | 2     | The device is running normally.                                     |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_STOP_COPY    | 3     | The device internal state can be read out.                          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RESUMING     | 4     | The device is stopped and is loading a new internal state.          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RUNNING_P2P  | 5     | (not used in vfio-user)                                             |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_PRE_COPY     | 6     | The device is running normally but tracking internal state changes. |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_PRE_COPY_P2P | 7     | (not used in vfio-user)                                             |
++--------------------------------+-------+---------------------------------------------------------------------+
+
+* *data_fd* is unused in vfio-user, as the ``VFIO_USER_MIG_DATA_READ`` and
+  ``VFIO_USER_MIG_DATA_WRITE`` messages are used instead for migration data
+  transport.
+
+Direct State Transitions
+""""""""""""""""""""""""
+
+The device migration FSM is a Mealy machine, so actions are taken upon the arcs
+between FSM states. The following transitions need to be supported by the
+server, a subset of those defined in ``<linux/vfio.h>``
+(``enum vfio_device_mig_state``).
+
+* ``RUNNING -> STOP``, ``STOP_COPY -> STOP``: Stop the operation of the device.
+  The ``STOP_COPY`` arc terminates the data transfer session.
+
+* ``RESUMING -> STOP``: Terminate the data transfer session. Complete processing
+  of the migration data. Stop the operation of the device. If the delivered data
+  is found to be incomplete, inconsistent, or otherwise invalid, fail the
+  ``SET`` command and optionally transition to the ``ERROR`` state.
+
+* ``PRE_COPY -> RUNNING``: Terminate the data transfer session. The device is
+  now fully operational.
+
+* ``STOP -> RUNNING``: Start the operation of the device.
+
+* ``RUNNING -> PRE_COPY``, ``STOP -> STOP_COPY``: Begin the process of saving
+  the device state. The device operation is unchanged, but data transfer begins.
+  ``PRE_COPY`` and ``STOP_COPY`` are referred to as the "saving group" of
+  states.
+
+* ``PRE_COPY -> STOP_COPY``: Continue to transfer migration data, but stop
+  device operation.
+
+* ``STOP -> RESUMING``: Start the process of restoring the device state. The
+  internal device state may be changed to prepare the device to receive the
+  migration data.
+
+The ``STOP_COPY -> PRE_COPY`` transition is explicitly not allowed and should
+return an error if requested.
+
+``ERROR`` cannot be specified as a device state, but any transition request can
+be failed and then move the state into ``ERROR`` if the server was unable to
+execute the requested arc AND was unable to restore the device into any valid
+state. To recover from ``ERROR``, ``VFIO_USER_DEVICE_RESET`` must be used to
+return back to ``RUNNING``.
+
+If ``PRE_COPY`` is not supported, arcs touching it are removed.
+
+Complex State Transitions
+"""""""""""""""""""""""""
+
+The remaining possible transitions are to be implemented as combinations of the
+above FSM arcs. As there are multiple paths, the path should be selected based
+on the following rules:
+
+* Select the shortest path.
+
+* The path cannot have saving group states as interior arcs, only start/end
+  states.
+
+``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` / ``VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP``
+""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_SET``, start/stop DMA logging. These features can
+also be probed to determine whether the device supports DMA logging.
+
+When DMA logging is started, a range of IOVAs to monitor is provided and the
+device can optimize its logging to cover only the IOVA range given. Only DMA
+writes are logged.
+
+The data field of the ``SET`` request is structured as follows:
+
++------------+--------+----------+
+| Name       | Offset | Size     |
++============+========+==========+
+| page_size  | 0      | 8        |
++------------+--------+----------+
+| num_ranges | 8      | 4        |
++------------+--------+----------+
+| reserved   | 12     | 4        |
++------------+--------+----------+
+| ranges     | 16     | variable |
++------------+--------+----------+
+
+* *page_size* hints what tracking granularity the device should try to achieve.
+  If the device cannot do the hinted page size then it's the driver's choice
+  which page size to pick based on its support. On output the device will return
+  the page size it selected.
+
+* *num_ranges* is the number of IOVA ranges to monitor. A value of zero
+  indicates that all writes should be logged.
+
+* *ranges* is an array of ``vfio_user_device_feature_dma_logging_range``
+  entries:
+
++--------+--------+------+
+| Name   | Offset | Size |
++========+========+======+
+| iova   | 0      | 8    |
++--------+--------+------+
+| length | 8      | 8    |
++--------+--------+------+
+
+  * *iova* is the base IO virtual address
+  * *length* is the length of the range to log
+
+Upon success, the response data field will be the same as the request, unless
+the page size was changed, in which case this will be reflected in the response.
+
+``VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT``
+""""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_GET``, returns the dirty bitmap for a specific IOVA
+range. This operation is only valid if logging of dirty pages has been
+previously started by setting ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START``.
+
+The data field of the request is structured as follows:
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| iova      | 0      | 8    |
++-----------+--------+------+
+| length    | 8      | 8    |
++-----------+--------+------+
+| page_size | 16     | 8    |
++-----------+--------+------+
+
+* *iova* is the base IO virtual address
+
+* *length* is the length of the range
+
+* *page_size* is the unit of granularity of the bitmap, and must be a power of
+  two. It doesn't have to match the value given to
+  ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` because the driver will format its
+  internal logging to match the reporting page size possibly by replicating bits
+  if the internal page size is lower than requested
+
+The data field of the response is identical, except with the bitmap added on
+the end at offset 24.
+
+The bitmap is an array of u64s that holds the output bitmap, with 1 bit
+reporting a *page_size* unit of IOVA. The bits outside of the requested range
+must be zero.
+
+The mapping of IOVA to bits is given by:
+
+``bitmap[(addr - iova)/page_size] & (1ULL << (addr % 64))``
+
+``VFIO_USER_MIG_DATA_READ``
+---------------------------
+
+This command is used to read data from the source migration server while it is
+in a saving group state (``PRE_COPY`` or ``STOP_COPY``).
+
+This command, and ``VFIO_USER_MIG_DATA_WRITE``, are used in place of the
+``data_fd`` file descriptor in ``<linux/vfio.h>``
+(``struct vfio_device_feature_mig_state``) to enable all data transport to use
+the single already-established UNIX socket. Hence, the migration data is
+treated like a stream, so the client must continue reading until no more
+migration data remains.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+------+
+| Name  | Offset | Size |
++=======+========+======+
+| argsz | 0      | 4    |
++-------+--------+------+
+| size  | 4      | 4    |
++-------+--------+------+
+
+* *argsz* is the maximum size of the reply payload.
+
+* *size* is the size of the migration data to read.
+
+Reply
+^^^^^
+
+The reply payload for this message is a structure of the following format.
+
++-------+--------+----------+
+| Name  | Offset | Size     |
++=======+========+==========+
+| argsz | 0      | 4        |
++-------+--------+----------+
+| size  | 4      | 4        |
++-------+--------+----------+
+| data  | 8      | variable |
++-------+--------+----------+
+
+* *argsz* is the size of the above structure, including the size of the data.
+
+* *size* indicates the size of returned migration data. If this is less than the
+  requested size, there is no more migration data to read.
+
+* *data* contains the migration data.
+
+``VFIO_USER_MIG_DATA_WRITE``
+----------------------------
+
+This command is used to write data to the destination migration server while it
+is in the ``RESUMING`` state.
+
+As above, this replaces the ``data_fd`` file descriptor for transport of
+migration data, and as such, the migration data is treated like a stream.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+----------+
+| Name  | Offset | Size     |
++=======+========+==========+
+| argsz | 0      | 4        |
++-------+--------+----------+
+| size  | 4      | 4        |
++-------+--------+----------+
+| data  | 8      | variable |
++-------+--------+----------+
+
+* *argsz* is the maximum size of the reply payload.
+
+* *size* is the size of the migration data to be written.
+
+* *data* contains the migration data.
+
+Reply
+^^^^^
+
+There is no reply payload for this message.
 
 Appendices
 ==========
-- 
2.52.0


