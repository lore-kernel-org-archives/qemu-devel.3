Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8FAC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thVHu-0005cp-EE; Mon, 10 Feb 2025 10:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thVHh-0005Yo-5m
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thVHe-0004pQ-K9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739199672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nv72Qccu1FBLVSgXzjSvJzUKOptPPadwl1TMlr5q+Y=;
 b=bXsZ8wlGS2eVQe6Nu8owYMboiRamen9Y76XITLLfMGllMHazsm8/Abx4VjmqD2pUX2Co9t
 5O6nTlg85SfmT4/48OQeDUwUTIK9zDHcFnmESVTaueAp2+sy/dOGhH/URqzUWP1cm0dX6I
 R5KA1E96cyfMxzWIIjpcvzahOZtUyXw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Oy9NYwZNN8-Zi6vrdYqySg-1; Mon,
 10 Feb 2025 10:01:10 -0500
X-MC-Unique: Oy9NYwZNN8-Zi6vrdYqySg-1
X-Mimecast-MFC-AGG-ID: Oy9NYwZNN8-Zi6vrdYqySg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2FC51800987
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 15:01:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86D1630001AB
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 15:01:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE2D021E6920; Mon, 10 Feb 2025 16:01:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Victor Toso <victortoso@redhat.com>
Subject: [PULL v2 3/8] qapi: fix colon in Since tag section
Date: Mon, 10 Feb 2025 16:01:01 +0100
Message-ID: <20250210150106.3924507-4-armbru@redhat.com>
In-Reply-To: <20250210150106.3924507-1-armbru@redhat.com>
References: <20250210150106.3924507-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

From: Victor Toso <victortoso@redhat.com>

As described in docs/devel/qapi-code-gen.rst line 998,
there should be no space between "Since" and ":".

Signed-off-by: Victor Toso <victortoso@redhat.com>
Message-ID: <20241217091504.16416-1-victortoso@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/cxl.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 9f65589bce..dd947d3bbc 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -460,7 +460,7 @@
 #
 # @unstable: For now this command is subject to change.
 #
-# Since : 9.1
+# Since: 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
   'data': { 'path': 'str',
@@ -539,7 +539,7 @@
 #
 # @unstable: For now this command is subject to change.
 #
-# Since : 9.1
+# Since: 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
   'data': { 'path': 'str',
-- 
2.48.1


