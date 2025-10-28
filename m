Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDrnt-0005Rm-8D; Tue, 28 Oct 2025 18:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnl-0005R7-Ol
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrne-0000sv-Tz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761689057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQo0xD0PYlagfD6A+td/xb7bHLwv+ZNKT5pynFk1gWQ=;
 b=HW0LYuQCRTZf0CSgvTiB0QToaCkkoHGeUyBkdZ79P+ZIhq3BZHb1qw9J/JZQ2oSmLSfDIf
 bYN3oW4kKwXki9t6IXA2ZXujV43QI1Gx9xqVSlzocb1KdG0RKS127raNBeuEvKu4yPpsel
 wNIfJEgcBbnFnVY3vU19LQhZkVpTJfE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-ORGciX-sPAKHFmL-AbnVSw-1; Tue,
 28 Oct 2025 18:04:12 -0400
X-MC-Unique: ORGciX-sPAKHFmL-AbnVSw-1
X-Mimecast-MFC-AGG-ID: ORGciX-sPAKHFmL-AbnVSw_1761689051
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF40B1800657; Tue, 28 Oct 2025 22:04:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 302D830001A2; Tue, 28 Oct 2025 22:04:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH RFC 10/10] python: delete qemu.qmp
Date: Tue, 28 Oct 2025 18:03:40 -0400
Message-ID: <20251028220342.1407883-11-jsnow@redhat.com>
In-Reply-To: <20251028220342.1407883-1-jsnow@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Begin relying on the external python-qemu-qmp dependency instead, to
prevent desync between the internal and external libraries.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 .gitlab-ci.d/buildtest.yml                    |    1 +
 python/qemu/qmp/__init__.py                   |   60 -
 python/qemu/qmp/error.py                      |   53 -
 python/qemu/qmp/events.py                     |  751 -----------
 python/qemu/qmp/legacy.py                     |  339 -----
 python/qemu/qmp/message.py                    |  217 ----
 python/qemu/qmp/models.py                     |  146 ---
 python/qemu/qmp/protocol.py                   | 1101 -----------------
 python/qemu/qmp/py.typed                      |    0
 python/qemu/qmp/qmp_client.py                 |  732 -----------
 python/qemu/qmp/qmp_shell.py                  |  689 -----------
 python/qemu/qmp/qmp_tui.py                    |  665 ----------
 python/qemu/qmp/util.py                       |  150 ---
 python/qemu/utils/qom_fuse.py                 |    1 -
 python/scripts/vendor.py                      |    2 +
 python/setup.cfg                              |   31 +-
 python/tests/minreqs.txt                      |    8 +-
 python/tests/protocol.py                      |  596 ---------
 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl |  Bin 0 -> 72263 bytes
 19 files changed, 9 insertions(+), 5533 deletions(-)
 delete mode 100644 python/qemu/qmp/__init__.py
 delete mode 100644 python/qemu/qmp/error.py
 delete mode 100644 python/qemu/qmp/events.py
 delete mode 100644 python/qemu/qmp/legacy.py
 delete mode 100644 python/qemu/qmp/message.py
 delete mode 100644 python/qemu/qmp/models.py
 delete mode 100644 python/qemu/qmp/protocol.py
 delete mode 100644 python/qemu/qmp/py.typed
 delete mode 100644 python/qemu/qmp/qmp_client.py
 delete mode 100644 python/qemu/qmp/qmp_shell.py
 delete mode 100644 python/qemu/qmp/qmp_tui.py
 delete mode 100644 python/qemu/qmp/util.py
 delete mode 100644 python/tests/protocol.py
 create mode 100644 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 21f6d7e96fe..a2b509a0aef 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -350,6 +350,7 @@ build-tcg-disabled:
     - make -j"$JOBS"
     - make check-unit
     - make check-qapi-schema
+    - meson compile "tests/pyvenv_test_deps"
     - cd tests/qemu-iotests/
     - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
             052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
