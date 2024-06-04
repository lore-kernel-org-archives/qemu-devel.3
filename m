Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DDEC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYR-0006bt-RU; Tue, 04 Jun 2024 09:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYP-0006aM-Qu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYN-0003AO-3m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQ4M6CW3rYAt+E6v3ZCnO9rcVZFq+BdWy1qO/IF7b/k=;
 b=ThpRlkz/7VfqTsYt4LA59twL17LKZ/p1G5+ohtWyHC3DqhT5GuPrDu2yZJE47cnHnu+76Q
 6GwhWfkc97L1DM8eKNTLzyyBWO1s8e1B7U+crUPMwktOuQvdwWpFFaVB5DxkE6Bv/Jr/bP
 WbnxHaRiwwUyIJsIfd04frVZqNYHsBk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630--Fo_AEcJNDyUp2KBRG0xmQ-1; Tue,
 04 Jun 2024 09:50:14 -0400
X-MC-Unique: -Fo_AEcJNDyUp2KBRG0xmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61C853C0008A;
 Tue,  4 Jun 2024 13:50:14 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5C7CC15C12;
 Tue,  4 Jun 2024 13:50:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 16/20] qga: conditionalize schema for commands requiring utmpx
Date: Tue,  4 Jun 2024 14:49:29 +0100
Message-ID: <20240604134933.220112-17-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-1-berrange@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the get-users command on POSIX
platforms lacking required APIs.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 10 +---------
 qga/qapi-schema.json |  6 ++++--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index d92fa0ec87..a353f64ae6 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1212,15 +1212,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
     return head;
 }
 
-#else
-
-GuestUserList *qmp_guest_get_users(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-#endif
+#endif /* HAVE_UTMPX */
 
 /* Replace escaped special characters with their real values. The replacement
  * is done in place -- returned value is in the original string.
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 0b7f911ca5..70d4f173ad 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1413,7 +1413,8 @@
 # Since: 2.10
 ##
 { 'struct': 'GuestUser',
-  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' } }
+  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' },
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
 
 ##
 # @guest-get-users:
@@ -1425,7 +1426,8 @@
 # Since: 2.10
 ##
 { 'command': 'guest-get-users',
-  'returns': ['GuestUser'] }
+  'returns': ['GuestUser'],
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
 
 ##
 # @GuestTimezone:
-- 
2.45.1


