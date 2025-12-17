Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D5D64095
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 08:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVnB4-000797-CD; Wed, 17 Dec 2025 03:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVnB1-00078H-Ge
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVnAy-0008US-7l
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765961186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+55x9UGTwF8GPPxsKo7Rmks8k9cEpmITHLQMA0Ppypo=;
 b=cnEm9KmmTlLOgTp6XIY2nYrrlR9ycP0b7n0G2ZxH+d7nIrwmeBJTZ9Xd2qTA7S8IxfrdGs
 eM5Q+V+hO23lkCAs0+9lKKFTEjVZPKVqtkqGMi6Iuygu1LwGdfl0+QoKJ70bknCQgQE84f
 a4Q8Ftpxgkuh9/93Quwyeq2G7rIl6PI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-TgsMSje-NPCNQcfJ2DVBgA-1; Wed,
 17 Dec 2025 03:46:25 -0500
X-MC-Unique: TgsMSje-NPCNQcfJ2DVBgA-1
X-Mimecast-MFC-AGG-ID: TgsMSje-NPCNQcfJ2DVBgA_1765961183
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75F041955D8E; Wed, 17 Dec 2025 08:46:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11AEB180044F; Wed, 17 Dec 2025 08:46:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2AA321E6935; Wed, 17 Dec 2025 09:46:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Zesen Liu <ftyghome@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL 1/1] qdev: fix error handling in set_uint64_checkmask
Date: Wed, 17 Dec 2025 09:46:20 +0100
Message-ID: <20251217084620.3319239-2-armbru@redhat.com>
In-Reply-To: <20251217084620.3319239-1-armbru@redhat.com>
References: <20251217084620.3319239-1-armbru@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zesen Liu <ftyghome@gmail.com>

When specifying lbr_fmt=VALUE in cpu options with an invalid VALUE, error_setg() gets triggered twice, causing an assertion failure in error_setv() which requires *errp to be NULL, preventing meaningful error messages from being displayed.

Fix this by checking visit_type_uint64()'s return value and returning early on failure, consistent with other property setters like set_string().

Fixes: 18c22d7112a7 (qdev-properties: Add a new macro with bitmask check for uint64_t property)
Cc: qemu-stable@nongnu.org
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
Message-ID: <20251217-qdev-fix-v1-1-bd33ea463220@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Add Fixes: and Cc:]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969..0930d64252 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -494,7 +494,9 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_uint64(v, name, ptr, errp);
+    if (!visit_type_uint64(v, name, ptr, errp)) {
+        return;
+    }
     if (*ptr & ~prop->bitmask) {
         error_setg(errp, "Property value for '%s' has bits outside mask '0x%" PRIx64 "'",
                    name, prop->bitmask);
-- 
2.49.0


