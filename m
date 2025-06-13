Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67862C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 20:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQBA0-0003YC-Sk; Fri, 13 Jun 2025 16:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB9x-0003O6-UP
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB9w-0005CD-Es
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749847075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/aRxH8LUCrVA1cEQ4UF8Q8BNDYrM4WQLyhEH2jtC9E=;
 b=N8gfX89fz1IH7jQp+niZsD00ZNqwnOJqdXJzXNDxZSTpPY4uBezmyTzqH9rynnePHsOuKY
 7TGPiasUjkCMJ/TQGOOOYwuI+1i6CV93yaJUE/4gTJchpUlofOm+bxryp0oupSINkyTam6
 jN085Oga2XG79LkHO9Z2qMae/BrDO0U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-O2737EkbMCKKMRwO3XnsMA-1; Fri,
 13 Jun 2025 16:37:53 -0400
X-MC-Unique: O2737EkbMCKKMRwO3XnsMA-1
X-Mimecast-MFC-AGG-ID: O2737EkbMCKKMRwO3XnsMA_1749847072
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F23EC1956088; Fri, 13 Jun 2025 20:37:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.203])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7727E30044CC; Fri, 13 Jun 2025 20:37:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 11/18] qapi: add cross-references to QOM
Date: Fri, 13 Jun 2025 16:36:13 -0400
Message-ID: <20250613203620.1283814-12-jsnow@redhat.com>
In-Reply-To: <20250613203620.1283814-1-jsnow@redhat.com>
References: <20250613203620.1283814-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/qdev.json | 4 ++--
 qapi/qom.json  | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 5d18fb8e0e0..ff3f06a36d6 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -95,10 +95,10 @@
 #    from the guest.  Hot removal is an operation that requires guest
 #    cooperation.  This command merely requests that the guest begin
 #    the hot removal process.  Completion of the device removal
-#    process is signaled with a DEVICE_DELETED event.  Guest reset
+#    process is signaled with a `DEVICE_DELETED` event.  Guest reset
 #    will automatically complete removal for all devices.  If a
 #    guest-side error in the hot removal process is detected, the
-#    device will not be removed and a DEVICE_UNPLUG_GUEST_ERROR event
+#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR` event
 #    is sent.  Some errors cannot be detected.
 #
 # Since: 0.14
diff --git a/qapi/qom.json b/qapi/qom.json
index e5fb42f692a..a03299fc93e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -51,7 +51,7 @@
 # This command will list any properties of a object given a path in
 # the object model.
 #
-# @path: the path within the object model.  See @qom-get for a
+# @path: the path within the object model.  See `qom-get` for a
 #     description of this parameter.
 #
 # Returns: a list that describe the properties of the object.
@@ -129,12 +129,12 @@
 #
 # This command will set a property from a object model path.
 #
-# @path: see @qom-get for a description of this parameter
+# @path: see `qom-get` for a description of this parameter
 #
 # @property: the property name to set
 #
 # @value: a value who's type is appropriate for the property type.
-#     See @qom-get for a description of type mapping.
+#     See `qom-get` for a description of type mapping.
 #
 # Since: 1.2
 #
@@ -153,7 +153,7 @@
 ##
 # @ObjectTypeInfo:
 #
-# This structure describes a search result from @qom-list-types
+# This structure describes a search result from `qom-list-types`
 #
 # @name: the type name found in the search
 #
@@ -193,6 +193,7 @@
 #
 # @typename: the type name of an object
 #
+#
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
-- 
2.48.1


