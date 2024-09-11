Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8764EE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLTz-0005fR-45; Wed, 11 Sep 2024 07:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTv-0005aD-V5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTu-00012I-EG
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726053953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPap5rPhgh2dW/X03TfOVy+09igrDU42hFAAY4BhjBo=;
 b=BJqRDs1n6jaeFZfYygHP4HQJwZnmYYrIQ9/zcUzOiaaEuct++c3ZSJFs++4SH+CRHHrKH2
 7pYU3Hr58W+9NX8heZ1vfNChaTt8eb9VHaoxz88driIDDAjZbZkrmxZE1H8UBkjGkEvMXF
 kC4tjLvYldPASTSb4U8meFOAiW3/z00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-L_UX2JqgOqSPwQTm-vaU2g-1; Wed,
 11 Sep 2024 07:25:50 -0400
X-MC-Unique: L_UX2JqgOqSPwQTm-vaU2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9193219560B1; Wed, 11 Sep 2024 11:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F63730001A1; Wed, 11 Sep 2024 11:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2183F21E6889; Wed, 11 Sep 2024 13:25:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, arei.gonglei@huawei.com, pizhenwei@bytedance.com,
 jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jiri@resnulli.us, jsnow@redhat.com
Subject: [PATCH v2 4/8] qapi/introspect: Supply missing member documentation
Date: Wed, 11 Sep 2024 13:25:41 +0200
Message-ID: <20240911112545.2248881-5-armbru@redhat.com>
In-Reply-To: <20240911112545.2248881-1-armbru@redhat.com>
References: <20240911112545.2248881-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since we neglect to document the members of JSONType, their
description in the QEMU QMP Reference manual is "Not documented".  Fix
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/introspect.json | 16 ++++++++++++++++
 qapi/pragma.json     |  1 -
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 14df049580..01bb242947 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -127,6 +127,22 @@
 # section 1, plus 'int' (split off 'number'), plus the obvious top
 # type 'value'.
 #
+# @string: JSON string
+#
+# @number: JSON number
+#
+# @int: JSON number that is an integer
+#
+# @boolean: literal ``false`` or ``true``
+#
+# @null: literal ``null``
+#
+# @object: JSON object
+#
+# @array: JSON array
+#
+# @value: any JSON value
+#
 # Since: 2.5
 ##
 { 'enum': 'JSONType',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 625eac99df..7b0e12f42b 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -58,7 +58,6 @@
         'InputButton',
         'IscsiHeaderDigest',
         'IscsiTransport',
-        'JSONType',
         'KeyValueKind',
         'MemoryDeviceInfoKind',
         'NetClientDriver',
-- 
2.46.0


