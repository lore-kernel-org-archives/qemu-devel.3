Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1FAC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKmc-0005tI-5R; Mon, 14 Jul 2025 11:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUg-0000Lz-6Y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUT-0003bR-VT
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3q/bW+GcuB7r8oOsorennTkn1NwHdWIIWWCKtwf0KS4=;
 b=KMgLm4/9mFmsIuaQOjeM7qJ3bFp5d+a4UUitp9PX91SBoJBJqJCVGbEDLLKFphiJDXBZhr
 SH7YvrGttMVH/Dm5604eUhywOuiRZ94nx98jGfmz1lOBM3Dg4x8bj40BjxkiHQEkH7YYSR
 V4ztiUxkmbpTUv9yBhamR44OWMT80iA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-jvXizUH7MbG6lTYKPIL-Kw-1; Mon,
 14 Jul 2025 09:45:06 -0400
X-MC-Unique: jvXizUH7MbG6lTYKPIL-Kw-1
X-Mimecast-MFC-AGG-ID: jvXizUH7MbG6lTYKPIL-Kw_1752500705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A67A419560B9
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 538271977000
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE9B121E6773; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/32] qapi: Clean up "This command will do ..." command
 descriptions
Date: Mon, 14 Jul 2025 15:44:32 +0200
Message-ID: <20250714134458.2991097-7-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use imperative mood "Do ..." instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250708072828.105185-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/control.json   |  9 +++++----
 qapi/misc-i386.json | 11 +++++------
 qapi/qom.json       | 10 ++++------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index ab0b3a3bbe..5fed0701f8 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -160,10 +160,11 @@
 ##
 # @quit:
 #
-# This command will cause the QEMU process to exit gracefully.  While
-# every attempt is made to send the QMP response before terminating,
-# this is not guaranteed.  When using this interface, a premature EOF
-# would not be unexpected.
+# Request graceful QEMU process termination.
+#
+# While every attempt is made to send the QMP response before
+# terminating, this is not guaranteed.  When using this interface, a
+# premature EOF would not be unexpected.
 #
 # Since: 0.14
 #
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 5fefa0a484..b53ed39288 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -6,9 +6,9 @@
 ##
 # @rtc-reset-reinjection:
 #
-# This command will reset the RTC interrupt reinjection backlog.  Can
-# be used if another mechanism to synchronize guest time is in effect,
-# for example QEMU guest agent's guest-set-time command.
+# Reset the RTC interrupt reinjection backlog.  Can be used if another
+# mechanism to synchronize guest time is in effect, for example QEMU
+# guest agent's guest-set-time command.
 #
 # Use of this command is only applicable for x86 machines with an RTC,
 # and on other machines will silently return without performing any
@@ -233,8 +233,7 @@
 ##
 # @sev-inject-launch-secret:
 #
-# This command injects a secret blob into memory of a SEV/SEV-ES
-# guest.
+# Inject a secret blob into a SEV/SEV-ES guest's memory.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  SEV-SNP guests do
@@ -272,7 +271,7 @@
 ##
 # @query-sev-attestation-report:
 #
-# This command is used to get the SEV attestation report.
+# Get the SEV attestation report.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The attestation
diff --git a/qapi/qom.json b/qapi/qom.json
index f68f72fbbc..6c38e865a6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -50,8 +50,7 @@
 ##
 # @qom-list:
 #
-# This command will list any properties of a object given a path in
-# the object model.
+# List properties of a object given a path in the object model.
 #
 # @path: the path within the object model.  See @qom-get for a
 #     description of this parameter.
@@ -78,8 +77,7 @@
 ##
 # @qom-get:
 #
-# This command will get a property from a object model path and return
-# the value.
+# Get a property value.
 #
 # @path: The path within the object model.  There are two forms of
 #     supported paths--absolute and partial paths.
@@ -130,7 +128,7 @@
 ##
 # @qom-set:
 #
-# This command will set a property from a object model path.
+# Set a property value.
 #
 # @path: see @qom-get for a description of this parameter
 #
@@ -173,7 +171,7 @@
 ##
 # @qom-list-types:
 #
-# This command will return a list of types given search parameters
+# Return a list of types given search parameters.
 #
 # @implements: if specified, only return types that implement this
 #     type name
-- 
2.49.0


