Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04969C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7o-00032N-9J; Mon, 06 May 2024 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7a-0002lM-TI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003ek-3n
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0bAfLx0fSN9+pKtZd6qempTW+VtaN8OzkHnNuAO3EY=;
 b=F6hOfpSODIoshj02oXdrpGkM6wo5lvyO9zPuL25kM6fkkxQR6QUXdZuf3j8zqomfWaS/mY
 NiQb3bT9e2RgCyzCr/FmhQkCgXXc1LAv2KFx/HUxmhoiDNV3K0/EXkFsb4HTyFCdUDMhbN
 sbai6hU0zequY8qgBiP0/uaUVV3mZKA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-YlVr0dCRNsiZ9_hajyr2WA-1; Mon,
 06 May 2024 07:02:57 -0400
X-MC-Unique: YlVr0dCRNsiZ9_hajyr2WA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9767E38000AF;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D53D200B2C4;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B32921D49C4; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 7/7] find untagged sections WIP
Date: Mon,  6 May 2024 13:02:53 +0200
Message-ID: <20240506110254.3965097-14-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

---
 qapi/block-core.json           | 1 +
 qapi/introspect.json           | 4 ++++
 qapi/machine-target.json       | 2 ++
 qapi/migration.json            | 3 +++
 qapi/net.json                  | 2 ++
 qapi/qom.json                  | 1 +
 qapi/ui.json                   | 1 +
 qga/qapi-schema.json           | 2 ++
 scripts/qapi/parser.py         | 1 +
 tests/qapi-schema/doc-good.out | 1 +
 10 files changed, 18 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index fab1a45365..1c43d3d2bb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3289,6 +3289,7 @@
 #
 # @namespace: namespace number of the device, starting from 1.
 #
+# @@@ untagged
 # Note that the PCI @device must have been unbound from any host
 # kernel driver before instructing QEMU to add the blockdev.
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index b041b02ba8..1747562a41 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -149,6 +149,7 @@
 #
 # @deprecated: Member @values is deprecated.  Use @members instead.
 #
+# @@@ untagged
 # Values of this type are JSON string on the wire.
 #
 # Since: 2.5
@@ -180,6 +181,7 @@
 #
 # @element-type: the array type's element type.
 #
+# @@@ untagged
 # Values of this type are JSON array on the wire.
 #
 # Since: 2.5
@@ -203,6 +205,7 @@
 #     The variants are in no particular order, and may even differ
 #     from the order of the values of the enum type of the @tag.
 #
+# @@@ untagged
 # Values of this type are JSON object on the wire.
 #
 # Since: 2.5
@@ -261,6 +264,7 @@
 #     members' wire encoding is distinct, see
 #     :doc:`/devel/qapi-code-gen` section Alternate types.
 #
+# @@@ untagged
 # On the wire, this can be any of the members.
 #
 # Since: 2.5
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 4ef7ef7b43..37ffd6409b 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -107,6 +107,7 @@
 # @responsible-properties: List of properties that led to the
 #     comparison result not being identical.
 #
+# @@@ untagged
 # @responsible-properties is a list of QOM property names that led to
 # both CPUs not being detected as identical.  For identical models,
 # this list is empty.  If a QOM property is read-only, that means
@@ -342,6 +343,7 @@
 #     removed in in some future version of QEMU according to the QEMU
 #     deprecation policy.  (since 5.2)
 #
+# @@@ untagged
 # @unavailable-features is a list of QOM property names that represent
 # CPU model attributes that prevent the CPU from running.  If the QOM
 # property is read-only, that means there's no known way to make the
diff --git a/qapi/migration.json b/qapi/migration.json
index e22645253c..97a727c41a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2427,6 +2427,7 @@
 #
 # @devices: list of block device node names to save a snapshot to
 #
+# @@@ untagged
 # Applications should not assume that the snapshot save is complete
 # when this command returns.  The job commands / events must be used
 # to determine completion and to fetch details of any errors that
@@ -2499,6 +2500,7 @@
 #
 # @devices: list of block device node names to load a snapshot from
 #
+# @@@ untagged
 # Applications should not assume that the snapshot load is complete
 # when this command returns.  The job commands / events must be used
 # to determine completion and to fetch details of any errors that
@@ -2567,6 +2569,7 @@
 #
 # @devices: list of block device node names to delete a snapshot from
 #
+# @@@ untagged
 # Applications should not assume that the snapshot delete is complete
 # when this command returns.  The job commands / events must be used
 # to determine completion and to fetch details of any errors that
diff --git a/qapi/net.json b/qapi/net.json
index 0f5a259475..da21c02fa2 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -650,6 +650,7 @@
 #     attempt a reconnect after the given number of seconds.  Setting
 #     this to zero disables this function.  (default: 0) (since 8.0)
 #
+# @@@ untagged
 # Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
 #
 # Since: 7.2
@@ -669,6 +670,7 @@
 #
 # @local: local address
 #
+# @@@ untagged
 # Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
 #
 # If remote address is present and it's a multicast address, local
diff --git a/qapi/qom.json b/qapi/qom.json
index d1dc216474..237711cd59 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -547,6 +547,7 @@
 #     algorithm detects it is spending too long polling without
 #     encountering events.  0 selects a default behaviour (default: 0)
 #
+# @@@ untagged
 # The @aio-max-batch option is available since 6.1.
 #
 # Since: 2.0
diff --git a/qapi/ui.json b/qapi/ui.json
index 2b7f0b8401..b2c3f143dc 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -934,6 +934,7 @@
 #
 # @f24: since 8.0
 #
+# @@@ untagged
 # 'sysrq' was mistakenly added to hack around the fact that the ps2
 # driver was not generating correct scancodes sequences when
 # 'alt+print' was pressed.  This flaw is now fixed and the 'sysrq' key
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index fe41670ed2..17cdb52f83 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -207,6 +207,7 @@
 #
 # @mode: "halt", "powerdown" (default), or "reboot"
 #
+# @@@ untagged
 # This command does NOT return a response on success.  Success
 # condition is indicated by the VM exiting with a zero exit status or,
 # when running with --no-shutdown, by issuing the query-status QMP
@@ -1050,6 +1051,7 @@
 #
 # @crypted: true if password is already crypt()d, false if raw
 #
+# @@@ untagged
 # If the @crypted flag is true, it is the caller's responsibility to
 # ensure the correct crypt() encryption scheme is used.  This command
 # does not attempt to interpret or report on the encryption scheme.
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index e8a482c37d..126acab38d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -665,6 +665,7 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
         section = self.Section(info)
         self.sections.append(section)
         self.all_sections.append(section)
+        section.append_line(f'### untagged {info.loc()}')
 
     def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
         section = self.Section(info, tag)
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index f2be711a2c..067e3d1135 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -112,6 +112,7 @@ Also _one_ {and only}
     feature=enum-member-feat
 a member feature
     section=None
+### untagged /work/armbru/qemu/bld/../tests/qapi-schema/doc-good.json:67
 @two is undocumented
 doc symbol=Base
     body=
-- 
2.44.0


