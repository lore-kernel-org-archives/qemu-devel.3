Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7CEC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 20:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQB9n-0002ps-KC; Fri, 13 Jun 2025 16:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB9d-0002Xh-6m
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQB9b-00059z-28
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749847054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jV6EUK4v9Hk11soohLDRLz51g+O+LaAM1YpqCl5GT6g=;
 b=QEJD6/aVaPQ1MClDwnO9UYxBxbIKsFdBGZ49ucQysStMa8s9uAmxFdTBbaurJUR3fKDDBh
 xYciRC9hXzXiva8FCb1tVPtbQ+klmcc6lnHumd1yBibjzR1DqY6w3wAy3fvyPZIL+zGqB1
 6XMEDTQmgayYc1UplGEtMKXqb7qf6+s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-vlh9DKKGMCycFe6l001-HA-1; Fri,
 13 Jun 2025 16:37:31 -0400
X-MC-Unique: vlh9DKKGMCycFe6l001-HA-1
X-Mimecast-MFC-AGG-ID: vlh9DKKGMCycFe6l001-HA_1749847049
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 567DF1808993; Fri, 13 Jun 2025 20:37:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.203])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA3E430044CC; Fri, 13 Jun 2025 20:37:22 +0000 (UTC)
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
Subject: [PATCH 08/18] qapi: add cross-references to migration.json
Date: Fri, 13 Jun 2025 16:36:10 -0400
Message-ID: <20250613203620.1283814-9-jsnow@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qapi/migration.json | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d7c5047462e..fec6479a23e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -193,14 +193,14 @@
 #
 # Information about current migration process.
 #
-# @status: @MigrationStatus describing the current migration status.
+# @status: `MigrationStatus` describing the current migration status.
 #     If this field is not returned, no migration process has been
 #     initiated
 #
-# @ram: @MigrationStats containing detailed migration status, only
+# @ram: `MigrationStats` containing detailed migration status, only
 #     returned if status is 'active' or 'completed'(since 1.2)
 #
-# @xbzrle-cache: @XBZRLECacheStats containing detailed XBZRLE
+# @xbzrle-cache: `XBZRLECacheStats` containing detailed XBZRLE
 #     migration statistics, only returned if XBZRLE feature is on and
 #     status is 'active' or 'completed' (since 1.2)
 #
@@ -239,7 +239,7 @@
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
-# @vfio: @VfioStats containing detailed VFIO devices migration
+# @vfio: `VfioStats` containing detailed VFIO devices migration
 #     statistics, only returned if VFIO device is present, migration
 #     is supported by all VFIO devices and status is 'active' or
 #     'completed' (since 5.2)
@@ -250,7 +250,7 @@
 #
 # @dirty-limit-throttle-time-per-round: Maximum throttle time (in
 #     microseconds) of virtual CPUs each dirty ring full round, which
-#     shows how MigrationCapability dirty-limit affects the guest
+#     shows how `MigrationCapability` dirty-limit affects the guest
 #     during live migration.  (Since 8.1)
 #
 # @dirty-limit-ring-full-time: Estimated average dirty ring full time
@@ -587,7 +587,7 @@
 #
 # @normal: the original form of migration.  (since 8.2)
 #
-# @cpr-reboot: The migrate command stops the VM and saves state to the
+# @cpr-reboot: The `migrate` command stops the VM and saves state to the
 #     URI.  After quitting QEMU, the user resumes by running QEMU
 #     -incoming.
 #
@@ -635,7 +635,7 @@
 #
 #     New QEMU reads the CPR channel before opening a monitor, hence
 #     the CPR channel cannot be specified in the list of channels for
-#     a migrate-incoming command.  It may only be specified on the
+#     a `migrate-incoming` command.  It may only be specified on the
 #     command line.
 #
 #     The main channel address cannot be a file type, and for an
@@ -646,10 +646,10 @@
 #     memory-backend-epc is not supported.  The VM must be started
 #     with the '-machine aux-ram-share=on' option.
 #
-#     When using -incoming defer, you must issue the migrate command
+#     When using -incoming defer, you must issue the `migrate` command
 #     to old QEMU before issuing any monitor commands to new QEMU.
 #     However, new QEMU does not open and read the migration stream
-#     until you issue the migrate incoming command.
+#     until you issue the `migrate` incoming command.
 #
 #     (since 10.0)
 ##
@@ -871,11 +871,11 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
-# @mode: Migration mode.  See description in @MigMode.  Default is
+# @mode: Migration mode.  See description in `MigMode`.  Default is
 #     'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'multifd'.
+#     See description in `ZeroPageDetection`.  Default is 'multifd'.
 #     (since 9.0)
 #
 # @direct-io: Open migration files with O_DIRECT when possible.  This
@@ -1052,11 +1052,11 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
-# @mode: Migration mode.  See description in @MigMode.  Default is
+# @mode: Migration mode.  See description in `MigMode`.  Default is
 #     'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'multifd'.
+#     See description in `ZeroPageDetection`.  Default is 'multifd'.
 #     (since 9.0)
 #
 # @direct-io: Open migration files with O_DIRECT when possible.  This
