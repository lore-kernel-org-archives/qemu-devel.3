Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6476C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsK-0006Ea-TR; Tue, 11 Mar 2025 07:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqP-0003CW-UE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq6-0006W2-2p
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAYqniCMLzAyv5FL5S5fpS2iROklEwvuiGIfKWs8y8A=;
 b=UkutpKkqTrfxCROvNjh5kN4l84WalVndyEJuWWfyJOkN5+JeAas6VRNTs/tOa0P4RWmJjr
 9HIENur/XIRoAaxH88V9Nv90idxFa1/aEIFloHuNyV/h0hJTEQmTuh1DnouiMe8/FucVaK
 a61gzGtAS84cEiBc1G6lARnc97YxJRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-ZwbIyeHCP0-15qGDJiU3tg-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: ZwbIyeHCP0-15qGDJiU3tg-1
X-Mimecast-MFC-AGG-ID: ZwbIyeHCP0-15qGDJiU3tg_1741692713
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A37851955F69; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CA3219560AB; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 171C321E64AE; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PULL 23/61] docs/qapi-domain: add :ifcond: directive option
Date: Tue, 11 Mar 2025 12:30:59 +0100
Message-ID: <20250311113137.1277125-24-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Add a special :ifcond: option that allows us to annotate the
definition-level conditionals.

The syntax of the argument is currently undefined, but it's possible we
can apply better formatting in the future. Currently, we just display
the ifcond string as preformatted text.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-26-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 13 +++++++++++++
 docs/sphinx/qapi_domain.py             | 23 +++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 5f58f1d524..3fd326613d 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -237,3 +237,16 @@ div[class^="highlight"] pre {
 .qapi-deprecated::before {
     content: '⚠️ ';
 }
+
+.qapi-ifcond::before {
+    /* gaze ye into the crystal ball to determine feature availability */
+    content: '🔮 ';
+}
+
+.qapi-ifcond {
+    background-color: #f9f5ff;
+    border: solid #dac2ff 6px;
+    padding: 8px;
+    border-radius: 15px;
+    margin: 5px;
+}
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 00fd11ebf7..4531b5d857 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -14,6 +14,7 @@
     NamedTuple,
     Optional,
     Tuple,
+    Union,
     cast,
 )
 
@@ -217,6 +218,7 @@ class QAPIObject(QAPIDescription):
             "module": directives.unchanged,  # Override contextual module name
             # These are QAPI originals:
             "since": directives.unchanged,
+            "ifcond": directives.unchanged,
             "deprecated": directives.flag,
             "unstable": directives.flag,
         }
@@ -288,9 +290,14 @@ def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
         infopips = nodes.container()
         infopips.attributes["classes"].append("qapi-infopips")
 
-        def _add_pip(source: str, content: str, classname: str) -> None:
+        def _add_pip(
+            source: str, content: Union[str, List[nodes.Node]], classname: str
+        ) -> None:
             node = nodes.container(source)
-            node.append(nodes.Text(content))
+            if isinstance(content, str):
+                node.append(nodes.Text(content))
+            else:
+                node.extend(content)
             node.attributes["classes"].extend(["qapi-infopip", classname])
             infopips.append(node)
 
@@ -308,6 +315,18 @@ def _add_pip(source: str, content: str, classname: str) -> None:
                 "qapi-unstable",
             )
 
+        if self.options.get("ifcond", ""):
+            ifcond = self.options["ifcond"]
+            _add_pip(
+                f":ifcond: {ifcond}",
+                [
+                    nodes.emphasis("", "Availability"),
+                    nodes.Text(": "),
+                    nodes.literal(ifcond, ifcond),
+                ],
+                "qapi-ifcond",
+            )
+
         if infopips.children:
             contentnode.insert(0, infopips)
 
-- 
2.48.1


