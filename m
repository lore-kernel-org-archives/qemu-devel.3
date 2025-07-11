Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA460C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua62h-0008Nv-0V; Fri, 11 Jul 2025 01:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua62e-0008Eq-2U
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua62b-0000Em-UX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752210679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xa077rVFvzC/zL3iOmNcf/FeXENytQE3nonaVEmrN+E=;
 b=OpX0bTdFJQJ3H2/ct6SQ4IeWvQs5aG82Th0bARNllH7uhF7nANl4jjrBeKOkIugS/llpdi
 RQuRl+zN4nyjxnQ7kQk3NhkGbV1gIJFw5z0HKMvr2Asfth4qHL3K0u0eVdO0Q/RZP3l9Sc
 Qa2Dj2gcJK1GTbhuMDPgqTDsbAGuGPc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-5GWakjI2P6--NNkB4Y021g-1; Fri,
 11 Jul 2025 01:11:15 -0400
X-MC-Unique: 5GWakjI2P6--NNkB4Y021g-1
X-Mimecast-MFC-AGG-ID: 5GWakjI2P6--NNkB4Y021g_1752210673
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 881AC1800366; Fri, 11 Jul 2025 05:11:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 344713000221; Fri, 11 Jul 2025 05:11:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v6 1/4] docs/qapi-domain: add return-nodesc
Date: Fri, 11 Jul 2025 01:10:42 -0400
Message-ID: <20250711051045.51110-2-jsnow@redhat.com>
In-Reply-To: <20250711051045.51110-1-jsnow@redhat.com>
References: <20250711051045.51110-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This form is used to annotate a return type without an accompanying
description, for when there is no "Returns:" information in the source
doc, but we have a return type we want to generate a cross-reference to.

The syntax is:

:return-nodesc: TypeName

It's primarily necessary because Sphinx always expects both a type and a
description for the prior form and will format it accordingly. To have a
reasonable rendering when the body is missing, we need to use a
different info field list entirely.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-domain.rst | 30 ++++++++++++++++++++++++++++++
 docs/sphinx/qapi_domain.py |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index 11238723c2d..204abb72ff4 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -242,6 +242,36 @@ Example::
              }
 
 
+``:return-nodesc:``
+-------------------
+
+Document the return type of a QAPI command, without an accompanying description.
+
+:availability: This field list is only available in the body of the
+               Command directive.
+:syntax: ``:return-nodesc: type``
+:type: `sphinx.util.docfields.Field
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.Field.html?private=1>`_
+
+
+Example::
+
+   .. qapi:command:: query-replay
+      :since: 5.2
+
+      Retrieve the record/replay information.  It includes current
+      instruction count which may be used for ``replay-break`` and
+      ``replay-seek`` commands.
+
+      :return-nodesc: ReplayInfo
+
+      .. qmp-example::
+
+          -> { "execute": "query-replay" }
+          <- { "return": {
+                 "mode": "play", "filename": "log.rr", "icount": 220414 }
+             }
+
 ``:value:``
 -----------
 
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index ebc46a72c61..f561dc465f8 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -532,6 +532,14 @@ class QAPICommand(QAPIObject):
                 names=("return",),
                 can_collapse=True,
             ),
+            # :return-nodesc: TypeName
+            CompatField(
+                "returnvalue",
+                label=_("Return"),
+                names=("return-nodesc",),
+                bodyrolename="type",
+                has_arg=False,
+            ),
         ]
     )
 
-- 
2.50.0


