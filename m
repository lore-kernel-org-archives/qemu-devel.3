Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF9EC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23GS-0007Mu-0U; Tue, 08 Apr 2025 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Ft-0007E2-VT
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fo-0001ZU-U8
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744096813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io1drieqA9gWXN/9jVeEZrQYhhZy/UCd+JEB2fjOiH8=;
 b=Y/pWoMfmxGamow5kQWmeYDKHVYCQXepRFI2jb/2w2+lPFedKezYWoDnIWeqcrj5jRMB0VS
 mOGiT9dBf2rhlB3Z19mH5at3VpOMdA6X2d/Pu1DmC77/3UJd3RpNx81UDAsDHBy+5BQR1K
 qbCRB/NzFpQQ97RuvMYlJ5AUBbLtb1E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-ExB8BLXqM7aRJlvJ2cpRZw-1; Tue,
 08 Apr 2025 03:20:09 -0400
X-MC-Unique: ExB8BLXqM7aRJlvJ2cpRZw-1
X-Mimecast-MFC-AGG-ID: ExB8BLXqM7aRJlvJ2cpRZw_1744096808
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58B42180AB19
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16D6018009BC
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 18B3721E65EC; Tue, 08 Apr 2025 09:20:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 10/11] storage-daemon/qapi/qapi-schema: Add a proper
 introduction
Date: Tue,  8 Apr 2025 09:20:00 +0200
Message-ID: <20250408072001.2518323-11-armbru@redhat.com>
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com>
References: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

Contents adapted from qapi/qapi-schema.json.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250404121413.1743790-11-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 storage-daemon/qapi/qapi-schema.json | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index 2a562ee32e..0427594c98 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -14,10 +14,26 @@
 # storage daemon.
 
 ##
-# = QEMU storage daemon protocol commands and structs
+# = Introduction
 #
-# For a concise listing of all commands, events, and types in the QEMU
-# storage daemon, please consult the `qapi-qsd-index`.
+# This manual describes the commands and events supported by the QEMU
+# storage daemon QMP.
+#
+# For locating a particular item, please see the `qapi-qsd-index`.
+#
+# The following notation is used in examples:
+#
+# .. qmp-example::
+#
+#   -> ... text sent by client (commands) ...
+#   <- ... text sent by server (command responses and events) ...
+#
+# Example text is formatted for readability.  However, in real
+# protocol usage, its commonly emitted as a single line.
+#
+# Please refer to the
+# :doc:`QEMU Machine Protocol Specification </interop/qmp-spec>`
+# for the general format of commands, responses, and events.
 ##
 
 
-- 
2.48.1


