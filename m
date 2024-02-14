Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E58C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra94Q-0002sR-Vm; Wed, 14 Feb 2024 01:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ra94Q-0002sI-0y
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:48:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ra94O-0003U2-L8
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707893314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZiYICAEPQEmGjWFcJuqoqXwCObYbxNWa7J9q7/sD8E=;
 b=cFXzZmR9DkAlwake41OxnoTZid5DavFiIP4GIe0CARGzZtMJYoIJPDEJ424nAJeQhi8kkO
 h/eDZvZ3yhYtR0oWIdq2Bc6P9S3iVTJAMOvZHofXaVrsN0L8d4TAewjYS06jTxbQhWE5uB
 Si4YVNTJUN/PXnKLxnoQIflEKybrS64=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-cqQvAB3yPHqOnin68keJ3Q-1; Wed,
 14 Feb 2024 01:47:51 -0500
X-MC-Unique: cqQvAB3yPHqOnin68keJ3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA631C05AE3;
 Wed, 14 Feb 2024 06:47:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC9CE1C060B1;
 Wed, 14 Feb 2024 06:47:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8230121E65EB; Wed, 14 Feb 2024 07:47:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL v2 3/4] qapi/char: Make backend types properly conditional
Date: Wed, 14 Feb 2024 07:47:48 +0100
Message-ID: <20240214064749.1060107-4-armbru@redhat.com>
In-Reply-To: <20240214064749.1060107-1-armbru@redhat.com>
References: <20240214064749.1060107-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

Character backends are actually QOM types.  When a backend's
compile-time conditional QOM type is not compiled in, creation fails
with "'FOO' is not a valid char driver name".  Okay, except
introspecting chardev-add with query-qmp-schema doesn't work then: the
backend type is there even though the QOM type isn't.

A management application can work around this issue by using
qom-list-types instead.

Fix the issue anyway: add the conditionals to the QAPI schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240203080228.2766159-4-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/char.json | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 6c6ad3b10c..2d74e66746 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -472,8 +472,8 @@
 ##
 { 'enum': 'ChardevBackendKind',
   'data': [ 'file',
-            'serial',
-            'parallel',
+            { 'name': 'serial', 'if': 'HAVE_CHARDEV_SERIAL' },
+            { 'name': 'parallel', 'if': 'HAVE_CHARDEV_PARALLEL' },
             'pipe',
             'socket',
             'udp',
@@ -482,10 +482,10 @@
             'mux',
             'msmouse',
             'wctablet',
-            'braille',
+            { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
             'testdev',
             'stdio',
-            'console',
+            { 'name': 'console', 'if': 'CONFIG_WIN32' },
             { 'name': 'spicevmc', 'if': 'CONFIG_SPICE' },
             { 'name': 'spiceport', 'if': 'CONFIG_SPICE' },
             { 'name': 'qemu-vdagent', 'if': 'CONFIG_SPICE_PROTOCOL' },
@@ -614,8 +614,10 @@
   'base': { 'type': 'ChardevBackendKind' },
   'discriminator': 'type',
   'data': { 'file': 'ChardevFileWrapper',
-            'serial': 'ChardevHostdevWrapper',
-            'parallel': 'ChardevHostdevWrapper',
+            'serial': { 'type': 'ChardevHostdevWrapper',
+                        'if': 'HAVE_CHARDEV_SERIAL' },
+            'parallel': { 'type': 'ChardevHostdevWrapper',
+                          'if': 'HAVE_CHARDEV_PARALLEL' },
             'pipe': 'ChardevHostdevWrapper',
             'socket': 'ChardevSocketWrapper',
             'udp': 'ChardevUdpWrapper',
@@ -624,10 +626,12 @@
             'mux': 'ChardevMuxWrapper',
             'msmouse': 'ChardevCommonWrapper',
             'wctablet': 'ChardevCommonWrapper',
-            'braille': 'ChardevCommonWrapper',
+            'braille': { 'type': 'ChardevCommonWrapper',
+                         'if': 'CONFIG_BRLAPI' },
             'testdev': 'ChardevCommonWrapper',
             'stdio': 'ChardevStdioWrapper',
-            'console': 'ChardevCommonWrapper',
+            'console': { 'type': 'ChardevCommonWrapper',
+                         'if': 'CONFIG_WIN32' },
             'spicevmc': { 'type': 'ChardevSpiceChannelWrapper',
                           'if': 'CONFIG_SPICE' },
             'spiceport': { 'type': 'ChardevSpicePortWrapper',
-- 
2.43.0


