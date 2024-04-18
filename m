Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19333C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxbCd-0002tk-6t; Thu, 18 Apr 2024 19:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCb-0002s7-2s
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCZ-0005fj-7a
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so1344900b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713482997; x=1714087797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fur+9qbrwuD/AXrrSTEkXP81Q45FHlgNLTr+T2spM0U=;
 b=hWoLiGo+Qm4RpHFluTV/8hQgmKqF+0l0WWoBaLhUTeGb7XQ941eaInyMm/q6AqqU1t
 WEBZcBS7Uop3lyw8dJ6fkTZENvh1ud22Gy9yh3FibZbaqRQaim/2ADweu/1tr4WAOzpt
 H/Casoc7F7+TnKJ7CPz2/M4Gr+XHZHLu3vkTECZGFtYMoGVtLEjMkAReX34LqDnJ/+Cz
 VAO1hI0IskH3rAbLTic4PgdztblWWsGCWZVe36ywwg7hTZ1Nf2HnqZw2VcLsk/JuQzkg
 fi5b/q2gpq3Y5XxxCmxlGwYeoSd7gKF5i4RJjg9uxQeTU+YXamYBxPRUR8kaire/3ToY
 RSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713482997; x=1714087797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fur+9qbrwuD/AXrrSTEkXP81Q45FHlgNLTr+T2spM0U=;
 b=DcKmkTfvTbaDoo/MdlidWdX46yvFaj7p3RMYh+0RkuKvRAM7oa90kxRDfeyoChx7pG
 YhYtJNBBNHWpo9OYud1TxyGjsk2F21TYpR8lQ8WFvsyfSkXl9u9HLvn7gGPqU56emufz
 uwZYxW1SNhuf+8jk9zuV5NQq7fYAexSF0KR/Xd27hbLB8G78mpkOD6J2bIkO5y+IeKxU
 +ElLYkEBo0NKwqNQPyGe8ti/oiX87PFd6vlV/T998ZL0REyncO6PDUqcTinRrrJoOj7h
 mStSiNrI1Tjw7fsv6xPZ079eeED5owrxWnF8Ca88QQZcbO8FVZXkaIzXMReMKXqRDgfL
 U/cQ==
X-Gm-Message-State: AOJu0YzGtVUvVfbtBJMKxRXnvI8Xdre3quBcLEBv+q+eN2r5CX7Jf6r5
 5rko5OEa6mgUoQEXeDmOUchYQ2vgeKdL868zJkhE18He6TdCeVfo3pwY7Q==
X-Google-Smtp-Source: AGHT+IEgYQfnOBvaScWVexAIMCNZgj8gRr1kAslt0+joKr9lAHw+kk3EANga3PIAHl9mvsXoBsg5Qg==
X-Received: by 2002:a05:6a00:6616:b0:6ed:d5f5:85e with SMTP id
 he22-20020a056a00661600b006edd5f5085emr565285pfb.3.1713482996762; 
 Thu, 18 Apr 2024 16:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 16:29:56 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, fan.ni@samsung.com
Subject: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Date: Thu, 18 Apr 2024 16:10:51 -0700
Message-ID: <20240418232902.583744-1-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42a.google.com
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

A git tree of this series can be found here (with one extra commit on top
for printing out accepted/pending extent list): 
https://github.com/moking/qemu/tree/dcd-v7

v6->v7:

1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
   Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
4. Added "Reviewed-by" tag to Patch 7.
5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
   reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
    (Jonathan)
7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
8. Modified QMP interfaces for adding/releasing DC extents to allow passing
   tags, selection policy, flags in the interface. (Jonathan, Gregory)
9. Redesigned the pending list so extents in the same requests are grouped
    together. A new data structure is introduced to represent "extent group"
    in pending list.  (Jonathan)
10. Added support in QMP interface for "More" flag. 
11. Check "Forced removal" flag for release request and not let it pass through.
12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
   to avoid the side effect it may introduce to inject error to DC event log.
   (Jonathan)
13. Hard coded the event log type to dynamic capacity event log in QMP
    interfaces. (Jonathan)
14. Adding space in between "-1]". (Jonathan)
15. Some minor comment fixes.

The code is tested with similar setup and has passed similar tests as listed
in the cover letter of v5[1] and v6[2].
Also, the code is tested with the latest DCD kernel patchset[3].

[1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
[2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
[3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3


Fan Ni (12):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size instead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
  hw/mem/cxl_type3: Allow to release extent superset in QMP interface

 hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  20 ++
 include/hw/cxl/cxl_device.h |  81 ++++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               |  69 ++++
 6 files changed, 1396 insertions(+), 45 deletions(-)

-- 
2.43.0


