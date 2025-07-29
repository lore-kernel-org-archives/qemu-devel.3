Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65DFC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugk7w-00019z-HA; Tue, 29 Jul 2025 09:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7m-0000Mv-Tj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7b-0001P2-C0
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753794714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OcMwyhfWDYTxeQShNJ68f9SR5yfoYsi2f9K+7EqHMo=;
 b=WTX8/yYuxtu4eNOKWdST/JuDV7LLni7P/tT3IwDq1HT6+rDFu8cLio45KI+vz4FIMVkYhb
 fwxF05/p3TixCsiFG2X1bgE3GSA6LC4MT8pee0F0YzrShGcAwUJoWVxl19+MojbhQp3LdB
 AH6vvwB6A3//qCmp553Y9t0yUUsESdw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-SEQj6Un9PAWzkAkoKjISPw-1; Tue,
 29 Jul 2025 09:11:52 -0400
X-MC-Unique: SEQj6Un9PAWzkAkoKjISPw-1
X-Mimecast-MFC-AGG-ID: SEQj6Un9PAWzkAkoKjISPw_1753794711
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5E24180034A
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B23B1955F16
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6241F21E6924; Tue, 29 Jul 2025 15:11:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 1/5] qapi: Add more cross-references
Date: Tue, 29 Jul 2025 15:11:44 +0200
Message-ID: <20250729131148.3777401-2-armbru@redhat.com>
In-Reply-To: <20250729131148.3777401-1-armbru@redhat.com>
References: <20250729131148.3777401-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently (merge commit 504632dcc631) enclosed command and type
names in `backquotes`, so they become links in generated HTML.  Take
care of a few we missed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250717115751.3832597-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/dump.json      | 2 +-
 qapi/machine.json   | 2 +-
 qapi/migration.json | 4 ++--
 qapi/misc-i386.json | 2 +-
 qapi/run-state.json | 2 +-
 qapi/sockets.json   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 32c8c1f06e..726b520870 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -79,7 +79,7 @@
 #
 # @detach: if true, QMP will return immediately rather than waiting
 #     for the dump to finish.  The user can track progress using
-#     "query-dump".  (since 2.6).
+#     `query-dump`.  (since 2.6).
 #
 # @begin: if specified, the starting physical address.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 6f59f70ca6..038eab281c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -2087,7 +2087,7 @@
 #
 # @deprecated-props: an optional list of properties that are flagged as
 #     deprecated by the CPU vendor.  The list depends on the
-#     CpuModelExpansionType: "static" properties are a subset of the
+#     `CpuModelExpansionType`: "static" properties are a subset of the
 #     enabled-properties for the expanded model; "full" properties are
 #     a set of properties that are deprecated across all models for
 #     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
diff --git a/qapi/migration.json b/qapi/migration.json
index e08a99bb82..2387c21e9c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -641,7 +641,7 @@
 #
 #     This mode supports VFIO devices provided the user first puts the
 #     guest in the suspended runstate, such as by issuing
-#     guest-suspend-ram to the QEMU guest agent.
+#     `guest-suspend-ram` to the QEMU guest agent.
 #
 #     Best performance is achieved when the memory backend is shared
 #     and the @x-ignore-shared migration capability is set, but this
@@ -1704,7 +1704,7 @@
 #
 # .. admonition:: Notes
 #
-#     1. The 'query-migrate' command should be used to check
+#     1. The `query-migrate` command should be used to check
 #        migration's progress and final result (this information is
 #        provided by the 'status' member).
 #
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index c8c91a241c..d1ce8caf25 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -8,7 +8,7 @@
 #
 # Reset the RTC interrupt reinjection backlog.  Can be used if another
 # mechanism to synchronize guest time is in effect, for example QEMU
-# guest agent's guest-set-time command.
+# guest agent's `guest-set-time` command.
 #
 # Use of this command is only applicable for x86 machines with an RTC,
 # and on other machines will silently return without performing any
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 54ba5c9a3f..4757947ca6 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -20,7 +20,7 @@
 # @inmigrate: guest is paused waiting for an incoming migration.  Note
 #     that this state does not tell whether the machine will start at
 #     the end of the migration.  This depends on the command-line -S
-#     option and any invocation of 'stop' or 'cont' that has happened
+#     option and any invocation of `stop` or `cont` that has happened
 #     since QEMU was started.
 #
 # @internal-error: An internal error that prevents further guest
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 82046b0b3a..32fac51728 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -143,7 +143,7 @@
 #
 # @str: decimal is for file descriptor number, otherwise it's a file
 #     descriptor name.  Named file descriptors are permitted in
-#     monitor commands, in combination with the 'getfd' command.
+#     monitor commands, in combination with the `getfd` command.
 #     Decimal file descriptors are permitted at startup or other
 #     contexts where no monitor context is active.
 #
-- 
2.49.0


