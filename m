Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0ABE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvHC-0006rE-2D; Thu, 12 Dec 2024 21:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHA-0006iX-0i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvH8-0007vX-AU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mB7oURT5LHh4f/ZBaK2d8wSMO7qjBmKcKRe0FD6zt5A=;
 b=d+TauptcMy2gq+sb2t6TmjmY9PzKFugM8C3kTg5ATX4VAqEuhy8a3ILcMTnC17mcSYE6Cd
 Rz0YNlK36INsR6OvGa1j4W2rQ9shYymiXqyQZMtPF//ouux73Xvn08erD+kxfmN50MPsMP
 jECus0YAbXdQEGa6LVSjkaoN4Ccq/EE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-jXcAetz7P5u9fNuIgRAuOg-1; Thu,
 12 Dec 2024 21:19:23 -0500
X-MC-Unique: jXcAetz7P5u9fNuIgRAuOg-1
X-Mimecast-MFC-AGG-ID: jXcAetz7P5u9fNuIgRAuOg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5786E19560B2; Fri, 13 Dec 2024 02:19:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47558195605A; Fri, 13 Dec 2024 02:19:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 10/23] docs/qapidoc: add visit_freeform() method
Date: Thu, 12 Dec 2024 21:18:13 -0500
Message-ID: <20241213021827.2956769-11-jsnow@redhat.com>
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com>
References: <20241213021827.2956769-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 docs/sphinx/qapidoc.py | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 7d2f7bfb415..6f8f69077b1 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -133,6 +133,53 @@ def visit_module(self, path: str) -> None:
         self.add_line_raw(f".. qapi:module:: {name}", path, 1)
         self.ensure_blank_line()
 
+    def visit_freeform(self, doc) -> None:
+        # Once the old qapidoc transformer is deprecated,
+        # freeform sections can be transformed into pure rST.
+        #
+        # For now, translate our micro-format into rST.
+        # Code adapted from Peter Maydell's freeform().
+
+        assert len(doc.all_sections) == 1, doc.all_sections
+        body = doc.all_sections[0]
+        text = body.text
+        info = doc.info
+
+        if re.match(r"=+ ", text):
+            # Section/subsection heading (if present, will always be the
+            # first line of the block)
+            (heading, _, text) = text.partition("\n")
+            (leader, _, heading) = heading.partition(" ")
+            level = len(leader) + 1  # Implicit +1 for heading in .rST stub
+
+            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
+            markers = {
+                1: "#",
+                2: "*",
+                3: "=",
+                4: "-",
+                5: "^",
+                6: '"',
+            }
+            overline = level <= 2
+            marker = markers[level]
+
+            self.ensure_blank_line()
+            # This credits all 2 or 3 lines to the single source line.
+            if overline:
+                self.add_line(marker * len(heading), info)
+            self.add_line(heading, info)
+            self.add_line(marker * len(heading), info)
+            self.ensure_blank_line()
+
+            # Eat blank line(s) and advance info
+            trimmed = text.lstrip("\n")
+            text = trimmed
+            info = info.next_line(len(text) - len(trimmed) + 1)
+
+        self.add_lines(text, info)
+        self.ensure_blank_line()
+
 
 # Disable black auto-formatter until re-enabled:
 # fmt: off
-- 
2.47.0


