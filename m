Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B65C36001
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 01:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvnMo-0005GP-Ek; Fri, 21 Mar 2025 21:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tvnMk-0005FG-0J
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 21:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tvnMi-0002xy-7b
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 21:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742605771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjP/row18jXL73vj5teE531SmQt9p6smZ45KD4CgyMc=;
 b=MT4OZ6oJwaWnvLReM23qfzbk5gzT299m3V0Nis+xtFmGcYMjZoDE6nVILKvXjy3SGkR6lN
 qO85qJoy9SZ+KWntq9IHdiptnlA09LEnGJ4q/hII5lQkqG3pWoA+5K/O5OWrxQwZtIlSbk
 nWcIJ27whNGNZ333Gtq4vY2vonziYwY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-pGQeI6bUMga3QinITXqwfg-1; Fri,
 21 Mar 2025 21:09:28 -0400
X-MC-Unique: pGQeI6bUMga3QinITXqwfg-1
X-Mimecast-MFC-AGG-ID: pGQeI6bUMga3QinITXqwfg_1742605765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D58F180049D; Sat, 22 Mar 2025 01:09:24 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C493D192ED68; Sat, 22 Mar 2025 01:09:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 John Snow <jsnow@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Zhenwei Pi <pizhenwei@bytedance.com>, Mads Ynddal <mads@ynddal.dk>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 1/4] docs/qapi-domain: add return-nodesc
Date: Fri, 21 Mar 2025 21:08:54 -0400
Message-ID: <20250322010857.309490-2-jsnow@redhat.com>
In-Reply-To: <20250322010857.309490-1-jsnow@redhat.com>
References: <20250322010857.309490-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index a748529f515..5ca060fa04c 100644
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
index c94af5719ca..d6d4a70f3df 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -529,6 +529,14 @@ class QAPICommand(QAPIObject):
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
2.48.1


