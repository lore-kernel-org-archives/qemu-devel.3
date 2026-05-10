Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F35BCD37B9
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4S0-0007rM-SX; Sun, 10 May 2026 09:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Rs-0007r8-T5
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Rr-0004Lw-Ed
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IzJU7fLiQ+OI3OVxJg3BiQ9kVmShuma5bxJM/6bUzE=;
 b=aQkW30UB9wSWSSn0aJ9VYhZbhUppFTi8tYMrKZ6BOLjM8nfTkGDTDJJST4zQrDShRWShIQ
 5aeao/A8UNnzeMdLn27CSxz53XFL6zosP2S7ltq9gLg53XLqvS/9XIJangcfruPoer1iqy
 tn/+DLGzqPcvZuPJ5KJQoEnbFW8oFVM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-7MEzvOv4Ox6g8R_vviQqow-1; Sun,
 10 May 2026 09:43:56 -0400
X-MC-Unique: 7MEzvOv4Ox6g8R_vviQqow-1
X-Mimecast-MFC-AGG-ID: 7MEzvOv4Ox6g8R_vviQqow_1778420636
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E05EC19560A2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:43:55 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A056C18004A3; Sun, 10 May 2026 13:43:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:42:59 +0400
Subject: [PATCH 02/54] qapi/introspect: expose the type name map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-2-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5ld04Km69gTihvCVA+G8/s2NgBnD5vvjVRkp5Y12BUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItu48nc2dBcrLXo9GKXCMWRahu0t5LW3Y4ai
 NVahXzvS7WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5WJrD/9/T16S2A1pehu+mZ/CJN0Agoy7Uc0WVJo8mqYorNmipAdrta3x7KkB/g9y45X9z6pVYbr
 VUtQ6V48LJ4A06Kp0yHk2sJXL/9h8HjE46P06v+m68CyeNerEWbUedAK2YrXoWalvDe1hso9YrY
 gN50dvxkFKlsg80XWj5DJFQiLzi5a7GwwC582mzV03AiC6inpmdB1tDKd9DcpyqYNa8QbAJW5uC
 o51pbJeNI4b0Bhyreu23HAd4go56vykgcEekab9XqOGdJ58TrtUXt+suWN/9vL3hZxbld/F/3OI
 j2u8JTr9T6bfuaSL+kDGjsSlcLdmTWppw/dqXG5Qy1El5dIOqrhOoedK/qW0oIZF/+YAf3OgDaU
 InpKfxJYO+mSBZUrRtC8A5LQGL+w7Rm07VyeqSSEwfEqLzQYclAlK7yTU6TG7LYWlZ1diGaZZoj
 9mxpxM7LT10J0u7A5P2QrmOmNhUMRvAw4+ZQzGi3wCQvXvqtu5r01FH3RNT61ro0Fp5Hj9ZV9PX
 mp/3BTE0Kmymh/HglDhEG7iJ7gvP6Tsa6iyH9XLqyDj7Y2P/oZ1Le/gXFvgztXOYUhL+ocqA4Q/
 c0s42ep1Aszow9TDUJC2pB4H+e21SsnCQR204nApFNI9jtc5//6kS1i2mijXttdyZRSIMvELbB3
 TERG18WlBQcF3TQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


