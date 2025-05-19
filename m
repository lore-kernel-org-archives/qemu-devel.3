Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01A8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH58R-0002pB-Eu; Mon, 19 May 2025 14:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH58N-0002nF-Rr
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH58G-0000et-RC
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747678952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXLChn7Ju3EvSXSzFG4YH+3NLvReCnqrI8z4PIwJS3I=;
 b=ivFTh+vJcSI/yFHd/qxLWLR+VlTTtxv0F0NbsWMccYlhFpnLEehzDNjqiP1clIJkpLm+fo
 nl6jhExZebbUgaaBeOjk8Q4nF5GMIx+woyCBFCGIVVdDETDCy5Xn7a7Qo2wAH1NxhKlM98
 Jv6mKbvNI0Qc9q2FmBHGTxAsoekDYss=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-VbXfYh-nNI6oJD15fzbuJA-1; Mon,
 19 May 2025 14:22:29 -0400
X-MC-Unique: VbXfYh-nNI6oJD15fzbuJA-1
X-Mimecast-MFC-AGG-ID: VbXfYh-nNI6oJD15fzbuJA_1747678948
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C16201955DB0; Mon, 19 May 2025 18:22:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0D3F19560A3; Mon, 19 May 2025 18:22:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 5/8] python: convert remaining deprecated type hints for 3.9+
Date: Mon, 19 May 2025 14:21:49 -0400
Message-ID: <20250519182153.3835722-6-jsnow@redhat.com>
In-Reply-To: <20250519182153.3835722-1-jsnow@redhat.com>
References: <20250519182153.3835722-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In this patch, we don't have a builtin type to use for a type hint, but
we do have collections.abc and other standard library types. Replace
deprecated type hints with their standard library equivalents:

typing.Awaitable      => collections.abc.Awaitable
typing.AbstractSet    => collections.abc.AbstractSet
typing.AsyncIterator  => collections.abc.AsyncIterator
typing.Callable       => collections.abc.Callable
typing.Coroutine      => collections.abc.Coroutine
typing.Deque          => collections.deque
typing.Generator      => collections.abc.Generator
typing.Iterable       => collections.abc.Iterable
typing.Iterator       => collections.abc.Iterator
typing.Mapping        => collections.abc.Mapping
typing.Match          => re.Match
typing.MutableMapping => collections.abc.MutableMapping
typing.Sequence       => collections.abc.Sequence
typing.ValuesView     => collections.abc.ValuesView

The primary benefit of this is, of course, that the standard type can
now be used directly as the type hint. In general, this means far fewer
imports from `typing`. The reason we *have* to do this is because the
old type hints have been deprecated and will be dropped from a Python
release in the future, so I am just getting ahead of it before it causes
a problem.

