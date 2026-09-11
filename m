Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC9C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xzL-0007nj-BF; Fri, 11 Sep 2026 05:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4xxI-0005nU-3w
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4xxG-000293-Ep
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789120437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HdTKagfO8JjKw1KXN2pn9l/2dFfUqr4nR2djugGQE4=;
 b=C9t7WAV0aT9ZOwfeNMTHeGgD4VHuWwkan0XQMQ7cPg1Y8KHSpMIBZ8T2n54TXZNtGjf3XE
 VFEMTKVrtYmY+D9kVnpsuR/CC6A9xKhveJ+fGlAHvHsXAQW0ygzmQRcNFUhGEzQDpkTqHn
 4Ny6svSEfgEhCsOaBs7J67jic8TbydM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-6fPrSDTINpCsNdODDtu80w-1; Fri,
 11 Sep 2026 05:53:54 -0400
X-MC-Unique: 6fPrSDTINpCsNdODDtu80w-1
X-Mimecast-MFC-AGG-ID: 6fPrSDTINpCsNdODDtu80w_1789120433
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C8261955E70; Fri, 11 Sep 2026 09:53:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE921418; Fri, 11 Sep 2026 09:53:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A1BF21E692D; Fri, 11 Sep 2026 11:53:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com
Subject: [PATCH 1/2] qapi/machine: Drop misleading (for OptsVisitor) doc
Date: Fri, 11 Sep 2026 11:53:49 +0200
Message-ID: <20260911095350.2020964-2-armbru@redhat.com>
In-Reply-To: <20260911095350.2020964-1-armbru@redhat.com>
References: <20260911095350.2020964-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The QMP Reference Manual describes NumaOptions and NumaNodeOptions as
"(for OptsVisitor)".  This makes no sense; the OptsVisitor is a purely
internal thing.

When commit 0042109a6a (NUMA: convert -numa option to use OptsVisitor)
added these QAPI types, both "(for OptsVisitor)" were correct and
merely schema comments.  They have since become wrong (both types are
part of QMP according to query-qmp-schema) and reference
documentation.

Delete both instances.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 2d63c1bac3..2fd4861616 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -470,7 +470,7 @@
 ##
 # @NumaOptions:
 #
-# A discriminated record of NUMA options.  (for OptsVisitor)
+# A discriminated record of NUMA options.
 #
 # @type: NUMA option type
 #
@@ -489,7 +489,7 @@
 ##
 # @NumaNodeOptions:
 #
-# Create a guest NUMA node.  (for OptsVisitor)
+# Create a guest NUMA node.
 #
 # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
 #
-- 
2.55.0


