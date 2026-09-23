Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0605EC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9GgQ-0004jl-Sx; Wed, 23 Sep 2026 02:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x9GgO-0004jK-H9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x9GgM-0002zx-TF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790145737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tfH3TdNOMaZam+3l18JPlVm+bYOj/yIeMzswR02M+s=;
 b=OFmQw/IX/IFA9JwXH9NeuiqwqvjG8XIAF7u0XNi0tHch2pj7/5s3ljFmUMxFS14cjGw0Bu
 DjTjoMAzERgrWtv6z6FrGkZcDKbFTqsPILYBsM9uWUf0pYVVjDGRx3xtCz2kwe2+SkXUYm
 /1aogwSjjECuUSgwpJwOSBYWGfZoOtk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-d6Am9QfIOVuJY8AaEK88Gg-1; Wed,
 23 Sep 2026 02:42:16 -0400
X-MC-Unique: d6Am9QfIOVuJY8AaEK88Gg-1
X-Mimecast-MFC-AGG-ID: d6Am9QfIOVuJY8AaEK88Gg_1790145735
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EBF319541B0; Wed, 23 Sep 2026 06:42:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E86193000223; Wed, 23 Sep 2026 06:42:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75F2121E6A04; Wed, 23 Sep 2026 08:42:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, michael.roth@amd.com,
 kkostiuk@redhat.com
Subject: [PATCH] qga/qapi-schema: Drop "This is a read-only operation"
Date: Wed, 23 Sep 2026 08:42:12 +0200
Message-ID: <20260923064212.839691-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Documentation of guest-get-vcpus and guest-get-memory-blocks has "This
is a read-only operation".  Similar commands don't.  A "get" command
that actually writes would be in surprisingly bad taste.  Delete both
instances of the sentence.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8cd0ba048b..040c932310 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -769,8 +769,6 @@
 #
 # Retrieve the list of the guest's logical processors.
 #
-# This is a read-only operation.
-#
 # Returns: The list of all VCPUs the guest knows about.  Each VCPU is
 #     put on the list exactly once, but their order is unspecified.
 #
@@ -1133,8 +1131,6 @@
 #
 # Retrieve the list of the guest's memory blocks.
 #
-# This is a read-only operation.
-#
 # Returns: The list of all memory blocks the guest knows about.  Each
 #     memory block is put on the list exactly once, but their order is
 #     unspecified.
-- 
2.55.0


