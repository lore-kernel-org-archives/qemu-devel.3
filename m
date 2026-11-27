Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78858606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Se0hsF9S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWrE9-0005YA-R5; Fri, 27 Nov 2026 03:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWrE8-0005XC-M5
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWrE6-0004Tp-55
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795767758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJm9V54BijzQkxuxWquReWmmnBcBh3pyYWXIcWRwj1Y=;
 b=Se0hsF9SyZWXnt5QI/jMXdql46RN5EpjTRsEQDjfnbXGCj6GM9eTWfaNIM5vufn/+r/fo9
 JPrPjr4bDc5YYpBahbYGPEO1JaV2G+AgJWDvw6NhtWwCdq8FjieH9kqoajtDs7lgdCTiZr
 Ve2Gsq6k37GGXnY7jdPSSK7JnUyQZJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-ZBZPkPDRPC-SMSgXHNx0tQ-1; Fri,
 27 Nov 2026 08:22:32 +0000
X-MC-Unique: ZBZPkPDRPC-SMSgXHNx0tQ-1
X-Mimecast-MFC-AGG-ID: ZBZPkPDRPC-SMSgXHNx0tQ_1795767751
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1B3B1955F10; Fri, 27 Nov 2026 08:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 566A21956049; Fri, 27 Nov 2026 08:22:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B14FF21E6883; Fri, 27 Nov 2026 09:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 4/4] qom: Really add 'confidential-guest-reset' feature
Date: Fri, 27 Nov 2026 09:22:28 +0100
Message-ID: <20261127082228.3907768-5-armbru@redhat.com>
In-Reply-To: <20261127082228.3907768-1-armbru@redhat.com>
References: <20261127082228.3907768-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit a9b328611143 added feature 'confidential-guest-reset' to
SevCommonProperties and to TdxGuestProperties.  The commit message
states the intent as "control plane should be able to detect if the
hypervisor supports x86 confidential guest resets."

Management applications ("control plane") would check whether the
relevant argument type of QMP command object-add has the feature.  The
relevant types are SevGuestProperties, SevSnpGuestProperties, and
TdxGuestProperties.

Only TdxGuestProperties has the feature.  The other two have base type
SevCommonProperties, but a type only inherits its base's members, and
not its features or conditions.

Fix by moving the feature from SevCommonProperties to
SevGuestProperties and SevSnpGuestProperties.

Fixes: a9b328611143 ("qom: add 'confidential-guest-reset' property for x86 confidential vms")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261124154310.2569390-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
---
 qapi/qom.json | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 32a59269361..b8237a94be0 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1004,11 +1004,6 @@
 #     only supported on SEV-ES and SEV-SNP guests
 #     (default: false) (since 11.1)
 #
-# Features:
-#
-# @confidential-guest-reset: If present, the hypervisor supports
-#     confidential guest resets (since 11.0).
-#
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
@@ -1016,8 +1011,7 @@
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
             '*kernel-hashes': 'bool',
-            '*debug-swap': 'bool' },
-  'features': ['confidential-guest-reset']}
+            '*debug-swap': 'bool' } }
 
 ##
 # @SevGuestProperties:
@@ -1042,6 +1036,11 @@
 #    that require it.  If set to 'off', QEMU will require
 #    KVM_SEV_INIT2 unconditionally.  (default: off) (since 9.1)
 #
+# Features:
+#
+# @confidential-guest-reset: If present, the hypervisor supports
+#     confidential guest resets (since 11.0).
+#
 # Since: 2.12
 ##
 { 'struct': 'SevGuestProperties',
@@ -1050,7 +1049,8 @@
             '*session-file': 'str',
             '*policy': 'uint32',
             '*handle': 'uint32',
-            '*legacy-vm-type': 'OnOffAuto' } }
+            '*legacy-vm-type': 'OnOffAuto' },
+  'features': [ 'confidential-guest-reset' ] }
 
 ##
 # @SevSnpGuestProperties:
@@ -1101,6 +1101,11 @@
 # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
 #     is enabled (default: zero) (since 11.1)
 #
+# Features:
+#
+# @confidential-guest-reset: If present, the hypervisor supports
+#     confidential guest resets (since 11.0).
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1114,7 +1119,8 @@
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
             '*secure-tsc': 'bool',
-            '*tsc-frequency': 'uint32' } }
+            '*tsc-frequency': 'uint32' },
+  'features': [ 'confidential-guest-reset' ] }
 
 ##
 # @TdxGuestProperties:
-- 
2.55.0


