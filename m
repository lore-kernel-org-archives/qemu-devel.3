Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D9C48BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg8-0005z2-En; Fri, 16 Feb 2024 09:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razg3-0005vb-E3
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfx-00082v-Kv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzN3BlToBLhT4d7GMH0J6jOe6oYyWunDynPXmBmSZRc=;
 b=fbfSbjmI7kRf10O2lejgGboIMBVHJ7sahVJMqRzc/pSRhHagxKx3nYKTGv70fWQ2jobG7Q
 GFZNAqs1jeCXRmjBV8EIShGLXA5TDkpjinuqz2sAamagN6gwnqZu0C+QmA+YzZsfdid8pP
 t/SNJh1ykS5vR6bCKvuF5shak7lzeks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-8V-amyN2OImHJVSATdiKSg-1; Fri,
 16 Feb 2024 09:58:49 -0500
X-MC-Unique: 8V-amyN2OImHJVSATdiKSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D2583813F2E;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FABE111F9;
 Fri, 16 Feb 2024 14:58:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C8B621E5A40; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 10/16] qapi: Require descriptions and tagged sections to be
 indented
Date: Fri, 16 Feb 2024 15:58:34 +0100
Message-ID: <20240216145841.2099240-11-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

By convention, we indent the second and subsequent lines of
descriptions and tagged sections, except for examples.

Turn this into a hard rule, and apply it to examples, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst    |  15 +-
 qapi/acpi.json                  |  20 +-
 qapi/block-core.json            | 868 ++++++++++++++++----------------
 qapi/block.json                 | 274 +++++-----
 qapi/char.json                  | 172 +++----
 qapi/control.json               |  54 +-
 qapi/dump.json                  |  26 +-
 qapi/machine-target.json        |   6 +-
 qapi/machine.json               | 302 +++++------
 qapi/migration.json             | 690 ++++++++++++-------------
 qapi/misc-target.json           | 110 ++--
 qapi/misc.json                  | 172 +++----
 qapi/net.json                   | 118 ++---
 qapi/pci.json                   | 252 +++++-----
 qapi/qdev.json                  |  38 +-
 qapi/qom.json                   |  54 +-
 qapi/rdma.json                  |  14 +-
 qapi/replay.json                |  16 +-
 qapi/rocker.json                |  66 +--
 qapi/run-state.json             |  84 ++--
 qapi/tpm.json                   |  36 +-
 qapi/trace.json                 |  12 +-
 qapi/transaction.json           |  36 +-
 qapi/ui.json                    | 324 ++++++------
 qapi/virtio.json                | 778 ++++++++++++++--------------
 qapi/yank.json                  |  24 +-
 scripts/qapi/parser.py          |   3 +
 tests/qapi-schema/doc-good.json |  12 +-
 28 files changed, 2289 insertions(+), 2287 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 756adc187e..77a40f3bdc 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -973,7 +973,7 @@ commands and events), member (for structs and unions), branch (for
 alternates), or value (for enums), a description of each feature (if
 any), and finally optional tagged sections.
 
-Descriptions start with '\@name:'.  The description text should be
+Descriptions start with '\@name:'.  The description text must be
 indented like this::
 
  # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
@@ -997,8 +997,8 @@ A tagged section starts with one of the following words:
 "Note:"/"Notes:", "Since:", "Example:"/"Examples:", "Returns:",
 "TODO:".  The section ends with the start of a new section.
 
-The second and subsequent lines of sections other than
-"Example"/"Examples" should be indented like this::
+The second and subsequent lines of tagged sections must be indented
+like this::
 
  # Note: Ut enim ad minim veniam, quis nostrud exercitation ullamco
  #     laboris nisi ut aliquip ex ea commodo consequat.
@@ -1049,11 +1049,10 @@ For example::
  #
  # Example:
  #
- # -> { "execute": "query-blockstats" }
- # <- {
- #      ... lots of output ...
- #    }
- #
+ #     -> { "execute": "query-blockstats" }
+ #     <- {
+ #          ... lots of output ...
+ #        }
  ##
  { 'command': 'query-blockstats',
    'data': { '*query-nodes': 'bool' },
diff --git a/qapi/acpi.json b/qapi/acpi.json
index e0739bd6ae..aa4dbe5794 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -113,12 +113,12 @@
 #
 # Example:
 #
-# -> { "execute": "query-acpi-ospm-status" }
-# <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
-#                  { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
-#                  { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
-#                  { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
-#    ]}
+#     -> { "execute": "query-acpi-ospm-status" }
+#     <- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
+#                      { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
+#                      { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
+#                      { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
+#        ]}
 ##
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
@@ -133,10 +133,10 @@
 #
 # Example:
 #
-# <- { "event": "ACPI_DEVICE_OST",
-#      "data": { "info": { "device": "d1", "slot": "0",
-#                          "slot-type": "DIMM", "source": 1, "status": 0 } },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "ACPI_DEVICE_OST",
+#          "data": { "info": { "device": "d1", "slot": "0",
+#                              "slot-type": "DIMM", "source": 1, "status": 0 } },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab5a93a966..22b8634422 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -766,87 +766,87 @@
 #
 # Example:
 #
-# -> { "execute": "query-block" }
-# <- {
-#       "return":[
-#          {
-#             "io-status": "ok",
-#             "device":"ide0-hd0",
-#             "locked":false,
-#             "removable":false,
-#             "inserted":{
-#                "ro":false,
-#                "drv":"qcow2",
-#                "encrypted":false,
-#                "file":"disks/test.qcow2",
-#                "backing_file_depth":1,
-#                "bps":1000000,
-#                "bps_rd":0,
-#                "bps_wr":0,
-#                "iops":1000000,
-#                "iops_rd":0,
-#                "iops_wr":0,
-#                "bps_max": 8000000,
-#                "bps_rd_max": 0,
-#                "bps_wr_max": 0,
-#                "iops_max": 0,
-#                "iops_rd_max": 0,
-#                "iops_wr_max": 0,
-#                "iops_size": 0,
-#                "detect_zeroes": "on",
-#                "write_threshold": 0,
-#                "image":{
-#                   "filename":"disks/test.qcow2",
-#                   "format":"qcow2",
-#                   "virtual-size":2048000,
-#                   "backing_file":"base.qcow2",
-#                   "full-backing-filename":"disks/base.qcow2",
-#                   "backing-filename-format":"qcow2",
-#                   "snapshots":[
-#                      {
-#                         "id": "1",
-#                         "name": "snapshot1",
-#                         "vm-state-size": 0,
-#                         "date-sec": 10000200,
-#                         "date-nsec": 12,
-#                         "vm-clock-sec": 206,
-#                         "vm-clock-nsec": 30
-#                      }
-#                   ],
-#                   "backing-image":{
-#                       "filename":"disks/base.qcow2",
+#     -> { "execute": "query-block" }
+#     <- {
+#           "return":[
+#              {
+#                 "io-status": "ok",
+#                 "device":"ide0-hd0",
+#                 "locked":false,
+#                 "removable":false,
+#                 "inserted":{
+#                    "ro":false,
+#                    "drv":"qcow2",
+#                    "encrypted":false,
+#                    "file":"disks/test.qcow2",
+#                    "backing_file_depth":1,
+#                    "bps":1000000,
+#                    "bps_rd":0,
+#                    "bps_wr":0,
+#                    "iops":1000000,
+#                    "iops_rd":0,
+#                    "iops_wr":0,
+#                    "bps_max": 8000000,
+#                    "bps_rd_max": 0,
+#                    "bps_wr_max": 0,
+#                    "iops_max": 0,
+#                    "iops_rd_max": 0,
+#                    "iops_wr_max": 0,
+#                    "iops_size": 0,
+#                    "detect_zeroes": "on",
+#                    "write_threshold": 0,
+#                    "image":{
+#                       "filename":"disks/test.qcow2",
 #                       "format":"qcow2",
-#                       "virtual-size":2048000
-#                   }
-#                }
-#             },
-#             "qdev": "ide_disk",
-#             "type":"unknown"
-#          },
-#          {
-#             "io-status": "ok",
-#             "device":"ide1-cd0",
-#             "locked":false,
-#             "removable":true,
-#             "qdev": "/machine/unattached/device[23]",
-#             "tray_open": false,
-#             "type":"unknown"
-#          },
-#          {
-#             "device":"floppy0",
-#             "locked":false,
-#             "removable":true,
-#             "qdev": "/machine/unattached/device[20]",
-#             "type":"unknown"
-#          },
-#          {
-#             "device":"sd0",
-#             "locked":false,
-#             "removable":true,
-#             "type":"unknown"
-#          }
-#       ]
-#    }
+#                       "virtual-size":2048000,
+#                       "backing_file":"base.qcow2",
+#                       "full-backing-filename":"disks/base.qcow2",
+#                       "backing-filename-format":"qcow2",
+#                       "snapshots":[
+#                          {
+#                             "id": "1",
+#                             "name": "snapshot1",
+#                             "vm-state-size": 0,
+#                             "date-sec": 10000200,
+#                             "date-nsec": 12,
+#                             "vm-clock-sec": 206,
+#                             "vm-clock-nsec": 30
+#                          }
+#                       ],
+#                       "backing-image":{
+#                           "filename":"disks/base.qcow2",
+#                           "format":"qcow2",
+#                           "virtual-size":2048000
+#                       }
+#                    }
+#                 },
+#                 "qdev": "ide_disk",
+#                 "type":"unknown"
+#              },
+#              {
+#                 "io-status": "ok",
+#                 "device":"ide1-cd0",
+#                 "locked":false,
+#                 "removable":true,
+#                 "qdev": "/machine/unattached/device[23]",
+#                 "tray_open": false,
+#                 "type":"unknown"
+#              },
+#              {
+#                 "device":"floppy0",
+#                 "locked":false,
+#                 "removable":true,
+#                 "qdev": "/machine/unattached/device[20]",
+#                 "type":"unknown"
+#              },
+#              {
+#                 "device":"sd0",
+#                 "locked":false,
+#                 "removable":true,
+#                 "type":"unknown"
+#              }
+#           ]
+#        }
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
   'allow-preconfig': true }
@@ -1170,105 +1170,105 @@
 #
 # Example:
 #
