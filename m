Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF3AC9831E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kBv-0006KM-8t; Thu, 24 Sep 2026 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9kBm-0006II-0u
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9kBj-0001Y8-Gq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790259157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C7ay93/LysMPfHP9EG4vAuH2W4K4fmSCc/2tKI8g+PY=;
 b=W9zw1BicHdlSKIJDDBHUbL12rDaoVX7T+nmJXzm+FEVK+6kS6foXK/imfoXrwuPQC3xTyx
 9c+9tPlKjM4/pQNaGTNJcWJlcuags5x9uI4W2Z/jBn7advM0+Hr9uIfsayoeFSUYA2lywm
 3qN6WH5FbVucFKI4Yc55EIB9tshmvhw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-yKVAxFmTMeSVR5G9REc-IA-1; Thu,
 24 Sep 2026 10:12:34 -0400
X-MC-Unique: yKVAxFmTMeSVR5G9REc-IA-1
X-Mimecast-MFC-AGG-ID: yKVAxFmTMeSVR5G9REc-IA_1790259153
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AADB197753D
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:12:33 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 923B43000239; Thu, 24 Sep 2026 14:12:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] .claude: delete as Claude Code now honours AGENTS.MD by
 default
Date: Thu, 24 Sep 2026 15:12:31 +0100
Message-ID: <20260924141231.2632941-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

From the release notes for Claude Code 2.1.77:

  https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

  "Added AGENTS.md support: in a project with no CLAUDE.md,
   Claude Code reads AGENTS.md instead"

If we assume people will keep their Claude Code updated, then the
.claude rules we added to link to AGENTS.md are now redundant, or
very soon will be.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

How quickly should we remove this ? We only just added it very recently
so it is barely a regression to remove it, but we could wait some $small
months for people to upgrade >= 2.1.77 ?

 .claude/.gitignore         | 2 --
 .claude/rules/agents-md.md | 1 -
 2 files changed, 3 deletions(-)
 delete mode 100644 .claude/.gitignore
 delete mode 100644 .claude/rules/agents-md.md

diff --git a/.claude/.gitignore b/.claude/.gitignore
deleted file mode 100644
index b0a57a19c01..00000000000
--- a/.claude/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# reserved for the user to add their own per-project rules
-/CLAUDE.md
diff --git a/.claude/rules/agents-md.md b/.claude/rules/agents-md.md
deleted file mode 100644
index 43c994c2d36..00000000000
--- a/.claude/rules/agents-md.md
+++ /dev/null
@@ -1 +0,0 @@
-@AGENTS.md
-- 
2.55.0


