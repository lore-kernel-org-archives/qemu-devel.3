Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298FAC3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWtP-0003Wv-5c; Wed, 26 Mar 2025 15:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWtO-0003WK-7S
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txWtL-0008J2-1W
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743019100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjP/row18jXL73vj5teE531SmQt9p6smZ45KD4CgyMc=;
 b=KbbZN8ADwHLjpNbuBbCuvJ9+xkrPWSoMNkkUgZ/K57IvwjNhOPJ5hwftgFc/nLVaaikG4z
 GJ+Yvi18DJpaSj+k7ES9qtE4d1308SL+kS7vtLKsUmGavfiXVCImUyR/fS81ifd3a5Pf99
 sgv7k0NHwWkeegEB8t8mlW16q3bWc70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-HM3tYCnSNjqq4kiAAJYWmg-1; Wed,
 26 Mar 2025 15:58:17 -0400
X-MC-Unique: HM3tYCnSNjqq4kiAAJYWmg-1
X-Mimecast-MFC-AGG-ID: HM3tYCnSNjqq4kiAAJYWmg_1743019094
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E052F18004A9; Wed, 26 Mar 2025 19:58:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.152])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55E631801A6D; Wed, 26 Mar 2025 19:58:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Hanna Reitz <hreitz@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Zhenwei Pi <pizhenwei@bytedance.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v2 1/4] docs/qapi-domain: add return-nodesc
Date: Wed, 26 Mar 2025 15:57:53 -0400
Message-ID: <20250326195756.330817-2-jsnow@redhat.com>
In-Reply-To: <20250326195756.330817-1-jsnow@redhat.com>
References: <20250326195756.330817-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


