Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FE7C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmq0f-0008Dn-5R; Thu, 23 Jul 2026 05:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmq0d-0008De-D5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 05:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmq0c-0000vt-3I
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 05:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784799988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3olnWTd7MiEUlD1RiJIUHI0LFB7x1/u4fWQGVyfjwGI=;
 b=fY15C4M83SUieH8TxYV5vGqU2RXINE/sZ/THTpi1zlJf8hSup655aK3Mqe8L+DsbzBUCp9
 6u7cw4qpavenkgw7Cjqb9W+0IdlUOa54X0bnTIAGvoqroBxJEJbxbepbe+QM9kYK7xAzVj
 rOAiU/AVxDmTkQUACATQmyof6qAfglU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-jPaM5witPDaNmOZ1dcBOeQ-1; Thu,
 23 Jul 2026 05:46:26 -0400
X-MC-Unique: jPaM5witPDaNmOZ1dcBOeQ-1
X-Mimecast-MFC-AGG-ID: jPaM5witPDaNmOZ1dcBOeQ_1784799986
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD2B19540E3; Thu, 23 Jul 2026 09:46:25 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 450111956053; Thu, 23 Jul 2026 09:46:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/system/security: exclude uninitialized stack variables
 as bugs
Date: Thu, 23 Jul 2026 10:46:22 +0100
Message-ID: <20260723094622.1515831-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The -ftrivial-auto-var-init=zero usage guarantees implicit zero
initializers for all stack variables. Thus most bug reports relying
on undefined behaviour from lack of variable initialization will
not be security issues, or even bugs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/security.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index 52bbf0cc7a..bbc462457e 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -133,6 +133,16 @@ an issue as a normal bug.
   that affect the level 0 QEMU process. While these bugs should be
   fixed, they will not be triaged as security flaws at this time.
 
+* **uninitialized stack variables**. If the bug scenario relies on
+  undefined behaviour from stack variables that lack explicit
+  initialization, it will not usually be considered a security flaw.
+  The build system adds '-ftrivial-auto-var-init=zero', which is
+  available in both the supported compilers (GCC and CLang) and
+  ensures all stack variables have implicit zero-initializers.
+  This eliminates undefined behaviour and usually gives the
+  correct desired initialization value, eliminating most of the
+  bug scenarios wrt uninitialized stack variables.
+
 * **low severity impact**. As a catch all rule, issues which
   are judged to have a "low" severity impact on the system will
   usually not justify handling as security bugs, nor assignment
-- 
2.55.0


