Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0635C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpflQ-0006Fk-HI; Tue, 04 Mar 2025 22:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpflM-0005uF-Pq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpflK-0006Uz-NY
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5urStQP63jkqPMNX2eWKJXzq7q9kxq6QAKJEtebhcU=;
 b=JLYqARfcY+rbx/xdClcQoYYbaVi+1lfw2LXkV+w+nO6DlWNjkHAhuowXmSx0Fn9IddlnyD
 qIsRFlM5gMcL+W3Wt49PGP3dFa7gkNUYfQd41gRlFXZdNceOv/VXjq72JRRxY2grvwZ/Ec
 TCYAAoNjX458uCyF/hOKCu2rXREQYsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-tD9_x6NmPsWWh5WBswH_og-1; Tue,
 04 Mar 2025 22:49:36 -0500
X-MC-Unique: tD9_x6NmPsWWh5WBswH_og-1
X-Mimecast-MFC-AGG-ID: tD9_x6NmPsWWh5WBswH_og_1741146575
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A309119560BC; Wed,  5 Mar 2025 03:49:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43E371956095; Wed,  5 Mar 2025 03:49:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 54/57] docs/qapidoc: add transmogrifier test document
Date: Tue,  4 Mar 2025 22:46:03 -0500
Message-ID: <20250305034610.960147-55-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is just a test document that demonstrates the new qapi-domain doc
generator. Note that this test document uses a nesting depth of 2 for
the TOC unlike the existing QMP's reference nesting depth of 3. It's
arbitrary and can be changed to suit taste, it has nothing to do with
the new domain itself.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/index.rst      |  1 +
 docs/qapi/index.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 docs/qapi/index.rst

diff --git a/docs/index.rst b/docs/index.rst
index 5665de85cab..4364f9f1618 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -21,3 +21,4 @@ Welcome to QEMU's documentation!
    specs/index
    devel/index
    glossary
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
2.48.1


