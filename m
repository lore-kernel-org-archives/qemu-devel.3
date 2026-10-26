Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F22606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7LpA5W7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJZv-00008x-4O; Mon, 26 Oct 2026 08:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLJZs-000084-9Q; Mon, 26 Oct 2026 08:13:24 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLJZq-0005zg-MZ; Mon, 26 Oct 2026 08:13:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE91D601FE;
 Mon, 26 Oct 2026 12:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A65F1F031E0;
 Mon, 26 Oct 2026 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793016801;
 bh=Yyr8Vef3hJZm81XPHmzhgHQDPuVtINKQOKAaS7xtcP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n7LpA5W7ocCvzkJ9gpWIYGIo9Bwocn3ZJnoNkuQio6jbRMgqDAdspA6qOkjry+TNR
 wDklcfkjoiGXR/6d1jWIPxhrlUsQBe8C4iHSncAmv5g9FSH6MfHWOj8eb2ytDq8Dqr
 8qtqa4DFy9Fiwfxvj4iCUIcHdpVSepLR/a0oQBYVv61WJVoBCpvTEzevMpPcA1QLQs
 6tellwjfvnrvJ0nrzUoc5g5y/MRQW+HaVKbKjT9qaToPChs3ET18g5EbWnbcNJ04YN
 wjAPapbpX2sDCw0+zzB0o7lz0U8v1sBz4MHa7s9NWvCcPrp+Ee2Ge0BP8SNVJ/S4iD
 KxEz/ttsvSMOA==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v15 3/7] block: define errnos for zone protocol errors
Date: Mon, 26 Oct 2026 13:12:51 +0100
Message-ID: <20261026121259.3354561-4-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026121259.3354561-1-cassel@kernel.org>
References: <20261026121259.3354561-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A block driver that emulates zones (e.g. qcow2 with the zoned format
feature) rejects requests that violate the zone protocol, and the device
model has to report each of these to the guest with the matching zone
error (ZAC/ZBC sense data, virtio-blk zone status codes, ...). It can
only do so if each condition comes with an errno of its own, rather than
a generic one such as EIO.

Define one for each condition:

  BLK_ZE_UNALIGNED_WRITE  ESPIPE        write not at the write pointer
  BLK_ZE_BOUNDARY         ERANGE        write past the zone capacity
  BLK_ZE_OPEN_RESOURCE    ETOOMANYREFS  open zone limit reached
  BLK_ZE_ACTIVE_RESOURCE  EOVERFLOW     active zone limit reached

ETOOMANYREFS and EOVERFLOW are what Linux returns for
BLK_STS_ZONE_OPEN_RESOURCE and BLK_STS_ZONE_ACTIVE_RESOURCE, so a host
zoned device used through file-posix already reports the same values.
For the boundary case, ERANGE is used rather than EFBIG, which the host
file system can legitimately return for an image file.

A write that is not at the write pointer gets ESPIPE, which file and
block device I/O never return, rather than EINVAL, which a zoned driver
also uses for invalid requests such as an invalid zone state
transition. So a device model can map each of these errnos to its zone
error without having to know which request failed.

ETOOMANYREFS is not POSIX, so provide a fallback for hosts that lack it.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/block/block-common.h | 16 ++++++++++++++++
 include/qemu/osdep.h         |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 3932ff8615..6e4b2eb3ce 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -125,6 +125,22 @@ typedef struct BlockZoneDescriptor {
     BlockZoneState state;
 } BlockZoneDescriptor;
 
+/*
+ * Errors that zoned block drivers report for zone protocol violations, as
+ * positive errno values (drivers return them negated). Each condition has an
+ * errno of its own that zoned block drivers do not return for anything else,
+ * so that device models can report the matching zone error to the guest
+ * whichever request failed. In particular, EINVAL is not used, as it also
+ * reports invalid requests, such as an invalid zone state transition. The
+ * zone resource errors are the errnos Linux uses for BLK_STS_ZONE_OPEN_RESOURCE
+ * and BLK_STS_ZONE_ACTIVE_RESOURCE, so a host zoned device accessed through
+ * file-posix reports the same values.
+ */
+#define BLK_ZE_UNALIGNED_WRITE  ESPIPE       /* write not at write pointer */
+#define BLK_ZE_BOUNDARY         ERANGE       /* write past zone capacity */
+#define BLK_ZE_OPEN_RESOURCE    ETOOMANYREFS /* open zone limit reached */
+#define BLK_ZE_ACTIVE_RESOURCE  EOVERFLOW    /* active zone limit reached */
+
 /*
  * Track write pointers of a zone in bytes.
  */
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 50c7ce33b6..7925c28ac3 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -345,6 +345,9 @@ void QEMU_ERROR("code path is reachable")
 #if !defined(ESHUTDOWN)
 #define ESHUTDOWN 4099
 #endif
+#if !defined(ETOOMANYREFS)
+#define ETOOMANYREFS 4100
+#endif
 
 #define RETRY_ON_EINTR(expr) \
     (__extension__                                          \
-- 
2.56.0


