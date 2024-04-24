Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F35CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpC-0001Gp-8a; Wed, 24 Apr 2024 04:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXog-0000PD-Pg
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoc-0006NN-Np
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3PB96E5geOcilAlxYVVbJAYbBbSyK2NOflBBzkZQT4=;
 b=JXJF2HwqQUiiK/lT4rTkKp9E8zeMaSF7DUiFZMeBKZfwoWIvecP0JWcr/TdTmuOq+cYz09
 qrE1Qm5xIZuzt4UI1t5+DgVNX6A2HqsR4E4gCC04G+2TxybLb1Fnd1MOhcEvGXXHXhZmQn
 ziQvEbT+h6TGtYNXEmK/g0hhKtlLEHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-rPfsceHKO2Cwn-MZZ7ufXA-1; Wed, 24 Apr 2024 04:17:13 -0400
X-MC-Unique: rPfsceHKO2Cwn-MZZ7ufXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B28318065AF;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CBBA112132A;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D537121E66AB; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 06/25] qapi/schema: declare type for
 QAPISchemaObjectTypeMember.type
Date: Wed, 24 Apr 2024 10:16:51 +0200
Message-ID: <20240424081710.2907748-7-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A QAPISchemaObjectTypeMember's type gets resolved only during .check().
We have QAPISchemaObjectTypeMember.__init__() initialize self.type =
None, and .check() assign the actual type.  Using .type before .check()
is wrong, and hopefully crashes due to the value being None.  Works.

However, it makes for awkward typing.  With .type:
Optional[QAPISchemaType], mypy is of course unable to see that it's None
before .check(), and a QAPISchemaType after.  To help it over the hump,
we'd have to assert self.type is not None before all the (valid) uses.
The assertion catches invalid uses, but only at run time; mypy can't
flag them.

Instead, declare .type in .__init__() as QAPISchemaType *without*
initializing it.  Using .type before .check() now certainly crashes,
which is an improvement.  Mypy still can't flag invalid uses, but that's
okay.

Addresses typing errors such as these:

qapi/schema.py:657: error: "None" has no attribute "alternate_qtype"  [attr-defined]
qapi/schema.py:662: error: "None" has no attribute "describe"  [attr-defined]

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-7-armbru@redhat.com>
---
 scripts/qapi/schema.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b298c8b4f9..307f8af01a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -786,7 +786,7 @@ def __init__(self, name, info, typ, optional, ifcond=None, features=None):
             assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
-        self.type = None
+        self.type: QAPISchemaType  # set during check()
         self.optional = optional
         self.features = features or []
 
-- 
2.44.0


