Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1864FCEF152
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7s1-0001Gq-P7; Tue, 08 Oct 2024 06:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7ry-0001Fv-4A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7rv-0001bv-Ot
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OwG1I1Ns7Ph1SI9mpHX2AoEQeigyPjnlb2ofDe6A9cY=;
 b=flhjXVcG8wiav72SBi/Dj+fp5rMd2ZeqvD8GRwZCXPuQL4urYev0PRJQpp2XD+bvx8RgdR
 H/2b5AUQCPGiF4cg2Hl+YOO7i+kDKmIBU1vThPC7ZTW5kCprgnXnFri1Ntfvb4404aRTru
 nGUOUnDTWgpf5HP5Zpf/HO0N54dRKtE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-dD5JFP7mN7Gvg9ENhCBzRw-1; Tue,
 08 Oct 2024 06:55:04 -0400
X-MC-Unique: dD5JFP7mN7Gvg9ENhCBzRw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB8C81955D4D; Tue,  8 Oct 2024 10:55:02 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5933119560A3; Tue,  8 Oct 2024 10:54:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 00/14] s390x: virtio-mem support
Date: Tue,  8 Oct 2024 12:54:41 +0200
Message-ID: <20241008105455.2302628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Based on current master.

There is really not much left to do on s390x, because virtio-mem already
implements most things we need today (e.g., early-migration,
unplugged-inaccessible). The biggest part of this series is just doing what
we do with virtio-pci, wiring it up in the machine hotplug handler and ...
well, messing with the physical memory layout where we can now exceed
initial RAM size and have sparsity (memory holes).

I tested a lot of things, including:
 * Memory hotplug/unplug
 * Device hotplug/unplug
 * System resets / reboots
 * Migrate to/from file (including storage attributes under KVM)
 * Basic live migration
 * Basic postcopy live migration

More details on how to use it on s390x -- which is pretty much how
we use it on other architectures, except
s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.

This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
be documented in the kernel and at [2] once this+kernel part go upstream.

There are not many s390x-specific virtio-mem future work items, except:
* Storage attribute migration might be improved
* We might want to reset storage attributes of unplugged memory
  (might or might not be required for upcoming page table reclaim in
   Linux; TBD)

The Linux driver is available at [3].

[1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
[2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
[3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com

v1 -> v2:
* "s390x/s390-virtio-hcall: prepare for more diag500 hypercalls"
 - Turn handle_diag_500() into a void function
 - Inject PGM_SPECIFICATION from handle_diag_500() directly
* "s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to
   machine code"
 - Move code to a new function to make further changes easier
 - Adjust s390_pv_vm_try_disable_async() to stay in sync with the
   maxram->ram change
* "s390x: introduce s390_get_memory_limit()"
 - Store limit in machine
 - Move s390_set_memory_limit() from target code into machine code
* "s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT"
 - Move handling into a separate function now that we lookup the machine
* "s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory
   layouts"
 - Adjust to s390_get_memory_limit() changes
* "s390x/s390-skeys: prepare for memory devices"
 - Adjust to s390_get_memory_limit() changes
* "s390x/pv: prepare for memory devices"
 - Use s390_get_memory_limit()
* "s390x: remember the maximum page size"
 - Store it in the machine
 - Move s390_set_max_pagesize() from target code into machine code
 - No need for s390_get_max_pagesize()
* "s390x/virtio-ccw: add support for virtio based memory devices"
 - Move machine wire-up code from virtio-mem patch into this patch
 - Add stubs to make compilation without virtio-mem work
* "s390x: virtio-mem support"
 - Move machine write-up code to previous patch

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>

David Hildenbrand (14):
  s390x/s390-virtio-ccw: don't crash on weird RAM sizes
  s390x/s390-virtio-hcall: remove hypercall registration mechanism
  s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
  s390x: rename s390-virtio-hcall* to s390-hypercall*
  s390x/s390-virtio-ccw: move setting the maximum guest size from sclp
    to machine code
  s390x: introduce s390_get_memory_limit()
  s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
  s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory
    layouts
  s390x/s390-skeys: prepare for memory devices
  s390x/s390-virtio-ccw: prepare for memory devices
  s390x/pv: prepare for memory devices
  s390x: remember the maximum page size
  s390x/virtio-ccw: add support for virtio based memory devices
  s390x: virtio-mem support

 MAINTAINERS                        |   5 +
 hw/s390x/Kconfig                   |   1 +
 hw/s390x/meson.build               |   6 +-
 hw/s390x/s390-hypercall.c          |  85 +++++++++++
 hw/s390x/s390-hypercall.h          |  25 ++++
 hw/s390x/s390-skeys.c              |   6 +-
 hw/s390x/s390-stattrib-kvm.c       |  67 ++++++---
 hw/s390x/s390-virtio-ccw.c         | 165 ++++++++++++++-------
 hw/s390x/s390-virtio-hcall.c       |  41 ------
 hw/s390x/s390-virtio-hcall.h       |  25 ----
 hw/s390x/sclp.c                    |  17 +--
 hw/s390x/virtio-ccw-md-stubs.c     |  24 +++
 hw/s390x/virtio-ccw-md.c           | 153 +++++++++++++++++++
 hw/s390x/virtio-ccw-md.h           |  44 ++++++
 hw/s390x/virtio-ccw-mem.c          | 226 +++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-mem.h          |  34 +++++
 hw/virtio/Kconfig                  |   1 +
 hw/virtio/virtio-mem.c             |   4 +-
 include/hw/s390x/s390-virtio-ccw.h |   4 +
 target/s390x/cpu-sysemu.c          |  15 --
 target/s390x/cpu.h                 |   2 -
 target/s390x/kvm/kvm.c             |  18 +--
 target/s390x/kvm/pv.c              |   2 +-
 target/s390x/tcg/misc_helper.c     |   7 +-
 24 files changed, 782 insertions(+), 195 deletions(-)
 create mode 100644 hw/s390x/s390-hypercall.c
 create mode 100644 hw/s390x/s390-hypercall.h
 delete mode 100644 hw/s390x/s390-virtio-hcall.c
 delete mode 100644 hw/s390x/s390-virtio-hcall.h
 create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
 create mode 100644 hw/s390x/virtio-ccw-md.c
 create mode 100644 hw/s390x/virtio-ccw-md.h
 create mode 100644 hw/s390x/virtio-ccw-mem.c
 create mode 100644 hw/s390x/virtio-ccw-mem.h

-- 
2.46.1


