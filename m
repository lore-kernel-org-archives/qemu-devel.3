Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F16D6EC0B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1Sw-0007XP-Mn; Fri, 29 Nov 2024 08:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH1Su-0007WI-3A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH1Ss-0004ly-9O
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732888520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4q8ZDel6iQN7p7D84KEIc2Y3xpUsYoQDuwcR6Shl9fQ=;
 b=ivRTa/d/mDx+9Twp1L7ovjyj/dow0oKBdUcrHYi4aKBTgDi8nXYk8VmgdRSRu077AqSdTp
 dHGK9KSb4ogwPhm7Y0rhL8UbW76ly+9Cs/F06xF/2oTE13L3TMpsY3iGAxLQk7M5MX2vXC
 VVIJ3O1z5lQKOx9slo6on8rLok5U6MU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-0eEcy7IhMqSGyYd0BoY22A-1; Fri,
 29 Nov 2024 08:55:17 -0500
X-MC-Unique: 0eEcy7IhMqSGyYd0BoY22A-1
X-Mimecast-MFC-AGG-ID: 0eEcy7IhMqSGyYd0BoY22A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624A7195422C; Fri, 29 Nov 2024 13:55:16 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EB061955D47; Fri, 29 Nov 2024 13:55:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/3 for 9.2] hw/virtio: fix crash in processing balloon
 stats
Date: Fri, 29 Nov 2024 13:55:05 +0000
Message-ID: <20241129135507.699030-2-berrange@redhat.com>
In-Reply-To: <20241129135507.699030-1-berrange@redhat.com>
References: <20241129135507.699030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

balloon_stats_get_all will iterate over guest stats upto the max
VIRTIO_BALLOON_S_NR value, calling visit_type_uint64 to populate
the QObject dict. The dict keys are obtained from the static
array balloon_stat_names which is VIRTIO_BALLOON_S_NR in size.

Unfortunately the way that array is declared results in any
unassigned stats getting a NULL name, which will then cause
visit_type_uint64 to trigger an assert in qobject_output_add_obj.

The balloon_stat_names array was fortunately fully populated with
names until recently:

  commit 0d2eeef77a33315187df8519491a900bde4a3d83
  Author: Bibo Mao <maobibo@loongson.cn>
  Date:   Mon Oct 28 10:38:09 2024 +0800

    linux-headers: Update to Linux v6.12-rc5

pulled a change to include/standard-headers/linux/virtio_balloon.h
which increased VIRTIO_BALLOON_S_NR by 6, and failed to add the new
names to balloon_stat_names.

This commit fills in the missing names, and uses a static assert to
guarantee that any future changes to VIRTIO_BALLOON_S_NR will cause
a build failure until balloon_stat_names is updated.

This problem was detected by the Cockpit Project's automated
integration tests on QEMU 9.2.0-rc1.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2329448
Fixes: 0d2eeef77a33315187df8519491a900bde4a3d83
Reported-by: Martin Pitt <mpitt@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/virtio/virtio-balloon.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 609e39a821..afd2ad6dd6 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -167,19 +167,33 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     }
 }
 
+/*
+ * All stats upto VIRTIO_BALLOON_S_NR /must/ have a
+ * non-NULL name declared here, since these are used
+ * as keys for populating the QDict with stats
+ */
 static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
    [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
    [VIRTIO_BALLOON_S_MAJFLT] = "stat-major-faults",
    [VIRTIO_BALLOON_S_MINFLT] = "stat-minor-faults",
    [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
+
    [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
    [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
    [VIRTIO_BALLOON_S_HTLB_PGALLOC] = "stat-htlb-pgalloc",
    [VIRTIO_BALLOON_S_HTLB_PGFAIL] = "stat-htlb-pgfail",
-   [VIRTIO_BALLOON_S_NR] = NULL
+
+   [VIRTIO_BALLOON_S_OOM_KILL] = "stat-oom-kills",
+   [VIRTIO_BALLOON_S_ALLOC_STALL] = "stat-alloc-stalls",
+   [VIRTIO_BALLOON_S_ASYNC_SCAN] = "stat-async-scans",
+   [VIRTIO_BALLOON_S_DIRECT_SCAN] = "stat-direct-scans",
+   [VIRTIO_BALLOON_S_ASYNC_RECLAIM] = "stat-async-reclaims",
+
+   [VIRTIO_BALLOON_S_DIRECT_RECLAIM] = "stat-direct-reclaims",
 };
+G_STATIC_ASSERT(G_N_ELEMENTS(balloon_stat_names) == VIRTIO_BALLOON_S_NR);
 
 /*
  * reset_stats - Mark all items in the stats array as unset
-- 
2.46.0


