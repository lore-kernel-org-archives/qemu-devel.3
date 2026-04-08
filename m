Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACC110F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXoZ-00070X-Cb; Wed, 08 Apr 2026 14:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAXoX-0006lM-OS
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKxe-0005Uw-Jx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjEgL/Yg7IG4CWwCmU+agYoD289+Mk5M4ZdIeYzk0UM=;
 b=ClYvlLXzs7s+kUSiLt89ld1JQe0WJ32zpIf6fR/rUilc266pKn7ebZABa//99P6ZknvqSC
 FFqH+QBi2XEF5Fjge4thOWzlg8y9znZR4Oic1TukXBZZjZZK6YnnImiLdT09MUoI/8KZRO
 tBASYKjoBlvS6qJ02DDU3i6rTqNIUmc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-j8ceCinXPCSEENH141qwYA-1; Wed,
 08 Apr 2026 00:56:13 -0400
X-MC-Unique: j8ceCinXPCSEENH141qwYA-1
X-Mimecast-MFC-AGG-ID: j8ceCinXPCSEENH141qwYA_1775624171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9529180034F; Wed,  8 Apr 2026 04:56:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EF3319560A6; Wed,  8 Apr 2026 04:56:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 03/10] qapi: add "Details:" disambiguation marker
Date: Wed,  8 Apr 2026 00:55:24 -0400
Message-ID: <20260408045531.3006678-4-jsnow@redhat.com>
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com>
References: <20260408045531.3006678-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
section. For the purposes of the inliner, the intro section of
documentation inlined into another documentation block will be omitted,
which may lead to unintentional omissions of details in the rendered
output.

When the delineation between "intro" and "details" is not clear because
there is no intervening description/tagged sections, the parser assumes
the entire text section is an "intro" section. This may not always be
semantically true, so this patch clarifies certain sections explicitly
as "details" sections by using an empty "Details:" marker.

Replace existing uses of "TODO:" hacks to achieve this effect with the
canonical marker.

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Review note: all *.ir files are completely unchanged before and after
this patch. --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 18 ++++++++++++++++++
 qapi/machine.json            |  2 +-
 qapi/migration.json          |  4 ++--
 qapi/net.json                |  2 +-
 qapi/yank.json               |  2 +-
 scripts/qapi/parser.py       |  8 ++++++++
 6 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 06ab3547fdc..e575b54128e 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1048,6 +1048,24 @@ definition.
 QMP).  In other sections, the text is formatted, and rST markup can be
 used.
 
+In cases where documentation consists of several paragraphs of text with
+no intervening sections to delineate them, it may become necessary to
+explicitly declare the start of the details section by using a
+"Details:" marker. For example::
+
+  ##
+  # @foobar
+  #
+  # foobar is an example definition.
+  #
+  # Details:
+  #
+  # Since there are no other sections in this documentation, the above
+  # "Details:" marker is required to mark this and subsequent paragraphs
+  # as the "Details" section. Any automatically generated documentation
+  # sections will be inserted above this point instead of below.
+  ##
+
 QMP Examples can be added by using the ``.. qmp-example::`` directive.
 In its simplest form, this can be used to contain a single QMP code
 block which accepts standard JSON syntax with additional server
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
index 7134d4ce47e..2142f74e3c7 100644
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
@@ -1687,7 +1687,7 @@
 #
 # Query COLO status while the vm is running.
 #
-# TODO: This line is a hack to separate the example from the body
+# Details:
 #
 # .. qmp-example::
 #
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
index 8a21e9e8b56..1d52d80e672 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -590,6 +590,14 @@ def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
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


