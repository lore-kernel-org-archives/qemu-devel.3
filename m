Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37866E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8l-0005p6-6K; Tue, 14 Jan 2025 13:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8U-0005k5-Mq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8J-0002pH-7W
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRGB+fcAPWJtZon2e2C2vNba4zoxDlqFDUVDr/OEU70=;
 b=iMxmSe7bwaWGMBxn8FRcGitDQcGBfyIqIsuwKFklf7Ekla/mzhenOWxqK12Gk8lun/6XMg
 uJDbsYqhsTaZJcIPIJpCEOCt8pgDdbiOzNBovNK+NUtEk2fXvVLbe27NF+oxcYG/qpXhdn
 evGZU2FLKAS55JDjDiLm7YHR9+foMyQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-uNu_cexHPBS1uqCK5ldLwA-1; Tue,
 14 Jan 2025 13:59:17 -0500
X-MC-Unique: uNu_cexHPBS1uqCK5ldLwA-1
X-Mimecast-MFC-AGG-ID: uNu_cexHPBS1uqCK5ldLwA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0CE819560AA; Tue, 14 Jan 2025 18:59:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6ECC19560A3; Tue, 14 Jan 2025 18:59:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 23/23] docs/qapidoc: add transmogrifier test document
Date: Tue, 14 Jan 2025 13:58:40 -0500
Message-ID: <20250114185840.3058525-24-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/index.rst      |  1 +
 docs/qapi/index.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 docs/qapi/index.rst

diff --git a/docs/index.rst b/docs/index.rst
index 0b9ee9901d9..11c18c598a8 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -18,3 +18,4 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   qapi/index
diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
new file mode 100644
index 00000000000..e40dce09119
--- /dev/null
+++ b/docs/qapi/index.rst
@@ -0,0 +1,53 @@
+########################
+QAPI Transmogrifier Test
+########################
+
+This is a test render of the QEMU QMP reference manual using the new
+"transmogrifier" generator in qapidoc.py in conjunction with the
+qapi-domain.py sphinx extension.
+
+Some notable features:
+
+ * Every QAPI definition visible below is available to be
+   cross-referenced from anywhere else in the Sphinx docs; for example
+   ```blockdev-add``` will render to `blockdev-add`.
+
+ * There are type-specific cross-referencing roles available for
+   alternates, commands, events, enums, structs, unions and modules. for
+   example, ``:qapi:cmd:`block-dirty-bitmap-add``` resolves to
+   :qapi:cmd:`block-dirty-bitmap-add`, and only works for commands. The
+   roles available are ``cmd``, ``alt``, ``event``, ``enum``,
+   ``struct``, ``union``, and ``mod``; with two meta-roles available:
+   ``obj`` for absolutely any QAPI definition, and ``type`` for
+   everything except commands, events, and modules.
+
+ * There is a new `qapi-index` page which can be linked to with
+   ```qapi-index```. There, you can browse a list of all QAPI
+   definitions by type or alphabetically.
+
+ * QAPI definitions are also added to the existing `genindex` page.
+
+ * All member/argument/return types are now cross-references to that
+   type's definition. `chardev-add` is a good example.
+
+ * This work-in-progress version does not perform any inlining.
+
+ * This work-in-progress version actually also ignores branches entirely
+   right now!
+
+ * This version currently does not "prune" unnecessary docs.
+
+ * This version does not add undocumented members or return values.
+
+ * This version does not handle ifcond for anything other than top-level
+   entity definitions.
+
+ * This version renders sections in precisely the order they appear in
+   source, even if that winds up looking silly.
+
+
+.. contents::
+   :depth: 2
+
+.. qapi-doc:: qapi/qapi-schema.json
+   :transmogrify:
-- 
2.47.1


