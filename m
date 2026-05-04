Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC3FCD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsRl-0000oy-VT; Mon, 04 May 2026 08:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsRT-0000jI-Je
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsRQ-0006Zd-D7
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OgU22ze7GVuxXACZGirfJSOSHdDNyiNw1gGQxOcMb+g=;
 b=D+ew/AORrYb/hwVDbL5Q4c+uRmcixkFL0Lo7Jcr547AyS/zQBeMD8luCE8sagsAI4Jfx0u
 XvnGqJM7dJS8f3fGBr4CfU5hI48eHx9bqQuYbpeVIH202hE27nqzhRqrK9jh5HSoEz6fee
 dbuSRNTQPNo5eSZjUSWrxy0QSJWJPmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-26UWwfNaOLqvxfzs1Ay78Q-1; Mon,
 04 May 2026 08:30:25 -0400
X-MC-Unique: 26UWwfNaOLqvxfzs1Ay78Q-1
X-Mimecast-MFC-AGG-ID: 26UWwfNaOLqvxfzs1Ay78Q_1777897823
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1921C19560B0
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:30:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B32C19560B6; Mon,  4 May 2026 12:30:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 00/13] Make RamDiscardManager work with multiple sources
 & virtio-mem
Date: Mon, 04 May 2026 16:30:06 +0400
Message-Id: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDE0MT3aKUXFPdJLOUNCNjM7MUMwNjJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAJ2/wg1oAAAA
X-Change-ID: 20260414-rdm5-b6df2366d603
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4131;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=83VEOCHOtaoYgZrtNdipg6m79xw6csBoimjFOwMyNak=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFYCyC+6HhEpb80k9nXfdtCV+wpUyzSM4cbn
 a/1tVThjuyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWAAKCRDa6OEJdZac
 5VwTEAClfCcv1A0dgUsH5+xfTGnB6+9yI87xAh07qdfvfKXb0GFlYCv6+5paDzzRO5kGk76Fw5x
 kMgRyDx5YK5BszDRm8YeDg65d7FDhzizFFckqB+25wMs3EOHwMCRsAKczxOhSo++YdGsM0BsFOY
 MOkPb5G5wfIaadM2kByBv92kNsXFudY+2aiLR3o4AbSw4A0dyVmVzEV7o963c56Ukw8Fn3I1S7U
 PfAcRwK6U/X/O9VlBSlqmirToZ1RK2mwB8H/YtuTbHrTkx5C3HPwpeM3AwO4FvpP5e4ZoX3RMgz
 lNy/Gkwe/GS8JXdmBUXbBDTPQxjd1fBjOrGfqynjWDMsWr+Ja7uNa5BVLeU+cqgVpOjPWd5le/e
 701QdNyIQka1Tcs8CPIrO1NAoDioJnsUG5PxaliG46aW3PCHhms2CqSBHPxFCHQUZImntJ2KYvu
 VTwu601xxV4+H1Ma6rYk9pZHfx6+7QHqDBdqJxvAso2WniWNJLMIUVZf0CbTZ81XY1gd49WUSHD
 ZnM5oyfLC95rIIPTVjgyJJznDDEc9mRKUB8w/oOqlT+RjfBnTj26gQX/oG/sKDmlR4dBZbC1oKB
 wY1gLPionD0aw2Z1g46XW6anU7Syty1iOn36rTLIDVff1I86Zmnvtf2ouTYIVKBGiZy+uQ+HE5G
 QmRc2ASdrBsyVFA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

This is an attempt to fix the incompatibility of virtio-mem with confidential
VMs. The solution implements what was discussed earlier with D. Hildenbrand:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238

The first patches are misc cleanups. Then some code refactoring to have split a
manager/source. And finally, the manager learns to deal with multiple sources.

I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
device. It would be nice to have more tests for those scenarios with
VFIO/virtio-mem/confvm.. In any case, review & testing needed!

(help fix https://issues.redhat.com/browse/RHEL-131968)

v4:
 - added "system/physmem: make ram_block_discard_range() handle guest_memfd"
 - added "monitor: add 'info ramblock-attributes' command"
 - added "RFC: hw/virtio: start virtio-mem guest_memfd regions as shared"
 - skip calling source in notify_populate (it may not have updated its
   internal state)
 - rebased, collected trailer tags

v3: issues found by Cédric
 - fix assertion error on shutdown, due to rcu-defer cleanup
 - fix API doc warnings

v2:
 - drop replay_{populated,discarded} from source, suggested by Peter Xu
 - add extra manager cleanup
 - add r-b tags for preliminary patches

---
Marc-André Lureau (13):
      system/memory: split RamDiscardManager into source and manager
      system/memory: move RamDiscardManager to separate compilation unit
      system/memory: constify section arguments
      system/ram-discard-manager: implement replay via is_populated iteration
      virtio-mem: remove replay_populated/replay_discarded implementation
      system/ram-discard-manager: drop replay from source interface
      system/memory: implement RamDiscardManager multi-source aggregation
      system/physmem: destroy ram block attributes before RCU-deferred reclaim
      system/memory: add RamDiscardManager reference counting and cleanup
      tests: add unit tests for RamDiscardManager multi-source aggregation
      system/physmem: make ram_block_discard_range() handle guest_memfd
      monitor: add 'info ramblock-attributes' command
      RFC: hw/virtio: start virtio-mem guest_memfd regions as shared

 MAINTAINERS                                 |    4 +
 qapi/machine.json                           |   55 ++
 include/hw/vfio/vfio-container.h            |    2 +-
 include/hw/vfio/vfio-cpr.h                  |    2 +-
 include/hw/virtio/virtio-mem.h              |    3 -
 include/monitor/hmp.h                       |    1 +
 include/system/memory.h                     |  283 +-----
 include/system/ram-discard-manager.h        |  358 ++++++++
 include/system/ramblock.h                   |    6 +-
 accel/kvm/kvm-all.c                         |    5 +-
 hw/core/machine-hmp-cmds.c                  |   32 +
 hw/vfio/cpr-legacy.c                        |    4 +-
 hw/vfio/listener.c                          |   10 +-
 hw/virtio/virtio-mem.c                      |  286 ++-----
 migration/ram.c                             |    6 +-
 system/memory.c                             |   83 +-
 system/memory_mapping.c                     |    4 +-
 system/physmem.c                            |   27 +-
 system/ram-block-attributes.c               |  329 +++----
 system/ram-discard-manager.c                |  612 +++++++++++++
 target/i386/kvm/tdx.c                       |    2 +-
 tests/unit/test-ram-discard-manager-stubs.c |   48 ++
 tests/unit/test-ram-discard-manager.c       | 1235 +++++++++++++++++++++++++++
 hmp-commands-info.hx                        |   13 +
 rust/bindings/system-sys/lib.rs             |    2 +-
 system/meson.build                          |    1 +
 system/trace-events                         |    2 +-
 tests/unit/meson.build                      |    8 +-
 28 files changed, 2597 insertions(+), 826 deletions(-)
---
base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
change-id: 20260414-rdm5-b6df2366d603

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


