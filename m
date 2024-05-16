Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3977C25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dL5-0007e7-88; Thu, 16 May 2024 11:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL3-0007bC-M8
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:13 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL1-0002tj-Sb
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:13 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51f60817e34so1264768e87.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715874488; x=1716479288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9P70DJ3Qlxb99JMgMDeD/bhw90eqeQUZf9UbR05GyHs=;
 b=FbSHrO+94ez/DO3+2WFzNUmFoDqTs9vyPvdNNT7m4z/GPMVBz3v3IhjHF/yT87NxVc
 PIxTpif7NY2ulnqPTjtgmOZKUT3DUJYfXPGwifBhosqAd6qdplHnV3VY8lfDrbsBQAVS
 XezxXuAHrHDV1joGcxyzad/iFLnfsDvCZwocS8OZvCOzczwe6VcuY0OCQ6pGiPZvY65p
 D/M/aA0w+Tb23TcZ6M9agK/yzUo9sS0DgdbCYkCCfeJGXQYhOrJnQX8yfAr24j+PHjec
 HHXcKj264inTNgkidtHbfJnJz7zYB2aoDN6d1UFn1rc9XQjYAv1jgPaxHiVmQxh+VGtN
 /ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715874488; x=1716479288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9P70DJ3Qlxb99JMgMDeD/bhw90eqeQUZf9UbR05GyHs=;
 b=gtjBZesqPSVuiQm0/ckPyeKvSOWuT++l3AgXgXxLhCsiixnXJteU1w6gtghfWpRiZK
 tO0TjqGj6XUFk7pKDqZW/anIuWlINFFAUCLIfJZ9hc8o/k6A6yA3GwFd7Ks399JGVeH1
 WMi4Ng5KQObEw2AUif11JzE4SToe2FLBdHuxiX21XIntFqxI8H/0WNac64RrrA+pjjFB
 g1Fmkuu/PGssaUOOJlS80wYtloemP+Dcsz8RbyyRFW5rcMpsUMV0n4l57Xzk1HErmbCA
 KKq06LFFLZ1v+rDrGm1OjIiBhCPf1LwLCjKe/l/IkKCH8NY/kSqq8JyphIVbK/PzjmoC
 AwnA==
X-Gm-Message-State: AOJu0YwPmL6OtvTm+lC8M2NLk/IsB3TvFwJvWw5eTRp+OQlABu6cdsPW
 yPGHlGtEgTqrKH1IEXOTcM+ichen/wjbQyMaSMiaFn64Satm85q4eiLk2IbKmcA=
X-Google-Smtp-Source: AGHT+IG0ESk3l8eW73wVBEK0qUdV+certcNCqSMRRYtqlBZIJthFtoHDK0VxEywLzqn/7pLFG1r1aA==
X-Received: by 2002:ac2:43af:0:b0:521:9207:189d with SMTP id
 2adb3069b0e04-5220ff72f4emr11331683e87.65.1715874487712; 
 Thu, 16 May 2024 08:48:07 -0700 (PDT)
Received: from gmail.com ([213.0.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42014c21260sm160833465e9.3.2024.05.16.08.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:48:07 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v6 0/8] xen: Support grant mappings
Date: Thu, 16 May 2024 17:47:56 +0200
Message-Id: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
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

Grant mappings are a mechanism in Xen for guests to grant each other
permissions to map and share pages. These grants can be temporary
so both map and unmaps must be respected. See here for more info:
https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt

Currently, the primary use-case for grants in QEMU, is with VirtIO backends.
Grant mappings will only work with models that use the address_space_map/unmap
interfaces, any other access will fail with appropriate error messages.

In response to feedback we got on v3, later version switch approach
from adding new MemoryRegion types and map/unmap hooks to instead reusing
the existing xen_map_cache() hooks (with extensions). Almost all of the
changes are now contained to the Xen modules.

This approach also refactors the mapcache to support multiple instances
(one for existing foreign mappings and another for grant mappings).

I've only enabled grants for the ARM PVH machine since that is what
I can currently test on.

Cheers,
Edgar

ChangeLog:

v5 -> v6:
* Correct passing of ram_addr_offset in xen_replace_cache_entry_unlocked.

v4 -> v5:
* Compute grant_ref from address_index to xen_remap_bucket().
* Rename grant_is_write to is_write.
* Remove unnecessary + mc->bucket_size - 1 in
  xen_invalidate_map_cache_entry_unlocked().
* Remove use of global mapcache in refactor of
  xen_replace_cache_entry_unlocked().
* Add error checking for xengnttab_unmap().
* Add assert in xen_replace_cache_entry_unlocked() against grant mappings.
* Fix memory leak when freeing first entry in mapcache buckets.
* Assert that bucket_shift is >= XC_PAGE_SHIFT when creating mapcache.
* Add missing use of xen_mr_is_memory() in hw/xen/xen-hvm-common.c.
* Rebase with master.

v3 -> v4:
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


Edgar E. Iglesias (8):
  xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime configurable
  xen: mapcache: Unmap first entries in buckets
  xen: Add xen_mr_is_memory()
  softmmu: xen: Always pass offset + addr to xen_map_cache
  softmmu: Replace check for RAMBlock offset 0 with xen_mr_is_memory
  xen: mapcache: Pass the ram_addr offset to xen_map_cache()
  xen: mapcache: Add support for grant mappings
  hw/arm: xen: Enable use of grant mappings

 hw/arm/xen_arm.c                |   5 +
 hw/xen/xen-hvm-common.c         |  18 ++-
 hw/xen/xen-mapcache.c           | 232 ++++++++++++++++++++++++--------
 include/hw/xen/xen-hvm-common.h |   3 +
 include/sysemu/xen-mapcache.h   |   2 +
 include/sysemu/xen.h            |  15 +++
 system/physmem.c                |  12 +-
 7 files changed, 226 insertions(+), 61 deletions(-)

-- 
2.40.1


