Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38A010F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqT-0004Fp-JN; Wed, 08 Apr 2026 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAXqM-0003PL-EL
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKy4-0005Wj-VB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaLNkC78dChf3IQ1YnUFsiyxPTWSj16Ag0PWMwgYCaM=;
 b=GBAeChwG4LOgGrzB718oWES+u0g8qs2QGfTKTFJ6tWdT+5h0zRjsTUovrj9VheomUX59xQ
 Wzmfb+8f5SZjb3LZ0OOJRlu6zDFYT7ElItHc86Ok4owGCTJ/hYpmret+nLWtEDHit/1mWU
 onqtyf3mieARW/uKC1FbTYkBkyXSHIU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-_o4l-70FP0eZEHHQCdHbbg-1; Wed,
 08 Apr 2026 00:56:41 -0400
X-MC-Unique: _o4l-70FP0eZEHHQCdHbbg-1
X-Mimecast-MFC-AGG-ID: _o4l-70FP0eZEHHQCdHbbg_1775624198
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FE191956053; Wed,  8 Apr 2026 04:56:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE33419560A6; Wed,  8 Apr 2026 04:56:29 +0000 (UTC)
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
Subject: [PATCH v2 06/10] qapi: detect potentially semantically ambiguous
 intro paragraphs
Date: Wed,  8 Apr 2026 00:55:27 -0400
Message-ID: <20260408045531.3006678-7-jsnow@redhat.com>
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com>
References: <20260408045531.3006678-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cajole the QAPI Doc parser into yelping if a QAPI Doc Block contains two
or more paragraphs of plaintext and has no instances of Members, Errors,
Returns, or Features that would naturally delineate an introduction from
additional details such as notes, examples, and additional details.

Such locations do not currently *guarantee* a difference to rendered
manual output, but later changes to the documentation generator that may
include additional auto-generated sections, and complexities from the
inliner, may increase the odds that these locations are suspect and will
need to be explicitly delineated.

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Review notes: no changes to *.ir files. --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py                     | 49 ++++++++++++++++++++++
 tests/qapi-schema/doc-missing-details.err  |  0
 tests/qapi-schema/doc-missing-details.json |  3 ++
 tests/qapi-schema/doc-missing-details.out  | 11 +++++
 tests/qapi-schema/meson.build              |  1 +
 5 files changed, 64 insertions(+)
 create mode 100644 tests/qapi-schema/doc-missing-details.err
 create mode 100644 tests/qapi-schema/doc-missing-details.json
 create mode 100644 tests/qapi-schema/doc-missing-details.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 1d52d80e672..ade26d124df 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -32,6 +32,8 @@
 from .source import QAPISourceInfo
 
 
+# pylint: disable=too-many-lines
+
 if TYPE_CHECKING:
     # pylint: disable=cyclic-import
     # TODO: Remove cycle. [schema -> expr -> parser -> schema]
@@ -962,3 +964,50 @@ def check_args_section(
 
         check_args_section(self.args, 'member')
         check_args_section(self.features, 'feature')
+
+        # Ignore free-form documentation sections
+        if self.symbol is None:
+            return
+
+        n_intro_para = 0
+        has_intro = False
+        has_other = False
+
+        for section in self.all_sections:
+            # Ignore Since: and TODO: sections
+            if section.kind in (QAPIDoc.Kind.SINCE, QAPIDoc.Kind.TODO):
+                continue
+
+            # Ignore empty plaintext sections
+            if section.kind in (QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAILS):
+                if not section.text:
+                    continue
+
+            if section.kind == QAPIDoc.Kind.INTRO:
+                has_intro = True
+                n_intro_para = len(section.text.split("\n\n"))
+            else:
+                if section.kind == QAPIDoc.Kind.MEMBER and not section.text:
+                    pass
+                elif section.kind == QAPIDoc.Kind.RETURNS and not section.text:
+                    pass
+                else:
+                    # This section is something other than an Intro section;
+                    # but we explicitly exclude stub entries for members
+                    # (undocumented fields with no text) from consideration
+                    # because they were auto-generated; they are not useful
+                    # for identifying the case "There are multiple intro
+                    # paragraphs and no other explicit source sections."
+                    has_other = True
+
+        # If an intro section is only a single paragraph, we are
+        # confident it is well and truly just an introduction. If we
+        # have a single, multi-paragraph intro section and *no other*
+        # explicit sections in source code, it is potentially a semantic
+        # goof-em-up where the intro and details sections have bled
+        # together. Warn about this case.
+        if has_intro and n_intro_para > 1 and not has_other:
+            print(
+                f"Warning: paragraphs for {self.symbol} are ambiguous "
+                "and could be either intro or details paragraphs."
+            )
diff --git a/tests/qapi-schema/doc-missing-details.err b/tests/qapi-schema/doc-missing-details.err
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/doc-missing-details.json b/tests/qapi-schema/doc-missing-details.json
new file mode 100644
index 00000000000..02c14ee768d
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-details.json
@@ -0,0 +1,3 @@
+# TODO / FIXME
+# This test intentionally triggers the parser warning
+# suggesting we use the Details: marker.
diff --git a/tests/qapi-schema/doc-missing-details.out b/tests/qapi-schema/doc-missing-details.out
new file mode 100644
index 00000000000..52ca7cb8727
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-details.out
@@ -0,0 +1,11 @@
+module ./builtin
+object q_empty
+enum QType
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-missing-details.json
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c233d77ab78..01da8534f2e 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -85,6 +85,7 @@ schemas = [
   'doc-long-line.json',
   'doc-misplaced-details.json',
   'doc-missing-colon.json',
+  'doc-missing-details.json',
   'doc-missing-expr.json',
   'doc-missing-space.json',
   'doc-missing.json',
-- 
2.53.0


