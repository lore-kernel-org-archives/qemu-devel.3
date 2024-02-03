Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E8CC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 08:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWAz4-0003ap-N8; Sat, 03 Feb 2024 03:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWAz2-0003a5-VY
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWAz0-00081Q-Qq
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706947358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/E/JvkeI/fr7kgmUzJT2i57ToPizfNyWV9QJp2tTUAs=;
 b=X5bsopZD3aXhN3tS/JEUWKbLXi0C1mNCT92K69dVXCwMaOsMzbF9XiuAYTzXAKAOvgMcna
 CTEgCuFTQ1KbtIKBe8fqn6e5EDdfigrmpL3oOBu95wQrVRJ11f54czRWivWtpA7yjXUcRe
 bT7qhIc5P1DxM/iUc6a6K2myFfdStpA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-FkinZXmvNuSpVN2-z5vRgA-1; Sat,
 03 Feb 2024 03:02:34 -0500
X-MC-Unique: FkinZXmvNuSpVN2-z5vRgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECF733C0F193;
 Sat,  3 Feb 2024 08:02:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0AF42028CD2;
 Sat,  3 Feb 2024 08:02:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA83B21E6690; Sat,  3 Feb 2024 09:02:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com
Subject: [PATCH 4/4] qapi/char: Deprecate backend type "memory"
Date: Sat,  3 Feb 2024 09:02:28 +0100
Message-ID: <20240203080228.2766159-5-armbru@redhat.com>
In-Reply-To: <20240203080228.2766159-1-armbru@redhat.com>
References: <20240203080228.2766159-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It's an alias for "ringbuf" we kept for backward compatibility; see
commit 3a1da42eb35 (qapi: Rename ChardevBackend member "memory" to
"ringbuf").  Deprecation is long overdue.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 qapi/char.json            | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d4492b9460..ae1a520c26 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -371,6 +371,14 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+Character device options
+''''''''''''''''''''''''
+
+Backend ``memory`` (since 9.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+``memory`` is a deprecated synonym for ``ringbuf``.
+
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/qapi/char.json b/qapi/char.json
index 2d74e66746..75a7e057f0 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -468,6 +468,10 @@
 #
 # @memory: Since 1.5
 #
+# Features:
+#
+# @deprecated: Member @memory is deprecated.  Use @ringbuf instead.
+#
 # Since: 1.4
 ##
 { 'enum': 'ChardevBackendKind',
@@ -492,8 +496,7 @@
             { 'name': 'dbus', 'if': 'CONFIG_DBUS_DISPLAY' },
             'vc',
             'ringbuf',
-            # next one is just for compatibility
-            'memory' ] }
+            { 'name': 'memory', 'features': [ 'deprecated' ] } ] }
 
 ##
 # @ChardevFileWrapper:
@@ -642,7 +645,6 @@
                       'if': 'CONFIG_DBUS_DISPLAY' },
             'vc': 'ChardevVCWrapper',
             'ringbuf': 'ChardevRingbufWrapper',
-            # next one is just for compatibility
             'memory': 'ChardevRingbufWrapper' } }
 
 ##
-- 
2.43.0


