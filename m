Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA74C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPJ1-00020g-OA; Sun, 23 Feb 2025 22:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPIK-0001Px-VU
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:38:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tmPIH-0005Rl-VU
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740368289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VP5SDk4WkmLEFDLuA4c7QRtXKXfuW84WFZb7/tKq7PU=;
 b=acde/lPeJl3LOpCt2V578OZ0i7bJ1l6KzpYe7isMuXNcX864ZW9xJOOK4dkhKKMlhY/afz
 plTVfK8ueHRthksL578sKniusUCtjkjrp2iHOnM32rdbKU0/CZDveomTI9H7n1aG4v+2De
 Y8ioBtWi9mHhhsTX2bIym4pbq8nsYFg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-AuHs_yNeMkCbz69CtkaH8g-1; Sun,
 23 Feb 2025 22:38:04 -0500
X-MC-Unique: AuHs_yNeMkCbz69CtkaH8g-1
X-Mimecast-MFC-AGG-ID: AuHs_yNeMkCbz69CtkaH8g_1740368283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B406318EB2C6; Mon, 24 Feb 2025 03:38:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D97D919560A3; Mon, 24 Feb 2025 03:38:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/10] qapi/schema: add __repr__ to QAPIDoc.Section
Date: Sun, 23 Feb 2025 22:37:39 -0500
Message-ID: <20250224033741.222749-9-jsnow@redhat.com>
In-Reply-To: <20250224033741.222749-1-jsnow@redhat.com>
References: <20250224033741.222749-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Makes debugging far more pleasant when you can just print(section) and
get something reasonable to display.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c3004aa70c6..617711b1f04 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -673,6 +673,9 @@ def __init__(
             # section text without tag
             self.text = ''
 
+        def __repr__(self) -> str:
+            return f"<QAPIDoc.Section kind={self.kind!r} text={self.text!r}>"
+
         def append_line(self, line: str) -> None:
             self.text += line + '\n'
 
@@ -687,6 +690,12 @@ def __init__(
             self.name = name
             self.member: Optional['QAPISchemaMember'] = None
 
+        def __repr__(self) -> str:
+            return (
+                f"<QAPIDoc.ArgSection kind={self.kind!r} "
+                f"name={self.name!r} text={self.text!r}>"
+            )
+
         def connect(self, member: 'QAPISchemaMember') -> None:
             self.member = member
 
-- 
2.48.1


