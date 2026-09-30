Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EC0CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrj6-0001dK-Lc; Wed, 30 Sep 2026 06:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriq-0001P0-7E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrii-0006mZ-3w
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9FytIz3duAWp7I4dsdddl3XSajbaKBftSrXFzenVF4=;
 b=YFzVTwp0tvuu5y2oW6SYcyzUu58YQWwXyLry7z5h/NDaSfQh/A8rkubVgidRsjZ+lyhKsT
 0cm/EGUNuMTv0/GXXPx73+TXhiUsvhEKHZSOhb2BgvcUlhLE5t7dzWKpclF6GZeIzP/+uU
 JJAumlkrx42Uu5SuvFFqRw77zgzKLdw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-cprlaxILOmes4ZwlYXtfgg-1; Wed,
 30 Sep 2026 06:39:25 -0400
X-MC-Unique: cprlaxILOmes4ZwlYXtfgg-1
X-Mimecast-MFC-AGG-ID: cprlaxILOmes4ZwlYXtfgg_1790764764
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B84011954233; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7209119560AB; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A515121E662B; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 066/105] qapi: convert simple enum intros for cxl.json
Date: Wed, 30 Sep 2026 12:38:31 +0200
Message-ID: <20260930103910.3934848-67-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
Message-ID: <20260909041640.69080-7-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/cxl.json | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 58ad82c2dc..82524f47cd 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -9,9 +9,9 @@
 
 ##
 # @CxlEventLog:
-#
-# CXL has a number of separate event logs for different types of
-# events.  Each such event log is handled and signaled independently.
+#     CXL has a number of separate event logs for different types of
+#     events.  Each such event log is handled and signaled
+#     independently.
 #
 # @informational: Information Event Log
 #
@@ -296,10 +296,9 @@
 
 ##
 # @CxlUncorErrorType:
-#
-# Type of uncorrectable CXL error to inject.  These errors are
-# reported via an AER uncorrectable internal error with additional
-# information logged at the CXL device.
+#     Type of uncorrectable CXL error to inject.  These errors are
+#     reported via an AER uncorrectable internal error with additional
+#     information logged at the CXL device.
 #
 # @cache-data-parity: Data error such as data parity or data ECC error
 #     CXL.cache
@@ -463,10 +462,9 @@
 
 ##
 # @CxlExtentSelectionPolicy:
-#
-# The policy to use for selecting which extents comprise the added
-# capacity, as defined in Compute Express Link (CXL) Specification,
-# Revision 3.1, Table 7-70.
+#     The policy to use for selecting which extents comprise the added
+#     capacity, as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-70.
 #
 # @free: Device is responsible for allocating the requested memory
 #     capacity and is free to do this using any combination of
@@ -550,10 +548,9 @@
 
 ##
 # @CxlExtentRemovalPolicy:
-#
-# The policy to use for selecting which extents comprise the released
-# capacity, defined in the "Flags" field in Compute Express Link (CXL)
-# Specification, Revision 3.1, Table 7-71.
+#     The policy to use for selecting which extents comprise the
+#     released capacity, defined in the "Flags" field in Compute
+#     Express Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
 # @tag-based: Extents are selected by the device based on tag, with
 #     no requirement for contiguous extents.
-- 
2.55.0