diff --git a/python/qemu/qmp/__init__.py b/python/qemu/qmp/__init__.py
deleted file mode 100644
index 058139dc3ca..00000000000
--- a/python/qemu/qmp/__init__.py
+++ /dev/null
@@ -1,60 +0,0 @@
-"""
-QEMU Monitor Protocol (QMP) development library & tooling.
-
-This package provides a fairly low-level class for communicating
-asynchronously with QMP protocol servers, as implemented by QEMU, the
-QEMU Guest Agent, and the QEMU Storage Daemon.
-
-`QMPClient` provides the main functionality of this package. All errors
-raised by this library derive from `QMPError`, see `qmp.error` for
-additional detail. See `qmp.events` for an in-depth tutorial on
-managing QMP events.
-"""
-
-# Copyright (C) 2020-2022 John Snow for Red Hat, Inc.
-#
-# Authors:
-#  John Snow <jsnow@redhat.com>
-#
-# Based on earlier work by Luiz Capitulino <lcapitulino@redhat.com>.
-#
-# This work is licensed under the terms of the GNU LGPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-import logging
-
-from .error import QMPError
-from .events import EventListener
-from .message import Message
-from .protocol import (
-    ConnectError,
-    Runstate,
-    SocketAddrT,
-    StateError,
-)
-from .qmp_client import ExecInterruptedError, ExecuteError, QMPClient
-
-
-# Suppress logging unless an application engages it.
-logging.getLogger('qemu.qmp').addHandler(logging.NullHandler())
-
-
-# IMPORTANT: When modifying this list, update the Sphinx overview docs.
-# Anything visible in the qemu.qmp namespace should be on the overview page.
-__all__ = (
-    # Classes, most to least important
-    'QMPClient',
-    'Message',
-    'EventListener',
-    'Runstate',
-
-    # Exceptions, most generic to most explicit
-    'QMPError',
-    'StateError',
-    'ConnectError',
-    'ExecuteError',
-    'ExecInterruptedError',
-
-    # Type aliases
-    'SocketAddrT',
-)
diff --git a/python/qemu/qmp/error.py b/python/qemu/qmp/error.py
deleted file mode 100644
index c87b078f620..00000000000
--- a/python/qemu/qmp/error.py
+++ /dev/null
@@ -1,53 +0,0 @@
-"""
-QMP Error Classes
-
-This package seeks to provide semantic error classes that are intended
-to be used directly by clients when they would like to handle particular
-semantic failures (e.g. "failed to connect") without needing to know the
-enumeration of possible reasons for that failure.
-
-QMPError serves as the ancestor for all exceptions raised by this
-package, and is suitable for use in handling semantic errors from this
-library. In most cases, individual public methods will attempt to catch
-and re-encapsulate various exceptions to provide a semantic
-error-handling interface.
-
-.. admonition:: QMP Exception Hierarchy Reference
-
- |   `Exception`
- |    +-- `QMPError`
- |         +-- `ConnectError`
- |         +-- `StateError`
- |         +-- `ExecInterruptedError`
- |         +-- `ExecuteError`
- |         +-- `ListenerError`
- |         +-- `ProtocolError`
- |              +-- `DeserializationError`
- |              +-- `UnexpectedTypeError`
- |              +-- `ServerParseError`
- |              +-- `BadReplyError`
- |              +-- `GreetingError`
- |              +-- `NegotiationError`
-"""
-
-
-class QMPError(Exception):
-    """Abstract error class for all errors originating from this package."""
-
-
-class ProtocolError(QMPError):
-    """
-    Abstract error class for protocol failures.
-
-    Semantically, these errors are generally the fault of either the
-    protocol server or as a result of a bug in this library.
-
-    :param error_message: Human-readable string describing the error.
-    """
-    def __init__(self, error_message: str, *args: object):
-        super().__init__(error_message, *args)
-        #: Human-readable error message, without any prefix.
-        self.error_message: str = error_message
-
-    def __str__(self) -> str:
-        return self.error_message
diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
deleted file mode 100644
index cfb5f0ac621..00000000000
--- a/python/qemu/qmp/events.py
+++ /dev/null
@@ -1,751 +0,0 @@
-"""
-QMP Events and EventListeners
-
-Asynchronous QMP uses `EventListener` objects to listen for events. An
-`EventListener` is a FIFO event queue that can be pre-filtered to listen
-for only specific events. Each `EventListener` instance receives its own
-copy of events that it hears, so events may be consumed without fear or
-worry for depriving other listeners of events they need to hear.
-
-
-EventListener Tutorial
-----------------------
-
-In all of the following examples, we assume that we have a `QMPClient`
-instantiated named ``qmp`` that is already connected. For example:
-
-.. code:: python
-
-   from qemu.qmp import QMPClient
-
-   qmp = QMPClient('example-vm')
-   await qmp.connect('127.0.0.1', 1234)
-
-
-`listener()` context blocks with one name
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The most basic usage is by using the `listener()` context manager to
-construct them:
-
-.. code:: python
-
-   with qmp.listener('STOP') as listener:
-       await qmp.execute('stop')
-       await listener.get()
-
-The listener is active only for the duration of the ‘with’ block. This
-instance listens only for ‘STOP’ events.
-
-
-`listener()` context blocks with two or more names
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Multiple events can be selected for by providing any ``Iterable[str]``:
-
-.. code:: python
-
-   with qmp.listener(('STOP', 'RESUME')) as listener:
-       await qmp.execute('stop')
-       event = await listener.get()
-       assert event['event'] == 'STOP'
-
-       await qmp.execute('cont')
-       event = await listener.get()
-       assert event['event'] == 'RESUME'
-
-
-`listener()` context blocks with no names
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-By omitting names entirely, you can listen to ALL events.
-
-.. code:: python
-
-   with qmp.listener() as listener:
-       await qmp.execute('stop')
-       event = await listener.get()
-       assert event['event'] == 'STOP'
-
-This isn’t a very good use case for this feature: In a non-trivial
-running system, we may not know what event will arrive next. Grabbing
-the top of a FIFO queue returning multiple kinds of events may be prone
-to error.
-
-
-Using async iterators to retrieve events
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-If you’d like to simply watch what events happen to arrive, you can use
-the listener as an async iterator:
-
-.. code:: python
-
-   with qmp.listener() as listener:
-       async for event in listener:
-           print(f"Event arrived: {event['event']}")
-
-This is analogous to the following code:
-
-.. code:: python
-
-   with qmp.listener() as listener:
-       while True:
-           event = listener.get()
-           print(f"Event arrived: {event['event']}")
-
-This event stream will never end, so these blocks will never
-terminate. Even if the QMP connection errors out prematurely, this
-listener will go silent without raising an error.
-
-
-Using asyncio.Task to concurrently retrieve events
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Since a listener’s event stream will never terminate, it is not likely
-useful to use that form in a script. For longer-running clients, we can
-create event handlers by using `asyncio.Task` to create concurrent
-coroutines:
-
-.. code:: python
-
-   async def print_events(listener):
-       try:
-           async for event in listener:
-               print(f"Event arrived: {event['event']}")
-       except asyncio.CancelledError:
-           return
-
-   with qmp.listener() as listener:
-       task = asyncio.Task(print_events(listener))
-       await qmp.execute('stop')
-       await qmp.execute('cont')
-       task.cancel()
-       await task
-
-However, there is no guarantee that these events will be received by the
-time we leave this context block. Once the context block is exited, the
-listener will cease to hear any new events, and becomes inert.
-
-Be mindful of the timing: the above example will *probably*– but does
-not *guarantee*– that both STOP/RESUMED events will be printed. The
-example below outlines how to use listeners outside of a context block.
-
-
-Using `register_listener()` and `remove_listener()`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-To create a listener with a longer lifetime, beyond the scope of a
-single block, create a listener and then call `register_listener()`:
-
-.. code:: python
-
-   class MyClient:
-       def __init__(self, qmp):
-           self.qmp = qmp
-           self.listener = EventListener()
-
-       async def print_events(self):
-           try:
-               async for event in self.listener:
-                   print(f"Event arrived: {event['event']}")
-           except asyncio.CancelledError:
-               return
-
-       async def run(self):
-           self.task = asyncio.Task(self.print_events)
-           self.qmp.register_listener(self.listener)
-           await qmp.execute('stop')
-           await qmp.execute('cont')
-
-       async def stop(self):
-           self.task.cancel()
-           await self.task
-           self.qmp.remove_listener(self.listener)
-
-The listener can be deactivated by using `remove_listener()`. When it is
-removed, any possible pending events are cleared and it can be
-re-registered at a later time.
-
-
-Using the built-in all events listener
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The `QMPClient` object creates its own default listener named
-:py:obj:`~Events.events` that can be used for the same purpose without
-having to create your own:
-
-.. code:: python
-
-   async def print_events(listener):
-       try:
-           async for event in listener:
-               print(f"Event arrived: {event['event']}")
-       except asyncio.CancelledError:
-           return
-
-   task = asyncio.Task(print_events(qmp.events))
-
-   await qmp.execute('stop')
-   await qmp.execute('cont')
-
-   task.cancel()
-   await task
-
-
-Using both .get() and async iterators
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The async iterator and `get()` methods pull events from the same FIFO
-queue. If you mix the usage of both, be aware: Events are emitted
-precisely once per listener.
-
-If multiple contexts try to pull events from the same listener instance,
-events are still emitted only precisely once.
-
-This restriction can be lifted by creating additional listeners.
-
-
-Creating multiple listeners
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Additional `EventListener` objects can be created at-will. Each one
-receives its own copy of events, with separate FIFO event queues.
-
-.. code:: python
-
-   my_listener = EventListener()
-   qmp.register_listener(my_listener)
-
-   await qmp.execute('stop')
-   copy1 = await my_listener.get()
-   copy2 = await qmp.events.get()
-
-   assert copy1 == copy2
-
-In this example, we await an event from both a user-created
-`EventListener` and the built-in events listener. Both receive the same
-event.
-
-
-Clearing listeners
-~~~~~~~~~~~~~~~~~~
-
-`EventListener` objects can be cleared, clearing all events seen thus far:
-
-.. code:: python
-
-   await qmp.execute('stop')
-   discarded = qmp.events.clear()
-   await qmp.execute('cont')
-   event = await qmp.events.get()
-   assert event['event'] == 'RESUME'
-   assert discarded[0]['event'] == 'STOP'
-
-`EventListener` objects are FIFO queues. If events are not consumed,
-they will remain in the queue until they are witnessed or discarded via
-`clear()`. FIFO queues will be drained automatically upon leaving a
-context block, or when calling `remove_listener()`.
-
-Any events removed from the queue in this fashion will be returned by
-the clear call.
-
-
-Accessing listener history
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-`EventListener` objects record their history. Even after being cleared,
-you can obtain a record of all events seen so far:
-
-.. code:: python
-
-   await qmp.execute('stop')
-   await qmp.execute('cont')
-   qmp.events.clear()
-
-   assert len(qmp.events.history) == 2
-   assert qmp.events.history[0]['event'] == 'STOP'
-   assert qmp.events.history[1]['event'] == 'RESUME'
-
-The history is updated immediately and does not require the event to be
-witnessed first.
-
-
-Using event filters
-~~~~~~~~~~~~~~~~~~~
-
-`EventListener` objects can be given complex filtering criteria if names
-are not sufficient:
-
-.. code:: python
-
-   def job1_filter(event) -> bool:
-       event_data = event.get('data', {})
-       event_job_id = event_data.get('id')
-       return event_job_id == "job1"
-
-   with qmp.listener('JOB_STATUS_CHANGE', job1_filter) as listener:
-       await qmp.execute('blockdev-backup', arguments={'job-id': 'job1', ...})
-       async for event in listener:
-           if event['data']['status'] == 'concluded':
-               break
-
-These filters might be most useful when parameterized. `EventListener`
-objects expect a function that takes only a single argument (the raw
-event, as a `Message`) and returns a bool; True if the event should be
-accepted into the stream. You can create a function that adapts this
-signature to accept configuration parameters:
-
-.. code:: python
-
-   def job_filter(job_id: str) -> EventFilter:
-       def filter(event: Message) -> bool:
-           return event['data']['id'] == job_id
-       return filter
-
-   with qmp.listener('JOB_STATUS_CHANGE', job_filter('job2')) as listener:
-       await qmp.execute('blockdev-backup', arguments={'job-id': 'job2', ...})
-       async for event in listener:
-           if event['data']['status'] == 'concluded':
-               break
-
-
-Activating an existing listener with `listen()`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Listeners with complex, long configurations can also be created manually
-and activated temporarily by using `listen()` instead of `listener()`:
-
-.. code:: python
-
-   listener = EventListener(('BLOCK_JOB_COMPLETED', 'BLOCK_JOB_CANCELLED',
-                             'BLOCK_JOB_ERROR', 'BLOCK_JOB_READY',
-                             'BLOCK_JOB_PENDING', 'JOB_STATUS_CHANGE'))
-
-   with qmp.listen(listener):
-       await qmp.execute('blockdev-backup', arguments={'job-id': 'job3', ...})
-       async for event in listener:
-           print(event)
-           if event['event'] == 'BLOCK_JOB_COMPLETED':
-               break
-
-Any events that are not witnessed by the time the block is left will be
-cleared from the queue; entering the block is an implicit
-`register_listener()` and leaving the block is an implicit
-`remove_listener()`.
-
-
-Activating multiple existing listeners with `listen()`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-While `listener()` is only capable of creating a single listener,
-`listen()` is capable of activating multiple listeners simultaneously:
-
-.. code:: python
-
-   def job_filter(job_id: str) -> EventFilter:
-       def filter(event: Message) -> bool:
-           return event['data']['id'] == job_id
-       return filter
-
-   jobA = EventListener('JOB_STATUS_CHANGE', job_filter('jobA'))
-   jobB = EventListener('JOB_STATUS_CHANGE', job_filter('jobB'))
-
-   with qmp.listen(jobA, jobB):
-       qmp.execute('blockdev-create', arguments={'job-id': 'jobA', ...})
-       qmp.execute('blockdev-create', arguments={'job-id': 'jobB', ...})
-
-       async for event in jobA.get():
-           if event['data']['status'] == 'concluded':
-               break
-       async for event in jobB.get():
-           if event['data']['status'] == 'concluded':
-               break
-
-
-Note that in the above example, we explicitly wait on jobA to conclude
-first, and then wait for jobB to do the same. All we have guaranteed is
-that the code that waits for jobA will not accidentally consume the
-event intended for the jobB waiter.
-
-
-Extending the `EventListener` class
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-In the case that a more specialized `EventListener` is desired to
-provide either more functionality or more compact syntax for specialized
-cases, it can be extended.
-
-One of the key methods to extend or override is
-:py:meth:`~EventListener.accept()`. The default implementation checks an
-incoming message for:
-
-1. A qualifying name, if any :py:obj:`~EventListener.names` were
-   specified at initialization time
-2. That :py:obj:`~EventListener.event_filter()` returns True.
-
-This can be modified however you see fit to change the criteria for
-inclusion in the stream.
-
-For convenience, a ``JobListener`` class could be created that simply
-bakes in configuration so it does not need to be repeated:
-
-.. code:: python
-
-   class JobListener(EventListener):
-       def __init__(self, job_id: str):
-           super().__init__(('BLOCK_JOB_COMPLETED', 'BLOCK_JOB_CANCELLED',
-                             'BLOCK_JOB_ERROR', 'BLOCK_JOB_READY',
-                             'BLOCK_JOB_PENDING', 'JOB_STATUS_CHANGE'))
-           self.job_id = job_id
-
-       def accept(self, event) -> bool:
-           if not super().accept(event):
-               return False
-           if event['event'] in ('BLOCK_JOB_PENDING', 'JOB_STATUS_CHANGE'):
-               return event['data']['id'] == job_id
-           return event['data']['device'] == job_id
-
-From here on out, you can conjure up a custom-purpose listener that
-listens only for job-related events for a specific job-id easily:
-
-.. code:: python
-
-   listener = JobListener('job4')
-   with qmp.listener(listener):
-       await qmp.execute('blockdev-backup', arguments={'job-id': 'job4', ...})
-       async for event in listener:
-           print(event)
-           if event['event'] == 'BLOCK_JOB_COMPLETED':
-               break
-
-
-Experimental Interfaces & Design Issues
----------------------------------------
-
-These interfaces are not ones I am sure I will keep or otherwise modify
-heavily.
-
-qmp.listen()’s type signature
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-`listen()` does not return anything, because it was assumed the caller
-already had a handle to the listener. However, for
-``qmp.listen(EventListener())`` forms, the caller will not have saved a
-handle to the listener.
-
-Because this function can accept *many* listeners, I found it hard to
-accurately type in a way where it could be used in both “one” or “many”
-forms conveniently and in a statically type-safe manner.
-
-Ultimately, I removed the return altogether, but perhaps with more time
-I can work out a way to re-add it.
-
-
-API Reference
--------------
-
-"""
-
-import asyncio
-from contextlib import contextmanager
-import logging
-from typing import (
-    AsyncIterator,
-    Callable,
-    Iterable,
-    Iterator,
-    List,
-    Optional,
-    Set,
-    Tuple,
-    Union,
-)
-
-from .error import QMPError
-from .message import Message
-
-
-EventNames = Union[str, Iterable[str], None]
-EventFilter = Callable[[Message], bool]
-
-
-class ListenerError(QMPError):
-    """
-    Generic error class for `EventListener`-related problems.
-    """
-
-
-class EventListener:
-    """
-    Selectively listens for events with runtime configurable filtering.
-
-    This class is designed to be directly usable for the most common cases,
-    but it can be extended to provide more rigorous control.
-
-    :param names:
-        One or more names of events to listen for.
-        When not provided, listen for ALL events.
-    :param event_filter:
-        An optional event filtering function.
-        When names are also provided, this acts as a secondary filter.
-
-    When ``names`` and ``event_filter`` are both provided, the names
-    will be filtered first, and then the filter function will be called
-    second. The event filter function can assume that the format of the
-    event is a known format.
-    """
-    def __init__(
-        self,
-        names: EventNames = None,
-        event_filter: Optional[EventFilter] = None,
-    ):
-        # Queue of 'heard' events yet to be witnessed by a caller.
-        self._queue: 'asyncio.Queue[Message]' = asyncio.Queue()
-
-        # Intended as a historical record, NOT a processing queue or backlog.
-        self._history: List[Message] = []
-
-        #: Primary event filter, based on one or more event names.
-        self.names: Set[str] = set()
-        if isinstance(names, str):
-            self.names.add(names)
-        elif names is not None:
-            self.names.update(names)
-
-        #: Optional, secondary event filter.
-        self.event_filter: Optional[EventFilter] = event_filter
-
-    def __repr__(self) -> str:
-        args: List[str] = []
-        if self.names:
-            args.append(f"names={self.names!r}")
-        if self.event_filter:
-            args.append(f"event_filter={self.event_filter!r}")
-
-        if self._queue.qsize():
-            state = f"<pending={self._queue.qsize()}>"
-        else:
-            state = ''
-
-        argstr = ", ".join(args)
-        return f"{type(self).__name__}{state}({argstr})"
-
-    @property
-    def history(self) -> Tuple[Message, ...]:
-        """
-        A read-only history of all events seen so far.
-
-        This represents *every* event, including those not yet witnessed
-        via `get()` or ``async for``. It persists between `clear()`
-        calls and is immutable.
-        """
-        return tuple(self._history)
-
-    def accept(self, event: Message) -> bool:
-        """
-        Determine if this listener accepts this event.
-
-        This method determines which events will appear in the stream.
-        The default implementation simply checks the event against the
-        list of names and the event_filter to decide if this
-        `EventListener` accepts a given event. It can be
-        overridden/extended to provide custom listener behavior.
-
-        User code is not expected to need to invoke this method.
-
-        :param event: The event under consideration.
-        :return: `True`, if this listener accepts this event.
-        """
-        name_ok = (not self.names) or (event['event'] in self.names)
-        return name_ok and (
-            (not self.event_filter) or self.event_filter(event)
-        )
-
-    async def put(self, event: Message) -> None:
-        """
-        Conditionally put a new event into the FIFO queue.
-
-        This method is not designed to be invoked from user code, and it
-        should not need to be overridden. It is a public interface so
-        that `QMPClient` has an interface by which it can inform
-        registered listeners of new events.
-
-        The event will be put into the queue if
-        :py:meth:`~EventListener.accept()` returns `True`.
-
-        :param event: The new event to put into the FIFO queue.
-        """
-        if not self.accept(event):
-            return
-
-        self._history.append(event)
-        await self._queue.put(event)
-
-    async def get(self) -> Message:
-        """
-        Wait for the very next event in this stream.
-
-        If one is already available, return that one.
-        """
-        return await self._queue.get()
-
-    def empty(self) -> bool:
-        """
-        Return `True` if there are no pending events.
-        """
-        return self._queue.empty()
-
-    def clear(self) -> List[Message]:
-        """
-        Clear this listener of all pending events.
-
-        Called when an `EventListener` is being unregistered, this clears the
-        pending FIFO queue synchronously. It can be also be used to
-        manually clear any pending events, if desired.
-
-        :return: The cleared events, if any.
-
-        .. warning::
-            Take care when discarding events. Cleared events will be
-            silently tossed on the floor. All events that were ever
-            accepted by this listener are visible in `history()`.
-        """
-        events = []
-        while True:
-            try:
-                events.append(self._queue.get_nowait())
-            except asyncio.QueueEmpty:
-                break
-
-        return events
-
-    def __aiter__(self) -> AsyncIterator[Message]:
-        return self
-
-    async def __anext__(self) -> Message:
-        """
-        Enables the `EventListener` to function as an async iterator.
-
-        It may be used like this:
-
-        .. code:: python
-
-            async for event in listener:
-                print(event)
-
-        These iterators will never terminate of their own accord; you
-        must provide break conditions or otherwise prepare to run them
-        in an `asyncio.Task` that can be cancelled.
-        """
-        return await self.get()
-
-
-class Events:
-    """
-    Events is a mix-in class that adds event functionality to the QMP class.
-
-    It's designed specifically as a mix-in for `QMPClient`, and it
-    relies upon the class it is being mixed into having a 'logger'
-    property.
-    """
-    def __init__(self) -> None:
-        self._listeners: List[EventListener] = []
-
-        #: Default, all-events `EventListener`. See `qmp.events` for more info.
-        self.events: EventListener = EventListener()
-        self.register_listener(self.events)
-
-        # Parent class needs to have a logger
-        self.logger: logging.Logger
-
-    async def _event_dispatch(self, msg: Message) -> None:
-        """
-        Given a new event, propagate it to all of the active listeners.
-
-        :param msg: The event to propagate.
-        """
-        for listener in self._listeners:
-            await listener.put(msg)
-
-    def register_listener(self, listener: EventListener) -> None:
-        """
-        Register and activate an `EventListener`.
-
-        :param listener: The listener to activate.
-        :raise ListenerError: If the given listener is already registered.
-        """
-        if listener in self._listeners:
-            raise ListenerError("Attempted to re-register existing listener")
-        self.logger.debug("Registering %s.", str(listener))
-        self._listeners.append(listener)
-
-    def remove_listener(self, listener: EventListener) -> None:
-        """
-        Unregister and deactivate an `EventListener`.
-
-        The removed listener will have its pending events cleared via
-        `clear()`. The listener can be re-registered later when
-        desired.
-
-        :param listener: The listener to deactivate.
-        :raise ListenerError: If the given listener is not registered.
-        """
-        if listener == self.events:
-            raise ListenerError("Cannot remove the default listener.")
-        self.logger.debug("Removing %s.", str(listener))
-        listener.clear()
-        self._listeners.remove(listener)
-
-    @contextmanager
-    def listen(self, *listeners: EventListener) -> Iterator[None]:
-        r"""
-        Context manager: Temporarily listen with an `EventListener`.
-
-        Accepts one or more `EventListener` objects and registers them,
-        activating them for the duration of the context block.
-
-        `EventListener` objects will have any pending events in their
-        FIFO queue cleared upon exiting the context block, when they are
-        deactivated.
-
-        :param \*listeners: One or more EventListeners to activate.
-        :raise ListenerError: If the given listener(s) are already active.
-        """
-        _added = []
-
-        try:
-            for listener in listeners:
-                self.register_listener(listener)
-                _added.append(listener)
-
-            yield
-
-        finally:
-            for listener in _added:
-                self.remove_listener(listener)
-
-    @contextmanager
-    def listener(
-        self,
-        names: EventNames = (),
-        event_filter: Optional[EventFilter] = None
-    ) -> Iterator[EventListener]:
-        """
-        Context manager: Temporarily listen with a new `EventListener`.
-
-        Creates an `EventListener` object and registers it, activating
-        it for the duration of the context block.
-
-        :param names:
-            One or more names of events to listen for.
-            When not provided, listen for ALL events.
-        :param event_filter:
-            An optional event filtering function.
-            When names are also provided, this acts as a secondary filter.
-
-        :return: The newly created and active `EventListener`.
-        """
-        listener = EventListener(names, event_filter)
-        with self.listen(listener):
-            yield listener
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
deleted file mode 100644
index 060ed0eb9d4..00000000000
--- a/python/qemu/qmp/legacy.py
+++ /dev/null
@@ -1,339 +0,0 @@
-"""
-(Legacy) Sync QMP Wrapper
-
-This module provides the `QEMUMonitorProtocol` class, which is a
-synchronous wrapper around `QMPClient`.
-
-Its design closely resembles that of the original QEMUMonitorProtocol
-class, originally written by Luiz Capitulino. It is provided here for
-compatibility with scripts inside the QEMU source tree that expect the
-old interface.
-"""
-
-#
-# Copyright (C) 2009-2022 Red Hat Inc.
-#
-# Authors:
-#  Luiz Capitulino <lcapitulino@redhat.com>
-#  John Snow <jsnow@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
-
-import asyncio
-import socket
-from types import TracebackType
-from typing import (
-    Any,
-    Awaitable,
-    Dict,
-    List,
-    Optional,
-    Type,
-    TypeVar,
-    Union,
-)
-
-from .error import QMPError
-from .protocol import Runstate, SocketAddrT
-from .qmp_client import QMPClient
-from .util import get_or_create_event_loop
-
-
-#: QMPMessage is an entire QMP message of any kind.
-QMPMessage = Dict[str, Any]
-
-#: QMPReturnValue is the 'return' value of a command.
-QMPReturnValue = object
-
-#: QMPObject is any object in a QMP message.
-QMPObject = Dict[str, object]
-
-# QMPMessage can be outgoing commands or incoming events/returns.
-# QMPReturnValue is usually a dict/json object, but due to QAPI's
-# 'command-returns-exceptions', it can actually be anything.
-#
-# {'return': {}} is a QMPMessage,
-# {} is the QMPReturnValue.
-
-
-class QMPBadPortError(QMPError):
-    """
-    Unable to parse socket address: Port was non-numerical.
-    """
-
-
-class QEMUMonitorProtocol:
-    """
-    Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP)
-    and then allow to handle commands and events.
-
-    :param address:  QEMU address, can be a unix socket path (string), a tuple
-                     in the form ( address, port ) for a TCP connection, or an
-                     existing `socket.socket` object.
-    :param server:   Act as the socket server. (See 'accept')
-                     Not applicable when passing a socket directly.
-    :param nickname: Optional nickname used for logging.
-    """
-
-    def __init__(self,
-                 address: Union[SocketAddrT, socket.socket],
-                 server: bool = False,
-                 nickname: Optional[str] = None):
-
-        if server and isinstance(address, socket.socket):
-            raise ValueError(
-                "server argument should be False when passing a socket")
-
-        self._qmp = QMPClient(nickname)
-        self._address = address
-        self._timeout: Optional[float] = None
-
-        # This is a sync shim intended for use in fully synchronous
-        # programs. Create and set an event loop if necessary.
-        self._aloop = get_or_create_event_loop()
-
-        if server:
-            assert not isinstance(self._address, socket.socket)
-            self._sync(self._qmp.start_server(self._address))
-
-    _T = TypeVar('_T')
-
-    def _sync(
-            self, future: Awaitable[_T], timeout: Optional[float] = None
-    ) -> _T:
-        return self._aloop.run_until_complete(
-            asyncio.wait_for(future, timeout=timeout)
-        )
-
-    def _get_greeting(self) -> Optional[QMPMessage]:
-        if self._qmp.greeting is not None:
-            # pylint: disable=protected-access
-            return self._qmp.greeting._asdict()
-        return None
-
-    def __enter__(self: _T) -> _T:
-        # Implement context manager enter function.
-        return self
-
-    def __exit__(self,
-                 exc_type: Optional[Type[BaseException]],
-                 exc_val: Optional[BaseException],
-                 exc_tb: Optional[TracebackType]) -> None:
-        # Implement context manager exit function.
-        self.close()
-
-    @classmethod
-    def parse_address(cls, address: str) -> SocketAddrT:
-        """
-        Parse a string into a QMP address.
-
-        Figure out if the argument is in the port:host form.
-        If it's not, it's probably a file path.
-        """
-        components = address.split(':')
-        if len(components) == 2:
-            try:
-                port = int(components[1])
-            except ValueError:
-                msg = f"Bad port: '{components[1]}' in '{address}'."
-                raise QMPBadPortError(msg) from None
-            return (components[0], port)
-
-        # Treat as filepath.
-        return address
-
-    def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
-        """
-        Connect to the QMP Monitor and perform capabilities negotiation.
-
-        :return: QMP greeting dict, or None if negotiate is false
-        :raise ConnectError: on connection errors
-        """
-        self._qmp.await_greeting = negotiate
-        self._qmp.negotiate = negotiate
-
-        self._sync(
-            self._qmp.connect(self._address)
-        )
-        return self._get_greeting()
-
-    def accept(self, timeout: Optional[float] = 15.0) -> QMPMessage:
-        """
-        Await connection from QMP Monitor and perform capabilities negotiation.
-
-        :param timeout:
-            timeout in seconds (nonnegative float number, or None).
-            If None, there is no timeout, and this may block forever.
-
-        :return: QMP greeting dict
-        :raise ConnectError: on connection errors
-        """
-        self._qmp.await_greeting = True
-        self._qmp.negotiate = True
-
-        self._sync(self._qmp.accept(), timeout)
-
-        ret = self._get_greeting()
-        assert ret is not None
-        return ret
-
-    def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
-        """
-        Send a QMP command to the QMP Monitor.
-
-        :param qmp_cmd: QMP command to be sent as a Python dict
-        :return: QMP response as a Python dict
-        """
-        return dict(
-            self._sync(
-                # pylint: disable=protected-access
-
-                # _raw() isn't a public API, because turning off
-                # automatic ID assignment is discouraged. For
-                # compatibility with iotests *only*, do it anyway.
-                self._qmp._raw(qmp_cmd, assign_id=False),
-                self._timeout
-            )
-        )
-
-    def cmd_raw(self, name: str,
-                args: Optional[Dict[str, object]] = None) -> QMPMessage:
-        """
-        Build a QMP command and send it to the QMP Monitor.
-
-        :param name: command name (string)
-        :param args: command arguments (dict)
-        """
-        qmp_cmd: QMPMessage = {'execute': name}
-        if args:
-            qmp_cmd['arguments'] = args
-        return self.cmd_obj(qmp_cmd)
-
-    def cmd(self, cmd: str, **kwds: object) -> QMPReturnValue:
-        """
-        Build and send a QMP command to the monitor, report errors if any
-        """
-        return self._sync(
-            self._qmp.execute(cmd, kwds),
-            self._timeout
-        )
-
-    def pull_event(self,
-                   wait: Union[bool, float] = False) -> Optional[QMPMessage]:
-        """
-        Pulls a single event.
-
-        :param wait:
-            If False or 0, do not wait. Return None if no events ready.
-            If True, wait forever until the next event.
-            Otherwise, wait for the specified number of seconds.
-
-        :raise asyncio.TimeoutError:
-            When a timeout is requested and the timeout period elapses.
-
-        :return: The first available QMP event, or None.
-        """
-        # Kick the event loop to allow events to accumulate
-        self._sync(asyncio.sleep(0))
-
-        if not wait:
-            # wait is False/0: "do not wait, do not except."
-            if self._qmp.events.empty():
-                return None
-
-        # If wait is 'True', wait forever. If wait is False/0, the events
-        # queue must not be empty; but it still needs some real amount
-        # of time to complete.
-        timeout = None
-        if wait and isinstance(wait, float):
-            timeout = wait
-
-        return dict(
-            self._sync(
-                self._qmp.events.get(),
-                timeout
-            )
-        )
-
-    def get_events(self, wait: Union[bool, float] = False) -> List[QMPMessage]:
-        """
-        Get a list of QMP events and clear all pending events.
-
-        :param wait:
-            If False or 0, do not wait. Return None if no events ready.
-            If True, wait until we have at least one event.
-            Otherwise, wait for up to the specified number of seconds for at
-            least one event.
-
-        :raise asyncio.TimeoutError:
-            When a timeout is requested and the timeout period elapses.
-
-        :return: A list of QMP events.
-        """
-        events = [dict(x) for x in self._qmp.events.clear()]
-        if events:
-            return events
-
-        event = self.pull_event(wait)
-        return [event] if event is not None else []
-
-    def clear_events(self) -> None:
-        """Clear current list of pending events."""
-        self._qmp.events.clear()
-
-    def close(self) -> None:
-        """Close the connection."""
-        self._sync(
-            self._qmp.disconnect()
-        )
-
-    def settimeout(self, timeout: Optional[float]) -> None:
-        """
-        Set the timeout for QMP RPC execution.
-
-        This timeout affects the `cmd`, `cmd_obj`, and `cmd_raw` methods.
-        The `accept`, `pull_event` and `get_events` methods have their
-        own configurable timeouts.
-
-        :param timeout:
-            timeout in seconds, or None.
-            None will wait indefinitely.
-        """
-        self._timeout = timeout
-
-    def send_fd_scm(self, fd: int) -> None:
-        """
-        Send a file descriptor to the remote via SCM_RIGHTS.
-        """
-        self._qmp.send_fd_scm(fd)
-
-    def __del__(self) -> None:
-        if self._qmp.runstate != Runstate.IDLE:
-            self._qmp.logger.warning(
-                "QEMUMonitorProtocol object garbage collected without a prior "
-                "call to close()"
-            )
-
-        if not self._aloop.is_running():
-            if self._qmp.runstate != Runstate.IDLE:
-                # If the user neglected to close the QMP session and we
-                # are not currently running in an asyncio context, we
-                # have the opportunity to close the QMP session. If we
-                # do not do this, the error messages presented over
-                # dangling async resources may not make any sense to the
-                # user.
-                self.close()
-
-        if self._qmp.runstate != Runstate.IDLE:
-            # If QMP is still not quiesced, it means that the garbage
-            # collector ran from a context within the event loop and we
-            # are simply too late to take any corrective action. Raise
-            # our own error to give meaningful feedback to the user in
-            # order to prevent pages of asyncio stacktrace jargon.
-            raise QMPError(
-                "QEMUMonitorProtocol.close() was not called before object was "
-                "garbage collected, and could not be closed due to GC running "
-                "in the event loop"
-            )
diff --git a/python/qemu/qmp/message.py b/python/qemu/qmp/message.py
deleted file mode 100644
index dabb8ec360e..00000000000
--- a/python/qemu/qmp/message.py
+++ /dev/null
@@ -1,217 +0,0 @@
-"""
-QMP Message Format
-
-This module provides the `Message` class, which represents a single QMP
-message sent to or from the server.
-"""
-
-import json
-from json import JSONDecodeError
-from typing import (
-    Dict,
-    Iterator,
-    Mapping,
-    MutableMapping,
-    Optional,
-    Union,
-)
-
-from .error import ProtocolError
-
-
-class Message(MutableMapping[str, object]):
-    """
-    Represents a single QMP protocol message.
-
-    QMP uses JSON objects as its basic communicative unit; so this
-    Python object is a :py:obj:`~collections.abc.MutableMapping`. It may
-    be instantiated from either another mapping (like a `dict`), or from
-    raw `bytes` that still need to be deserialized.
-
-    Once instantiated, it may be treated like any other
-    :py:obj:`~collections.abc.MutableMapping`::
-
-        >>> msg = Message(b'{"hello": "world"}')
-        >>> assert msg['hello'] == 'world'
-        >>> msg['id'] = 'foobar'
-        >>> print(msg)
-        {
-          "hello": "world",
-          "id": "foobar"
-        }
-
-    It can be converted to `bytes`::
-
-        >>> msg = Message({"hello": "world"})
-        >>> print(bytes(msg))
-        b'{"hello":"world","id":"foobar"}'
-
-    Or back into a garden-variety `dict`::
-
-       >>> dict(msg)
-       {'hello': 'world'}
-
-    Or pretty-printed::
-
-       >>> print(str(msg))
-       {
-         "hello": "world"
-       }
-
-    :param value: Initial value, if any.
-    :param eager:
-        When `True`, attempt to serialize or deserialize the initial value
-        immediately, so that conversion exceptions are raised during
-        the call to ``__init__()``.
-
-    """
-    # pylint: disable=too-many-ancestors
-
-    def __init__(self,
-                 value: Union[bytes, Mapping[str, object]] = b'{}', *,
-                 eager: bool = True):
-        self._data: Optional[bytes] = None
-        self._obj: Optional[Dict[str, object]] = None
-
-        if isinstance(value, bytes):
-            self._data = value
-            if eager:
-                self._obj = self._deserialize(self._data)
-        else:
-            self._obj = dict(value)
-            if eager:
-                self._data = self._serialize(self._obj)
-
-    # Methods necessary to implement the MutableMapping interface, see:
-    # https://docs.python.org/3/library/collections.abc.html#collections.abc.MutableMapping
-
-    # We get pop, popitem, clear, update, setdefault, __contains__,
-    # keys, items, values, get, __eq__ and __ne__ for free.
-
-    def __getitem__(self, key: str) -> object:
-        return self._object[key]
-
-    def __setitem__(self, key: str, value: object) -> None:
-        self._object[key] = value
-        self._data = None
-
-    def __delitem__(self, key: str) -> None:
-        del self._object[key]
-        self._data = None
-
-    def __iter__(self) -> Iterator[str]:
-        return iter(self._object)
-
-    def __len__(self) -> int:
-        return len(self._object)
-
-    # Dunder methods not related to MutableMapping:
-
-    def __repr__(self) -> str:
-        if self._obj is not None:
-            return f"Message({self._object!r})"
-        return f"Message({bytes(self)!r})"
-
-    def __str__(self) -> str:
-        """Pretty-printed representation of this QMP message."""
-        return json.dumps(self._object, indent=2)
-
-    def __bytes__(self) -> bytes:
-        """bytes representing this QMP message."""
-        if self._data is None:
-            self._data = self._serialize(self._obj or {})
-        return self._data
-
-    # Conversion Methods
-
-    @property
-    def _object(self) -> Dict[str, object]:
-        """
-        A `dict` representing this QMP message.
-
-        Generated on-demand, if required. This property is private
-        because it returns an object that could be used to invalidate
-        the internal state of the `Message` object.
-        """
-        if self._obj is None:
-            self._obj = self._deserialize(self._data or b'{}')
-        return self._obj
-
-    @classmethod
-    def _serialize(cls, value: object) -> bytes:
-        """
-        Serialize a JSON object as `bytes`.
-
-        :raise ValueError: When the object cannot be serialized.
-        :raise TypeError: When the object cannot be serialized.
-
-        :return: `bytes` ready to be sent over the wire.
-        """
-        return json.dumps(value, separators=(',', ':')).encode('utf-8')
-
-    @classmethod
-    def _deserialize(cls, data: bytes) -> Dict[str, object]:
-        """
-        Deserialize JSON `bytes` into a native Python `dict`.
-
-        :raise DeserializationError:
-            If JSON deserialization fails for any reason.
-        :raise UnexpectedTypeError:
-            If the data does not represent a JSON object.
-
-        :return: A `dict` representing this QMP message.
-        """
-        try:
-            obj = json.loads(data)
-        except JSONDecodeError as err:
-            emsg = "Failed to deserialize QMP message."
-            raise DeserializationError(emsg, data) from err
-        if not isinstance(obj, dict):
-            raise UnexpectedTypeError(
-                "QMP message is not a JSON object.",
-                obj
-            )
-        return obj
-
-
-class DeserializationError(ProtocolError):
-    """
-    A QMP message was not understood as JSON.
-
-    When this Exception is raised, ``__cause__`` will be set to the
-    `json.JSONDecodeError` Exception, which can be interrogated for
-    further details.
-
-    :param error_message: Human-readable string describing the error.
-    :param raw: The raw `bytes` that prompted the failure.
-    """
-    def __init__(self, error_message: str, raw: bytes):
-        super().__init__(error_message, raw)
-        #: The raw `bytes` that were not understood as JSON.
-        self.raw: bytes = raw
-
-    def __str__(self) -> str:
-        return "\n".join((
-            super().__str__(),
-            f"  raw bytes were: {str(self.raw)}",
-        ))
-
-
-class UnexpectedTypeError(ProtocolError):
-    """
-    A QMP message was JSON, but not a JSON object.
-
-    :param error_message: Human-readable string describing the error.
-    :param value: The deserialized JSON value that wasn't an object.
-    """
-    def __init__(self, error_message: str, value: object):
-        super().__init__(error_message, value)
-        #: The JSON value that was expected to be an object.
-        self.value: object = value
-
-    def __str__(self) -> str:
-        strval = json.dumps(self.value, indent=2)
-        return "\n".join((
-            super().__str__(),
-            f"  json value was: {strval}",
-        ))
diff --git a/python/qemu/qmp/models.py b/python/qemu/qmp/models.py
deleted file mode 100644
index 7e0d0baf038..00000000000
--- a/python/qemu/qmp/models.py
+++ /dev/null
@@ -1,146 +0,0 @@
-"""
-QMP Data Models
-
-This module provides simplistic data classes that represent the few
-structures that the QMP spec mandates; they are used to verify incoming
-data to make sure it conforms to spec.
-"""
-# pylint: disable=too-few-public-methods
-
-from collections import abc
-import copy
-from typing import (
-    Any,
-    Dict,
-    Mapping,
-    Optional,
-    Sequence,
-)
-
-
-class Model:
-    """
-    Abstract data model, representing some QMP object of some kind.
-
-    :param raw: The raw object to be validated.
-    :raise KeyError: If any required fields are absent.
-    :raise TypeError: If any required fields have the wrong type.
-    """
-    def __init__(self, raw: Mapping[str, Any]):
-        self._raw = raw
-
-    def _check_key(self, key: str) -> None:
-        if key not in self._raw:
-            raise KeyError(f"'{self._name}' object requires '{key}' member")
-
-    def _check_value(self, key: str, type_: type, typestr: str) -> None:
-        assert key in self._raw
-        if not isinstance(self._raw[key], type_):
-            raise TypeError(
-                f"'{self._name}' member '{key}' must be a {typestr}"
-            )
-
-    def _check_member(self, key: str, type_: type, typestr: str) -> None:
-        self._check_key(key)
-        self._check_value(key, type_, typestr)
-
-    @property
-    def _name(self) -> str:
-        return type(self).__name__
-
-    def __repr__(self) -> str:
-        return f"{self._name}({self._raw!r})"
-
-
-class Greeting(Model):
-    """
-    Defined in `interop/qmp-spec`, "Server Greeting" section.
-
-    :param raw: The raw Greeting object.
-    :raise KeyError: If any required fields are absent.
-    :raise TypeError: If any required fields have the wrong type.
-    """
-    def __init__(self, raw: Mapping[str, Any]):
-        super().__init__(raw)
-        #: 'QMP' member
-        self.QMP: QMPGreeting  # pylint: disable=invalid-name
-
-        self._check_member('QMP', abc.Mapping, "JSON object")
-        self.QMP = QMPGreeting(self._raw['QMP'])
-
-    def _asdict(self) -> Dict[str, object]:
-        """
-        For compatibility with the iotests sync QMP wrapper.
-
-        The legacy QMP interface needs Greetings as a garden-variety Dict.
-
-        This interface is private in the hopes that it will be able to
-        be dropped again in the near-future. Caller beware!
-        """
-        return dict(copy.deepcopy(self._raw))
-
-
-class QMPGreeting(Model):
-    """
-    Defined in `interop/qmp-spec`, "Server Greeting" section.
-
-    :param raw: The raw QMPGreeting object.
-    :raise KeyError: If any required fields are absent.
-    :raise TypeError: If any required fields have the wrong type.
-    """
-    def __init__(self, raw: Mapping[str, Any]):
-        super().__init__(raw)
-        #: 'version' member
-        self.version: Mapping[str, object]
-        #: 'capabilities' member
-        self.capabilities: Sequence[object]
-
-        self._check_member('version', abc.Mapping, "JSON object")
-        self.version = self._raw['version']
-
-        self._check_member('capabilities', abc.Sequence, "JSON array")
-        self.capabilities = self._raw['capabilities']
-
-
-class ErrorResponse(Model):
-    """
-    Defined in `interop/qmp-spec`, "Error" section.
-
-    :param raw: The raw ErrorResponse object.
-    :raise KeyError: If any required fields are absent.
-    :raise TypeError: If any required fields have the wrong type.
-    """
-    def __init__(self, raw: Mapping[str, Any]):
-        super().__init__(raw)
-        #: 'error' member
-        self.error: ErrorInfo
-        #: 'id' member
-        self.id: Optional[object] = None  # pylint: disable=invalid-name
-
-        self._check_member('error', abc.Mapping, "JSON object")
-        self.error = ErrorInfo(self._raw['error'])
-
-        if 'id' in raw:
-            self.id = raw['id']
-
-
-class ErrorInfo(Model):
-    """
-    Defined in `interop/qmp-spec`, "Error" section.
-
-    :param raw: The raw ErrorInfo object.
-    :raise KeyError: If any required fields are absent.
-    :raise TypeError: If any required fields have the wrong type.
-    """
-    def __init__(self, raw: Mapping[str, Any]):
-        super().__init__(raw)
-        #: 'class' member, with an underscore to avoid conflicts in Python.
-        self.class_: str
-        #: 'desc' member
-        self.desc: str
-
-        self._check_member('class', str, "string")
-        self.class_ = self._raw['class']
-
-        self._check_member('desc', str, "string")
-        self.desc = self._raw['desc']
diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
deleted file mode 100644
index 219d092a792..00000000000
--- a/python/qemu/qmp/protocol.py
+++ /dev/null
@@ -1,1101 +0,0 @@
-"""
-Generic Asynchronous Message-based Protocol Support
-
-This module provides a generic framework for sending and receiving
-messages over an asyncio stream. `AsyncProtocol` is an abstract class
-that implements the core mechanisms of a simple send/receive protocol,
-and is designed to be extended.
-
-In this package, it is used as the implementation for the `QMPClient`
-class.
-"""
-
-# It's all the docstrings ... ! It's long for a good reason ^_^;
-# pylint: disable=too-many-lines
-
-import asyncio
-from asyncio import StreamReader, StreamWriter
-from contextlib import asynccontextmanager
-from enum import Enum
-from functools import wraps
-from inspect import iscoroutinefunction
-import logging
-import socket
-from ssl import SSLContext
-from typing import (
-    Any,
-    AsyncGenerator,
-    Awaitable,
-    Callable,
-    Generic,
-    List,
-    Optional,
-    Tuple,
-    TypeVar,
-    Union,
-    cast,
-)
-
-from .error import QMPError
-from .util import (
-    bottom_half,
-    exception_summary,
-    flush,
-    pretty_traceback,
-    upper_half,
-)
-
-
-T = TypeVar('T')
-_U = TypeVar('_U')
-_TaskFN = Callable[[], Awaitable[None]]  # aka ``async def func() -> None``
-
-InternetAddrT = Tuple[str, int]
-UnixAddrT = str
-SocketAddrT = Union[UnixAddrT, InternetAddrT]
-
-# Maximum allowable size of read buffer, default
-_DEFAULT_READBUFLEN = 64 * 1024
-
-
-class Runstate(Enum):
-    """Protocol session runstate."""
-
-    #: Fully quiesced and disconnected.
-    IDLE = 0
-    #: In the process of connecting or establishing a session.
-    CONNECTING = 1
-    #: Fully connected and active session.
-    RUNNING = 2
-    #: In the process of disconnecting.
-    #: Runstate may be returned to `IDLE` by calling `disconnect()`.
-    DISCONNECTING = 3
-
-
-class ConnectError(QMPError):
-    """
-    Raised when the initial connection process has failed.
-
-    This Exception always wraps a "root cause" exception that can be
-    interrogated for additional information.
-
-    For example, when connecting to a non-existent socket::
-
-        await qmp.connect('not_found.sock')
-        # ConnectError: Failed to establish connection:
-        #               [Errno 2] No such file or directory
-
-    :param error_message: Human-readable string describing the error.
-    :param exc: The root-cause exception.
-    """
-    def __init__(self, error_message: str, exc: Exception):
-        super().__init__(error_message, exc)
-        #: Human-readable error string
-        self.error_message: str = error_message
-        #: Wrapped root cause exception
-        self.exc: Exception = exc
-
-    def __str__(self) -> str:
-        cause = str(self.exc)
-        if not cause:
-            # If there's no error string, use the exception name.
-            cause = exception_summary(self.exc)
-        return f"{self.error_message}: {cause}"
-
-
-class StateError(QMPError):
-    """
-    An API command (connect, execute, etc) was issued at an inappropriate time.
-
-    This error is raised when a command like
-    :py:meth:`~AsyncProtocol.connect()` is called when the client is
-    already connected.
-
-    :param error_message: Human-readable string describing the state violation.
-    :param state: The actual `Runstate` seen at the time of the violation.
-    :param required: The `Runstate` required to process this command.
-    """
-    def __init__(self, error_message: str,
-                 state: Runstate, required: Runstate):
-        super().__init__(error_message, state, required)
-        self.error_message = error_message
-        self.state = state
-        self.required = required
-
-    def __str__(self) -> str:
-        return self.error_message
-
-
-F = TypeVar('F', bound=Callable[..., Any])  # pylint: disable=invalid-name
-
-
-# Don't Panic.
-def require(required_state: Runstate) -> Callable[[F], F]:
-    """
-    Decorator: protect a method so it can only be run in a certain `Runstate`.
-
-    :param required_state: The `Runstate` required to invoke this method.
-    :raise StateError: When the required `Runstate` is not met.
-    """
-    def _check(proto: 'AsyncProtocol[Any]') -> None:
-        name = type(proto).__name__
-        if proto.runstate == required_state:
-            return
-
-        if proto.runstate == Runstate.CONNECTING:
-            emsg = f"{name} is currently connecting."
-        elif proto.runstate == Runstate.DISCONNECTING:
-            emsg = (f"{name} is disconnecting."
-                    " Call disconnect() to return to IDLE state.")
-        elif proto.runstate == Runstate.RUNNING:
-            emsg = f"{name} is already connected and running."
-        elif proto.runstate == Runstate.IDLE:
-            emsg = f"{name} is disconnected and idle."
-        else:
-            assert False
-
-        raise StateError(emsg, proto.runstate, required_state)
-
-    def _decorator(func: F) -> F:
-        # _decorator is the decorator that is built by calling the
-        # require() decorator factory; e.g.:
-        #
-        # @require(Runstate.IDLE) def foo(): ...
-        # will replace 'foo' with the result of '_decorator(foo)'.
-
-        @wraps(func)
-        def _wrapper(proto: 'AsyncProtocol[Any]',
-                     *args: Any, **kwargs: Any) -> Any:
-            _check(proto)
-            return func(proto, *args, **kwargs)
-
-        @wraps(func)
-        async def _async_wrapper(proto: 'AsyncProtocol[Any]',
-                                 *args: Any, **kwargs: Any) -> Any:
-            _check(proto)
-            return await func(proto, *args, **kwargs)
-
-        # Return the decorated method; F => Decorated[F]
-        # Use an async version when applicable, which
-        # preserves async signature generation in sphinx.
-        if iscoroutinefunction(func):
-            return cast(F, _async_wrapper)
-        return cast(F, _wrapper)
-
-    # Return the decorator instance from the decorator factory. Phew!
-    return _decorator
-
-
-class AsyncProtocol(Generic[T]):
-    """
-    AsyncProtocol implements a generic async message-based protocol.
-
-    This protocol assumes the basic unit of information transfer between
-    client and server is a "message", the details of which are left up
-    to the implementation. It assumes the sending and receiving of these
-    messages is full-duplex and not necessarily correlated; i.e. it
-    supports asynchronous inbound messages.
-
-    It is designed to be extended by a specific protocol which provides
-    the implementations for how to read and send messages. These must be
-    defined in `_do_recv()` and `_do_send()`, respectively.
-
-    Other callbacks have a default implementation, but are intended to be
-    either extended or overridden:
-
-     - `_establish_session`:
-         The base implementation starts the reader/writer tasks.
-         A protocol implementation can override this call, inserting
-         actions to be taken prior to starting the reader/writer tasks
-         before the super() call; actions needing to occur afterwards
-         can be written after the super() call.
-     - `_on_message`:
-         Actions to be performed when a message is received.
-     - `_cb_outbound`:
-         Logging/Filtering hook for all outbound messages.
-     - `_cb_inbound`:
-         Logging/Filtering hook for all inbound messages.
-         This hook runs *before* `_on_message()`.
-
-    :param name:
-        Name used for logging messages, if any. By default, messages
-        will log to 'qemu.qmp.protocol', but each individual connection
-        can be given its own logger by giving it a name; messages will
-        then log to 'qemu.qmp.protocol.${name}'.
-    :param readbuflen:
-        The maximum read buffer length of the underlying StreamReader
-        instance.
-    """
-    # pylint: disable=too-many-instance-attributes
-
-    #: Logger object for debugging messages from this connection.
-    logger = logging.getLogger(__name__)
-
-    # -------------------------
-    # Section: Public interface
-    # -------------------------
-
-    def __init__(
-        self, name: Optional[str] = None,
-        readbuflen: int = _DEFAULT_READBUFLEN
-    ) -> None:
-        self._name: Optional[str]
-        self.name = name
-        self.readbuflen = readbuflen
-
-        # stream I/O
-        self._reader: Optional[StreamReader] = None
-        self._writer: Optional[StreamWriter] = None
-
-        # Outbound Message queue
-        self._outgoing: asyncio.Queue[T]
-
-        # Special, long-running tasks:
-        self._reader_task: Optional[asyncio.Future[None]] = None
-        self._writer_task: Optional[asyncio.Future[None]] = None
-
-        # Aggregate of the above two tasks, used for Exception management.
-        self._bh_tasks: Optional[asyncio.Future[Tuple[None, None]]] = None
-
-        #: Disconnect task. The disconnect implementation runs in a task
-        #: so that asynchronous disconnects (initiated by the
-        #: reader/writer) are allowed to wait for the reader/writers to
-        #: exit.
-        self._dc_task: Optional[asyncio.Future[None]] = None
-
-        self._runstate = Runstate.IDLE
-        self._runstate_changed: Optional[asyncio.Event] = None
-
-        # Server state for start_server() and _incoming()
-        self._server: Optional[asyncio.AbstractServer] = None
-        self._accepted: Optional[asyncio.Event] = None
-
-    def __repr__(self) -> str:
-        cls_name = type(self).__name__
-        tokens = []
-        if self.name is not None:
-            tokens.append(f"name={self.name!r}")
-        tokens.append(f"runstate={self.runstate.name}")
-        return f"<{cls_name} {' '.join(tokens)}>"
-
-    @property
-    def name(self) -> Optional[str]:
-        """
-        The nickname for this connection, if any.
-
-        This name is used for differentiating instances in debug output.
-        """
-        return self._name
-
-    @name.setter
-    def name(self, name: Optional[str]) -> None:
-        logger = logging.getLogger(__name__)
-        if name:
-            self.logger = logger.getChild(name)
-        else:
-            self.logger = logger
-        self._name = name
-
-    @property  # @upper_half
-    def runstate(self) -> Runstate:
-        """The current `Runstate` of the connection."""
-        return self._runstate
-
-    @upper_half
-    async def runstate_changed(self) -> Runstate:
-        """
-        Wait for the `runstate` to change, then return that `Runstate`.
-        """
-        await self._runstate_event.wait()
-        return self.runstate
-
-    @upper_half
-    @require(Runstate.IDLE)
-    async def start_server_and_accept(
-            self, address: SocketAddrT,
-            ssl: Optional[SSLContext] = None
-    ) -> None:
-        """
-        Accept a connection and begin processing message queues.
-
-        If this call fails, `runstate` is guaranteed to be set back to
-        `IDLE`.  This method is precisely equivalent to calling
-        `start_server()` followed by :py:meth:`~AsyncProtocol.accept()`.
-
-        :param address:
-            Address to listen on; UNIX socket path or TCP address/port.
-        :param ssl: SSL context to use, if any.
-
-        :raise StateError: When the `Runstate` is not `IDLE`.
-        :raise ConnectError:
-            When a connection or session cannot be established.
-
-            This exception will wrap a more concrete one. In most cases,
-            the wrapped exception will be `OSError` or `EOFError`. If a
-            protocol-level failure occurs while establishing a new
-            session, the wrapped error may also be a `QMPError`.
-
-        """
-        await self.start_server(address, ssl)
-        await self.accept()
-        assert self.runstate == Runstate.RUNNING
-
-    @upper_half
-    @require(Runstate.IDLE)
-    async def start_server(self, address: SocketAddrT,
-                           ssl: Optional[SSLContext] = None) -> None:
-        """
-        Start listening for an incoming connection, but do not wait for a peer.
-
-        This method starts listening for an incoming connection, but
-        does not block waiting for a peer. This call will return
-        immediately after binding and listening on a socket. A later
-        call to :py:meth:`~AsyncProtocol.accept()` must be made in order
-        to finalize the incoming connection.
-
-        :param address:
-            Address to listen on; UNIX socket path or TCP address/port.
-        :param ssl: SSL context to use, if any.
-
-        :raise StateError: When the `Runstate` is not `IDLE`.
-        :raise ConnectError:
-            When the server could not start listening on this address.
-
-            This exception will wrap a more concrete one. In most cases,
-            the wrapped exception will be `OSError`.
-        """
-        async with self._session_guard('Failed to establish connection'):
-            await self._do_start_server(address, ssl)
-        assert self.runstate == Runstate.CONNECTING
-
-    @upper_half
-    @require(Runstate.CONNECTING)
-    async def accept(self) -> None:
-        """
-        Accept an incoming connection and begin processing message queues.
-
-        Used after a previous call to `start_server()` to accept an
-        incoming connection. If this call fails, `runstate` is
-        guaranteed to be set back to `IDLE`.
-
-        :raise StateError: When the `Runstate` is not `CONNECTING`.
-        :raise QMPError: When `start_server()` was not called first.
-        :raise ConnectError:
-            When a connection or session cannot be established.
-
-            This exception will wrap a more concrete one. In most cases,
-            the wrapped exception will be `OSError` or `EOFError`. If a
-            protocol-level failure occurs while establishing a new
-            session, the wrapped error may also be an `QMPError`.
-        """
-        if self._accepted is None:
-            raise QMPError("Cannot call accept() before start_server().")
-        async with self._session_guard('Failed to establish connection'):
-            await self._do_accept()
-        async with self._session_guard('Failed to establish session'):
-            await self._establish_session()
-        assert self.runstate == Runstate.RUNNING
-
-    @upper_half
-    @require(Runstate.IDLE)
-    async def connect(self, address: Union[SocketAddrT, socket.socket],
-                      ssl: Optional[SSLContext] = None) -> None:
-        """
-        Connect to the server and begin processing message queues.
-
-        If this call fails, `runstate` is guaranteed to be set back to `IDLE`.
-
-        :param address:
-            Address to connect to; UNIX socket path or TCP address/port.
-        :param ssl: SSL context to use, if any.
-
-        :raise StateError: When the `Runstate` is not `IDLE`.
-        :raise ConnectError:
-            When a connection or session cannot be established.
-
-            This exception will wrap a more concrete one. In most cases,
-            the wrapped exception will be `OSError` or `EOFError`. If a
-            protocol-level failure occurs while establishing a new
-            session, the wrapped error may also be an `QMPError`.
-        """
-        async with self._session_guard('Failed to establish connection'):
-            await self._do_connect(address, ssl)
-        async with self._session_guard('Failed to establish session'):
-            await self._establish_session()
-        assert self.runstate == Runstate.RUNNING
-
-    @upper_half
-    async def disconnect(self) -> None:
-        """
-        Disconnect and wait for all tasks to fully stop.
-
-        If there was an exception that caused the reader/writers to
-        terminate prematurely, it will be raised here.
-
-        :raise Exception:
-            When the reader or writer terminate unexpectedly. You can
-            expect to see `EOFError` if the server hangs up, or
-            `OSError` for connection-related issues. If there was a QMP
-            protocol-level problem, `ProtocolError` will be seen.
-        """
-        self.logger.debug("disconnect() called.")
-        self._schedule_disconnect()
-        await self._wait_disconnect()
-
-    # --------------------------
-    # Section: Session machinery
-    # --------------------------
-
-    @asynccontextmanager
-    async def _session_guard(self, emsg: str) -> AsyncGenerator[None, None]:
-        """
-        Async guard function used to roll back to `IDLE` on any error.
-
-        On any Exception, the state machine will be reset back to
-        `IDLE`. Most Exceptions will be wrapped with `ConnectError`, but
-        `BaseException` events will be left alone (This includes
-        asyncio.CancelledError, even prior to Python 3.8).
-
-        :param error_message:
-            Human-readable string describing what connection phase failed.
-
-        :raise BaseException:
-            When `BaseException` occurs in the guarded block.
-        :raise ConnectError:
-            When any other error is encountered in the guarded block.
-        """
-        try:
-            # Caller's code runs here.
-            yield
-        except BaseException as err:
-            self.logger.error("%s: %s", emsg, exception_summary(err))
-            self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-            try:
-                # Reset the runstate back to IDLE.
-                await self.disconnect()
-            except:
-                # We don't expect any Exceptions from the disconnect function
-                # here, because we failed to connect in the first place.
-                # The disconnect() function is intended to perform
-                # only cannot-fail cleanup here, but you never know.
-                emsg = (
-                    "Unexpected bottom half exception. "
-                    "This is a bug in the QMP library. "
-                    "Please report it to <qemu-devel@nongnu.org> and "
-                    "CC: John Snow <jsnow@redhat.com>."
-                )
-                self.logger.critical("%s:\n%s\n", emsg, pretty_traceback())
-                raise
-
-            # CancelledError is an Exception with special semantic meaning;
-            # We do NOT want to wrap it up under ConnectError.
-            # NB: CancelledError is not a BaseException before Python 3.8
-            if isinstance(err, asyncio.CancelledError):
-                raise
-
-            # Any other kind of error can be treated as some kind of connection
-            # failure broadly. Inspect the 'exc' field to explore the root
-            # cause in greater detail.
-            if isinstance(err, Exception):
-                raise ConnectError(emsg, err) from err
-
-            # Raise BaseExceptions un-wrapped, they're more important.
-            raise
-
-    @property
-    def _runstate_event(self) -> asyncio.Event:
-        # asyncio.Event() objects should not be created prior to entrance into
-        # an event loop, so we can ensure we create it in the correct context.
-        # Create it on-demand *only* at the behest of an 'async def' method.
-        if not self._runstate_changed:
-            self._runstate_changed = asyncio.Event()
-        return self._runstate_changed
-
-    @upper_half
-    @bottom_half
-    def _set_state(self, state: Runstate) -> None:
-        """
-        Change the `Runstate` of the protocol connection.
-
-        Signals the `runstate_changed` event.
-        """
-        if state == self._runstate:
-            return
-
-        self.logger.debug("Transitioning from '%s' to '%s'.",
-                          str(self._runstate), str(state))
-        self._runstate = state
-        self._runstate_event.set()
-        self._runstate_event.clear()
-
-    @bottom_half
-    async def _stop_server(self) -> None:
-        """
-        Stop listening for / accepting new incoming connections.
-        """
-        if self._server is None:
-            return
-
-        try:
-            self.logger.debug("Stopping server.")
-            self._server.close()
-            self.logger.debug("Server stopped.")
-        finally:
-            self._server = None
-
-    @bottom_half  # However, it does not run from the R/W tasks.
-    async def _incoming(self,
-                        reader: asyncio.StreamReader,
-                        writer: asyncio.StreamWriter) -> None:
-        """
-        Accept an incoming connection and signal the upper_half.
-
-        This method does the minimum necessary to accept a single
-        incoming connection. It signals back to the upper_half ASAP so
-        that any errors during session initialization can occur
-        naturally in the caller's stack.
-
-        :param reader: Incoming `asyncio.StreamReader`
-        :param writer: Incoming `asyncio.StreamWriter`
-        """
-        peer = writer.get_extra_info('peername', 'Unknown peer')
-        self.logger.debug("Incoming connection from %s", peer)
-
-        if self._reader or self._writer:
-            # Sadly, we can have more than one pending connection
-            # because of https://bugs.python.org/issue46715
-            # Close any extra connections we don't actually want.
-            self.logger.warning("Extraneous connection inadvertently accepted")
-            writer.close()
-            return
-
-        # A connection has been accepted; stop listening for new ones.
-        assert self._accepted is not None
-        await self._stop_server()
-        self._reader, self._writer = (reader, writer)
-        self._accepted.set()
-
-    @upper_half
-    async def _do_start_server(self, address: SocketAddrT,
-                               ssl: Optional[SSLContext] = None) -> None:
-        """
-        Start listening for an incoming connection, but do not wait for a peer.
-
-        This method starts listening for an incoming connection, but does not
-        block waiting for a peer. This call will return immediately after
-        binding and listening to a socket. A later call to accept() must be
-        made in order to finalize the incoming connection.
-
-        :param address:
-            Address to listen on; UNIX socket path or TCP address/port.
-        :param ssl: SSL context to use, if any.
-
-        :raise OSError: For stream-related errors.
-        """
-        assert self.runstate == Runstate.IDLE
-        self._set_state(Runstate.CONNECTING)
-
-        self.logger.debug("Awaiting connection on %s ...", address)
-        self._accepted = asyncio.Event()
-
-        if isinstance(address, tuple):
-            coro = asyncio.start_server(
-                self._incoming,
-                host=address[0],
-                port=address[1],
-                ssl=ssl,
-                backlog=1,
-                limit=self.readbuflen,
-            )
-        else:
-            coro = asyncio.start_unix_server(
-                self._incoming,
-                path=address,
-                ssl=ssl,
-                backlog=1,
-                limit=self.readbuflen,
-            )
-
-        # Allow runstate watchers to witness 'CONNECTING' state; some
-        # failures in the streaming layer are synchronous and will not
-        # otherwise yield.
-        await asyncio.sleep(0)
-
-        # This will start the server (bind(2), listen(2)). It will also
-        # call accept(2) if we yield, but we don't block on that here.
-        self._server = await coro
-        self.logger.debug("Server listening on %s", address)
-
-    @upper_half
-    async def _do_accept(self) -> None:
-        """
-        Wait for and accept an incoming connection.
-
-        Requires that we have not yet accepted an incoming connection
-        from the upper_half, but it's OK if the server is no longer
-        running because the bottom_half has already accepted the
-        connection.
-        """
-        assert self._accepted is not None
-        await self._accepted.wait()
-        assert self._server is None
-        self._accepted = None
-
-        self.logger.debug("Connection accepted.")
-
-    @upper_half
-    async def _do_connect(self, address: Union[SocketAddrT, socket.socket],
-                          ssl: Optional[SSLContext] = None) -> None:
-        """
-        Acting as the transport client, initiate a connection to a server.
-
-        :param address:
-            Address to connect to; UNIX socket path or TCP address/port.
-        :param ssl: SSL context to use, if any.
-
-        :raise OSError: For stream-related errors.
-        """
-        assert self.runstate == Runstate.IDLE
-        self._set_state(Runstate.CONNECTING)
-
-        # Allow runstate watchers to witness 'CONNECTING' state; some
-        # failures in the streaming layer are synchronous and will not
-        # otherwise yield.
-        await asyncio.sleep(0)
-
-        if isinstance(address, socket.socket):
-            self.logger.debug("Connecting with existing socket: "
-                              "fd=%d, family=%r, type=%r",
-                              address.fileno(), address.family, address.type)
-            connect = asyncio.open_connection(
-                limit=self.readbuflen,
-                ssl=ssl,
-                sock=address,
-            )
-        elif isinstance(address, tuple):
-            self.logger.debug("Connecting to %s ...", address)
-            connect = asyncio.open_connection(
-                address[0],
-                address[1],
-                ssl=ssl,
-                limit=self.readbuflen,
-            )
-        else:
-            self.logger.debug("Connecting to file://%s ...", address)
-            connect = asyncio.open_unix_connection(
-                path=address,
-                ssl=ssl,
-                limit=self.readbuflen,
-            )
-
-        self._reader, self._writer = await connect
-        self.logger.debug("Connected.")
-
-    @upper_half
-    async def _establish_session(self) -> None:
-        """
-        Establish a new session.
-
-        Starts the readers/writer tasks; subclasses may perform their
-        own negotiations here. The Runstate will be RUNNING upon
-        successful conclusion.
-        """
-        assert self.runstate == Runstate.CONNECTING
-
-        self._outgoing = asyncio.Queue()
-
-        reader_coro = self._bh_loop_forever(self._bh_recv_message, 'Reader')
-        writer_coro = self._bh_loop_forever(self._bh_send_message, 'Writer')
-
-        self._reader_task = asyncio.create_task(reader_coro)
-        self._writer_task = asyncio.create_task(writer_coro)
-
-        self._bh_tasks = asyncio.gather(
-            self._reader_task,
-            self._writer_task,
-        )
-
-        self._set_state(Runstate.RUNNING)
-        await asyncio.sleep(0)  # Allow runstate_event to process
-
-    @upper_half
-    @bottom_half
-    def _schedule_disconnect(self) -> None:
-        """
-        Initiate a disconnect; idempotent.
-
-        This method is used both in the upper-half as a direct
-        consequence of `disconnect()`, and in the bottom-half in the
-        case of unhandled exceptions in the reader/writer tasks.
-
-        It can be invoked no matter what the `runstate` is.
-        """
-        if not self._dc_task:
-            self._set_state(Runstate.DISCONNECTING)
-            self.logger.debug("Scheduling disconnect.")
-            self._dc_task = asyncio.create_task(self._bh_disconnect())
-
-    @upper_half
-    async def _wait_disconnect(self) -> None:
-        """
-        Waits for a previously scheduled disconnect to finish.
-
-        This method will gather any bottom half exceptions and re-raise
-        the one that occurred first; presuming it to be the root cause
-        of any subsequent Exceptions. It is intended to be used in the
-        upper half of the call chain.
-
-        :raise Exception:
-            Arbitrary exception re-raised on behalf of the reader/writer.
-        """
-        assert self.runstate == Runstate.DISCONNECTING
-        assert self._dc_task
-
-        aws: List[Awaitable[object]] = [self._dc_task]
-        if self._bh_tasks:
-            aws.insert(0, self._bh_tasks)
-        all_defined_tasks = asyncio.gather(*aws)
-
-        # Ensure disconnect is done; Exception (if any) is not raised here:
-        await asyncio.wait((self._dc_task,))
-
-        try:
-            await all_defined_tasks  # Raise Exceptions from the bottom half.
-        finally:
-            self._cleanup()
-            self._set_state(Runstate.IDLE)
-
-    @upper_half
-    def _cleanup(self) -> None:
-        """
-        Fully reset this object to a clean state and return to `IDLE`.
-        """
-        def _paranoid_task_erase(task: Optional['asyncio.Future[_U]']
-                                 ) -> Optional['asyncio.Future[_U]']:
-            # Help to erase a task, ENSURING it is fully quiesced first.
-            assert (task is None) or task.done()
-            return None if (task and task.done()) else task
-
-        assert self.runstate == Runstate.DISCONNECTING
-        self._dc_task = _paranoid_task_erase(self._dc_task)
-        self._reader_task = _paranoid_task_erase(self._reader_task)
-        self._writer_task = _paranoid_task_erase(self._writer_task)
-        self._bh_tasks = _paranoid_task_erase(self._bh_tasks)
-
-        self._reader = None
-        self._writer = None
-        self._accepted = None
-
-        # NB: _runstate_changed cannot be cleared because we still need it to
-        # send the final runstate changed event ...!
-
-    # ----------------------------
-    # Section: Bottom Half methods
-    # ----------------------------
-
-    @bottom_half
-    async def _bh_disconnect(self) -> None:
-        """
-        Disconnect and cancel all outstanding tasks.
-
-        It is designed to be called from its task context,
-        :py:obj:`~AsyncProtocol._dc_task`. By running in its own task,
-        it is free to wait on any pending actions that may still need to
-        occur in either the reader or writer tasks.
-        """
-        assert self.runstate == Runstate.DISCONNECTING
-
-        def _done(task: Optional['asyncio.Future[Any]']) -> bool:
-            return task is not None and task.done()
-
-        # If the server is running, stop it.
-        await self._stop_server()
-
-        # Are we already in an error pathway? If either of the tasks are
-        # already done, or if we have no tasks but a reader/writer; we
-        # must be.
-        #
-        # NB: We can't use _bh_tasks to check for premature task
-        # completion, because it may not yet have had a chance to run
-        # and gather itself.
-        tasks = tuple(filter(None, (self._writer_task, self._reader_task)))
-        error_pathway = _done(self._reader_task) or _done(self._writer_task)
-        if not tasks:
-            error_pathway |= bool(self._reader) or bool(self._writer)
-
-        try:
-            # Try to flush the writer, if possible.
-            # This *may* cause an error and force us over into the error path.
-            if not error_pathway:
-                await self._bh_flush_writer()
-        except BaseException as err:
-            error_pathway = True
-            emsg = "Failed to flush the writer"
-            self.logger.error("%s: %s", emsg, exception_summary(err))
-            self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-            raise
-        finally:
-            # Cancel any still-running tasks (Won't raise):
-            if self._writer_task is not None and not self._writer_task.done():
-                self.logger.debug("Cancelling writer task.")
-                self._writer_task.cancel()
-            if self._reader_task is not None and not self._reader_task.done():
-                self.logger.debug("Cancelling reader task.")
-                self._reader_task.cancel()
-
-            # Close out the tasks entirely (Won't raise):
-            if tasks:
-                self.logger.debug("Waiting for tasks to complete ...")
-                await asyncio.wait(tasks)
-
-            # Lastly, close the stream itself. (*May raise*!):
-            await self._bh_close_stream(error_pathway)
-            self.logger.debug("Disconnected.")
-
-    @bottom_half
-    async def _bh_flush_writer(self) -> None:
-        if not self._writer_task:
-            return
-
-        self.logger.debug("Draining the outbound queue ...")
-        await self._outgoing.join()
-        if self._writer is not None:
-            self.logger.debug("Flushing the StreamWriter ...")
-            await flush(self._writer)
-
-    @bottom_half
-    async def _bh_close_stream(self, error_pathway: bool = False) -> None:
-        # NB: Closing the writer also implicitly closes the reader.
-        if not self._writer:
-            return
-
-        if not self._writer.is_closing():
-            self.logger.debug("Closing StreamWriter.")
-            self._writer.close()
-
-        self.logger.debug("Waiting for StreamWriter to close ...")
-        try:
-            await self._writer.wait_closed()
-        except Exception:  # pylint: disable=broad-except
-            # It's hard to tell if the Stream is already closed or
-            # not. Even if one of the tasks has failed, it may have
-            # failed for a higher-layered protocol reason. The
-            # stream could still be open and perfectly fine.
-            # I don't know how to discern its health here.
-
-            if error_pathway:
-                # We already know that *something* went wrong. Let's
-                # just trust that the Exception we already have is the
-                # better one to present to the user, even if we don't
-                # genuinely *know* the relationship between the two.
-                self.logger.debug(
-                    "Discarding Exception from wait_closed:\n%s\n",
-                    pretty_traceback(),
-                )
-            else:
-                # Oops, this is a brand-new error!
-                raise
-        finally:
-            self.logger.debug("StreamWriter closed.")
-
-    @bottom_half
-    async def _bh_loop_forever(self, async_fn: _TaskFN, name: str) -> None:
-        """
-        Run one of the bottom-half methods in a loop forever.
-
-        If the bottom half ever raises any exception, schedule a
-        disconnect that will terminate the entire loop.
-
-        :param async_fn: The bottom-half method to run in a loop.
-        :param name: The name of this task, used for logging.
-        """
-        try:
-            while True:
-                await async_fn()
-        except asyncio.CancelledError:
-            # We have been cancelled by _bh_disconnect, exit gracefully.
-            self.logger.debug("Task.%s: cancelled.", name)
-            return
-        except BaseException as err:
-            self.logger.log(
-                logging.INFO if isinstance(err, EOFError) else logging.ERROR,
-                "Task.%s: %s",
-                name, exception_summary(err)
-            )
-            self.logger.debug("Task.%s: failure:\n%s\n",
-                              name, pretty_traceback())
-            self._schedule_disconnect()
-            raise
-        finally:
-            self.logger.debug("Task.%s: exiting.", name)
-
-    @bottom_half
-    async def _bh_send_message(self) -> None:
-        """
-        Wait for an outgoing message, then send it.
-
-        Designed to be run in `_bh_loop_forever()`.
-        """
-        msg = await self._outgoing.get()
-        try:
-            await self._send(msg)
-        finally:
-            self._outgoing.task_done()
-
-    @bottom_half
-    async def _bh_recv_message(self) -> None:
-        """
-        Wait for an incoming message and call `_on_message` to route it.
-
-        Designed to be run in `_bh_loop_forever()`.
-        """
-        msg = await self._recv()
-        await self._on_message(msg)
-
-    # --------------------
-    # Section: Message I/O
-    # --------------------
-
-    @upper_half
-    @bottom_half
-    def _cb_outbound(self, msg: T) -> T:
-        """
-        Callback: outbound message hook.
-
-        This is intended for subclasses to be able to add arbitrary
-        hooks to filter or manipulate outgoing messages. The base
-        implementation does nothing but log the message without any
-        manipulation of the message.
-
-        :param msg: raw outbound message
-        :return: final outbound message
-        """
-        self.logger.debug("--> %s", str(msg))
-        return msg
-
-    @upper_half
-    @bottom_half
-    def _cb_inbound(self, msg: T) -> T:
-        """
-        Callback: inbound message hook.
-
-        This is intended for subclasses to be able to add arbitrary
-        hooks to filter or manipulate incoming messages. The base
-        implementation does nothing but log the message without any
-        manipulation of the message.
-
-        This method does not "handle" incoming messages; it is a filter.
-        The actual "endpoint" for incoming messages is `_on_message()`.
-
-        :param msg: raw inbound message
-        :return: processed inbound message
-        """
-        self.logger.debug("<-- %s", str(msg))
-        return msg
-
-    @upper_half
-    @bottom_half
-    async def _readline(self) -> bytes:
-        """
-        Wait for a newline from the incoming reader.
-
-        This method is provided as a convenience for upper-layer
-        protocols, as many are line-based.
-
-        This method *may* return a sequence of bytes without a trailing
-        newline if EOF occurs, but *some* bytes were received. In this
-        case, the next call will raise `EOFError`. It is assumed that
-        the layer 5 protocol will decide if there is anything meaningful
-        to be done with a partial message.
-
-        :raise OSError: For stream-related errors.
-        :raise EOFError:
-            If the reader stream is at EOF and there are no bytes to return.
-        :return: bytes, including the newline.
-        """
-        assert self._reader is not None
-        msg_bytes = await self._reader.readline()
-
-        if not msg_bytes:
-            if self._reader.at_eof():
-                raise EOFError
-
-        return msg_bytes
-
-    @upper_half
-    @bottom_half
-    async def _do_recv(self) -> T:
-        """
-        Abstract: Read from the stream and return a message.
-
-        Very low-level; intended to only be called by `_recv()`.
-        """
-        raise NotImplementedError
-
-    @upper_half
-    @bottom_half
-    async def _recv(self) -> T:
-        """
-        Read an arbitrary protocol message.
-
-        .. warning::
-            This method is intended primarily for `_bh_recv_message()`
-            to use in an asynchronous task loop. Using it outside of
-            this loop will "steal" messages from the normal routing
-            mechanism. It is safe to use prior to `_establish_session()`,
-            but should not be used otherwise.
-
-        This method uses `_do_recv()` to retrieve the raw message, and
-        then transforms it using `_cb_inbound()`.
-
-        :return: A single (filtered, processed) protocol message.
-        """
-        message = await self._do_recv()
-        return self._cb_inbound(message)
-
-    @upper_half
-    @bottom_half
-    def _do_send(self, msg: T) -> None:
-        """
-        Abstract: Write a message to the stream.
-
-        Very low-level; intended to only be called by `_send()`.
-        """
-        raise NotImplementedError
-
-    @upper_half
-    @bottom_half
-    async def _send(self, msg: T) -> None:
-        """
-        Send an arbitrary protocol message.
-
-        This method will transform any outgoing messages according to
-        `_cb_outbound()`.
-
-        .. warning::
-            Like `_recv()`, this method is intended to be called by
-            the writer task loop that processes outgoing
-            messages. Calling it directly may circumvent logic
-            implemented by the caller meant to correlate outgoing and
-            incoming messages.
-
-        :raise OSError: For problems with the underlying stream.
-        """
-        msg = self._cb_outbound(msg)
-        self._do_send(msg)
-
-    @bottom_half
-    async def _on_message(self, msg: T) -> None:
-        """
-        Called to handle the receipt of a new message.
-
-        .. caution::
-            This is executed from within the reader loop, so be advised
-            that waiting on either the reader or writer task will lead
-            to deadlock. Additionally, any unhandled exceptions will
-            directly cause the loop to halt, so logic may be best-kept
-            to a minimum if at all possible.
-
-        :param msg: The incoming message, already logged/filtered.
-        """
-        # Nothing to do in the abstract case.
diff --git a/python/qemu/qmp/py.typed b/python/qemu/qmp/py.typed
deleted file mode 100644
index e69de29bb2d..00000000000
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
deleted file mode 100644
index 8beccfe29d3..00000000000
--- a/python/qemu/qmp/qmp_client.py
+++ /dev/null
@@ -1,732 +0,0 @@
-"""
-QMP Protocol Implementation
-
-This module provides the `QMPClient` class, which can be used to connect
-and send commands to a QMP server such as QEMU. The QMP class can be
-used to either connect to a listening server, or used to listen and
-accept an incoming connection from that server.
-"""
-
-import asyncio
-import logging
-import socket
-import struct
-from typing import (
-    Dict,
-    List,
-    Mapping,
-    Optional,
-    Union,
-    cast,
-)
-
-from .error import ProtocolError, QMPError
-from .events import Events
-from .message import Message
-from .models import ErrorResponse, Greeting
-from .protocol import AsyncProtocol, Runstate, require
-from .util import (
-    bottom_half,
-    exception_summary,
-    pretty_traceback,
-    upper_half,
-)
-
-
-class _WrappedProtocolError(ProtocolError):
-    """
-    Abstract exception class for Protocol errors that wrap an Exception.
-
-    :param error_message: Human-readable string describing the error.
-    :param exc: The root-cause exception.
-    """
-    def __init__(self, error_message: str, exc: Exception):
-        super().__init__(error_message, exc)
-        self.exc = exc
-
-    def __str__(self) -> str:
-        return f"{self.error_message}: {self.exc!s}"
-
-
-class GreetingError(_WrappedProtocolError):
-    """
-    An exception occurred during the Greeting phase.
-
-    :param error_message: Human-readable string describing the error.
-    :param exc: The root-cause exception.
-    """
-
-
-class NegotiationError(_WrappedProtocolError):
-    """
-    An exception occurred during the Negotiation phase.
-
-    :param error_message: Human-readable string describing the error.
-    :param exc: The root-cause exception.
-    """
-
-
-class ExecuteError(QMPError):
-    """
-    Exception raised by `QMPClient.execute()` on RPC failure.
-
-    This exception is raised when the server received, interpreted, and
-    replied to a command successfully; but the command itself returned a
-    failure status.
-
-    For example::
-
-        await qmp.execute('block-dirty-bitmap-add',
-                          {'node': 'foo', 'name': 'my_bitmap'})
-        # qemu.qmp.qmp_client.ExecuteError:
-        #     Cannot find device='foo' nor node-name='foo'
-
-    :param error_response: The RPC error response object.
-    :param sent: The sent RPC message that caused the failure.
-    :param received: The raw RPC error reply received.
-    """
-    def __init__(self, error_response: ErrorResponse,
-                 sent: Message, received: Message):
-        super().__init__(error_response, sent, received)
-        #: The sent `Message` that caused the failure
-        self.sent: Message = sent
-        #: The received `Message` that indicated failure
-        self.received: Message = received
-        #: The parsed error response
-        self.error: ErrorResponse = error_response
-
-    @property
-    def error_class(self) -> str:
-        """The QMP error class"""
-        return self.error.error.class_
-
-    def __str__(self) -> str:
-        return self.error.error.desc
-
-
-class ExecInterruptedError(QMPError):
-    """
-    Exception raised by `execute()` (et al) when an RPC is interrupted.
-
-    This error is raised when an `execute()` statement could not be
-    completed.  This can occur because the connection itself was
-    terminated before a reply was received. The true cause of the
-    interruption will be available via `disconnect()`.
-
-    The QMP protocol does not make it possible to know if a command
-    succeeded or failed after such an event; the client will need to
-    query the server to determine the state of the server on a
-    case-by-case basis.
-
-    For example, ECONNRESET might look like this::
-
-        try:
-            await qmp.execute('query-block')
-            # ExecInterruptedError: Disconnected
-        except ExecInterruptedError:
-            await qmp.disconnect()
-            # ConnectionResetError: [Errno 104] Connection reset by peer
-    """
-
-
-class _MsgProtocolError(ProtocolError):
-    """
-    Abstract error class for protocol errors that have a `Message` object.
-
-    This Exception class is used for protocol errors where the `Message`
-    was mechanically understood, but was found to be inappropriate or
-    malformed.
-
-    :param error_message: Human-readable string describing the error.
-    :param msg: The QMP `Message` that caused the error.
-    """
-    def __init__(self, error_message: str, msg: Message, *args: object):
-        super().__init__(error_message, msg, *args)
-        #: The received `Message` that caused the error.
-        self.msg: Message = msg
-
-    def __str__(self) -> str:
-        return "\n".join([
-            super().__str__(),
-            f"  Message was: {str(self.msg)}\n",
-        ])
-
-
-class ServerParseError(_MsgProtocolError):
-    """
-    The Server sent a `Message` indicating parsing failure.
-
-    i.e. A reply has arrived from the server, but it is missing the "ID"
-    field, indicating a parsing error.
-
-    :param error_message: Human-readable string describing the error.
-    :param msg: The QMP `Message` that caused the error.
-    """
-
-
-class BadReplyError(_MsgProtocolError):
-    """
-    An execution reply was successfully routed, but not understood.
-
-    If a QMP message is received with an 'id' field to allow it to be
-    routed, but is otherwise malformed, this exception will be raised.
-
-    A reply message is malformed if it is missing either the 'return' or
-    'error' keys, or if the 'error' value has missing keys or members of
-    the wrong type.
-
-    :param error_message: Human-readable string describing the error.
-    :param msg: The malformed reply that was received.
-    :param sent: The message that was sent that prompted the error.
-    """
-    def __init__(self, error_message: str, msg: Message, sent: Message):
-        super().__init__(error_message, msg, sent)
-        #: The sent `Message` that caused the failure
-        self.sent = sent
-
-
-class QMPClient(AsyncProtocol[Message], Events):
-    """Implements a QMP client connection.
-
-    `QMPClient` can be used to either connect or listen to a QMP server,
-    but always acts as the QMP client.
-
-    :param name:
-        Optional nickname for the connection, used to differentiate
-        instances when logging.
-
-    :param readbuflen:
-        The maximum buffer length for reads and writes to and from the QMP
-        server, in bytes. Default is 10MB. If `QMPClient` is used to
-        connect to a guest agent to transfer files via ``guest-file-read``/
-        ``guest-file-write``, increasing this value may be required.
-
-    Basic script-style usage looks like this::
-
-      import asyncio
-      from qemu.qmp import QMPClient
-
-      async def main():
-          qmp = QMPClient('my_virtual_machine_name')
-          await qmp.connect(('127.0.0.1', 1234))
-          ...
-          res = await qmp.execute('query-block')
-          ...
-          await qmp.disconnect()
-
-      asyncio.run(main())
-
-    A more advanced example that starts to take advantage of asyncio
-    might look like this::
-
-      class Client:
-          def __init__(self, name: str):
-              self.qmp = QMPClient(name)
-
-          async def watch_events(self):
-              try:
-                  async for event in self.qmp.events:
-                      print(f"Event: {event['event']}")
-              except asyncio.CancelledError:
-                  return
-
-          async def run(self, address='/tmp/qemu.socket'):
-              await self.qmp.connect(address)
-              asyncio.create_task(self.watch_events())
-              await self.qmp.runstate_changed.wait()
-              await self.disconnect()
-
-    See `qmp.events` for more detail on event handling patterns.
-
-    """
-    #: Logger object used for debugging messages.
-    logger = logging.getLogger(__name__)
-
-    # Read buffer default limit; 10MB like libvirt default
-    _readbuflen = 10 * 1024 * 1024
-
-    # Type alias for pending execute() result items
-    _PendingT = Union[Message, ExecInterruptedError]
-
-    def __init__(
-        self,
-        name: Optional[str] = None,
-        readbuflen: int = _readbuflen
-    ) -> None:
-        super().__init__(name, readbuflen)
-        Events.__init__(self)
-
-        #: Whether or not to await a greeting after establishing a connection.
-        #: Defaults to True; QGA servers expect this to be False.
-        self.await_greeting: bool = True
-
-        #: Whether or not to perform capabilities negotiation upon
-        #: connection. Implies `await_greeting`. Defaults to True; QGA
-        #: servers expect this to be False.
-        self.negotiate: bool = True
-
-        # Cached Greeting, if one was awaited.
-        self._greeting: Optional[Greeting] = None
-
-        # Command ID counter
-        self._execute_id = 0
-
-        # Incoming RPC reply messages.
-        self._pending: Dict[
-            Union[str, None],
-            'asyncio.Queue[QMPClient._PendingT]'
-        ] = {}
-
-    @property
-    def greeting(self) -> Optional[Greeting]:
-        """
-        The `Greeting` from the QMP server, if any.
-
-        Defaults to ``None``, and will be set after a greeting is
-        received during the connection process. It is reset at the start
-        of each connection attempt.
-        """
-        return self._greeting
-
-    @upper_half
-    async def _establish_session(self) -> None:
-        """
-        Initiate the QMP session.
-
-        Wait for the QMP greeting and perform capabilities negotiation.
-
-        :raise GreetingError: When the greeting is not understood.
-        :raise NegotiationError: If the negotiation fails.
-        :raise EOFError: When the server unexpectedly hangs up.
-        :raise OSError: For underlying stream errors.
-        """
-        self._greeting = None
-        self._pending = {}
-
-        if self.await_greeting or self.negotiate:
-            self._greeting = await self._get_greeting()
-
-        if self.negotiate:
-            await self._negotiate()
-
-        # This will start the reader/writers:
-        await super()._establish_session()
-
-    @upper_half
-    async def _get_greeting(self) -> Greeting:
-        """
-        :raise GreetingError: When the greeting is not understood.
-        :raise EOFError: When the server unexpectedly hangs up.
-        :raise OSError: For underlying stream errors.
-
-        :return: the Greeting object given by the server.
-        """
-        self.logger.debug("Awaiting greeting ...")
-
-        try:
-            msg = await self._recv()
-            return Greeting(msg)
-        except (ProtocolError, KeyError, TypeError) as err:
-            emsg = "Did not understand Greeting"
-            self.logger.error("%s: %s", emsg, exception_summary(err))
-            self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-            raise GreetingError(emsg, err) from err
-        except BaseException as err:
-            # EOFError, OSError, or something unexpected.
-            emsg = "Failed to receive Greeting"
-            self.logger.error("%s: %s", emsg, exception_summary(err))
-            self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-            raise
-
-    @upper_half
-    async def _negotiate(self) -> None:
-        """
-        Perform QMP capabilities negotiation.
-
-        :raise NegotiationError: When negotiation fails.
-        :raise EOFError: When the server unexpectedly hangs up.
-        :raise OSError: For underlying stream errors.
-        """
-        self.logger.debug("Negotiating capabilities ...")
-
-        arguments: Dict[str, List[str]] = {}
-        if self._greeting and 'oob' in self._greeting.QMP.capabilities:
-            arguments.setdefault('enable', []).append('oob')
-        msg = self.make_execute_msg('qmp_capabilities', arguments=arguments)
-
-        # It's not safe to use execute() here, because the reader/writers
-        # aren't running. AsyncProtocol *requires* that a new session
-        # does not fail after the reader/writers are running!
-        try:
-            await self._send(msg)
-            reply = await self._recv()
-            assert 'return' in reply
-            assert 'error' not in reply
-        except (ProtocolError, AssertionError) as err:
-            emsg = "Negotiation failed"
-            self.logger.error("%s: %s", emsg, exception_summary(err))
-            self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-            raise NegotiationError(emsg, err) from err
-        except BaseException as err:
-            # EOFError, OSError, or something unexpected.
-            emsg = "Negotiation failed"
-            self.logger.error("%s: %s", emsg, exception_summary(err))
-            self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-            raise
-
-    @bottom_half
-    async def _bh_disconnect(self) -> None:
-        try:
-            await super()._bh_disconnect()
-        finally:
-            if self._pending:
-                self.logger.debug("Cancelling pending executions")
-            keys = self._pending.keys()
-            for key in keys:
-                self.logger.debug("Cancelling execution '%s'", key)
-                self._pending[key].put_nowait(
-                    ExecInterruptedError("Disconnected")
-                )
-
-            self.logger.debug("QMP Disconnected.")
-
-    @upper_half
-    def _cleanup(self) -> None:
-        super()._cleanup()
-        assert not self._pending
-
-    @bottom_half
-    async def _on_message(self, msg: Message) -> None:
-        """
-        Add an incoming message to the appropriate queue/handler.
-
-        :raise ServerParseError: When Message indicates server parse failure.
-        """
-        # Incoming messages are not fully parsed/validated here;
-        # do only light peeking to know how to route the messages.
-
-        if 'event' in msg:
-            await self._event_dispatch(msg)
-            return
-
-        # Below, we assume everything left is an execute/exec-oob response.
-
-        exec_id = cast(Optional[str], msg.get('id'))
-
-        if exec_id in self._pending:
-            await self._pending[exec_id].put(msg)
-            return
-
-        # We have a message we can't route back to a caller.
-
-        is_error = 'error' in msg
-        has_id = 'id' in msg
-
-        if is_error and not has_id:
-            # This is very likely a server parsing error.
-            # It doesn't inherently belong to any pending execution.
-            # Instead of performing clever recovery, just terminate.
-            # See "NOTE" in interop/qmp-spec, "Error" section.
-            raise ServerParseError(
-                ("Server sent an error response without an ID, "
-                 "but there are no ID-less executions pending. "
-                 "Assuming this is a server parser failure."),
-                msg
-            )
-
-        # qmp-spec.rst, "Commands Responses" section:
-        # 'Clients should drop all the responses
-        # that have an unknown "id" field.'
-        self.logger.log(
-            logging.ERROR if is_error else logging.WARNING,
-            "Unknown ID '%s', message dropped.",
-            exec_id,
-        )
-        self.logger.debug("Unroutable message: %s", str(msg))
-
-    @upper_half
-    @bottom_half
-    async def _do_recv(self) -> Message:
-        """
-        :raise OSError: When a stream error is encountered.
-        :raise EOFError: When the stream is at EOF.
-        :raise ProtocolError:
-            When the Message is not understood.
-            See also `Message._deserialize`.
-
-        :return: A single QMP `Message`.
-        """
-        msg_bytes = await self._readline()
-        msg = Message(msg_bytes, eager=True)
-        return msg
-
-    @upper_half
-    @bottom_half
-    def _do_send(self, msg: Message) -> None:
-        """
-        :raise ValueError: JSON serialization failure
-        :raise TypeError: JSON serialization failure
-        :raise OSError: When a stream error is encountered.
-        """
-        assert self._writer is not None
-        self._writer.write(bytes(msg))
-
-    @upper_half
-    def _get_exec_id(self) -> str:
-        exec_id = f"__qmp#{self._execute_id:05d}"
-        self._execute_id += 1
-        return exec_id
-
-    @upper_half
-    async def _issue(self, msg: Message) -> Union[None, str]:
-        """
-        Issue a QMP `Message` and do not wait for a reply.
-
-        :param msg: The QMP `Message` to send to the server.
-
-        :return: The ID of the `Message` sent.
-        """
-        msg_id: Optional[str] = None
-        if 'id' in msg:
-            assert isinstance(msg['id'], str)
-            msg_id = msg['id']
-
-        self._pending[msg_id] = asyncio.Queue(maxsize=1)
-        try:
-            await self._outgoing.put(msg)
-        except:
-            del self._pending[msg_id]
-            raise
-
-        return msg_id
-
-    @upper_half
-    async def _reply(self, msg_id: Union[str, None]) -> Message:
-        """
-        Await a reply to a previously issued QMP message.
-
-        :param msg_id: The ID of the previously issued message.
-
-        :return: The reply from the server.
-        :raise ExecInterruptedError:
-            When the reply could not be retrieved because the connection
-            was lost, or some other problem.
-        """
-        queue = self._pending[msg_id]
-
-        try:
-            result = await queue.get()
-            if isinstance(result, ExecInterruptedError):
-                raise result
-            return result
-        finally:
-            del self._pending[msg_id]
-
-    @upper_half
-    async def _execute(self, msg: Message, assign_id: bool = True) -> Message:
-        """
-        Send a QMP `Message` to the server and await a reply.
-
-        This method *assumes* you are sending some kind of an execute
-        statement that *will* receive a reply.
-
-        An execution ID will be assigned if assign_id is `True`. It can be
-        disabled, but this requires that an ID is manually assigned
-        instead. For manually assigned IDs, you must not use the string
-        '__qmp#' anywhere in the ID.
-
-        :param msg: The QMP `Message` to execute.
-        :param assign_id: If True, assign a new execution ID.
-
-        :return: Execution reply from the server.
-        :raise ExecInterruptedError:
-            When the reply could not be retrieved because the connection
-            was lost, or some other problem.
-        """
-        if assign_id:
-            msg['id'] = self._get_exec_id()
-        elif 'id' in msg:
-            assert isinstance(msg['id'], str)
-            assert '__qmp#' not in msg['id']
-
-        exec_id = await self._issue(msg)
-        return await self._reply(exec_id)
-
-    @upper_half
-    @require(Runstate.RUNNING)
-    async def _raw(
-            self,
-            msg: Union[Message, Mapping[str, object], bytes],
-            assign_id: bool = True,
-    ) -> Message:
-        """
-        Issue a raw `Message` to the QMP server and await a reply.
-
-        :param msg:
-            A Message to send to the server. It may be a `Message`, any
-            Mapping (including Dict), or raw bytes.
-        :param assign_id:
-            Assign an arbitrary execution ID to this message. If
-            `False`, the existing id must either be absent (and no other
-            such pending execution may omit an ID) or a string. If it is
-            a string, it must not start with '__qmp#' and no other such
-            pending execution may currently be using that ID.
-
-        :return: Execution reply from the server.
-
-        :raise ExecInterruptedError:
-            When the reply could not be retrieved because the connection
-            was lost, or some other problem.
-        :raise TypeError:
-            When assign_id is `False`, an ID is given, and it is not a string.
-        :raise ValueError:
-            When assign_id is `False`, but the ID is not usable;
-            Either because it starts with '__qmp#' or it is already in-use.
-        """
-        # 1. convert generic Mapping or bytes to a QMP Message
-        # 2. copy Message objects so that we assign an ID only to the copy.
-        msg = Message(msg)
-
-        exec_id = msg.get('id')
-        if not assign_id and 'id' in msg:
-            if not isinstance(exec_id, str):
-                raise TypeError(f"ID ('{exec_id}') must be a string.")
-            if exec_id.startswith('__qmp#'):
-                raise ValueError(
-                    f"ID ('{exec_id}') must not start with '__qmp#'."
-                )
-
-        if not assign_id and exec_id in self._pending:
-            raise ValueError(
-                f"ID '{exec_id}' is in-use and cannot be used."
-            )
-
-        return await self._execute(msg, assign_id=assign_id)
-
-    @upper_half
-    @require(Runstate.RUNNING)
-    async def execute_msg(self, msg: Message) -> object:
-        """
-        Execute a QMP command on the server and return its value.
-
-        :param msg: The QMP `Message` to execute.
-
-        :return:
-            The command execution return value from the server. The type of
-            object returned depends on the command that was issued,
-            though most in QEMU return a `dict`.
-        :raise ValueError:
-            If the QMP `Message` does not have either the 'execute' or
-            'exec-oob' fields set.
-        :raise ExecuteError: When the server returns an error response.
-        :raise ExecInterruptedError:
-            If the connection was disrupted before
-            receiving a reply from the server.
-        """
-        if not ('execute' in msg or 'exec-oob' in msg):
-            raise ValueError("Requires 'execute' or 'exec-oob' message")
-
-        # Copy the Message so that the ID assigned by _execute() is
-        # local to this method; allowing the ID to be seen in raised
-        # Exceptions but without modifying the caller's held copy.
-        msg = Message(msg)
-        reply = await self._execute(msg)
-
-        if 'error' in reply:
-            try:
-                error_response = ErrorResponse(reply)
-            except (KeyError, TypeError) as err:
-                # Error response was malformed.
-                raise BadReplyError(
-                    "QMP error reply is malformed", reply, msg,
-                ) from err
-
-            raise ExecuteError(error_response, msg, reply)
-
-        if 'return' not in reply:
-            raise BadReplyError(
-                "QMP reply is missing a 'error' or 'return' member",
-                reply, msg,
-            )
-
-        return reply['return']
-
-    @classmethod
-    def make_execute_msg(cls, cmd: str,
-                         arguments: Optional[Mapping[str, object]] = None,
-                         oob: bool = False) -> Message:
-        """
-        Create an executable message to be sent by `execute_msg` later.
-
-        :param cmd: QMP command name.
-        :param arguments: Arguments (if any). Must be JSON-serializable.
-        :param oob:
-            If `True`, execute "out of band". See `interop/qmp-spec`
-            section "Out-of-band execution".
-
-        :return: A QMP `Message` that can be executed with `execute_msg()`.
-        """
-        msg = Message({'exec-oob' if oob else 'execute': cmd})
-        if arguments is not None:
-            msg['arguments'] = arguments
-        return msg
-
-    @upper_half
-    async def execute(self, cmd: str,
-                      arguments: Optional[Mapping[str, object]] = None,
-                      oob: bool = False) -> object:
-        """
-        Execute a QMP command on the server and return its value.
-
-        :param cmd: QMP command name.
-        :param arguments: Arguments (if any). Must be JSON-serializable.
-        :param oob:
-            If `True`, execute "out of band". See `interop/qmp-spec`
-            section "Out-of-band execution".
-
-        :return:
-            The command execution return value from the server. The type of
-            object returned depends on the command that was issued,
-            though most in QEMU return a `dict`.
-        :raise ExecuteError: When the server returns an error response.
-        :raise ExecInterruptedError:
-            If the connection was disrupted before
-            receiving a reply from the server.
-        """
-        msg = self.make_execute_msg(cmd, arguments, oob=oob)
-        return await self.execute_msg(msg)
-
-    @upper_half
-    @require(Runstate.RUNNING)
-    def send_fd_scm(self, fd: int) -> None:
-        """Send a file descriptor to the remote via SCM_RIGHTS.
-
-        This method does not close the file descriptor.
-
-        :param fd: The file descriptor to send to QEMU.
-
-        This is an advanced feature of QEMU where file descriptors can
-        be passed from client to server. This is usually used as a
-        security measure to isolate the QEMU process from being able to
-        open its own files. See the QMP commands ``getfd`` and
-        ``add-fd`` for more information.
-
-        See `socket.socket.sendmsg` for more information on the Python
-        implementation for sending file descriptors over a UNIX socket.
-        """
-        assert self._writer is not None
-        sock = self._writer.transport.get_extra_info('socket')
-
-        if sock.family != socket.AF_UNIX:
-            raise QMPError("Sending file descriptors requires a UNIX socket.")
-
-        if not hasattr(sock, 'sendmsg'):
-            # We need to void the warranty sticker.
-            # Access to sendmsg is scheduled for removal in Python 3.11.
-            # Find the real backing socket to use it anyway.
-            sock = sock._sock  # pylint: disable=protected-access
-
-        sock.sendmsg(
-            [b' '],
-            [(socket.SOL_SOCKET, socket.SCM_RIGHTS, struct.pack('@i', fd))]
-        )
diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
deleted file mode 100644
index f8188005685..00000000000
--- a/python/qemu/qmp/qmp_shell.py
+++ /dev/null
@@ -1,689 +0,0 @@
-#
-# Copyright (C) 2009-2022 Red Hat Inc.
-#
-# Authors:
-#  Luiz Capitulino <lcapitulino@redhat.com>
-#  John Snow <jsnow@redhat.com>
-#
-# This work is licensed under the terms of the GNU LGPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-#
-
-"""
-qmp-shell - An interactive QEMU shell powered by QMP
-
-qmp-shell offers a simple shell with a convenient shorthand syntax as an
-alternative to typing JSON by hand. This syntax is not standardized and
-is not meant to be used as a scriptable interface. This shorthand *may*
-change incompatibly in the future, and it is strongly encouraged to use
-the QMP library to provide API-stable scripting when needed.
-
-usage: qmp-shell [-h] [-H] [-v] [-p] [-l LOGFILE] [-N] qmp_server
-
-positional arguments:
-  qmp_server            < UNIX socket path | TCP address:port >
-
-optional arguments:
-  -h, --help            show this help message and exit
-  -H, --hmp             Use HMP interface
-  -v, --verbose         Verbose (echo commands sent and received)
-  -p, --pretty          Pretty-print JSON
-  -l LOGFILE, --logfile LOGFILE
-                        Save log of all QMP messages to PATH
-  -N, --skip-negotiation
-                        Skip negotiate (for qemu-ga)
-
-Usage
------
-
-First, start QEMU with::
-
-    > qemu [...] -qmp unix:./qmp-sock,server=on[,wait=off]
-
-Then run the shell, passing the address of the socket::
-
-    > qmp-shell ./qmp-sock
-
-Syntax
-------
-
-Commands have the following format::
-
-    < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
-
-For example, to add a network device::
-
-    (QEMU) device_add driver=e1000 id=net1
-    {'return': {}}
-    (QEMU)
-
-key=value pairs support either Python or JSON object literal notations,
-**without spaces**. Dictionaries/objects ``{}`` are supported, as are
-arrays ``[]``::
-
-    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
-
-Either JSON or Python formatting for compound values works, including
-both styles of string literal quotes (either single or double
-quotes). Both paradigms of literal values are accepted, including
-``null/true/false`` for JSON and ``None/True/False`` for Python.
-
-Transactions
-------------
-
-Transactions have the following multi-line format::
-
-   transaction(
-   action-name1 [ arg-name1=arg1 ] ... [arg-nameN=argN ]
-   ...
-   action-nameN [ arg-name1=arg1 ] ... [arg-nameN=argN ]
-   )
-
-One line transactions are also supported::
-
-   transaction( action-name1 ... )
-
-For example::
-
-    (QEMU) transaction(
-    TRANS> block-dirty-bitmap-add node=drive0 name=bitmap1
-    TRANS> block-dirty-bitmap-clear node=drive0 name=bitmap0
-    TRANS> )
-    {"return": {}}
-    (QEMU)
-
-Commands
---------
-
-Autocomplete of command names using <tab> is supported. Pressing <tab>
-at a blank CLI prompt will show you a list of all available commands
-that the connected QEMU instance supports.
-
-For documentation on QMP commands and their arguments, please see
-`qmp ref`.
-
-Events
-------
-
-qmp-shell will display events received from the server, but this version
-does not do so asynchronously. To check for new events from the server,
-press <enter> on a blank line::
-
-    (QEMU) ⏎
-    {'timestamp': {'seconds': 1660071944, 'microseconds': 184667},
-     'event': 'STOP'}
-
-Display options
----------------
-
-Use the -v and -p options to activate the verbose and pretty-print
-options, which will echo back the properly formatted JSON-compliant QMP
-that is being sent to QEMU. This is useful for debugging to see the
-wire-level QMP data being exchanged, and generating output for use in
-writing documentation for QEMU.
-"""
-
-import argparse
-import ast
-import json
-import logging
-import os
-import re
-import readline
-from subprocess import Popen
-import sys
-from typing import (
-    IO,
-    Dict,
-    Iterator,
-    List,
-    NoReturn,
-    Optional,
-    Sequence,
-    cast,
-)
-
-from qemu.qmp import (
-    ConnectError,
-    ExecuteError,
-    QMPError,
-    SocketAddrT,
-)
-from qemu.qmp.legacy import (
-    QEMUMonitorProtocol,
-    QMPBadPortError,
-    QMPMessage,
-    QMPObject,
-)
-
-
-LOG = logging.getLogger(__name__)
-
-
-class QMPCompleter:
-    """
-    QMPCompleter provides a readline library tab-complete behavior.
-    """
-    # NB: Python 3.9+ will probably allow us to subclass list[str] directly,
-    # but pylint as of today does not know that List[str] is simply 'list'.
-    def __init__(self) -> None:
-        self._matches: List[str] = []
-
-    def append(self, value: str) -> None:
-        """Append a new valid completion to the list of possibilities."""
-        return self._matches.append(value)
-
-    def complete(self, text: str, state: int) -> Optional[str]:
-        """readline.set_completer() callback implementation."""
-        for cmd in self._matches:
-            if cmd.startswith(text):
-                if state == 0:
-                    return cmd
-                state -= 1
-        return None
-
-
-class QMPShellError(QMPError):
-    """
-    QMP Shell Base error class.
-    """
-
-
-class FuzzyJSON(ast.NodeTransformer):
-    """
-    This extension of ast.NodeTransformer filters literal "true/false/null"
-    values in a Python AST and replaces them by proper "True/False/None" values
-    that Python can properly evaluate.
-    """
-
-    @classmethod
-    def visit_Name(cls,  # pylint: disable=invalid-name
-                   node: ast.Name) -> ast.AST:
-        """
-        Transform Name nodes with certain values into Constant (keyword) nodes.
-        """
-        if node.id == 'true':
-            return ast.Constant(value=True)
-        if node.id == 'false':
-            return ast.Constant(value=False)
-        if node.id == 'null':
-            return ast.Constant(value=None)
-        return node
-
-
-class QMPShell(QEMUMonitorProtocol):
-    """
-    QMPShell provides a basic readline-based QMP shell.
-
-    :param address: Address of the QMP server.
-    :param pretty: Pretty-print QMP messages.
-    :param verbose: Echo outgoing QMP messages to console.
-    """
-    def __init__(self, address: SocketAddrT,
-                 pretty: bool = False,
-                 verbose: bool = False,
-                 server: bool = False,
-                 logfile: Optional[str] = None):
-        super().__init__(address, server=server)
-        self._greeting: Optional[QMPMessage] = None
-        self._completer = QMPCompleter()
-        self._transmode = False
-        self._actions: List[QMPMessage] = []
-        self._histfile = os.path.join(os.path.expanduser('~'),
-                                      '.qmp-shell_history')
-        self.pretty = pretty
-        self.verbose = verbose
-        self.logfile = None
-
-        if logfile is not None:
-            self.logfile = open(logfile, "w", encoding='utf-8')
-
-    def close(self) -> None:
-        # Hook into context manager of parent to save shell history.
-        self._save_history()
-        super().close()
-
-    def _fill_completion(self) -> None:
-        try:
-            cmds = cast(List[Dict[str, str]], self.cmd('query-commands'))
-            for cmd in cmds:
-                self._completer.append(cmd['name'])
-        except ExecuteError:
-            pass
-
-    def _completer_setup(self) -> None:
-        self._completer = QMPCompleter()
-        self._fill_completion()
-        readline.set_history_length(1024)
-        readline.set_completer(self._completer.complete)
-        readline.parse_and_bind("tab: complete")
-        # NB: default delimiters conflict with some command names
-        # (eg. query-), clearing everything as it doesn't seem to matter
-        readline.set_completer_delims('')
-        try:
-            readline.read_history_file(self._histfile)
-        except FileNotFoundError:
-            pass
-        except IOError as err:
-            msg = f"Failed to read history '{self._histfile}': {err!s}"
-            LOG.warning(msg)
-
-    def _save_history(self) -> None:
-        try:
-            readline.write_history_file(self._histfile)
-        except IOError as err:
-            msg = f"Failed to save history file '{self._histfile}': {err!s}"
-            LOG.warning(msg)
-
-    @classmethod
-    def _parse_value(cls, val: str) -> object:
-        try:
-            return int(val)
-        except ValueError:
-            pass
-
-        if val.lower() == 'true':
-            return True
-        if val.lower() == 'false':
-            return False
-        if val.startswith(('{', '[')):
-            # Try first as pure JSON:
-            try:
-                return json.loads(val)
-            except ValueError:
-                pass
-            # Try once again as FuzzyJSON:
-            try:
-                tree = ast.parse(val, mode='eval')
-                transformed = FuzzyJSON().visit(tree)
-                return ast.literal_eval(transformed)
-            except (SyntaxError, ValueError):
-                pass
-        return val
-
-    def _cli_expr(self,
-                  tokens: Sequence[str],
-                  parent: QMPObject) -> None:
-        for arg in tokens:
-            (key, sep, val) = arg.partition('=')
-            if sep != '=':
-                raise QMPShellError(
-                    f"Expected a key=value pair, got '{arg!s}'"
-                )
-
-            value = self._parse_value(val)
-            optpath = key.split('.')
-            curpath = []
-            for path in optpath[:-1]:
-                curpath.append(path)
-                obj = parent.get(path, {})
-                if not isinstance(obj, dict):
-                    msg = 'Cannot use "{:s}" as both leaf and non-leaf key'
-                    raise QMPShellError(msg.format('.'.join(curpath)))
-                parent[path] = obj
-                parent = obj
-            if optpath[-1] in parent:
-                if isinstance(parent[optpath[-1]], dict):
-                    msg = 'Cannot use "{:s}" as both leaf and non-leaf key'
-                    raise QMPShellError(msg.format('.'.join(curpath)))
-                raise QMPShellError(f'Cannot set "{key}" multiple times')
-            parent[optpath[-1]] = value
-
-    def _build_cmd(self, cmdline: str) -> Optional[QMPMessage]:
-        """
-        Build a QMP input object from a user provided command-line in the
-        following format:
-
-            < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
-        """
-        argument_regex = r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+'''
-        cmdargs = re.findall(argument_regex, cmdline)
-        qmpcmd: QMPMessage
-
-        # Transactional CLI entry:
-        if cmdargs and cmdargs[0] == 'transaction(':
-            self._transmode = True
-            self._actions = []
-            cmdargs.pop(0)
-
-        # Transactional CLI exit:
-        if cmdargs and cmdargs[0] == ')' and self._transmode:
-            self._transmode = False
-            if len(cmdargs) > 1:
-                msg = 'Unexpected input after close of Transaction sub-shell'
-                raise QMPShellError(msg)
-            qmpcmd = {
-                'execute': 'transaction',
-                'arguments': {'actions': self._actions}
-            }
-            return qmpcmd
-
-        # No args, or no args remaining
-        if not cmdargs:
-            return None
-
-        if self._transmode:
-            # Parse and cache this Transactional Action
-            finalize = False
-            action = {'type': cmdargs[0], 'data': {}}
-            if cmdargs[-1] == ')':
-                cmdargs.pop(-1)
-                finalize = True
-            self._cli_expr(cmdargs[1:], action['data'])
-            self._actions.append(action)
-            return self._build_cmd(')') if finalize else None
-
-        # Standard command: parse and return it to be executed.
-        qmpcmd = {'execute': cmdargs[0], 'arguments': {}}
-        self._cli_expr(cmdargs[1:], qmpcmd['arguments'])
-        return qmpcmd
-
-    def _print(self, qmp_message: object, fh: IO[str] = sys.stdout) -> None:
-        jsobj = json.dumps(qmp_message,
-                           indent=4 if self.pretty else None,
-                           sort_keys=self.pretty)
-        print(str(jsobj), file=fh)
-
-    def _execute_cmd(self, cmdline: str) -> bool:
-        try:
-            qmpcmd = self._build_cmd(cmdline)
-        except QMPShellError as err:
-            print(
-                f"Error while parsing command line: {err!s}\n"
-                "command format: <command-name> "
-                "[arg-name1=arg1] ... [arg-nameN=argN",
-                file=sys.stderr
-            )
-            return True
-        # For transaction mode, we may have just cached the action:
-        if qmpcmd is None:
-            return True
-        if self.verbose:
-            self._print(qmpcmd)
-        resp = self.cmd_obj(qmpcmd)
-        if resp is None:
-            print('Disconnected')
-            return False
-        self._print(resp)
-        if self.logfile is not None:
-            cmd = {**qmpcmd, **resp}
-            self._print(cmd, fh=self.logfile)
-        return True
-
-    def connect(self, negotiate: bool = True) -> None:
-        self._greeting = super().connect(negotiate)
-        self._completer_setup()
-
-    def show_banner(self,
-                    msg: str = 'Welcome to the QMP low-level shell!') -> None:
-        """
-        Print to stdio a greeting, and the QEMU version if available.
-        """
-        print(msg)
-        if not self._greeting:
-            print('Connected')
-            return
-        version = self._greeting['QMP']['version']['qemu']
-        print("Connected to QEMU {major}.{minor}.{micro}\n".format(**version))
-
-    @property
-    def prompt(self) -> str:
-        """
-        Return the current shell prompt, including a trailing space.
-        """
-        if self._transmode:
-            return 'TRANS> '
-        return '(QEMU) '
-
-    def read_exec_command(self) -> bool:
-        """
-        Read and execute a command.
-
-        @return True if execution was ok, return False if disconnected.
-        """
-        try:
-            cmdline = input(self.prompt)
-        except EOFError:
-            print()
-            return False
-
-        if cmdline == '':
-            for event in self.get_events():
-                print(event)
-            return True
-
-        return self._execute_cmd(cmdline)
-
-    def repl(self) -> Iterator[None]:
-        """
-        Return an iterator that implements the REPL.
-        """
-        self.show_banner()
-        while self.read_exec_command():
-            yield
-        self.close()
-
-
-class HMPShell(QMPShell):
-    """
-    HMPShell provides a basic readline-based HMP shell, tunnelled via QMP.
-
-    :param address: Address of the QMP server.
-    :param pretty: Pretty-print QMP messages.
-    :param verbose: Echo outgoing QMP messages to console.
-    """
-    def __init__(self, address: SocketAddrT,
-                 pretty: bool = False,
-                 verbose: bool = False,
-                 server: bool = False,
-                 logfile: Optional[str] = None):
-        super().__init__(address, pretty, verbose, server, logfile)
-        self._cpu_index = 0
-
-    def _cmd_completion(self) -> None:
-        for cmd in self._cmd_passthrough('help')['return'].split('\r\n'):
-            if cmd and cmd[0] != '[' and cmd[0] != '\t':
-                name = cmd.split()[0]  # drop help text
-                if name == 'info':
-                    continue
-                if name.find('|') != -1:
-                    # Command in the form 'foobar|f' or 'f|foobar', take the
-                    # full name
-                    opt = name.split('|')
-                    if len(opt[0]) == 1:
-                        name = opt[1]
-                    else:
-                        name = opt[0]
-                self._completer.append(name)
-                self._completer.append('help ' + name)  # help completion
-
-    def _info_completion(self) -> None:
-        for cmd in self._cmd_passthrough('info')['return'].split('\r\n'):
-            if cmd:
-                self._completer.append('info ' + cmd.split()[1])
-
-    def _other_completion(self) -> None:
-        # special cases
-        self._completer.append('help info')
-
-    def _fill_completion(self) -> None:
-        self._cmd_completion()
-        self._info_completion()
-        self._other_completion()
-
-    def _cmd_passthrough(self, cmdline: str,
-                         cpu_index: int = 0) -> QMPMessage:
-        return self.cmd_obj({
-            'execute': 'human-monitor-command',
-            'arguments': {
-                'command-line': cmdline,
-                'cpu-index': cpu_index
-            }
-        })
-
-    def _execute_cmd(self, cmdline: str) -> bool:
-        if cmdline.split()[0] == "cpu":
-            # trap the cpu command, it requires special setting
-            try:
-                idx = int(cmdline.split()[1])
-                if 'return' not in self._cmd_passthrough('info version', idx):
-                    print('bad CPU index')
-                    return True
-                self._cpu_index = idx
-            except ValueError:
-                print('cpu command takes an integer argument')
-                return True
-        resp = self._cmd_passthrough(cmdline, self._cpu_index)
-        if resp is None:
-            print('Disconnected')
-            return False
-        assert 'return' in resp or 'error' in resp
-        if 'return' in resp:
-            # Success
-            if len(resp['return']) > 0:
-                print(resp['return'], end=' ')
-        else:
-            # Error
-            print('%s: %s' % (resp['error']['class'], resp['error']['desc']))
-        return True
-
-    def show_banner(self, msg: str = 'Welcome to the HMP shell!') -> None:
-        QMPShell.show_banner(self, msg)
-
-
-def die(msg: str) -> NoReturn:
-    """Write an error to stderr, then exit with a return code of 1."""
-    sys.stderr.write('ERROR: %s\n' % msg)
-    sys.exit(1)
-
-
-def common_parser() -> argparse.ArgumentParser:
-    """Build common parsing options used by qmp-shell and qmp-shell-wrap."""
-    parser = argparse.ArgumentParser()
-    parser.add_argument('-H', '--hmp', action='store_true',
-                        help='Use HMP interface')
-    parser.add_argument('-v', '--verbose', action='store_true',
-                        help='Verbose (echo commands sent and received)')
-    parser.add_argument('-p', '--pretty', action='store_true',
-                        help='Pretty-print JSON')
-    parser.add_argument('-l', '--logfile',
-                        help='Save log of all QMP messages to PATH')
-    # NOTE: When changing arguments, update both this module docstring
-    # and the manpage synopsis in docs/man/qmp_shell.rst.
-    return parser
-
-
-def main() -> None:
-    """
-    qmp-shell entry point: parse command line arguments and start the REPL.
-    """
-    parser = common_parser()
-    parser.add_argument('-N', '--skip-negotiation', action='store_true',
-                        help='Skip negotiate (for qemu-ga)')
-
-    default_server = os.environ.get('QMP_SOCKET')
-    parser.add_argument('qmp_server', action='store',
-                        default=default_server,
-                        help='< UNIX socket path | TCP address:port >')
-
-    args = parser.parse_args()
-    if args.qmp_server is None:
-        parser.error("QMP socket or TCP address must be specified")
-
-    shell_class = HMPShell if args.hmp else QMPShell
-
-    try:
-        address = shell_class.parse_address(args.qmp_server)
-    except QMPBadPortError:
-        parser.error(f"Bad port number: {args.qmp_server}")
-        return  # pycharm doesn't know error() is noreturn
-
-    with shell_class(address, args.pretty, args.verbose, args.logfile) as qemu:
-        try:
-            qemu.connect(negotiate=not args.skip_negotiation)
-        except ConnectError as err:
-            if isinstance(err.exc, OSError):
-                die(f"Couldn't connect to {args.qmp_server}: {err!s}")
-            die(str(err))
-
-        for _ in qemu.repl():
-            pass
-
-
-def main_wrap() -> None:
-    """
-    qmp-shell-wrap - QEMU + qmp-shell launcher utility
-
-    Launch QEMU and connect to it with `qmp-shell` in a single command.
-    CLI arguments will be forwarded to qemu, with additional arguments
-    added to allow `qmp-shell` to then connect to the recently launched
-    QEMU instance.
-
-    usage: qmp-shell-wrap [-h] [-H] [-v] [-p] [-l LOGFILE] ...
-
-    positional arguments:
-      command               QEMU command line to invoke
-
-    optional arguments:
-      -h, --help            show this help message and exit
-      -H, --hmp             Use HMP interface
-      -v, --verbose         Verbose (echo commands sent and received)
-      -p, --pretty          Pretty-print JSON
-      -l LOGFILE, --logfile LOGFILE
-                            Save log of all QMP messages to PATH
-
-    Usage
-    -----
-
-    Prepend "qmp-shell-wrap" to your usual QEMU command line::
-
-        > qmp-shell-wrap qemu-system-x86_64 -M q35 -m 4096 -display none
-        Welcome to the QMP low-level shell!
-        Connected
-        (QEMU)
-    """
-    parser = common_parser()
-    parser.add_argument('command', nargs=argparse.REMAINDER,
-                        help='QEMU command line to invoke')
-
-    args = parser.parse_args()
-
-    cmd = args.command
-    if len(cmd) != 0 and cmd[0] == '--':
-        cmd = cmd[1:]
-    if len(cmd) == 0:
-        cmd = ["qemu-system-x86_64"]
-
-    sockpath = "qmp-shell-wrap-%d" % os.getpid()
-    cmd += ["-qmp", "unix:%s" % sockpath]
-
-    shell_class = HMPShell if args.hmp else QMPShell
-
-    try:
-        address = shell_class.parse_address(sockpath)
-    except QMPBadPortError:
-        parser.error(f"Bad port number: {sockpath}")
-        return  # pycharm doesn't know error() is noreturn
-
-    try:
-        with shell_class(address, args.pretty, args.verbose,
-                         True, args.logfile) as qemu:
-            with Popen(cmd):
-
-                try:
-                    qemu.accept()
-                except ConnectError as err:
-                    if isinstance(err.exc, OSError):
-                        die(f"Couldn't connect to {args.qmp_server}: {err!s}")
-                    die(str(err))
-
-                for _ in qemu.repl():
-                    pass
-    except FileNotFoundError:
-        sys.stderr.write(f"ERROR: QEMU executable '{cmd[0]}' not found.\n")
-    finally:
-        os.unlink(sockpath)
-
-
-if __name__ == '__main__':
-    main()
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
deleted file mode 100644
index d946c205131..00000000000
--- a/python/qemu/qmp/qmp_tui.py
+++ /dev/null
@@ -1,665 +0,0 @@
-# Copyright (c) 2021
-#
-# Authors:
-#  Niteesh Babu G S <niteesh.gs@gmail.com>
-#
-# This work is licensed under the terms of the GNU LGPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-"""
-QMP TUI
-
-QMP TUI is an asynchronous interface built on top the of the QMP library.
-It is the successor of QMP-shell and is bought-in as a replacement for it.
-
-Example Usage: qmp-tui <SOCKET | TCP IP:PORT>
-Full Usage: qmp-tui --help
-"""
-
-import argparse
-import asyncio
-import json
-import logging
-from logging import Handler, LogRecord
-import signal
-import sys
-from typing import (
-    List,
-    Optional,
-    Tuple,
-    Type,
-    Union,
-    cast,
-)
-
-
-try:
-    from pygments import lexers
-    from pygments import token as Token
-    import urwid
-    import urwid_readline
-except ModuleNotFoundError as exc:
-    print(
-        f"Module '{exc.name}' not found.",
-        "You need the optional 'tui' group: pip install qemu.qmp[tui]",
-        sep='\n',
-        file=sys.stderr,
-    )
-    sys.exit(1)
-
-from .error import ProtocolError
-from .legacy import QEMUMonitorProtocol, QMPBadPortError
-from .message import DeserializationError, Message, UnexpectedTypeError
-from .protocol import ConnectError, Runstate
-from .qmp_client import ExecInterruptedError, QMPClient
-from .util import get_or_create_event_loop, pretty_traceback
-
-
-# The name of the signal that is used to update the history list
-UPDATE_MSG: str = 'UPDATE_MSG'
-
-
-palette = [
-    (Token.Punctuation, '', '', '', 'h15,bold', 'g7'),
-    (Token.Text, '', '', '', '', 'g7'),
-    (Token.Name.Tag, '', '', '', 'bold,#f88', 'g7'),
-    (Token.Literal.Number.Integer, '', '', '', '#fa0', 'g7'),
-    (Token.Literal.String.Double, '', '', '', '#6f6', 'g7'),
-    (Token.Keyword.Constant, '', '', '', '#6af', 'g7'),
-    ('DEBUG', '', '', '', '#ddf', 'g7'),
-    ('INFO', '', '', '', 'g100', 'g7'),
-    ('WARNING', '', '', '', '#ff6', 'g7'),
-    ('ERROR', '', '', '', '#a00', 'g7'),
-    ('CRITICAL', '', '', '', '#a00', 'g7'),
-    ('background', '', 'black', '', '', 'g7'),
-]
-
-
-def format_json(msg: str) -> str:
-    """
-    Formats valid/invalid multi-line JSON message into a single-line message.
-
-    Formatting is first tried using the standard json module. If that fails
-    due to an decoding error then a simple string manipulation is done to
-    achieve a single line JSON string.
-
-    Converting into single line is more aesthetically pleasing when looking
-    along with error messages.
-
-    Eg:
-    Input:
-          [ 1,
-            true,
-            3 ]
-    The above input is not a valid QMP message and produces the following error
-    "QMP message is not a JSON object."
-    When displaying this in TUI in multiline mode we get
-
-        [ 1,
-          true,
-          3 ]: QMP message is not a JSON object.
-
-    whereas in singleline mode we get the following
-
-        [1, true, 3]: QMP message is not a JSON object.
-
-    The single line mode is more aesthetically pleasing.
-
-    :param msg:
-        The message to formatted into single line.
-
-    :return: Formatted singleline message.
-    """
-    try:
-        msg = json.loads(msg)
-        return str(json.dumps(msg))
-    except json.decoder.JSONDecodeError:
-        msg = msg.replace('\n', '')
-        words = msg.split(' ')
-        words = list(filter(None, words))
-        return ' '.join(words)
-
-
-def has_handler_type(logger: logging.Logger,
-                     handler_type: Type[Handler]) -> bool:
-    """
-    The Logger class has no interface to check if a certain type of handler is
-    installed or not. So we provide an interface to do so.
-
-    :param logger:
-        Logger object
-    :param handler_type:
-        The type of the handler to be checked.
-
-    :return: returns True if handler of type `handler_type`.
-    """
-    for handler in logger.handlers:
-        if isinstance(handler, handler_type):
-            return True
-    return False
-
-
-class App(QMPClient):
-    """
-    Implements the QMP TUI.
-
-    Initializes the widgets and starts the urwid event loop.
-
-    :param address:
-        Address of the server to connect to.
-    :param num_retries:
-        The number of times to retry before stopping to reconnect.
-    :param retry_delay:
-        The delay(sec) before each retry
-    """
-    def __init__(self, address: Union[str, Tuple[str, int]], num_retries: int,
-                 retry_delay: Optional[int]) -> None:
-        urwid.register_signal(type(self), UPDATE_MSG)
-        self.window = Window(self)
-        self.address = address
-        self.aloop: Optional[asyncio.AbstractEventLoop] = None
-        self.num_retries = num_retries
-        self.retry_delay = retry_delay if retry_delay else 2
-        self.retry: bool = False
-        self.exiting: bool = False
-        super().__init__()
-
-    def add_to_history(self, msg: str, level: Optional[str] = None) -> None:
-        """
-        Appends the msg to the history list.
-
-        :param msg:
-            The raw message to be appended in string type.
-        """
-        urwid.emit_signal(self, UPDATE_MSG, msg, level)
-
-    def _cb_outbound(self, msg: Message) -> Message:
-        """
-        Callback: outbound message hook.
-
-        Appends the outgoing messages to the history box.
-
-        :param msg: raw outbound message.
-        :return: final outbound message.
-        """
-        str_msg = str(msg)
-
-        if not has_handler_type(logging.getLogger(), TUILogHandler):
-            logging.debug('Request: %s', str_msg)
-        self.add_to_history('<-- ' + str_msg)
-        return msg
-
-    def _cb_inbound(self, msg: Message) -> Message:
-        """
-        Callback: outbound message hook.
-
-        Appends the incoming messages to the history box.
-
-        :param msg: raw inbound message.
-        :return: final inbound message.
-        """
-        str_msg = str(msg)
-
-        if not has_handler_type(logging.getLogger(), TUILogHandler):
-            logging.debug('Request: %s', str_msg)
-        self.add_to_history('--> ' + str_msg)
-        return msg
-
-    async def _send_to_server(self, msg: Message) -> None:
-        """
-        This coroutine sends the message to the server.
-        The message has to be pre-validated.
-
-        :param msg:
-            Pre-validated message to be to sent to the server.
-
-        :raise Exception: When an unhandled exception is caught.
-        """
-        try:
-            await self._raw(msg, assign_id='id' not in msg)
-        except ExecInterruptedError as err:
-            logging.info('Error server disconnected before reply %s', str(err))
-            self.add_to_history('Server disconnected before reply', 'ERROR')
-        except Exception as err:
-            logging.error('Exception from _send_to_server: %s', str(err))
-            raise err
-
-    def cb_send_to_server(self, raw_msg: str) -> None:
-        """
-        Validates and sends the message to the server.
-        The raw string message is first converted into a Message object
-        and is then sent to the server.
-
-        :param raw_msg:
-            The raw string message to be sent to the server.
-
-        :raise Exception: When an unhandled exception is caught.
-        """
-        try:
-            msg = Message(bytes(raw_msg, encoding='utf-8'))
-            asyncio.create_task(self._send_to_server(msg))
-        except (DeserializationError, UnexpectedTypeError) as err:
-            raw_msg = format_json(raw_msg)
-            logging.info('Invalid message: %s', err.error_message)
-            self.add_to_history(f'{raw_msg}: {err.error_message}', 'ERROR')
-
-    def unhandled_input(self, key: str) -> None:
-        """
-        Handle's keys which haven't been handled by the child widgets.
-
-        :param key:
-            Unhandled key
-        """
-        if key == 'esc':
-            self.kill_app()
-
-    def kill_app(self) -> None:
-        """
-        Initiates killing of app. A bridge between asynchronous and synchronous
-        code.
-        """
-        asyncio.create_task(self._kill_app())
-
-    async def _kill_app(self) -> None:
-        """
-        This coroutine initiates the actual disconnect process and calls
-        urwid.ExitMainLoop() to kill the TUI.
-
-        :raise Exception: When an unhandled exception is caught.
-        """
-        self.exiting = True
-        await self.disconnect()
-        logging.debug('Disconnect finished. Exiting app')
-        raise urwid.ExitMainLoop()
-
-    async def disconnect(self) -> None:
-        """
-        Overrides the disconnect method to handle the errors locally.
-        """
-        try:
-            await super().disconnect()
-        except (OSError, EOFError) as err:
-            logging.info('disconnect: %s', str(err))
-            self.retry = True
-        except ProtocolError as err:
-            logging.info('disconnect: %s', str(err))
-        except Exception as err:
-            logging.error('disconnect: Unhandled exception %s', str(err))
-            raise err
-
-    def _set_status(self, msg: str) -> None:
-        """
-        Sets the message as the status.
-
-        :param msg:
-            The message to be displayed in the status bar.
-        """
-        self.window.footer.set_text(msg)
-
-    def _get_formatted_address(self) -> str:
-        """
-        Returns a formatted version of the server's address.
-
-        :return: formatted address
-        """
-        if isinstance(self.address, tuple):
-            host, port = self.address
-            addr = f'{host}:{port}'
-        else:
-            addr = f'{self.address}'
-        return addr
-
-    async def _initiate_connection(self) -> Optional[ConnectError]:
-        """
-        Tries connecting to a server a number of times with a delay between
-        each try. If all retries failed then return the error faced during
-        the last retry.
-
-        :return: Error faced during last retry.
-        """
-        current_retries = 0
-        err = None
-
-        # initial try
-        await self.connect_server()
-        while self.retry and current_retries < self.num_retries:
-            logging.info('Connection Failed, retrying in %d', self.retry_delay)
-            status = f'[Retry #{current_retries} ({self.retry_delay}s)]'
-            self._set_status(status)
-
-            await asyncio.sleep(self.retry_delay)
-
-            err = await self.connect_server()
-            current_retries += 1
-        # If all retries failed report the last error
-        if err:
-            logging.info('All retries failed: %s', err)
-            return err
-        return None
-
-    async def manage_connection(self) -> None:
-        """
-        Manage the connection based on the current run state.
-
-        A reconnect is issued when the current state is IDLE and the number
-        of retries is not exhausted.
-        A disconnect is issued when the current state is DISCONNECTING.
-        """
-        while not self.exiting:
-            if self.runstate == Runstate.IDLE:
-                err = await self._initiate_connection()
-                # If retry is still true then, we have exhausted all our tries.
-                if err:
-                    self._set_status(f'[Error: {err.error_message}]')
-                else:
-                    addr = self._get_formatted_address()
-                    self._set_status(f'[Connected {addr}]')
-            elif self.runstate == Runstate.DISCONNECTING:
-                self._set_status('[Disconnected]')
-                await self.disconnect()
-                # check if a retry is needed
-                # mypy 1.4.0 doesn't believe runstate can change after
-                # disconnect(), hence the cast.
-                state = cast(Runstate, self.runstate)
-                if state == Runstate.IDLE:
-                    continue
-            await self.runstate_changed()
-
-    async def connect_server(self) -> Optional[ConnectError]:
-        """
-        Initiates a connection to the server at address `self.address`
-        and in case of a failure, sets the status to the respective error.
-        """
-        try:
-            await self.connect(self.address)
-            self.retry = False
-        except ConnectError as err:
-            logging.info('connect_server: ConnectError %s', str(err))
-            self.retry = True
-            return err
-        return None
-
-    def run(self, debug: bool = False) -> None:
-        """
-        Starts the long running co-routines and the urwid event loop.
-
-        :param debug:
-            Enables/Disables asyncio event loop debugging
-        """
-        screen = urwid.raw_display.Screen()
-        screen.set_terminal_properties(256)
-        self.aloop = get_or_create_event_loop()
-        self.aloop.set_debug(debug)
-
-        # Gracefully handle SIGTERM and SIGINT signals
-        cancel_signals = [signal.SIGTERM, signal.SIGINT]
-        for sig in cancel_signals:
-            self.aloop.add_signal_handler(sig, self.kill_app)
-
-        event_loop = urwid.AsyncioEventLoop(loop=self.aloop)
-        main_loop = urwid.MainLoop(urwid.AttrMap(self.window, 'background'),
-                                   unhandled_input=self.unhandled_input,
-                                   screen=screen,
-                                   palette=palette,
-                                   handle_mouse=True,
-                                   event_loop=event_loop)
-
-        self.aloop.create_task(self.manage_connection())
-        try:
-            main_loop.run()
-        except Exception as err:
-            logging.error('%s\n%s\n', str(err), pretty_traceback())
-            raise err
-
-
-class StatusBar(urwid.Text):
-    """
-    A simple statusbar modelled using the Text widget. The status can be
-    set using the set_text function. All text set is aligned to right.
-
-    :param text: Initial text to be displayed. Default is empty str.
-    """
-    def __init__(self, text: str = ''):
-        super().__init__(text, align='right')
-
-
-class Editor(urwid_readline.ReadlineEdit):
-    """
-    A simple editor modelled using the urwid_readline.ReadlineEdit widget.
-    Mimcs GNU readline shortcuts and provides history support.
-
-    The readline shortcuts can be found below:
-    https://github.com/rr-/urwid_readline#features
-
-    Along with the readline features, this editor also has support for
-    history. Pressing the 'up'/'down' switches between the prev/next messages
-    available in the history.
-
-    Currently there is no support to save the history to a file. The history of
-    previous commands is lost on exit.
-
-    :param parent: Reference to the TUI object.
-    """
-    def __init__(self, parent: App) -> None:
-        super().__init__(caption='> ', multiline=True)
-        self.parent = parent
-        self.history: List[str] = []
-        self.last_index: int = -1
-        self.show_history: bool = False
-
-    def keypress(self, size: Tuple[int, int], key: str) -> Optional[str]:
-        """
-        Handles the keypress on this widget.
-
-        :param size:
-            The current size of the widget.
-        :param key:
-            The key to be handled.
-
-        :return: Unhandled key if any.
-        """
-        msg = self.get_edit_text()
-        if key == 'up' and not msg:
-            # Show the history when 'up arrow' is pressed with no input text.
-            # NOTE: The show_history logic is necessary because in 'multiline'
-            # mode (which we use) 'up arrow' is used to move between lines.
-            if not self.history:
-                return None
-            self.show_history = True
-            last_msg = self.history[self.last_index]
-            self.set_edit_text(last_msg)
-            self.edit_pos = len(last_msg)
-        elif key == 'up' and self.show_history:
-            self.last_index = max(self.last_index - 1, -len(self.history))
-            self.set_edit_text(self.history[self.last_index])
-            self.edit_pos = len(self.history[self.last_index])
-        elif key == 'down' and self.show_history:
-            if self.last_index == -1:
-                self.set_edit_text('')
-                self.show_history = False
-            else:
-                self.last_index += 1
-                self.set_edit_text(self.history[self.last_index])
-                self.edit_pos = len(self.history[self.last_index])
-        elif key == 'meta enter':
-            # When using multiline, enter inserts a new line into the editor
-            # send the input to the server on alt + enter
-            self.parent.cb_send_to_server(msg)
-            self.history.append(msg)
-            self.set_edit_text('')
-            self.last_index = -1
-            self.show_history = False
-        else:
-            self.show_history = False
-            self.last_index = -1
-            return cast(Optional[str], super().keypress(size, key))
-        return None
-
-
-class EditorWidget(urwid.Filler):
-    """
-    Wrapper around the editor widget.
-
-    The Editor is a flow widget and has to wrapped inside a box widget.
-    This class wraps the Editor inside filler widget.
-
-    :param parent: Reference to the TUI object.
-    """
-    def __init__(self, parent: App) -> None:
-        super().__init__(Editor(parent), valign='top')
-
-
-class HistoryBox(urwid.ListBox):
-    """
-    This widget is modelled using the ListBox widget, contains the list of
-    all messages both QMP messages and log messages to be shown in the TUI.
-
-    The messages are urwid.Text widgets. On every append of a message, the
-    focus is shifted to the last appended message.
-
-    :param parent: Reference to the TUI object.
-    """
-    def __init__(self, parent: App) -> None:
-        self.parent = parent
-        self.history = urwid.SimpleFocusListWalker([])
-        super().__init__(self.history)
-
-    def add_to_history(self,
-                       history: Union[str, List[Tuple[str, str]]]) -> None:
-        """
-        Appends a message to the list and set the focus to the last appended
-        message.
-
-        :param history:
-            The history item(message/event) to be appended to the list.
-        """
-        self.history.append(urwid.Text(history))
-        self.history.set_focus(len(self.history) - 1)
-
-    def mouse_event(self, size: Tuple[int, int], _event: str, button: float,
-                    _x: int, _y: int, focus: bool) -> None:
-        # Unfortunately there are no urwid constants that represent the mouse
-        # events.
-        if button == 4:  # Scroll up event
-            super().keypress(size, 'up')
-        elif button == 5:  # Scroll down event
-            super().keypress(size, 'down')
-
-
-class HistoryWindow(urwid.Frame):
-    """
-    This window composes the HistoryBox and EditorWidget in a horizontal split.
-    By default the first focus is given to the history box.
-
-    :param parent: Reference to the TUI object.
-    """
-    def __init__(self, parent: App) -> None:
-        self.parent = parent
-        self.editor_widget = EditorWidget(parent)
-        self.editor = urwid.LineBox(self.editor_widget)
-        self.history = HistoryBox(parent)
-        self.body = urwid.Pile([('weight', 80, self.history),
-                                ('weight', 20, self.editor)])
-        super().__init__(self.body)
-        urwid.connect_signal(self.parent, UPDATE_MSG, self.cb_add_to_history)
-
-    def cb_add_to_history(self, msg: str, level: Optional[str] = None) -> None:
-        """
-        Appends a message to the history box
-
-        :param msg:
-            The message to be appended to the history box.
-        :param level:
-            The log level of the message, if it is a log message.
-        """
-        formatted = []
-        if level:
-            msg = f'[{level}]: {msg}'
-            formatted.append((level, msg))
-        else:
-            lexer = lexers.JsonLexer()  # pylint: disable=no-member
-            for token in lexer.get_tokens(msg):
-                formatted.append(token)
-        self.history.add_to_history(formatted)
-
-
-class Window(urwid.Frame):
-    """
-    This window is the top most widget of the TUI and will contain other
-    windows. Each child of this widget is responsible for displaying a specific
-    functionality.
-
-    :param parent: Reference to the TUI object.
-    """
-    def __init__(self, parent: App) -> None:
-        self.parent = parent
-        footer = StatusBar()
-        body = HistoryWindow(parent)
-        super().__init__(body, footer=footer)
-
-
-class TUILogHandler(Handler):
-    """
-    This handler routes all the log messages to the TUI screen.
-    It is installed to the root logger to so that the log message from all
-    libraries begin used is routed to the screen.
-
-    :param tui: Reference to the TUI object.
-    """
-    def __init__(self, tui: App) -> None:
-        super().__init__()
-        self.tui = tui
-
-    def emit(self, record: LogRecord) -> None:
-        """
-        Emits a record to the TUI screen.
-
-        Appends the log message to the TUI screen
-        """
-        level = record.levelname
-        msg = record.getMessage()
-        self.tui.add_to_history(msg, level)
-
-
-def main() -> None:
-    """
-    Driver of the whole script, parses arguments, initialize the TUI and
-    the logger.
-    """
-    parser = argparse.ArgumentParser(description='QMP TUI')
-    parser.add_argument('qmp_server', help='Address of the QMP server. '
-                        'Format <UNIX socket path | TCP addr:port>')
-    parser.add_argument('--num-retries', type=int, default=10,
-                        help='Number of times to reconnect before giving up.')
-    parser.add_argument('--retry-delay', type=int,
-                        help='Time(s) to wait before next retry. '
-                        'Default action is to wait 2s between each retry.')
-    parser.add_argument('--log-file', help='The Log file name')
-    parser.add_argument('--log-level', default='WARNING',
-                        help='Log level <CRITICAL|ERROR|WARNING|INFO|DEBUG|>')
-    parser.add_argument('--asyncio-debug', action='store_true',
-                        help='Enable debug mode for asyncio loop. '
-                        'Generates lot of output, makes TUI unusable when '
-                        'logs are logged in the TUI. '
-                        'Use only when logging to a file.')
-    args = parser.parse_args()
-
-    try:
-        address = QEMUMonitorProtocol.parse_address(args.qmp_server)
-    except QMPBadPortError as err:
-        parser.error(str(err))
-
-    app = App(address, args.num_retries, args.retry_delay)
-
-    root_logger = logging.getLogger()
-    root_logger.setLevel(logging.getLevelName(args.log_level))
-
-    if args.log_file:
-        root_logger.addHandler(logging.FileHandler(args.log_file))
-    else:
-        root_logger.addHandler(TUILogHandler(app))
-
-    app.run(args.asyncio_debug)
-
-
-if __name__ == '__main__':
-    main()
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
deleted file mode 100644
index a8229e55245..00000000000
--- a/python/qemu/qmp/util.py
+++ /dev/null
@@ -1,150 +0,0 @@
-"""
-Miscellaneous Utilities
-
-This module provides asyncio and various logging and debugging
-utilities, such as `exception_summary()` and `pretty_traceback()`, used
-primarily for adding information into the logging stream.
-"""
-
-import asyncio
-import sys
-import traceback
-from typing import TypeVar, cast
-import warnings
-
-
-T = TypeVar('T')
-
-
-# --------------------------
-# Section: Utility Functions
-# --------------------------
-
-
-def get_or_create_event_loop() -> asyncio.AbstractEventLoop:
-    """
-    Return this thread's current event loop, or create a new one.
-
-    This function behaves similarly to asyncio.get_event_loop() in
-    Python<=3.13, where if there is no event loop currently associated
-    with the current context, it will create and register one. It should
-    generally not be used in any asyncio-native applications.
-    """
-    try:
-        with warnings.catch_warnings():
-            # Python <= 3.13 will trigger deprecation warnings if no
-            # event loop is set, but will create and set a new loop.
-            warnings.simplefilter("ignore")
-            loop = asyncio.get_event_loop()
-    except RuntimeError:
-        # Python 3.14+: No event loop set for this thread,
-        # create and set one.
-        loop = asyncio.new_event_loop()
-        # Set this loop as the current thread's loop, to be returned
-        # by calls to get_event_loop() in the future.
-        asyncio.set_event_loop(loop)
-
-    return loop
-
-
-async def flush(writer: asyncio.StreamWriter) -> None:
-    """
-    Utility function to ensure an `asyncio.StreamWriter` is *fully* drained.
-
-    `asyncio.StreamWriter.drain` only promises we will return to below
-    the "high-water mark". This function ensures we flush the entire
-    buffer -- by setting the high water mark to 0 and then calling
-    drain. The flow control limits are restored after the call is
-    completed.
-    """
-    transport = cast(  # type: ignore[redundant-cast]
-        asyncio.WriteTransport, writer.transport
-    )
-
-    # https://github.com/python/typeshed/issues/5779
-    low, high = transport.get_write_buffer_limits()  # type: ignore
-    transport.set_write_buffer_limits(0, 0)
-    try:
-        await writer.drain()
-    finally:
-        transport.set_write_buffer_limits(high, low)
-
-
-def upper_half(func: T) -> T:
-    """
-    Do-nothing decorator that annotates a method as an "upper-half" method.
-
-    These methods must not call bottom-half functions directly, but can
-    schedule them to run.
-    """
-    return func
-
-
-def bottom_half(func: T) -> T:
-    """
-    Do-nothing decorator that annotates a method as a "bottom-half" method.
-
-    These methods must take great care to handle their own exceptions whenever
-    possible. If they go unhandled, they will cause termination of the loop.
-
-    These methods do not, in general, have the ability to directly
-    report information to a caller’s context and will usually be
-    collected as an `asyncio.Task` result instead.
-
-    They must not call upper-half functions directly.
-    """
-    return func
-
-
-# ----------------------------
-# Section: Logging & Debugging
-# ----------------------------
-
-
-def exception_summary(exc: BaseException) -> str:
-    """
-    Return a summary string of an arbitrary exception.
-
-    It will be of the form "ExceptionType: Error Message" if the error
-    string is non-empty, and just "ExceptionType" otherwise.
-
-    This code is based on CPython's implementation of
-    `traceback.TracebackException.format_exception_only`.
-    """
-    name = type(exc).__qualname__
-    smod = type(exc).__module__
-    if smod not in ("__main__", "builtins"):
-        name = smod + '.' + name
-
-    error = str(exc)
-    if error:
-        return f"{name}: {error}"
-    return name
-
-
-def pretty_traceback(prefix: str = "  | ") -> str:
-    """
-    Formats the current traceback, indented to provide visual distinction.
-
-    This is useful for printing a traceback within a traceback for
-    debugging purposes when encapsulating errors to deliver them up the
-    stack; when those errors are printed, this helps provide a nice
-    visual grouping to quickly identify the parts of the error that
-    belong to the inner exception.
-
-    :param prefix: The prefix to append to each line of the traceback.
-    :return: A string, formatted something like the following::
-
-      | Traceback (most recent call last):
-      |   File "foobar.py", line 42, in arbitrary_example
-      |     foo.baz()
-      | ArbitraryError: [Errno 42] Something bad happened!
-    """
-    output = "".join(traceback.format_exception(*sys.exc_info()))
-
-    exc_lines = []
-    for line in output.split('\n'):
-        exc_lines.append(prefix + line)
-
-    # The last line is always empty, omit it
-    return "\n".join(exc_lines[:-1])
diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
index cf7e344bd53..e377ef6942f 100644
--- a/python/qemu/utils/qom_fuse.py
+++ b/python/qemu/utils/qom_fuse.py
@@ -47,7 +47,6 @@
 
 import fuse
 from fuse import FUSE, FuseOSError, Operations
-
 from qemu.qmp import ExecuteError
 
 from .qom_common import QOMCommand
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 33ac7a45de0..36cd27046e7 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -43,6 +43,8 @@ def main() -> int:
     packages = {
         "meson==1.9.0":
         "45e51ddc41e37d961582d06e78c48e0f9039011587f3495c4d6b0781dad92357",
+        "qemu.qmp==0.0.5":
+        "e05782d6df5844b34e0d2f7c68693525da074deef7b641c1401dda6e4e3d6303",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
diff --git a/python/setup.cfg b/python/setup.cfg
index f40f11396c9..c46a95f8d41 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -24,9 +24,10 @@ classifiers =
 [options]
 python_requires = >= 3.9
 packages =
-    qemu.qmp
     qemu.machine
     qemu.utils
+install_requires =
+    qemu.qmp
 
 [options.package_data]
 * = py.typed
@@ -38,26 +39,17 @@ devel =
     distlib >= 0.3.6
     flake8 >= 5.0.4
     fusepy >= 2.0.4
-    isort >= 5.1.2
+    isort >= 5.6.0
     mypy >= 1.4.0
     pylint >= 2.17.3
     pylint != 3.2.4; python_version<"3.9"
     tox >= 3.18.0
-    urwid >= 2.1.2
-    urwid-readline >= 0.13
-    Pygments >= 2.9.0
     sphinx >= 3.4.3
 
 # Provides qom-fuse functionality
 fuse =
     fusepy >= 2.0.4
 
-# QMP TUI dependencies
-tui =
-    urwid >= 2.1.2
-    urwid-readline >= 0.13
-    Pygments >= 2.9.0
-
 [options.entry_points]
 console_scripts =
     qom = qemu.utils.qom:main
@@ -67,9 +59,6 @@ console_scripts =
     qom-tree = qemu.utils.qom:QOMTree.entry_point
     qom-fuse = qemu.utils.qom_fuse:QOMFuse.entry_point [fuse]
     qemu-ga-client = qemu.utils.qemu_ga_client:main
-    qmp-shell = qemu.qmp.qmp_shell:main
-    qmp-shell-wrap = qemu.qmp.qmp_shell:main_wrap
-    qmp-tui = qemu.qmp.qmp_tui:main [tui]
 
 [flake8]
 # Prefer pylint's bare-except checks to flake8's
@@ -86,10 +75,6 @@ warn_unused_ignores = False
 # fusepy has no type stubs:
 allow_subclassing_any = True
 
-[mypy-qemu.qmp.qmp_tui]
-# urwid and urwid_readline have no type stubs:
-allow_subclassing_any = True
-
 # The following missing import directives are because these libraries do not
 # provide type stubs. Allow them on an as-needed basis for mypy.
 [mypy-fuse]
@@ -101,15 +86,6 @@ ignore_missing_imports = True
 [mypy-tomllib]
 ignore_missing_imports = True
 
-[mypy-urwid]
-ignore_missing_imports = True
-
-[mypy-urwid_readline]
-ignore_missing_imports = True
-
-[mypy-pygments]
-ignore_missing_imports = True
-
 [mypy-distlib]
 ignore_missing_imports = True
 
@@ -194,7 +170,6 @@ allowlist_externals = make
 deps =
     .[devel]
     .[fuse]  # Workaround to trigger tox venv rebuild
-    .[tui]   # Workaround to trigger tox venv rebuild
 commands =
     make check
 
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index cd2e2a81c3d..855b5129c94 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -20,10 +20,8 @@ setuptools<=70
 # Dependencies for qapidoc/qapi_domain et al
 sphinx==3.4.3
 
-# Dependencies for the TUI addon (Required for successful linting)
-urwid==2.1.2
-urwid-readline==0.13
-Pygments==2.9.0
+# Dependencies for qemu.machine
+qemu.qmp==0.0.5
 
 # Dependencies for mkvenv
 distlib==0.3.6
@@ -36,7 +34,7 @@ avocado-framework==90.0
 
 # Linters
 flake8==5.0.4
-isort==5.1.2
+isort==5.6.0
 mypy==1.4.0
 pylint==2.17.3
 
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
deleted file mode 100644
index e565802516d..00000000000
--- a/python/tests/protocol.py
+++ /dev/null
@@ -1,596 +0,0 @@
-import asyncio
-from contextlib import contextmanager
-import os
-import socket
-from tempfile import TemporaryDirectory
-
-import avocado
-
-from qemu.qmp import ConnectError, Runstate
-from qemu.qmp.protocol import AsyncProtocol, StateError
-
-
-class NullProtocol(AsyncProtocol[None]):
-    """
-    NullProtocol is a test mockup of an AsyncProtocol implementation.
-
-    It adds a fake_session instance variable that enables a code path
-    that bypasses the actual connection logic, but still allows the
-    reader/writers to start.
-
-    Because the message type is defined as None, an asyncio.Event named
-    'trigger_input' is created that prohibits the reader from
-    incessantly being able to yield None; this event can be poked to
-    simulate an incoming message.
-
-    For testing symmetry with do_recv, an interface is added to "send" a
-    Null message.
-
-    For testing purposes, a "simulate_disconnection" method is also
-    added which allows us to trigger a bottom half disconnect without
-    injecting any real errors into the reader/writer loops; in essence
-    it performs exactly half of what disconnect() normally does.
-    """
-    def __init__(self, name=None):
-        self.fake_session = False
-        self.trigger_input: asyncio.Event
-        super().__init__(name)
-
-    async def _establish_session(self):
-        self.trigger_input = asyncio.Event()
-        await super()._establish_session()
-
-    async def _do_start_server(self, address, ssl=None):
-        if self.fake_session:
-            self._accepted = asyncio.Event()
-            self._set_state(Runstate.CONNECTING)
-            await asyncio.sleep(0)
-        else:
-            await super()._do_start_server(address, ssl)
-
-    async def _do_accept(self):
-        if self.fake_session:
-            self._accepted = None
-        else:
-            await super()._do_accept()
-
-    async def _do_connect(self, address, ssl=None):
-        if self.fake_session:
-            self._set_state(Runstate.CONNECTING)
-            await asyncio.sleep(0)
-        else:
-            await super()._do_connect(address, ssl)
-
-    async def _do_recv(self) -> None:
-        await self.trigger_input.wait()
-        self.trigger_input.clear()
-
-    def _do_send(self, msg: None) -> None:
-        pass
-
-    async def send_msg(self) -> None:
-        await self._outgoing.put(None)
-
-    async def simulate_disconnect(self) -> None:
-        """
-        Simulates a bottom-half disconnect.
-
-        This method schedules a disconnection but does not wait for it
-        to complete. This is used to put the loop into the DISCONNECTING
-        state without fully quiescing it back to IDLE. This is normally
-        something you cannot coax AsyncProtocol to do on purpose, but it
-        will be similar to what happens with an unhandled Exception in
-        the reader/writer.
-
-        Under normal circumstances, the library design requires you to
-        await on disconnect(), which awaits the disconnect task and
-        returns bottom half errors as a pre-condition to allowing the
-        loop to return back to IDLE.
-        """
-        self._schedule_disconnect()
-
-
-class LineProtocol(AsyncProtocol[str]):
-    def __init__(self, name=None):
-        super().__init__(name)
-        self.rx_history = []
-
-    async def _do_recv(self) -> str:
-        raw = await self._readline()
-        msg = raw.decode()
-        self.rx_history.append(msg)
-        return msg
-
-    def _do_send(self, msg: str) -> None:
-        assert self._writer is not None
-        self._writer.write(msg.encode() + b'\n')
-
-    async def send_msg(self, msg: str) -> None:
-        await self._outgoing.put(msg)
-
-
-def run_as_task(coro, allow_cancellation=False):
-    """
-    Run a given coroutine as a task.
-
-    Optionally, wrap it in a try..except block that allows this
-    coroutine to be canceled gracefully.
-    """
-    async def _runner():
-        try:
-            await coro
-        except asyncio.CancelledError:
-            if allow_cancellation:
-                return
-            raise
-    return asyncio.create_task(_runner())
-
-
-@contextmanager
-def jammed_socket():
-    """
-    Opens up a random unused TCP port on localhost, then jams it.
-    """
-    socks = []
-
-    try:
-        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
-        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
-        sock.bind(('127.0.0.1', 0))
-        sock.listen(1)
-        address = sock.getsockname()
-
-        socks.append(sock)
-
-        # I don't *fully* understand why, but it takes *two* un-accepted
-        # connections to start jamming the socket.
-        for _ in range(2):
-            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
-            sock.connect(address)
-            socks.append(sock)
-
-        yield address
-
-    finally:
-        for sock in socks:
-            sock.close()
-
-
-class Smoke(avocado.Test):
-
-    def setUp(self):
-        self.proto = NullProtocol()
-
-    def test__repr__(self):
-        self.assertEqual(
-            repr(self.proto),
-            "<NullProtocol runstate=IDLE>"
-        )
-
-    def testRunstate(self):
-        self.assertEqual(
-            self.proto.runstate,
-            Runstate.IDLE
-        )
-
-    def testDefaultName(self):
-        self.assertEqual(
-            self.proto.name,
-            None
-        )
-
-    def testLogger(self):
-        self.assertEqual(
-            self.proto.logger.name,
-            'qemu.qmp.protocol'
-        )
-
-    def testName(self):
-        self.proto = NullProtocol('Steve')
-
-        self.assertEqual(
-            self.proto.name,
-            'Steve'
-        )
-
-        self.assertEqual(
-            self.proto.logger.name,
-            'qemu.qmp.protocol.Steve'
-        )
-
-        self.assertEqual(
-            repr(self.proto),
-            "<NullProtocol name='Steve' runstate=IDLE>"
-        )
-
-
-class TestBase(avocado.Test):
-
-    def setUp(self):
-        self.proto = NullProtocol(type(self).__name__)
-        self.assertEqual(self.proto.runstate, Runstate.IDLE)
-        self.runstate_watcher = None
-
-    def tearDown(self):
-        self.assertEqual(self.proto.runstate, Runstate.IDLE)
-
-    async def _asyncSetUp(self):
-        pass
-
-    async def _asyncTearDown(self):
-        if self.runstate_watcher:
-            await self.runstate_watcher
-
-    @staticmethod
-    def async_test(async_test_method):
-        """
-        Decorator; adds SetUp and TearDown to async tests.
-        """
-        async def _wrapper(self, *args, **kwargs):
-            loop = asyncio.get_running_loop()
-            loop.set_debug(True)
-
-            await self._asyncSetUp()
-            await async_test_method(self, *args, **kwargs)
-            await self._asyncTearDown()
-
-        return _wrapper
-
-    # Definitions
-
-    # The states we expect a "bad" connect/accept attempt to transition through
-    BAD_CONNECTION_STATES = (
-        Runstate.CONNECTING,
-        Runstate.DISCONNECTING,
-        Runstate.IDLE,
-    )
-
-    # The states we expect a "good" session to transition through
-    GOOD_CONNECTION_STATES = (
-        Runstate.CONNECTING,
-        Runstate.RUNNING,
-        Runstate.DISCONNECTING,
-        Runstate.IDLE,
-    )
-
-    # Helpers
-
-    async def _watch_runstates(self, *states):
-        """
-        This launches a task alongside (most) tests below to confirm that
-        the sequence of runstate changes that occur is exactly as
-        anticipated.
-        """
-        async def _watcher():
-            for state in states:
-                new_state = await self.proto.runstate_changed()
-                self.assertEqual(
-                    new_state,
-                    state,
-                    msg=f"Expected state '{state.name}'",
-                )
-
-        self.runstate_watcher = asyncio.create_task(_watcher())
-        # Kick the loop and force the task to block on the event.
-        await asyncio.sleep(0)
-
-
-class State(TestBase):
-
-    @TestBase.async_test
-    async def testSuperfluousDisconnect(self):
-        """
-        Test calling disconnect() while already disconnected.
-        """
-        await self._watch_runstates(
-            Runstate.DISCONNECTING,
-            Runstate.IDLE,
-        )
-        await self.proto.disconnect()
-
-
-class Connect(TestBase):
-    """
-    Tests primarily related to calling Connect().
-    """
-    async def _bad_connection(self, family: str):
-        assert family in ('INET', 'UNIX')
-
-        if family == 'INET':
-            await self.proto.connect(('127.0.0.1', 0))
-        elif family == 'UNIX':
-            await self.proto.connect('/dev/null')
-
-    async def _hanging_connection(self):
-        with jammed_socket() as addr:
-            await self.proto.connect(addr)
-
-    async def _bad_connection_test(self, family: str):
-        await self._watch_runstates(*self.BAD_CONNECTION_STATES)
-
-        with self.assertRaises(ConnectError) as context:
-            await self._bad_connection(family)
-
-        self.assertIsInstance(context.exception.exc, OSError)
-        self.assertEqual(
-            context.exception.error_message,
-            "Failed to establish connection"
-        )
-
-    @TestBase.async_test
-    async def testBadINET(self):
-        """
-        Test an immediately rejected call to an IP target.
-        """
-        await self._bad_connection_test('INET')
-
-    @TestBase.async_test
-    async def testBadUNIX(self):
-        """
-        Test an immediately rejected call to a UNIX socket target.
-        """
-        await self._bad_connection_test('UNIX')
-
-    @TestBase.async_test
-    async def testCancellation(self):
-        """
-        Test what happens when a connection attempt is aborted.
-        """
-        # Note that accept() cannot be cancelled outright, as it isn't a task.
-        # However, we can wrap it in a task and cancel *that*.
-        await self._watch_runstates(*self.BAD_CONNECTION_STATES)
-        task = run_as_task(self._hanging_connection(), allow_cancellation=True)
-
-        state = await self.proto.runstate_changed()
-        self.assertEqual(state, Runstate.CONNECTING)
-
-        # This is insider baseball, but the connection attempt has
-        # yielded *just* before the actual connection attempt, so kick
-        # the loop to make sure it's truly wedged.
-        await asyncio.sleep(0)
-
-        task.cancel()
-        await task
-
-    @TestBase.async_test
-    async def testTimeout(self):
-        """
-        Test what happens when a connection attempt times out.
-        """
-        await self._watch_runstates(*self.BAD_CONNECTION_STATES)
-        task = run_as_task(self._hanging_connection())
-
-        # More insider baseball: to improve the speed of this test while
-        # guaranteeing that the connection even gets a chance to start,
-        # verify that the connection hangs *first*, then await the
-        # result of the task with a nearly-zero timeout.
-
-        state = await self.proto.runstate_changed()
-        self.assertEqual(state, Runstate.CONNECTING)
-        await asyncio.sleep(0)
-
-        with self.assertRaises(asyncio.TimeoutError):
-            await asyncio.wait_for(task, timeout=0)
-
-    @TestBase.async_test
-    async def testRequire(self):
-        """
-        Test what happens when a connection attempt is made while CONNECTING.
-        """
-        await self._watch_runstates(*self.BAD_CONNECTION_STATES)
-        task = run_as_task(self._hanging_connection(), allow_cancellation=True)
-
-        state = await self.proto.runstate_changed()
-        self.assertEqual(state, Runstate.CONNECTING)
-
-        with self.assertRaises(StateError) as context:
-            await self._bad_connection('UNIX')
-
-        self.assertEqual(
-            context.exception.error_message,
-            "NullProtocol is currently connecting."
-        )
-        self.assertEqual(context.exception.state, Runstate.CONNECTING)
-        self.assertEqual(context.exception.required, Runstate.IDLE)
-
-        task.cancel()
-        await task
-
-    @TestBase.async_test
-    async def testImplicitRunstateInit(self):
-        """
-        Test what happens if we do not wait on the runstate event until
-        AFTER a connection is made, i.e., connect()/accept() themselves
-        initialize the runstate event. All of the above tests force the
-        initialization by waiting on the runstate *first*.
-        """
-        task = run_as_task(self._hanging_connection(), allow_cancellation=True)
-
-        # Kick the loop to coerce the state change
-        await asyncio.sleep(0)
-        assert self.proto.runstate == Runstate.CONNECTING
-
-        # We already missed the transition to CONNECTING
-        await self._watch_runstates(Runstate.DISCONNECTING, Runstate.IDLE)
-
-        task.cancel()
-        await task
-
-
-class Accept(Connect):
-    """
-    All of the same tests as Connect, but using the accept() interface.
-    """
-    async def _bad_connection(self, family: str):
-        assert family in ('INET', 'UNIX')
-
-        if family == 'INET':
-            await self.proto.start_server_and_accept(('example.com', 1))
-        elif family == 'UNIX':
-            await self.proto.start_server_and_accept('/dev/null')
-
-    async def _hanging_connection(self):
-        with TemporaryDirectory(suffix='.qmp') as tmpdir:
-            sock = os.path.join(tmpdir, type(self.proto).__name__ + ".sock")
-            await self.proto.start_server_and_accept(sock)
-
-
-class FakeSession(TestBase):
-
-    def setUp(self):
-        super().setUp()
-        self.proto.fake_session = True
-
-    async def _asyncSetUp(self):
-        await super()._asyncSetUp()
-        await self._watch_runstates(*self.GOOD_CONNECTION_STATES)
-
-    async def _asyncTearDown(self):
-        await self.proto.disconnect()
-        await super()._asyncTearDown()
-
-    ####
-
-    @TestBase.async_test
-    async def testFakeConnect(self):
-
-        """Test the full state lifecycle (via connect) with a no-op session."""
-        await self.proto.connect('/not/a/real/path')
-        self.assertEqual(self.proto.runstate, Runstate.RUNNING)
-
-    @TestBase.async_test
-    async def testFakeAccept(self):
-        """Test the full state lifecycle (via accept) with a no-op session."""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-        self.assertEqual(self.proto.runstate, Runstate.RUNNING)
-
-    @TestBase.async_test
-    async def testFakeRecv(self):
-        """Test receiving a fake/null message."""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-
-        logname = self.proto.logger.name
-        with self.assertLogs(logname, level='DEBUG') as context:
-            self.proto.trigger_input.set()
-            self.proto.trigger_input.clear()
-            await asyncio.sleep(0)  # Kick reader.
-
-        self.assertEqual(
-            context.output,
-            [f"DEBUG:{logname}:<-- None"],
-        )
-
-    @TestBase.async_test
-    async def testFakeSend(self):
-        """Test sending a fake/null message."""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-
-        logname = self.proto.logger.name
-        with self.assertLogs(logname, level='DEBUG') as context:
-            # Cheat: Send a Null message to nobody.
-            await self.proto.send_msg()
-            # Kick writer; awaiting on a queue.put isn't sufficient to yield.
-            await asyncio.sleep(0)
-
-        self.assertEqual(
-            context.output,
-            [f"DEBUG:{logname}:--> None"],
-        )
-
-    async def _prod_session_api(
-            self,
-            current_state: Runstate,
-            error_message: str,
-            accept: bool = True
-    ):
-        with self.assertRaises(StateError) as context:
-            if accept:
-                await self.proto.start_server_and_accept('/not/a/real/path')
-            else:
-                await self.proto.connect('/not/a/real/path')
-
-        self.assertEqual(context.exception.error_message, error_message)
-        self.assertEqual(context.exception.state, current_state)
-        self.assertEqual(context.exception.required, Runstate.IDLE)
-
-    @TestBase.async_test
-    async def testAcceptRequireRunning(self):
-        """Test that accept() cannot be called when Runstate=RUNNING"""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-
-        await self._prod_session_api(
-            Runstate.RUNNING,
-            "NullProtocol is already connected and running.",
-            accept=True,
-        )
-
-    @TestBase.async_test
-    async def testConnectRequireRunning(self):
-        """Test that connect() cannot be called when Runstate=RUNNING"""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-
-        await self._prod_session_api(
-            Runstate.RUNNING,
-            "NullProtocol is already connected and running.",
-            accept=False,
-        )
-
-    @TestBase.async_test
-    async def testAcceptRequireDisconnecting(self):
-        """Test that accept() cannot be called when Runstate=DISCONNECTING"""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-
-        # Cheat: force a disconnect.
-        await self.proto.simulate_disconnect()
-
-        await self._prod_session_api(
-            Runstate.DISCONNECTING,
-            ("NullProtocol is disconnecting."
-             " Call disconnect() to return to IDLE state."),
-            accept=True,
-        )
-
-    @TestBase.async_test
-    async def testConnectRequireDisconnecting(self):
-        """Test that connect() cannot be called when Runstate=DISCONNECTING"""
-        await self.proto.start_server_and_accept('/not/a/real/path')
-
-        # Cheat: force a disconnect.
-        await self.proto.simulate_disconnect()
-
-        await self._prod_session_api(
-            Runstate.DISCONNECTING,
-            ("NullProtocol is disconnecting."
-             " Call disconnect() to return to IDLE state."),
-            accept=False,
-        )
-
-
-class SimpleSession(TestBase):
-
-    def setUp(self):
-        super().setUp()
-        self.server = LineProtocol(type(self).__name__ + '-server')
-
-    async def _asyncSetUp(self):
-        await super()._asyncSetUp()
-        await self._watch_runstates(*self.GOOD_CONNECTION_STATES)
-
-    async def _asyncTearDown(self):
-        await self.proto.disconnect()
-        try:
-            await self.server.disconnect()
-        except EOFError:
-            pass
-        await super()._asyncTearDown()
-
-    @TestBase.async_test
-    async def testSmoke(self):
-        with TemporaryDirectory(suffix='.qmp') as tmpdir:
-            sock = os.path.join(tmpdir, type(self.proto).__name__ + ".sock")
-            server_task = asyncio.create_task(
-                self.server.start_server_and_accept(sock))
-
-            # give the server a chance to start listening [...]
-            await asyncio.sleep(0)
-            await self.proto.connect(sock)
diff --git a/python/wheels/qemu_qmp-0.0.5-py3-none-any.whl b/python/wheels/qemu_qmp-0.0.5-py3-none-any.whl
new file mode 100644
index 0000000000000000000000000000000000000000..6372b7544ffb015a5c77d9686e921b65c848d433
GIT binary patch
literal 72263
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

literal 0
HcmV?d00001

-- 
2.51.0


