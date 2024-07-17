Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF6C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuBO-0001Ou-CL; Tue, 16 Jul 2024 22:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuBM-0001JE-Ul
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuBL-0003yY-3u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721182454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nIgr4oTC9LuBXh886B1f/pEQMptCNLixC2q+YAp+Ts=;
 b=XhsDoT1m2A++UfxYqdAqlcxg4CroJHu0Rx/xUWbaV8Vs4cOiUfMfPnShPPdGkDTYKe9vkD
 pPvf+Ls/i/Thze3pXKY9kfK5xTo7X9VFa1++8Zpl+xosaShuWqUClni6x0LavbZCzceNEF
 L2rctjHTy6vF9A52b6VXIvJZqMPnVO4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-JkFhVavNOZKYt5UA2XGFJQ-1; Tue,
 16 Jul 2024 22:14:08 -0400
X-MC-Unique: JkFhVavNOZKYt5UA2XGFJQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF6A21955D4D; Wed, 17 Jul 2024 02:14:05 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B700E1955F40; Wed, 17 Jul 2024 02:14:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 8/9] qapi: convert "Example" sections with longer prose
Date: Tue, 16 Jul 2024 22:13:10 -0400
Message-ID: <20240717021312.606116-9-jsnow@redhat.com>
In-Reply-To: <20240717021312.606116-1-jsnow@redhat.com>
References: <20240717021312.606116-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These examples require longer explanations or have explanations that
require markup to look reasonable when rendered and so use the longer
form of the ".. qmp-example::" directive.

By using the :annotated: option, the content in the example block is
assumed *not* to be a code block literal and is instead parsed as normal
rST - with the exception that any code literal blocks after `::` will
assumed to be a QMP code literal block.

Note: There's one title-less conversion in this patch that comes along
for the ride because it's part of a larger "Examples" block that was
better to convert all at once.

See commit-5: "docs/qapidoc: create qmp-example directive", for a
              detailed explanation of this custom directive syntax.

See commit+1: "qapi: remove "Example" doc section" for a detailed
              explanation of why.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block.json     | 30 +++++++++++++++++++-----------
 qapi/machine.json   | 30 ++++++++++++++++++++----------
 qapi/migration.json |  7 +++++--
 qapi/virtio.json    | 24 ++++++++++++++++++------
 4 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 5ddd061e964..ce9490a3678 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -545,31 +545,37 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     Set new histograms for all io types with intervals
-#     [0, 10), [10, 50), [50, 100), [100, +inf):
+#    Set new histograms for all io types with intervals
+#    [0, 10), [10, 50), [50, 100), [100, +inf)::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
 #                         "boundaries": [10, 50, 100] } }
 #     <- { "return": {} }
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     Set new histogram only for write, other histograms will remain
-#     not changed (or not created):
+#    Set new histogram only for write, other histograms will remain
+#    not changed (or not created)::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
 #                         "boundaries-write": [10, 50, 100] } }
 #     <- { "return": {} }
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     Set new histograms with the following intervals:
-#       read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
-#       write: [0, 1000), [1000, 5000), [5000, +inf)
+#    Set new histograms with the following intervals:
+#
+#    - read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
+#    - write: [0, 1000), [1000, 5000), [5000, +inf)
+#
+#    ::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
@@ -578,7 +584,9 @@
 #     <- { "return": {} }
 #
 # .. qmp-example::
-#    :title: Remove all latency histograms
+#    :annotated:
+#
+#    Remove all latency histograms::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0" } }
diff --git a/qapi/machine.json b/qapi/machine.json
index 83f60b319c7..0a5ffe652b7 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1047,10 +1047,11 @@
 #
 # Since: 2.7
 #
-# Examples:
+# .. qmp-example::
+#    :annotated:
 #
-#     For pseries machine type started with -smp 2,cores=2,maxcpus=4
-#     -cpu POWER8:
+#    For pseries machine type started with
+#    ``-smp 2,cores=2,maxcpus=4 -cpu POWER8``::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1060,7 +1061,10 @@
 #            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
 #        ]}
 #
-#     For pc machine type started with -smp 1,maxcpus=2:
+# .. qmp-example::
+#    :annotated:
+#
+#    For pc machine type started with ``-smp 1,maxcpus=2``::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1075,8 +1079,11 @@
 #          }
 #        ]}
 #
-#     For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2
-#     -cpu qemu (Since: 2.11):
+# .. qmp-example::
+#    :annotated:
+#
+#    For s390x-virtio-ccw machine type started with
+#    ``-smp 1,maxcpus=2 -cpu qemu`` (Since: 2.11)::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1130,12 +1137,15 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     -> { "execute": "balloon", "arguments": { "value": 536870912 } }
-#     <- { "return": {} }
+#    ::
 #
-#     With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#      -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+#      <- { "return": {} }
+#
+#    With a 2.5GiB guest this command inflated the ballon to 3GiB.
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 74968a14173..073b67c0524 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2106,13 +2106,16 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
 #                                                     "sample-pages": 512} }
 #     <- { "return": {} }
 #
-#     Measure dirty rate using dirty bitmap for 500 milliseconds:
+# .. qmp-example::
+#    :annotated:
+#
+#    Measure dirty rate using dirty bitmap for 500 milliseconds::
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
 #         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
diff --git a/qapi/virtio.json b/qapi/virtio.json
index d965c98ad2b..26df8b3064b 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -203,9 +203,11 @@
 #
 # Since: 7.2
 #
-# Examples:
+# .. qmp-example::
+#    :annotated:
 #
-#     1. Poll for the status of virtio-crypto (no vhost-crypto active)
+#    Poll for the status of virtio-crypto (no vhost-crypto active)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-status",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
@@ -261,7 +263,11 @@
 #          }
 #        }
 #
-#     2. Poll for the status of virtio-net (vhost-net is active)
+# .. qmp-example::
+#    :annotated:
+#
+#    Poll for the status of virtio-net (vhost-net is active)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-status",
 #          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
@@ -568,9 +574,11 @@
 #
 # Since: 7.2
 #
-# Examples:
+# .. qmp-example::
+#    :annotated:
 #
-#     1. Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+#    Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
 #          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
@@ -593,7 +601,11 @@
 #          }
 #        }
 #
-#     2. Get VirtQueueStatus for virtio-serial (no vhost)
+# .. qmp-example::
+#    :annotated:
+#
+#    Get VirtQueueStatus for virtio-serial (no vhost)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
 #          "arguments": { "path": "/machine/peripheral-anon/device[0]/virtio-backend",
-- 
2.45.0


