Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BB1CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8Pe-0004Ww-Cu; Fri, 12 Sep 2025 14:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8Pa-0004VL-5g
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8PU-0005Fe-ER
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757701331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIORJberizBZ1QFQWihvovMmrYhgEpRz/6jxhp5LxgY=;
 b=W9wGaNBDxjgNWTboQ4oxjTc4PduxddjH6uW367WW2Hxb+aSeQvyOccPECOW9P5OoLCfL5I
 /fk73neDEnFRKChzsIxdfJdFK/89vakdgxaGt038IP7iDHo8Y3Z6+kzLdlzK/YWL8gd9Bm
 OBit9SHP0prOsZC9A6DbiJm1QSvoQLI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-nYnPnRElOtO3AdMqWAdTIQ-1; Fri,
 12 Sep 2025 14:22:07 -0400
X-MC-Unique: nYnPnRElOtO3AdMqWAdTIQ-1
X-Mimecast-MFC-AGG-ID: nYnPnRElOtO3AdMqWAdTIQ_1757701327
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9DFA1800359
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 18:22:06 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8C4C18003FC; Fri, 12 Sep 2025 18:22:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/6] tests/functional: import GDB remote code from avocado
Date: Fri, 12 Sep 2025 19:21:55 +0100
Message-ID: <20250912182200.643909-2-berrange@redhat.com>
In-Reply-To: <20250912182200.643909-1-berrange@redhat.com>
References: <20250912182200.643909-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The gdbmi_parser.py and spark.py modules originated in projects
that pre-date avocado and are imported unchanged aside from the
'import' statement in gdbmi_parser.py

The gdb.py module is original avocado code that is imported with
all classes except GDBRemote removed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/gdb.py          | 233 ++++++
 tests/functional/qemu_test/gdbmi_parser.py | 419 ++++++++++
 tests/functional/qemu_test/spark.py        | 850 +++++++++++++++++++++
 3 files changed, 1502 insertions(+)
 create mode 100644 tests/functional/qemu_test/gdb.py
 create mode 100644 tests/functional/qemu_test/gdbmi_parser.py
 create mode 100644 tests/functional/qemu_test/spark.py

diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_test/gdb.py
new file mode 100644
index 0000000000..913e3b65ab
--- /dev/null
+++ b/tests/functional/qemu_test/gdb.py
@@ -0,0 +1,233 @@
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+#
+# A cut-down copy of gdb.py from the avocado project:
+#
+# Copyright: Red Hat Inc. 2014
+# Authors: Cleber Rosa <cleber@redhat.com>
+
+__all__ = ["GDB", "GDBServer", "GDBRemote"]
+
+
+import socket
+
+from . import gdbmi_parser
+
+#: How the remote protocol signals a transmission success (in ACK mode)
+REMOTE_TRANSMISSION_SUCCESS = "+"
+
+#: How the remote protocol signals a transmission failure (in ACK mode)
+REMOTE_TRANSMISSION_FAILURE = "-"
+
+#: How the remote protocol flags the start of a packet
+REMOTE_PREFIX = b"$"
+
+#: How the remote protocol flags the end of the packet payload, and that the
+#: two digits checksum follow
+REMOTE_DELIMITER = b"#"
+
+#: Rather conservative default maximum packet size for clients using the
+#: remote protocol. Individual connections can ask (and do so by default)
+#: the server about the maximum packet size they can handle.
+REMOTE_MAX_PACKET_SIZE = 1024
+
+
+class UnexpectedResponseError(Exception):
+    """A response different from the one expected was received from GDB"""
+
+
+class ServerInitTimeoutError(Exception):
+    """Server took longer than expected to initialize itself properly"""
+
+
+class InvalidPacketError(Exception):
+    """Packet received has invalid format"""
+
+
+class NotConnectedError(Exception):
+    """GDBRemote is not connected to a remote GDB server"""
+
+
+class RetransmissionRequestedError(Exception):
+    """Message integrity was not validated and retransmission is being requested"""
+
+
+
+class GDBRemote:
+    """A GDBRemote acts like a client that speaks the GDB remote protocol,
+    documented at:
+
+    https://sourceware.org/gdb/current/onlinedocs/gdb/Remote-Protocol.html
+
+    Caveat: we currently do not support communicating with devices, only
+    with TCP sockets. This limitation is basically due to the lack of
+    use cases that justify an implementation, but not due to any technical
+    shortcoming.
+    """
+
+    def __init__(self, host, port, no_ack_mode=True, extended_mode=True):
+        """Initializes a new GDBRemote object.
+
+        :param host: the IP address or host name
+        :type host: str
+        :param port: the port number where the the remote GDB is listening on
+        :type port: int
+        :param no_ack_mode: if the packet transmission confirmation mode should
+                            be disabled
+        :type no_ack_mode: bool
+        :param extended_mode: if the remote extended mode should be enabled
+        :type param extended_mode: bool
+        """
+        self.host = host
+        self.port = port
+
+        # Temporary holder for the class init attributes
+        self._no_ack_mode = no_ack_mode
+        self.no_ack_mode = False
+        self._extended_mode = extended_mode
+        self.extended_mode = False
+
+        self._socket = None
+
+    @staticmethod
+    def checksum(input_message):
+        """Calculates a remote message checksum.
+
+        More details are available at:
+        https://sourceware.org/gdb/current/onlinedocs/gdb/Overview.html
+
+        :param input_message: the message input payload, without the
+                              start and end markers
+        :type input_message: bytes
+        :returns: two byte checksum
+        :rtype: bytes
+        """
+        total = 0
+        for i in input_message:
+            total += i
+        result = total % 256
+
+        return b"%02x" % result
+
+    @staticmethod
+    def encode(data):
+        """Encodes a command.
+
+        That is, add prefix, suffix and checksum.
+
+        More details are available at:
+        https://sourceware.org/gdb/current/onlinedocs/gdb/Overview.html
+
+        :param data: the command data payload
+        :type data: bytes
+        :returns: the encoded command, ready to be sent to a remote GDB
+        :rtype: bytes
+        """
+        return b"$%b#%b" % (data, GDBRemote.checksum(data))
+
+    @staticmethod
+    def decode(data):
+        """Decodes a packet and returns its payload.
+
+        More details are available at:
+        https://sourceware.org/gdb/current/onlinedocs/gdb/Overview.html
+
+        :param data: the command data payload
+        :type data: bytes
+        :returns: the encoded command, ready to be sent to a remote GDB
+        :rtype: bytes
+        :raises InvalidPacketError: if the packet is not well constructed,
+                                    like in checksum mismatches
+        """
+        if data[0:1] != REMOTE_PREFIX:
+            raise InvalidPacketError
+
+        if data[-3:-2] != REMOTE_DELIMITER:
+            raise InvalidPacketError
+
+        payload = data[1:-3]
+        checksum = data[-2:]
+
+        if payload == b"":
+            expected_checksum = b"00"
+        else:
+            expected_checksum = GDBRemote.checksum(payload)
+
+        if checksum != expected_checksum:
+            raise InvalidPacketError
+
+        return payload
+
+    def cmd(self, command_data, expected_response=None):
+        """Sends a command data to a remote gdb server
+
+        Limitations: the current version does not deal with retransmissions.
+
+        :param command_data: the remote command to send the the remote stub
+        :type command_data: str
+        :param expected_response: the (optional) response that is expected
+                                  as a response for the command sent
+        :type expected_response: str
+        :raises: RetransmissionRequestedError, UnexpectedResponseError
+        :returns: raw data read from from the remote server
+        :rtype: str
+        :raises NotConnectedError: if the socket is not initialized
+        :raises RetransmissionRequestedError: if there was a failure while
+                                              reading the result of the command
+        :raises UnexpectedResponseError: if response is unexpected
+        """
+        if self._socket is None:
+            raise NotConnectedError
+
+        data = self.encode(command_data)
+        self._socket.send(data)
+
+        if not self.no_ack_mode:
+            transmission_result = self._socket.recv(1)
+            if transmission_result == REMOTE_TRANSMISSION_FAILURE:
+                raise RetransmissionRequestedError
+
+        result = self._socket.recv(REMOTE_MAX_PACKET_SIZE)
+        response_payload = self.decode(result)
+
+        if expected_response is not None:
+            if expected_response != response_payload:
+                raise UnexpectedResponseError
+
+        return response_payload
+
+    def set_extended_mode(self):
+        """Enable extended mode. In extended mode, the remote server is made
+        persistent. The 'R' packet is used to restart the program being
+        debugged. Original documentation at:
+
+        https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#extended-mode
+        """
+        self.cmd(b"!", b"OK")
+        self.extended_mode = True
+
+    def start_no_ack_mode(self):
+        """Request that the remote stub disable the normal +/- protocol
+        acknowledgments. Original documentation at:
+
+        https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Packets.html#QStartNoAckMode
+        """
+        self.cmd(b"QStartNoAckMode", b"OK")
+        self.no_ack_mode = True
+
+    def connect(self):
+        """Connects to the remote target and initializes the chosen modes"""
+        self._socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+        self._socket.connect((self.host, self.port))
+
+        if self._no_ack_mode:
+            self.start_no_ack_mode()
+
+        if self._extended_mode:
+            self.set_extended_mode()
diff --git a/tests/functional/qemu_test/gdbmi_parser.py b/tests/functional/qemu_test/gdbmi_parser.py
new file mode 100644
index 0000000000..476e824b72
--- /dev/null
+++ b/tests/functional/qemu_test/gdbmi_parser.py
@@ -0,0 +1,419 @@
+#
+# Copyright (c) 2008 Michael Eddington
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE.
+#
+# Authors:
+#   Frank Laub (frank.laub@gmail.com)
+#   Michael Eddington (mike@phed.org)
+
+
+import pprint
+import re
+
+from . import spark
+
+
+class GdbMiError(Exception):
+    """
+    Exception raised when there is an error parsing GDB/MI output.
+    """
+
+
+class Token:
+    def __init__(self, token_type, value=None):
+        self.type = token_type
+        self.value = value
+
+    def __lt__(self, o):
+        return self.type < o
+
+    def __gt__(self, o):
+        return self.type > o
+
+    def __le__(self, o):
+        return self.type <= o
+
+    def __ge__(self, o):
+        return self.type >= o
+
+    def __eq__(self, o):
+        return self.type == o
+
+    def __ne__(self, o):
+        return self.type != o
+
+    def __repr__(self):
+        return self.value or self.type
+
+
+class AST:
+    def __init__(self, ast_type):
+        self.type = ast_type
+        self._kids = []
+
+    def __getitem__(self, i):
+        return self._kids[i]
+
+    def __setitem__(self, i, k):
+        self._kids[i] = k
+
+    def __len__(self):
+        return len(self._kids)
+
+    def __lt__(self, o):
+        return self.type < o
+
+    def __gt__(self, o):
+        return self.type > o
+
+    def __le__(self, o):
+        return self.type <= o
+
+    def __ge__(self, o):
+        return self.type >= o
+
+    def __eq__(self, o):
+        return self.type == o
+
+    def __ne__(self, o):
+        return self.type != o
+
+
+class GdbMiScannerBase(spark.GenericScanner):
+    def tokenize(self, s):  # pylint: disable=W0221
+        self.rv = []  # pylint: disable=W0201
+        spark.GenericScanner.tokenize(self, s)
+        return self.rv
+
+    def t_nl(self, s):  # pylint: disable=W0613
+        r"\n|\r\n"
+        self.rv.append(Token("nl"))
+
+    def t_whitespace(self, s):  # pylint: disable=W0613
+        r"[ \t\f\v]+"
+
+    def t_symbol(self, s):
+        r",|\{|\}|\[|\]|\="
+        self.rv.append(Token(s, s))
+
+    def t_result_type(self, s):
+        r"\*|\+|\^"
+        self.rv.append(Token("result_type", s))
+
+    def t_stream_type(self, s):
+        r"\@|\&|\~"
+        self.rv.append(Token("stream_type", s))
+
+    def t_string(self, s):
+        r"[\w-]+"
+        self.rv.append(Token("string", s))
+
+    def t_c_string(self, s):
+        r"\".*?(?<![\\\\])\" "
+        inner = self.__unescape(s[1 : len(s) - 1])
+        self.rv.append(Token("c_string", inner))
+
+    def t_default(self, s):  # pylint: disable=W0221
+        r"( . | \n )+"
+        raise GdbMiError(f"Specification error: unmatched input for '{s}'")
+
+    @staticmethod
+    def __unescape(s):
+        s = re.sub(r"\\r", r"\r", s)
+        s = re.sub(r"\\n", r"\n", s)
+        s = re.sub(r"\\t", r"\t", s)
+        return re.sub(r"\\(.)", r"\1", s)
+
+
+class GdbMiScanner(GdbMiScannerBase):
+    def t_token(self, s):
+        r"\d+"
+        self.rv.append(Token("token", s))
+
+
+class GdbMiParser(spark.GenericASTBuilder):
+    def __init__(self):
+        spark.GenericASTBuilder.__init__(self, AST, "output")
+
+    def p_output(self, args):
+        """
+        output ::= record_list
+        record_list ::= generic_record
+        record_list ::= generic_record record_list
+        generic_record ::= result_record
+        generic_record ::= stream_record
+        result_record ::= result_header result_list nl
+        result_record ::= result_header nl
+        result_header ::= token result_type class
+        result_header ::= result_type class
+        result_header ::= token = class
+        result_header ::= = class
+        stream_record ::= stream_type c_string nl
+        result_list ::= , result result_list
+        result_list ::= , result
+        result_list ::= , tuple
+        result ::= variable = value
+        class ::= string
+        variable ::= string
+        value ::= const
+        value ::= tuple
+        value ::= list
+        value_list ::= , value
+        value_list ::= , value value_list
+        const ::= c_string
+        tuple ::= { }
+        tuple ::= { result }
+        tuple ::= { result result_list }
+        list ::= [ ]
+        list ::= [ value ]
+        list ::= [ value value_list ]
+        list ::= [ result ]
+        list ::= [ result result_list ]
+        list ::= { value }
+        list ::= { value value_list }
+        """
+
+    def terminal(self, token):  # pylint: disable=W0221
+        #  Homogeneous AST.
+        rv = AST(token.type)
+        rv.value = token.value  # pylint: disable=W0201
+        return rv
+
+    def nonterminal(self, token_type, args):
+        #  Flatten AST a bit by not making nodes if there's only one child.
+        exclude = ["record_list"]
+        if len(args) == 1 and token_type not in exclude:
+            return args[0]
+        return spark.GenericASTBuilder.nonterminal(self, token_type, args)
+
+    def error(self, token, i=0, tokens=None):  # pylint: disable=W0221
+        if i > 2:
+            print(f"{tokens[i - 3]} {tokens[i - 2]} " f"{tokens[i - 1]} {tokens[i]}")
+        raise GdbMiError(f"Syntax error at or near {int(i)}:'{token}' token")
+
+
+class GdbMiInterpreter(spark.GenericASTTraversal):
+    def __init__(self, ast):
+        spark.GenericASTTraversal.__init__(self, ast)
+        self.postorder()
+
+    @staticmethod
+    def __translate_type(token_type):
+        table = {
+            "^": "result",
+            "=": "notify",
+            "+": "status",
+            "*": "exec",
+            "~": "console",
+            "@": "target",
+            "&": "log",
+        }
+        return table[token_type]
+
+    @staticmethod
+    def n_result(node):
+        # result ::= variable = value
+        node.value = {node[0].value: node[2].value}
+        # print 'result: %s' % node.value
+
+    @staticmethod
+    def n_tuple(node):
+        if len(node) == 2:
+            # tuple ::= {}
+            node.value = {}
+        elif len(node) == 3:
+            # tuple ::= { result }
+            node.value = node[1].value
+        elif len(node) == 4:
+            # tuple ::= { result result_list }
+            node.value = node[1].value
+            for result in node[2].value:
+                for n, v in list(result.items()):
+                    if n in node.value:
+                        # print '**********list conversion: [%s] %s -> %s' % (n, node.value[n], v)
+                        old = node.value[n]
+                        if not isinstance(old, list):
+                            node.value[n] = [node.value[n]]
+                        node.value[n].append(v)
+                    else:
+                        node.value[n] = v
+        else:
+            raise GdbMiError("Invalid tuple")
+        # print 'tuple: %s' % node.value
+
+    @staticmethod
+    def n_list(node):
+        if len(node) == 2:
+            # list ::= []
+            node.value = []
+        elif len(node) == 3:
+            # list ::= [ value ]
+            node.value = [node[1].value]
+        elif len(node) == 4:
+            # list ::= [ value value_list ]
+            node.value = [node[1].value] + node[2].value
+            # list ::= [ result ]
+            # list ::= [ result result_list ]
+            # list ::= { value }
+            # list ::= { value value_list }
+        # print 'list %s' % node.value
+
+    @staticmethod
+    def n_value_list(node):
+        if len(node) == 2:
+            # value_list ::= , value
+            node.value = [node[1].value]
+        elif len(node) == 3:
+            # value_list ::= , value value_list
+            node.value = [node[1].value] + node[2].value
+
+    @staticmethod
+    def n_result_list(node):
+        if len(node) == 2:
+            # result_list ::= , result
+            node.value = [node[1].value]
+        else:
+            # result_list ::= , result result_list
+            node.value = [node[1].value] + node[2].value
+        # print 'result_list: %s' % node.value
+
+    @staticmethod
+    def n_result_record(node):
+        node.value = node[0].value
+        if len(node) == 3:
+            # result_record ::= result_header result_list nl
+            node.value["results"] = node[1].value
+        elif len(node) == 2:
+            # result_record ::= result_header nl
+            pass
+        # print 'result_record: %s' % (node.value)
+
+    def n_result_header(self, node):
+        if len(node) == 3:
+            # result_header ::= token result_type class
+            node.value = {
+                "token": node[0].value,
+                "type": self.__translate_type(node[1].value),
+                "class_": node[2].value,
+                "record_type": "result",
+            }
+        elif len(node) == 2:
+            # result_header ::= result_type class
+            node.value = {
+                "token": None,
+                "type": self.__translate_type(node[0].value),
+                "class_": node[1].value,
+                "record_type": "result",
+            }
+
+    def n_stream_record(self, node):
+        # stream_record ::= stream_type c_string nl
+        node.value = {
+            "type": self.__translate_type(node[0].value),
+            "value": node[1].value,
+            "record_type": "stream",
+        }
+        # print 'stream_record: %s' % node.value
+
+    @staticmethod
+    def n_record_list(node):
+        if len(node) == 1:
+            # record_list ::= generic_record
+            node.value = [node[0].value]
+        elif len(node) == 2:
+            # record_list ::= generic_record record_list
+            node.value = [node[0].value] + node[1].value
+        # print 'record_list: %s' % node.value
+
+    # def default(self, node):
+    # print 'default: ' + node.type
+
+
+class GdbDynamicObject:
+    def __init__(self, dict_):
+        self.graft(dict_)
+
+    def __repr__(self):
+        return pprint.pformat(self.__dict__)
+
+    def __bool__(self):
+        return len(self.__dict__) > 0
+
+    def __getitem__(self, i):
+        if not i and len(self.__dict__) > 0:
+            return self
+        raise IndexError
+
+    def __getattr__(self, name):
+        if name.startswith("__"):
+            raise AttributeError
+
+    def graft(self, dict_):
+        for name, value in list(dict_.items()):
+            name = name.replace("-", "_")
+            if isinstance(value, dict):
+                value = GdbDynamicObject(value)
+            elif isinstance(value, list):
+                x = value
+                value = []
+                for item in x:
+                    if isinstance(item, dict):
+                        item = GdbDynamicObject(item)
+                    value.append(item)
+            setattr(self, name, value)
+
+
+class GdbMiRecord:
+    def __init__(self, record):
+        self.result = None
+        for name, value in list(record[0].items()):
+            name = name.replace("-", "_")
+            if name == "results":
+                for result in value:
+                    if not self.result:
+                        self.result = GdbDynamicObject(result)
+                    else:
+                        # graft this result to self.results
+                        self.result.graft(result)
+            else:
+                setattr(self, name, value)
+
+    def __repr__(self):
+        return pprint.pformat(self.__dict__)
+
+
+class session:  # pylint: disable=C0103
+    def __init__(self):
+        self.the_scanner = GdbMiScanner()
+        self.the_parser = GdbMiParser()
+        self.the_interpreter = GdbMiInterpreter
+        self.the_output = GdbMiRecord
+
+    def scan(self, data_input):
+        return self.the_scanner.tokenize(data_input)
+
+    def parse(self, tokens):
+        return self.the_parser.parse(tokens)
+
+    def process(self, data_input):
+        tokens = self.scan(data_input)
+        ast = self.parse(tokens)
+        self.the_interpreter(ast)
+        return self.the_output(ast.value)
diff --git a/tests/functional/qemu_test/spark.py b/tests/functional/qemu_test/spark.py
new file mode 100644
index 0000000000..1f98b9508c
--- /dev/null
+++ b/tests/functional/qemu_test/spark.py
@@ -0,0 +1,850 @@
+#  Copyright (c) 1998-2002 John Aycock
+#
+#  Permission is hereby granted, free of charge, to any person obtaining
+#  a copy of this software and associated documentation files (the
+#  "Software"), to deal in the Software without restriction, including
+#  without limitation the rights to use, copy, modify, merge, publish,
+#  distribute, sublicense, and/or sell copies of the Software, and to
+#  permit persons to whom the Software is furnished to do so, subject to
+#  the following conditions:
+#
+#  The above copyright notice and this permission notice shall be
+#  included in all copies or substantial portions of the Software.
+#
+#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+#  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+#  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+#  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+
+__version__ = "SPARK-0.7 (pre-alpha-7)"
+
+import re
+
+
+def _namelist(instance):
+    namelist, namedict, classlist = [], {}, [instance.__class__]
+    for c in classlist:
+        for b in c.__bases__:
+            classlist.append(b)  # pylint: disable=W4701
+        for name in c.__dict__.keys():
+            if name not in namedict:
+                namelist.append(name)
+                namedict[name] = 1
+    return namelist
+
+
+class GenericScanner:
+    def __init__(self, flags=0):
+        pattern = self.reflect()
+        self.re = re.compile(pattern, re.VERBOSE | flags)
+
+        self.index2func = {}
+        for name, number in self.re.groupindex.items():
+            self.index2func[number - 1] = getattr(self, "t_" + name)
+
+    def makeRE(self, name):  # pylint: disable=C0103
+        doc = getattr(self, name).__doc__
+        rv = f"(?P<{name[2:]}>{doc})"
+        return rv
+
+    def reflect(self):
+        rv = []
+        for name in _namelist(self):
+            if name[:2] == "t_" and name != "t_default":
+                rv.append(self.makeRE(name))
+
+        rv.append(self.makeRE("t_default"))
+        return "|".join(rv)
+
+    @staticmethod
+    def error(s, pos):  # pylint: disable=W0613
+        print(f"Lexical error at position {pos}")
+        raise SystemExit
+
+    def tokenize(self, s):
+        pos = 0
+        n = len(s)
+        while pos < n:
+            m = self.re.match(s, pos)
+            if m is None:
+                self.error(s, pos)
+
+            groups = m.groups()
+            for i, group in enumerate(groups):
+                if group and i in self.index2func:
+                    self.index2func[i](group)
+            pos = m.end()
+
+    @staticmethod
+    def t_default(s):  # pylint: disable=W0613
+        r"( . | \n )+"
+        print("Specification error: unmatched input")
+        raise SystemExit
+
+
+#
+#  Extracted from GenericParser and made global so that [un]picking works.
+#
+
+
+class _State:
+    def __init__(self, stateno, items):
+        self.t, self.complete, self.items = [], [], items
+        self.stateno = stateno
+
+
+# pylint: disable=R0902,R0904
+class GenericParser:
+    #
+    #  An Earley parser, as per J. Earley, "An Efficient Context-Free
+    #  Parsing Algorithm", CACM 13(2), pp. 94-102.  Also J. C. Earley,
+    #  "An Efficient Context-Free Parsing Algorithm", Ph.D. thesis,
+    #  Carnegie-Mellon University, August 1968.  New formulation of
+    #  the parser according to J. Aycock, "Practical Earley Parsing
+    #  and the SPARK Toolkit", Ph.D. thesis, University of Victoria,
+    #  2001, and J. Aycock and R. N. Horspool, "Practical Earley
+    #  Parsing", unpublished paper, 2001.
+    #
+
+    def __init__(self, start):
+        self.rules = {}
+        self.rule2func = {}
+        self.rule2name = {}
+        self.collectRules()
+        self.augment(start)
+        self.ruleschanged = 1
+
+    _NULLABLE = r"\e_"
+    _START = "START"
+    _BOF = "|-"
+
+    #
+    #  When pickling, take the time to generate the full state machine;
+    #  some information is then extraneous, too.  Unfortunately we
+    #  can't save the rule2func map.
+    #
+    def __getstate__(self):
+        if self.ruleschanged:
+            #
+            #  FIX ME - duplicated from parse()
+            #
+            self.computeNull()
+            self.newrules = {}  # pylint: disable=W0201
+            self.new2old = {}  # pylint: disable=W0201
+            self.makeNewRules()
+            self.ruleschanged = 0
+            self.edges, self.cores = {}, {}  # pylint: disable=W0201
+            self.states = {0: self.makeState0()}  # pylint: disable=W0201
+            self.makeState(0, self._BOF)
+        #
+        #  FIX ME - should find a better way to do this..
+        #
+        changes = 1
+        while changes:
+            changes = 0
+            for k, v in self.edges.items():
+                if v is None:
+                    state, sym = k
+                    if state in self.states:
+                        self.goto(state, sym)
+                        changes = 1
+        rv = self.__dict__.copy()
+        for s in self.states.values():
+            del s.items
+        del rv["rule2func"]
+        del rv["nullable"]
+        del rv["cores"]
+        return rv
+
+    def __setstate__(self, d):
+        self.rules = {}
+        self.rule2func = {}
+        self.rule2name = {}
+        self.collectRules()
+        start = d["rules"][self._START][0][1][1]  # Blech.
+        self.augment(start)
+        d["rule2func"] = self.rule2func
+        d["makeSet"] = self.makeSet_fast
+        self.__dict__ = d  # pylint: disable=W0201
+
+    #
+    #  A hook for GenericASTBuilder and GenericASTMatcher.  Mess
+    #  thee not with this; nor shall thee toucheth the _preprocess
+    #  argument to addRule.
+    #
+    @staticmethod
+    def preprocess(rule, func):
+        return rule, func
+
+    def addRule(self, doc, func, _preprocess=1):  # pylint: disable=C0103
+        fn = func
+        rules = doc.split()
+
+        index = []
+        for i, rule in enumerate(rules):
+            if rule == "::=":
+                index.append(i - 1)
+        index.append(len(rules))
+
+        for i in range(len(index) - 1):
+            lhs = rules[index[i]]
+            rhs = rules[index[i] + 2 : index[i + 1]]
+            rule = (lhs, tuple(rhs))
+
+            if _preprocess:
+                rule, fn = self.preprocess(rule, func)
+
+            if lhs in self.rules:
+                self.rules[lhs].append(rule)
+            else:
+                self.rules[lhs] = [rule]
+            self.rule2func[rule] = fn
+            self.rule2name[rule] = func.__name__[2:]
+        self.ruleschanged = 1
+
+    def collectRules(self):  # pylint: disable=C0103
+        for name in _namelist(self):
+            if name[:2] == "p_":
+                func = getattr(self, name)
+                doc = func.__doc__
+                self.addRule(doc, func)
+
+    def augment(self, start):
+        rule = f"{self._START} ::= {self._BOF} {start}"
+        self.addRule(rule, lambda args: args[1], 0)
+
+    def computeNull(self):  # pylint: disable=C0103
+        self.nullable = {}  # pylint: disable=W0201
+        tbd = []
+
+        for rulelist in self.rules.values():
+            lhs = rulelist[0][0]
+            self.nullable[lhs] = 0
+            for rule in rulelist:
+                rhs = rule[1]
+                if not rhs:
+                    self.nullable[lhs] = 1
+                    continue
+                #
+                #  We only need to consider rules which
+                #  consist entirely of nonterminal symbols.
+                #  This should be a savings on typical
+                #  grammars.
+                #
+                for sym in rhs:
+                    if sym not in self.rules:
+                        break
+                else:
+                    tbd.append(rule)
+        changes = 1
+        while changes:
+            changes = 0
+            for lhs, rhs in tbd:
+                if self.nullable[lhs]:
+                    continue
+                for sym in rhs:
+                    if not self.nullable[sym]:
+                        break
+                else:
+                    self.nullable[lhs] = 1
+                    changes = 1
+
+    def makeState0(self):  # pylint: disable=C0103
+        s0 = _State(0, [])
+        for rule in self.newrules[self._START]:
+            s0.items.append((rule, 0))
+        return s0
+
+    def finalState(self, tokens):  # pylint: disable=C0103
+        #
+        #  Yuck.
+        #
+        if len(self.newrules[self._START]) == 2 and not tokens:
+            return 1
+        start = self.rules[self._START][0][1][1]
+        return self.goto(1, start)
+
+    def makeNewRules(self):  # pylint: disable=C0103
+        worklist = []
+        for rulelist in self.rules.values():
+            for rule in rulelist:
+                worklist.append((rule, 0, 1, rule))
+
+        for rule, i, candidate, oldrule in worklist:
+            lhs, rhs = rule
+            n = len(rhs)
+            while i < n:
+                sym = rhs[i]
+                if sym not in self.rules or not self.nullable[sym]:
+                    candidate = 0
+                    i += 1
+                    continue
+
+                newrhs = list(rhs)
+                newrhs[i] = self._NULLABLE + sym
+                newrule = (lhs, tuple(newrhs))
+                # pylint: disable=W4701
+                worklist.append((newrule, i + 1, candidate, oldrule))
+                candidate = 0
+                i += 1
+            else:  # pylint: disable=W0120
+                if candidate:
+                    lhs = self._NULLABLE + lhs
+                    rule = (lhs, rhs)
+                if lhs in self.newrules:
+                    self.newrules[lhs].append(rule)
+                else:
+                    self.newrules[lhs] = [rule]
+                self.new2old[rule] = oldrule
+
+    @staticmethod
+    def typestring(token):  # pylint: disable=W0613
+        return None
+
+    @staticmethod
+    def error(token):
+        print(f"Syntax error at or near `{token}' token")
+        raise SystemExit
+
+    def parse(self, tokens):
+        sets = [[(1, 0), (2, 0)]]
+        self.links = {}  # pylint: disable=W0201
+
+        if self.ruleschanged:
+            self.computeNull()
+            self.newrules = {}  # pylint: disable=W0201
+            self.new2old = {}  # pylint: disable=W0201
+            self.makeNewRules()
+            self.ruleschanged = 0
+            self.edges, self.cores = {}, {}  # pylint: disable=W0201
+            self.states = {0: self.makeState0()}  # pylint: disable=W0201
+            self.makeState(0, self._BOF)
+
+        for i, token in enumerate(tokens):
+            sets.append([])
+
+            if sets[i] == []:
+                break
+            self.makeSet(token, sets, i)
+        else:
+            sets.append([])
+            self.makeSet(None, sets, len(tokens))
+
+        finalitem = (self.finalState(tokens), 0)
+        if finalitem not in sets[-2]:
+            if len(tokens) > 0:
+                self.error(tokens[i - 1])  # pylint: disable=W0631
+            else:
+                self.error(None)
+
+        return self.buildTree(self._START, finalitem, tokens, len(sets) - 2)
+
+    def isnullable(self, sym):
+        #
+        #  For symbols in G_e only.  If we weren't supporting 1.5,
+        #  could just use sym.startswith().
+        #
+        return self._NULLABLE == sym[0 : len(self._NULLABLE)]
+
+    def skip(self, hs, pos=0):
+        n = len(hs[1])
+        while pos < n:
+            if not self.isnullable(hs[1][pos]):
+                break
+            pos += 1
+        return pos
+
+    def makeState(self, state, sym):  # pylint: disable=R0914, R0912, C0103
+        assert sym is not None
+        #
+        #  Compute \epsilon-kernel state's core and see if
+        #  it exists already.
+        #
+        kitems = []
+        for rule, pos in self.states[state].items:
+            _, rhs = rule
+            if rhs[pos : pos + 1] == (sym,):
+                kitems.append((rule, self.skip(rule, pos + 1)))
+        core = kitems
+
+        core.sort()
+        tcore = tuple(core)
+        if tcore in self.cores:
+            return self.cores[tcore]
+        #
+        #  Nope, doesn't exist.  Compute it and the associated
+        #  \epsilon-nonkernel state together; we'll need it right away.
+        #
+        k = self.cores[tcore] = len(self.states)
+        ks, nk = _State(k, kitems), _State(k + 1, [])
+        self.states[k] = ks
+        predicted = {}
+
+        edges = self.edges
+        rules = self.newrules
+        for x in ks, nk:
+            worklist = x.items
+            for item in worklist:
+                rule, pos = item
+                _, rhs = rule
+                if pos == len(rhs):
+                    x.complete.append(rule)
+                    continue
+
+                next_sym = rhs[pos]
+                key = (x.stateno, next_sym)
+                if next_sym not in rules:
+                    if key not in edges:
+                        edges[key] = None
+                        x.t.append(next_sym)
+                else:
+                    edges[key] = None
+                    if next_sym not in predicted:
+                        predicted[next_sym] = 1
+                        for prule in rules[next_sym]:
+                            ppos = self.skip(prule)
+                            new = (prule, ppos)
+                            nk.items.append(new)
+            #
+            #  Problem: we know K needs generating, but we
+            #  don't yet know about NK.  Can't commit anything
+            #  regarding NK to self.edges until we're sure.  Should
+            #  we delay committing on both K and NK to avoid this
+            #  hacky code?  This creates other problems..
+            #
+            if x is ks:
+                edges = {}
+
+        if nk.items == []:
+            return k
+
+        #
+        #  Check for \epsilon-nonkernel's core.  Unfortunately we
+        #  need to know the entire set of predicted nonterminals
+        #  to do this without accidentally duplicating states.
+        #
+        core = sorted(predicted.keys())
+        tcore = tuple(core)
+        if tcore in self.cores:
+            self.edges[(k, None)] = self.cores[tcore]
+            return k
+
+        nk = self.cores[tcore] = self.edges[(k, None)] = nk.stateno
+        self.edges.update(edges)
+        self.states[nk] = nk
+        return k
+
+    def goto(self, state, sym):
+        key = (state, sym)
+        if key not in self.edges:
+            #
+            #  No transitions from state on sym.
+            #
+            return None
+
+        rv = self.edges[key]
+        if rv is None:
+            #
+            #  Target state isn't generated yet.  Remedy this.
+            #
+            rv = self.makeState(state, sym)
+            self.edges[key] = rv
+        return rv
+
+    def gotoT(self, state, t):  # pylint: disable=C0103
+        return [self.goto(state, t)]
+
+    def gotoST(self, state, st):  # pylint: disable=C0103
+        rv = []
+        for t in self.states[state].t:
+            if st == t:
+                rv.append(self.goto(state, t))
+        return rv
+
+    # pylint: disable=R0913
+    def add(self, input_set, item, i=None, predecessor=None, causal=None):
+        if predecessor is None:
+            if item not in input_set:
+                input_set.append(item)
+        else:
+            key = (item, i)
+            if item not in input_set:
+                self.links[key] = []
+                input_set.append(item)
+            self.links[key].append((predecessor, causal))
+
+    def makeSet(self, token, sets, i):  # pylint: disable=R0914,C0103
+        cur, next_item = sets[i], sets[i + 1]
+
+        ttype = (  # pylint: disable=R1709
+            token is not None and self.typestring(token) or None
+        )
+        if ttype is not None:
+            fn, arg = self.gotoT, ttype
+        else:
+            fn, arg = self.gotoST, token
+
+        for item in cur:
+            ptr = (item, i)
+            state, parent = item
+            add = fn(state, arg)
+            for k in add:
+                if k is not None:
+                    self.add(next_item, (k, parent), i + 1, ptr)
+                    nk = self.goto(k, None)
+                    if nk is not None:
+                        self.add(next_item, (nk, i + 1))
+
+            if parent == i:
+                continue
+
+            for rule in self.states[state].complete:
+                lhs, _ = rule
+                for pitem in sets[parent]:
+                    pstate, pparent = pitem
+                    k = self.goto(pstate, lhs)
+                    if k is not None:
+                        why = (item, i, rule)
+                        pptr = (pitem, parent)
+                        self.add(cur, (k, pparent), i, pptr, why)
+                        nk = self.goto(k, None)
+                        if nk is not None:
+                            self.add(cur, (nk, i))
+
+    def makeSet_fast(self, token, sets, i):  # pylint: disable=R0914, R0912, C0103
+        #
+        #  Call *only* when the entire state machine has been built!
+        #  It relies on self.edges being filled in completely, and
+        #  then duplicates and inlines code to boost speed at the
+        #  cost of extreme ugliness.
+        #
+        cur, next_item = sets[i], sets[i + 1]
+        ttype = (  # pylint: disable=R1709
+            token is not None and self.typestring(token) or None
+        )
+
+        for item in cur:  # pylint: disable=R1702
+            ptr = (item, i)
+            state, parent = item
+            if ttype is not None:
+                k = self.edges.get((state, ttype), None)
+                if k is not None:
+                    # self.add(next_item, (k, parent), i + 1, ptr)
+                    # INLINED --v
+                    new = (k, parent)
+                    key = (new, i + 1)
+                    if new not in next_item:
+                        self.links[key] = []
+                        next_item.append(new)
+                    self.links[key].append((ptr, None))
+                    # INLINED --^
+                    # nk = self.goto(k, None)
+                    nk = self.edges.get((k, None), None)
+                    if nk is not None:
+                        # self.add(next_item, (nk, i + 1))
+                        # INLINED --v
+                        new = (nk, i + 1)
+                        if new not in next_item:
+                            next_item.append(new)
+                        # INLINED --^
+            else:
+                add = self.gotoST(state, token)
+                for k in add:
+                    if k is not None:
+                        self.add(next_item, (k, parent), i + 1, ptr)
+                        # nk = self.goto(k, None)
+                        nk = self.edges.get((k, None), None)
+                        if nk is not None:
+                            self.add(next_item, (nk, i + 1))
+
+            if parent == i:
+                continue
+
+            for rule in self.states[state].complete:
+                lhs, _ = rule
+                for pitem in sets[parent]:
+                    pstate, pparent = pitem
+                    # k = self.goto(pstate, lhs)
+                    k = self.edges.get((pstate, lhs), None)
+                    if k is not None:
+                        why = (item, i, rule)
+                        pptr = (pitem, parent)
+                        # self.add(cur, (k, pparent),
+                        #          i, pptr, why)
+                        # INLINED --v
+                        new = (k, pparent)
+                        key = (new, i)
+                        if new not in cur:
+                            self.links[key] = []
+                            cur.append(new)
+                        self.links[key].append((pptr, why))
+                        # INLINED --^
+                        # nk = self.goto(k, None)
+                        nk = self.edges.get((k, None), None)
+                        if nk is not None:
+                            # self.add(cur, (nk, i))
+                            # INLINED --v
+                            new = (nk, i)
+                            if new not in cur:
+                                cur.append(new)
+                            # INLINED --^
+
+    def predecessor(self, key, causal):
+        for p, c in self.links[key]:
+            if c == causal:
+                return p
+        assert 0
+
+    def causal(self, key):
+        links = self.links[key]
+        if len(links) == 1:
+            return links[0][1]
+        choices = []
+        rule2cause = {}
+        for _, c in links:
+            rule = c[2]
+            choices.append(rule)
+            rule2cause[rule] = c
+        return rule2cause[self.ambiguity(choices)]
+
+    def deriveEpsilon(self, nt):  # pylint: disable=C0103
+        if len(self.newrules[nt]) > 1:
+            rule = self.ambiguity(self.newrules[nt])
+        else:
+            rule = self.newrules[nt][0]
+
+        rhs = rule[1]
+        attr = [None] * len(rhs)
+
+        for i in range(len(rhs) - 1, -1, -1):
+            attr[i] = self.deriveEpsilon(rhs[i])
+        return self.rule2func[self.new2old[rule]](attr)
+
+    def buildTree(self, nt, item, tokens, k):  # pylint: disable=C0103
+        state, _ = item
+
+        choices = []
+        for rule in self.states[state].complete:
+            if rule[0] == nt:
+                choices.append(rule)
+        rule = choices[0]
+        if len(choices) > 1:
+            rule = self.ambiguity(choices)
+
+        rhs = rule[1]
+        attr = [None] * len(rhs)
+
+        for i in range(len(rhs) - 1, -1, -1):
+            sym = rhs[i]
+            if sym not in self.newrules:
+                if sym != self._BOF:
+                    attr[i] = tokens[k - 1]
+                    key = (item, k)
+                    item, k = self.predecessor(key, None)
+            # elif self.isnullable(sym):
+            elif self._NULLABLE == sym[0 : len(self._NULLABLE)]:
+                attr[i] = self.deriveEpsilon(sym)
+            else:
+                key = (item, k)
+                why = self.causal(key)
+                attr[i] = self.buildTree(sym, why[0], tokens, why[1])
+                item, k = self.predecessor(key, why)
+        return self.rule2func[self.new2old[rule]](attr)
+
+    def ambiguity(self, rules):
+        #
+        #  FIX ME - problem here and in collectRules() if the same rule
+        #           appears in >1 method.  Also undefined results if rules
+        #           causing the ambiguity appear in the same method.
+        #
+        sortlist = []
+        name2index = {}
+        for i, rule in enumerate(rules):
+            _, rhs = rule = rule
+            name = self.rule2name[self.new2old[rule]]
+            sortlist.append((len(rhs), name))
+            name2index[name] = i
+        sortlist.sort()
+        result_list = [name for _, name in sortlist]
+        return rules[name2index[self.resolve(result_list)]]
+
+    @staticmethod
+    def resolve(input_list):
+        #
+        #  Resolve ambiguity in favor of the shortest RHS.
+        #  Since we walk the tree from the top down, this
+        #  should effectively resolve in favor of a "shift".
+        #
+        return input_list[0]
+
+
+#
+#  GenericASTBuilder automagically constructs a concrete/abstract syntax tree
+#  for a given input.  The extra argument is a class (not an instance!)
+#  which supports the "__setslice__" and "__len__" methods.
+#
+#  FIX ME - silently overrides any user code in methods.
+#
+
+
+class GenericASTBuilder(GenericParser):
+    def __init__(self, AST, start):
+        GenericParser.__init__(self, start)
+        self.ast = AST
+
+    def preprocess(self, rule, func):  # pylint: disable=W0221
+        # pylint: disable=C3001
+        rebind = (
+            lambda lhs, self=self: lambda args, lhs=lhs, self=self: self.buildASTNode(
+                args, lhs
+            )
+        )
+        lhs, _ = rule
+        return rule, rebind(lhs)
+
+    def buildASTNode(self, args, lhs):  # pylint: disable=C0103
+        children = []
+        for arg in args:
+            if isinstance(arg, self.ast):
+                children.append(arg)
+            else:
+                children.append(self.terminal(arg))
+        return self.nonterminal(lhs, children)
+
+    @staticmethod
+    def terminal(token):
+        return token
+
+    def nonterminal(self, token_type, args):
+        rv = self.ast(token_type)
+        rv[: len(args)] = args
+        return rv
+
+
+#
+#  GenericASTTraversal is a Visitor pattern according to Design Patterns.  For
+#  each node it attempts to invoke the method n_<node type>, falling
+#  back onto the default() method if the n_* can't be found.  The preorder
+#  traversal also looks for an exit hook named n_<node type>_exit (no default
+#  routine is called if it's not found).  To prematurely halt traversal
+#  of a subtree, call the prune() method -- this only makes sense for a
+#  preorder traversal.  Node type is determined via the typestring() method.
+#
+
+
+class GenericASTTraversalPruningException(Exception):
+    pass
+
+
+class GenericASTTraversal:
+    def __init__(self, ast):
+        self.ast = ast
+
+    @staticmethod
+    def typestring(node):
+        return node.type
+
+    @staticmethod
+    def prune():
+        raise GenericASTTraversalPruningException
+
+    def preorder(self, node=None):
+        if node is None:
+            node = self.ast
+
+        try:
+            name = "n_" + self.typestring(node)
+            if hasattr(self, name):
+                func = getattr(self, name)
+                func(node)
+            else:
+                self.default(node)
+        except GenericASTTraversalPruningException:
+            return
+
+        for kid in node:
+            self.preorder(kid)
+
+        name = name + "_exit"
+        if hasattr(self, name):
+            func = getattr(self, name)
+            func(node)
+
+    def postorder(self, node=None):
+        if node is None:
+            node = self.ast
+
+        for kid in node:
+            self.postorder(kid)
+
+        name = "n_" + self.typestring(node)
+        if hasattr(self, name):
+            func = getattr(self, name)
+            func(node)
+        else:
+            self.default(node)
+
+    def default(self, node):
+        pass
+
+
+#
+#  GenericASTMatcher.  AST nodes must have "__getitem__" and "__cmp__"
+#  implemented.
+#
+#  FIX ME - makes assumptions about how GenericParser walks the parse tree.
+#
+
+
+class GenericASTMatcher(GenericParser):
+    def __init__(self, start, ast):
+        GenericParser.__init__(self, start)
+        self.ast = ast
+
+    def preprocess(self, rule, func):  # pylint: disable=W0221
+        # pylint: disable=C3001
+        rebind = (
+            lambda func, self=self: lambda args, func=func, self=self: self.foundMatch(
+                args, func
+            )
+        )
+        lhs, rhs = rule
+        rhslist = list(rhs)
+        rhslist.reverse()
+
+        return (lhs, tuple(rhslist)), rebind(func)
+
+    @staticmethod
+    def foundMatch(args, func):  # pylint: disable=C0103
+        func(args[-1])
+        return args[-1]
+
+    def match_r(self, node):
+        self.input.insert(0, node)
+        children = 0
+
+        for child in node:
+            if not children:
+                self.input.insert(0, "(")
+            children += 1
+            self.match_r(child)
+
+        if children > 0:
+            self.input.insert(0, ")")
+
+    def match(self, ast=None):
+        if ast is None:
+            ast = self.ast
+        self.input = []  # pylint: disable=W0201
+
+        self.match_r(ast)
+        self.parse(self.input)
+
+    def resolve(self, input_list):  # pylint: disable=W0221
+        #
+        #  Resolve ambiguity in favor of the longest RHS.
+        #
+        return input_list[-1]
-- 
2.50.1


