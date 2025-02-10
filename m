Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D98C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thVHw-0005fM-Vj; Mon, 10 Feb 2025 10:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thVHi-0005Yw-DP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thVHg-0004qd-HP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739199675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oo7e/z5yYvjKLNMxKI9ikNx7KlprmXFpAylKDOmriJM=;
 b=BKh2lERl5+Hvzl35QR5U8fKBqT+6XlzEXnb4Hzow4yeKrFbTNvYCdy+Hy7Nux6HW0FyAgZ
 YNZjM3MJsztI8e72OQDvYh6HxD/FUZYj5Nd1FbgB47pOq4sAhfAC5gt2dfyK3Nw7QbxYpX
 WcZLLnqPTb+9pcsUC48rrbQcSHY+OaE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-rxjoS1PUMRG1JJP96aPauA-1; Mon,
 10 Feb 2025 10:01:13 -0500
X-MC-Unique: rxjoS1PUMRG1JJP96aPauA-1
X-Mimecast-MFC-AGG-ID: rxjoS1PUMRG1JJP96aPauA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD2951800877
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 15:01:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6726F1800352
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 15:01:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B5B2E21E6939; Mon, 10 Feb 2025 16:01:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 5/8] qapi: cope with feature names containing a '-'
Date: Mon, 10 Feb 2025 16:01:03 +0100
Message-ID: <20250210150106.3924507-6-armbru@redhat.com>
In-Reply-To: <20250210150106.3924507-1-armbru@redhat.com>
References: <20250210150106.3924507-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When we shortly expose all feature names to code, it will be valid to
include a '-', which must be translated to a '_' for the enum constants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250205123550.2754387-2-berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/gen.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 6a8abe0041..c53ca72950 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -24,6 +24,7 @@
 )
 
 from .common import (
+    c_enum_const,
     c_fname,
     c_name,
     guardend,
@@ -41,7 +42,7 @@
 
 
 def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
-    special_features = [f"1u << QAPI_{feat.name.upper()}"
+    special_features = [f"1u << {c_enum_const('qapi', feat.name)}"
                         for feat in features if feat.is_special()]
     return ' | '.join(special_features) or '0'
 
-- 
2.48.1


