Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657F5C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpI-0001Vc-10; Wed, 24 Apr 2024 04:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXof-0000O7-1f
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXob-0006Mf-9K
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDW0Xz9TlyAbEVZVLeFRsDcKqdQmawhWBp1iG9NppSk=;
 b=diFSu/Xdl6zAmvj0CLOxkRhDOZFQ7K9N/rws39wUyyjBKfbfzDx0Nlc+4/kwb95Dpry0DC
 Zt1+II8RKDKk7CRgso5zoWuOt9rkc0xUty8ZAIb+rrw4jki57CQLkKu7ygM+kI7/GP2UTG
 NE0EPFQn35yd5DKYEHAjEQoF3EDhc84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ljW-VVLsMQGvToo9B0fL4g-1; Wed, 24 Apr 2024 04:17:14 -0400
X-MC-Unique: ljW-VVLsMQGvToo9B0fL4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DE6F830E85;
 Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D02740C5C2;
 Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 14F9721E6811; Wed, 24 Apr 2024 10:17:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 24/25] qapi: Tighten check whether implicit object type already
 exists
Date: Wed, 24 Apr 2024 10:17:09 +0200
Message-ID: <20240424081710.2907748-25-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

Entities with names starting with q_obj_ are implicit object types.
Therefore, QAPISchema._make_implicit_object_type()'s .lookup_entity()
can only return a QAPISchemaObjectType.  Assert that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-25-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e52930a48a..a6180f93c6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1297,8 +1297,9 @@ def _make_implicit_object_type(
             return None
         # See also QAPISchemaObjectTypeMember.describe()
         name = 'q_obj_%s-%s' % (name, role)
-        typ = self.lookup_entity(name, QAPISchemaObjectType)
+        typ = self.lookup_entity(name)
         if typ:
+            assert(isinstance(typ, QAPISchemaObjectType))
             # The implicit object type has multiple users.  This can
             # only be a duplicate definition, which will be flagged
             # later.
-- 
2.44.0


