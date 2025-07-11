Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27D7C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6XP-0000wH-MO; Fri, 11 Jul 2025 01:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6X1-0000CK-28
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Wy-0000kn-O6
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb4z32+fkSN8gqr9HC7lLlmjSCH+yUlNbnAVkeRCy1M=;
 b=MHEA7du1/dCUxe/yfXJl8yQ6yqUo+noy+GK0S8ysLY/gOJObX4nYvFtkrHTO84p6+aBOBu
 CFmXDcfdlCNSe5KowFELvR1iwrkjg+r5q4iaP/M+MZyHR5HzEO95nFezppuiWMx3PuTTdV
 YjFWBdax4e/ssCYHPVhTCkKX1hDWaTc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-ktpsdOytMASj0Cx-vqSrwA-1; Fri,
 11 Jul 2025 01:42:34 -0400
X-MC-Unique: ktpsdOytMASj0Cx-vqSrwA-1
X-Mimecast-MFC-AGG-ID: ktpsdOytMASj0Cx-vqSrwA_1752212553
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06BFF180028D; Fri, 11 Jul 2025 05:42:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1A841800285; Fri, 11 Jul 2025 05:42:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 18/18] qapi: add cross-references to misc modules
Date: Fri, 11 Jul 2025 01:40:05 -0400
Message-ID: <20250711054005.60969-19-jsnow@redhat.com>
In-Reply-To: <20250711054005.60969-1-jsnow@redhat.com>
References: <20250711054005.60969-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

These modules don't have specific maintainers, so they're lumped in
together here as miscellaneous.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/control.json    |  2 +-
 qapi/ebpf.json       |  2 +-
 qapi/introspect.json | 24 ++++++++++++------------
 qapi/misc-arm.json   |  4 ++--
 qapi/misc-i386.json  |  2 +-
 qapi/misc.json       | 12 ++++++------
 qapi/stats.json      |  8 ++++----
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 3aeb8f4f6fb..91de9fcd3b6 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -11,7 +11,7 @@
 #
 # Enable QMP capabilities.
 #
-# @enable: An optional list of QMPCapability values to enable.  The
+# @enable: An optional list of `QMPCapability` values to enable.  The
 #     client must not enable any capability that is not mentioned in
 #     the QMP greeting message.  If the field is not provided, it
 #     means no QMP capabilities will be enabled.  (since 2.12)
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index db19ae850fc..834e28d1aba 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -32,7 +32,7 @@
 ##
 # @EbpfProgramID:
 #
-# The eBPF programs that can be gotten with request-ebpf.
+# The eBPF programs that can be gotten with `request-ebpf`.
 #
 # @rss: Receive side scaling, technology that allows steering traffic
 #     between queues by calculation hash.  Users may set up
diff --git a/qapi/introspect.json b/qapi/introspect.json
index a5340268d13..4ccce77483e 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -16,11 +16,11 @@
 ##
 # @query-qmp-schema:
 #
-# Command query-qmp-schema exposes the QMP wire ABI as an array of
-# SchemaInfo.  This lets QMP clients figure out what commands and
+# Command `query-qmp-schema` exposes the QMP wire ABI as an array of
+# `SchemaInfo`.  This lets QMP clients figure out what commands and
 # events are available in this QEMU, and their parameters and results.
 #
-# However, the SchemaInfo can't reflect all the rules and restrictions
+# However, the `SchemaInfo` can't reflect all the rules and restrictions
 # that apply to QMP.  It's interface introspection (figuring out
 # what's there), not interface specification.  The specification is in
 # the QAPI schema.
@@ -54,7 +54,7 @@
 ##
 # @SchemaMetaType:
 #
-# This is a @SchemaInfo's meta type, i.e. the kind of entity it
+# This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
 # describes.
 #
 # @builtin: a predefined type such as 'int' or 'bool'.
@@ -80,7 +80,7 @@
 ##
 # @SchemaInfo:
 #
-# @name: the entity's name, inherited from @base.  The SchemaInfo is
+# @name: the entity's name, inherited from @base.  The `SchemaInfo` is
 #     always referenced by this name.  Commands and events have the
 #     name defined in the QAPI schema.  Unlike command and event
 #     names, type names are not part of the wire ABI.  Consequently,
@@ -111,7 +111,7 @@
 ##
 # @SchemaInfoBuiltin:
 #
-# Additional SchemaInfo members for meta-type 'builtin'.
+# Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -152,7 +152,7 @@
 ##
 # @SchemaInfoEnum:
 #
