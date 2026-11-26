Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92F606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NrIyiPRc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIq-0008Iu-3A; Thu, 26 Nov 2026 05:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIe-0008Aq-GK
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIa-0006hm-3t
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AbLji0IfyYfwjZTpbMpa0hLpPEf0/vhPjdwsNulQD0=;
 b=NrIyiPRcyMHKBSXol+VzJ8jkmuZAryRhjd0hidL76HugoVdTipCk0FtxWZT3UB8wj2cQFb
 GTYj1QXLUePeWP2vxOxhhvKNC8hu2d2LmGoAUQcJ4fqYH3qzj7iPAPgYM7MVgTui+QZPjb
 zDeMFFdrH1+M6Kb9O12o2nVZ9t11GDE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-Yakw_yeNNcazSJH4lQQuzg-1; Thu,
 26 Nov 2026 10:01:49 +0000
X-MC-Unique: Yakw_yeNNcazSJH4lQQuzg-1
X-Mimecast-MFC-AGG-ID: Yakw_yeNNcazSJH4lQQuzg_1795687308
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C46B1955EAC; Thu, 26 Nov 2026 10:01:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A9D01956086; Thu, 26 Nov 2026 10:01:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00D8021E6893; Thu, 26 Nov 2026 11:01:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 15/16] python/qemu: Wean off ObjectPropertyValue member @type
Date: Thu, 26 Nov 2026 11:01:38 +0100
Message-ID: <20261126100139.3557890-16-armbru@redhat.com>
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

QOMTree._list_nodes() uses @type to print non-child properties like
"NAME: VALUE (TYPE)".  Drop (TYPE).  This affects qom-tree.

Replace all other uses of @type by @kind and @qom-type.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 python/qemu/utils/qom.py        |  2 +-
 python/qemu/utils/qom_common.py | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/python/qemu/utils/qom.py b/python/qemu/utils/qom.py
index 05e5f141791..9f113240f9b 100644
--- a/python/qemu/utils/qom.py
+++ b/python/qemu/utils/qom.py
@@ -242,7 +242,7 @@ def _list_nodes(self, paths: List[str]) -> None:
                     value = item.value
                     if value is None:
                         value = "<EXCEPTION: property could not be read>"
-                    print(f"  {item.name}: {value} ({item.type})")
+                    print(f"  {item.name}: {value}")
 
             print('')
 
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index 8d324f29cc3..c0f684bc455 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -69,9 +69,11 @@ class ObjectPropertyValue:
     """
     Represents a property return from e.g. qom-tree-get
     """
-    def __init__(self, name: str, type_: str, value: object):
+    def __init__(self, name: str, kind: str, qom_type: Optional[str],
+                 value: object):
         self.name = name
-        self.type = type_
+        self.kind = kind
+        self.qom_type = qom_type
         self.value = value
 
     @classmethod
@@ -79,13 +81,14 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyValue':
         """
         Build an ObjectPropertyValue from a Dict with an unknown shape.
         """
-        assert value.keys() >= {'name', 'type'}
-        return cls(value['name'], value['type'], value.get('value'))
+        assert value.keys() >= {'name', 'kind'}
+        return cls(value['name'], value['kind'], value.get('qom-type'),
+                   value.get('value'))
 
     @property
     def child(self) -> bool:
         """Is this property a child property?"""
-        return self.type.startswith('child<')
+        return self.kind == "child"
 
 
 class ObjectPropertiesValues:
@@ -104,7 +107,7 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectPropertiesValues':
         """
         assert value.keys() <= {'properties'}
         props = [ObjectPropertyValue(item['name'],
-                                     item['type'],
+                                     item['kind'], item.get('qom-type'),
                                      item.get('value'))
                  for item in value['properties']]
         return cls(props)
-- 
2.55.0


