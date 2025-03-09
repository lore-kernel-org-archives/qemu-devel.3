Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9C1C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCA3-00045G-AE; Sun, 09 Mar 2025 04:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9t-00039R-I6
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9r-0002Sa-Ns
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VB/rvzHwv+YDxSX4OayGop88B5f/2LV5nycjpQE48GM=;
 b=b8Aue0zu12ToAqcUL6cn6m1spmFqNuV31h/NqZx4m/rQB44vEaMXH4Jqzc4CFZ+7nyZvt7
 dAxMf57kd+usn/qK89ahzYUGwza37cT3Puxr/MdKOP4Dn/yqQjwwDzKXywIKlFeKzB5204
 rgUKiUcCKiM0J2TS5W4o3DNUesw9SYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-FOKJ_0FcOmaAMz5CrHupdA-1; Sun,
 09 Mar 2025 04:37:10 -0400
X-MC-Unique: FOKJ_0FcOmaAMz5CrHupdA-1
X-Mimecast-MFC-AGG-ID: FOKJ_0FcOmaAMz5CrHupdA_1741509429
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75FE619560B5; Sun,  9 Mar 2025 08:37:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4817B19560AB; Sun,  9 Mar 2025 08:37:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 30/62] docs/qapi-domain: warn when QAPI domain xrefs fail
 to resolve
Date: Sun,  9 Mar 2025 04:35:17 -0400
Message-ID: <20250309083550.5155-31-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

This patch adds a warning (which is a build failure under our current
build settings) whenever a QAPI cross-reference fails to resolve.

This applies to any cross-references of the form :qapi:{role}:`foo`,
which covers all of the automatically generated references by the qapi
domain, and any such references that are manually written into the
documentation rst files.

Cross-references of the form `foo` do not use this system, but are
already configured to issue a warning (Again, a build failure) if the
cross-reference isn't found anywhere.

Adds warnings that look like the following:

docs/qapi/index.rst:48: WARNING: qapi:type reference target not found: 'footype' [ref.qapi]
docs/qapi/index.rst:50: WARNING: qapi:mod reference target not found: 'foomod' [ref.qapi]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 2649fa8c1db..f8fc51d7d4f 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -825,6 +825,29 @@ def resolve_xref(
         matches = self.find_obj(modname, target, typ)
 
         if not matches:
+            # Normally, we could pass warn_dangling=True to QAPIXRefRole(),
+            # but that will trigger on references to these built-in types,
+            # which we'd like to ignore instead.
+
+            # Take care of that warning here instead, so long as the
+            # reference isn't to one of our built-in core types.
+            if target not in (
+                "string",
+                "number",
+                "int",
+                "boolean",
+                "null",
+                "value",
+                "q_empty",
+            ):
+                logger.warning(
+                    __("qapi:%s reference target not found: %r"),
+                    typ,
+                    target,
+                    type="ref",
+                    subtype="qapi",
+                    location=node,
+                )
             return None
 
         if len(matches) > 1:
-- 
2.48.1


