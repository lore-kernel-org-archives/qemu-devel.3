Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB97ECA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfnP-0006WO-AO; Wed, 03 Sep 2025 01:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmf-0006Ec-Fl
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmX-0006Nu-Ji
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96fcc12r2NZGoWcAWvZ/2KcZ+/kTHQQsPcjDbDUtkY8=;
 b=jJnC99kXzAkg43tLHH/6Vy/2zi6CBUZAm7XT4QVcmS9XpWZfdpgxVVSMnw9LW6Cbe2sT6p
 V0FjOY/wSiNRYQ6PINZ8H1SJTrvA7Swb7QcQaQhCOmdjAEPBaK9XgoJQ8EAn0pi9vfSzxA
 8nEDNyHpxPf6qQUvI32XC1rmObMxD8w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-04VxaiosPrKs-pW5y5GD1Q-1; Wed,
 03 Sep 2025 01:11:39 -0400
X-MC-Unique: 04VxaiosPrKs-pW5y5GD1Q-1
X-Mimecast-MFC-AGG-ID: 04VxaiosPrKs-pW5y5GD1Q_1756876298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2678F1956050; Wed,  3 Sep 2025 05:11:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AACF19560A2; Wed,  3 Sep 2025 05:11:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 04/18] python: backport 'protocol: adjust logging name when
 changing client name'
Date: Wed,  3 Sep 2025 01:11:10 -0400
Message-ID: <20250903051125.3020805-5-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The client name is mutable, so the logging name should also change to
reflect it when it changes.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit e10b73c633ce138ba30bc8beccd2ab31989eaf3d
---
 python/qemu/qmp/protocol.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 86e588881b7..ec4762c567b 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -217,10 +217,8 @@ class AsyncProtocol(Generic[T]):
     # -------------------------
 
     def __init__(self, name: Optional[str] = None) -> None:
-        #: The nickname for this connection, if any.
-        self.name: Optional[str] = name
-        if self.name is not None:
-            self.logger = self.logger.getChild(self.name)
+        self._name: Optional[str]
+        self.name = name
 
         # stream I/O
         self._reader: Optional[StreamReader] = None
@@ -257,6 +255,24 @@ def __repr__(self) -> str:
         tokens.append(f"runstate={self.runstate.name}")
         return f"<{cls_name} {' '.join(tokens)}>"
 
+    @property
+    def name(self) -> Optional[str]:
+        """
+        The nickname for this connection, if any.
+
+        This name is used for differentiating instances in debug output.
+        """
+        return self._name
+
+    @name.setter
+    def name(self, name: Optional[str]) -> None:
+        logger = logging.getLogger(__name__)
+        if name:
+            self.logger = logger.getChild(name)
+        else:
+            self.logger = logger
+        self._name = name
+
     @property  # @upper_half
     def runstate(self) -> Runstate:
         """The current `Runstate` of the connection."""
-- 
2.50.1


