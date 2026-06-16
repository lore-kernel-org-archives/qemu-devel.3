Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8692CD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUbX-0001QC-DD; Tue, 16 Jun 2026 10:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbV-0001Oe-4Z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbR-0003xu-V1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zQUu+TsNk2briT5cBZJ92hGKQfM61V1auBvWMi/Bjo=;
 b=ioWnZI+IarGkp1JoRfAtopFVW7n+VxzQiAQreL7Qw4+4viz2Szfyr+5NWKr5YsKodyGmAw
 wR8PfwMrHjY+WiB6EeFFOd5Oo7Vpm1iplnyljmLtah+kX8lzM33A266UkGKZL+lsz7vWgy
 j9q656TIMI+iUyvJVQ+4sOKBnhFfeSc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-RPDHUkWuMtuTRJZr9kva0Q-1; Tue,
 16 Jun 2026 10:17:19 -0400
X-MC-Unique: RPDHUkWuMtuTRJZr9kva0Q-1
X-Mimecast-MFC-AGG-ID: RPDHUkWuMtuTRJZr9kva0Q_1781619438
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4953F180034A; Tue, 16 Jun 2026 14:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8BD41955BC1; Tue, 16 Jun 2026 14:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41E1321E6A02; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PULL 01/14] qapi: drop "must exist" from ID descriptions for
 consistency
Date: Tue, 16 Jun 2026 16:17:02 +0200
Message-ID: <20260616141715.2974467-2-armbru@redhat.com>
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Filip Hejsek <filip.hejsek@gmail.com>

Make chardev ID param descriptions more consistent with ID descriptions
elsewhere.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Message-ID: <20260609120221.461303-1-filip.hejsek@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index aa5ee9ffcd..abaccefa97 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -821,7 +821,7 @@
 #
 # Change a character device backend
 #
-# @id: the chardev's ID, must exist
+# @id: the chardev's ID
 #
 # @backend: new backend type and parameters
 #
@@ -862,7 +862,7 @@
 #
 # Remove a character device backend
 #
-# @id: the chardev's ID, must exist and not be in use
+# @id: the chardev's ID, must not be in use
 #
 # Since: 1.4
 #
@@ -879,7 +879,7 @@
 #
 # Send a break to a character device
 #
-# @id: the chardev's ID, must exist
+# @id: the chardev's ID
 #
 # Since: 2.10
 #
-- 
2.54.0


