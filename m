Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BF0C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwg-0005xr-BZ; Fri, 04 Apr 2025 08:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwM-0005rl-4N
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwI-0005r6-DP
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkOx9DvyW+UIqO3JgCkIGQT82yofg2cjLuOSgtkw5CQ=;
 b=iX3dKQ3AFAho2l2OiE0j7g38KHigMJR9Oqg6VB7YPC+17t4XwHBpArTvPJWy8AH4SMGUYG
 cMy0htg8HstWySdrdp5f51VA1dQwGZ5raGR3lAD3MXqXOF6a4zKJtxxBZm2qGWd7n9VgYO
 sDWnlDflx3bd3MmTerYJd14w3QaoGlA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-_LBKEJaUOAeKjJIU82CScw-1; Fri,
 04 Apr 2025 08:14:22 -0400
X-MC-Unique: _LBKEJaUOAeKjJIU82CScw-1
X-Mimecast-MFC-AGG-ID: _LBKEJaUOAeKjJIU82CScw_1743768861
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 762C61800258; Fri,  4 Apr 2025 12:14:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB68B1955BC2; Fri,  4 Apr 2025 12:14:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8651B21E65DC; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 09/11] qapi/qapi-schema: Address the introduction's bit rot
Date: Fri,  4 Apr 2025 14:14:11 +0200
Message-ID: <20250404121413.1743790-10-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cut the crap that stopped making sense years ago.  Adjust the
remainder.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qapi-schema.json | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 0d027d5017..7bc600bb76 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -3,37 +3,24 @@
 ##
 # = Introduction
 #
-# This document describes all commands currently supported by QMP.
+# This manual describes the commands and events supported by the QEMU
+# Monitor Protocol (QMP).
 #
 # For locating a particular item, please see the `qapi-qmp-index`.
 #
-# Most of the time their usage is exactly the same as in the user
-# Monitor, this means that any other document which also describe
-# commands (the manpage, QEMU's manual, etc) can and should be
-# consulted.
-#
-# QMP has two types of commands: regular and query commands.  Regular
-# commands usually change the Virtual Machine's state someway, while
-# query commands just return information.  The sections below are
-# divided accordingly.
-#
-# It's important to observe that all communication examples are
-# formatted in a reader-friendly way, so that they're easier to
-# understand.  However, in real protocol usage, they're emitted as a
-# single line.
-#
-# Also, the following notation is used to denote data flow:
-#
-# Example:
+# The following notation is used in examples:
 #
 # .. qmp-example::
 #
 #   -> ... text sent by client (commands) ...
 #   <- ... text sent by server (command responses and events) ...
 #
+# Example text is formatted for readability.  However, in real
+# protocol usage, its commonly emitted as a single line.
+#
 # Please refer to the
 # :doc:`QEMU Machine Protocol Specification </interop/qmp-spec>`
-# for detailed information on the Server command and response formats.
+# for the general format of commands, responses, and events.
 ##
 
 { 'include': 'pragma.json' }
-- 
2.48.1


