Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FBFCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkg-00071H-G1; Wed, 30 Sep 2026 06:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001ct-BM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qj-RG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwDYr8EvPbRreMzX4dU/m85TiptGx0ITs9H3DvmNsBo=;
 b=IJkwaTyVgKNMaZcSIwYd7JMEZu9z7nSWgsj70/YrC0I4O0O8HeHzMowyKeiFNONMxzNT1A
 R/6lXvkoTMalBwGYsgf+nvS+acbqBecOgt6LINbX35w6NGbEOddpyBK8lLhjL4Fv4R+p6o
 OywLWCgarvyEonwmYyVFoju+W9Ehtng=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-3PIPTiWvPuqTWm3oU6OCAA-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: 3PIPTiWvPuqTWm3oU6OCAA-1
X-Mimecast-MFC-AGG-ID: 3PIPTiWvPuqTWm3oU6OCAA_1790764770
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7AB195419E; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07C8F76D; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3EB6121E60EA; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 101/105] qapi: convert/split intros for commands
Date: Wed, 30 Sep 2026 12:39:06 +0200
Message-ID: <20260930103910.3934848-102-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Convert or split apart the existing intro for any remaining commands
in the QAPI schema into introduction and details sections. The
introduction is indented, remaining plaintext/details paragraphs
are not.

For commands that have automatically generated documentation inserted
at parse time, these new split points serve as the new insertion
point. This affects the rendered documentation for `netdev_add`,
`query-stats`, and `query-gic-capabilities` in particular, whose
arguments descriptions / "Returns:" documentation are pushed upwards.

Minor rephrasings are applied for `query-qmp-schema` to help
the split flow better in rendered documentation.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260928192557.509157-7-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message corrected]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/control.json     |  3 +--
 qapi/introspect.json  | 16 ++++++++--------
 qapi/machine.json     | 31 +++++++++++++++----------------
 qapi/migration.json   | 12 +++++-------
 qapi/misc-arm.json    |  5 ++---
 qapi/misc.json        |  8 +++-----
 qapi/net.json         |  3 +--
 qapi/qdev.json        |  9 ++++-----
 qapi/stats.json       |  5 ++---
 qapi/transaction.json |  7 +++----
 qapi/ui.json          |  3 +--
 11 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 2788ce32e2..ef63a8a261 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -152,8 +152,7 @@
 
 ##
 # @quit:
-#
-# Request graceful QEMU process termination.
+#     Request graceful QEMU process termination.
 #
 # While every attempt is made to send the QMP response before
 # terminating, this is not guaranteed.  When using this interface, a
diff --git a/qapi/introspect.json b/qapi/introspect.json
index bd42aac335..d579e5c855 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -17,15 +17,15 @@
 
 ##
 # @query-qmp-schema:
+#     Command `query-qmp-schema` exposes the QMP wire ABI as an array
+#     of `SchemaInfo`.  This lets QMP clients figure out what commands
+#     and events are available in this QEMU, and their parameters and
+#     results.
 #
-# Command `query-qmp-schema` exposes the QMP wire ABI as an array of
-# `SchemaInfo`.  This lets QMP clients figure out what commands and
-# events are available in this QEMU, and their parameters and results.
-#
-# However, the `SchemaInfo` can't reflect all the rules and
-# restrictions that apply to QMP.  It's interface introspection
-# (figuring out what's there), not interface specification.  The
-# specification is in the QAPI schema.
+# The `SchemaInfo` can't reflect all the rules and restrictions that
+# apply to QMP.  It's interface introspection (figuring out what's
+# there), not interface specification.  The specification is in the
+# QAPI schema.
 #
 # Furthermore, while we strive to keep the QMP wire format
 # backwards-compatible across QEMU versions, the introspection output
diff --git a/qapi/machine.json b/qapi/machine.json
index b5d4eb8db9..e9584f9166 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -2007,13 +2007,13 @@
 
 ##
 # @query-cpu-model-comparison:
+#     Compares two CPU models, @modela and @modelb, returning how they
+#     compare in a specific configuration.
 #
-# Compares two CPU models, @modela and @modelb, returning how they
-# compare in a specific configuration.  The results indicates how both
-# models compare regarding runnability.  This result can be used by
-# tooling to make decisions if a certain CPU model will run in a
-# certain configuration or if a compatible CPU model has to be created
-# by baselining.
+# The results indicates how both models compare regarding runnability.
+# This result can be used by tooling to make decisions if a certain
+# CPU model will run in a certain configuration or if a compatible CPU
+# model has to be created by baselining.
 #
 # Usually, a CPU model is compared against the maximum possible CPU
 # model of a certain configuration (e.g. the "host" model for KVM).
@@ -2063,11 +2063,10 @@
 
 ##
 # @query-cpu-model-baseline:
-#
-# Baseline two CPU models, @modela and @modelb, creating a compatible
-# third model.  The created model will always be a static,
-# migration-safe CPU model (see "static" CPU model expansion for
-# details).
+#     Baseline two CPU models, @modela and @modelb, creating a
+#     compatible third model.  The created model will always be a
+#     static, migration-safe CPU model (see "static" CPU model
+#     expansion for details).
 #
 # This interface can be used by tooling to create a compatible CPU
 # model out two CPU models.  The created CPU model will be identical
@@ -2135,11 +2134,11 @@
 
 ##
 # @query-cpu-model-expansion:
