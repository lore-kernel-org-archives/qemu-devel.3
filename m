Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCF7C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 18:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7qi-0007JU-FF; Thu, 08 Aug 2024 14:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc7qe-00075E-Te
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc7qa-00010P-TN
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723141607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCyr7FYSBNpBY8JP2h8Gp4KgWb+w+sLKTsRT6zhiF2k=;
 b=Dz3HwwQkpNMg5Qw6+ya6boMINanot+sJp8ssMpeJBiU9r25q+cBg/WdFmI1yy1Ck5EVxhQ
 x7YCYBNMRlEVbVxvNi2IvI3iBPZYzKHpaMAUxQigUJDEQOEvhlULunargXs5LDNEpJ6ZuW
 dNxAzp1iccM094UGHXeXX4f8otTtnYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-ft6mSj8SOzKUYa7gp0tHrQ-1; Thu,
 08 Aug 2024 14:26:42 -0400
X-MC-Unique: ft6mSj8SOzKUYa7gp0tHrQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B501944B2F; Thu,  8 Aug 2024 18:26:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B58E1955E99; Thu,  8 Aug 2024 18:26:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29B4621E5A5F; Thu,  8 Aug 2024 20:26:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
Subject: [PATCH 2/6] qapi/common: Supply missing member documentation
Date: Thu,  8 Aug 2024 20:26:32 +0200
Message-ID: <20240808182636.3657537-3-armbru@redhat.com>
In-Reply-To: <20240808182636.3657537-1-armbru@redhat.com>
References: <20240808182636.3657537-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Since we neglect to document the members of GrabToggleKeys, their
description in the QEMU QMP Reference manual is "Not documented".  Fix
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json | 14 +++++++++++++-
 qapi/pragma.json |  1 -
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 7558ce5430..6ffc7a3789 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -183,7 +183,19 @@
 ##
 # @GrabToggleKeys:
 #
-# Keys to toggle input-linux between host and guest.
+# Key combinations to toggle input-linux between host and guest.
+#
+# @ctrl-ctrl: left and right control key
+#
+# @alt-alt: left and right alt key
+#
+# @shift-shift: left and right shift key
+#
+# @meta-meta: left and right meta key
+#
+# @scrolllock: scroll lock key
+#
+# @ctrl-scrolllock: either control key and scroll lock key
 #
 # Since: 4.0
 ##
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 39a424303b..6ff135d8d2 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -55,7 +55,6 @@
         'DummyBlockCoreForceArrays',
         'DummyForceArrays',
         'DummyVirtioForceArrays',
-        'GrabToggleKeys',
         'HotKeyMod',
         'ImageInfoSpecificKind',
         'InputAxis',
-- 
2.45.0


