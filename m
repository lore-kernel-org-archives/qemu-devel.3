Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09116C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrI-0003fJ-F5; Tue, 11 Mar 2025 07:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqt-0003OK-Bw
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqC-0006WS-0R
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIz5D146hfHkf+gYrn3NUb8y77ROWgAaRiF8ghz04Zc=;
 b=JowILy14ev/hRoIb3X5LFg2wq03giG2iY9x4cy3rkuJ4zamoE1szB/gSALLHM0t1CY6hnl
 fd5J0t080VnCvX0rO6p9vNBpJLMo8H9UO0nDc33Vb1dS1t0oBnmiUs0V94ykGKci34f13W
 zKbB0ij+oTZTze4PW5pwJVGRa2i8dVA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-KVQxNFDrP3Od3N6a27Pzpg-1; Tue,
 11 Mar 2025 07:31:58 -0400
X-MC-Unique: KVQxNFDrP3Od3N6a27Pzpg-1
X-Mimecast-MFC-AGG-ID: KVQxNFDrP3Od3N6a27Pzpg_1741692717
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76E4619560B4
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AEF21801752
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 50A8521E61BB; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 38/61] qapi/source: allow multi-line QAPISourceInfo advancing
Date: Tue, 11 Mar 2025 12:31:14 +0100
Message-ID: <20250311113137.1277125-39-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

This is for the sake of the new rST generator (the "transmogrifier") so
we can advance multiple lines on occasion while keeping the
generated<-->source mappings accurate.

next_line now simply takes an optional n parameter which chooses the
number of lines to advance.

The next patch will use this when converting section syntax in free-form
documentation to more traditional rST section header syntax, which does
not always line up 1:1 for line counts.

For example:

```
 ##
 # = Section     <-- Info is pointing here, "L1"
 #
 # Lorem Ipsum
 ##
```

would be transformed to rST as:

```
=======        <-- L1
Section        <-- L1
=======        <-- L1
               <-- L2
Lorem Ipsum    <-- L3
```

After consuming the single "Section" line from the source, we want to
advance the source pointer to the next non-empty line which requires
jumping by more than one line.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250311034303.75779-42-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/source.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 7b379fdc92..ffdc3f482a 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
         self.defn_meta = meta
         self.defn_name = name
 
-    def next_line(self: T) -> T:
+    def next_line(self: T, n: int = 1) -> T:
         info = copy.copy(self)
-        info.line += 1
+        info.line += n
         return info
 
     def loc(self) -> str:
-- 
2.48.1


