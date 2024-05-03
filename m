Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63223C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57am-0001jv-1v; Thu, 09 May 2024 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57aa-0001hy-5Y
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:56 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57aX-0003YX-Nm
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:51 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so14487711fa.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715275787; x=1715880587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9gxZi8Kxunmjw0xqkHld/SfRNQJr5iGjZkmVGJhY1Pc=;
 b=DIueN/bW+APipWVm0VOXbdYUVM49Ly22kS14jVKK26wSsOVZdCgeckdpDHd8K2U/EB
 RNc8KxZImgCBV0k2v1E2Pjup56As7i8x+sSOL+vZjunozGFxxGVFIjGhB5l0pgcRcjlq
 CW69rHjglYBM1Z6M2aiSHKa9g9P6kNYgeXdmtJXoydOPDaaJFaUJ6OX8nTDK1o3ZUtVm
 5m9KxnitBucbtHoRaO8oTbZ7g14Qh9fHsIWLL0/PuDMyCyH8B7EyAVsJlKk7ZjFS0DZs
 i05RQiqj5GKuHdzP+vcQ+yM5bk6k8ZIDz71yUD6ig6MzMaGUWnr5pAciNjz6RAr8lwWG
 Tf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275787; x=1715880587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9gxZi8Kxunmjw0xqkHld/SfRNQJr5iGjZkmVGJhY1Pc=;
 b=k9JDXeOycyz23evqLkTCC0hbo/Mw9JsgE0XOIIBeFGw6c1zYL3/DAKRMpcH5JOCdZg
 ftTtkS7fB+XgAhqYVBaTNYxI3NG7CjB3YsEgb+kHAp5DegSi28WSXOwEgg7PoKxVkPtX
 o218FBpwx52p0eKz2P3efPE33HsAYOedkeutHMyTgN4MtV3LyplJVq7Fi1BlxvYTDDIg
 kUpkQakWO0bhd7rf5o06lRGqY6lhPOnFfjKqiJAUKJxJaJ2Xr3TsadKePFPOsc9KuI71
 6wXMkA4XR3/nkl5eWcyBRPaDhrkKDXnoM6DmxjMrqoiNzbvs4RJwOUKs6ZikShwz7VNc
 X1zA==
X-Gm-Message-State: AOJu0YyMjw5RWTfcWSZydBIBMhi9A+jpqnaat6zucz9MzJk7eWkuSi0x
 /qRx78viOkRwGsZkrymWKJBB8nyZnQ65ywBo810yjrQwjnJ6n1Nq8ZIAiVLg
X-Google-Smtp-Source: AGHT+IHs5xnu5c2xGbOBr4n7Me7bFXR19SRenqLxh5Xp2IkHaTBQ1HcYWjTe6yiah+PMw8F7yGpmuA==
X-Received: by 2002:a2e:b8c9:0:b0:2e1:f199:3853 with SMTP id
 38308e7fff4ca-2e5204cc91amr787251fa.47.1715275786645; 
 Thu, 09 May 2024 10:29:46 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d15155fdsm2557011fa.83.2024.05.09.10.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:29:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v5 0/8] xen: Support grant mappings
Date: Fri,  3 May 2024 03:44:41 +0200
Message-Id: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v4 -> v5:
* Compute grant_ref from address_index to xen_remap_bucket().
* Rename grant_is_write to is_write and comment on why foreign
  mappings don't yet use it.
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


