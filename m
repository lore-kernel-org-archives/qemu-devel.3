Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD59EC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49kK-0004aD-QI; Wed, 09 Sep 2026 00:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49kJ-0004Zh-BJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49kH-0006F6-T7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788927433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=camL1mSnMPUm2RZCMdeat8czfawEGrMZ6U4V+dNjyYs=;
 b=ThmFhrN4wbLF4D3FJv1lJxzoYyl1yNhOlktrSjUYuI+9nro7hRgsoY5ZWYGUbw+hAh1VTj
 jwJdX0ZHbaVw1fydX/Aagf6oDhesNOAonyujLCoz6tZ3hbTDCvmK/xRBNUFNr5xZnV3VC9
 BYXqUJNPd/Ty/USHnxU7GBP64Zqfp/E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-eK4mFDvsMlqAwO9xNV3YIw-1; Wed,
 09 Sep 2026 00:17:09 -0400
X-MC-Unique: eK4mFDvsMlqAwO9xNV3YIw-1
X-Mimecast-MFC-AGG-ID: eK4mFDvsMlqAwO9xNV3YIw_1788927428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC24318004D8; Wed,  9 Sep 2026 04:17:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68C891800370; Wed,  9 Sep 2026 04:17:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 linux-cxl@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 06/10] qapi: convert simple enum intros for cxl.json
Date: Wed,  9 Sep 2026 00:16:36 -0400
Message-ID: <20260909041640.69080-7-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 58ad82c2dc7..82524f47cdf 100644
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


