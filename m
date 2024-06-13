Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3803CC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHme3-0006iA-9Q; Thu, 13 Jun 2024 11:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdC-0005jl-JN
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdA-0003e8-Pt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cP5eDyTferRyEVAqRT0l6V4VNtRugYzuhl1jpEpHhE=;
 b=AI11ABxPUNS2XBl12DFHvTSM1o3HV1ybodRpm7De1Ipfgaw9xsEAupt5Z+baJyit/uzhfg
 EnMccaYd4A6Li8n4CDeeT/t1X4DSu833AN8gRnQ5n1CM+7r2b+7DSMq8HgtOyHSly2v0WC
 lSZ6/h6CwLwzheTUp4kLVj6Bu8WmgRM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-pDKzFwFbNHCIm3ypF_2f9w-1; Thu,
 13 Jun 2024 11:44:48 -0400
X-MC-Unique: pDKzFwFbNHCIm3ypF_2f9w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70B5919560B3; Thu, 13 Jun 2024 15:44:47 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B08813000219; Thu, 13 Jun 2024 15:44:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 16/22] qga: conditionalize schema for commands requiring
 utmpx
Date: Thu, 13 Jun 2024 16:44:00 +0100
Message-ID: <20240613154406.1365469-11-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

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


