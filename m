Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0982FC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1Tq-000899-2c; Fri, 02 Feb 2024 16:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1To-00088J-5z
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tm-0004pv-OA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eAfGPNGoSRQyzVD/lvMDqGy5ykgvWIQwuk7OacjeIQ8=;
 b=G5orB0Ayn+VFlMJO3w+F2vfWtKaq+tPWZdsltYNHRFsBgdEQt/v/XDH04lALICAOjyKosW
 tBfcps860MuaXJHR1/YRaJiWu+EQy5FKkS/rG7/EAf4EMA5YLhyXLe2Fh6Qd3EwqOOVuo9
 ywcBhQOxTnU0gMi3ymK6p9zsgiV3Wv4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-iRxNVwHAOfKE6nueQ8cRCQ-1; Fri,
 02 Feb 2024 16:53:41 -0500
X-MC-Unique: iRxNVwHAOfKE6nueQ8cRCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE9012812FEA;
 Fri,  2 Feb 2024 21:53:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B01942166B31;
 Fri,  2 Feb 2024 21:53:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 00/15] libvhost-user: support more memslots and cleanup
 memslot handling code
Date: Fri,  2 Feb 2024 22:53:17 +0100
Message-ID: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series adds support for more memslots (509) to libvhost-user, to
make it fully compatible with virtio-mem that uses up to 256 memslots
accross all memory devices in "dynamic-memslot" mode (more details
in patch #3).

One simple fix upfront.

With that in place, this series optimizes and extens memory region
handling in libvhost-user:
* Heavily deduplicate and clean up the memory region handling code
* Speeds up GPA->VA translation with many memslots using binary search
* Optimize mmap_offset handling to use it as fd_offset for mmap()
* Avoid ring remapping when adding a single memory region
* Avoid dumping all guest memory, possibly allocating memory in sparse
  memory mappings when the process crashes

I'm being very careful to not break some weird corner case that modern
QEMU might no longer trigger, but older one could have triggered or some
other frontend might trigger.

The only thing where I am not careful is to forbid memory regions that
overlap in GPA space: it doesn't make any sense.

With this series, virtio-mem (with dynamic-memslots=on) +
qemu-storage-daemon works flawlessly and as expected in my tests.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Germano Veit Michel <germano@redhat.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>

David Hildenbrand (15):
  libvhost-user: Fix msg_region->userspace_addr computation
  libvhost-user: Dynamically allocate memory for memory slots
  libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS to 509
  libvhost-user: Factor out removing all mem regions
  libvhost-user: Merge vu_set_mem_table_exec_postcopy() into
    vu_set_mem_table_exec()
  libvhost-user: Factor out adding a memory region
  libvhost-user: No need to check for NULL when unmapping
  libvhost-user: Don't zero out memory for memory regions
  libvhost-user: Don't search for duplicates when removing memory
    regions
  libvhost-user: Factor out search for memory region by GPA and simplify
  libvhost-user: Speedup gpa_to_mem_region() and vu_gpa_to_va()
  libvhost-user: Use most of mmap_offset as fd_offset
  libvhost-user: Factor out vq usability check
  libvhost-user: Dynamically remap rings after (temporarily?) removing
    memory regions
  libvhost-user: Mark mmap'ed region memory as MADV_DONTDUMP

 subprojects/libvhost-user/libvhost-user.c | 593 ++++++++++++----------
 subprojects/libvhost-user/libvhost-user.h |  10 +-
 2 files changed, 332 insertions(+), 271 deletions(-)

-- 
2.43.0


