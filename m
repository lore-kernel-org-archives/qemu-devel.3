Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E3C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRC-0007yw-F3; Wed, 13 Mar 2024 00:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQx-0007vM-Du
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQv-0001tN-He
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDBILCYokuD+BvPljO3SV3muUHZxbA1WQCNU/LWfLsw=;
 b=MKeJMofyJZBfJ1Sc+ZLWw46R4NCTA4GHCXRcv8omVJsCd2G0J/Gi8uOysGwkzE1Mhay/R6
 PUig4Qpxh23f9gbckGQNsuso2BUjiiS7YoIwrENV/Jbs8iZADIhFkrpEqVY9KH2HjBbx8B
 dPb4751JqepBuCnNgK1oj9ecz7XIok8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-RYAPmci5OfqE8mE5f9PJ6w-1; Wed, 13 Mar 2024 00:41:34 -0400
X-MC-Unique: RYAPmci5OfqE8mE5f9PJ6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C73D785A58C;
 Wed, 13 Mar 2024 04:41:33 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C49C10E4B;
 Wed, 13 Mar 2024 04:41:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 15/23] qapi/schema: add _check_complete flag
Date: Wed, 13 Mar 2024 00:41:19 -0400
Message-ID: <20240313044127.49089-16-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
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

Instead of using the None value for the members field, use a dedicated
flag to detect recursive misconfigurations.

This is intended to assist with subsequent patches that seek to remove
the "None" value from the members field (which can never hold that value
after the final call to check()) in order to simplify the static typing
of that field; avoiding the need of assertions littered at many
callsites to eliminate the possibility of the None value.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d514b3c28f6..50ebc4f12de 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -450,12 +450,13 @@ def __init__(self, name, info, doc, ifcond, features,
         self.local_members = local_members
         self.variants = variants
         self.members = None
+        self._check_complete = False
 
     def check(self, schema):
         # This calls another type T's .check() exactly when the C
         # struct emitted by gen_object() contains that T's C struct
         # (pointers don't count).
-        if self.members is not None:
+        if self._check_complete:
             # A previous .check() completed: nothing to do
             return
         if self._checked:
@@ -464,7 +465,7 @@ def check(self, schema):
                                "object %s contains itself" % self.name)
 
         super().check(schema)
-        assert self._checked and self.members is None
+        assert self._checked and not self._check_complete
 
         seen = OrderedDict()
         if self._base_name:
@@ -487,7 +488,8 @@ def check(self, schema):
             self.variants.check(schema, seen)
             self.variants.check_clash(self.info, seen)
 
-        self.members = members  # mark completed
+        self.members = members
+        self._check_complete = True  # mark completed
 
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors
-- 
2.44.0


