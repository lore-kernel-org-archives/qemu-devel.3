Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C13CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJyh-0006xc-BP; Mon, 28 Sep 2026 18:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyf-0006xI-4t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyd-0006Ci-6u
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlsGHieLVzsYLcnNJcSRdA6Jix7RfHABXE9ZNt3gV4k=;
 b=DorZ8ayE509KJ7uu11sy5Amz5gChsRtnM2foTpUaZ5JpCqlBsq2qgjpN8D56fbxz16btd9
 P1E2Q2C04WpnKHVFPdkvDFfkleIjCSNIj1Dg6BN9Seonyb/o7enKv8SdwJdcQwafGvGkKM
 IcubDdkvaPHPD5IB1FUQ8TmcojggdmI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-Kd5FYDKQMZCD8mKBuqJomw-1; Mon,
 28 Sep 2026 18:37:35 -0400
X-MC-Unique: Kd5FYDKQMZCD8mKBuqJomw-1
X-Mimecast-MFC-AGG-ID: Kd5FYDKQMZCD8mKBuqJomw_1790635053
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 630EF1800A47; Mon, 28 Sep 2026 22:37:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCE801956047; Mon, 28 Sep 2026 22:37:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex@shazbot.org>,
 Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 02/14] docs/qapi-code-gen: expand each section's syntax into a
 mini-section
Date: Mon, 28 Sep 2026 18:36:45 -0400
Message-ID: <20260928223657.2303684-3-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While grouping Features and Argument descriptions together is
syntactically elegant, it is more helpful to document how a QAPI
definition documentation block is laid out from start to finish.

Break apart and re-order the documentation for each section into a
logical order that follows the document flow. Add cross-references and
revise the documentation as we go.

Note that as of this commit, we do not enforce a total section
ordering for source documentation, but the order in which these
sections are being presented matches the order we wish to enforce in a
forthcoming commit:

 1. Intro
 2. Members/Arguments/etc
 3. Returns
 4. Errors
 5. Features
 6. Details
 7. Since
 X. TODO (Not rendered or ordered.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 110 ++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index b1cc5b5f0db..3ac1c2dae18 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -985,13 +985,23 @@ When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
 Definition documentation starts with a description naming the
-definition with an optional indented overview, a description of each
-argument (for commands and events), member (for structs and unions),
-branch (for alternates), or value (for enums), a description of each
-feature (if any), and finally optional tagged sections.
+definition with an optional indented overview (the "intro"),
+:ref:`descriptions <doc-descrip>` of each argument (for commands and
+events), member (for structs and unions), branch (for alternates), or
+value (for enums), :ref:`feature descriptions <doc-feat>` of each
+feature (if any), and finally optional :ref:`tagged sections
+<doc-tagged>`.
 
-Descriptions start with '\@name:'.  The description text must be
-indented like this::
+.. _doc-descrip:
+
+Descriptions
+^^^^^^^^^^^^
+
+Descriptions start with '\@name:'.  These are used to document
+arguments (for commands and events), members (for structs and unions),
+branches (for alternates), or values (for enums).
+
+The description text must be indented like this::
 
  # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
  #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
@@ -1001,15 +1011,12 @@ indented like this::
 .. FIXME union branches should be described, too.
 
 Extensions added after the definition was first released carry a
-"(since x.y.z)" comment.
+"(since x.y)" comment.
 
-The feature descriptions must be preceded by a blank line and then a
-line "Features:", like this::
+.. _doc-tagged:
 
-  #
-  # Features:
-  #
-  # @feature: Description text
+Tagged sections
+^^^^^^^^^^^^^^^
 
 A tagged section begins with a paragraph that starts with one of the
 following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends with
@@ -1024,8 +1031,29 @@ like this::
  #     Duis aute irure dolor in reprehenderit in voluptate velit esse
  #     cillum dolore eu fugiat nulla pariatur.
 
-"Returns" and "Errors" sections are only valid for commands.  They
-document the success and the error response, respectively.
+
+Returns
+^^^^^^^
+
+"Returns" :ref:`doc-tagged` are only valid for commands.  They document the
+success response of the command. If there is some nuance to capture
+with the return value, it may be documented as::
+
+  #
+  # Returns: eBPF object encoded in base64. Long lines should be
+  #     wrapped and indented.
+  #
+
+The type of the return value will be added to the documentation
+automatically. If there is nothing relevant to add apart from type,
+this section may be omitted.
+
+
+Errors
+^^^^^^
+
+"Errors" :ref:`doc-tagged` are only valid for commands.  They document
+the error responses.
 
 "Errors" sections should be formatted as an rST list, each entry
 detailing a relevant error condition.  For example::
@@ -1034,12 +1062,33 @@ detailing a relevant error condition.  For example::
  #     - If @device does not exist, DeviceNotFound
  #     - Any other error returns a GenericError.
 
-A "Since: x.y.z" tagged section lists the release that introduced the
-definition.
 
-"TODO" sections are not rendered (they are for developers, not users of
-QMP).  In other sections, the text is formatted, and rST markup can be
-used.
+.. _doc-feat:
+
+Feature Descriptions
+^^^^^^^^^^^^^^^^^^^^
+
+Feature descriptions are a :ref:`doc-descrip` section that document features
+that apply to this definition.
+
+The feature descriptions must be preceded by a blank line and then a
+line "Features:", like this::
+
+  #
+  # Features:
+  #
+  # @feature: Description text
+
+
+Details
+^^^^^^^
+
+Details sections are comprised of one or more paragraphs of rST
+formatted text, but otherwise are not marked up in any specific
+way. In general, this text contains in-depth explanations of the
+definition being documented and may include various rST admonitions
+like ``.. seealso::``, ``.. note::``, etc. This is also the section
+where QMP usage examples should be placed.
 
 QMP Examples can be added by using the ``.. qmp-example::`` directive.
 In its simplest form, this can be used to contain a single QMP code
@@ -1089,6 +1138,27 @@ Highlighting in non-QMP languages can be accomplished by using the
 achieved by omitting the language argument.
 
 
+Tagged section: Since
+^^^^^^^^^^^^^^^^^^^^^
+
+A "Since: x.y" :ref:`doc-tagged` lists the release that introduced the
+definition::
+
+  #
+  # Since: 11.2
+  #
+
+
+TODO
+^^^^
+
+"TODO" tagged sections are not rendered (they are for developers, not users of
+QMP).
+
+
+Putting it all together
+^^^^^^^^^^^^^^^^^^^^^^^
+
 Examples of complete definition documentation::
 
  ##
-- 
2.55.0


