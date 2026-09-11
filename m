Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33DDC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57tx-0001Pc-6q; Fri, 11 Sep 2026 16:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tT-0001L1-PW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tR-00057W-KS
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789158639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4j5x+zHcMcWnQDIHgjrGifJeCHeIkjIz2iqGNtVg/1k=;
 b=aTd+SghYECi//aJHKcln4TTQctqyxREvE6RlpbqWkCk4I426RnBjMAZdA0+gPsE6KiAheZ
 dUYUYs6yXUYwZ4jfX+UIMYN7hrcewOCvaNGXsFjn4l4YW6mSC5upOyqfNIGKztGg77wi8X
 Yu4AOzHQNfFT4aDFKPWL+Occ3Qj80Lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ZHGXpqHiOeurOildHJwObQ-1; Fri,
 11 Sep 2026 16:30:35 -0400
X-MC-Unique: ZHGXpqHiOeurOildHJwObQ-1
X-Mimecast-MFC-AGG-ID: ZHGXpqHiOeurOildHJwObQ_1789158634
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 312A31802676; Fri, 11 Sep 2026 20:30:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E21D641B; Fri, 11 Sep 2026 20:30:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 4/9] qapi: convert multi-paragraph intros (structs)
Date: Fri, 11 Sep 2026 16:29:57 -0400
Message-ID: <20260911203002.305316-5-jsnow@redhat.com>
In-Reply-To: <20260911203002.305316-1-jsnow@redhat.com>
References: <20260911203002.305316-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch converts some slightly-non-trivial intros with more than
one paragraph, but doesn't create any new intro/details splits.

Review notes: Again, the Numa Hmat options have text that are prime
candidates for a ".. seealso::" admonition, but I was uncertain as to
whether this information was principally for developers or for
users. If it's for developers, it can stay in the intro where it will
be dropped when inlined. If it is for users, they should be moved into
the details region.

The remaining structs have an awful lot of text, but I was not
immediately sure of which information we wanted to preserve when
inlined or not; these structures tend to be written as if they are
describing a command, but they actually only define a set of
arguments.

Advice? Opinions?

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 17 ++++++++---------
 qapi/net.json     | 34 +++++++++++++++-------------------
 qapi/qom.json     | 18 +++++++++---------
 3 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 710b638b3bf..aaecd151407 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -657,12 +657,11 @@
 
 ##
 # @NumaHmatLBOptions:
+#     Set the system locality latency and bandwidth information
+#     between Initiator and Target proximity Domains.
 #
-# Set the system locality latency and bandwidth information between
-# Initiator and Target proximity Domains.
-#
-# For more information about `NumaHmatLBOptions`, see chapter
-# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
+#     For more information about `NumaHmatLBOptions`, see chapter
+#     5.2.27.4: Table 5-146 of ACPI 6.3 spec.
 #
 # @initiator: the Initiator Proximity Domain.
 #
@@ -734,11 +733,11 @@
 
 ##
 # @NumaHmatCacheOptions:
+#     Set the memory side cache information for a given memory domain.
 #
-# Set the memory side cache information for a given memory domain.
-#
-# For more information of `NumaHmatCacheOptions`, see chapter
-# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+#     For more information of `NumaHmatCacheOptions`, see chapter
+#     5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3
+#     spec.
 #
 # @node-id: the memory proximity domain to which the memory belongs.
 #
diff --git a/qapi/net.json b/qapi/net.json
index 7aabd8b9260..50dc3137182 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -681,11 +681,10 @@
 
 ##
 # @NetdevVhostVDPAOptions:
+#     Vhost-vdpa network backend
 #
-# Vhost-vdpa network backend
-#
-# vDPA device is a device that uses a datapath which complies with the
-# virtio specifications with a vendor specific control path.
+#     vDPA device is a device that uses a datapath which complies with
+#     the virtio specifications with a vendor specific control path.
 #
 # @vhostdev: path of vhost-vdpa device (default:'/dev/vhost-vdpa-0')
 #
@@ -712,11 +711,10 @@
 
 ##
 # @NetdevVmnetHostOptions:
+#     vmnet (host mode) network backend.
 #
-# vmnet (host mode) network backend.
-#
-# Allows the vmnet interface to communicate with other vmnet
-# interfaces that are in host mode and also with the host.
+#     Allows the vmnet interface to communicate with other vmnet
+#     interfaces that are in host mode and also with the host.
 #
 # @start-address: The starting IPv4 address to use for the interface.
 #     Must be in the private IP range (RFC 1918).  Must be specified
@@ -755,15 +753,14 @@
 
 ##
 # @NetdevVmnetSharedOptions:
+#     vmnet (shared mode) network backend.
 #
-# vmnet (shared mode) network backend.
-#
-# Allows traffic originating from the vmnet interface to reach the
-# Internet through a network address translator (NAT).  The vmnet
-# interface can communicate with the host and with other shared mode
-# interfaces on the same subnet.  If no DHCP settings, subnet mask and
-# IPv6 prefix specified, the interface can communicate with any of
-# other interfaces in shared mode.
+#     Allows traffic originating from the vmnet interface to reach the
+#     Internet through a network address translator (NAT).  The vmnet
+#     interface can communicate with the host and with other shared
+#     mode interfaces on the same subnet.  If no DHCP settings, subnet
+#     mask and IPv6 prefix specified, the interface can communicate
+#     with any of other interfaces in shared mode.
 #
 # @start-address: The starting IPv4 address to use for the interface.
 #     Must be in the private IP range (RFC 1918).  Must be specified
@@ -800,10 +797,9 @@
 
 ##
 # @NetdevVmnetBridgedOptions:
+#     vmnet (bridged mode) network backend.
 #
-# vmnet (bridged mode) network backend.
-#
-# Bridges the vmnet interface with a physical network interface.
+#     Bridges the vmnet interface with a physical network interface.
 #
 # @ifname: The name of the physical interface to be bridged.
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 51af9485e6d..3de06488768 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1033,16 +1033,16 @@
 
 ##
 # @SevSnpGuestProperties:
+#     Properties for sev-snp-guest objects.  Most of these are direct
+#     arguments for the KVM_SNP_* interfaces documented in the Linux
+#     kernel source under
+#     Documentation/arch/x86/amd-memory-encryption.rst, which are in
+#     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
+#     commands documented in the SEV-SNP Firmware ABI Specification
+#     (Rev 0.9).
 #
-# Properties for sev-snp-guest objects.  Most of these are direct
-# arguments for the KVM_SNP_* interfaces documented in the Linux
-# kernel source under
-# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
-# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
-# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
-#
-# More usage information is also available in the QEMU source tree
-# under docs/amd-memory-encryption.
+#     More usage information is also available in the QEMU source tree
+#     under docs/amd-memory-encryption.
 #
 # @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
 #     defined in the SEV-SNP firmware ABI (default: 0x30000)
-- 
2.55.0


