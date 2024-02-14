Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00CAC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH10-0007qS-At; Wed, 14 Feb 2024 10:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0y-0007ps-R8
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0x-0000O1-5G
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bSccHHa1hkDF2GHxTm35urL2B47v/oiNRgiAeoNeJ28=;
 b=M35S/DNYkgDE54q41J9NmBTkPOvybt0QA39qPd8AgrUds4BeiocamdWCbmtavBX5bXzmMZ
 YOrEo6Ho7Pb7UsvQCo4+jAMc41ElwpOJ6zvgIO8Q0XVXv+k+vArNF9ogScjBzxM81OaPBu
 hq9aaar4NcTZXFgjwhnSETiRi/IrGmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-SqZ4WGn0PAuF0cTaQI4Q1g-1; Wed, 14 Feb 2024 10:17:19 -0500
X-MC-Unique: SqZ4WGn0PAuF0cTaQI4Q1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70A4283F270;
 Wed, 14 Feb 2024 15:17:05 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B9561C066AA;
 Wed, 14 Feb 2024 15:17:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v2 00/14] libvhost-user: support more memslots and cleanup
 memslot handling code
Date: Wed, 14 Feb 2024 16:16:47 +0100
Message-ID: <20240214151701.29906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
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

This series adds support for more memslots (509) to libvhost-user, to
make it fully compatible with virtio-mem that uses up to 256 memslots
accross all memory devices in "dynamic-memslot" mode (more details
in patch #2).

With that in place, this series optimizes and extends memory region
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

v1 -> v2:
* Drop "libvhost-user: Fix msg_region->userspace_addr computation"
 -> Not actually required
* "libvhost-user: Factor out adding a memory region"
 -> Make debug output more consistent (add missing ":")
* "libvhost-user: Use most of mmap_offset as fd_offset"
 -> get_fd_pagesize -> get_fd_hugepagesize; remove getpagesize()
 -> "mmap_offset:" to "old mmap_offset:" in debug message
 -> "adj mmap_offset:" to "new mmap_offset:" in debug message
 -> Use "(unsigned int)fs.f_type"; the man page of fstatfs() calls out
    that the type of f_type can vary depending on the architecture.
    "unsigned int" is sufficient here.
 -> Updated patch description
* Added RBs+ACKs
* Did a Gitlab CI run, seems to be happy reagrding libvhost-user

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Germano Veit Michel <germano@redhat.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>

David Hildenbrand (14):
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

 subprojects/libvhost-user/libvhost-user.c | 595 ++++++++++++----------
 subprojects/libvhost-user/libvhost-user.h |  10 +-
 2 files changed, 334 insertions(+), 271 deletions(-)

-- 
2.43.0