-# -> { "execute": "query-blockstats" }
-# <- {
-#       "return":[
-#          {
-#             "device":"ide0-hd0",
-#             "parent":{
-#                "stats":{
-#                   "wr_highest_offset":3686448128,
-#                   "wr_bytes":9786368,
-#                   "wr_operations":751,
-#                   "rd_bytes":122567168,
-#                   "rd_operations":36772
-#                   "wr_total_times_ns":313253456
-#                   "rd_total_times_ns":3465673657
-#                   "flush_total_times_ns":49653
-#                   "flush_operations":61,
-#                   "rd_merged":0,
-#                   "wr_merged":0,
-#                   "idle_time_ns":2953431879,
-#                   "account_invalid":true,
-#                   "account_failed":false
-#                }
-#             },
-#             "stats":{
-#                "wr_highest_offset":2821110784,
-#                "wr_bytes":9786368,
-#                "wr_operations":692,
-#                "rd_bytes":122739200,
-#                "rd_operations":36604
-#                "flush_operations":51,
-#                "wr_total_times_ns":313253456
-#                "rd_total_times_ns":3465673657
-#                "flush_total_times_ns":49653,
-#                "rd_merged":0,
-#                "wr_merged":0,
-#                "idle_time_ns":2953431879,
-#                "account_invalid":true,
-#                "account_failed":false
-#             },
-#             "qdev": "/machine/unattached/device[23]"
-#          },
-#          {
-#             "device":"ide1-cd0",
-#             "stats":{
-#                "wr_highest_offset":0,
-#                "wr_bytes":0,
-#                "wr_operations":0,
-#                "rd_bytes":0,
-#                "rd_operations":0
-#                "flush_operations":0,
-#                "wr_total_times_ns":0
-#                "rd_total_times_ns":0
-#                "flush_total_times_ns":0,
-#                "rd_merged":0,
-#                "wr_merged":0,
-#                "account_invalid":false,
-#                "account_failed":false
-#             },
-#             "qdev": "/machine/unattached/device[24]"
-#          },
-#          {
-#             "device":"floppy0",
-#             "stats":{
-#                "wr_highest_offset":0,
-#                "wr_bytes":0,
-#                "wr_operations":0,
-#                "rd_bytes":0,
-#                "rd_operations":0
-#                "flush_operations":0,
-#                "wr_total_times_ns":0
-#                "rd_total_times_ns":0
-#                "flush_total_times_ns":0,
-#                "rd_merged":0,
-#                "wr_merged":0,
-#                "account_invalid":false,
-#                "account_failed":false
-#             },
-#             "qdev": "/machine/unattached/device[16]"
-#          },
-#          {
-#             "device":"sd0",
-#             "stats":{
-#                "wr_highest_offset":0,
-#                "wr_bytes":0,
-#                "wr_operations":0,
-#                "rd_bytes":0,
-#                "rd_operations":0
-#                "flush_operations":0,
-#                "wr_total_times_ns":0
-#                "rd_total_times_ns":0
-#                "flush_total_times_ns":0,
-#                "rd_merged":0,
-#                "wr_merged":0,
-#                "account_invalid":false,
-#                "account_failed":false
-#             }
-#          }
-#       ]
-#    }
+#     -> { "execute": "query-blockstats" }
+#     <- {
+#           "return":[
+#              {
+#                 "device":"ide0-hd0",
+#                 "parent":{
+#                    "stats":{
+#                       "wr_highest_offset":3686448128,
+#                       "wr_bytes":9786368,
+#                       "wr_operations":751,
+#                       "rd_bytes":122567168,
+#                       "rd_operations":36772
+#                       "wr_total_times_ns":313253456
+#                       "rd_total_times_ns":3465673657
+#                       "flush_total_times_ns":49653
+#                       "flush_operations":61,
+#                       "rd_merged":0,
+#                       "wr_merged":0,
+#                       "idle_time_ns":2953431879,
+#                       "account_invalid":true,
+#                       "account_failed":false
+#                    }
+#                 },
+#                 "stats":{
+#                    "wr_highest_offset":2821110784,
+#                    "wr_bytes":9786368,
+#                    "wr_operations":692,
+#                    "rd_bytes":122739200,
+#                    "rd_operations":36604
+#                    "flush_operations":51,
+#                    "wr_total_times_ns":313253456
+#                    "rd_total_times_ns":3465673657
+#                    "flush_total_times_ns":49653,
+#                    "rd_merged":0,
+#                    "wr_merged":0,
+#                    "idle_time_ns":2953431879,
+#                    "account_invalid":true,
+#                    "account_failed":false
+#                 },
+#                 "qdev": "/machine/unattached/device[23]"
+#              },
+#              {
+#                 "device":"ide1-cd0",
+#                 "stats":{
+#                    "wr_highest_offset":0,
+#                    "wr_bytes":0,
+#                    "wr_operations":0,
+#                    "rd_bytes":0,
+#                    "rd_operations":0
+#                    "flush_operations":0,
+#                    "wr_total_times_ns":0
+#                    "rd_total_times_ns":0
+#                    "flush_total_times_ns":0,
+#                    "rd_merged":0,
+#                    "wr_merged":0,
+#                    "account_invalid":false,
+#                    "account_failed":false
+#                 },
+#                 "qdev": "/machine/unattached/device[24]"
+#              },
+#              {
+#                 "device":"floppy0",
+#                 "stats":{
+#                    "wr_highest_offset":0,
+#                    "wr_bytes":0,
+#                    "wr_operations":0,
+#                    "rd_bytes":0,
+#                    "rd_operations":0
+#                    "flush_operations":0,
+#                    "wr_total_times_ns":0
+#                    "rd_total_times_ns":0
+#                    "flush_total_times_ns":0,
+#                    "rd_merged":0,
+#                    "wr_merged":0,
+#                    "account_invalid":false,
+#                    "account_failed":false
+#                 },
+#                 "qdev": "/machine/unattached/device[16]"
+#              },
+#              {
+#                 "device":"sd0",
+#                 "stats":{
+#                    "wr_highest_offset":0,
+#                    "wr_bytes":0,
+#                    "wr_operations":0,
+#                    "rd_bytes":0,
+#                    "rd_operations":0
+#                    "flush_operations":0,
+#                    "wr_total_times_ns":0
+#                    "rd_total_times_ns":0
+#                    "flush_total_times_ns":0,
+#                    "rd_merged":0,
+#                    "wr_merged":0,
+#                    "account_invalid":false,
+#                    "account_failed":false
+#                 }
+#              }
+#           ]
+#        }
 ##
 { 'command': 'query-blockstats',
   'data': { '*query-nodes': 'bool' },
@@ -1464,9 +1464,9 @@
 #
 # Example:
 #
-# -> { "execute": "block_resize",
-#      "arguments": { "device": "scratch", "size": 1073741824 } }
-# <- { "return": {} }
+#     -> { "execute": "block_resize",
+#          "arguments": { "device": "scratch", "size": 1073741824 } }
+#     <- { "return": {} }
 ##
 { 'command': 'block_resize',
   'data': { '*device': 'str',
@@ -1682,12 +1682,12 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-snapshot-sync",
-#      "arguments": { "device": "ide-hd0",
-#                     "snapshot-file":
-#                     "/some/place/my-image",
-#                     "format": "qcow2" } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-snapshot-sync",
+#          "arguments": { "device": "ide-hd0",
+#                         "snapshot-file":
+#                         "/some/place/my-image",
+#                         "format": "qcow2" } }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-snapshot-sync',
   'data': 'BlockdevSnapshotSync',
@@ -1715,19 +1715,19 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-add",
-#      "arguments": { "driver": "qcow2",
-#                     "node-name": "node1534",
-#                     "file": { "driver": "file",
-#                               "filename": "hd1.qcow2" },
-#                     "backing": null } }
+#     -> { "execute": "blockdev-add",
+#          "arguments": { "driver": "qcow2",
+#                         "node-name": "node1534",
+#                         "file": { "driver": "file",
+#                                   "filename": "hd1.qcow2" },
+#                         "backing": null } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 #
-# -> { "execute": "blockdev-snapshot",
-#      "arguments": { "node": "ide-hd0",
-#                     "overlay": "node1534" } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-snapshot",
+#          "arguments": { "node": "ide-hd0",
+#                         "overlay": "node1534" } }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-snapshot',
   'data': 'BlockdevSnapshot',
@@ -1863,10 +1863,10 @@
 #
 # Example:
 #
-# -> { "execute": "block-commit",
-#      "arguments": { "device": "virtio0",
-#                     "top": "/tmp/snap1.qcow2" } }
-# <- { "return": {} }
+#     -> { "execute": "block-commit",
+#          "arguments": { "device": "virtio0",
+#                         "top": "/tmp/snap1.qcow2" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
@@ -1902,11 +1902,11 @@
 #
 # Example:
 #
-# -> { "execute": "drive-backup",
-#      "arguments": { "device": "drive0",
-#                     "sync": "full",
-#                     "target": "backup.img" } }
-# <- { "return": {} }
+#     -> { "execute": "drive-backup",
+#          "arguments": { "device": "drive0",
+#                         "sync": "full",
+#                         "target": "backup.img" } }
+#     <- { "return": {} }
 ##
 { 'command': 'drive-backup', 'boxed': true,
   'data': 'DriveBackup', 'features': ['deprecated'],
@@ -1929,11 +1929,11 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-backup",
-#      "arguments": { "device": "src-id",
-#                     "sync": "full",
-#                     "target": "tgt-id" } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-backup",
+#          "arguments": { "device": "src-id",
+#                         "sync": "full",
+#                         "target": "tgt-id" } }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-backup', 'boxed': true,
   'data': 'BlockdevBackup',
@@ -1953,52 +1953,52 @@
 #
 # Example:
 #
-# -> { "execute": "query-named-block-nodes" }
-# <- { "return": [ { "ro":false,
-#                    "drv":"qcow2",
-#                    "encrypted":false,
-#                    "file":"disks/test.qcow2",
-#                    "node-name": "my-node",
-#                    "backing_file_depth":1,
-#                    "detect_zeroes":"off",
-#                    "bps":1000000,
-#                    "bps_rd":0,
-#                    "bps_wr":0,
-#                    "iops":1000000,
-#                    "iops_rd":0,
-#                    "iops_wr":0,
-#                    "bps_max": 8000000,
-#                    "bps_rd_max": 0,
-#                    "bps_wr_max": 0,
-#                    "iops_max": 0,
-#                    "iops_rd_max": 0,
-#                    "iops_wr_max": 0,
-#                    "iops_size": 0,
-#                    "write_threshold": 0,
-#                    "image":{
-#                       "filename":"disks/test.qcow2",
-#                       "format":"qcow2",
-#                       "virtual-size":2048000,
-#                       "backing_file":"base.qcow2",
-#                       "full-backing-filename":"disks/base.qcow2",
-#                       "backing-filename-format":"qcow2",
-#                       "snapshots":[
-#                          {
-#                             "id": "1",
-#                             "name": "snapshot1",
-#                             "vm-state-size": 0,
-#                             "date-sec": 10000200,
-#                             "date-nsec": 12,
-#                             "vm-clock-sec": 206,
-#                             "vm-clock-nsec": 30
-#                          }
-#                       ],
-#                       "backing-image":{
-#                           "filename":"disks/base.qcow2",
+#     -> { "execute": "query-named-block-nodes" }
+#     <- { "return": [ { "ro":false,
+#                        "drv":"qcow2",
+#                        "encrypted":false,
+#                        "file":"disks/test.qcow2",
+#                        "node-name": "my-node",
+#                        "backing_file_depth":1,
+#                        "detect_zeroes":"off",
+#                        "bps":1000000,
+#                        "bps_rd":0,
+#                        "bps_wr":0,
+#                        "iops":1000000,
+#                        "iops_rd":0,
+#                        "iops_wr":0,
+#                        "bps_max": 8000000,
+#                        "bps_rd_max": 0,
+#                        "bps_wr_max": 0,
+#                        "iops_max": 0,
+#                        "iops_rd_max": 0,
+#                        "iops_wr_max": 0,
+#                        "iops_size": 0,
+#                        "write_threshold": 0,
+#                        "image":{
+#                           "filename":"disks/test.qcow2",
 #                           "format":"qcow2",
-#                           "virtual-size":2048000
-#                       }
-#                    } } ] }
+#                           "virtual-size":2048000,
+#                           "backing_file":"base.qcow2",
+#                           "full-backing-filename":"disks/base.qcow2",
+#                           "backing-filename-format":"qcow2",
+#                           "snapshots":[
+#                              {
+#                                 "id": "1",
+#                                 "name": "snapshot1",
+#                                 "vm-state-size": 0,
+#                                 "date-sec": 10000200,
+#                                 "date-nsec": 12,
+#                                 "vm-clock-sec": 206,
+#                                 "vm-clock-nsec": 30
+#                              }
+#                           ],
+#                           "backing-image":{
+#                               "filename":"disks/base.qcow2",
+#                               "format":"qcow2",
+#                               "virtual-size":2048000
+#                           }
+#                        } } ] }
 ##
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
@@ -2135,12 +2135,12 @@
 #
 # Example:
 #
-# -> { "execute": "drive-mirror",
-#      "arguments": { "device": "ide-hd0",
-#                     "target": "/some/place/my-image",
-#                     "sync": "full",
-#                     "format": "qcow2" } }
-# <- { "return": {} }
+#     -> { "execute": "drive-mirror",
+#          "arguments": { "device": "ide-hd0",
+#                         "target": "/some/place/my-image",
+#                         "sync": "full",
+#                         "format": "qcow2" } }
+#     <- { "return": {} }
 ##
 { 'command': 'drive-mirror', 'boxed': true,
   'data': 'DriveMirror',
@@ -2313,9 +2313,9 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-add",
-#      "arguments": { "node": "drive0", "name": "bitmap0" } }
-# <- { "return": {} }
+#     -> { "execute": "block-dirty-bitmap-add",
+#          "arguments": { "node": "drive0", "name": "bitmap0" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-dirty-bitmap-add',
   'data': 'BlockDirtyBitmapAdd',
@@ -2338,9 +2338,9 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-remove",
-#      "arguments": { "node": "drive0", "name": "bitmap0" } }
-# <- { "return": {} }
+#     -> { "execute": "block-dirty-bitmap-remove",
+#          "arguments": { "node": "drive0", "name": "bitmap0" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-dirty-bitmap-remove',
   'data': 'BlockDirtyBitmap',
@@ -2362,9 +2362,9 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-clear",
-#      "arguments": { "node": "drive0", "name": "bitmap0" } }
-# <- { "return": {} }
+#     -> { "execute": "block-dirty-bitmap-clear",
+#          "arguments": { "node": "drive0", "name": "bitmap0" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-dirty-bitmap-clear',
   'data': 'BlockDirtyBitmap',
@@ -2384,9 +2384,9 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-enable",
-#      "arguments": { "node": "drive0", "name": "bitmap0" } }
-# <- { "return": {} }
+#     -> { "execute": "block-dirty-bitmap-enable",
+#          "arguments": { "node": "drive0", "name": "bitmap0" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-dirty-bitmap-enable',
   'data': 'BlockDirtyBitmap',
@@ -2406,9 +2406,9 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-disable",
-#      "arguments": { "node": "drive0", "name": "bitmap0" } }
-# <- { "return": {} }
+#     -> { "execute": "block-dirty-bitmap-disable",
+#          "arguments": { "node": "drive0", "name": "bitmap0" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-dirty-bitmap-disable',
   'data': 'BlockDirtyBitmap',
@@ -2439,10 +2439,10 @@
 #
 # Example:
 #
-# -> { "execute": "block-dirty-bitmap-merge",
-#      "arguments": { "node": "drive0", "target": "bitmap0",
-#                     "bitmaps": ["bitmap1"] } }
-# <- { "return": {} }
+#     -> { "execute": "block-dirty-bitmap-merge",
+#          "arguments": { "node": "drive0", "target": "bitmap0",
+#                         "bitmaps": ["bitmap1"] } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-dirty-bitmap-merge',
   'data': 'BlockDirtyBitmapMerge',
@@ -2548,11 +2548,11 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-mirror",
-#      "arguments": { "device": "ide-hd0",
-#                     "target": "target0",
-#                     "sync": "full" } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-mirror",
+#          "arguments": { "device": "ide-hd0",
+#                         "target": "target0",
+#                         "sync": "full" } }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
@@ -2874,10 +2874,10 @@
 #
 # Example:
 #
-# -> { "execute": "block-stream",
-#      "arguments": { "device": "virtio0",
-#                     "base": "/tmp/master.qcow2" } }
-# <- { "return": {} }
+#     -> { "execute": "block-stream",
+#          "arguments": { "device": "virtio0",
+#                         "base": "/tmp/master.qcow2" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
@@ -4805,41 +4805,41 @@
 #
 # Examples:
 #
-# -> { "execute": "blockdev-add",
-#      "arguments": {
-#           "driver": "qcow2",
-#           "node-name": "test1",
-#           "file": {
-#               "driver": "file",
-#               "filename": "test.qcow2"
-#            }
-#       }
-#     }
-# <- { "return": {} }
-#
-# -> { "execute": "blockdev-add",
-#      "arguments": {
-#           "driver": "qcow2",
-#           "node-name": "node0",
-#           "discard": "unmap",
-#           "cache": {
-#              "direct": true
-#            },
-#            "file": {
-#              "driver": "file",
-#              "filename": "/tmp/test.qcow2"
-#            },
-#            "backing": {
-#               "driver": "raw",
+#     -> { "execute": "blockdev-add",
+#          "arguments": {
+#               "driver": "qcow2",
+#               "node-name": "test1",
 #               "file": {
+#                   "driver": "file",
+#                   "filename": "test.qcow2"
+#                }
+#           }
+#         }
+#     <- { "return": {} }
+#
+#     -> { "execute": "blockdev-add",
+#          "arguments": {
+#               "driver": "qcow2",
+#               "node-name": "node0",
+#               "discard": "unmap",
+#               "cache": {
+#                  "direct": true
+#                },
+#                "file": {
 #                  "driver": "file",
-#                  "filename": "/dev/fdset/4"
+#                  "filename": "/tmp/test.qcow2"
+#                },
+#                "backing": {
+#                   "driver": "raw",
+#                   "file": {
+#                      "driver": "file",
+#                      "filename": "/dev/fdset/4"
+#                    }
 #                }
 #            }
-#        }
-#      }
+#          }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true,
   'allow-preconfig': true }
@@ -4903,22 +4903,22 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-add",
-#      "arguments": {
-#           "driver": "qcow2",
-#           "node-name": "node0",
-#           "file": {
-#               "driver": "file",
-#               "filename": "test.qcow2"
-#           }
-#      }
-#    }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-add",
+#          "arguments": {
+#               "driver": "qcow2",
+#               "node-name": "node0",
+#               "file": {
+#                   "driver": "file",
+#                   "filename": "test.qcow2"
+#               }
+#          }
+#        }
+#     <- { "return": {} }
 #
-# -> { "execute": "blockdev-del",
-#      "arguments": { "node-name": "node0" }
-#    }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-del",
+#          "arguments": { "node-name": "node0" }
+#        }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' },
   'allow-preconfig': true }
@@ -5552,10 +5552,10 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_IMAGE_CORRUPTED",
-#      "data": { "device": "", "node-name": "drive", "fatal": false,
-#                "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)" },
-#      "timestamp": { "seconds": 1648243240, "microseconds": 906060 } }
+#     <- { "event": "BLOCK_IMAGE_CORRUPTED",
+#          "data": { "device": "", "node-name": "drive", "fatal": false,
+#                    "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)" },
+#          "timestamp": { "seconds": 1648243240, "microseconds": 906060 } }
 #
 # Since: 1.7
 ##
@@ -5601,13 +5601,13 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_IO_ERROR",
-#      "data": { "device": "ide0-hd1",
-#                "node-name": "#block212",
-#                "operation": "write",
-#                "action": "stop",
-#                "reason": "No space left on device" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "BLOCK_IO_ERROR",
+#          "data": { "device": "ide0-hd1",
+#                    "node-name": "#block212",
+#                    "operation": "write",
+#                    "action": "stop",
+#                    "reason": "No space left on device" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_IO_ERROR',
   'data': { 'device': 'str', '*node-name': 'str',
@@ -5641,11 +5641,11 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_JOB_COMPLETED",
-#      "data": { "type": "stream", "device": "virtio-disk0",
-#                "len": 10737418240, "offset": 10737418240,
-#                "speed": 0 },
-#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#     <- { "event": "BLOCK_JOB_COMPLETED",
+#          "data": { "type": "stream", "device": "virtio-disk0",
+#                    "len": 10737418240, "offset": 10737418240,
+#                    "speed": 0 },
+#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
 ##
 { 'event': 'BLOCK_JOB_COMPLETED',
   'data': { 'type'  : 'JobType',
@@ -5676,11 +5676,11 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_JOB_CANCELLED",
-#      "data": { "type": "stream", "device": "virtio-disk0",
-#                "len": 10737418240, "offset": 134217728,
-#                "speed": 0 },
-#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#     <- { "event": "BLOCK_JOB_CANCELLED",
+#          "data": { "type": "stream", "device": "virtio-disk0",
+#                    "len": 10737418240, "offset": 134217728,
+#                    "speed": 0 },
+#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
 ##
 { 'event': 'BLOCK_JOB_CANCELLED',
   'data': { 'type'  : 'JobType',
@@ -5705,11 +5705,11 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_JOB_ERROR",
-#      "data": { "device": "ide0-hd1",
-#                "operation": "write",
-#                "action": "stop" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "BLOCK_JOB_ERROR",
+#          "data": { "device": "ide0-hd1",
+#                    "operation": "write",
+#                    "action": "stop" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_JOB_ERROR',
   'data': { 'device'   : 'str',
@@ -5740,10 +5740,10 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_JOB_READY",
-#      "data": { "device": "drive0", "type": "mirror", "speed": 0,
-#                "len": 2097152, "offset": 2097152 },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "BLOCK_JOB_READY",
+#          "data": { "device": "drive0", "type": "mirror", "speed": 0,
+#                    "len": 2097152, "offset": 2097152 },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_JOB_READY',
   'data': { 'type'  : 'JobType',
@@ -5768,9 +5768,9 @@
 #
 # Example:
 #
-# <- { "event": "BLOCK_JOB_PENDING",
-#      "data": { "type": "mirror", "id": "backup_1" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "BLOCK_JOB_PENDING",
+#          "data": { "type": "mirror", "id": "backup_1" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_JOB_PENDING',
   'data': { 'type'  : 'JobType',
@@ -5842,10 +5842,10 @@
 #
 # Example:
 #
-# -> { "execute": "block-set-write-threshold",
-#      "arguments": { "node-name": "mydev",
-#                     "write-threshold": 17179869184 } }
-# <- { "return": {} }
+#     -> { "execute": "block-set-write-threshold",
+#          "arguments": { "node-name": "mydev",
+#                         "write-threshold": 17179869184 } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-set-write-threshold',
   'data': { 'node-name': 'str', 'write-threshold': 'uint64' },
@@ -5887,26 +5887,26 @@
 #
 # Examples:
 #
-# 1. Add a new node to a quorum
+#     1. Add a new node to a quorum
 #
-# -> { "execute": "blockdev-add",
-#      "arguments": {
-#          "driver": "raw",
-#          "node-name": "new_node",
-#          "file": { "driver": "file",
-#                    "filename": "test.raw" } } }
-# <- { "return": {} }
-# -> { "execute": "x-blockdev-change",
-#      "arguments": { "parent": "disk1",
-#                     "node": "new_node" } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-add",
+#          "arguments": {
+#              "driver": "raw",
+#              "node-name": "new_node",
+#              "file": { "driver": "file",
+#                        "filename": "test.raw" } } }
+#     <- { "return": {} }
+#     -> { "execute": "x-blockdev-change",
+#          "arguments": { "parent": "disk1",
+#                         "node": "new_node" } }
+#     <- { "return": {} }
 #
-# 2. Delete a quorum's node
+#     2. Delete a quorum's node
 #
-# -> { "execute": "x-blockdev-change",
-#      "arguments": { "parent": "disk1",
-#                     "child": "children.1" } }
-# <- { "return": {} }
+#     -> { "execute": "x-blockdev-change",
+#          "arguments": { "parent": "disk1",
+#                         "child": "children.1" } }
+#     <- { "return": {} }
 ##
 { 'command': 'x-blockdev-change',
   'data' : { 'parent': 'str',
@@ -5939,19 +5939,19 @@
 #
 # Examples:
 #
-# 1. Move a node into an IOThread
+#     1. Move a node into an IOThread
 #
-# -> { "execute": "x-blockdev-set-iothread",
-#      "arguments": { "node-name": "disk1",
-#                     "iothread": "iothread0" } }
-# <- { "return": {} }
+#     -> { "execute": "x-blockdev-set-iothread",
+#          "arguments": { "node-name": "disk1",
+#                         "iothread": "iothread0" } }
+#     <- { "return": {} }
 #
-# 2. Move a node into the main loop
+#     2. Move a node into the main loop
 #
-# -> { "execute": "x-blockdev-set-iothread",
-#      "arguments": { "node-name": "disk1",
-#                     "iothread": null } }
-# <- { "return": {} }
+#     -> { "execute": "x-blockdev-set-iothread",
+#          "arguments": { "node-name": "disk1",
+#                         "iothread": null } }
+#     <- { "return": {} }
 ##
 { 'command': 'x-blockdev-set-iothread',
   'data' : { 'node-name': 'str',
@@ -5993,9 +5993,9 @@
 #
 # Example:
 #
-# <- { "event": "QUORUM_FAILURE",
-#      "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#     <- { "event": "QUORUM_FAILURE",
+#          "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
+#          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
 ##
 { 'event': 'QUORUM_FAILURE',
   'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'int' } }
@@ -6024,19 +6024,19 @@
 #
 # Examples:
 #
-# 1. Read operation
+#     1. Read operation
 #
-# <- { "event": "QUORUM_REPORT_BAD",
-#      "data": { "node-name": "node0", "sector-num": 345435, "sectors-count": 5,
-#                "type": "read" },
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#     <- { "event": "QUORUM_REPORT_BAD",
+#          "data": { "node-name": "node0", "sector-num": 345435, "sectors-count": 5,
+#                    "type": "read" },
+#          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
 #
-# 2. Flush operation
+#     2. Flush operation
 #
-# <- { "event": "QUORUM_REPORT_BAD",
-#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
-#                "type": "flush", "error": "Broken pipe" },
-#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#     <- { "event": "QUORUM_REPORT_BAD",
+#          "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
+#                    "type": "flush", "error": "Broken pipe" },
+#          "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
 ##
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
@@ -6082,11 +6082,11 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-snapshot-internal-sync",
-#      "arguments": { "device": "ide-hd0",
-#                     "name": "snapshot0" }
-#    }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-snapshot-internal-sync",
+#          "arguments": { "device": "ide-hd0",
+#                         "name": "snapshot0" }
+#        }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-snapshot-internal-sync',
   'data': 'BlockdevSnapshotInternal',
@@ -6119,21 +6119,21 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-snapshot-delete-internal-sync",
-#      "arguments": { "device": "ide-hd0",
-#                     "name": "snapshot0" }
-#    }
-# <- { "return": {
-#                    "id": "1",
-#                    "name": "snapshot0",
-#                    "vm-state-size": 0,
-#                    "date-sec": 1000012,
-#                    "date-nsec": 10,
-#                    "vm-clock-sec": 100,
-#                    "vm-clock-nsec": 20,
-#                    "icount": 220414
-#      }
-#    }
+#     -> { "execute": "blockdev-snapshot-delete-internal-sync",
+#          "arguments": { "device": "ide-hd0",
+#                         "name": "snapshot0" }
+#        }
+#     <- { "return": {
+#                        "id": "1",
+#                        "name": "snapshot0",
+#                        "vm-state-size": 0,
+#                        "date-sec": 1000012,
+#                        "date-nsec": 10,
+#                        "vm-clock-sec": 100,
+#                        "vm-clock-nsec": 20,
+#                        "icount": 220414
+#          }
+#        }
 ##
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
diff --git a/qapi/block.json b/qapi/block.json
index 998008cfa8..79a0bcc208 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -120,8 +120,8 @@
 #
 # Example:
 #
-# -> { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
-# <- { "return": {} }
+#     -> { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
+#     <- { "return": {} }
 ##
 { 'command': 'eject',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -164,17 +164,17 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-open-tray",
-#      "arguments": { "id": "ide0-1-0" } }
+#     -> { "execute": "blockdev-open-tray",
+#          "arguments": { "id": "ide0-1-0" } }
 #
-# <- { "timestamp": { "seconds": 1418751016,
-#                     "microseconds": 716996 },
-#      "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "ide0-1-0",
-#                "tray-open": true } }
+#     <- { "timestamp": { "seconds": 1418751016,
+#                         "microseconds": 716996 },
+#          "event": "DEVICE_TRAY_MOVED",
+#          "data": { "device": "ide1-cd0",
+#                    "id": "ide0-1-0",
+#                    "tray-open": true } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-open-tray',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -202,17 +202,17 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-close-tray",
-#      "arguments": { "id": "ide0-1-0" } }
+#     -> { "execute": "blockdev-close-tray",
+#          "arguments": { "id": "ide0-1-0" } }
 #
-# <- { "timestamp": { "seconds": 1418751345,
-#                     "microseconds": 272147 },
-#      "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "ide0-1-0",
-#                "tray-open": false } }
+#     <- { "timestamp": { "seconds": 1418751345,
+#                         "microseconds": 272147 },
+#          "event": "DEVICE_TRAY_MOVED",
+#          "data": { "device": "ide1-cd0",
+#                    "id": "ide0-1-0",
+#                    "tray-open": false } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-close-tray',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -234,28 +234,28 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-remove-medium",
-#      "arguments": { "id": "ide0-1-0" } }
+#     -> { "execute": "blockdev-remove-medium",
+#          "arguments": { "id": "ide0-1-0" } }
 #
-# <- { "error": { "class": "GenericError",
-#                 "desc": "Tray of device 'ide0-1-0' is not open" } }
+#     <- { "error": { "class": "GenericError",
+#                     "desc": "Tray of device 'ide0-1-0' is not open" } }
 #
-# -> { "execute": "blockdev-open-tray",
-#      "arguments": { "id": "ide0-1-0" } }
+#     -> { "execute": "blockdev-open-tray",
+#          "arguments": { "id": "ide0-1-0" } }
 #
-# <- { "timestamp": { "seconds": 1418751627,
-#                     "microseconds": 549958 },
-#      "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "ide0-1-0",
-#                "tray-open": true } }
+#     <- { "timestamp": { "seconds": 1418751627,
+#                         "microseconds": 549958 },
+#          "event": "DEVICE_TRAY_MOVED",
+#          "data": { "device": "ide1-cd0",
+#                    "id": "ide0-1-0",
+#                    "tray-open": true } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 #
-# -> { "execute": "blockdev-remove-medium",
-#      "arguments": { "id": "ide0-1-0" } }
+#     -> { "execute": "blockdev-remove-medium",
+#          "arguments": { "id": "ide0-1-0" } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-remove-medium',
   'data': { 'id': 'str' } }
@@ -275,19 +275,19 @@
 #
 # Example:
 #
-# -> { "execute": "blockdev-add",
-#      "arguments": {
-#          "node-name": "node0",
-#          "driver": "raw",
-#          "file": { "driver": "file",
-#                    "filename": "fedora.iso" } } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-add",
+#          "arguments": {
+#              "node-name": "node0",
+#              "driver": "raw",
+#              "file": { "driver": "file",
+#                        "filename": "fedora.iso" } } }
+#     <- { "return": {} }
 #
-# -> { "execute": "blockdev-insert-medium",
-#      "arguments": { "id": "ide0-1-0",
-#                     "node-name": "node0" } }
+#     -> { "execute": "blockdev-insert-medium",
+#          "arguments": { "id": "ide0-1-0",
+#                         "node-name": "node0" } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-insert-medium',
   'data': { 'id': 'str',
@@ -345,33 +345,33 @@
 #
 # Examples:
 #
-# 1. Change a removable medium
+#     1. Change a removable medium
 #
-# -> { "execute": "blockdev-change-medium",
-#      "arguments": { "id": "ide0-1-0",
-#                     "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
-#                     "format": "raw" } }
-# <- { "return": {} }
+#     -> { "execute": "blockdev-change-medium",
+#          "arguments": { "id": "ide0-1-0",
+#                         "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
+#                         "format": "raw" } }
+#     <- { "return": {} }
 #
-# 2. Load a read-only medium into a writable drive
+#     2. Load a read-only medium into a writable drive
 #
-# -> { "execute": "blockdev-change-medium",
-#      "arguments": { "id": "floppyA",
-#                     "filename": "/srv/images/ro.img",
-#                     "format": "raw",
-#                     "read-only-mode": "retain" } }
+#     -> { "execute": "blockdev-change-medium",
+#          "arguments": { "id": "floppyA",
+#                         "filename": "/srv/images/ro.img",
+#                         "format": "raw",
+#                         "read-only-mode": "retain" } }
 #
-# <- { "error":
-#      { "class": "GenericError",
-#        "desc": "Could not open '/srv/images/ro.img': Permission denied" } }
+#     <- { "error":
+#          { "class": "GenericError",
+#            "desc": "Could not open '/srv/images/ro.img': Permission denied" } }
 #
-# -> { "execute": "blockdev-change-medium",
-#      "arguments": { "id": "floppyA",
-#                     "filename": "/srv/images/ro.img",
-#                     "format": "raw",
-#                     "read-only-mode": "read-only" } }
+#     -> { "execute": "blockdev-change-medium",
+#          "arguments": { "id": "floppyA",
+#                         "filename": "/srv/images/ro.img",
+#                         "format": "raw",
+#                         "read-only-mode": "read-only" } }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'blockdev-change-medium',
   'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
@@ -400,12 +400,12 @@
 #
 # Example:
 #
-# <- { "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "/machine/unattached/device[22]",
-#                "tray-open": true
-#      },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "DEVICE_TRAY_MOVED",
+#          "data": { "device": "ide1-cd0",
+#                    "id": "/machine/unattached/device[22]",
+#                    "tray-open": true
+#          },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'DEVICE_TRAY_MOVED',
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
@@ -424,11 +424,11 @@
 #
 # Example:
 #
-# <- { "event": "PR_MANAGER_STATUS_CHANGED",
-#      "data": { "id": "pr-helper0",
-#                "connected": true
-#      },
-#      "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
+#     <- { "event": "PR_MANAGER_STATUS_CHANGED",
+#          "data": { "id": "pr-helper0",
+#                    "connected": true
+#          },
+#          "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
@@ -467,41 +467,41 @@
 #
 # Examples:
 #
-# -> { "execute": "block_set_io_throttle",
-#      "arguments": { "id": "virtio-blk-pci0/virtio-backend",
-#                     "bps": 0,
-#                     "bps_rd": 0,
-#                     "bps_wr": 0,
-#                     "iops": 512,
-#                     "iops_rd": 0,
-#                     "iops_wr": 0,
-#                     "bps_max": 0,
-#                     "bps_rd_max": 0,
-#                     "bps_wr_max": 0,
-#                     "iops_max": 0,
-#                     "iops_rd_max": 0,
-#                     "iops_wr_max": 0,
-#                     "bps_max_length": 0,
-#                     "iops_size": 0 } }
-# <- { "return": {} }
+#     -> { "execute": "block_set_io_throttle",
+#          "arguments": { "id": "virtio-blk-pci0/virtio-backend",
+#                         "bps": 0,
+#                         "bps_rd": 0,
+#                         "bps_wr": 0,
+#                         "iops": 512,
+#                         "iops_rd": 0,
+#                         "iops_wr": 0,
+#                         "bps_max": 0,
+#                         "bps_rd_max": 0,
+#                         "bps_wr_max": 0,
+#                         "iops_max": 0,
+#                         "iops_rd_max": 0,
+#                         "iops_wr_max": 0,
+#                         "bps_max_length": 0,
+#                         "iops_size": 0 } }
+#     <- { "return": {} }
 #
-# -> { "execute": "block_set_io_throttle",
-#      "arguments": { "id": "ide0-1-0",
-#                     "bps": 1000000,
-#                     "bps_rd": 0,
-#                     "bps_wr": 0,
-#                     "iops": 0,
-#                     "iops_rd": 0,
-#                     "iops_wr": 0,
-#                     "bps_max": 8000000,
-#                     "bps_rd_max": 0,
-#                     "bps_wr_max": 0,
-#                     "iops_max": 0,
-#                     "iops_rd_max": 0,
-#                     "iops_wr_max": 0,
-#                     "bps_max_length": 60,
-#                     "iops_size": 0 } }
-# <- { "return": {} }
+#     -> { "execute": "block_set_io_throttle",
+#          "arguments": { "id": "ide0-1-0",
+#                         "bps": 1000000,
+#                         "bps_rd": 0,
+#                         "bps_wr": 0,
+#                         "iops": 0,
+#                         "iops_rd": 0,
+#                         "iops_wr": 0,
+#                         "bps_max": 8000000,
+#                         "bps_rd_max": 0,
+#                         "bps_wr_max": 0,
+#                         "iops_max": 0,
+#                         "iops_rd_max": 0,
+#                         "iops_wr_max": 0,
+#                         "bps_max_length": 60,
+#                         "iops_size": 0 } }
+#     <- { "return": {} }
 ##
 { 'command': 'block_set_io_throttle', 'boxed': true,
   'data': 'BlockIOThrottle',
@@ -547,43 +547,43 @@
 #
 # Example:
 #
-# Set new histograms for all io types with intervals [0, 10), [10,
-# 50), [50, 100), [100, +inf):
+#     Set new histograms for all io types with intervals [0, 10), [10,
+#     50), [50, 100), [100, +inf):
 #
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0",
-#                     "boundaries": [10, 50, 100] } }
-# <- { "return": {} }
+#     -> { "execute": "block-latency-histogram-set",
+#          "arguments": { "id": "drive0",
+#                         "boundaries": [10, 50, 100] } }
+#     <- { "return": {} }
 #
 # Example:
 #
-# Set new histogram only for write, other histograms will remain not
-# changed (or not created):
+#     Set new histogram only for write, other histograms will remain not
+#     changed (or not created):
 #
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0",
-#                     "boundaries-write": [10, 50, 100] } }
-# <- { "return": {} }
+#     -> { "execute": "block-latency-histogram-set",
+#          "arguments": { "id": "drive0",
+#                         "boundaries-write": [10, 50, 100] } }
+#     <- { "return": {} }
 #
 # Example:
 #
-# Set new histograms with the following intervals:   read, flush: [0,
-# 10), [10, 50), [50, 100), [100, +inf)   write: [0, 1000), [1000,
-# 5000), [5000, +inf)
+#     Set new histograms with the following intervals:   read, flush: [0,
+#     10), [10, 50), [50, 100), [100, +inf)   write: [0, 1000), [1000,
+#     5000), [5000, +inf)
 #
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0",
-#                     "boundaries": [10, 50, 100],
-#                     "boundaries-write": [1000, 5000] } }
-# <- { "return": {} }
+#     -> { "execute": "block-latency-histogram-set",
+#          "arguments": { "id": "drive0",
+#                         "boundaries": [10, 50, 100],
+#                         "boundaries-write": [1000, 5000] } }
+#     <- { "return": {} }
 #
 # Example:
 #
-# Remove all latency histograms:
+#     Remove all latency histograms:
 #
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0" } }
-# <- { "return": {} }
+#     -> { "execute": "block-latency-histogram-set",
+#          "arguments": { "id": "drive0" } }
+#     <- { "return": {} }
 ##
 { 'command': 'block-latency-histogram-set',
   'data': {'id': 'str',
diff --git a/qapi/char.json b/qapi/char.json
index 2b786104f8..4873bc635a 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -42,26 +42,26 @@
 #
 # Example:
 #
-# -> { "execute": "query-chardev" }
-# <- {
-#       "return": [
-#          {
-#             "label": "charchannel0",
-#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agent,server=on",
-#             "frontend-open": false
-#          },
-#          {
-#             "label": "charmonitor",
-#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.monitor,server=on",
-#             "frontend-open": true
-#          },
-#          {
-#             "label": "charserial0",
-#             "filename": "pty:/dev/pts/2",
-#             "frontend-open": true
-#          }
-#       ]
-#    }
+#     -> { "execute": "query-chardev" }
+#     <- {
+#           "return": [
+#              {
+#                 "label": "charchannel0",
+#                 "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agent,server=on",
+#                 "frontend-open": false
+#              },
+#              {
+#                 "label": "charmonitor",
+#                 "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.monitor,server=on",
+#                 "frontend-open": true
+#              },
+#              {
+#                 "label": "charserial0",
+#                 "filename": "pty:/dev/pts/2",
+#                 "frontend-open": true
+#              }
+#           ]
+#        }
 ##
 { 'command': 'query-chardev', 'returns': ['ChardevInfo'],
   'allow-preconfig': true }
@@ -88,23 +88,23 @@
 #
 # Example:
 #
-# -> { "execute": "query-chardev-backends" }
-# <- {
-#       "return":[
-#          {
-#             "name":"udp"
-#          },
-#          {
-#             "name":"tcp"
-#          },
-#          {
-#             "name":"unix"
-#          },
-#          {
-#             "name":"spiceport"
-#          }
-#       ]
-#    }
+#     -> { "execute": "query-chardev-backends" }
+#     <- {
+#           "return":[
+#              {
+#                 "name":"udp"
+#              },
+#              {
+#                 "name":"tcp"
+#              },
+#              {
+#                 "name":"unix"
+#              },
+#              {
+#                 "name":"spiceport"
+#              }
+#           ]
+#        }
 ##
 { 'command': 'query-chardev-backends', 'returns': ['ChardevBackendInfo'] }
 
@@ -145,11 +145,11 @@
 #
 # Example:
 #
-# -> { "execute": "ringbuf-write",
-#      "arguments": { "device": "foo",
-#                     "data": "abcdefgh",
-#                     "format": "utf8" } }
-# <- { "return": {} }
+#     -> { "execute": "ringbuf-write",
+#          "arguments": { "device": "foo",
+#                         "data": "abcdefgh",
+#                         "format": "utf8" } }
+#     <- { "return": {} }
 ##
 { 'command': 'ringbuf-write',
   'data': { 'device': 'str',
@@ -181,11 +181,11 @@
 #
 # Example:
 #
-# -> { "execute": "ringbuf-read",
-#      "arguments": { "device": "foo",
-#                     "size": 1000,
-#                     "format": "utf8" } }
-# <- { "return": "abcdefgh" }
+#     -> { "execute": "ringbuf-read",
+#          "arguments": { "device": "foo",
+#                         "size": 1000,
+#                         "format": "utf8" } }
+#     <- { "return": "abcdefgh" }
 ##
 { 'command': 'ringbuf-read',
   'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
@@ -703,21 +703,21 @@
 #
 # Examples:
 #
-# -> { "execute" : "chardev-add",
-#      "arguments" : { "id" : "foo",
-#                      "backend" : { "type" : "null", "data" : {} } } }
-# <- { "return": {} }
+#     -> { "execute" : "chardev-add",
+#          "arguments" : { "id" : "foo",
+#                          "backend" : { "type" : "null", "data" : {} } } }
+#     <- { "return": {} }
 #
-# -> { "execute" : "chardev-add",
-#      "arguments" : { "id" : "bar",
-#                      "backend" : { "type" : "file",
-#                                    "data" : { "out" : "/tmp/bar.log" } } } }
-# <- { "return": {} }
+#     -> { "execute" : "chardev-add",
+#          "arguments" : { "id" : "bar",
+#                          "backend" : { "type" : "file",
+#                                        "data" : { "out" : "/tmp/bar.log" } } } }
+#     <- { "return": {} }
 #
-# -> { "execute" : "chardev-add",
-#      "arguments" : { "id" : "baz",
-#                      "backend" : { "type" : "pty", "data" : {} } } }
-# <- { "return": { "pty" : "/dev/pty/42" } }
+#     -> { "execute" : "chardev-add",
+#          "arguments" : { "id" : "baz",
+#                          "backend" : { "type" : "pty", "data" : {} } } }
+#     <- { "return": { "pty" : "/dev/pty/42" } }
 ##
 { 'command': 'chardev-add',
   'data': { 'id': 'str',
@@ -739,26 +739,26 @@
 #
 # Examples:
 #
-# -> { "execute" : "chardev-change",
-#      "arguments" : { "id" : "baz",
-#                      "backend" : { "type" : "pty", "data" : {} } } }
-# <- { "return": { "pty" : "/dev/pty/42" } }
+#     -> { "execute" : "chardev-change",
+#          "arguments" : { "id" : "baz",
+#                          "backend" : { "type" : "pty", "data" : {} } } }
+#     <- { "return": { "pty" : "/dev/pty/42" } }
 #
-# -> {"execute" : "chardev-change",
-#     "arguments" : {
-#         "id" : "charchannel2",
-#         "backend" : {
-#             "type" : "socket",
-#             "data" : {
-#                 "addr" : {
-#                     "type" : "unix" ,
-#                     "data" : {
-#                         "path" : "/tmp/charchannel2.socket"
-#                     }
-#                  },
-#                  "server" : true,
-#                  "wait" : false }}}}
-# <- {"return": {}}
+#     -> {"execute" : "chardev-change",
+#         "arguments" : {
+#             "id" : "charchannel2",
+#             "backend" : {
+#                 "type" : "socket",
+#                 "data" : {
+#                     "addr" : {
+#                         "type" : "unix" ,
+#                         "data" : {
+#                             "path" : "/tmp/charchannel2.socket"
+#                         }
+#                      },
+#                      "server" : true,
+#                      "wait" : false }}}}
+#     <- {"return": {}}
 ##
 { 'command': 'chardev-change',
   'data': { 'id': 'str',
@@ -778,8 +778,8 @@
 #
 # Example:
 #
-# -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
-# <- { "return": {} }
+#     -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
+#     <- { "return": {} }
 ##
 { 'command': 'chardev-remove',
   'data': { 'id': 'str' } }
@@ -797,8 +797,8 @@
 #
 # Example:
 #
-# -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
-# <- { "return": {} }
+#     -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
+#     <- { "return": {} }
 ##
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
@@ -818,9 +818,9 @@
 #
 # Example:
 #
-# <- { "event": "VSERPORT_CHANGE",
-#      "data": { "id": "channel0", "open": true },
-#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#     <- { "event": "VSERPORT_CHANGE",
+#          "data": { "id": "channel0", "open": true },
+#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
 ##
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
diff --git a/qapi/control.json b/qapi/control.json
index a91fa33407..f404daef60 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -20,9 +20,9 @@
 #
 # Example:
 #
-# -> { "execute": "qmp_capabilities",
-#      "arguments": { "enable": [ "oob" ] } }
-# <- { "return": {} }
+#     -> { "execute": "qmp_capabilities",
+#          "arguments": { "enable": [ "oob" ] } }
+#     <- { "return": {} }
 #
 # Notes: This command is valid exactly when first connecting: it must
 #     be issued before any other command will be accepted, and will
@@ -102,17 +102,17 @@
 #
 # Example:
 #
-# -> { "execute": "query-version" }
-# <- {
-#       "return":{
-#          "qemu":{
-#             "major":0,
-#             "minor":11,
-#             "micro":5
-#          },
-#          "package":""
-#       }
-#    }
+#     -> { "execute": "query-version" }
+#     <- {
+#           "return":{
+#              "qemu":{
+#                 "major":0,
+#                 "minor":11,
+#                 "micro":5
+#              },
+#              "package":""
+#           }
+#        }
 ##
 { 'command': 'query-version', 'returns': 'VersionInfo',
   'allow-preconfig': true }
@@ -139,17 +139,17 @@
 #
 # Example:
 #
-# -> { "execute": "query-commands" }
-# <- {
-#      "return":[
-#         {
-#            "name":"query-balloon"
-#         },
-#         {
-#            "name":"system_powerdown"
-#         }
-#      ]
-#    }
+#     -> { "execute": "query-commands" }
+#     <- {
+#          "return":[
+#             {
+#                "name":"query-balloon"
+#             },
+#             {
+#                "name":"system_powerdown"
+#             }
+#          ]
+#        }
 #
 # Note: This example has been shortened as the real response is too
 #     long.
@@ -169,8 +169,8 @@
 #
 # Example:
 #
-# -> { "execute": "quit" }
-# <- { "return": {} }
+#     -> { "execute": "quit" }
+#     <- { "return": {} }
 ##
 { 'command': 'quit',
   'allow-preconfig': true }
diff --git a/qapi/dump.json b/qapi/dump.json
index 1997c1d1d4..f82dd6a1af 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -98,9 +98,9 @@
 #
 # Example:
 #
-# -> { "execute": "dump-guest-memory",
-#      "arguments": { "paging": false, "protocol": "fd:dump" } }
-# <- { "return": {} }
+#     -> { "execute": "dump-guest-memory",
+#          "arguments": { "paging": false, "protocol": "fd:dump" } }
+#     <- { "return": {} }
 ##
 { 'command': 'dump-guest-memory',
   'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
@@ -154,9 +154,9 @@
 #
 # Example:
 #
-# -> { "execute": "query-dump" }
-# <- { "return": { "status": "active", "completed": 1024000,
-#                  "total": 2048000 } }
+#     -> { "execute": "query-dump" }
+#     <- { "return": { "status": "active", "completed": 1024000,
+#                      "total": 2048000 } }
 ##
 { 'command': 'query-dump', 'returns': 'DumpQueryResult' }
 
@@ -175,10 +175,10 @@
 #
 # Example:
 #
-# <- { "event": "DUMP_COMPLETED",
-#      "data": { "result": { "total": 1090650112, "status": "completed",
-#                            "completed": 1090650112 } },
-#      "timestamp": { "seconds": 1648244171, "microseconds": 950316 } }
+#     <- { "event": "DUMP_COMPLETED",
+#          "data": { "result": { "total": 1090650112, "status": "completed",
+#                                "completed": 1090650112 } },
+#          "timestamp": { "seconds": 1648244171, "microseconds": 950316 } }
 ##
 { 'event': 'DUMP_COMPLETED' ,
   'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
@@ -206,9 +206,9 @@
 #
 # Example:
 #
-# -> { "execute": "query-dump-guest-memory-capability" }
-# <- { "return": { "formats":
-#                  ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] } }
+#     -> { "execute": "query-dump-guest-memory-capability" }
+#     <- { "return": { "formats":
+#                      ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] } }
 ##
 { 'command': 'query-dump-guest-memory-capability',
   'returns': 'DumpGuestMemoryCapability' }
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 7b7149f81c..2c5dda735e 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -447,9 +447,9 @@
 #
 # Example:
 #
-# <- { "event": "CPU_POLARIZATION_CHANGE",
-#      "data": { "polarization": "horizontal" },
-#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#     <- { "event": "CPU_POLARIZATION_CHANGE",
+#          "data": { "polarization": "horizontal" },
+#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'CpuS390Polarization' },
diff --git a/qapi/machine.json b/qapi/machine.json
index d816c5c02e..93b4677286 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -106,32 +106,32 @@
 #
 # Example:
 #
-# -> { "execute": "query-cpus-fast" }
-# <- { "return": [
-#         {
-#             "thread-id": 25627,
-#             "props": {
-#                 "core-id": 0,
-#                 "thread-id": 0,
-#                 "socket-id": 0
+#     -> { "execute": "query-cpus-fast" }
+#     <- { "return": [
+#             {
+#                 "thread-id": 25627,
+#                 "props": {
+#                     "core-id": 0,
+#                     "thread-id": 0,
+#                     "socket-id": 0
+#                 },
+#                 "qom-path": "/machine/unattached/device[0]",
+#                 "target":"x86_64",
+#                 "cpu-index": 0
 #             },
-#             "qom-path": "/machine/unattached/device[0]",
-#             "target":"x86_64",
-#             "cpu-index": 0
-#         },
-#         {
-#             "thread-id": 25628,
-#             "props": {
-#                 "core-id": 0,
-#                 "thread-id": 0,
-#                 "socket-id": 1
-#             },
-#             "qom-path": "/machine/unattached/device[2]",
-#             "target":"x86_64",
-#             "cpu-index": 1
-#         }
-#     ]
-# }
+#             {
+#                 "thread-id": 25628,
+#                 "props": {
+#                     "core-id": 0,
+#                     "thread-id": 0,
+#                     "socket-id": 1
+#                 },
+#                 "qom-path": "/machine/unattached/device[2]",
+#                 "target":"x86_64",
+#                 "cpu-index": 1
+#             }
+#         ]
+#     }
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
@@ -258,8 +258,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-uuid" }
-# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
+#     -> { "execute": "query-uuid" }
+#     <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
 
@@ -292,8 +292,8 @@
 #
 # Example:
 #
-# -> { "execute": "system_reset" }
-# <- { "return": {} }
+#     -> { "execute": "system_reset" }
+#     <- { "return": {} }
 ##
 { 'command': 'system_reset' }
 
@@ -311,8 +311,8 @@
 #
 # Example:
 #
-# -> { "execute": "system_powerdown" }
-# <- { "return": {} }
+#     -> { "execute": "system_powerdown" }
+#     <- { "return": {} }
 ##
 { 'command': 'system_powerdown' }
 
@@ -333,8 +333,8 @@
 #
 # Example:
 #
-# -> { "execute": "system_wakeup" }
-# <- { "return": {} }
+#     -> { "execute": "system_wakeup" }
+#     <- { "return": {} }
 ##
 { 'command': 'system_wakeup' }
 
@@ -386,8 +386,8 @@
 #
 # Example:
 #
-# -> { "execute": "inject-nmi" }
-# <- { "return": {} }
+#     -> { "execute": "inject-nmi" }
+#     <- { "return": {} }
 ##
 { 'command': 'inject-nmi' }
 
@@ -415,8 +415,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-kvm" }
-# <- { "return": { "enabled": true, "present": true } }
+#     -> { "execute": "query-kvm" }
+#     <- { "return": { "enabled": true, "present": true } }
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
@@ -786,11 +786,11 @@
 #
 # Example:
 #
-# -> { "execute": "memsave",
-#      "arguments": { "val": 10,
-#                     "size": 100,
-#                     "filename": "/tmp/virtual-mem-dump" } }
-# <- { "return": {} }
+#     -> { "execute": "memsave",
+#          "arguments": { "val": 10,
+#                         "size": 100,
+#                         "filename": "/tmp/virtual-mem-dump" } }
+#     <- { "return": {} }
 ##
 { 'command': 'memsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
@@ -814,11 +814,11 @@
 #
 # Example:
 #
-# -> { "execute": "pmemsave",
-#      "arguments": { "val": 10,
-#                     "size": 100,
-#                     "filename": "/tmp/physical-mem-dump" } }
-# <- { "return": {} }
+#     -> { "execute": "pmemsave",
+#          "arguments": { "val": 10,
+#                         "size": 100,
+#                         "filename": "/tmp/physical-mem-dump" } }
+#     <- { "return": {} }
 ##
 { 'command': 'pmemsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
@@ -875,29 +875,29 @@
 #
 # Example:
 #
-# -> { "execute": "query-memdev" }
-# <- { "return": [
-#        {
-#          "id": "mem1",
-#          "size": 536870912,
-#          "merge": false,
-#          "dump": true,
-#          "prealloc": false,
-#          "share": false,
-#          "host-nodes": [0, 1],
-#          "policy": "bind"
-#        },
-#        {
-#          "size": 536870912,
-#          "merge": false,
-#          "dump": true,
-#          "prealloc": true,
-#          "share": false,
-#          "host-nodes": [2, 3],
-#          "policy": "preferred"
+#     -> { "execute": "query-memdev" }
+#     <- { "return": [
+#            {
+#              "id": "mem1",
+#              "size": 536870912,
+#              "merge": false,
+#              "dump": true,
+#              "prealloc": false,
+#              "share": false,
+#              "host-nodes": [0, 1],
+#              "policy": "bind"
+#            },
+#            {
+#              "size": 536870912,
+#              "merge": false,
+#              "dump": true,
+#              "prealloc": true,
+#              "share": false,
+#              "host-nodes": [2, 3],
+#              "policy": "preferred"
+#            }
+#          ]
 #        }
-#      ]
-#    }
 ##
 { 'command': 'query-memdev', 'returns': ['Memdev'], 'allow-preconfig': true }
 
@@ -990,47 +990,47 @@
 #
 # Examples:
 #
-# For pseries machine type started with -smp 2,cores=2,maxcpus=4 -cpu
-# POWER8:
+#     For pseries machine type started with -smp 2,cores=2,maxcpus=4 -cpu
+#     POWER8:
 #
-# -> { "execute": "query-hotpluggable-cpus" }
-# <- {"return": [
-#      { "props": { "core-id": 8 }, "type": "POWER8-spapr-cpu-core",
-#        "vcpus-count": 1 },
-#      { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
-#        "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
-#    ]}'
+#     -> { "execute": "query-hotpluggable-cpus" }
+#     <- {"return": [
+#          { "props": { "core-id": 8 }, "type": "POWER8-spapr-cpu-core",
+#            "vcpus-count": 1 },
+#          { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
+#            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
+#        ]}'
 #
-# For pc machine type started with -smp 1,maxcpus=2:
+#     For pc machine type started with -smp 1,maxcpus=2:
 #
-# -> { "execute": "query-hotpluggable-cpus" }
-# <- {"return": [
-#      {
-#         "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
-#         "props": {"core-id": 0, "socket-id": 1, "thread-id": 0}
-#      },
-#      {
-#         "qom-path": "/machine/unattached/device[0]",
-#         "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
-#         "props": {"core-id": 0, "socket-id": 0, "thread-id": 0}
-#      }
-#    ]}
+#     -> { "execute": "query-hotpluggable-cpus" }
+#     <- {"return": [
+#          {
+#             "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
+#             "props": {"core-id": 0, "socket-id": 1, "thread-id": 0}
+#          },
+#          {
+#             "qom-path": "/machine/unattached/device[0]",
+#             "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
+#             "props": {"core-id": 0, "socket-id": 0, "thread-id": 0}
+#          }
+#        ]}
 #
-# For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu
-# qemu (Since: 2.11):
+#     For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu
+#     qemu (Since: 2.11):
 #
-# -> { "execute": "query-hotpluggable-cpus" }
-# <- {"return": [
-#      {
-#         "type": "qemu-s390x-cpu", "vcpus-count": 1,
-#         "props": { "core-id": 1 }
-#      },
-#      {
-#         "qom-path": "/machine/unattached/device[0]",
-#         "type": "qemu-s390x-cpu", "vcpus-count": 1,
-#         "props": { "core-id": 0 }
-#      }
-#    ]}
+#     -> { "execute": "query-hotpluggable-cpus" }
+#     <- {"return": [
+#          {
+#             "type": "qemu-s390x-cpu", "vcpus-count": 1,
+#             "props": { "core-id": 1 }
+#          },
+#          {
+#             "qom-path": "/machine/unattached/device[0]",
+#             "type": "qemu-s390x-cpu", "vcpus-count": 1,
+#             "props": { "core-id": 0 }
+#          }
+#        ]}
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
              'allow-preconfig': true }
@@ -1074,10 +1074,10 @@
 #
 # Example:
 #
-# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
-# <- { "return": {} }
+#     -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+#     <- { "return": {} }
 #
-# With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#     With a 2.5GiB guest this command inflated the ballon to 3GiB.
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
@@ -1108,11 +1108,11 @@
 #
 # Example:
 #
-# -> { "execute": "query-balloon" }
-# <- { "return": {
-#          "actual": 1073741824
-#       }
-#    }
+#     -> { "execute": "query-balloon" }
+#     <- { "return": {
+#              "actual": 1073741824
+#           }
+#        }
 ##
 { 'command': 'query-balloon', 'returns': 'BalloonInfo' }
 
@@ -1132,9 +1132,9 @@
 #
 # Example:
 #
-# <- { "event": "BALLOON_CHANGE",
-#      "data": { "actual": 944766976 },
-#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#     <- { "event": "BALLOON_CHANGE",
+#          "data": { "actual": 944766976 },
+#          "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
@@ -1172,12 +1172,12 @@
 #
 # Example:
 #
-# -> { "execute": "query-hv-balloon-status-report" }
-# <- { "return": {
-#          "committed": 816640000,
-#          "available": 3333054464
-#       }
-#    }
+#     -> { "execute": "query-hv-balloon-status-report" }
+#     <- { "return": {
+#              "committed": 816640000,
+#              "available": 3333054464
+#           }
+#        }
 ##
 { 'command': 'query-hv-balloon-status-report', 'returns': 'HvBalloonInfo' }
 
@@ -1193,9 +1193,9 @@
 #
 # Example:
 #
-# <- { "event": "HV_BALLOON_STATUS_REPORT",
-#      "data": { "committed": 816640000, "available": 3333054464 },
-#      "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
+#     <- { "event": "HV_BALLOON_STATUS_REPORT",
+#          "data": { "committed": 816640000, "available": 3333054464 },
+#          "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
 #
 ##
 { 'event': 'HV_BALLOON_STATUS_REPORT',
@@ -1226,8 +1226,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-memory-size-summary" }
-# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
+#     -> { "execute": "query-memory-size-summary" }
+#     <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
 #
 # Since: 2.11
 ##
@@ -1505,18 +1505,18 @@
 #
 # Example:
 #
-# -> { "execute": "query-memory-devices" }
-# <- { "return": [ { "data":
-#                       { "addr": 5368709120,
-#                         "hotpluggable": true,
-#                         "hotplugged": true,
-#                         "id": "d1",
-#                         "memdev": "/objects/memX",
-#                         "node": 0,
-#                         "size": 1073741824,
-#                         "slot": 0},
-#                    "type": "dimm"
-#                  } ] }
+#     -> { "execute": "query-memory-devices" }
+#     <- { "return": [ { "data":
+#                           { "addr": 5368709120,
+#                             "hotpluggable": true,
+#                             "hotplugged": true,
+#                             "id": "d1",
+#                             "memdev": "/objects/memX",
+#                             "node": 0,
+#                             "size": 1073741824,
+#                             "slot": 0},
+#                        "type": "dimm"
+#                      } ] }
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
 
@@ -1539,10 +1539,10 @@
 #
 # Example:
 #
-# <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
-#      "data": { "id": "vm0", "size": 1073741824,
-#                "qom-path": "/machine/unattached/device[2]" },
-#      "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
+#     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
+#          "data": { "id": "vm0", "size": 1073741824,
+#                    "qom-path": "/machine/unattached/device[2]" },
+#          "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
 ##
 { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
@@ -1565,11 +1565,11 @@
 #
 # Example:
 #
-# <- { "event": "MEM_UNPLUG_ERROR",
-#      "data": { "device": "dimm1",
-#                "msg": "acpi: device unplug for unsupported device"
-#      },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "MEM_UNPLUG_ERROR",
+#          "data": { "device": "dimm1",
+#                    "msg": "acpi: device unplug for unsupported device"
+#          },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'MEM_UNPLUG_ERROR',
   'data': { 'device': 'str', 'msg': 'str' },
@@ -1836,9 +1836,9 @@
 #
 # Example:
 #
-# -> { "execute": "dumpdtb" }
-#      "arguments": { "filename": "fdt.dtb" } }
-# <- { "return": {} }
+#     -> { "execute": "dumpdtb" }
+#          "arguments": { "filename": "fdt.dtb" } }
+#     <- { "return": {} }
 ##
 { 'command': 'dumpdtb',
   'data': { 'filename': 'str' },
diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..c3c6e821cf 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -312,112 +312,112 @@
 #
 # Examples:
 #
-# 1. Before the first migration
+#     1. Before the first migration
 #
-# -> { "execute": "query-migrate" }
-# <- { "return": {} }
+#     -> { "execute": "query-migrate" }
+#     <- { "return": {} }
 #
-# 2. Migration is done and has succeeded
+#     2. Migration is done and has succeeded
 #
-# -> { "execute": "query-migrate" }
-# <- { "return": {
-#         "status": "completed",
-#         "total-time":12345,
-#         "setup-time":12345,
-#         "downtime":12345,
-#         "ram":{
-#           "transferred":123,
-#           "remaining":123,
-#           "total":246,
-#           "duplicate":123,
-#           "normal":123,
-#           "normal-bytes":123456,
-#           "dirty-sync-count":15
-#         }
-#      }
-#    }
-#
-# 3. Migration is done and has failed
-#
-# -> { "execute": "query-migrate" }
-# <- { "return": { "status": "failed" } }
-#
-# 4. Migration is being performed and is not a block migration:
-#
-# -> { "execute": "query-migrate" }
-# <- {
-#       "return":{
-#          "status":"active",
-#          "total-time":12345,
-#          "setup-time":12345,
-#          "expected-downtime":12345,
-#          "ram":{
-#             "transferred":123,
-#             "remaining":123,
-#             "total":246,
-#             "duplicate":123,
-#             "normal":123,
-#             "normal-bytes":123456,
-#             "dirty-sync-count":15
+#     -> { "execute": "query-migrate" }
+#     <- { "return": {
+#             "status": "completed",
+#             "total-time":12345,
+#             "setup-time":12345,
+#             "downtime":12345,
+#             "ram":{
+#               "transferred":123,
+#               "remaining":123,
+#               "total":246,
+#               "duplicate":123,
+#               "normal":123,
+#               "normal-bytes":123456,
+#               "dirty-sync-count":15
+#             }
 #          }
-#       }
-#    }
+#        }
 #
-# 5. Migration is being performed and is a block migration:
+#     3. Migration is done and has failed
 #
-# -> { "execute": "query-migrate" }
-# <- {
-#       "return":{
-#          "status":"active",
-#          "total-time":12345,
-#          "setup-time":12345,
-#          "expected-downtime":12345,
-#          "ram":{
-#             "total":1057024,
-#             "remaining":1053304,
-#             "transferred":3720,
-#             "duplicate":123,
-#             "normal":123,
-#             "normal-bytes":123456,
-#             "dirty-sync-count":15
-#          },
-#          "disk":{
-#             "total":20971520,
-#             "remaining":20880384,
-#             "transferred":91136
-#          }
-#       }
-#    }
+#     -> { "execute": "query-migrate" }
+#     <- { "return": { "status": "failed" } }
 #
-# 6. Migration is being performed and XBZRLE is active:
+#     4. Migration is being performed and is not a block migration:
 #
-# -> { "execute": "query-migrate" }
-# <- {
-#       "return":{
-#          "status":"active",
-#          "total-time":12345,
-#          "setup-time":12345,
-#          "expected-downtime":12345,
-#          "ram":{
-#             "total":1057024,
-#             "remaining":1053304,
-#             "transferred":3720,
-#             "duplicate":10,
-#             "normal":3333,
-#             "normal-bytes":3412992,
-#             "dirty-sync-count":15
-#          },
-#          "xbzrle-cache":{
-#             "cache-size":67108864,
-#             "bytes":20971520,
-#             "pages":2444343,
-#             "cache-miss":2244,
-#             "cache-miss-rate":0.123,
-#             "encoding-rate":80.1,
-#             "overflow":34434
-#          }
-#       }
-#    }
+#     -> { "execute": "query-migrate" }
+#     <- {
+#           "return":{
+#              "status":"active",
+#              "total-time":12345,
+#              "setup-time":12345,
+#              "expected-downtime":12345,
+#              "ram":{
+#                 "transferred":123,
+#                 "remaining":123,
+#                 "total":246,
+#                 "duplicate":123,
+#                 "normal":123,
+#                 "normal-bytes":123456,
+#                 "dirty-sync-count":15
+#              }
+#           }
+#        }
+#
+#     5. Migration is being performed and is a block migration:
+#
+#     -> { "execute": "query-migrate" }
+#     <- {
+#           "return":{
+#              "status":"active",
+#              "total-time":12345,
+#              "setup-time":12345,
+#              "expected-downtime":12345,
+#              "ram":{
+#                 "total":1057024,
+#                 "remaining":1053304,
+#                 "transferred":3720,
+#                 "duplicate":123,
+#                 "normal":123,
+#                 "normal-bytes":123456,
+#                 "dirty-sync-count":15
+#              },
+#              "disk":{
+#                 "total":20971520,
+#                 "remaining":20880384,
+#                 "transferred":91136
+#              }
+#           }
+#        }
+#
+#     6. Migration is being performed and XBZRLE is active:
+#
+#     -> { "execute": "query-migrate" }
+#     <- {
+#           "return":{
+#              "status":"active",
+#              "total-time":12345,
+#              "setup-time":12345,
+#              "expected-downtime":12345,
+#              "ram":{
+#                 "total":1057024,
+#                 "remaining":1053304,
+#                 "transferred":3720,
+#                 "duplicate":10,
+#                 "normal":3333,
+#                 "normal-bytes":3412992,
+#                 "dirty-sync-count":15
+#              },
+#              "xbzrle-cache":{
+#                 "cache-size":67108864,
+#                 "bytes":20971520,
+#                 "pages":2444343,
+#                 "cache-miss":2244,
+#                 "cache-miss-rate":0.123,
+#                 "encoding-rate":80.1,
+#                 "overflow":34434
+#              }
+#           }
+#        }
 ##
 { 'command': 'query-migrate', 'returns': 'MigrationInfo' }
 
@@ -582,9 +582,9 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-set-capabilities" , "arguments":
-#      { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate-set-capabilities" , "arguments":
+#          { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'migrate-set-capabilities',
   'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
@@ -600,17 +600,17 @@
 #
 # Example:
 #
-# -> { "execute": "query-migrate-capabilities" }
-# <- { "return": [
-#       {"state": false, "capability": "xbzrle"},
-#       {"state": false, "capability": "rdma-pin-all"},
-#       {"state": false, "capability": "auto-converge"},
-#       {"state": false, "capability": "zero-blocks"},
-#       {"state": false, "capability": "compress"},
-#       {"state": true, "capability": "events"},
-#       {"state": false, "capability": "postcopy-ram"},
-#       {"state": false, "capability": "x-colo"}
-#    ]}
+#     -> { "execute": "query-migrate-capabilities" }
+#     <- { "return": [
+#           {"state": false, "capability": "xbzrle"},
+#           {"state": false, "capability": "rdma-pin-all"},
+#           {"state": false, "capability": "auto-converge"},
+#           {"state": false, "capability": "zero-blocks"},
+#           {"state": false, "capability": "compress"},
+#           {"state": true, "capability": "events"},
+#           {"state": false, "capability": "postcopy-ram"},
+#           {"state": false, "capability": "x-colo"}
+#        ]}
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
 
@@ -1130,9 +1130,9 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-set-parameters" ,
-#      "arguments": { "multifd-channels": 5 } }
-# <- { "return": {} }
+#     -> { "execute": "migrate-set-parameters" ,
+#          "arguments": { "multifd-channels": 5 } }
+#     <- { "return": {} }
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
   'data': 'MigrateSetParameters' }
@@ -1357,15 +1357,15 @@
 #
 # Example:
 #
-# -> { "execute": "query-migrate-parameters" }
-# <- { "return": {
-#          "multifd-channels": 2,
-#          "cpu-throttle-increment": 10,
-#          "cpu-throttle-initial": 20,
-#          "max-bandwidth": 33554432,
-#          "downtime-limit": 300
-#       }
-#    }
+#     -> { "execute": "query-migrate-parameters" }
+#     <- { "return": {
+#              "multifd-channels": 2,
+#              "cpu-throttle-increment": 10,
+#              "cpu-throttle-initial": 20,
+#              "max-bandwidth": 33554432,
+#              "downtime-limit": 300
+#           }
+#        }
 ##
 { 'command': 'query-migrate-parameters',
   'returns': 'MigrationParameters' }
@@ -1381,8 +1381,8 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-start-postcopy" }
-# <- { "return": {} }
+#     -> { "execute": "migrate-start-postcopy" }
+#     <- { "return": {} }
 ##
 { 'command': 'migrate-start-postcopy' }
 
@@ -1397,9 +1397,9 @@
 #
 # Example:
 #
-# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
-#     "event": "MIGRATION",
-#     "data": {"status": "completed"} }
+#     <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#         "event": "MIGRATION",
+#         "data": {"status": "completed"} }
 ##
 { 'event': 'MIGRATION',
   'data': {'status': 'MigrationStatus'}}
@@ -1416,8 +1416,8 @@
 #
 # Example:
 #
-# <- { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
-#       "event": "MIGRATION_PASS", "data": {"pass": 2} }
+#     <- { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
+#           "event": "MIGRATION_PASS", "data": {"pass": 2} }
 ##
 { 'event': 'MIGRATION_PASS',
   'data': { 'pass': 'int' } }
@@ -1500,8 +1500,8 @@
 #
 # Example:
 #
-# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
-#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
+#     <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
+#          "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
 ##
 { 'event': 'COLO_EXIT',
   'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
@@ -1543,8 +1543,8 @@
 #
 # Example:
 #
-# -> { "execute": "x-colo-lost-heartbeat" }
-# <- { "return": {} }
+#     -> { "execute": "x-colo-lost-heartbeat" }
+#     <- { "return": {} }
 ##
 { 'command': 'x-colo-lost-heartbeat',
   'features': [ 'unstable' ],
@@ -1564,8 +1564,8 @@
 #
 # Example:
 #
-# -> { "execute": "migrate_cancel" }
-# <- { "return": {} }
+#     -> { "execute": "migrate_cancel" }
+#     <- { "return": {} }
 ##
 { 'command': 'migrate_cancel' }
 
@@ -1582,9 +1582,9 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-continue" , "arguments":
-#      { "state": "pre-switchover" } }
-# <- { "return": {} }
+#     -> { "execute": "migrate-continue" , "arguments":
+#          { "state": "pre-switchover" } }
+#     <- { "return": {} }
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
@@ -1726,40 +1726,40 @@
 #
 # Example:
 #
-# -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
-# <- { "return": {} }
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "socket",
-#                                    "type": "inet",
-#                                    "host": "10.12.34.9",
-#                                    "port": "1050" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
+#     <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "socket",
+#                                        "type": "inet",
+#                                        "host": "10.12.34.9",
+#                                        "port": "1050" } } ] } }
+#     <- { "return": {} }
 #
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "exec",
-#                                    "args": [ "/bin/nc", "-p", "6000",
-#                                              "/some/sock" ] } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "exec",
+#                                        "args": [ "/bin/nc", "-p", "6000",
+#                                                  "/some/sock" ] } } ] } }
+#     <- { "return": {} }
 #
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "rdma",
-#                                    "host": "10.12.34.9",
-#                                    "port": "1050" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "rdma",
+#                                        "host": "10.12.34.9",
+#                                        "port": "1050" } } ] } }
+#     <- { "return": {} }
 #
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "file",
-#                                    "filename": "/tmp/migfile",
-#                                    "offset": "0x1000" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "file",
+#                                        "filename": "/tmp/migfile",
+#                                        "offset": "0x1000" } } ] } }
+#     <- { "return": {} }
 #
 ##
 { 'command': 'migrate',
@@ -1804,34 +1804,34 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-incoming",
-#      "arguments": { "uri": "tcp::4446" } }
-# <- { "return": {} }
+#     -> { "execute": "migrate-incoming",
+#          "arguments": { "uri": "tcp::4446" } }
+#     <- { "return": {} }
 #
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "socket",
-#                                    "type": "inet",
-#                                    "host": "10.12.34.9",
-#                                    "port": "1050" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "socket",
+#                                        "type": "inet",
+#                                        "host": "10.12.34.9",
+#                                        "port": "1050" } } ] } }
+#     <- { "return": {} }
 #
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "exec",
-#                                    "args": [ "/bin/nc", "-p", "6000",
-#                                              "/some/sock" ] } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "exec",
+#                                        "args": [ "/bin/nc", "-p", "6000",
+#                                                  "/some/sock" ] } } ] } }
+#     <- { "return": {} }
 #
-# -> { "execute": "migrate",
-#      "arguments": {
-#          "channels": [ { "channel-type": "main",
-#                          "addr": { "transport": "rdma",
-#                                    "host": "10.12.34.9",
-#                                    "port": "1050" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "migrate",
+#          "arguments": {
+#              "channels": [ { "channel-type": "main",
+#                              "addr": { "transport": "rdma",
+#                                        "host": "10.12.34.9",
+#                                        "port": "1050" } } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
@@ -1856,9 +1856,9 @@
 #
 # Example:
 #
-# -> { "execute": "xen-save-devices-state",
-#      "arguments": { "filename": "/tmp/save" } }
-# <- { "return": {} }
+#     -> { "execute": "xen-save-devices-state",
+#          "arguments": { "filename": "/tmp/save" } }
+#     <- { "return": {} }
 ##
 { 'command': 'xen-save-devices-state',
   'data': {'filename': 'str', '*live':'bool' } }
@@ -1876,9 +1876,9 @@
 #
 # Example:
 #
-# -> { "execute": "xen-set-global-dirty-log",
-#      "arguments": { "enable": true } }
-# <- { "return": {} }
+#     -> { "execute": "xen-set-global-dirty-log",
+#          "arguments": { "enable": true } }
+#     <- { "return": {} }
 ##
 { 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
 
@@ -1896,9 +1896,9 @@
 #
 # Example:
 #
-# -> { "execute": "xen-load-devices-state",
-#      "arguments": { "filename": "/tmp/resume" } }
-# <- { "return": {} }
+#     -> { "execute": "xen-load-devices-state",
+#          "arguments": { "filename": "/tmp/resume" } }
+#     <- { "return": {} }
 ##
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
 
@@ -1918,9 +1918,9 @@
 #
 # Example:
 #
-# -> { "execute": "xen-set-replication",
-#      "arguments": {"enable": true, "primary": false} }
-# <- { "return": {} }
+#     -> { "execute": "xen-set-replication",
+#          "arguments": {"enable": true, "primary": false} }
+#     <- { "return": {} }
 #
 # Since: 2.9
 ##
@@ -1953,8 +1953,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-xen-replication-status" }
-# <- { "return": { "error": false } }
+#     -> { "execute": "query-xen-replication-status" }
+#     <- { "return": { "error": false } }
 #
 # Since: 2.9
 ##
@@ -1971,8 +1971,8 @@
 #
 # Example:
 #
-# -> { "execute": "xen-colo-do-checkpoint" }
-# <- { "return": {} }
+#     -> { "execute": "xen-colo-do-checkpoint" }
+#     <- { "return": {} }
 #
 # Since: 2.9
 ##
@@ -2009,8 +2009,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-colo-status" }
-# <- { "return": { "mode": "primary", "last-mode": "none", "reason": "request" } }
+#     -> { "execute": "query-colo-status" }
+#     <- { "return": { "mode": "primary", "last-mode": "none", "reason": "request" } }
 #
 # Since: 3.1
 ##
@@ -2029,9 +2029,9 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-recover",
-#      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
-# <- { "return": {} }
+#     -> { "execute": "migrate-recover",
+#          "arguments": { "uri": "tcp:192.168.1.200:12345" } }
+#     <- { "return": {} }
 #
 # Since: 3.0
 ##
@@ -2048,8 +2048,8 @@
 #
 # Example:
 #
-# -> { "execute": "migrate-pause" }
-# <- { "return": {} }
+#     -> { "execute": "migrate-pause" }
+#     <- { "return": {} }
 #
 # Since: 3.0
 ##
@@ -2069,9 +2069,9 @@
 #
 # Example:
 #
-# <- { "event": "UNPLUG_PRIMARY",
-#      "data": { "device-id": "hostdev0" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "UNPLUG_PRIMARY",
+#          "data": { "device-id": "hostdev0" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
@@ -2230,16 +2230,16 @@
 #
 # Example:
 #
-# -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
-#                                                 'sample-pages': 512} }
-# <- { "return": {} }
+#     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
+#                                                     'sample-pages': 512} }
+#     <- { "return": {} }
 #
-# Measure dirty rate using dirty bitmap for 500 milliseconds:
+#     Measure dirty rate using dirty bitmap for 500 milliseconds:
 #
-# -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
-#     "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
+#     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
+#         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
 #
-# <- { "return": {} }
+#     <- { "return": {} }
 ##
 { 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
                                          '*calc-time-unit': 'TimeUnit',
@@ -2258,17 +2258,17 @@
 #
 # Examples:
 #
-# 1. Measurement is in progress:
+#     1. Measurement is in progress:
 #
-# <- {"status": "measuring", "sample-pages": 512,
-#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
-#     "calc-time-unit": "second"}
+#     <- {"status": "measuring", "sample-pages": 512,
+#         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
+#         "calc-time-unit": "second"}
 #
-# 2. Measurement has been completed:
+#     2. Measurement has been completed:
 #
-# <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
-#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
-#     "calc-time-unit": "second"}
+#     <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
+#         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
+#         "calc-time-unit": "second"}
 ##
 { 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' },
                                  'returns': 'DirtyRateInfo' }
@@ -2309,10 +2309,10 @@
 #
 # Example:
 #
-# -> {"execute": "set-vcpu-dirty-limit"}
-#     "arguments": { "dirty-rate": 200,
-#                    "cpu-index": 1 } }
-# <- { "return": {} }
+#     -> {"execute": "set-vcpu-dirty-limit"}
+#         "arguments": { "dirty-rate": 200,
+#                        "cpu-index": 1 } }
+#     <- { "return": {} }
 ##
 { 'command': 'set-vcpu-dirty-limit',
   'data': { '*cpu-index': 'int',
@@ -2333,9 +2333,9 @@
 #
 # Example:
 #
-# -> {"execute": "cancel-vcpu-dirty-limit"},
-#     "arguments": { "cpu-index": 1 } }
-# <- { "return": {} }
+#     -> {"execute": "cancel-vcpu-dirty-limit"},
+#         "arguments": { "cpu-index": 1 } }
+#     <- { "return": {} }
 ##
 { 'command': 'cancel-vcpu-dirty-limit',
   'data': { '*cpu-index': 'int'} }
@@ -2350,10 +2350,10 @@
 #
 # Example:
 #
-# -> {"execute": "query-vcpu-dirty-limit"}
-# <- {"return": [
-#        { "limit-rate": 60, "current-rate": 3, "cpu-index": 0},
-#        { "limit-rate": 60, "current-rate": 3, "cpu-index": 1}]}
+#     -> {"execute": "query-vcpu-dirty-limit"}
+#     <- {"return": [
+#            { "limit-rate": 60, "current-rate": 3, "cpu-index": 0},
+#            { "limit-rate": 60, "current-rate": 3, "cpu-index": 1}]}
 ##
 { 'command': 'query-vcpu-dirty-limit',
   'returns': [ 'DirtyLimitInfo' ] }
@@ -2418,40 +2418,40 @@
 #
 # Example:
 #
-# -> { "execute": "snapshot-save",
-#      "arguments": {
-#         "job-id": "snapsave0",
-#         "tag": "my-snap",
-#         "vmstate": "disk0",
-#         "devices": ["disk0", "disk1"]
-#      }
-#    }
-# <- { "return": { } }
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1432121972, "microseconds": 744001},
-#     "data": {"status": "created", "id": "snapsave0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1432122172, "microseconds": 744001},
-#     "data": {"status": "running", "id": "snapsave0"}}
-# <- {"event": "STOP",
-#     "timestamp": {"seconds": 1432122372, "microseconds": 744001} }
-# <- {"event": "RESUME",
-#     "timestamp": {"seconds": 1432122572, "microseconds": 744001} }
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1432122772, "microseconds": 744001},
-#     "data": {"status": "waiting", "id": "snapsave0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1432122972, "microseconds": 744001},
-#     "data": {"status": "pending", "id": "snapsave0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1432123172, "microseconds": 744001},
-#     "data": {"status": "concluded", "id": "snapsave0"}}
-# -> {"execute": "query-jobs"}
-# <- {"return": [{"current-progress": 1,
-#                 "status": "concluded",
-#                 "total-progress": 1,
-#                 "type": "snapshot-save",
-#                 "id": "snapsave0"}]}
+#     -> { "execute": "snapshot-save",
+#          "arguments": {
+#             "job-id": "snapsave0",
+#             "tag": "my-snap",
+#             "vmstate": "disk0",
+#             "devices": ["disk0", "disk1"]
+#          }
+#        }
+#     <- { "return": { } }
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#         "data": {"status": "created", "id": "snapsave0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1432122172, "microseconds": 744001},
+#         "data": {"status": "running", "id": "snapsave0"}}
+#     <- {"event": "STOP",
+#         "timestamp": {"seconds": 1432122372, "microseconds": 744001} }
+#     <- {"event": "RESUME",
+#         "timestamp": {"seconds": 1432122572, "microseconds": 744001} }
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1432122772, "microseconds": 744001},
+#         "data": {"status": "waiting", "id": "snapsave0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1432122972, "microseconds": 744001},
+#         "data": {"status": "pending", "id": "snapsave0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1432123172, "microseconds": 744001},
+#         "data": {"status": "concluded", "id": "snapsave0"}}
+#     -> {"execute": "query-jobs"}
+#     <- {"return": [{"current-progress": 1,
+#                     "status": "concluded",
+#                     "total-progress": 1,
+#                     "type": "snapshot-save",
+#                     "id": "snapsave0"}]}
 #
 # Since: 6.0
 ##
@@ -2490,40 +2490,40 @@
 #
 # Example:
 #
-# -> { "execute": "snapshot-load",
-#      "arguments": {
-#         "job-id": "snapload0",
-#         "tag": "my-snap",
-#         "vmstate": "disk0",
-#         "devices": ["disk0", "disk1"]
-#      }
-#    }
-# <- { "return": { } }
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1472124172, "microseconds": 744001},
-#     "data": {"status": "created", "id": "snapload0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1472125172, "microseconds": 744001},
-#     "data": {"status": "running", "id": "snapload0"}}
-# <- {"event": "STOP",
-#     "timestamp": {"seconds": 1472125472, "microseconds": 744001} }
-# <- {"event": "RESUME",
-#     "timestamp": {"seconds": 1472125872, "microseconds": 744001} }
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1472126172, "microseconds": 744001},
-#     "data": {"status": "waiting", "id": "snapload0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1472127172, "microseconds": 744001},
-#     "data": {"status": "pending", "id": "snapload0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1472128172, "microseconds": 744001},
-#     "data": {"status": "concluded", "id": "snapload0"}}
-# -> {"execute": "query-jobs"}
-# <- {"return": [{"current-progress": 1,
-#                 "status": "concluded",
-#                 "total-progress": 1,
-#                 "type": "snapshot-load",
-#                 "id": "snapload0"}]}
+#     -> { "execute": "snapshot-load",
+#          "arguments": {
+#             "job-id": "snapload0",
+#             "tag": "my-snap",
+#             "vmstate": "disk0",
+#             "devices": ["disk0", "disk1"]
+#          }
+#        }
+#     <- { "return": { } }
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1472124172, "microseconds": 744001},
+#         "data": {"status": "created", "id": "snapload0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1472125172, "microseconds": 744001},
+#         "data": {"status": "running", "id": "snapload0"}}
+#     <- {"event": "STOP",
+#         "timestamp": {"seconds": 1472125472, "microseconds": 744001} }
+#     <- {"event": "RESUME",
+#         "timestamp": {"seconds": 1472125872, "microseconds": 744001} }
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1472126172, "microseconds": 744001},
+#         "data": {"status": "waiting", "id": "snapload0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1472127172, "microseconds": 744001},
+#         "data": {"status": "pending", "id": "snapload0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1472128172, "microseconds": 744001},
+#         "data": {"status": "concluded", "id": "snapload0"}}
+#     -> {"execute": "query-jobs"}
+#     <- {"return": [{"current-progress": 1,
+#                     "status": "concluded",
+#                     "total-progress": 1,
+#                     "type": "snapshot-load",
+#                     "id": "snapload0"}]}
 #
 # Since: 6.0
 ##
@@ -2553,35 +2553,35 @@
 #
 # Example:
 #
-# -> { "execute": "snapshot-delete",
-#      "arguments": {
-#         "job-id": "snapdelete0",
-#         "tag": "my-snap",
-#         "devices": ["disk0", "disk1"]
-#      }
-#    }
-# <- { "return": { } }
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1442124172, "microseconds": 744001},
-#     "data": {"status": "created", "id": "snapdelete0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1442125172, "microseconds": 744001},
-#     "data": {"status": "running", "id": "snapdelete0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1442126172, "microseconds": 744001},
-#     "data": {"status": "waiting", "id": "snapdelete0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1442127172, "microseconds": 744001},
-#     "data": {"status": "pending", "id": "snapdelete0"}}
-# <- {"event": "JOB_STATUS_CHANGE",
-#     "timestamp": {"seconds": 1442128172, "microseconds": 744001},
-#     "data": {"status": "concluded", "id": "snapdelete0"}}
-# -> {"execute": "query-jobs"}
-# <- {"return": [{"current-progress": 1,
-#                 "status": "concluded",
-#                 "total-progress": 1,
-#                 "type": "snapshot-delete",
-#                 "id": "snapdelete0"}]}
+#     -> { "execute": "snapshot-delete",
+#          "arguments": {
+#             "job-id": "snapdelete0",
+#             "tag": "my-snap",
+#             "devices": ["disk0", "disk1"]
+#          }
+#        }
+#     <- { "return": { } }
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1442124172, "microseconds": 744001},
+#         "data": {"status": "created", "id": "snapdelete0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1442125172, "microseconds": 744001},
+#         "data": {"status": "running", "id": "snapdelete0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1442126172, "microseconds": 744001},
+#         "data": {"status": "waiting", "id": "snapdelete0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1442127172, "microseconds": 744001},
+#         "data": {"status": "pending", "id": "snapdelete0"}}
+#     <- {"event": "JOB_STATUS_CHANGE",
+#         "timestamp": {"seconds": 1442128172, "microseconds": 744001},
+#         "data": {"status": "concluded", "id": "snapdelete0"}}
+#     -> {"execute": "query-jobs"}
+#     <- {"return": [{"current-progress": 1,
+#                     "status": "concluded",
+#                     "total-progress": 1,
+#                     "type": "snapshot-delete",
+#                     "id": "snapdelete0"}]}
 #
 # Since: 6.0
 ##
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 03e83c053f..542a3e42f2 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -13,8 +13,8 @@
 #
 # Example:
 #
-# -> { "execute": "rtc-reset-reinjection" }
-# <- { "return": {} }
+#     -> { "execute": "rtc-reset-reinjection" }
+#     <- { "return": {} }
 ##
 { 'command': 'rtc-reset-reinjection',
   'if': 'TARGET_I386' }
@@ -91,10 +91,10 @@
 #
 # Example:
 #
-# -> { "execute": "query-sev" }
-# <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
-#                  "build-id" : 0, "policy" : 0, "state" : "running",
-#                  "handle" : 1 } }
+#     -> { "execute": "query-sev" }
+#     <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
+#                      "build-id" : 0, "policy" : 0, "state" : "running",
+#                      "handle" : 1 } }
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo',
   'if': 'TARGET_I386' }
@@ -122,8 +122,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-sev-launch-measure" }
-# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+#     -> { "execute": "query-sev-launch-measure" }
+#     <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo',
   'if': 'TARGET_I386' }
@@ -167,10 +167,10 @@
 #
 # Example:
 #
-# -> { "execute": "query-sev-capabilities" }
-# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
-#                  "cpu0-id": "2lvmGwo+...61iEinw==",
-#                  "cbitpos": 47, "reduced-phys-bits": 1}}
+#     -> { "execute": "query-sev-capabilities" }
+#     <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
+#                      "cpu0-id": "2lvmGwo+...61iEinw==",
+#                      "cbitpos": 47, "reduced-phys-bits": 1}}
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
   'if': 'TARGET_I386' }
@@ -221,9 +221,9 @@
 #
 # Example:
 #
-# -> { "execute" : "query-sev-attestation-report",
-#                  "arguments": { "mnonce": "aaaaaaa" } }
-# <- { "return" : { "data": "aaaaaaaabbbddddd"} }
+#     -> { "execute" : "query-sev-attestation-report",
+#                      "arguments": { "mnonce": "aaaaaaa" } }
+#     <- { "return" : { "data": "aaaaaaaabbbddddd"} }
 ##
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
@@ -241,9 +241,9 @@
 #
 # Example:
 #
-# -> { "execute": "dump-skeys",
-#      "arguments": { "filename": "/tmp/skeys" } }
-# <- { "return": {} }
+#     -> { "execute": "dump-skeys",
+#          "arguments": { "filename": "/tmp/skeys" } }
+#     <- { "return": {} }
 ##
 { 'command': 'dump-skeys',
   'data': { 'filename': 'str' },
@@ -286,9 +286,9 @@
 #
 # Example:
 #
-# -> { "execute": "query-gic-capabilities" }
-# <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
-#                 { "version": 3, "emulated": false, "kernel": true } ] }
+#     -> { "execute": "query-gic-capabilities" }
+#     <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
+#                     { "version": 3, "emulated": false, "kernel": true } ] }
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
   'if': 'TARGET_ARM' }
@@ -344,11 +344,11 @@
 #
 # Example:
 #
-# -> { "execute": "query-sgx" }
-# <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
-#                  "flc": true,
-#                  "sections": [{"node": 0, "size": 67108864},
-#                  {"node": 1, "size": 29360128}]} }
+#     -> { "execute": "query-sgx" }
+#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
+#                      "flc": true,
+#                      "sections": [{"node": 0, "size": 67108864},
+#                      {"node": 1, "size": 29360128}]} }
 ##
 { 'command': 'query-sgx', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
 
@@ -363,11 +363,11 @@
 #
 # Example:
 #
-# -> { "execute": "query-sgx-capabilities" }
-# <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
-#                  "flc": true,
-#                  "section" : [{"node": 0, "size": 67108864},
-#                  {"node": 1, "size": 29360128}]} }
+#     -> { "execute": "query-sgx-capabilities" }
+#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
+#                      "flc": true,
+#                      "section" : [{"node": 0, "size": 67108864},
+#                      {"node": 1, "size": 29360128}]} }
 ##
 { 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
 
@@ -438,28 +438,28 @@
 #
 # Example:
 #
-# -> { "execute": "xen-event-list" }
-# <- { "return": [
-#         {
-#             "pending": false,
-#             "port": 1,
-#             "vcpu": 1,
-#             "remote-domain": "qemu",
-#             "masked": false,
-#             "type": "interdomain",
-#             "target": 1
-#         },
-#         {
-#             "pending": false,
-#             "port": 2,
-#             "vcpu": 0,
-#             "remote-domain": "",
-#             "masked": false,
-#             "type": "virq",
-#             "target": 0
-#         }
-#      ]
-#    }
+#     -> { "execute": "xen-event-list" }
+#     <- { "return": [
+#             {
+#                 "pending": false,
+#                 "port": 1,
+#                 "vcpu": 1,
+#                 "remote-domain": "qemu",
+#                 "masked": false,
+#                 "type": "interdomain",
+#                 "target": 1
+#             },
+#             {
+#                 "pending": false,
+#                 "port": 2,
+#                 "vcpu": 0,
+#                 "remote-domain": "",
+#                 "masked": false,
+#                 "type": "virq",
+#                 "target": 0
+#             }
+#          ]
+#        }
 ##
 { 'command': 'xen-event-list',
   'returns': ['EvtchnInfo'],
@@ -479,8 +479,8 @@
 #
 # Example:
 #
-# -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
-# <- { "return": { } }
+#     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
+#     <- { "return": { } }
 ##
 { 'command': 'xen-event-inject',
   'data': { 'port': 'uint32' },
diff --git a/qapi/misc.json b/qapi/misc.json
index 4108a0c951..11c55c2b6c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -34,9 +34,9 @@
 #
 # Example:
 #
-# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
-#                                              "fdname": "myclient" } }
-# <- { "return": {} }
+#         -> { "execute": "add_client", "arguments": { "protocol": "vnc",
+#                                                      "fdname": "myclient" } }
+#         <- { "return": {} }
 ##
 { 'command': 'add_client',
   'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
@@ -64,8 +64,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-name" }
-# <- { "return": { "name": "qemu-name" } }
+#     -> { "execute": "query-name" }
+#     <- { "return": { "name": "qemu-name" } }
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
@@ -115,18 +115,18 @@
 #
 # Example:
 #
-# -> { "execute": "query-iothreads" }
-# <- { "return": [
-#          {
-#             "id":"iothread0",
-#             "thread-id":3134
-#          },
-#          {
-#             "id":"iothread1",
-#             "thread-id":3135
-#          }
-#       ]
-#    }
+#     -> { "execute": "query-iothreads" }
+#     <- { "return": [
+#              {
+#                 "id":"iothread0",
+#                 "thread-id":3134
+#              },
+#              {
+#                 "id":"iothread1",
+#                 "thread-id":3135
+#              }
+#           ]
+#        }
 ##
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
@@ -148,8 +148,8 @@
 #
 # Example:
 #
-# -> { "execute": "stop" }
-# <- { "return": {} }
+#     -> { "execute": "stop" }
+#     <- { "return": {} }
 ##
 { 'command': 'stop' }
 
@@ -174,8 +174,8 @@
 #
 # Example:
 #
-# -> { "execute": "cont" }
-# <- { "return": {} }
+#     -> { "execute": "cont" }
+#     <- { "return": {} }
 ##
 { 'command': 'cont' }
 
@@ -200,8 +200,8 @@
 #
 # Example:
 #
-# -> { "execute": "x-exit-preconfig" }
-# <- { "return": {} }
+#     -> { "execute": "x-exit-preconfig" }
+#     <- { "return": {} }
 ##
 { 'command': 'x-exit-preconfig', 'allow-preconfig': true,
   'features': [ 'unstable' ] }
@@ -240,9 +240,9 @@
 #
 # Example:
 #
-# -> { "execute": "human-monitor-command",
-#      "arguments": { "command-line": "info kvm" } }
-# <- { "return": "kvm support: enabled\r\n" }
+#     -> { "execute": "human-monitor-command",
+#          "arguments": { "command-line": "info kvm" } }
+#     <- { "return": "kvm support: enabled\r\n" }
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
@@ -268,8 +268,8 @@
 #
 # Example:
 #
-# -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
-# <- { "return": {} }
+#     -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
+#     <- { "return": {} }
 ##
 { 'command': 'getfd', 'data': {'fdname': 'str'}, 'if': 'CONFIG_POSIX' }
 
@@ -297,8 +297,8 @@
 #
 # Example:
 #
-# -> { "execute": "get-win32-socket", "arguments": { "info": "abcd123..", fdname": "skclient" } }
-# <- { "return": {} }
+#     -> { "execute": "get-win32-socket", "arguments": { "info": "abcd123..", fdname": "skclient" } }
+#     <- { "return": {} }
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
 
@@ -315,8 +315,8 @@
 #
 # Example:
 #
-# -> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
-# <- { "return": {} }
+#     -> { "execute": "closefd", "arguments": { "fdname": "fd1" } }
+#     <- { "return": {} }
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
@@ -357,8 +357,8 @@
 #
 # Example:
 #
-# -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
-# <- { "return": { "fdset-id": 1, "fd": 3 } }
+#     -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
+#     <- { "return": { "fdset-id": 1, "fd": 3 } }
 ##
 { 'command': 'add-fd',
   'data': { '*fdset-id': 'int',
@@ -388,8 +388,8 @@
 #
 # Example:
 #
-# -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
-# <- { "return": {} }
+#     -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
+#     <- { "return": {} }
 ##
 { 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
 
@@ -434,34 +434,34 @@
 #
 # Example:
 #
-# -> { "execute": "query-fdsets" }
-# <- { "return": [
-#        {
-#          "fds": [
+#     -> { "execute": "query-fdsets" }
+#     <- { "return": [
 #            {
-#              "fd": 30,
-#              "opaque": "rdonly:/path/to/file"
+#              "fds": [
+#                {
+#                  "fd": 30,
+#                  "opaque": "rdonly:/path/to/file"
+#                },
+#                {
+#                  "fd": 24,
+#                  "opaque": "rdwr:/path/to/file"
+#                }
+#              ],
+#              "fdset-id": 1
 #            },
 #            {
-#              "fd": 24,
-#              "opaque": "rdwr:/path/to/file"
+#              "fds": [
+#                {
+#                  "fd": 28
+#                },
+#                {
+#                  "fd": 29
+#                }
+#              ],
+#              "fdset-id": 0
 #            }
-#          ],
-#          "fdset-id": 1
-#        },
-#        {
-#          "fds": [
-#            {
-#              "fd": 28
-#            },
-#            {
-#              "fd": 29
-#            }
-#          ],
-#          "fdset-id": 0
+#          ]
 #        }
-#      ]
-#    }
 ##
 { 'command': 'query-fdsets', 'returns': ['FdsetInfo'] }
 
@@ -535,24 +535,24 @@
 #
 # Example:
 #
-# -> { "execute": "query-command-line-options",
-#      "arguments": { "option": "option-rom" } }
-# <- { "return": [
-#         {
-#             "parameters": [
-#                 {
-#                     "name": "romfile",
-#                     "type": "string"
-#                 },
-#                 {
-#                     "name": "bootindex",
-#                     "type": "number"
-#                 }
-#             ],
-#             "option": "option-rom"
-#         }
-#      ]
-#    }
+#     -> { "execute": "query-command-line-options",
+#          "arguments": { "option": "option-rom" } }
+#     <- { "return": [
+#             {
+#                 "parameters": [
+#                     {
+#                         "name": "romfile",
+#                         "type": "string"
+#                     },
+#                     {
+#                         "name": "bootindex",
+#                         "type": "number"
+#                     }
+#                 ],
+#                 "option": "option-rom"
+#             }
+#          ]
+#        }
 ##
 {'command': 'query-command-line-options',
  'data': {'*option': 'str'},
@@ -577,9 +577,9 @@
 #
 # Example:
 #
-# <- { "event": "RTC_CHANGE",
-#      "data": { "offset": 78 },
-#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#     <- { "event": "RTC_CHANGE",
+#          "data": { "offset": 78 },
+#          "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
 ##
 { 'event': 'RTC_CHANGE',
   'data': { 'offset': 'int', 'qom-path': 'str' } }
@@ -604,12 +604,12 @@
 #
 # Example:
 #
-# <- { "event": "VFU_CLIENT_HANGUP",
-#      "data": { "vfu-id": "vfu1",
-#                "vfu-qom-path": "/objects/vfu1",
-#                "dev-id": "sas1",
-#                "dev-qom-path": "/machine/peripheral/sas1" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "VFU_CLIENT_HANGUP",
+#          "data": { "vfu-id": "vfu1",
+#                    "vfu-qom-path": "/objects/vfu1",
+#                    "dev-id": "sas1",
+#                    "dev-qom-path": "/machine/peripheral/sas1" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'VFU_CLIENT_HANGUP',
   'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
diff --git a/qapi/net.json b/qapi/net.json
index 0a993e1a3d..1374caac64 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -29,9 +29,9 @@
 #
 # Example:
 #
-# -> { "execute": "set_link",
-#      "arguments": { "name": "e1000.0", "up": false } }
-# <- { "return": {} }
+#     -> { "execute": "set_link",
+#          "arguments": { "name": "e1000.0", "up": false } }
+#     <- { "return": {} }
 ##
 { 'command': 'set_link', 'data': {'name': 'str', 'up': 'bool'} }
 
@@ -50,10 +50,10 @@
 #
 # Example:
 #
-# -> { "execute": "netdev_add",
-#      "arguments": { "type": "user", "id": "netdev1",
-#                     "dnssearch": [ { "str": "example.org" } ] } }
-# <- { "return": {} }
+#     -> { "execute": "netdev_add",
+#          "arguments": { "type": "user", "id": "netdev1",
+#                         "dnssearch": [ { "str": "example.org" } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'netdev_add', 'data': 'Netdev', 'boxed': true,
   'allow-preconfig': true }
@@ -73,8 +73,8 @@
 #
 # Example:
 #
-# -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
-# <- { "return": {} }
+#     -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
+#     <- { "return": {} }
 ##
 { 'command': 'netdev_del', 'data': {'id': 'str'},
   'allow-preconfig': true }
@@ -836,32 +836,32 @@
 #
 # Example:
 #
-# -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
-# <- { "return": [
-#         {
-#             "promiscuous": true,
-#             "name": "vnet0",
-#             "main-mac": "52:54:00:12:34:56",
-#             "unicast": "normal",
-#             "vlan": "normal",
-#             "vlan-table": [
-#                 4,
-#                 0
-#             ],
-#             "unicast-table": [
-#             ],
-#             "multicast": "normal",
-#             "multicast-overflow": false,
-#             "unicast-overflow": false,
-#             "multicast-table": [
-#                 "01:00:5e:00:00:01",
-#                 "33:33:00:00:00:01",
-#                 "33:33:ff:12:34:56"
-#             ],
-#             "broadcast-allowed": false
-#         }
-#       ]
-#    }
+#     -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
+#     <- { "return": [
+#             {
+#                 "promiscuous": true,
+#                 "name": "vnet0",
+#                 "main-mac": "52:54:00:12:34:56",
+#                 "unicast": "normal",
+#                 "vlan": "normal",
+#                 "vlan-table": [
+#                     4,
+#                     0
+#                 ],
+#                 "unicast-table": [
+#                 ],
+#                 "multicast": "normal",
+#                 "multicast-overflow": false,
+#                 "unicast-overflow": false,
+#                 "multicast-table": [
+#                     "01:00:5e:00:00:01",
+#                     "33:33:00:00:00:01",
+#                     "33:33:ff:12:34:56"
+#                 ],
+#                 "broadcast-allowed": false
+#             }
+#           ]
+#        }
 ##
 { 'command': 'query-rx-filter',
   'data': { '*name': 'str' },
@@ -881,10 +881,10 @@
 #
 # Example:
 #
-# <- { "event": "NIC_RX_FILTER_CHANGED",
-#      "data": { "name": "vnet0",
-#                "path": "/machine/peripheral/vnet0/virtio-backend" },
-#      "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#     <- { "event": "NIC_RX_FILTER_CHANGED",
+#          "data": { "name": "vnet0",
+#                    "path": "/machine/peripheral/vnet0/virtio-backend" },
+#          "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
@@ -930,11 +930,11 @@
 #
 # Example:
 #
-# -> { "execute": "announce-self",
-#      "arguments": {
-#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
-#          "interfaces": ["vn2", "vn3"], "id": "bob" } }
-# <- { "return": {} }
+#     -> { "execute": "announce-self",
+#          "arguments": {
+#              "initial": 50, "max": 550, "rounds": 10, "step": 50,
+#              "interfaces": ["vn2", "vn3"], "id": "bob" } }
+#     <- { "return": {} }
 #
 # Since: 4.0
 ##
@@ -955,9 +955,9 @@
 #
 # Example:
 #
-# <- { "event": "FAILOVER_NEGOTIATED",
-#      "data": { "device-id": "net1" },
-#      "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#     <- { "event": "FAILOVER_NEGOTIATED",
+#          "data": { "device-id": "net1" },
+#          "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
 ##
 { 'event': 'FAILOVER_NEGOTIATED',
   'data': {'device-id': 'str'} }
@@ -975,16 +975,16 @@
 #
 # Examples:
 #
-# <- { "event": "NETDEV_STREAM_CONNECTED",
-#      "data": { "netdev-id": "netdev0",
-#                "addr": { "port": "47666", "ipv6": true,
-#                          "host": "::1", "type": "inet" } },
-#      "timestamp": { "seconds": 1666269863, "microseconds": 311222 } }
+#     <- { "event": "NETDEV_STREAM_CONNECTED",
+#          "data": { "netdev-id": "netdev0",
+#                    "addr": { "port": "47666", "ipv6": true,
+#                              "host": "::1", "type": "inet" } },
+#          "timestamp": { "seconds": 1666269863, "microseconds": 311222 } }
 #
-# <- { "event": "NETDEV_STREAM_CONNECTED",
-#      "data": { "netdev-id": "netdev0",
-#                "addr": { "path": "/tmp/qemu0", "type": "unix" } },
-#      "timestamp": { "seconds": 1666269706, "microseconds": 413651 } }
+#     <- { "event": "NETDEV_STREAM_CONNECTED",
+#          "data": { "netdev-id": "netdev0",
+#                    "addr": { "path": "/tmp/qemu0", "type": "unix" } },
+#          "timestamp": { "seconds": 1666269706, "microseconds": 413651 } }
 ##
 { 'event': 'NETDEV_STREAM_CONNECTED',
   'data': { 'netdev-id': 'str',
@@ -1001,9 +1001,9 @@
 #
 # Example:
 #
-# <- { 'event': 'NETDEV_STREAM_DISCONNECTED',
-#      'data': {'netdev-id': 'netdev0'},
-#      'timestamp': {'seconds': 1663330937, 'microseconds': 526695} }
+#     <- { 'event': 'NETDEV_STREAM_DISCONNECTED',
+#          'data': {'netdev-id': 'netdev0'},
+#          'timestamp': {'seconds': 1663330937, 'microseconds': 526695} }
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
diff --git a/qapi/pci.json b/qapi/pci.json
index 086c773052..08bf695863 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -184,132 +184,132 @@
 #
 # Example:
 #
-# -> { "execute": "query-pci" }
-# <- { "return": [
-#          {
-#             "bus": 0,
-#             "devices": [
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 0,
-#                   "class_info": {
-#                      "class": 1536,
-#                      "desc": "Host bridge"
-#                   },
-#                   "id": {
-#                      "device": 32902,
-#                      "vendor": 4663
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 1,
-#                   "class_info": {
-#                      "class": 1537,
-#                      "desc": "ISA bridge"
-#                   },
-#                   "id": {
-#                      "device": 32902,
-#                      "vendor": 28672
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 1,
-#                   "class_info": {
-#                      "class": 257,
-#                      "desc": "IDE controller"
-#                   },
-#                   "id": {
-#                      "device": 32902,
-#                      "vendor": 28688
-#                   },
-#                   "function": 1,
-#                   "regions": [
-#                      {
-#                         "bar": 4,
-#                         "size": 16,
-#                         "address": 49152,
-#                         "type": "io"
-#                      }
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "slot": 2,
-#                   "class_info": {
-#                      "class": 768,
-#                      "desc": "VGA controller"
-#                   },
-#                   "id": {
-#                      "device": 4115,
-#                      "vendor": 184
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                      {
-#                         "prefetch": true,
-#                         "mem_type_64": false,
-#                         "bar": 0,
-#                         "size": 33554432,
-#                         "address": 4026531840,
-#                         "type": "memory"
-#                      },
-#                      {
-#                         "prefetch": false,
-#                         "mem_type_64": false,
-#                         "bar": 1,
-#                         "size": 4096,
-#                         "address": 4060086272,
-#                         "type": "memory"
-#                      },
-#                      {
-#                         "prefetch": false,
-#                         "mem_type_64": false,
-#                         "bar": 6,
-#                         "size": 65536,
-#                         "address": -1,
-#                         "type": "memory"
-#                      }
-#                   ]
-#                },
-#                {
-#                   "bus": 0,
-#                   "qdev_id": "",
-#                   "irq": 11,
-#                   "slot": 4,
-#                   "class_info": {
-#                      "class": 1280,
-#                      "desc": "RAM controller"
-#                   },
-#                   "id": {
-#                      "device": 6900,
-#                      "vendor": 4098
-#                   },
-#                   "function": 0,
-#                   "regions": [
-#                      {
-#                         "bar": 0,
-#                         "size": 32,
-#                         "address": 49280,
-#                         "type": "io"
-#                      }
-#                   ]
-#                }
-#             ]
-#          }
-#       ]
-#    }
+#     -> { "execute": "query-pci" }
+#     <- { "return": [
+#              {
+#                 "bus": 0,
+#                 "devices": [
+#                    {
+#                       "bus": 0,
+#                       "qdev_id": "",
+#                       "slot": 0,
+#                       "class_info": {
+#                          "class": 1536,
+#                          "desc": "Host bridge"
+#                       },
+#                       "id": {
+#                          "device": 32902,
+#                          "vendor": 4663
+#                       },
+#                       "function": 0,
+#                       "regions": [
+#                       ]
+#                    },
+#                    {
+#                       "bus": 0,
+#                       "qdev_id": "",
+#                       "slot": 1,
+#                       "class_info": {
+#                          "class": 1537,
+#                          "desc": "ISA bridge"
+#                       },
+#                       "id": {
+#                          "device": 32902,
+#                          "vendor": 28672
+#                       },
+#                       "function": 0,
+#                       "regions": [
+#                       ]
+#                    },
+#                    {
+#                       "bus": 0,
+#                       "qdev_id": "",
+#                       "slot": 1,
+#                       "class_info": {
+#                          "class": 257,
+#                          "desc": "IDE controller"
+#                       },
+#                       "id": {
+#                          "device": 32902,
+#                          "vendor": 28688
+#                       },
+#                       "function": 1,
+#                       "regions": [
+#                          {
+#                             "bar": 4,
+#                             "size": 16,
+#                             "address": 49152,
+#                             "type": "io"
+#                          }
+#                       ]
+#                    },
+#                    {
+#                       "bus": 0,
+#                       "qdev_id": "",
+#                       "slot": 2,
+#                       "class_info": {
+#                          "class": 768,
+#                          "desc": "VGA controller"
+#                       },
+#                       "id": {
+#                          "device": 4115,
+#                          "vendor": 184
+#                       },
+#                       "function": 0,
+#                       "regions": [
+#                          {
+#                             "prefetch": true,
+#                             "mem_type_64": false,
+#                             "bar": 0,
+#                             "size": 33554432,
+#                             "address": 4026531840,
+#                             "type": "memory"
+#                          },
+#                          {
+#                             "prefetch": false,
+#                             "mem_type_64": false,
+#                             "bar": 1,
+#                             "size": 4096,
+#                             "address": 4060086272,
+#                             "type": "memory"
+#                          },
+#                          {
+#                             "prefetch": false,
+#                             "mem_type_64": false,
+#                             "bar": 6,
+#                             "size": 65536,
+#                             "address": -1,
+#                             "type": "memory"
+#                          }
+#                       ]
+#                    },
+#                    {
+#                       "bus": 0,
+#                       "qdev_id": "",
+#                       "irq": 11,
+#                       "slot": 4,
+#                       "class_info": {
+#                          "class": 1280,
+#                          "desc": "RAM controller"
+#                       },
+#                       "id": {
+#                          "device": 6900,
+#                          "vendor": 4098
+#                       },
+#                       "function": 0,
+#                       "regions": [
+#                          {
+#                             "bar": 0,
+#                             "size": 32,
+#                             "address": 49280,
+#                             "type": "io"
+#                          }
+#                       ]
+#                    }
+#                 ]
+#              }
+#           ]
+#        }
 #
 # Note: This example has been shortened as the real response is too
 #     long.
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 3b3ccfa413..32ffaee644 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -64,11 +64,11 @@
 #
 # Example:
 #
-# -> { "execute": "device_add",
-#      "arguments": { "driver": "e1000", "id": "net1",
-#                     "bus": "pci.0",
-#                     "mac": "52:54:00:12:34:56" } }
-# <- { "return": {} }
+#     -> { "execute": "device_add",
+#          "arguments": { "driver": "e1000", "id": "net1",
+#                         "bus": "pci.0",
+#                         "mac": "52:54:00:12:34:56" } }
+#     <- { "return": {} }
 #
 # TODO: This command effectively bypasses QAPI completely due to its
 #     "additional arguments" business.  It shouldn't have been added
@@ -107,13 +107,13 @@
 #
 # Examples:
 #
-# -> { "execute": "device_del",
-#      "arguments": { "id": "net1" } }
-# <- { "return": {} }
+#     -> { "execute": "device_del",
+#          "arguments": { "id": "net1" } }
+#     <- { "return": {} }
 #
-# -> { "execute": "device_del",
-#      "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
-# <- { "return": {} }
+#     -> { "execute": "device_del",
+#          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
+#     <- { "return": {} }
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
 
@@ -133,10 +133,10 @@
 #
 # Example:
 #
-# <- { "event": "DEVICE_DELETED",
-#      "data": { "device": "virtio-net-pci-0",
-#                "path": "/machine/peripheral/virtio-net-pci-0" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#     <- { "event": "DEVICE_DELETED",
+#          "data": { "device": "virtio-net-pci-0",
+#                    "path": "/machine/peripheral/virtio-net-pci-0" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'DEVICE_DELETED',
   'data': { '*device': 'str', 'path': 'str' } }
@@ -155,10 +155,10 @@
 #
 # Example:
 #
-# <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
-#      "data": { "device": "core1",
-#                "path": "/machine/peripheral/core1" },
-#      "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
+#     <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
+#          "data": { "device": "core1",
+#                    "path": "/machine/peripheral/core1" },
+#          "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
diff --git a/qapi/qom.json b/qapi/qom.json
index 84af23fe24..2a6e49365a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -61,12 +61,12 @@
 #
 # Example:
 #
-# -> { "execute": "qom-list",
-#      "arguments": { "path": "/chardevs" } }
-# <- { "return": [ { "name": "type", "type": "string" },
-#                  { "name": "parallel0", "type": "child<chardev-vc>" },
-#                  { "name": "serial0", "type": "child<chardev-vc>" },
-#                  { "name": "mon0", "type": "child<chardev-stdio>" } ] }
+#     -> { "execute": "qom-list",
+#          "arguments": { "path": "/chardevs" } }
+#     <- { "return": [ { "name": "type", "type": "string" },
+#                      { "name": "parallel0", "type": "child<chardev-vc>" },
+#                      { "name": "serial0", "type": "child<chardev-vc>" },
+#                      { "name": "mon0", "type": "child<chardev-stdio>" } ] }
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
@@ -106,19 +106,19 @@
 #
 # Examples:
 #
-# 1. Use absolute path
+#     1. Use absolute path
 #
-# -> { "execute": "qom-get",
-#      "arguments": { "path": "/machine/unattached/device[0]",
-#                     "property": "hotplugged" } }
-# <- { "return": false }
+#     -> { "execute": "qom-get",
+#          "arguments": { "path": "/machine/unattached/device[0]",
+#                         "property": "hotplugged" } }
+#     <- { "return": false }
 #
-# 2. Use partial path
+#     2. Use partial path
 #
-# -> { "execute": "qom-get",
-#      "arguments": { "path": "unattached/sysbus",
-#                     "property": "type" } }
-# <- { "return": "System" }
+#     -> { "execute": "qom-get",
+#          "arguments": { "path": "unattached/sysbus",
+#                         "property": "type" } }
+#     <- { "return": "System" }
 ##
 { 'command': 'qom-get',
   'data': { 'path': 'str', 'property': 'str' },
@@ -141,11 +141,11 @@
 #
 # Example:
 #
-# -> { "execute": "qom-set",
-#      "arguments": { "path": "/machine",
-#                     "property": "graphics",
-#                     "value": false } }
-# <- { "return": {} }
+#     -> { "execute": "qom-set",
+#          "arguments": { "path": "/machine",
+#                         "property": "graphics",
+#                         "value": false } }
+#     <- { "return": {} }
 ##
 { 'command': 'qom-set',
   'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
@@ -1064,10 +1064,10 @@
 #
 # Example:
 #
-# -> { "execute": "object-add",
-#      "arguments": { "qom-type": "rng-random", "id": "rng1",
-#                     "filename": "/dev/hwrng" } }
-# <- { "return": {} }
+#     -> { "execute": "object-add",
+#          "arguments": { "qom-type": "rng-random", "id": "rng1",
+#                         "filename": "/dev/hwrng" } }
+#     <- { "return": {} }
 ##
 { 'command': 'object-add', 'data': 'ObjectOptions', 'boxed': true,
   'allow-preconfig': true }
@@ -1087,8 +1087,8 @@
 #
 # Example:
 #
-# -> { "execute": "object-del", "arguments": { "id": "rng1" } }
-# <- { "return": {} }
+#     -> { "execute": "object-del", "arguments": { "id": "rng1" } }
+#     <- { "return": {} }
 ##
 { 'command': 'object-del', 'data': {'id': 'str'},
   'allow-preconfig': true }
diff --git a/qapi/rdma.json b/qapi/rdma.json
index 23ebcf7885..195c001850 100644
--- a/qapi/rdma.json
+++ b/qapi/rdma.json
@@ -23,13 +23,13 @@
 #
 # Example:
 #
-# <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
-#     "event": "RDMA_GID_STATUS_CHANGED",
-#     "data":
-#         {"netdev": "bridge0",
-#         "interface-id": 15880512517475447892,
-#         "gid-status": true,
-#         "subnet-prefix": 33022}}
+#     <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
+#         "event": "RDMA_GID_STATUS_CHANGED",
+#         "data":
+#             {"netdev": "bridge0",
+#             "interface-id": 15880512517475447892,
+#             "gid-status": true,
+#             "subnet-prefix": 33022}}
 ##
 { 'event': 'RDMA_GID_STATUS_CHANGED',
   'data': { 'netdev'        : 'str',
diff --git a/qapi/replay.json b/qapi/replay.json
index 289b2d3658..8626fb58f4 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -56,8 +56,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-replay" }
-# <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#     -> { "execute": "query-replay" }
+#     <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
 ##
 { 'command': 'query-replay',
   'returns': 'ReplayInfo' }
@@ -78,8 +78,8 @@
 #
 # Example:
 #
-# -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
-# <- { "return": {} }
+#     -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
+#     <- { "return": {} }
 ##
 { 'command': 'replay-break', 'data': { 'icount': 'int' } }
 
@@ -93,8 +93,8 @@
 #
 # Example:
 #
-# -> { "execute": "replay-delete-break" }
-# <- { "return": {} }
+#     -> { "execute": "replay-delete-break" }
+#     <- { "return": {} }
 ##
 { 'command': 'replay-delete-break' }
 
@@ -114,7 +114,7 @@
 #
 # Example:
 #
-# -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
-# <- { "return": {} }
+#     -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
+#     <- { "return": {} }
 ##
 { 'command': 'replay-seek', 'data': { 'icount': 'int' } }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 31ce0b36f6..5635cf174f 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -32,8 +32,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
-# <- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
+#     -> { "execute": "query-rocker", "arguments": { "name": "sw1" } }
+#     <- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
 ##
 { 'command': 'query-rocker',
   'data': { 'name': 'str' },
@@ -100,12 +100,12 @@
 #
 # Example:
 #
-# -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
-# <- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
-#                   "autoneg": "off", "link-up": true, "speed": 10000},
-#                  {"duplex": "full", "enabled": true, "name": "sw1.2",
-#                   "autoneg": "off", "link-up": true, "speed": 10000}
-#    ]}
+#     -> { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
+#     <- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
+#                       "autoneg": "off", "link-up": true, "speed": 10000},
+#                      {"duplex": "full", "enabled": true, "name": "sw1.2",
+#                       "autoneg": "off", "link-up": true, "speed": 10000}
+#        ]}
 ##
 { 'command': 'query-rocker-ports',
   'data': { 'name': 'str' },
@@ -242,16 +242,16 @@
 #
 # Example:
 #
-# -> { "execute": "query-rocker-of-dpa-flows",
-#      "arguments": { "name": "sw1" } }
-# <- { "return": [ {"key": {"in-pport": 0, "priority": 1, "tbl-id": 0},
-#                   "hits": 138,
-#                   "cookie": 0,
-#                   "action": {"goto-tbl": 10},
-#                   "mask": {"in-pport": 4294901760}
-#                  },
-#                  {...more...},
-#    ]}
+#     -> { "execute": "query-rocker-of-dpa-flows",
+#          "arguments": { "name": "sw1" } }
+#     <- { "return": [ {"key": {"in-pport": 0, "priority": 1, "tbl-id": 0},
+#                       "hits": 138,
+#                       "cookie": 0,
+#                       "action": {"goto-tbl": 10},
+#                       "mask": {"in-pport": 4294901760}
+#                      },
+#                      {...more...},
+#        ]}
 ##
 { 'command': 'query-rocker-of-dpa-flows',
   'data': { 'name': 'str', '*tbl-id': 'uint32' },
@@ -317,21 +317,21 @@
 #
 # Example:
 #
-# -> { "execute": "query-rocker-of-dpa-groups",
-#      "arguments": { "name": "sw1" } }
-# <- { "return": [ {"type": 0, "out-pport": 2,
-#                   "pport": 2, "vlan-id": 3841,
-#                   "pop-vlan": 1, "id": 251723778},
-#                  {"type": 0, "out-pport": 0,
-#                   "pport": 0, "vlan-id": 3841,
-#                   "pop-vlan": 1, "id": 251723776},
-#                  {"type": 0, "out-pport": 1,
-#                   "pport": 1, "vlan-id": 3840,
-#                   "pop-vlan": 1, "id": 251658241},
-#                  {"type": 0, "out-pport": 0,
-#                   "pport": 0, "vlan-id": 3840,
-#                   "pop-vlan": 1, "id": 251658240}
-#    ]}
+#     -> { "execute": "query-rocker-of-dpa-groups",
+#          "arguments": { "name": "sw1" } }
+#     <- { "return": [ {"type": 0, "out-pport": 2,
+#                       "pport": 2, "vlan-id": 3841,
+#                       "pop-vlan": 1, "id": 251723778},
+#                      {"type": 0, "out-pport": 0,
+#                       "pport": 0, "vlan-id": 3841,
+#                       "pop-vlan": 1, "id": 251723776},
+#                      {"type": 0, "out-pport": 1,
+#                       "pport": 1, "vlan-id": 3840,
+#                       "pop-vlan": 1, "id": 251658241},
+#                      {"type": 0, "out-pport": 0,
+#                       "pport": 0, "vlan-id": 3840,
+#                       "pop-vlan": 1, "id": 251658240}
+#        ]}
 ##
 { 'command': 'query-rocker-of-dpa-groups',
   'data': { 'name': 'str', '*type': 'uint8' },
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 08bc99cb85..d19d23a0fd 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -128,9 +128,9 @@
 #
 # Example:
 #
-# -> { "execute": "query-status" }
-# <- { "return": { "running": true,
-#                  "status": "running" } }
+#     -> { "execute": "query-status" }
+#     <- { "return": { "running": true,
+#                      "status": "running" } }
 ##
 { 'command': 'query-status', 'returns': 'StatusInfo',
   'allow-preconfig': true }
@@ -157,9 +157,9 @@
 #
 # Example:
 #
-# <- { "event": "SHUTDOWN",
-#      "data": { "guest": true, "reason": "guest-shutdown" },
-#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#     <- { "event": "SHUTDOWN",
+#          "data": { "guest": true, "reason": "guest-shutdown" },
+#          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
 ##
 { 'event': 'SHUTDOWN', 'data': { 'guest': 'bool', 'reason': 'ShutdownCause' } }
 
@@ -173,8 +173,8 @@
 #
 # Example:
 #
-# <- { "event": "POWERDOWN",
-#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#     <- { "event": "POWERDOWN",
+#          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
 ##
 { 'event': 'POWERDOWN' }
 
@@ -194,9 +194,9 @@
 #
 # Example:
 #
-# <- { "event": "RESET",
-#      "data": { "guest": false, "reason": "guest-reset" },
-#      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
+#     <- { "event": "RESET",
+#          "data": { "guest": false, "reason": "guest-reset" },
+#          "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
 ##
 { 'event': 'RESET', 'data': { 'guest': 'bool', 'reason': 'ShutdownCause' } }
 
@@ -209,8 +209,8 @@
 #
 # Example:
 #
-# <- { "event": "STOP",
-#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#     <- { "event": "STOP",
+#          "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
 ##
 { 'event': 'STOP' }
 
@@ -223,8 +223,8 @@
 #
 # Example:
 #
-# <- { "event": "RESUME",
-#      "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
+#     <- { "event": "RESUME",
+#          "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
 ##
 { 'event': 'RESUME' }
 
@@ -238,8 +238,8 @@
 #
 # Example:
 #
-# <- { "event": "SUSPEND",
-#      "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#     <- { "event": "SUSPEND",
+#          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
 ##
 { 'event': 'SUSPEND' }
 
@@ -257,8 +257,8 @@
 #
 # Example:
 #
-# <- { "event": "SUSPEND_DISK",
-#      "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#     <- { "event": "SUSPEND_DISK",
+#          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
 ##
 { 'event': 'SUSPEND_DISK' }
 
@@ -272,8 +272,8 @@
 #
 # Example:
 #
-# <- { "event": "WAKEUP",
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#     <- { "event": "WAKEUP",
+#          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
 ##
 { 'event': 'WAKEUP' }
 
@@ -294,9 +294,9 @@
 #
 # Example:
 #
-# <- { "event": "WATCHDOG",
-#      "data": { "action": "reset" },
-#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#     <- { "event": "WATCHDOG",
+#          "data": { "action": "reset" },
+#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
 ##
 { 'event': 'WATCHDOG',
   'data': { 'action': 'WatchdogAction' } }
@@ -406,12 +406,12 @@
 #
 # Example:
 #
-# -> { "execute": "set-action",
-#      "arguments": { "reboot": "shutdown",
-#                     "shutdown" : "pause",
-#                     "panic": "pause",
-#                     "watchdog": "inject-nmi" } }
-# <- { "return": {} }
+#     -> { "execute": "set-action",
+#          "arguments": { "reboot": "shutdown",
+#                         "shutdown" : "pause",
+#                         "panic": "pause",
+#                         "watchdog": "inject-nmi" } }
+#     <- { "return": {} }
 ##
 { 'command': 'set-action',
   'data': { '*reboot': 'RebootAction',
@@ -433,9 +433,9 @@
 #
 # Example:
 #
-# <- { "event": "GUEST_PANICKED",
-#      "data": { "action": "pause" },
-#      "timestamp": { "seconds": 1648245231, "microseconds": 900001 } }
+#     <- { "event": "GUEST_PANICKED",
+#          "data": { "action": "pause" },
+#          "timestamp": { "seconds": 1648245231, "microseconds": 900001 } }
 ##
 { 'event': 'GUEST_PANICKED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
@@ -453,9 +453,9 @@
 #
 # Example:
 #
-# <- { "event": "GUEST_CRASHLOADED",
-#      "data": { "action": "run" },
-#      "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+#     <- { "event": "GUEST_CRASHLOADED",
+#          "data": { "action": "run" },
+#          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
 ##
 { 'event': 'GUEST_CRASHLOADED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
@@ -583,12 +583,12 @@
 #
 # Example:
 #
-# <- { "event": "MEMORY_FAILURE",
-#      "data": { "recipient": "hypervisor",
-#                "action": "fatal",
-#                "flags": { "action-required": false,
-#                           "recursive": false } },
-#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#     <- { "event": "MEMORY_FAILURE",
+#          "data": { "recipient": "hypervisor",
+#                    "action": "fatal",
+#                    "flags": { "action-required": false,
+#                               "recursive": false } },
+#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
 ##
 { 'event': 'MEMORY_FAILURE',
   'data': { 'recipient': 'MemoryFailureRecipient',
diff --git a/qapi/tpm.json b/qapi/tpm.json
index f9c1e866e7..07a73e5f2b 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -33,8 +33,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-tpm-models" }
-# <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
+#     -> { "execute": "query-tpm-models" }
+#     <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
 ##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'],
   'if': 'CONFIG_TPM' }
@@ -64,8 +64,8 @@
 #
 # Example:
 #
-# -> { "execute": "query-tpm-types" }
-# <- { "return": [ "passthrough", "emulator" ] }
+#     -> { "execute": "query-tpm-types" }
+#     <- { "return": [ "passthrough", "emulator" ] }
 ##
 { 'command': 'query-tpm-types', 'returns': ['TpmType'],
   'if': 'CONFIG_TPM' }
@@ -172,21 +172,21 @@
 #
 # Example:
 #
-# -> { "execute": "query-tpm" }
-# <- { "return":
-#      [
-#        { "model": "tpm-tis",
-#          "options":
-#            { "type": "passthrough",
-#              "data":
-#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
-#                  "path": "/dev/tpm0"
-#                }
-#            },
-#          "id": "tpm0"
+#     -> { "execute": "query-tpm" }
+#     <- { "return":
+#          [
+#            { "model": "tpm-tis",
+#              "options":
+#                { "type": "passthrough",
+#                  "data":
+#                    { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
+#                      "path": "/dev/tpm0"
+#                    }
+#                },
+#              "id": "tpm0"
+#            }
+#          ]
 #        }
-#      ]
-#    }
 ##
 { 'command': 'query-tpm', 'returns': ['TPMInfo'],
   'if': 'CONFIG_TPM' }
diff --git a/qapi/trace.json b/qapi/trace.json
index 2077d7e117..043d12f83e 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -66,9 +66,9 @@
 #
 # Example:
 #
-# -> { "execute": "trace-event-get-state",
-#      "arguments": { "name": "qemu_memalign" } }
-# <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
+#     -> { "execute": "trace-event-get-state",
+#          "arguments": { "name": "qemu_memalign" } }
+#     <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
 ##
 { 'command': 'trace-event-get-state',
   'data': {'name': 'str',
@@ -96,9 +96,9 @@
 #
 # Example:
 #
-# -> { "execute": "trace-event-set-state",
-#      "arguments": { "name": "qemu_memalign", "enable": true } }
-# <- { "return": {} }
+#     -> { "execute": "trace-event-set-state",
+#          "arguments": { "name": "qemu_memalign", "enable": true } }
+#     <- { "return": {} }
 ##
 { 'command': 'trace-event-set-state',
   'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool',
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 7a95c081e9..45233ddd2a 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -247,24 +247,24 @@
 #
 # Example:
 #
-# -> { "execute": "transaction",
-#      "arguments": { "actions": [
-#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd0",
-#                                      "snapshot-file": "/some/place/my-image",
-#                                      "format": "qcow2" } },
-#          { "type": "blockdev-snapshot-sync", "data" : { "node-name": "myfile",
-#                                      "snapshot-file": "/some/place/my-image2",
-#                                      "snapshot-node-name": "node3432",
-#                                      "mode": "existing",
-#                                      "format": "qcow2" } },
-#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd1",
-#                                      "snapshot-file": "/some/place/my-image2",
-#                                      "mode": "existing",
-#                                      "format": "qcow2" } },
-#          { "type": "blockdev-snapshot-internal-sync", "data" : {
-#                                      "device": "ide-hd2",
-#                                      "name": "snapshot0" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "transaction",
+#          "arguments": { "actions": [
+#              { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd0",
+#                                          "snapshot-file": "/some/place/my-image",
+#                                          "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-sync", "data" : { "node-name": "myfile",
+#                                          "snapshot-file": "/some/place/my-image2",
+#                                          "snapshot-node-name": "node3432",
+#                                          "mode": "existing",
+#                                          "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd1",
+#                                          "snapshot-file": "/some/place/my-image2",
+#                                          "mode": "existing",
+#                                          "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-internal-sync", "data" : {
+#                                          "device": "ide-hd2",
+#                                          "name": "snapshot0" } } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'transaction',
   'data': { 'actions': [ 'TransactionAction' ],
diff --git a/qapi/ui.json b/qapi/ui.json
index b6d7e142b7..0adb7e18ff 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -86,9 +86,9 @@
 #
 # Example:
 #
-# -> { "execute": "set_password", "arguments": { "protocol": "vnc",
-#                                                "password": "secret" } }
-# <- { "return": {} }
+#     -> { "execute": "set_password", "arguments": { "protocol": "vnc",
+#                                                    "password": "secret" } }
+#     <- { "return": {} }
 ##
 { 'command': 'set_password', 'boxed': true, 'data': 'SetPasswordOptions' }
 
@@ -149,9 +149,9 @@
 #
 # Example:
 #
-# -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
-#                                                   "time": "+60" } }
-# <- { "return": {} }
+#     -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
+#                                                       "time": "+60" } }
+#     <- { "return": {} }
 ##
 { 'command': 'expire_password', 'boxed': true, 'data': 'ExpirePasswordOptions' }
 
@@ -193,9 +193,9 @@
 #
 # Example:
 #
-# -> { "execute": "screendump",
-#      "arguments": { "filename": "/tmp/image" } }
-# <- { "return": {} }
+#     -> { "execute": "screendump",
+#          "arguments": { "filename": "/tmp/image" } }
+#     <- { "return": {} }
 ##
 { 'command': 'screendump',
   'data': {'filename': 'str', '*device': 'str', '*head': 'int',
@@ -337,38 +337,38 @@
 #
 # Example:
 #
-# -> { "execute": "query-spice" }
-# <- { "return": {
-#          "enabled": true,
-#          "auth": "spice",
-#          "port": 5920,
-#          "migrated":false,
-#          "tls-port": 5921,
-#          "host": "0.0.0.0",
-#          "mouse-mode":"client",
-#          "channels": [
-#             {
-#                "port": "54924",
-#                "family": "ipv4",
-#                "channel-type": 1,
-#                "connection-id": 1804289383,
-#                "host": "127.0.0.1",
-#                "channel-id": 0,
-#                "tls": true
-#             },
-#             {
-#                "port": "36710",
-#                "family": "ipv4",
-#                "channel-type": 4,
-#                "connection-id": 1804289383,
-#                "host": "127.0.0.1",
-#                "channel-id": 0,
-#                "tls": false
-#             },
-#             [ ... more channels follow ... ]
-#          ]
-#       }
-#    }
+#     -> { "execute": "query-spice" }
+#     <- { "return": {
+#              "enabled": true,
+#              "auth": "spice",
+#              "port": 5920,
+#              "migrated":false,
+#              "tls-port": 5921,
+#              "host": "0.0.0.0",
+#              "mouse-mode":"client",
+#              "channels": [
+#                 {
+#                    "port": "54924",
+#                    "family": "ipv4",
+#                    "channel-type": 1,
+#                    "connection-id": 1804289383,
+#                    "host": "127.0.0.1",
+#                    "channel-id": 0,
+#                    "tls": true
+#                 },
+#                 {
+#                    "port": "36710",
+#                    "family": "ipv4",
+#                    "channel-type": 4,
+#                    "connection-id": 1804289383,
+#                    "host": "127.0.0.1",
+#                    "channel-id": 0,
+#                    "tls": false
+#                 },
+#                 [ ... more channels follow ... ]
+#              ]
+#           }
+#        }
 ##
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
   'if': 'CONFIG_SPICE' }
@@ -386,12 +386,12 @@
 #
 # Example:
 #
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
-#      "event": "SPICE_CONNECTED",
-#      "data": {
-#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
-#    }}
+#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#          "event": "SPICE_CONNECTED",
+#          "data": {
+#            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
+#            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
+#        }}
 ##
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -412,14 +412,14 @@
 #
 # Example:
 #
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
-#      "event": "SPICE_INITIALIZED",
-#      "data": {"server": {"auth": "spice", "port": "5921",
-#                          "family": "ipv4", "host": "127.0.0.1"},
-#               "client": {"port": "49004", "family": "ipv4", "channel-type": 3,
-#                          "connection-id": 1804289383, "host": "127.0.0.1",
-#                          "channel-id": 0, "tls": true}
-#    }}
+#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#          "event": "SPICE_INITIALIZED",
+#          "data": {"server": {"auth": "spice", "port": "5921",
+#                              "family": "ipv4", "host": "127.0.0.1"},
+#                   "client": {"port": "49004", "family": "ipv4", "channel-type": 3,
+#                              "connection-id": 1804289383, "host": "127.0.0.1",
+#                              "channel-id": 0, "tls": true}
+#        }}
 ##
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
@@ -439,12 +439,12 @@
 #
 # Example:
 #
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
-#      "event": "SPICE_DISCONNECTED",
-#      "data": {
-#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
-#    }}
+#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#          "event": "SPICE_DISCONNECTED",
+#          "data": {
+#            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
+#            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
+#        }}
 ##
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
@@ -460,8 +460,8 @@
 #
 # Example:
 #
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
-#      "event": "SPICE_MIGRATE_COMPLETED" }
+#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#          "event": "SPICE_MIGRATE_COMPLETED" }
 ##
 { 'event': 'SPICE_MIGRATE_COMPLETED',
   'if': 'CONFIG_SPICE' }
@@ -668,23 +668,23 @@
 #
 # Example:
 #
-# -> { "execute": "query-vnc" }
-# <- { "return": {
-#          "enabled":true,
-#          "host":"0.0.0.0",
-#          "service":"50402",
-#          "auth":"vnc",
-#          "family":"ipv4",
-#          "clients":[
-#             {
-#                "host":"127.0.0.1",
-#                "service":"50401",
-#                "family":"ipv4",
-#                "websocket":false
-#             }
-#          ]
-#       }
-#    }
+#     -> { "execute": "query-vnc" }
+#     <- { "return": {
+#              "enabled":true,
+#              "host":"0.0.0.0",
+#              "service":"50402",
+#              "auth":"vnc",
+#              "family":"ipv4",
+#              "clients":[
+#                 {
+#                    "host":"127.0.0.1",
+#                    "service":"50401",
+#                    "family":"ipv4",
+#                    "websocket":false
+#                 }
+#              ]
+#           }
+#        }
 ##
 { 'command': 'query-vnc', 'returns': 'VncInfo',
   'if': 'CONFIG_VNC' }
@@ -733,13 +733,13 @@
 #
 # Example:
 #
-# <- { "event": "VNC_CONNECTED",
-#      "data": {
-#            "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
-#                        "service": "5901", "host": "0.0.0.0" },
-#            "client": { "family": "ipv4", "service": "58425",
-#                        "host": "127.0.0.1", "websocket": false } },
-#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#     <- { "event": "VNC_CONNECTED",
+#          "data": {
+#                "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
+#                            "service": "5901", "host": "0.0.0.0" },
+#                "client": { "family": "ipv4", "service": "58425",
+#                            "host": "127.0.0.1", "websocket": false } },
+#          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -760,13 +760,13 @@
 #
 # Example:
 #
-# <-  { "event": "VNC_INITIALIZED",
-#       "data": {
-#            "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
-#                        "service": "5901", "host": "0.0.0.0"},
-#            "client": { "family": "ipv4", "service": "46089", "websocket": false,
-#                        "host": "127.0.0.1", "sasl_username": "luiz" } },
-#       "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
+#     <-  { "event": "VNC_INITIALIZED",
+#           "data": {
+#                "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
+#                            "service": "5901", "host": "0.0.0.0"},
+#                "client": { "family": "ipv4", "service": "46089", "websocket": false,
+#                            "host": "127.0.0.1", "sasl_username": "luiz" } },
+#           "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
@@ -786,13 +786,13 @@
 #
 # Example:
 #
-# <- { "event": "VNC_DISCONNECTED",
-#      "data": {
-#            "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
-#                        "service": "5901", "host": "0.0.0.0" },
-#            "client": { "family": "ipv4", "service": "58425", "websocket": false,
-#                        "host": "127.0.0.1", "sasl_username": "luiz" } },
-#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#     <- { "event": "VNC_DISCONNECTED",
+#          "data": {
+#                "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
+#                            "service": "5901", "host": "0.0.0.0" },
+#                "client": { "family": "ipv4", "service": "58425", "websocket": false,
+#                            "host": "127.0.0.1", "sasl_username": "luiz" } },
+#          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -834,22 +834,22 @@
 #
 # Example:
 #
-# -> { "execute": "query-mice" }
-# <- { "return": [
-#          {
-#             "name":"QEMU Microsoft Mouse",
-#             "index":0,
-#             "current":false,
-#             "absolute":false
-#          },
-#          {
-#             "name":"QEMU PS/2 Mouse",
-#             "index":1,
-#             "current":true,
-#             "absolute":true
-#          }
-#       ]
-#    }
+#     -> { "execute": "query-mice" }
+#     <- { "return": [
+#              {
+#                 "name":"QEMU Microsoft Mouse",
+#                 "index":0,
+#                 "current":false,
+#                 "absolute":false
+#              },
+#              {
+#                 "name":"QEMU PS/2 Mouse",
+#                 "index":1,
+#                 "current":true,
+#                 "absolute":true
+#              }
+#           ]
+#        }
 ##
 { 'command': 'query-mice', 'returns': ['MouseInfo'] }
 
@@ -1044,11 +1044,11 @@
 #
 # Example:
 #
-# -> { "execute": "send-key",
-#      "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
-#                               { "type": "qcode", "data": "alt" },
-#                               { "type": "qcode", "data": "delete" } ] } }
-# <- { "return": {} }
+#     -> { "execute": "send-key",
+#          "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
+#                                   { "type": "qcode", "data": "alt" },
+#                                   { "type": "qcode", "data": "delete" } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'send-key',
   'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
@@ -1270,39 +1270,39 @@
 #
 # Examples:
 #
-# 1. Press left mouse button.
+#     1. Press left mouse button.
 #
-# -> { "execute": "input-send-event",
-#     "arguments": { "device": "video0",
-#                    "events": [ { "type": "btn",
-#                    "data" : { "down": true, "button": "left" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "input-send-event",
+#         "arguments": { "device": "video0",
+#                        "events": [ { "type": "btn",
+#                        "data" : { "down": true, "button": "left" } } ] } }
+#     <- { "return": {} }
 #
-# -> { "execute": "input-send-event",
-#     "arguments": { "device": "video0",
-#                    "events": [ { "type": "btn",
-#                    "data" : { "down": false, "button": "left" } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "input-send-event",
+#         "arguments": { "device": "video0",
+#                        "events": [ { "type": "btn",
+#                        "data" : { "down": false, "button": "left" } } ] } }
+#     <- { "return": {} }
 #
-# 2. Press ctrl-alt-del.
+#     2. Press ctrl-alt-del.
 #
-# -> { "execute": "input-send-event",
-#      "arguments": { "events": [
-#         { "type": "key", "data" : { "down": true,
-#           "key": {"type": "qcode", "data": "ctrl" } } },
-#         { "type": "key", "data" : { "down": true,
-#           "key": {"type": "qcode", "data": "alt" } } },
-#         { "type": "key", "data" : { "down": true,
-#           "key": {"type": "qcode", "data": "delete" } } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "input-send-event",
+#          "arguments": { "events": [
+#             { "type": "key", "data" : { "down": true,
+#               "key": {"type": "qcode", "data": "ctrl" } } },
+#             { "type": "key", "data" : { "down": true,
+#               "key": {"type": "qcode", "data": "alt" } } },
+#             { "type": "key", "data" : { "down": true,
+#               "key": {"type": "qcode", "data": "delete" } } } ] } }
+#     <- { "return": {} }
 #
-# 3. Move mouse pointer to absolute coordinates (20000, 400).
+#     3. Move mouse pointer to absolute coordinates (20000, 400).
 #
-# -> { "execute": "input-send-event" ,
-#   "arguments": { "events": [
-#                { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
-#                { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
-# <- { "return": {} }
+#     -> { "execute": "input-send-event" ,
+#       "arguments": { "events": [
+#                    { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
+#                    { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'input-send-event',
   'data': { '*device': 'str',
@@ -1611,9 +1611,9 @@
 #
 # Example:
 #
-# -> { "execute": "display-reload",
-#      "arguments": { "type": "vnc", "tls-certs": true  } }
-# <- { "return": {} }
+#     -> { "execute": "display-reload",
+#          "arguments": { "type": "vnc", "tls-certs": true  } }
+#     <- { "return": {} }
 ##
 { 'command': 'display-reload',
   'data': 'DisplayReloadOptions',
@@ -1670,11 +1670,11 @@
 #
 # Example:
 #
-# -> { "execute": "display-update",
-#      "arguments": { "type": "vnc", "addresses":
-#                     [ { "type": "inet", "host": "0.0.0.0",
-#                         "port": "5901" } ] } }
-# <- { "return": {} }
+#     -> { "execute": "display-update",
+#          "arguments": { "type": "vnc", "addresses":
+#                         [ { "type": "inet", "host": "0.0.0.0",
+#                             "port": "5901" } ] } }
+#     <- { "return": {} }
 ##
 { 'command': 'display-update',
   'data': 'DisplayUpdateOptions',
@@ -1701,11 +1701,11 @@
 #
 # Example:
 #
-# -> { "execute": "client_migrate_info",
-#      "arguments": { "protocol": "spice",
-#                     "hostname": "virt42.lab.kraxel.org",
-#                     "port": 1234 } }
-# <- { "return": {} }
+#     -> { "execute": "client_migrate_info",
+#          "arguments": { "protocol": "spice",
+#                         "hostname": "virt42.lab.kraxel.org",
+#                         "port": 1234 } }
+#     <- { "return": {} }
 ##
 { 'command': 'client_migrate_info',
   'data': { 'protocol': 'str', 'hostname': 'str', '*port': 'int',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 19c7c36e36..a79013fe89 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -36,30 +36,30 @@
 #
 # Example:
 #
-# -> { "execute": "x-query-virtio" }
-# <- { "return": [
-#          {
-#              "name": "virtio-input",
-#              "path": "/machine/peripheral-anon/device[4]/virtio-backend"
-#          },
-#          {
-#              "name": "virtio-crypto",
-#              "path": "/machine/peripheral/crypto0/virtio-backend"
-#          },
-#          {
-#              "name": "virtio-scsi",
-#              "path": "/machine/peripheral-anon/device[2]/virtio-backend"
-#          },
-#          {
-#              "name": "virtio-net",
-#              "path": "/machine/peripheral-anon/device[1]/virtio-backend"
-#          },
-#          {
-#              "name": "virtio-serial",
-#              "path": "/machine/peripheral-anon/device[0]/virtio-backend"
-#          }
-#      ]
-#    }
+#     -> { "execute": "x-query-virtio" }
+#     <- { "return": [
+#              {
+#                  "name": "virtio-input",
+#                  "path": "/machine/peripheral-anon/device[4]/virtio-backend"
+#              },
+#              {
+#                  "name": "virtio-crypto",
+#                  "path": "/machine/peripheral/crypto0/virtio-backend"
+#              },
+#              {
+#                  "name": "virtio-scsi",
+#                  "path": "/machine/peripheral-anon/device[2]/virtio-backend"
+#              },
+#              {
+#                  "name": "virtio-net",
+#                  "path": "/machine/peripheral-anon/device[1]/virtio-backend"
+#              },
+#              {
+#                  "name": "virtio-serial",
+#                  "path": "/machine/peripheral-anon/device[0]/virtio-backend"
+#              }
+#          ]
+#        }
 ##
 { 'command': 'x-query-virtio',
   'returns': [ 'VirtioInfo' ],
@@ -205,229 +205,229 @@
 #
 # Examples:
 #
-# 1. Poll for the status of virtio-crypto (no vhost-crypto active)
+#     1. Poll for the status of virtio-crypto (no vhost-crypto active)
 #
-# -> { "execute": "x-query-virtio-status",
-#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
-#    }
-# <- { "return": {
-#          "device-endian": "little",
-#          "bus-name": "",
-#          "disable-legacy-check": false,
-#          "name": "virtio-crypto",
-#          "started": true,
-#          "device-id": 20,
-#          "backend-features": {
-#              "transports": [],
-#              "dev-features": []
-#          },
-#          "start-on-kick": false,
-#          "isr": 1,
-#          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
-#          "num-vqs": 2,
-#          "guest-features": {
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#              ]
-#          },
-#          "host-features": {
-#              "unknown-dev-features": 1073741824,
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
-#          },
-#          "use-guest-notifier-mask": true,
-#          "vm-running": true,
-#          "queue-sel": 1,
-#          "disabled": false,
-#          "vhost-started": false,
-#          "use-started": true
-#      }
-#    }
-#
-# 2. Poll for the status of virtio-net (vhost-net is active)
-#
-# -> { "execute": "x-query-virtio-status",
-#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
-#    }
-# <- { "return": {
-#          "device-endian": "little",
-#          "bus-name": "",
-#          "disabled-legacy-check": false,
-#          "name": "virtio-net",
-#          "started": true,
-#          "device-id": 1,
-#          "vhost-dev": {
-#              "n-tmp-sections": 4,
-#              "n-mem-sections": 4,
-#              "max-queues": 1,
-#              "backend-cap": 2,
-#              "log-size": 0,
+#     -> { "execute": "x-query-virtio-status",
+#          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
+#        }
+#     <- { "return": {
+#              "device-endian": "little",
+#              "bus-name": "",
+#              "disable-legacy-check": false,
+#              "name": "virtio-crypto",
+#              "started": true,
+#              "device-id": 20,
 #              "backend-features": {
+#                  "transports": [],
+#                  "dev-features": []
+#              },
+#              "start-on-kick": false,
+#              "isr": 1,
+#              "broken": false,
+#              "status": {
+#                  "statuses": [
+#                      "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
+#                      "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
+#                      "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
+#                      "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
+#                  ]
+#              },
+#              "num-vqs": 2,
+#              "guest-features": {
 #                  "dev-features": [],
-#                  "transports": []
-#              },
-#              "nvqs": 2,
-#              "protocol-features": {
-#                  "protocols": []
-#              },
-#              "vq-index": 0,
-#              "log-enabled": false,
-#              "acked-features": {
-#                  "dev-features": [
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
 #                  "transports": [
 #                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
 #                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
 #                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
 #                  ]
 #              },
-#              "features": {
-#                  "dev-features": [
-#                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
+#              "host-features": {
+#                  "unknown-dev-features": 1073741824,
+#                  "dev-features": [],
 #                  "transports": [
 #                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
 #                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
 #                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
 #                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
 #                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
 #                  ]
-#              }
-#          },
-#          "backend-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
-#          },
-#          "start-on-kick": false,
-#          "isr": 1,
-#          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
-#          "num-vqs": 3,
-#          "guest-features": {
-#              "dev-features": [
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#             ]
-#          },
-#          "host-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#             ]
-#          },
-#          "use-guest-notifier-mask": true,
-#          "vm-running": true,
-#          "queue-sel": 2,
-#          "disabled": false,
-#          "vhost-started": true,
-#          "use-started": true
-#      }
-#    }
+#              },
+#              "use-guest-notifier-mask": true,
+#              "vm-running": true,
+#              "queue-sel": 1,
+#              "disabled": false,
+#              "vhost-started": false,
+#              "use-started": true
+#          }
+#        }
+#
+#     2. Poll for the status of virtio-net (vhost-net is active)
+#
+#     -> { "execute": "x-query-virtio-status",
+#          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
+#        }
+#     <- { "return": {
+#              "device-endian": "little",
+#              "bus-name": "",
+#              "disabled-legacy-check": false,
+#              "name": "virtio-net",
+#              "started": true,
+#              "device-id": 1,
+#              "vhost-dev": {
+#                  "n-tmp-sections": 4,
+#                  "n-mem-sections": 4,
+#                  "max-queues": 1,
+#                  "backend-cap": 2,
+#                  "log-size": 0,
+#                  "backend-features": {
+#                      "dev-features": [],
+#                      "transports": []
+#                  },
+#                  "nvqs": 2,
+#                  "protocol-features": {
+#                      "protocols": []
+#                  },
+#                  "vq-index": 0,
+#                  "log-enabled": false,
+#                  "acked-features": {
+#                      "dev-features": [
+#                          "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
+#                      ],
+#                      "transports": [
+#                          "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
+#                          "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
+#                          "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
+#                      ]
+#                  },
+#                  "features": {
+#                      "dev-features": [
+#                          "VHOST_F_LOG_ALL: Logging write descriptors supported",
+#                          "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
+#                      ],
+#                      "transports": [
+#                          "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
+#                          "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
+#                          "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
+#                          "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
+#                          "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
+#                          "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
+#                      ]
+#                  }
+#              },
+#              "backend-features": {
+#                  "dev-features": [
+#                      "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
+#                      "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
+#                      "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
+#                      "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
+#                      "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
+#                      "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
+#                      "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
+#                      "VIRTIO_NET_F_CTRL_VQ: Control channel available",
+#                      "VIRTIO_NET_F_STATUS: Configuration status field available",
+#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
+#                      "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
+#                      "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
+#                      "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
+#                      "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
+#                      "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
+#                      "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
+#                      "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
+#                      "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
+#                      "VIRTIO_NET_F_MAC: Device has given MAC address",
+#                      "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
+#                      "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
+#                      "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
+#                  ],
+#                  "transports": [
+#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
+#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
+#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
+#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
+#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
+#                  ]
+#              },
+#              "start-on-kick": false,
+#              "isr": 1,
+#              "broken": false,
+#              "status": {
+#                  "statuses": [
+#                      "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
+#                      "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
+#                      "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
+#                      "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
+#                  ]
+#              },
+#              "num-vqs": 3,
+#              "guest-features": {
+#                  "dev-features": [
+#                      "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
+#                      "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
+#                      "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
+#                      "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
+#                      "VIRTIO_NET_F_CTRL_VQ: Control channel available",
+#                      "VIRTIO_NET_F_STATUS: Configuration status field available",
+#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
+#                      "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
+#                      "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
+#                      "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
+#                      "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
+#                      "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
+#                      "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
+#                      "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
+#                      "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
+#                      "VIRTIO_NET_F_MAC: Device has given MAC address",
+#                      "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
+#                      "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
+#                      "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
+#                  ],
+#                  "transports": [
+#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
+#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
+#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
+#                 ]
+#              },
+#              "host-features": {
+#                  "dev-features": [
+#                      "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
+#                      "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
+#                      "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
+#                      "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
+#                      "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
+#                      "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
+#                      "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
+#                      "VIRTIO_NET_F_CTRL_VQ: Control channel available",
+#                      "VIRTIO_NET_F_STATUS: Configuration status field available",
+#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
+#                      "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
+#                      "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
+#                      "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
+#                      "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
+#                      "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
+#                      "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
+#                      "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
+#                      "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
+#                      "VIRTIO_NET_F_MAC: Device has given MAC address",
+#                      "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
+#                      "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
+#                      "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
+#                  ],
+#                  "transports": [
+#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
+#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
+#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
+#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
+#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
+#                 ]
+#              },
+#              "use-guest-notifier-mask": true,
+#              "vm-running": true,
+#              "queue-sel": 2,
+#              "disabled": false,
+#              "vhost-started": true,
+#              "use-started": true
+#          }
+#        }
 ##
 { 'command': 'x-query-virtio-status',
   'data': { 'path': 'str' },
@@ -570,52 +570,52 @@
 #
 # Examples:
 #
-# 1. Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+#     1. Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
 #
-# -> { "execute": "x-query-virtio-queue-status",
-#      "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
-#                     "queue": 1 }
-#    }
-# <- { "return": {
-#          "signalled-used": 0,
-#          "inuse": 0,
-#          "name": "vhost-vsock",
-#          "vring-align": 4096,
-#          "vring-desc": 5217370112,
-#          "signalled-used-valid": false,
-#          "vring-num-default": 128,
-#          "vring-avail": 5217372160,
-#          "queue-index": 1,
-#          "last-avail-idx": 0,
-#          "vring-used": 5217372480,
-#          "used-idx": 0,
-#          "vring-num": 128
-#      }
-#    }
+#     -> { "execute": "x-query-virtio-queue-status",
+#          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
+#                         "queue": 1 }
+#        }
+#     <- { "return": {
+#              "signalled-used": 0,
+#              "inuse": 0,
+#              "name": "vhost-vsock",
+#              "vring-align": 4096,
+#              "vring-desc": 5217370112,
+#              "signalled-used-valid": false,
+#              "vring-num-default": 128,
+#              "vring-avail": 5217372160,
+#              "queue-index": 1,
+#              "last-avail-idx": 0,
+#              "vring-used": 5217372480,
+#              "used-idx": 0,
+#              "vring-num": 128
+#          }
+#        }
 #
-# 2. Get VirtQueueStatus for virtio-serial (no vhost)
+#     2. Get VirtQueueStatus for virtio-serial (no vhost)
 #
-# -> { "execute": "x-query-virtio-queue-status",
-#      "arguments": { "path": "/machine/peripheral-anon/device[0]/virtio-backend",
-#                     "queue": 20 }
-#    }
-# <- { "return": {
-#          "signalled-used": 0,
-#          "inuse": 0,
-#          "name": "virtio-serial",
-#          "vring-align": 4096,
-#          "vring-desc": 5182074880,
-#          "signalled-used-valid": false,
-#          "vring-num-default": 128,
-#          "vring-avail": 5182076928,
-#          "queue-index": 20,
-#          "last-avail-idx": 0,
-#          "vring-used": 5182077248,
-#          "used-idx": 0,
-#          "shadow-avail-idx": 0,
-#          "vring-num": 128
-#      }
-#    }
+#     -> { "execute": "x-query-virtio-queue-status",
+#          "arguments": { "path": "/machine/peripheral-anon/device[0]/virtio-backend",
+#                         "queue": 20 }
+#        }
+#     <- { "return": {
+#              "signalled-used": 0,
+#              "inuse": 0,
+#              "name": "virtio-serial",
+#              "vring-align": 4096,
+#              "vring-desc": 5182074880,
+#              "signalled-used-valid": false,
+#              "vring-num-default": 128,
+#              "vring-avail": 5182076928,
+#              "queue-index": 20,
+#              "last-avail-idx": 0,
+#              "vring-used": 5182077248,
+#              "used-idx": 0,
+#              "shadow-avail-idx": 0,
+#              "vring-num": 128
+#          }
+#        }
 ##
 { 'command': 'x-query-virtio-queue-status',
   'data': { 'path': 'str', 'queue': 'uint16' },
@@ -690,51 +690,51 @@
 #
 # Examples:
 #
-# 1. Get vhost_virtqueue status for vhost-crypto
+#     1. Get vhost_virtqueue status for vhost-crypto
 #
-# -> { "execute": "x-query-virtio-vhost-queue-status",
-#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
-#                     "queue": 0 }
-#    }
-# <- { "return": {
-#          "avail-phys": 5216124928,
-#          "name": "virtio-crypto",
-#          "used-phys": 5216127040,
-#          "avail-size": 2054,
-#          "desc-size": 16384,
-#          "used-size": 8198,
-#          "desc": 140141447430144,
-#          "num": 1024,
-#          "call": 0,
-#          "avail": 140141447446528,
-#          "desc-phys": 5216108544,
-#          "used": 140141447448640,
-#          "kick": 0
-#      }
-#    }
+#     -> { "execute": "x-query-virtio-vhost-queue-status",
+#          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
+#                         "queue": 0 }
+#        }
+#     <- { "return": {
+#              "avail-phys": 5216124928,
+#              "name": "virtio-crypto",
+#              "used-phys": 5216127040,
+#              "avail-size": 2054,
+#              "desc-size": 16384,
+#              "used-size": 8198,
+#              "desc": 140141447430144,
+#              "num": 1024,
+#              "call": 0,
+#              "avail": 140141447446528,
+#              "desc-phys": 5216108544,
+#              "used": 140141447448640,
+#              "kick": 0
+#          }
+#        }
 #
-# 2. Get vhost_virtqueue status for vhost-vsock
+#     2. Get vhost_virtqueue status for vhost-vsock
 #
-# -> { "execute": "x-query-virtio-vhost-queue-status",
-#      "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
-#                     "queue": 0 }
-#    }
-# <- { "return": {
-#          "avail-phys": 5182261248,
-#          "name": "vhost-vsock",
-#          "used-phys": 5182261568,
-#          "avail-size": 262,
-#          "desc-size": 2048,
-#          "used-size": 1030,
-#          "desc": 140141413580800,
-#          "num": 128,
-#          "call": 0,
-#          "avail": 140141413582848,
-#          "desc-phys": 5182259200,
-#          "used": 140141413583168,
-#          "kick": 0
-#      }
-#    }
+#     -> { "execute": "x-query-virtio-vhost-queue-status",
+#          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
+#                         "queue": 0 }
+#        }
+#     <- { "return": {
+#              "avail-phys": 5182261248,
+#              "name": "vhost-vsock",
+#              "used-phys": 5182261568,
+#              "avail-size": 262,
+#              "desc-size": 2048,
+#              "used-size": 1030,
+#              "desc": 140141413580800,
+#              "num": 128,
+#              "call": 0,
+#              "avail": 140141413582848,
+#              "desc-phys": 5182259200,
+#              "used": 140141413583168,
+#              "kick": 0
+#          }
+#        }
 ##
 { 'command': 'x-query-virtio-vhost-queue-status',
   'data': { 'path': 'str', 'queue': 'uint16' },
@@ -839,90 +839,90 @@
 #
 # Examples:
 #
-# 1. Introspect on virtio-net's VirtQueue 0 at index 5
+#     1. Introspect on virtio-net's VirtQueue 0 at index 5
 #
-# -> { "execute": "x-query-virtio-queue-element",
-#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
-#                     "queue": 0,
-#                     "index": 5 }
-#    }
-# <- { "return": {
-#          "index": 5,
-#          "name": "virtio-net",
-#          "descs": [
-#              {
-#                  "flags": ["write"],
-#                  "len": 1536,
-#                  "addr": 5257305600
+#     -> { "execute": "x-query-virtio-queue-element",
+#          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
+#                         "queue": 0,
+#                         "index": 5 }
+#        }
+#     <- { "return": {
+#              "index": 5,
+#              "name": "virtio-net",
+#              "descs": [
+#                  {
+#                      "flags": ["write"],
+#                      "len": 1536,
+#                      "addr": 5257305600
+#                  }
+#              ],
+#              "avail": {
+#                  "idx": 256,
+#                  "flags": 0,
+#                  "ring": 5
+#              },
+#              "used": {
+#                  "idx": 13,
+#                  "flags": 0
 #              }
-#          ],
-#          "avail": {
-#              "idx": 256,
-#              "flags": 0,
-#              "ring": 5
-#          },
-#          "used": {
-#              "idx": 13,
-#              "flags": 0
 #          }
-#      }
-#    }
+#        }
 #
-# 2. Introspect on virtio-crypto's VirtQueue 1 at head
+#     2. Introspect on virtio-crypto's VirtQueue 1 at head
 #
-# -> { "execute": "x-query-virtio-queue-element",
-#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
-#                     "queue": 1 }
-#    }
-# <- { "return": {
-#          "index": 0,
-#          "name": "virtio-crypto",
-#          "descs": [
-#              {
-#                  "flags": [],
-#                  "len": 0,
-#                  "addr": 8080268923184214134
+#     -> { "execute": "x-query-virtio-queue-element",
+#          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
+#                         "queue": 1 }
+#        }
+#     <- { "return": {
+#              "index": 0,
+#              "name": "virtio-crypto",
+#              "descs": [
+#                  {
+#                      "flags": [],
+#                      "len": 0,
+#                      "addr": 8080268923184214134
+#                  }
+#              ],
+#              "avail": {
+#                  "idx": 280,
+#                  "flags": 0,
+#                  "ring": 0
+#              },
+#              "used": {
+#                  "idx": 280,
+#                  "flags": 0
 #              }
-#          ],
-#          "avail": {
-#              "idx": 280,
-#              "flags": 0,
-#              "ring": 0
-#          },
-#          "used": {
-#              "idx": 280,
-#              "flags": 0
 #          }
-#      }
-#    }
+#        }
 #
-# 3. Introspect on virtio-scsi's VirtQueue 2 at head
+#     3. Introspect on virtio-scsi's VirtQueue 2 at head
 #
-# -> { "execute": "x-query-virtio-queue-element",
-#      "arguments": { "path": "/machine/peripheral-anon/device[2]/virtio-backend",
-#                     "queue": 2 }
-#    }
-# <- { "return": {
-#          "index": 19,
-#          "name": "virtio-scsi",
-#          "descs": [
-#              {
-#                  "flags": ["used", "indirect", "write"],
-#                  "len": 4099327944,
-#                  "addr": 12055409292258155293
+#     -> { "execute": "x-query-virtio-queue-element",
+#          "arguments": { "path": "/machine/peripheral-anon/device[2]/virtio-backend",
+#                         "queue": 2 }
+#        }
+#     <- { "return": {
+#              "index": 19,
+#              "name": "virtio-scsi",
+#              "descs": [
+#                  {
+#                      "flags": ["used", "indirect", "write"],
+#                      "len": 4099327944,
+#                      "addr": 12055409292258155293
+#                  }
+#              ],
+#              "avail": {
+#                  "idx": 1147,
+#                  "flags": 0,
+#                  "ring": 19
+#              },
+#              "used": {
+#                  "idx": 280,
+#                  "flags": 0
 #              }
-#          ],
-#          "avail": {
-#              "idx": 1147,
-#              "flags": 0,
-#              "ring": 19
-#          },
-#          "used": {
-#              "idx": 280,
-#              "flags": 0
 #          }
-#      }
-#    }
+#        }
 ##
 { 'command': 'x-query-virtio-queue-element',
   'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
diff --git a/qapi/yank.json b/qapi/yank.json
index ee038a11a1..b7aeb9ceef 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -84,13 +84,13 @@
 #
 # Example:
 #
-# -> { "execute": "yank",
-#      "arguments": {
-#          "instances": [
-#               { "type": "block-node",
-#                 "node-name": "nbd0" }
-#          ] } }
-# <- { "return": {} }
+#     -> { "execute": "yank",
+#          "arguments": {
+#              "instances": [
+#                   { "type": "block-node",
+#                     "node-name": "nbd0" }
+#              ] } }
+#     <- { "return": {} }
 #
 # Since: 6.0
 ##
@@ -107,11 +107,11 @@
 #
 # Example:
 #
-# -> { "execute": "query-yank" }
-# <- { "return": [
-#          { "type": "block-node",
-#            "node-name": "nbd0" }
-#      ] }
+#     -> { "execute": "query-yank" }
+#     <- { "return": [
+#              { "type": "block-node",
+#                "node-name": "nbd0" }
+#          ] }
 #
 # Since: 6.0
 ##
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 3aefec1c2b..f8da315332 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -492,6 +492,9 @@ def append(self, line: str) -> None:
                     # indeterminate indentation
                     if self.text != '':
                         # non-blank, non-first line determines indentation
+                        if indent == 0:
+                            raise QAPIParseError(
+                                self._parser, "line needs to be indented")
                         self._indent = indent
                 elif indent < self._indent:
                     raise QAPIParseError(
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 0479d16a01..977bb38b6e 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -165,11 +165,11 @@
 #  Duis aute irure dolor
 # Example:
 #
-# -> in
-# <- out
+#  -> in
+#  <- out
 # Examples:
-# - *verbatim*
-# - {braces}
+#  - *verbatim*
+#  - {braces}
 # Since: 2.10
 ##
 { 'command': 'cmd',
@@ -185,9 +185,9 @@
 # @cmd-feat2: another feature
 # Example:
 #
-# -> in
+#  -> in
 #
-# <- out
+#  <- out
 ##
 { 'command': 'cmd-boxed', 'boxed': true,
   'data': 'Object',
-- 
2.43.0


