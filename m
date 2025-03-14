Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1337C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20M-0006KS-1F; Fri, 14 Mar 2025 06:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20E-0006Ip-Se
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00023B-ML
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMhx6loXPBAjuIXAlLsHOTwdp7+0R4NgyYOtMoaW8X0=;
 b=Rr2AcfnptxhEdZp48VNPQOK5b/urYpTK8Vmsps5oFYErUh2d2HgGubaXgj/HvNljg939l9
 XuGlVvvBYACM6Jgkl9C/a5i4oWZS/xbpI34o5NZWlGt16wwJNiOIPTRu2qvWKxuH+l7LBB
 SdVPHb9jXxl265V2o6kAvBr7liuDZa4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-9AGI9JAvMsGXl2srunHEQA-1; Fri,
 14 Mar 2025 06:10:49 -0400
X-MC-Unique: 9AGI9JAvMsGXl2srunHEQA-1
X-Mimecast-MFC-AGG-ID: 9AGI9JAvMsGXl2srunHEQA_1741947049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E21881800258
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88CCF1828AA4
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E652121E64F2; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 12/12] docs: enable transmogrifier for QSD and QGA
Date: Fri, 14 Mar 2025 11:10:38 +0100
Message-ID: <20250314101038.2408751-13-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

This also creates the `qapi-qsd-index` and `qapi-qga-index` QMP indices.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-12-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/conf.py                                 | 2 ++
 docs/interop/qemu-ga-ref.rst                 | 2 ++
 docs/interop/qemu-storage-daemon-qmp-ref.rst | 2 ++
 qga/qapi-schema.json                         | 3 +++
 storage-daemon/qapi/qapi-schema.json         | 8 ++++++++
 5 files changed, 17 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 9a86e84a80..7b5712e122 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -164,7 +164,9 @@
 # Due to a limitation in Sphinx, we need to know which indices to
 # generate in advance. Adding a namespace here allows that generation.
 qapi_namespaces = {
+    "QGA",
     "QMP",
+    "QSD",
 }
 
 # -- Options for HTML output ----------------------------------------------
diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
index 032d492455..19b5c7a549 100644
--- a/docs/interop/qemu-ga-ref.rst
+++ b/docs/interop/qemu-ga-ref.rst
@@ -5,3 +5,5 @@ QEMU Guest Agent Protocol Reference
    :depth: 3
 
 .. qapi-doc:: qga/qapi-schema.json
+   :transmogrify:
+   :namespace: QGA
diff --git a/docs/interop/qemu-storage-daemon-qmp-ref.rst b/docs/interop/qemu-storage-daemon-qmp-ref.rst
index 9fed68152f..d0228d63b8 100644
--- a/docs/interop/qemu-storage-daemon-qmp-ref.rst
+++ b/docs/interop/qemu-storage-daemon-qmp-ref.rst
@@ -5,3 +5,5 @@ QEMU Storage Daemon QMP Reference Manual
    :depth: 3
 
 .. qapi-doc:: storage-daemon/qapi/qapi-schema.json
+   :transmogrify:
+   :namespace: QSD
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 995594aaf4..35ec0e7db3 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -3,6 +3,9 @@
 
 ##
 # = QEMU guest agent protocol commands and structs
+#
+# For a concise listing of all commands, events, and types in the QEMU
+# guest agent, please consult the `qapi-qga-index`.
 ##
 
 { 'pragma': { 'doc-required': true } }
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index f10c949490..2a562ee32e 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -13,6 +13,14 @@
 # the array type in the main schema, even if it is unused outside of the
 # storage daemon.
 
+##
+# = QEMU storage daemon protocol commands and structs
+#
+# For a concise listing of all commands, events, and types in the QEMU
+# storage daemon, please consult the `qapi-qsd-index`.
+##
+
+
 { 'include': '../../qapi/pragma.json' }
 
 # Documentation generated with qapi-gen.py is in source order, with
-- 
2.48.1


