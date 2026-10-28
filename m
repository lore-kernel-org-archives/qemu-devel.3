Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I80EzzOo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4pw-0001BV-Ud; Wed, 28 Oct 2026 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM4pS-0000vZ-Js
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM4pR-00058b-4z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793198436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7r3pYMNuK9gIARB/b8Klmne4oT9/3HKWNdTb63UUYQ=;
 b=I80EzzOoTjVt2sOhvKsvOtjeqef1x2FiJ+Hq1a1o59YGHhUDFyQR+ymkVT8YvFiQ5Ssv97
 paipLG5psCe7n2bvLRVEbwnWkYwo3z8I99bFOZxYnPob5H1Xqp3G9LRTHmv0C+NLNIw5dj
 7jn2UJgh09VSHRH3lweytdhJzpUIuV0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-q4FyNl-PO2yvTWIGBPYibw-1; Wed,
 28 Oct 2026 10:40:35 -0400
X-MC-Unique: q4FyNl-PO2yvTWIGBPYibw-1
X-Mimecast-MFC-AGG-ID: q4FyNl-PO2yvTWIGBPYibw_1793198434
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6109319560AD
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:40:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21DFF1956040
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:40:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 059FB21E6888; Wed, 28 Oct 2026 15:40:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	berrange@redhat.com
Subject: [PATCH 4/4] qapi/compat: Fix "only syntactic aspects of QMP" note
Date: Wed, 28 Oct 2026 15:40:28 +0100
Message-ID: <20261028144028.771869-10-armbru@redhat.com>
In-Reply-To: <20261028144028.771869-1-armbru@redhat.com>
References: <20261028144028.771869-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Covers only syntactic aspects of QMP" was initially accurate, but we
we neglected to update it when we added @insecure-types.  Do that now.

While there, move the limitation notes below the enum value
descriptions to avoid forward references, and mark up an existing
reference properly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index f6bc93904f..d1fb74abf7 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -57,13 +57,6 @@
 #
 #     This is intended for testing users of the management interfaces.
 #
-# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
-# with feature 'deprecated' or 'unstable'.  We may want to extend it
-# to cover semantic aspects and CLI.
-#
-# Limitation: deprecated-output policy @hide is not implemented for
-# enumeration values.  They behave the same as with policy @accept.
-#
 # @deprecated-input: how to handle deprecated input (default 'accept')
 #
 # @deprecated-output: how to handle deprecated output (default
@@ -78,6 +71,14 @@
 # @insecure-types: how to handle types that are not declared secure
 #     (default 'accept') (since 11.2)
 #
+# Limitation: @deprecated-input, @deprecated-output, @unstable-input,
+# and @unstable-output cover only syntactic aspects of QMP, i.e. stuff
+# tagged with feature 'deprecated' or 'unstable'.  We may want to
+# extend it to cover semantic aspects and CLI.
+#
+# Limitation: @deprecated-output policy @hide is not implemented for
+# enumeration values.  They behave the same as with policy @accept.
+#
 # Since: 6.0
 ##
 { 'struct': 'CompatPolicy',
-- 
2.55.0


