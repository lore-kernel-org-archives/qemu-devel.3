Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763BECA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utB7b-00048E-E0; Mon, 01 Sep 2025 16:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7V-000467-Qp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7U-0008Lf-Et
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756758435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHcWkc3P5BrkTo+wY0LYOsbpNSwFaqwF1CJ9Qo0H2dw=;
 b=XELd4FnVL9CWNy9heAuX07hCpva3oUKluyW7sRZLaNWJJgE6V1oRaxS1mjvsKLFVOeVcjF
 Vf5FY6fHnMXtAVPLMtRukpkYqrpyCqnIsV6MUsDAwZ1YUGKeFiASClbscO5OY8gAJwK/S6
 J87x2W+TldZDWxqbrtMQRU1msdxLtq8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-fZID8ix8PzSyY7jDCI8lYw-1; Mon,
 01 Sep 2025 16:27:12 -0400
X-MC-Unique: fZID8ix8PzSyY7jDCI8lYw-1
X-Mimecast-MFC-AGG-ID: fZID8ix8PzSyY7jDCI8lYw_1756758431
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C96FB19560AA; Mon,  1 Sep 2025 20:27:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 838BA19560AB; Mon,  1 Sep 2025 20:27:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 02/19] python: backport 'EventListener: add __repr__ method'
Date: Mon,  1 Sep 2025 16:26:44 -0400
Message-ID: <20250901202702.2971212-3-jsnow@redhat.com>
In-Reply-To: <20250901202702.2971212-1-jsnow@redhat.com>
References: <20250901202702.2971212-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the object is not stateful, this repr method prints what you'd
expect. In cases where there are pending events, the output is augmented
to illustrate that.

The object itself has no idea if it's "active" or not, so it cannot
convey that information.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit 8a6f2e136dae395fec8aa5fd77487cfe12d9e05e
---
 python/qemu/qmp/events.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
index 6199776cc66..66583496192 100644
--- a/python/qemu/qmp/events.py
+++ b/python/qemu/qmp/events.py
@@ -497,6 +497,21 @@ def __init__(
         #: Optional, secondary event filter.
         self.event_filter: Optional[EventFilter] = event_filter
 
+    def __repr__(self) -> str:
+        args: List[str] = []
+        if self.names:
+            args.append(f"names={self.names!r}")
+        if self.event_filter:
+            args.append(f"event_filter={self.event_filter!r}")
+
+        if self._queue.qsize():
+            state = f"<pending={self._queue.qsize()}>"
+        else:
+            state = ''
+
+        argstr = ", ".join(args)
+        return f"{type(self).__name__}{state}({argstr})"
+
     @property
     def history(self) -> Tuple[Message, ...]:
         """
-- 
2.50.1


