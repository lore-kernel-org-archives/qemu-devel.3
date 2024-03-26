Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82313CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KU-0004iU-7m; Tue, 26 Mar 2024 03:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KT-0004hl-61
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KR-0005O5-H6
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usHxnroC+/V02zcv1/xzx3HUcrcsHK3aUDTuWOsh/I0=;
 b=Ea+RzCLYGugAjCQf+HvEPTaUSzSGIQBnudbePZZEnddZqtYELy1cmVWv+Pb48hrq3aMo9v
 1H+SoOWzIOTl1G3c8AmTH9BF6fH/zMecTa5T81lAtV/41BpzoWVqzMfUjxV6hF/3i3Bd4c
 W4ysEi/VA7bIpqoojJHS8sgkJV9ao0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-s4yAdzf5P9yr4dTe_zSL0Q-1; Tue, 26 Mar 2024 03:34:36 -0400
X-MC-Unique: s4yAdzf5P9yr4dTe_zSL0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 127A2101A552;
 Tue, 26 Mar 2024 07:34:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3D832166B31;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD7AD21E5D39; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 19/20] qapi/block-core: improve Qcow2OverlapCheckFlags
 documentation
Date: Tue, 26 Mar 2024 08:34:19 +0100
Message-ID: <20240326073420.738016-20-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Most of fields have no description at all. Let's fix that. Still, no
reason to place here more detailed descriptions of what these
structures are, as we have public Qcow2 format specification.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20240325120054.2693236-1-vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
[Capitalize "QEMU", update qapi/pragma.json]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 25 +++++++++++++++++++++----
 qapi/pragma.json     |  1 -
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7d3fe59f6c..746d1694c2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3403,14 +3403,31 @@
 # @Qcow2OverlapCheckFlags:
 #
 # Structure of flags for each metadata structure.  Setting a field to
-# 'true' makes qemu guard that structure against unintended
-# overwriting.  The default value is chosen according to the template
-# given.
+# 'true' makes QEMU guard that Qcow2 format structure against
+# unintended overwriting.  See Qcow2 format specification for detailed
+# information on these structures.  The default value is chosen
+# according to the template given.
 #
 # @template: Specifies a template mode which can be adjusted using the
 #     other flags, defaults to 'cached'
 #
-# @bitmap-directory: since 3.0
+# @main-header: Qcow2 format header
+#
+# @active-l1: Qcow2 active L1 table
+#
+# @active-l2: Qcow2 active L2 table
+#
+# @refcount-table: Qcow2 refcount table
+#
+# @refcount-block: Qcow2 refcount blocks
+#
+# @snapshot-table: Qcow2 snapshot table
+#
+# @inactive-l1: Qcow2 inactive L1 tables
+#
+# @inactive-l2: Qcow2 inactive L2 tables
+#
+# @bitmap-directory: Qcow2 bitmap directory (since 3.0)
 #
 # Since: 2.9
 ##
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 99e4052ab3..9e28de1721 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -72,7 +72,6 @@
         'QCryptoAkCipherKeyType',
         'QCryptodevBackendServiceType',
         'QKeyCode',
-        'Qcow2OverlapCheckFlags',
         'RbdAuthMode',
         'RbdImageEncryptionFormat',
         'String',
-- 
2.44.0


