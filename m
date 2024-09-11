Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66DBEE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOad-0002pj-Hz; Wed, 11 Sep 2024 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soOUB-0004Ws-Gv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soOU6-0005Mx-E0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sF/axt7gHoI/0iIPWhb44khszupbbhA6fHi/Tq9S3c0=;
 b=ISV9PSz9CbbEgRCoty58rFwUKBrirTgR9qKWaVlgfBWUClDcuR2toD9ninsUOrQkwBJNHK
 jS+I5DEC8AwsQKZ/MPDee1qI0BmAzG2oMQ2ZvQYxJM003p8aLVS/D4rYcGMm/8GoThHJCO
 TcUGyGbf5oQT01Asd5F+Gw2FspLOdWo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-N0adUVuLNRmNR1TrJ5JRqg-1; Wed,
 11 Sep 2024 09:25:07 -0400
X-MC-Unique: N0adUVuLNRmNR1TrJ5JRqg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2B821955F40; Wed, 11 Sep 2024 13:25:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 721EE30001A1; Wed, 11 Sep 2024 13:25:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1394B21E691E; Wed, 11 Sep 2024 15:24:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 qemu-block@nongnu.org, jsnow@redhat.com
Subject: [PATCH 1/2] qapi: Drop "with an explanation" from error descriptions
Date: Wed, 11 Sep 2024 15:24:58 +0200
Message-ID: <20240911132459.2548063-2-armbru@redhat.com>
In-Reply-To: <20240911132459.2548063-1-armbru@redhat.com>
References: <20240911132459.2548063-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All errors come with an explanation, namely the human-readable error
message in the error response's @desc member.  Drop the redundant
"with an explanation" phrase.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9f6dd59298..82f59a7758 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2299,7 +2299,7 @@
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
-#     - If @name is already taken, GenericError with an explanation
+#     - If @name is already taken, GenericError
 #
 # Since: 2.4
 #
@@ -2322,7 +2322,7 @@
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
-#     - If @name is not found, GenericError with an explanation
+#     - If @name is not found, GenericError
 #     - if @name is frozen by an operation, GenericError
 #
 # Since: 2.4
@@ -2346,7 +2346,7 @@
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
-#     - If @name is not found, GenericError with an explanation
+#     - If @name is not found, GenericError
 #
 # Since: 2.4
 #
@@ -2367,7 +2367,7 @@
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
-#     - If @name is not found, GenericError with an explanation
+#     - If @name is not found, GenericError
 #
 # Since: 4.0
 #
@@ -2388,7 +2388,7 @@
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
-#     - If @name is not found, GenericError with an explanation
+#     - If @name is not found, GenericError
 #
 # Since: 4.0
 #
@@ -2462,7 +2462,6 @@
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found or if hashing has failed, GenericError
-#       with an explanation
 #
 # Since: 2.10
 ##
-- 
2.46.0