(Granted, yes, in practice this just means we're usually importing from
collections.abc instead of typing, but... ah well. What are you gonna
do.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py                           |  8 ++------
 docs/sphinx/dbusdoc.py                          |  4 +---
 docs/sphinx/dbusdomain.py                       |  3 +--
 docs/sphinx/qapi_domain.py                      |  9 ++-------
 docs/sphinx/qapidoc.py                          |  9 ++-------
 python/qemu/machine/console_socket.py           |  4 ++--
 python/qemu/machine/machine.py                  |  2 +-
 python/qemu/machine/qtest.py                    |  3 ++-
 python/qemu/qmp/events.py                       |  9 ++++-----
 python/qemu/qmp/legacy.py                       |  2 +-
 python/qemu/qmp/message.py                      |  9 ++-------
 python/qemu/qmp/models.py                       | 17 ++++++-----------
 python/qemu/qmp/protocol.py                     |  4 +---
 python/qemu/qmp/qmp_client.py                   |  8 ++------
 python/qemu/qmp/qmp_shell.py                    |  3 +--
 python/qemu/utils/qemu_ga_client.py             |  8 ++------
 python/qemu/utils/qom_fuse.py                   |  9 ++-------
 python/scripts/mkvenv.py                        |  9 ++-------
 scripts/block-coroutine-wrapper.py              |  2 +-
 scripts/codeconverter/codeconverter/patching.py |  8 +++++---
 scripts/compare-machine-types.py                |  3 ++-
 scripts/qapi/common.py                          | 11 +++--------
 scripts/qapi/expr.py                            |  8 ++------
 scripts/qapi/features.py                        |  2 +-
 scripts/qapi/gen.py                             |  3 ++-
 scripts/qapi/introspect.py                      |  2 +-
 scripts/qapi/parser.py                          |  5 ++---
 scripts/qapi/schema.py                          |  3 +--
 scripts/rust/rustc_args.py                      |  3 ++-
 tests/functional/test_acpi_bits.py              |  6 ++----
 tests/qemu-iotests/fat16.py                     |  3 ++-
 tests/qemu-iotests/findtests.py                 |  3 ++-
 tests/qemu-iotests/iotests.py                   |  4 ++--
 tests/qemu-iotests/linters.py                   |  3 ++-
 tests/qemu-iotests/testenv.py                   |  5 +----
 tests/qemu-iotests/testrunner.py                |  9 +++------
 36 files changed, 72 insertions(+), 131 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 50002b6fea7..6693631ed7a 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -2,13 +2,9 @@
 Sphinx cross-version compatibility goop
 """
 
+from collections.abc import Callable
 import re
-from typing import (
-    TYPE_CHECKING,
-    Any,
-    Callable,
-    Optional,
-)
+from typing import TYPE_CHECKING, Any, Optional
 
 from docutils import nodes
 from docutils.nodes import Element, Node, Text
diff --git a/docs/sphinx/dbusdoc.py b/docs/sphinx/dbusdoc.py
index 5bff49b41d2..34a264eec84 100644
--- a/docs/sphinx/dbusdoc.py
+++ b/docs/sphinx/dbusdoc.py
@@ -7,15 +7,13 @@
 # Author: Marc-André Lureau <marcandre.lureau@redhat.com>
 """dbus-doc is a Sphinx extension that provides documentation from D-Bus XML."""
 
+from collections.abc import Callable, Iterator, Sequence
 import os
 import re
 from typing import (
     TYPE_CHECKING,
     Any,
-    Callable,
-    Iterator,
     Optional,
-    Sequence,
     TypeVar,
     Union,
 )
diff --git a/docs/sphinx/dbusdomain.py b/docs/sphinx/dbusdomain.py
index 75a6b5590bc..091da4f4d0e 100644
--- a/docs/sphinx/dbusdomain.py
+++ b/docs/sphinx/dbusdomain.py
@@ -6,10 +6,9 @@
 #
 # Author: Marc-André Lureau <marcandre.lureau@redhat.com>
 
+from collections.abc import Iterable, Iterator
 from typing import (
     Any,
-    Iterable,
-    Iterator,
     NamedTuple,
     Optional,
     cast,
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 665f0953b44..7d056a58ec2 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -39,13 +39,8 @@
 
 
 if TYPE_CHECKING:
-    from typing import (
-        AbstractSet,
-        Any,
-        Iterable,
-        Optional,
-        Union,
-    )
+    from collections.abc import AbstractSet, Iterable
+    from typing import Any, Optional, Union
 
     from docutils.nodes import Element, Node
     from sphinx.addnodes import desc_signature, pending_xref
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index ff102a8cab3..2d3454f5397 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -68,13 +68,8 @@
 
 
 if TYPE_CHECKING:
-    from typing import (
-        Any,
-        Generator,
-        Optional,
-        Sequence,
-        Union,
-    )
+    from collections.abc import Generator, Sequence
+    from typing import Any, Optional, Union
 
     from sphinx.application import Sphinx
     from sphinx.util.typing import ExtensionMetadata
diff --git a/python/qemu/machine/console_socket.py b/python/qemu/machine/console_socket.py
index 0a4e09ffc73..c6070b2c7c5 100644
--- a/python/qemu/machine/console_socket.py
+++ b/python/qemu/machine/console_socket.py
@@ -17,7 +17,7 @@
 import socket
 import threading
 import time
-from typing import Deque, Optional
+from typing import Optional
 
 
 class ConsoleSocket(socket.socket):
@@ -43,7 +43,7 @@ def __init__(self,
 
         self._recv_timeout_sec = 300.0
         self._sleep_time = 0.5
-        self._buffer: Deque[int] = deque()
+        self._buffer: deque[int] = deque()
         if address is not None:
             socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
             self.connect(address)
diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 52a2d735d32..03769d51b75 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -17,6 +17,7 @@
 # Based on qmp.py.
 #
 
+from collections.abc import Sequence
 import errno
 from itertools import chain
 import locale
@@ -32,7 +33,6 @@
     Any,
     BinaryIO,
     Optional,
-    Sequence,
     TypeVar,
 )
 
diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
index 2582d89cc5e..bc6364f02f0 100644
--- a/python/qemu/machine/qtest.py
+++ b/python/qemu/machine/qtest.py
@@ -17,9 +17,10 @@
 # Based on qmp.py.
 #
 
+from collections.abc import Sequence
 import os
 import socket
-from typing import Optional, Sequence, TextIO
+from typing import Optional, TextIO
 
 from qemu.qmp import SocketAddrT
 
diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
index 93ae808b2ac..33a9317e4d4 100644
--- a/python/qemu/qmp/events.py
+++ b/python/qemu/qmp/events.py
@@ -448,16 +448,15 @@ def accept(self, event) -> bool:
 """
 
 import asyncio
-from contextlib import contextmanager
-import logging
-from typing import (
+from collections.abc import (
     AsyncIterator,
     Callable,
     Iterable,
     Iterator,
-    Optional,
-    Union,
 )
+from contextlib import contextmanager
+import logging
+from typing import Optional, Union
 
 from .error import QMPError
 from .message import Message
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index de859a99f72..584c4de0433 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -22,11 +22,11 @@
 #
 
 import asyncio
+from collections.abc import Awaitable
 import socket
 from types import TracebackType
 from typing import (
     Any,
-    Awaitable,
     Optional,
     TypeVar,
     Union,
diff --git a/python/qemu/qmp/message.py b/python/qemu/qmp/message.py
index d9234fa2453..0a4371307df 100644
--- a/python/qemu/qmp/message.py
+++ b/python/qemu/qmp/message.py
@@ -5,15 +5,10 @@
 message sent to or from the server.
 """
 
+from collections.abc import Iterator, Mapping, MutableMapping
 import json
 from json import JSONDecodeError
-from typing import (
-    Iterator,
-    Mapping,
-    MutableMapping,
-    Optional,
-    Union,
-)
+from typing import Optional, Union
 
 from .error import ProtocolError
 
diff --git a/python/qemu/qmp/models.py b/python/qemu/qmp/models.py
index 0e4a3c4e5ed..991cc87f63b 100644
--- a/python/qemu/qmp/models.py
+++ b/python/qemu/qmp/models.py
@@ -7,14 +7,9 @@
 """
 # pylint: disable=too-few-public-methods
 
-from collections import abc
+from collections.abc import Mapping, Sequence
 import copy
-from typing import (
-    Any,
-    Mapping,
-    Optional,
-    Sequence,
-)
+from typing import Any, Optional
 
 
 class Model:
@@ -68,7 +63,7 @@ def __init__(self, raw: Mapping[str, Any]):
         #: 'QMP' member
         self.QMP: QMPGreeting  # pylint: disable=invalid-name
 
-        self._check_member('QMP', abc.Mapping, "JSON object")
+        self._check_member('QMP', Mapping, "JSON object")
         self.QMP = QMPGreeting(self._raw['QMP'])
 
     def _asdict(self) -> dict[str, object]:
@@ -98,10 +93,10 @@ def __init__(self, raw: Mapping[str, Any]):
         #: 'capabilities' member
         self.capabilities: Sequence[object]
 
-        self._check_member('version', abc.Mapping, "JSON object")
+        self._check_member('version', Mapping, "JSON object")
         self.version = self._raw['version']
 
-        self._check_member('capabilities', abc.Sequence, "JSON array")
+        self._check_member('capabilities', Sequence, "JSON array")
         self.capabilities = self._raw['capabilities']
 
 
@@ -120,7 +115,7 @@ def __init__(self, raw: Mapping[str, Any]):
         #: 'id' member
         self.id: Optional[object] = None  # pylint: disable=invalid-name
 
-        self._check_member('error', abc.Mapping, "JSON object")
+        self._check_member('error', Mapping, "JSON object")
         self.error = ErrorInfo(self._raw['error'])
 
         if 'id' in raw:
diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 43aefd7b01a..683df61f55e 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -15,6 +15,7 @@
 
 import asyncio
 from asyncio import StreamReader, StreamWriter
+from collections.abc import AsyncGenerator, Awaitable, Callable
 from contextlib import asynccontextmanager
 from enum import Enum
 from functools import wraps
@@ -24,9 +25,6 @@
 from ssl import SSLContext
 from typing import (
     Any,
-    AsyncGenerator,
-    Awaitable,
-    Callable,
     Generic,
     Optional,
     TypeVar,
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index 515784ab552..5b91314bdad 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -8,15 +8,11 @@
 """
 
 import asyncio
+from collections.abc import Mapping
 import logging
 import socket
 import struct
-from typing import (
-    Mapping,
-    Optional,
-    Union,
-    cast,
-)
+from typing import Optional, Union, cast
 
 from .error import ProtocolError, QMPError
 from .events import Events
diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index 7265bd1120e..2737141fb4f 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -125,6 +125,7 @@
 
 import argparse
 import ast
+from collections.abc import Iterator, Sequence
 import json
 import logging
 import os
@@ -134,10 +135,8 @@
 import sys
 from typing import (
     IO,
-    Iterator,
     NoReturn,
     Optional,
-    Sequence,
     cast,
 )
 
diff --git a/python/qemu/utils/qemu_ga_client.py b/python/qemu/utils/qemu_ga_client.py
index 48b94e5d83b..082222dadc5 100644
--- a/python/qemu/utils/qemu_ga_client.py
+++ b/python/qemu/utils/qemu_ga_client.py
@@ -39,15 +39,11 @@
 import argparse
 import asyncio
 import base64
+from collections.abc import Callable, Sequence
 import os
 import random
 import sys
-from typing import (
-    Any,
-    Callable,
-    Optional,
-    Sequence,
-)
+from typing import Any, Optional
 
 from qemu.qmp import ConnectError, SocketAddrT
 from qemu.qmp.legacy import QEMUMonitorProtocol
diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
index 36819b7d623..e2ed70f9ded 100644
--- a/python/qemu/utils/qom_fuse.py
+++ b/python/qemu/utils/qom_fuse.py
@@ -33,16 +33,11 @@
 ##
 
 import argparse
+from collections.abc import Iterator, Mapping
 from errno import ENOENT, EPERM
 import stat
 import sys
-from typing import (
-    IO,
-    Iterator,
-    Mapping,
-    Optional,
-    Union,
-)
+from typing import IO, Optional, Union
 
 import fuse
 from fuse import FUSE, FuseOSError, Operations
diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index d026ac17ff3..b626903fa8d 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -58,6 +58,7 @@
 # later. See the COPYING file in the top-level directory.
 
 import argparse
+from collections.abc import Iterator, Sequence
 from importlib.metadata import (
     Distribution,
     EntryPoint,
@@ -76,13 +77,7 @@
 import sys
 import sysconfig
 from types import SimpleNamespace
-from typing import (
-    Any,
-    Iterator,
-    Optional,
-    Sequence,
-    Union,
-)
+from typing import Any, Optional, Union
 import venv
 
 
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index dbbde99e39e..b75b6f5567b 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -23,9 +23,9 @@
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 """
 
+from collections.abc import Iterator
 import sys
 import re
-from typing import Iterator
 
 
 def gen_header():
diff --git a/scripts/codeconverter/codeconverter/patching.py b/scripts/codeconverter/codeconverter/patching.py
index 2646811b037..e27cb9d6518 100644
--- a/scripts/codeconverter/codeconverter/patching.py
+++ b/scripts/codeconverter/codeconverter/patching.py
@@ -5,7 +5,9 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
-from typing import IO, Match, NamedTuple, Optional, Literal, Iterable, Any, TypeVar, NewType, Union
+
+from collections.abc import Iterable
+from typing import IO, NamedTuple, Optional, Literal, Any, TypeVar, NewType, Union
 from pathlib import Path
 from itertools import chain
 from tempfile import NamedTemporaryFile
@@ -45,9 +47,9 @@ class FileMatch:
     """
     regexp: Optional[str] = None
 
-    def __init__(self, f: 'FileInfo', m: Match) -> None:
+    def __init__(self, f: 'FileInfo', m: re.Match) -> None:
         self.file: 'FileInfo' = f
-        self.match: Match[str] = m
+        self.match: re.Match[str] = m
 
     @property
     def name(self) -> str:
diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
index b47ab058645..67bf0fc0ad0 100755
--- a/scripts/compare-machine-types.py
+++ b/scripts/compare-machine-types.py
@@ -26,12 +26,13 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 
+from collections.abc import Generator
 import sys
 from os import path
 from argparse import ArgumentParser, RawTextHelpFormatter, Namespace
 import pandas as pd
 from contextlib import ExitStack
-from typing import Optional, Generator, Union, Any
+from typing import Optional, Union, Any
 
 try:
     qemu_dir = path.abspath(path.dirname(path.dirname(__file__)))
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2c55b70a8bd..27e4c89936c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -11,14 +11,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from collections.abc import Sequence
 import re
-from typing import (
-    Any,
-    Match,
-    Optional,
-    Sequence,
-    Union,
-)
+from typing import Any, Optional, Union
 
 
 #: Magic string that gets removed along with all space to its right.
@@ -250,7 +245,7 @@ def gen_endif(cond: str) -> str:
 ''', cond=cond)
 
 
-def must_match(pattern: str, string: str) -> Match[str]:
+def must_match(pattern: str, string: str) -> re.Match[str]:
     match = re.match(pattern, string)
     assert match is not None
     return match
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 144e3dfaa32..fc9e4ec6f96 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -31,13 +31,9 @@
 structures and contextual semantic validation.
 """
 
+from collections.abc import Iterable
 import re
-from typing import (
-    Iterable,
-    Optional,
-    Union,
-    cast,
-)
+from typing import Optional, Union, cast
 
 from .common import c_name
 from .error import QAPISemError
diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
index 57563207a82..d605c9609da 100644
--- a/scripts/qapi/features.py
+++ b/scripts/qapi/features.py
@@ -7,7 +7,7 @@
 # See the COPYING file in the top-level directory.
 """
 
-from typing import ValuesView
+from collections.abc import ValuesView
 
 from .common import c_enum_const, c_name
 from .gen import QAPISchemaMonolithicCVisitor
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 53b267228e5..cc2bb066555 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -11,11 +11,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from collections.abc import Iterator, Sequence
 from contextlib import contextmanager
 import os
 import re
 import sys
-from typing import Iterator, Optional, Sequence
+from typing import Optional
 
 from .common import (
     c_enum_const,
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 037ed35d3f4..d7ea6bb0f01 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -11,12 +11,12 @@
 See the COPYING file in the top-level directory.
 """
 
+from collections.abc import Sequence
 from dataclasses import dataclass
 from typing import (
     Any,
     Generic,
     Optional,
-    Sequence,
     TypeVar,
     Union,
 )
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 1475e92a208..98067f6d347 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -14,14 +14,13 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from collections.abc import Mapping
 import enum
 import os
 import re
 from typing import (
     TYPE_CHECKING,
     Any,
-    Mapping,
-    Match,
     Optional,
     Union,
 )
@@ -430,7 +429,7 @@ def get_doc_line(self) -> Optional[str]:
         return self.val[2:].rstrip()
 
     @staticmethod
-    def _match_at_name_colon(string: str) -> Optional[Match[str]]:
+    def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
         return re.match(r'@([^:]*): *', string)
 
     def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index aaeb7b202f8..2d1e5b1597e 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -19,14 +19,13 @@
 from __future__ import annotations
 
 from abc import ABC, abstractmethod
+from collections.abc import Callable, ValuesView
 import os
 import re
 from typing import (
     Any,
-    Callable,
     Optional,
     Union,
-    ValuesView,
     cast,
 )
 
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 5de6079b9a0..ef60d57003e 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -25,10 +25,11 @@
 """
 
 import argparse
+from collections.abc import Iterable, Mapping
 from dataclasses import dataclass
 import logging
 from pathlib import Path
-from typing import Any, Iterable, Mapping, Optional
+from typing import Any, Optional
 
 try:
     import tomllib
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index b9ca6a9b162..c32ea5e012c 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -31,15 +31,13 @@
 https://gitlab.com/qemu-project/biosbits-bits .
 """
 
+from collections.abc import Sequence
 import os
 import re
 import shutil
 import subprocess
+from typing import Optional
 
-from typing import (
-    Optional,
-    Sequence,
-)
 from qemu.machine import QEMUMachine
 from qemu_test import (QemuSystemTest, Asset, skipIfMissingCommands,
                        skipIfNotMachine)
diff --git a/tests/qemu-iotests/fat16.py b/tests/qemu-iotests/fat16.py
index a2c69b3a54d..c3ba088674b 100644
--- a/tests/qemu-iotests/fat16.py
+++ b/tests/qemu-iotests/fat16.py
@@ -15,7 +15,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
-from typing import Callable, Optional, Protocol
+from collections.abc import Callable
+from typing import Optional, Protocol
 import string
 
 SECTOR_SIZE = 512
diff --git a/tests/qemu-iotests/findtests.py b/tests/qemu-iotests/findtests.py
index 11531bdca7b..787a202aff5 100644
--- a/tests/qemu-iotests/findtests.py
+++ b/tests/qemu-iotests/findtests.py
@@ -20,8 +20,9 @@
 import glob
 import re
 from collections import defaultdict
+from collections.abc import Iterator
 from contextlib import contextmanager
-from typing import Optional, Iterator
+from typing import Optional
 
 
 @contextmanager
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 49a6bbc4cde..d539de05767 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -20,6 +20,7 @@
 import atexit
 import bz2
 from collections import OrderedDict
+from collections.abc import Callable, Iterable, Iterator, Sequence
 import faulthandler
 import json
 import logging
@@ -31,8 +32,7 @@
 import subprocess
 import sys
 import time
-from typing import (Any, Callable, Iterable, Iterator,
-                    Optional, Sequence, TextIO, TypeVar)
+from typing import Any, Optional, TextIO, TypeVar
 import unittest
 
 from contextlib import contextmanager
diff --git a/tests/qemu-iotests/linters.py b/tests/qemu-iotests/linters.py
index 21b26bff298..ceb1bcd3ad9 100644
--- a/tests/qemu-iotests/linters.py
+++ b/tests/qemu-iotests/linters.py
@@ -13,11 +13,12 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+from collections.abc import Mapping
 import os
 import re
 import subprocess
 import sys
-from typing import Mapping, Optional
+from typing import Optional
 
 
 # TODO: Empty this list!
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 3c0d5027594..b407e845045 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -16,6 +16,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+from contextlib import AbstractContextManager as ContextManager
 import os
 import sys
 import tempfile
@@ -27,10 +28,6 @@
 import glob
 from typing import Any, Optional
 
-if sys.version_info >= (3, 9):
-    from contextlib import AbstractContextManager as ContextManager
-else:
-    from typing import ContextManager
 
 DEF_GDB_OPTIONS = 'localhost:12345'
 
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index d4e5c4c7ff9..90112152be6 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -16,6 +16,8 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+from collections.abc import Sequence
+from contextlib import AbstractContextManager as ContextManager
 import os
 from pathlib import Path
 import datetime
@@ -27,14 +29,9 @@
 import shutil
 import sys
 from multiprocessing import Pool
-from typing import Optional, Any, Sequence
+from typing import Optional, Any
 from testenv import TestEnv
 
-if sys.version_info >= (3, 9):
-    from contextlib import AbstractContextManager as ContextManager
-else:
-    from typing import ContextManager
-
 
 def silent_unlink(path: Path) -> None:
     try:
-- 
2.48.1


