Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D6C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKr7-00083i-6G; Mon, 14 Jul 2025 11:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUn-0000PM-8L
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0003cw-OH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tQ/nGBFgj8hUnPDR6SJJ9Xu+NhV1wZSIeMX9Jwnur4=;
 b=iV/0hhkBoHCVTGnz9qhc3OY5Va4oxDNzFf0+FzrJXFOXKAINYafZm1WXx+vGQ0f3qNjJPI
 TW2CBnYr/09tJqWXDTQxPLL8Euodc1WU/mrJiVECtirbDQLfuP9WtiK0WxT4eXHbiX1xpU
 e7veIBo1HZ3Mx9C+CQJmNoHgsa+cxtU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-nEdp5gC2MT23Z6P2RWjdgw-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: nEdp5gC2MT23Z6P2RWjdgw-1
X-Mimecast-MFC-AGG-ID: nEdp5gC2MT23Z6P2RWjdgw_1752500708
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74EC119560AD
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 301AC19560AF
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02E4121E660B; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 16/32] qapi: add cross-references to dump.json
Date: Mon, 14 Jul 2025 15:44:42 +0200
Message-ID: <20250714134458.2991097-17-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-6-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/dump.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index dc92b53247..32c8c1f06e 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -112,7 +112,7 @@
 #
 # Describe the status of a long-running background guest memory dump.
 #
-# @none: no dump-guest-memory has started yet.
+# @none: no `dump-guest-memory` has started yet.
 #
 # @active: there is one dump running in background.
 #
@@ -128,9 +128,9 @@
 ##
 # @DumpQueryResult:
 #
-# The result format for 'query-dump'.
+# The result format for `query-dump`.
 #
-# @status: enum of @DumpStatus, which shows current dump status
+# @status: enum of `DumpStatus`, which shows current dump status
 #
 # @completed: bytes written in latest dump (uncompressed)
 #
@@ -186,7 +186,7 @@
 ##
 # @DumpGuestMemoryCapability:
 #
-# @formats: the available formats for dump-guest-memory
+# @formats: the available formats for `dump-guest-memory`
 #
 # Since: 2.0
 ##
@@ -197,9 +197,9 @@
 ##
 # @query-dump-guest-memory-capability:
 #
-# Return the available formats for dump-guest-memory
+# Return the available formats for `dump-guest-memory`
 #
-# Returns: An object listing available formats for dump-guest-memory
+# Returns: An object listing available formats for `dump-guest-memory`
 #
 # Since: 2.0
 #
-- 
2.49.0


