Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F566C982D9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7I4A-0005mc-Uf; Thu, 17 Sep 2026 15:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7I42-0005l1-MT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7I41-0005DY-5S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789674392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClPV5sIPWojjTAynGwc1mftqvUQ/Gr/l3qbEvnYoawE=;
 b=XKxrI2a7LJClhAaJ7ifUNmtKIqZpidYcLyfHecCmjvd8efc4rm7NKS8AsfMJi0ccBhTg1c
 RtwPQ2Niix4w2R6Wf6tXocEEZy/eK2b2ffuWdFWHGjEZg3YxvK1zJsPZbcmPgfeKiPYOOm
 qx8CAWxIm8Ogyb52GVzWXdy1LhM0HCI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-kF7sXa3VNxm8FKNkD_5-hA-1; Thu,
 17 Sep 2026 15:46:28 -0400
X-MC-Unique: kF7sXa3VNxm8FKNkD_5-hA-1
X-Mimecast-MFC-AGG-ID: kF7sXa3VNxm8FKNkD_5-hA_1789674386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142D61912C44; Thu, 17 Sep 2026 19:46:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3747019AC047; Thu, 17 Sep 2026 19:46:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-cxl@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, Jonathan Cameron <jic23@kernel.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v5 2/7] qapi: convert remaining simple intros for cxl.json
Date: Thu, 17 Sep 2026 15:46:09 -0400
Message-ID: <20260917194614.549584-3-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 631d4def2ac..9422d5a0e2d 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -32,9 +32,8 @@
 
 ##
 # @CXLCommonEventBase:
-#
-# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
-# Table 8-55 Common Event Record Format).
+#     Common event base for a CXL Event (CXL r3.2 8.2.10.2.1 Table
+#     8-55 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -63,8 +62,7 @@
 
 ##
 # @CXLGeneralMediaEvent:
-#
-# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
+#     Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-57 General
@@ -129,8 +127,7 @@
 
 ##
 # @CXLDRAMEvent:
-#
-# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+#     Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
@@ -211,8 +208,7 @@
 
 ##
 # @CXLMemModuleEvent:
-#
-# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
+#     Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
-- 
2.55.0


