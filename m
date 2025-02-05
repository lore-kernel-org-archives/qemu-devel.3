Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8091AC02199
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfocH-0000rB-5R; Wed, 05 Feb 2025 18:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoc7-00009Q-9Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoc5-00062k-HY
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocEVIzgCllNidvY9XGuysb7vC/waRLiNKCmS0h9gcRQ=;
 b=YYSM/NRRQFpYDSUGe+9b+2PPLnQFZwq5hQzNOMRThBhH/cE6rwPrr5Sc8r+Z2DkWgXQLlf
 Jf/GUNwvDkjNDEsbe62/9stZvVuX/6QHzHbmT25dfmXzFSSRYfcPHSQJUAYatEu7up8VHh
 NrtUmZF9n+wFJzBgVC2vOmr6XmAFyHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-htWgkY6PMOiJpafevoan7Q-1; Wed,
 05 Feb 2025 18:15:15 -0500
X-MC-Unique: htWgkY6PMOiJpafevoan7Q-1
X-Mimecast-MFC-AGG-ID: htWgkY6PMOiJpafevoan7Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25DEB180087F; Wed,  5 Feb 2025 23:15:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D7B71800570; Wed,  5 Feb 2025 23:15:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
Date: Wed,  5 Feb 2025 18:11:55 -0500
Message-ID: <20250205231208.1480762-30-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This clarifies sections that are mistaken by the parser as "intro"
sections to be "details" sections instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json      | 2 ++
 qapi/migration.json    | 4 ++++
 qapi/qom.json          | 4 ++++
 qapi/yank.json         | 2 ++
 scripts/qapi/parser.py | 8 ++++++++
 5 files changed, 20 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..3c1b397f6cc 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1301,6 +1301,8 @@
 # Return the amount of initially allocated and present hotpluggable
 # (if enabled) memory in bytes.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "query-memory-size-summary" }
diff --git a/qapi/migration.json b/qapi/migration.json
index 43babd1df41..9070a91e655 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1920,6 +1920,8 @@
 #
 # Xen uses this command to notify replication to trigger a checkpoint.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "xen-colo-do-checkpoint" }
@@ -1993,6 +1995,8 @@
 #
 # Pause a migration.  Currently it only supports postcopy.
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-pause" }
diff --git a/qapi/qom.json b/qapi/qom.json
index 11277d1f84c..5d285ef9239 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -729,6 +729,8 @@
 #
 # Properties for memory-backend-shm objects.
 #
+# Details:
+#
 # This memory backend supports only shared memory, which is the
 # default.
 #
@@ -744,6 +746,8 @@
 #
 # Properties for memory-backend-epc objects.
 #
+# Details:
+#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
diff --git a/qapi/yank.json b/qapi/yank.json
index 30f46c97c98..4d36d21e76a 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -104,6 +104,8 @@
 #
 # Returns: list of @YankInstance
 #
+# Details:
+#
 # .. qmp-example::
 #
 #     -> { "execute": "query-yank" }
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c5d2b950a82..5890a13b5ba 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -544,6 +544,14 @@ def _tag_check(what: str) -> None:
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
2.48.1


