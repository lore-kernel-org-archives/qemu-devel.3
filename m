Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D82C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKpo-000409-QK; Mon, 14 Jul 2025 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0000GO-8K
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUS-0003bN-Qo
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyZcrwnCLaLvW4YdnG8ypJUNcE3idD2PpbQHZael9Bc=;
 b=USwX3p5pNUeDP8CH4Pob/lZt77/XXntDu7JqZ+a0ZV9icf3KaJImNDM+113rxP0auTI7+D
 +cddbxZk3wXaExqXyf73686vHyw3pZTn2VsqKMBB05lQPaEcTOHwqU4TnsAVuBT9om4Z3O
 n6WVifJFPY7afUPWjr480OWudPPvBgs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-Lymspn52NVSjdBWiBwC6RQ-1; Mon,
 14 Jul 2025 09:45:06 -0400
X-MC-Unique: Lymspn52NVSjdBWiBwC6RQ-1
X-Mimecast-MFC-AGG-ID: Lymspn52NVSjdBWiBwC6RQ_1752500705
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 714E5180029F
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A7718002B2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D260221E6774; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/32] qapi: Clean up a few Errors: sections
Date: Mon, 14 Jul 2025 15:44:33 +0200
Message-ID: <20250714134458.2991097-8-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Use the conventional "- If <error-condition>" phrasing, optionally
with ", <error-class>".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250708072828.105185-3-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/misc-i386.json | 7 +++----
 qapi/qom.json       | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index b53ed39288..24a2e143f6 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -283,10 +283,9 @@
 # Returns: SevAttestationReport objects.
 #
 # Errors:
-#     - This will return an error if the attestation report is
-#       unavailable, either due to an invalid guest configuration
-#       or if the guest has not reached the required SEV state,
-#       GenericError
+#     - If the attestation report is unavailable, either due to an
+#       invalid guest configuration or because the guest has not
+#       reached the required SEV state, GenericError
 #
 # Since: 6.1
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 6c38e865a6..fbf94b9e09 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1261,7 +1261,7 @@
 # Create a QOM object.
 #
 # Errors:
-#     - Error if @qom-type is not a valid class name
+#     - If @qom-type is not a valid class name
 #
 # Since: 2.0
 #
@@ -1283,7 +1283,7 @@
 # @id: the name of the QOM object to remove
 #
 # Errors:
-#     - Error if @id is not a valid id for a QOM object
+#     - If @id is not a valid id for a QOM object
 #
 # Since: 2.0
 #
-- 
2.49.0