-# Additional SchemaInfo members for meta-type 'enum'.
+# Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -192,7 +192,7 @@
 ##
 # @SchemaInfoArray:
 #
-# Additional SchemaInfo members for meta-type 'array'.
+# Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -206,7 +206,7 @@
 ##
 # @SchemaInfoObject:
 #
-# Additional SchemaInfo members for meta-type 'object'.
+# Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -271,7 +271,7 @@
 ##
 # @SchemaInfoAlternate:
 #
-# Additional SchemaInfo members for meta-type 'alternate'.
+# Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -299,7 +299,7 @@
 ##
 # @SchemaInfoCommand:
 #
-# Additional SchemaInfo members for meta-type 'command'.
+# Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -321,7 +321,7 @@
 ##
 # @SchemaInfoEvent:
 #
-# Additional SchemaInfo members for meta-type 'event'.
+# Additional `SchemaInfo` members for meta-type 'event'.
 #
 # @arg-type: the name of the object type that provides the event's
 #     parameters.
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f5341372f5a..7f16ecf5390 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -30,13 +30,13 @@
 ##
 # @query-gic-capabilities:
 #
-# It will return a list of GICCapability objects that describe its
+# It will return a list of `GICCapability` objects that describe its
 # capability bits.
 #
 # On non-ARM targets this command will report an error as the GIC
 # technology is not applicable.
 #
-# Returns: a list of GICCapability objects.
+# Returns: a list of `GICCapability` objects.
 #
 # Since: 2.6
 #
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index c0c57f9ab25..24ba3bc8690 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -26,7 +26,7 @@
 ##
 # @SevState:
 #
-# An enumeration of SEV state information used during @query-sev.
+# An enumeration of SEV state information used during `query-sev`.
 #
 # @uninit: The guest is uninitialized.
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 70dbcb0aecf..5ac41dc55f2 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -21,7 +21,7 @@
 #     "@dbus-display" or the name of a character device (e.g. from
 #     -chardev id=XXXX)
 #
-# @fdname: file descriptor name previously passed via 'getfd' command
+# @fdname: file descriptor name previously passed via `getfd` command
 #
 # @skipauth: whether to skip authentication.  Only applies to "vnc"
 #     and "spice" protocols
@@ -226,7 +226,7 @@
 #    Known limitations:
 #
 #    * This command is stateless, this means that commands that depend
-#      on state information (such as getfd) might not work.
+#      on state information (such as `getfd`) might not work.
 #
 #    * Commands that prompt the user for data don't currently work.
 #
@@ -253,7 +253,7 @@
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
-#    The 'closefd' command can be used to explicitly close the file
+#    The `closefd` command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
 # .. qmp-example::
@@ -280,7 +280,7 @@
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
-#    The 'closefd' command can be used to explicitly close the file
+#    The `closefd` command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
 # .. qmp-example::
@@ -473,7 +473,7 @@
 #
 # @name: parameter name
 #
-# @type: parameter @CommandLineParameterType
+# @type: parameter `CommandLineParameterType`
 #
 # @help: human readable text string, not suitable for parsing.
 #
@@ -495,7 +495,7 @@
 #
 # @option: option name
 #
-# @parameters: an array of @CommandLineParameterInfo
+# @parameters: an array of `CommandLineParameterInfo`
 #
 # Since: 1.5
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index 7e7f1dabbc3..f00785879d6 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -87,7 +87,7 @@
 # @StatsRequest:
 #
 # Indicates a set of statistics that should be returned by
-# query-stats.
+# `query-stats`.
 #
 # @provider: provider for which to return statistics.
 #
@@ -112,7 +112,7 @@
 ##
 # @StatsFilter:
 #
-# The arguments to the query-stats command; specifies a target for
+# The arguments to the `query-stats` command; specifies a target for
 # which to request statistics and optionally the required subset of
 # information for that target.
 #
@@ -183,7 +183,7 @@
 # Return runtime-collected statistics for objects such as the VM or
 # its vCPUs.
 #
-# The arguments are a StatsFilter and specify the provider and objects
+# The arguments are a `StatsFilter` and specify the provider and objects
 # to return statistics about.
 #
 # Returns: a list of statistics, one for each provider and object
@@ -203,7 +203,7 @@
 #
 # @name: name of the statistic; each element of the schema is uniquely
 #     identified by a target, a provider (both available in
-#     @StatsSchema) and the name.
+#     `StatsSchema`) and the name.
 #
 # @type: kind of statistic.
 #
-- 
2.50.0


