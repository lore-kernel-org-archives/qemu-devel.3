Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F614C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn49-0002rT-5b; Mon, 22 Jul 2024 03:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn46-0002Re-8M
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn44-0006hW-F3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NE1m+6b/EcjuHgXsuhW3c0W5Ezdqh0PyXac4E9BN6HI=;
 b=FyHFiS5OA15K0gNZESY6zKuyyg6KhFCpHd69QuEn8cKv7LzJw6IP1kKk/sfVZWubECS9qF
 QzcUOgAObucvQOYB1c+0zU6gMceZCPqyyAhFWgwBVfFIxSR1FPPLxJe23kZU1e7eXZq9K7
 d4vIXQaitph0Oa3XT30vLbhRIPEAVCk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-zJJBSoIaP0mTwK-bGZkCBg-1; Mon,
 22 Jul 2024 03:02:25 -0400
X-MC-Unique: zJJBSoIaP0mTwK-bGZkCBg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D116818EB232; Mon, 22 Jul 2024 07:02:11 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D1281944A83; Mon, 22 Jul 2024 07:02:10 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 16/25] qga: conditionalize schema for commands requiring utmpx
Date: Mon, 22 Jul 2024 10:01:13 +0300
Message-ID: <20240722070122.27615-17-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


