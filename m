Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3492FC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZA-0002iD-Tt; Mon, 26 Feb 2024 05:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYg-0002bd-E9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003jI-EF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsgsOUSA5kYAMJI0r5yNAd03d7uI00midcMtl+CB+rU=;
 b=izOjFivmv1tmHrHHnZFd7lsLrp61iLH/pMDTBggHbggO+wXJrPhFWZ7VCaGD4vbdrZEPFp
 V9Vz3b9xXrBNbpWmMqY1gs4yXIrLkODper/ctHX6lePM+274/S0+PDv0sCfjp/SmduW+BW
 4hFOW6bMwb6lOBwF7HTIZrjBLOZayMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-X50WwBmZONCldio5c-z9ag-1; Mon, 26 Feb 2024 05:49:58 -0500
X-MC-Unique: X50WwBmZONCldio5c-z9ag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E000C882082;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB73492BE2;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 925F921E660C; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/17] sphinx/qapidoc: Drop code to generate doc for simple
 union branch
Date: Mon, 26 Feb 2024 11:49:42 +0100
Message-ID: <20240226104954.3781985-6-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 4e99f4b12c0 (qapi: Drop simple unions) eliminated implicitly
defined union branch types, except for the empty object type
'q_empty'.  QAPISchemaGenRSTVisitor._nodes_for_members() still has
code to generate documentation for implicitly defined union branch
types.  It does nothing for 'q_empty'.  Simplify.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-5-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/sphinx/qapidoc.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 05b809af27..488de23d72 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -180,17 +180,13 @@ def _nodes_for_members(self, doc, what, base=None, variants=None):
 
         if variants:
             for v in variants.variants:
-                if v.type.is_implicit():
-                    assert not v.type.base and not v.type.variants
-                    for m in v.type.local_members:
-                        term = self._nodes_for_one_member(m)
-                        term.extend(self._nodes_for_variant_when(variants, v))
-                        dlnode += self._make_dlitem(term, None)
-                else:
-                    term = [nodes.Text('The members of '),
-                            nodes.literal('', v.type.doc_type())]
-                    term.extend(self._nodes_for_variant_when(variants, v))
-                    dlnode += self._make_dlitem(term, None)
+                if v.type.name == 'q_empty':
+                    continue
+                assert not v.type.is_implicit()
+                term = [nodes.Text('The members of '),
+                        nodes.literal('', v.type.doc_type())]
+                term.extend(self._nodes_for_variant_when(variants, v))
+                dlnode += self._make_dlitem(term, None)
 
         if not dlnode.children:
             return []
-- 
2.43.0


