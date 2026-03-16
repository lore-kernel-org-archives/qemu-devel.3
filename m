Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ECAF53D86
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cey-0002J6-AQ; Mon, 16 Mar 2026 14:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Cel-0002DH-Ab
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Ceg-0007xT-Cr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ei4aQY7VT0T8rdfeAOBGN2KI2lTl3AJb+i0rhiwk9r0=;
 b=HOItc/8WRapYvj0epcDgvFbVDEWQ+8/V+dbUyE4WPu7d4pWQTVxWFavxn0ctfKhqZOgDtL
 guTD3DxyWaotNvfN7Z2knIJeJH/VOS6FJsFMH7tP3OK5BDnNNjDwAq5cKE2Prb/fSPfYEt
 D5djsOpM5HimmjAZd7GTi1UEvXngBZg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-ffODOIcEOAuOXJb4i59YBA-1; Mon,
 16 Mar 2026 14:27:01 -0400
X-MC-Unique: ffODOIcEOAuOXJb4i59YBA-1
X-Mimecast-MFC-AGG-ID: ffODOIcEOAuOXJb4i59YBA_1773685619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B05EC1800345; Mon, 16 Mar 2026 18:26:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45CCF30001A2; Mon, 16 Mar 2026 18:26:49 +0000 (UTC)
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
Subject: [PATCH 4/8] qapi: detect potentially semantically ambiguous intro
 paragraphs
Date: Mon, 16 Mar 2026 14:26:03 -0400
Message-ID: <20260316182608.148628-5-jsnow@redhat.com>
In-Reply-To: <20260316182608.148628-1-jsnow@redhat.com>
References: <20260316182608.148628-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cajole the QAPI Doc parser into yelping if a QAPI Doc Block contains
more than one paragraph of plaintext and has no instances of Members,
Errors, Returns, or Features that would naturally delineate an
introduction from additional details such as notes, examples, and
additional details.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index da47ee55bdd..9e8dfc67208 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -960,3 +960,47 @@ def check_args_section(
 
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
+            elif not (
+                    section.kind == QAPIDoc.Kind.MEMBER and not section.text
+            ):
+                # This section is something other than an Intro section;
+                # but we explicitly exclude stub entries for members
+                # (undocumented fields with no text) from consideration
+                # because they were auto-generated; they are not useful
+                # for identifying the case "There are multiple intro
+                # paragraphs and no other explicit source sections."
+                has_other = True
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
-- 
2.53.0


