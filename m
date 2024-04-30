Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FD7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgh-0006LN-7X; Tue, 30 Apr 2024 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgI-0005zO-Bb
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:15 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgF-0005pu-C1
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:14 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e09138a2b1so29121011fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495808; x=1715100608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVjR1/Zvy9eh6tF4LUGS9KbJtamZ1d/0apzG3iHgn8A=;
 b=eHs5gT8SO7K4p4zwK27bXU8iS0KzoBIPtXU6LOS4fkJZf2lx/NN+n8Hro+6Qtej6HD
 +/VXM4/vw6xPK9BAHE8Kc96HN9+3tSioYkO0RChPwszqQ0wb2LkTgLlsYbaO/k+svmgT
 jYsMUWeoQ23kdx5BEn0VvwGBBbAaJw3qVZv645PD6jGooYjEPNou9T+A74n0zNJHFvFg
 Un7JcDNEkD7/kinNwuC7JNXghdbuFBaVlDf+VQBIztYiMb2ORep7Rldawkb00HyacTsG
 wyWBYafARS83AT/NSFh+yHssED0ZRqO6JOoCu3Byb/HMkQd5psDvSBhcwxSR3Ec/rWnY
 IncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495808; x=1715100608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVjR1/Zvy9eh6tF4LUGS9KbJtamZ1d/0apzG3iHgn8A=;
 b=GcCSoL7G45ymI3SPch+BeKtcSOA5WP86XZz0HwlSsi3dZ/vUvoyh0FPFAvslqLKT0A
 wytprJXTZGMtWZ+UVULRtQ3Ol7HQ1DwwSPj0rK4e0nAuQglVlrvKa15vu0CClT6NFZe2
 1nDss6EhKHN2PbOUHjiwj1lnXfeJkmOtuJ8x9vjKFKa06YpuERfKuCWFqNr5OBW1mawJ
 khep9NrCboWZHty0otjCdkWhq0xrp/zE+sK1hV/mevJpAh5CLPDTqYyxkNkV3ZdSxP84
 56xcsqDcuSzh/hHkJHZvNlyKZL6N/uq5h6URgo6Ha0a9yP3hmoo5X1FjACi0janZftFc
 0r7Q==
X-Gm-Message-State: AOJu0YylZaFauFnAzUisVdqUzsf+Hbalf7FmnyI/1H9qKl3rwepcWO2S
 A8/g1p1fCDp1BVOCepIkyASwALpm4mXYSxQWHoFnkynHIHampL8f2LgkQ//L
X-Google-Smtp-Source: AGHT+IEJFCC/WC1/UZT8ews/QcZF7Et9pZs+DQFzwPNtEzrf5cVS6rqXergKubynyE7A/CmEMffhTg==
X-Received: by 2002:a2e:3e01:0:b0:2e0:c659:3a8d with SMTP id
 l1-20020a2e3e01000000b002e0c6593a8dmr167136lja.21.1714495807864; 
 Tue, 30 Apr 2024 09:50:07 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a2e9b57000000b002d46df91965sm4018226ljj.80.2024.04.30.09.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:07 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 00/17] xen: Support grant mappings
Date: Tue, 30 Apr 2024 18:49:22 +0200
Message-Id: <20240430164939.925307-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Hi,

This is a follow-up on Vikrams v3:
http://next.patchew.org/QEMU/20240227223501.28475-1-vikram.garhwal@amd.com/

Grant mappings are a mechanism in Xen for guests to grant each other
permissions to map and share pages. These grants can be temporary
so both map and unmaps must be respected. See here for more info:
https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt

Currently, the primary use-case for this is with QEMU's VirtIO backends.
Grant mappings will only work with models that use the address_space_map/unmap
interfaces, any other access will fail with appropriate error messages.

In response to feedback we got on v3, this version switches approach
from adding new MemoryRegion types and map/unmap hooks to instead reusing
the existing xen_map_cache() hooks (with extensions). Almost all of the
changes are now contained to the Xen modules.

This approach also refactors the mapcache to support multiple instances
(one for existing foreign mappings and another for grant mappings).

Patch 1 - 10 are refactorings with minimal functional changes.
Patch 3 - 10 could possibly get squashed into one but I've left them
separate to make them easier to review.

I've only enabled grants for the ARM PVH machine since that is what
I can currently test on.

Cheers,
Edgar

ChangeLog:

v3 -> v4:
* Major changes.
* Reuse existing xen_map_cache hooks.
* Reuse existing map-cache for both foreign and grant mappings.
* Only enable grants for the ARM PVH machine (removed i386).

v2 -> v3:
* Drop patch 1/7. This was done because device unplug is an x86-only case.
* Add missing qemu_mutex_unlock() before return.

v1 -> v2:
* Split patch 2/7 to keep phymem.c changes in a separate.
* In patch "xen: add map and unmap callbacks for grant" add check for total
  allowed grant < XEN_MAX_VIRTIO_GRANTS.
* Fix formatting issues and re-based with master latest.

Edgar E. Iglesias (15):
  xen: mapcache: Refactor lock functions for multi-instance
  xen: mapcache: Refactor xen_map_cache for multi-instance
  xen: mapcache: Refactor xen_remap_bucket for multi-instance
  xen: mapcache: Break out xen_ram_addr_from_mapcache_single
  xen: mapcache: Refactor xen_replace_cache_entry_unlocked
  xen: mapcache: Refactor xen_invalidate_map_cache_entry_unlocked
  xen: mapcache: Break out xen_invalidate_map_cache_single()
  xen: mapcache: Break out xen_map_cache_init_single()
  xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime configurable
  xen: mapcache: Unmap first entries in buckets
  softmmu: Pass RAM MemoryRegion and is_write xen_map_cache()
  xen: Add xen_mr_is_memory()
  xen: mapcache: Remove assumption of RAMBlock with 0 offset
  xen: mapcache: Add support for grant mappings
  hw/arm: xen: Enable use of grant mappings

Juergen Gross (2):
  softmmu: let qemu_map_ram_ptr() use qemu_ram_ptr_length()
  xen: let xen_ram_addr_from_mapcache() return -1 in case of not found
    entry

 hw/arm/xen_arm.c                |   5 +
 hw/xen/xen-hvm-common.c         |  16 +-
 hw/xen/xen-mapcache.c           | 408 +++++++++++++++++++++-----------
 include/hw/xen/xen-hvm-common.h |   3 +
 include/sysemu/xen-mapcache.h   |  13 +-
 include/sysemu/xen.h            |  15 ++
 system/physmem.c                |  83 ++++---
 7 files changed, 365 insertions(+), 178 deletions(-)

-- 
2.40.1