@@ -1068,8 +1068,8 @@
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
-# TODO: either fuse back into MigrationParameters, or make
-#     MigrationParameters members mandatory
+# TODO: either fuse back into `MigrationParameters`, or make
+#     `MigrationParameters` members mandatory
 #
 # Since: 2.4
 ##
@@ -1262,11 +1262,11 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
-# @mode: Migration mode.  See description in @MigMode.  Default is
+# @mode: Migration mode.  See description in `MigMode`.  Default is
 #     'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'multifd'.
+#     See description in `ZeroPageDetection`.  Default is 'multifd'.
 #     (since 9.0)
 #
 # @direct-io: Open migration files with O_DIRECT when possible.  This
@@ -1356,7 +1356,7 @@
 #
 # Emitted when a migration event happens
 #
-# @status: @MigrationStatus describing the current migration status.
+# @status: `MigrationStatus` describing the current migration status.
 #
 # Since: 2.4
 #
@@ -1477,8 +1477,8 @@
 # The reason for a COLO exit.
 #
 # @none: failover has never happened.  This state does not occur in
-#     the COLO_EXIT event, and is only visible in the result of
-#     query-colo-status.
+#     the `COLO_EXIT` event, and is only visible in the result of
+#     `query-colo-status`.
 #
 # @request: COLO exit is due to an external request.
 #
@@ -1733,8 +1733,8 @@
 #     list connected to a destination interface endpoint.
 #
 # @exit-on-error: Exit on incoming migration failure.  Default true.
-#     When set to false, the failure triggers a MIGRATION event, and
-#     error details could be retrieved with query-migrate.
+#     When set to false, the failure triggers a :qapi:event:`MIGRATION`
+#     event, and error details could be retrieved with `query-migrate`.
 #     (since 9.1)
 #
 # Since: 2.3
@@ -1746,7 +1746,7 @@
 #        already exposed above libvirt.
 #
 #     2. QEMU must be started with -incoming defer to allow
-#        migrate-incoming to be used.
+#        `migrate-incoming` to be used.
 #
 #     3. The uri format is the same as for -incoming
 #
@@ -1799,7 +1799,7 @@
 # devices of the VM are not saved by this command.
 #
 # @filename: the file to save the state of the devices to as binary
-#     data.  See xen-save-devices-state.txt for a description of the
+#     data.  See `xen-save-devices-state`.txt for a description of the
 #     binary format.
 #
 # @live: Optional argument to ask QEMU to treat this command as part
@@ -1840,7 +1840,7 @@
 # devices of the VM are not loaded by this command.
 #
 # @filename: the file to load the state of the devices from as binary
-#     data.  See xen-save-devices-state.txt for a description of the
+#     data.  See `xen-save-devices-state`.txt for a description of the
 #     binary format.
 #
 # Since: 2.7
@@ -2049,7 +2049,7 @@
 # @DirtyRateMeasureMode:
 #
 # Method used to measure dirty page rate.  Differences between
-# available methods are explained in @calc-dirty-rate.
+# available methods are explained in `calc-dirty-rate`.
 #
 # @page-sampling: use page sampling
 #
@@ -2117,7 +2117,7 @@
 # @calc-dirty-rate:
 #
 # Start measuring dirty page rate of the VM.  Results can be retrieved
-# with @query-dirty-rate after measurements are completed.
+# with `query-dirty-rate` after measurements are completed.
 #
 # Dirty page rate is the number of pages changed in a given time
 # period expressed in MiB/s.  The following methods of calculation are
@@ -2190,7 +2190,7 @@
 ##
 # @query-dirty-rate:
 #
-# Query results of the most recent invocation of @calc-dirty-rate.
+# Query results of the most recent invocation of `calc-dirty-rate`.
 #
 # @calc-time-unit: time unit in which to report calculation time.
 #     By default it is reported in seconds.  (Since 8.2)
@@ -2240,7 +2240,7 @@
 #
 # Requires KVM with accelerator property "dirty-ring-size" set.  A
 # virtual CPU's dirty page rate is a measure of its memory load.  To
-# observe dirty page rates, use @calc-dirty-rate.
+# observe dirty page rates, use `calc-dirty-rate`.
 #
 # @cpu-index: index of a virtual CPU, default is all.
 #
@@ -2265,7 +2265,7 @@
 # Cancel the upper limit of dirty page rate for virtual CPUs.
 #
 # Cancel the dirty page limit for the vCPU which has been set with
-# set-vcpu-dirty-limit command.  Note that this command requires
+# `set-vcpu-dirty-limit` command.  Note that this command requires
 # support from dirty ring, same as the "set-vcpu-dirty-limit".
 #
 # @cpu-index: index of a virtual CPU, default is all.
@@ -2423,7 +2423,7 @@
 # time it takes to load the snapshot.
 #
 # It is strongly recommended that @devices contain all writable block
-# device nodes that can have changed since the original @snapshot-save
+# device nodes that can have changed since the original `snapshot-save`
 # command execution.
 #
 # .. qmp-example::
-- 
2.48.1


