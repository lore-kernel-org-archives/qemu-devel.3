Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A09ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGfLE-0001l8-Hj; Wed, 05 Nov 2025 10:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGfLB-0001kk-OI
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 10:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGfLA-0007cp-CJ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 10:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762356145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZxN1/sJkXIkgfPdR4ACmuVXQYkfgeuGtDX6CwgvNIdY=;
 b=hmzTc9JSpRvfKLJkl7fTWvsfJpIrVeGFQLUMAu9cizIsGvb5Q85QpBxbE7EjuU9doMIhL+
 p4YJikbaBml4BovX5aUJk9Zq2Ge9Eg5WPnkKgvDfiSokRNlSP95FvmeNG10Tbnp689yNNz
 tn8EJLsG/l3grLFmO+B7yBPmmhl8vFc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-CpcMsgxXPna-tTiY4V1rRA-1; Wed,
 05 Nov 2025 10:22:24 -0500
X-MC-Unique: CpcMsgxXPna-tTiY4V1rRA-1
X-Mimecast-MFC-AGG-ID: CpcMsgxXPna-tTiY4V1rRA_1762356143
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AB5C1956095; Wed,  5 Nov 2025 15:22:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E30D1300018D; Wed,  5 Nov 2025 15:22:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37D1321E6A27; Wed, 05 Nov 2025 16:22:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	vsementsov@yandex-team.ru
Subject: [PATCH] qapi/parser: Mollify mypy
Date: Wed,  5 Nov 2025 16:22:19 +0100
Message-ID: <20251105152219.311154-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

re.match(r'^ *', ...) can't fail, but mypy doesn't know that and
complains:

    scripts/qapi/parser.py:444: error: Item "None" of "Match[str] | None" has no attribute "end"  [union-attr]

Work around by using must_match() instead.

Fixes: 8107ba47fd78 (qapi: Add documentation format validation)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 1bb1af7051..c3cf33904e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -441,7 +441,7 @@ def get_doc_line(self) -> Optional[str]:
             self._literal_mode = True
             self._literal_mode_indent = 0
         elif self._literal_mode and line:
-            indent = re.match(r'^ *', line).end()
+            indent = must_match(r'\s*', line).end()
             if self._literal_mode_indent == 0:
                 self._literal_mode_indent = indent
             elif indent < self._literal_mode_indent:
-- 
2.49.0