-#
-# Expands a given CPU model, @model, (or a combination of CPU model +
-# additional options) to different granularities, specified by @type,
-# allowing tooling to get an understanding what a specific CPU model
-# looks like in QEMU under a certain configuration.
+#     Expands a given CPU model, @model, (or a combination of CPU
+#     model + additional options) to different granularities,
+#     specified by @type, allowing tooling to get an understanding
+#     what a specific CPU model looks like in QEMU under a certain
+#     configuration.
 #
 # This interface can be used to query the "host" CPU model.
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index f7f223f9ab..889a9b89c2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1826,9 +1826,9 @@
 
 ##
 # @calc-dirty-rate:
-#
-# Start measuring dirty page rate of the VM.  Results can be retrieved
-# with `query-dirty-rate` after measurements are completed.
+#     Start measuring dirty page rate of the VM.  Results can be
+#     retrieved with `query-dirty-rate` after measurements are
+#     completed.
 #
 # Dirty page rate is the number of pages changed in a given time
 # period expressed in MiB/s.  The following methods of calculation are
@@ -1945,8 +1945,7 @@
 
 ##
 # @set-vcpu-dirty-limit:
-#
-# Set the upper limit of dirty page rate for virtual CPUs.
+#     Set the upper limit of dirty page rate for virtual CPUs.
 #
 # Requires KVM with accelerator property "dirty-ring-size" set.  A
 # virtual CPU's dirty page rate is a measure of its memory load.  To
@@ -1971,8 +1970,7 @@
 
 ##
 # @cancel-vcpu-dirty-limit:
-#
-# Cancel the upper limit of dirty page rate for virtual CPUs.
+#     Cancel the upper limit of dirty page rate for virtual CPUs.
 #
 # Cancel the dirty page limit for the vCPU which has been set with
 # `set-vcpu-dirty-limit` command.  Note that this command requires
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index 8cb2ea7795..70859b2c37 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -28,9 +28,8 @@
 
 ##
 # @query-gic-capabilities:
-#
-# It will return a list of `GICCapability` objects that describe its
-# capability bits.
+#     It will return a list of `GICCapability` objects that describe
+#     its capability bits.
 #
 # On non-ARM targets this command will report an error as the GIC
 # technology is not applicable.
diff --git a/qapi/misc.json b/qapi/misc.json
index b62cabc2b7..4469e44d05 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -12,9 +12,8 @@
 
 ##
 # @add_client:
-#
-# Allow client connections for VNC, Spice and socket based character
-# devices to be passed in to QEMU via SCM_RIGHTS.
+#     Allow client connections for VNC, Spice and socket based
+#     character devices to be passed in to QEMU via SCM_RIGHTS.
 #
 # If the FD associated with @fdname is not a socket, the command will
 # fail and the FD will be closed.
@@ -185,8 +184,7 @@
 
 ##
 # @x-exit-preconfig:
-#
-# Exit from "preconfig" state
+#     Exit from "preconfig" state
 #
 # This command makes QEMU exit the preconfig state and proceed with VM
 # initialization using configuration data provided on the command line
diff --git a/qapi/net.json b/qapi/net.json
index 81d1ab1c2f..3541dd7cad 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -37,8 +37,7 @@
 
 ##
 # @netdev_add:
-#
-# Add a network backend.
+#     Add a network backend.
 #
 # Additional arguments depend on the type.
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index a35321d2fd..f390354d68 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -162,11 +162,10 @@
 
 ##
 # @device-sync-config:
-#
-# Synchronize device configuration from host to guest part.  First,
-# copy the configuration from the host part (backend) to the guest
-# part (frontend).  Then notify guest software that device
-# configuration changed.
+#     Synchronize device configuration from host to guest part.
+#     First, copy the configuration from the host part (backend) to
+#     the guest part (frontend).  Then notify guest software that
+#     device configuration changed.
 #
 # The command may be used to notify the guest about block device
 # capacity change.  Currently only vhost-user-blk device supports
diff --git a/qapi/stats.json b/qapi/stats.json
index af57ec0854..e9d05390c3 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -175,9 +175,8 @@
 
 ##
 # @query-stats:
-#
-# Return runtime-collected statistics for objects such as the VM or
-# its vCPUs.
+#     Return runtime-collected statistics for objects such as the VM
+#     or its vCPUs.
 #
 # The arguments are a `StatsFilter` and specify the provider and
 # objects to return statistics about.
diff --git a/qapi/transaction.json b/qapi/transaction.json
index c0dc811ba6..daecf843c9 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -197,10 +197,9 @@
 
 ##
 # @transaction:
-#
-# Executes a number of transactionable QMP commands atomically.  If
-# any operation fails, then the entire set of actions will be
-# abandoned and the appropriate error returned.
+#     Executes a number of transactionable QMP commands atomically.
+#     If any operation fails, then the entire set of actions will be
+#     abandoned and the appropriate error returned.
 #
 # For external snapshots, the dictionary contains the device, the file
 # to use for the new snapshot, and the format.  The default format, if
diff --git a/qapi/ui.json b/qapi/ui.json
index a59cd63577..73ee2cb205 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1198,8 +1198,7 @@
 
 ##
 # @input-send-event:
-#
-# Send input event(s) to guest.
+#     Send input event(s) to guest.
 #
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
-- 
2.55.0


