Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35297C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Ye-0006aJ-K5; Tue, 23 Jul 2024 03:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Ya-0006LH-TR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YZ-0000tK-3f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NE1m+6b/EcjuHgXsuhW3c0W5Ezdqh0PyXac4E9BN6HI=;
 b=QiOhrnt4RzeWAu8yjpRbI6RrIDp5b8LLJDhvELv1moocudexXAjx2gh4sEzzEjdlkdLnum
 IkDVjorgJAeQJ1jH5VwDV5CYm4zAwVRbCHzQVbE94XwpWWmtgTEZdC7R5FcOE3ppt6BavH
 UUiwan3HPYLitjtLvQvo4FaBYoUSUck=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-pV6RG1SzMVeSqjMzP7OsBA-1; Tue,
 23 Jul 2024 03:03:28 -0400
X-MC-Unique: pV6RG1SzMVeSqjMzP7OsBA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA0CB1955D52; Tue, 23 Jul 2024 07:03:27 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62ED13000192; Tue, 23 Jul 2024 07:03:26 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 16/25] qga: conditionalize schema for commands requiring
 utmpx
Date: Tue, 23 Jul 2024 10:02:42 +0300
Message-ID: <20240723070251.25575-17-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the get-users command on POSIX
platforms lacking required APIs.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-17-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
index cf1ad42519..0662a68c43 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1414,7 +1414,8 @@
 # Since: 2.10
 ##
 { 'struct': 'GuestUser',
-  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' } }
+  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' },
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
 
 ##
 # @guest-get-users:
@@ -1426,7 +1427,8 @@
 # Since: 2.10
 ##
 { 'command': 'guest-get-users',
-  'returns': ['GuestUser'] }
+  'returns': ['GuestUser'],
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
 
 ##
 # @GuestTimezone:
-- 
2.45.2


