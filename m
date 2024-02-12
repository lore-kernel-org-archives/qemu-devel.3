Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFF1C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZS2a-000447-Ew; Mon, 12 Feb 2024 03:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZS2Y-00043d-FF
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZS2X-0007HJ-08
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707727908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWTHcmbEky3hiItKDV7M/GZt0ngVYkFRBdrKbOuF4Cc=;
 b=Ky348BPMcCkp1wvIHedEW6DyX0jXu/DTZdE5wap7ZNlfHpNuGSTR0Y1Mha9gbgcXlgrGDh
 MiYTvyRk85lbY00QmGLW2nXR+N+T5rceIsdTTt0VcXiiivsT+Xi/PRWChL7oNbRdqbhsCA
 U+5vIRb1+xs93MB8l4dPPo4DOe/+sT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-NzDiOZ1xOay2SOHOvAGC5w-1; Mon, 12 Feb 2024 03:51:44 -0500
X-MC-Unique: NzDiOZ1xOay2SOHOvAGC5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 259ED85A588;
 Mon, 12 Feb 2024 08:51:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0310145384C;
 Mon, 12 Feb 2024 08:51:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD2CF21E65ED; Mon, 12 Feb 2024 09:51:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 4/4] qapi/char: Deprecate backend type "memory"
Date: Mon, 12 Feb 2024 09:51:42 +0100
Message-ID: <20240212085142.523317-5-armbru@redhat.com>
In-Reply-To: <20240212085142.523317-1-armbru@redhat.com>
References: <20240212085142.523317-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20240203080228.2766159-5-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 qapi/char.json            | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c7b95e6068..7d9343676c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -380,6 +380,14 @@ Specifying the iSCSI password in plain text on the command line using the
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


