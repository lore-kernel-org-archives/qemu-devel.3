Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD12EC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIV-0005Ca-Cm; Tue, 08 Jul 2025 16:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZELL-000503-Gt
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZELI-00085h-7z
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752004263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EF/7oRW56kxgQgBmtbilXnq8uXusNqlDQOz1y4eSKVA=;
 b=iNBdkgZ2M2vSsW9+jIT40piwdtFWOlPKKhh+05Y16DLOBK7yl5jabI6UeE1IJB4bLknGCR
 fUHd5khn+FUYLw6ekXMzAWXmmDz+r36Mk5Nhgkg84iLVG3DDzSgxyesPXuzcNVKtk8KUnm
 exhNBG/tkOWUYR+pWJ45SMRIpgcQhKo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-LoGiApbhN3iAjPvEPRfPWg-1; Tue,
 08 Jul 2025 03:28:32 -0400
X-MC-Unique: LoGiApbhN3iAjPvEPRfPWg-1
X-Mimecast-MFC-AGG-ID: LoGiApbhN3iAjPvEPRfPWg_1751959711
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A6E3180028C; Tue,  8 Jul 2025 07:28:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C02A1956087; Tue,  8 Jul 2025 07:28:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3EFC821E6924; Tue, 08 Jul 2025 09:28:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, steven.sistare@oracle.com
Subject: [PATCH 1/2] qapi: Clean up "This command will do ..." command
 descriptions
Date: Tue,  8 Jul 2025 09:28:27 +0200
Message-ID: <20250708072828.105185-2-armbru@redhat.com>
In-Reply-To: <20250708072828.105185-1-armbru@redhat.com>
References: <20250708072828.105185-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use imperative mood "Do ..." instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/control.json   |  9 +++++----
 qapi/misc-i386.json | 11 +++++------
 qapi/qom.json       | 10 ++++------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 34b733f63b..1bc4ac8734 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -158,10 +158,11 @@
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
index b133b06447..9670d10246 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -48,8 +48,7 @@
 ##
 # @qom-list:
 #
-# This command will list any properties of a object given a path in
-# the object model.
+# List properties of a object given a path in the object model.
 #
 # @path: the path within the object model.  See @qom-get for a
 #     description of this parameter.
@@ -76,8 +75,7 @@
 ##
 # @qom-get:
 #
-# This command will get a property from a object model path and return
-# the value.
+# Get a property value.
 #
 # @path: The path within the object model.  There are two forms of
 #     supported paths--absolute and partial paths.
@@ -128,7 +126,7 @@
 ##
 # @qom-set:
 #
-# This command will set a property from a object model path.
+# Set a property value.
 #
 # @path: see @qom-get for a description of this parameter
 #
@@ -171,7 +169,7 @@
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


