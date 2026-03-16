Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A18F53D81
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ceo-0002FA-QA; Mon, 16 Mar 2026 14:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CeY-0002At-9n
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CeU-0007wd-EX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLX0JASAI8bW3KHHwlVtyvFqtsK38+dLHCLP2gq/KLc=;
 b=XocNZFG/mcLlDNeo3i0K1V/W86c2aNeZNiy+vYggWBccvkrPOtqDFq43FspYM4P2mzBHJ0
 JYHW97ONoHpuwAyK8BkStJdhF5o3iToDJaf1oI2QhfSfhN8V96SLqlSpM4qe1a1DnzUji+
 JxrsyevTTKy2cItVf62wQwxhD4dYJwM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ACSdKo0nPS64iAF2AkOpBg-1; Mon,
 16 Mar 2026 14:26:52 -0400
X-MC-Unique: ACSdKo0nPS64iAF2AkOpBg-1
X-Mimecast-MFC-AGG-ID: ACSdKo0nPS64iAF2AkOpBg_1773685610
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB35E195609F; Mon, 16 Mar 2026 18:26:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 101E330001A2; Mon, 16 Mar 2026 18:26:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 3/8] qapi: add "Details:" disambiguation marker
Date: Mon, 16 Mar 2026 14:26:02 -0400
Message-ID: <20260316182608.148628-4-jsnow@redhat.com>
In-Reply-To: <20260316182608.148628-1-jsnow@redhat.com>
References: <20260316182608.148628-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

When a documentation block consists only of plaintext, there is nothing
to semantically differentiate the "intro" from the "details"
section. For the purposes of the inliner, the intro section is likely to
be dropped while the details section will be merged onto the end of the
parent's details section.

When the delineation between "intro" and "details" is not clear because
there is no intervening "members", "features", "errors", "returns",
"TODO", or "Since" section, the parser assumes the entire text section
is an "intro" section. This may not always be semantically true, so this
patch clarifies certain sections explicitly as "details" sections by
using an empty "Details:" marker.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json   | 3 +++
 qapi/machine.json      | 2 +-
 qapi/migration.json    | 8 ++++++--
 qapi/net.json          | 2 +-
 qapi/qom.json          | 4 ++++
 qapi/yank.json         | 2 +-
 scripts/qapi/parser.py | 8 ++++++++
 7 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f8d446b3d6e..c5ff15ae7a1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5007,6 +5007,9 @@
 # @blockdev-reopen:
 #
 # Reopens one or more block devices using the given set of options.
+#
+# Details:
+#
 # Any option not specified will be reset to its default value
 # regardless of its previous status.  If an option cannot be changed
 # or a particular driver does not support reopening then the command
diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b87..bc2279b2526 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1259,7 +1259,7 @@
 # Return the amount of initially allocated and present hotpluggable
 # (if enabled) memory in bytes.
 #
-# TODO: This line is a hack to separate the example from the body
+# Details:
 #
 # .. qmp-example::
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47e..558b4f145ed 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1633,7 +1633,7 @@
 #
 # Query replication status while the vm is running.
 #
-# TODO: This line is a hack to separate the example from the body
+# Details:
 #
 # .. qmp-example::
 #
@@ -1651,6 +1651,8 @@
 #
 # Xen uses this command to notify replication to trigger a checkpoint.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-colo-do-checkpoint" }
@@ -1687,7 +1689,7 @@
 #
 # Query COLO status while the vm is running.
 #
-# TODO: This line is a hack to separate the example from the body
+# Details:
 #
 # .. qmp-example::
 #
@@ -1724,6 +1726,8 @@
 #
 # Pause a migration.  Currently it only supports postcopy.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-pause" }
diff --git a/qapi/net.json b/qapi/net.json
index 118bd349651..c011d6dc1a9 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1070,7 +1070,7 @@
 # switches.  This can be useful when network bonds fail-over the
 # active slave.
 #
-# TODO: This line is a hack to separate the example from the body
+# Details:
 #
 # .. qmp-example::
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 1b47abd44e9..568b7d4b997 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -777,6 +777,8 @@
 #
 # Properties for memory-backend-shm objects.
 #
+# Details:
+#
 # This memory backend supports only shared memory, which is the
 # default.
 #
@@ -792,6 +794,8 @@
 #
 # Properties for memory-backend-epc objects.
 #
+# Details:
+#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
diff --git a/qapi/yank.json b/qapi/yank.json
index f3cd5c15d60..2854a8a9d2a 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -104,7 +104,7 @@
 #
 # Query yank instances.  See `YankInstance` for more information.
 #
-# TODO: This line is a hack to separate the example from the body
+# Details:
 #
 # .. qmp-example::
 #
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index dea056df30d..da47ee55bdd 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -588,6 +588,14 @@ def _tag_check(what: str) -> None:
                         raise QAPIParseError(
                             self, 'feature descriptions expected')
                     have_tagged = True
+                elif line == 'Details:':
+                    _tag_check("Details")
+                    self.accept(False)
+                    line = self.get_doc_line()
+                    while line == '':
+                        self.accept(False)
+                        line = self.get_doc_line()
+                    have_tagged = True
                 elif match := self._match_at_name_colon(line):
                     # description
                     if have_tagged:
-- 
2.53.0


