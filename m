Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0342D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n1u-0005gu-Le; Fri, 18 Oct 2024 09:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1t-0005gc-Km
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1s-0007O2-1E
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpWSy0XyKx65FnLlrtpV8TJHvHRjtWH5qZJitrNaeTY=;
 b=LzhSXaZCUX3S5GHvdT2h4GzGLaPX7JdIy4mmqWFo+4ZBghbU96g/bEqfMmI/sXXOyFTDJL
 ExKA7nitv76MIAJeT/RhkJJvnzvYIVy1t+B11NfFGWGNRZkHWcPSVOZKFl3XJ6ZjLnVehe
 gy0ae3WnVNWJfdk2jq9YD3PI7cBG1ps=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-soRP1AKRO7aZayl9FdtZRg-1; Fri,
 18 Oct 2024 09:28:29 -0400
X-MC-Unique: soRP1AKRO7aZayl9FdtZRg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99D441955EE7; Fri, 18 Oct 2024 13:28:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D38E19560AD; Fri, 18 Oct 2024 13:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4980621E691E; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 1/9] qga/qapi-schema: Drop obsolete note on "unsupported" errors
Date: Fri, 18 Oct 2024 15:28:16 +0200
Message-ID: <20241018132824.3379780-2-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The note talks about "unsupported" errors and QERR_UNSUPPORTED.  The
former is vague, and the latter makes sense only in C, not in external
interface documentation.  Fortunately, we don't have to address this
anymore: recent merge commit 3b5efc553eb got rid of these errors.
Delete the note.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240911131206.2503035-2-armbru@redhat.com>
---
 qga/qapi-schema.json | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 495706cf73..0537bb7886 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,15 +1,6 @@
 # *-*- Mode: Python -*-*
 # vim: filetype=python
 
-##
-# = General note concerning the use of guest agent interfaces
-#
-# "unsupported" is a higher-level error than the errors that
-# individual commands might document.  The caller should always be
-# prepared to receive QERR_UNSUPPORTED, even if the given command
-# doesn't specify it, or doesn't document any failure mode at all.
-##
-
 ##
 # = QEMU guest agent protocol commands and structs
 ##
-- 
2.46.0


