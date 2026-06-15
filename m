Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E8CD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4J-0002r9-NB; Mon, 15 Jun 2026 16:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4I-0002qM-AR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4G-0002BG-TM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IzJU7fLiQ+OI3OVxJg3BiQ9kVmShuma5bxJM/6bUzE=;
 b=JY9e1zUfqHx3HgXBp4IPS0s7gNQmM752rM9mOwqyRg5flYO6v+cY/HkqO6UvnXXWVJ91h+
 acmrb6F7VRL7Go/Esi2kEP+xcDShAZ0qpkf8Vd1di0WQaACp/nGN1rUVI8koTQJZnrogBF
 ijTY+yvcnN+mcjFH/j40WV4PRYP4ZRw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-Q1qmkLoBNVGzs-ZIk9F5iA-1; Mon,
 15 Jun 2026 16:37:56 -0400
X-MC-Unique: Q1qmkLoBNVGzs-ZIk9F5iA-1
X-Mimecast-MFC-AGG-ID: Q1qmkLoBNVGzs-ZIk9F5iA_1781555875
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9948318001F0; Mon, 15 Jun 2026 20:37:55 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D491414; Mon, 15 Jun 2026 20:37:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:28 +0400
Subject: [PATCH v2 02/53] qapi/introspect: expose the type name map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-2-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5ld04Km69gTihvCVA+G8/s2NgBnD5vvjVRkp5Y12BUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKN3D3zL00infnm2V5p5rBs32JpbMpVIYeUV
 zVK1lPzU8WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijQAKCRDa6OEJdZac
 5VQyEACVWn/8b757+m+nqX+psomUPZw4iLfKrEyLRTjG9rZejTRS4qI9OKiWOhU6IEQOKSPW0iI
 bVRuAhn/mIj6DArt/sXAu10eyvpRYk9gFkkOk1kdQsbFZdc5QNPtsU3ltksn8rpeAddXMuFFIpH
 T+7X4nx7y/CbrlTqlV3N53UygPIE+M8bzLR0S/KY//7gCviwdWpoVqtrubb984WerFTc/bT+5Sm
 6UzpF+5eEMs4HqTiA83F8qCY6+wF4VfKsAD3CzZAzXsw5PkmJ446KyhMn7pG6NrcXjozN881IO6
 VJNX+bQ2xUyXWr6TeAPBOTHfp8xnvKNfnkRgSZWoWPDS79TwkTvaWWVLiD1g28GbFAW/hyxhPv2
 48cWzDYdphbytEYYPtuaLQ5pW7ZLT55og9PZYM/J0XuTMI88GAnnEOFsw3AtnQlevFm5mQm4hOo
 pRbNr74uaGOtd/xnnu6TnMsEmmmhCdDzXTtOAhET1F0x8K3EI52rAgTlxaZRMIZMyubD7MaSCVP
 TU2C4aHM1vGqOqn5mn+oJHTgVFDNObug8u45V/QJ7UkwItqhEOh7WvRce2mFXT3lG1VVcZDZjhh
 dWwVM0eGmEzMoVqNfhKiQYbV9F1Z9cdwoZFO9ag/L28vi3u2bYmK7Z6GGVFgX3bYtfEDRAgPaCr
 DI0hLJhK8J++a9w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Preserve the internal-to-masked name map computed during introspection
visitation and return it from gen_introspect(). The type-infos generator
will consume this map to produce per-type QAPITypeInfo constants with
correct masked names.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 7e28de2279a..d3d3de481f4 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -178,6 +178,7 @@ def __init__(self, prefix: str, unmask: bool):
         self._trees: List[Annotated[SchemaInfo]] = []
         self._used_types: List[QAPISchemaType] = []
         self._name_map: Dict[str, str] = {}
+        self._final_name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -208,8 +209,17 @@ def visit_end(self) -> None:
         self._schema = None
         self._trees = []
         self._used_types = []
+        self._final_name_map = dict(self._name_map)
         self._name_map = {}
 
+    def name_map(self) -> Dict[str, str]:
+        """Return the QAPI-name-to-schema-name map.
+
+        Must be called after visit() has completed; the map is
+        populated during visit_end().
+        """
+        return self._final_name_map
+
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # Ignore types on first pass; visit_end() will pick up used types
         return not isinstance(entity, QAPISchemaType)
@@ -387,7 +397,8 @@ def visit_event(self, name: str, info: Optional[QAPISourceInfo],
 
 
 def gen_introspect(schema: QAPISchema, output_dir: str, prefix: str,
-                   opt_unmask: bool) -> None:
+                   opt_unmask: bool) -> Dict[str, str]:
     vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
     schema.visit(vis)
     vis.write(output_dir)
+    return vis.name_map()

-- 
2.54.0


