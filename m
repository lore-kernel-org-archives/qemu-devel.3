Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8DCAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYTu-0003cq-7C; Tue, 16 Sep 2025 12:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYTb-0003aQ-0f
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYTY-0002hF-H3
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqzKN+I2hwoaeFIFrS/xVwd3pPHhPD85EHQmwuVlHF4=;
 b=eKjADAzVilVrLedJiVxZXvo7mh3N/Bdy5L0pnu5WEp/3X6d9tC2dWiFknAcg1xJOyEB5Rn
 Cn1LAimy8MjD6yqZ4VAKhGn7n9pjqzy2j81ks2e/MM3hfTpjur3KHz5jFF1LYNlAJQUq+i
 R9NkVATAs20sQB6nSPZjNW8wX/hRBWg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-7-K4yIdjNXe-TAU6xiSEIg-1; Tue,
 16 Sep 2025 12:24:13 -0400
X-MC-Unique: 7-K4yIdjNXe-TAU6xiSEIg-1
X-Mimecast-MFC-AGG-ID: 7-K4yIdjNXe-TAU6xiSEIg_1758039852
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EF6519560A6; Tue, 16 Sep 2025 16:24:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6EF419560BA; Tue, 16 Sep 2025 16:24:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/19] python: backport 'Change error classes to have better
 repr methods'
Date: Tue, 16 Sep 2025 12:23:46 -0400
Message-ID: <20250916162404.9195-2-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

By passing all of the arguments to the base class and overriding the
__str__ method when we want a different "human readable" message that
isn't just printing the list of arguments, we can ensure that all custom
error classes have a reasonable __repr__ implementation.

In the case of ExecuteError, the pseudo-field that isn't actually
correlated to an input argument can be re-imagined as a read-only
property; this forces consistency in the class and makes the repr output
more obviously correct.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@afdb7893f3b34212da4259b7202973f9a8cb85b3
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/error.py      |  7 +++++--
 python/qemu/qmp/message.py    | 12 ++++++------
 python/qemu/qmp/protocol.py   |  7 +++++--
 python/qemu/qmp/qmp_client.py | 20 +++++++++++++-------
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/python/qemu/qmp/error.py b/python/qemu/qmp/error.py
index 24ba4d50541..c87b078f620 100644
--- a/python/qemu/qmp/error.py
+++ b/python/qemu/qmp/error.py
@@ -44,7 +44,10 @@ class ProtocolError(QMPError):
 
     :param error_message: Human-readable string describing the error.
     """
-    def __init__(self, error_message: str):
-        super().__init__(error_message)
+    def __init__(self, error_message: str, *args: object):
+        super().__init__(error_message, *args)
         #: Human-readable error message, without any prefix.
         self.error_message: str = error_message
+
+    def __str__(self) -> str:
+        return self.error_message
diff --git a/python/qemu/qmp/message.py b/python/qemu/qmp/message.py
index f76ccc90746..c2e9dd0dd54 100644
--- a/python/qemu/qmp/message.py
+++ b/python/qemu/qmp/message.py
@@ -178,15 +178,15 @@ class DeserializationError(ProtocolError):
     :param raw: The raw `bytes` that prompted the failure.
     """
     def __init__(self, error_message: str, raw: bytes):
-        super().__init__(error_message)
+        super().__init__(error_message, raw)
         #: The raw `bytes` that were not understood as JSON.
         self.raw: bytes = raw
 
     def __str__(self) -> str:
-        return "\n".join([
+        return "\n".join((
             super().__str__(),
             f"  raw bytes were: {str(self.raw)}",
-        ])
+        ))
 
 
 class UnexpectedTypeError(ProtocolError):
@@ -197,13 +197,13 @@ class UnexpectedTypeError(ProtocolError):
     :param value: The deserialized JSON value that wasn't an object.
     """
     def __init__(self, error_message: str, value: object):
-        super().__init__(error_message)
+        super().__init__(error_message, value)
         #: The JSON value that was expected to be an object.
         self.value: object = value
 
     def __str__(self) -> str:
         strval = json.dumps(self.value, indent=2)
-        return "\n".join([
+        return "\n".join((
             super().__str__(),
             f"  json value was: {strval}",
-        ])
+        ))
diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index a4ffdfad51b..86e588881b7 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -80,7 +80,7 @@ class ConnectError(QMPError):
     :param exc: The root-cause exception.
     """
     def __init__(self, error_message: str, exc: Exception):
-        super().__init__(error_message)
+        super().__init__(error_message, exc)
         #: Human-readable error string
         self.error_message: str = error_message
         #: Wrapped root cause exception
@@ -108,11 +108,14 @@ class StateError(QMPError):
     """
     def __init__(self, error_message: str,
                  state: Runstate, required: Runstate):
-        super().__init__(error_message)
+        super().__init__(error_message, state, required)
         self.error_message = error_message
         self.state = state
         self.required = required
 
+    def __str__(self) -> str:
+        return self.error_message
+
 
 F = TypeVar('F', bound=Callable[..., Any])  # pylint: disable=invalid-name
 
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index 2a817f9db33..a87fb565ab5 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -41,7 +41,7 @@ class _WrappedProtocolError(ProtocolError):
     :param exc: The root-cause exception.
     """
     def __init__(self, error_message: str, exc: Exception):
-        super().__init__(error_message)
+        super().__init__(error_message, exc)
         self.exc = exc
 
     def __str__(self) -> str:
@@ -76,15 +76,21 @@ class ExecuteError(QMPError):
     """
     def __init__(self, error_response: ErrorResponse,
                  sent: Message, received: Message):
-        super().__init__(error_response.error.desc)
+        super().__init__(error_response, sent, received)
         #: The sent `Message` that caused the failure
         self.sent: Message = sent
         #: The received `Message` that indicated failure
         self.received: Message = received
         #: The parsed error response
         self.error: ErrorResponse = error_response
-        #: The QMP error class
-        self.error_class: str = error_response.error.class_
+
+    @property
+    def error_class(self) -> str:
+        """The QMP error class"""
+        return self.error.error.class_
+
+    def __str__(self) -> str:
+        return self.error.error.desc
 
 
 class ExecInterruptedError(QMPError):
@@ -110,8 +116,8 @@ class _MsgProtocolError(ProtocolError):
     :param error_message: Human-readable string describing the error.
     :param msg: The QMP `Message` that caused the error.
     """
-    def __init__(self, error_message: str, msg: Message):
-        super().__init__(error_message)
+    def __init__(self, error_message: str, msg: Message, *args: object):
+        super().__init__(error_message, msg, *args)
         #: The received `Message` that caused the error.
         self.msg: Message = msg
 
@@ -150,7 +156,7 @@ class BadReplyError(_MsgProtocolError):
     :param sent: The message that was sent that prompted the error.
     """
     def __init__(self, error_message: str, msg: Message, sent: Message):
-        super().__init__(error_message, msg)
+        super().__init__(error_message, msg, sent)
         #: The sent `Message` that caused the failure
         self.sent = sent
 
-- 
2.51.0


