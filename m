Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4694FC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDg-0007tm-BR; Wed, 21 Feb 2024 13:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDY-0007g5-Vx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:17 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDV-0003Iw-EI
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:16 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e2e6bcc115so3875426a34.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539671; x=1709144471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rF+lzU6VXn8MzeIYj12jMaidQDet+Jk/8usd9xFeU4E=;
 b=HJ19q2J2jf81j8LJiFt84T9ciG02HBeTw+1tJA21/PnKHNbT333vwn3vAVXhoxGB4R
 tSnFBoQZd+itRx6wFUMYJksaQS9p54/DyT7S4rLuzt2URSyUXCLpd99muszttLScRmQ4
 MbPFKf1Y2sKRnOArI+JKNHJSTDR/2E0zFxLcPNbA1AK5VWbD+7a0RUqmsMl72fsE0rlg
 jyq1FflokIJkddadgsWKM3sD8lWUBbki99TT32IyNsHJiOXh+KMwf585pCBgzBDBQxT3
 JoJAfKcyvaA9Pnh5uTPtFJ8rEXW6bt/mb+pW5fgImPLwVJfFwE4GX5O6ecx/vxpLtOyd
 Bftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539671; x=1709144471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rF+lzU6VXn8MzeIYj12jMaidQDet+Jk/8usd9xFeU4E=;
 b=Db0/7MKKVUwEmLGHuRL9iqLSKGzTaReq6wgS9EQCsFKP7jXcrTvA19jzf+PYQJURtj
 T3rNQr2uvrX7MsNKLMFFkigRnBCpcpc9k64Ur10TbYnFmE7NyEWAFBmaKYWrVew/GJdi
 +zKTbQr4L/IhMN56EzPZpk4ptK0nFizJOvRLFJp2YmR5DyRCYtYiJ0on5GNsKZwKjsr1
 /h+oO+hqus4AS0QW5KfCuc0847KS2GPWSG9S1iFBX6Fz/pNfU6zRHqUjuCuCPwTUlW+c
 IdcNKHq0z8YSeXTJxVshYtRhI0DDP3ZpWE1uninfPRUezlKj1cMLgD2S5f0A9CkMaMVI
 eIJQ==
X-Gm-Message-State: AOJu0Yysa5pF65CMjIoevwYlosyqWFPxrc7gVgsgsD3R5NE11YP2N6Zw
 UCRd1FO3U0fCG0BjHKPw054bgTaQASqPFQtBmQS9q25aJWtle8QyEKkEwIfp
X-Google-Smtp-Source: AGHT+IEeZFxdjaqyZAi2dnWva5Y087szRR+YGolJKt82BgzIVoI5c1BjJh3XQtisJrtTNdd4YlBcJA==
X-Received: by 2002:a05:6358:65a7:b0:17b:57f3:3b9 with SMTP id
 x39-20020a05635865a700b0017b57f303b9mr3776609rwh.14.1708539670465; 
 Wed, 21 Feb 2024 10:21:10 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:10 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 00/10] Enabling DCD emulation support in Qemu
Date: Wed, 21 Feb 2024 10:15:53 -0800
Message-ID: <20240221182020.1086096-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=nifan.cxl@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fan Ni <fan.ni@samsung.com>

v3[1]->v4: 

The code is rebased on mainstream QEMU with the following patch series:

hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
hw/cxl/mailbox: interface to add CCI commands to an existing CCI

Main changes include:

1. Updated the specification references to align with cxl spec r3.1.
2. Add extra elements to get dc region configuration output payload and
procecced accordingly in mailbox command 4800h.
3. Removed the unwanted space.
4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
5. Updated cxl_create_dc_regions function to derive region len from host
backend size.
6. Changed the logic for creating DC regions when host backend and address
space processing is introduced, now cxl_create_dc_regions is called only
when host backend exists.
7. Updated the name of the definitions related to DC extents for consistency.
7. Updated dynamic capacity event record definition to align with spec r3.1.
9. Changed the dynamic capacity request process logic, for release request,
extra checks are done against the pending list to remove the extent yet added.
10. Changed the return value of cxl_create_dc_regions so the return can be used
to Remove the extent for the list if needed.
11. offset and size in the qmp interface are changed to be byte-wise while the
original is MiB-wise.
12. Fixed bugs in handling bitmap for dpa range existence.
13. NOTE: in previous version DC is set to non-volatile, while in this version
we change it to volatile per Jonathan's suggestion.
14. Updated the doc in qapi/cxl.json.

Thank Jonathan for the detailed review of the last version[1].

The code is tested with Ira's last kernel DCD patch set [2] with some minor
bug fixes[3]. Tested operations include:
1. create DC region;
2. Add/release DC extents;
3. convert DC capacity into system RAM (no real read/write to DCD tested);


v3: 
[1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
[2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
[3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964

Fan Ni (10):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size insead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions

 hw/cxl/cxl-mailbox-utils.c  | 507 +++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 559 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  14 +
 include/hw/cxl/cxl_device.h |  61 +++-
 include/hw/cxl/cxl_events.h |  18 ++
 qapi/cxl.json               |  61 +++-
 6 files changed, 1174 insertions(+), 46 deletions(-)

-- 
2.43.0


