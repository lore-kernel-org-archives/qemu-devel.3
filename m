Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8399CC36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVZH-0004Xc-BJ; Tue, 17 Sep 2024 06:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZ8-00044G-AA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZ6-0007LE-Q4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvVrh6vqILKkbVGpDKaYq80XG1PO1QYdQIXKP3XRj2Y=;
 b=TPMTiCiR6tEYt7JWKKrQbzVQ7Hp7VSUjXqqtZsEwEaIlK1C8rHK7JaIZTjuRakZd8e+KFt
 5cGtDV3mxoZ8aQAlsdNiKjEedXRArI7OQKhKomM7ELciLlJsJ4el0nzjQ51tKr8nQxD6SP
 5w8wkQKYtCJ+/oz52w83aOtUCtD0Cog=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-1uBcJolTNMOzqnuJGc3luQ-1; Tue,
 17 Sep 2024 06:36:08 -0400
X-MC-Unique: 1uBcJolTNMOzqnuJGc3luQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A61431956069; Tue, 17 Sep 2024 10:36:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ED971955DC7; Tue, 17 Sep 2024 10:36:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/17] tests/unit: replace assert(0) with g_assert_not_reached()
Date: Tue, 17 Sep 2024 12:35:32 +0200
Message-ID: <20240917103540.149144-10-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240912073921.453203-14-pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-xs-node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
index ac94e7ed6c..2f447a73fb 100644
--- a/tests/unit/test-xs-node.c
+++ b/tests/unit/test-xs-node.c
@@ -212,7 +212,7 @@ static void compare_tx(gpointer key, gpointer val, gpointer opaque)
         printf("Comparison failure in TX %u after serdes:\n", tx_id);
         dump_ref("Original", t1->root, 0);
         dump_ref("Deserialised", t2->root, 0);
-        g_assert(0);
+        g_assert_not_reached();
     }
     g_assert(t1->nr_nodes == t2->nr_nodes);
 }
@@ -257,7 +257,7 @@ static void check_serdes(XenstoreImplState *s)
         printf("Comparison failure in main tree after serdes:\n");
         dump_ref("Original", s->root, 0);
         dump_ref("Deserialised", s2->root, 0);
-        g_assert(0);
+        g_assert_not_reached();
     }
 
     nr_transactions1 = g_hash_table_size(s->transactions);
-- 
2.46.0


