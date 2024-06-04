Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F9C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYV-00071B-I0; Tue, 04 Jun 2024 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYT-0006nE-OZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYS-0003BZ-1w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYZr3fwgw717JFUyBmktse/fqjl/ZkKCOJMRUp6hAp4=;
 b=JG3u9lCL2mFMKOxIpmqpTjN0eo9sTLUY+H/Q0SzNmwZheGJ9UWSqy3YGowGDoVNfsVY7iX
 Wtak7XwVWC/f20kSG3Ee1NcfM5+MEqOna7wiPjVJCxuLLuQyBYnJ1T8lLdiQpyltq/lTVP
 CqrqwAu+FzxZtA9pvNXgmDnNb01rHYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-ukYt0j7WMDakCACaJGzbvQ-1; Tue, 04 Jun 2024 09:50:19 -0400
X-MC-Unique: ukYt0j7WMDakCACaJGzbvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9506A8038E3;
 Tue,  4 Jun 2024 13:50:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC678C15C41;
 Tue,  4 Jun 2024 13:50:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 18/20] qga: add note about where to disable commands for a
 platform
Date: Tue,  4 Jun 2024 14:49:31 +0100
Message-ID: <20240604134933.220112-19-berrange@redhat.com>
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

Any command that is known to be unimplemented on a given build target
must be disabled using a QAPI schema conditional. Only use dynamidc
disabling for commands that require a runtime feature check.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 8 +++++++-
 qga/commands-win32.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index f4104f2760..8f09162562 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1136,7 +1136,13 @@ error:
 
 #endif /* HAVE_GETIFADDRS */
 
-/* add unsupported commands to the list of blocked RPCs */
+/*
+ * Add commands that cannot be supported based on the results of
+ * dynamic check of the running OS installation.
+ *
+ * Commands that cannot be supported at all on a given platform
+ * should be disabled with a condition in the QAPI schema.
+ */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
     return blockedrpcs;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2533e4c748..0198e37a96 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1958,7 +1958,13 @@ done:
     g_free(rawpasswddata);
 }
 
-/* add unsupported commands to the list of blocked RPCs */
+/*
+ * Add commands that cannot be supported based on the results of
+ * dynamic check of the running OS installation.
+ *
+ * Commands that cannot be supported at all on Wnidows
+ * should be disabled with a condition in the QAPI schema.
+ */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
     if (!vss_init(true)) {
-- 
2.45.1


