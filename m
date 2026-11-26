Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416D606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZROVsQLD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWJA-0008QL-Cv; Thu, 26 Nov 2026 05:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIe-0008BX-Ik
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIc-0006iw-Ae
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqzJh37WsjyxtVPYzjGqhYFsN/GVFqINLZr9izjXRjI=;
 b=ZROVsQLDr96eMocY/aMpn2m7knT2fSCSbSbsex2qO2l4H/tCpGL/X3OKBLOHBXM3SxJCmM
 caP6RPk47aomLVbvWpap7Y3AgfGtaT9Fz2TZ/CgcJSkt0k7bWpzLiwP123hMbHR959IxOo
 GnYENV4vz7aHNDQglpKCahfo0qzx8NI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-WCNXnGrbPZCUwgMhZwjbTw-1; Thu,
 26 Nov 2026 10:01:46 +0000
X-MC-Unique: WCNXnGrbPZCUwgMhZwjbTw-1
X-Mimecast-MFC-AGG-ID: WCNXnGrbPZCUwgMhZwjbTw_1795687305
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8548B1955F7C; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6F91956087; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8D0621E688D; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 12/16] python/qemu: Wean off ObjectPropertyInfo member @type
Date: Thu, 26 Nov 2026 11:01:35 +0100
Message-ID: <20261126100139.3557890-13-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use members @kind and @qom-type instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 python/qemu/utils/qom_common.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index e5bae1c7421..8d324f29cc3 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -35,11 +35,12 @@ class ObjectPropertyInfo:
     """
     Represents the return type from e.g. qom-list.
     """
-    def __init__(self, name: str, type_: str,
+    def __init__(self, name: str, kind: str, qom_type: Optional[str],
                  description: Optional[str] = None,
                  default_value: Optional[object] = None):
         self.name = name
-        self.type = type_
+        self.kind = kind
+        self.qom_type = qom_type
         self.description = description
         self.default_value = default_value
 
@@ -48,20 +49,20 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyInfo':
         """
         Build an ObjectPropertyInfo from a Dict with an unknown shape.
         """
-        assert value.keys() >= {'name', 'type'}
-        return cls(value['name'], value['type'],
+        assert value.keys() >= {'name', 'kind'}
+        return cls(value['name'], value['kind'], value.get('qom-type'),
                    value.get('description'),
                    value.get('default-value'))
 
     @property
     def child(self) -> bool:
         """Is this property a child property?"""
-        return self.type.startswith('child<')
+        return self.kind == "child"
 
     @property
     def link(self) -> bool:
         """Is this property a link property?"""
-        return self.type.startswith('link<')
+        return self.kind == "link"
 
 
 class ObjectPropertyValue:
-- 
2.55.0


