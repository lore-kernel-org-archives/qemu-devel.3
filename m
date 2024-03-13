Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2038C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRF-00082K-NM; Wed, 13 Mar 2024 00:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQv-0007uQ-KC
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQt-0001sM-JY
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NavLvS6rBldL7oxXMuG+C39E9A+moUuZMnnLhZNAYms=;
 b=SFiEK2/NUVLme3E1+hjpK4MS31xSZJaF9HDT6wq84ecqNJARKAskXxs4lzppmSTwByV/yn
 cBf1JT3Fuep+io+Mv9QJ9tZ6kpHNFqU+rlXZ4VbE7gMadNNbiJpcUP/olU/tEeS2NwzHtj
 Rc/ILMbLmuJ/cqF3X1iC38jhyGF5R8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-035zUkxCOviLYvlSpVseXw-1; Wed,
 13 Mar 2024 00:41:35 -0400
X-MC-Unique: 035zUkxCOviLYvlSpVseXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F27F029AB3F5;
 Wed, 13 Mar 2024 04:41:34 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8148175AD;
 Wed, 13 Mar 2024 04:41:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 19/23] qapi/parser: demote QAPIExpression to Dict[str, Any]
Date: Wed, 13 Mar 2024 00:41:23 -0400
Message-ID: <20240313044127.49089-20-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Dict[str, object] is a stricter type, but with the way that code is
currently arranged, it is infeasible to enforce this strictness.

In particular, although expr.py's entire raison d'être is normalization
and type-checking of QAPI Expressions, that type information is not
"remembered" in any meaningful way by mypy because each individual
expression is not downcast to a specific expression type that holds all
the details of each expression's unique form.

As a result, all of the code in schema.py that deals with actually
creating type-safe specialized structures has no guarantee (myopically)
that the data it is being passed is correct.

There are two ways to solve this:

(1) Re-assert that the incoming data is in the shape we expect it to be, or
(2) Disable type checking for this data.

(1) is appealing to my sense of strictness, but I gotta concede that it
is asinine to re-check the shape of a QAPIExpression in schema.py when
expr.py has just completed that work at length. The duplication of code
and the nightmare thought of needing to update both locations if and
when we change the shape of these structures makes me extremely
reluctant to go down this route.

(2) allows us the chance to miss updating types in the case that types
are updated in expr.py, but it *is* an awful lot simpler and,
importantly, gets us closer to type checking schema.py *at
all*. Something is better than nothing, I'd argue.

So, do the simpler dumber thing and worry about future strictness
improvements later.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index ec4ebef4e33..2f3c704fa24 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -19,6 +19,7 @@
 import re
 from typing import (
     TYPE_CHECKING,
+    Any,
     Dict,
     List,
     Mapping,
@@ -43,7 +44,7 @@
 _ExprValue = Union[List[object], Dict[str, object], str, bool]
 
 
-class QAPIExpression(Dict[str, object]):
+class QAPIExpression(Dict[str, Any]):
     # pylint: disable=too-few-public-methods
     def __init__(self,
                  data: Mapping[str, object],
-- 
2.44.0


