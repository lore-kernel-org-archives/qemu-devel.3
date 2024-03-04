Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1DEC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEEQ-0005SZ-Vo; Mon, 04 Mar 2024 14:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEK-0005RQ-2B
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:08 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEI-0006uk-9g
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:07 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6095dfcb461so46332707b3.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581445; x=1710186245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QJbfZE+vJVhF6ohULRusgGlAawiyr+LeVZe1pP+RB9U=;
 b=kWCXqWTRFC9cYqlQVb9Zkj3EQ4IWQedDry81KN6uPu4IznmozlDG11UKQAia8/ZVeF
 HIpNc1P94rVjl5lrSpQipEc69owOC1CP7pNb3Sl2htpBzmYc6PuJCGle9c1IWgywpnQf
 Tuow7L0mgaznvwHjkeiZFxP00YauqCgq512lFgjWWnXNAHUp1xVggFxvmWSbmESQBuAl
 eeiaoERuiqa8VfjZHqT4hfmGmoOkMeTNAphC5ABhzlQtEP+Zjf1DlMquFPa6Lnj5P9OJ
 iEWh74jwe9fWEA9BM2PbaNI9pV/FwH5oI3WOtt5ydPqCbfTV1DAFzMyjtTHoYWcdrzGu
 kC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581445; x=1710186245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJbfZE+vJVhF6ohULRusgGlAawiyr+LeVZe1pP+RB9U=;
 b=BG1QvsPXiTfiP0iMoHgx9FeVpte2u+e1/8cDoPNqW7yZhj91jFY1GoFRYlMXfhnglZ
 uj4zp2h/O1KiY7xyXbqUrGH1xYW8HDBHNC1TJ8m6QW49aimFSzU8Qea5uEsGQ6YOrDBg
 17UNrRIppHdnyTXQTkoZ9zgNn7r8zxW56T0EMNvJK3n6SARhBiM35jH6eK3WIE+qo5VH
 6yZce0RuKNNiPDEmM8Xo7RPIkLNhhVv0Y4bbPRYDox6CZIKmUuiywBAUWLKnEAjWEZ65
 caHQmVh4+aJVREB17oTtz8i4yxYYvgSpm0SNrej2wOMui4Av71T7iDHPJnvjVtCbKGFr
 GG2Q==
X-Gm-Message-State: AOJu0YwKCVM/V08kY8egu10tZgorbno0YTUg/VTKzxRuHlKuAw3T0lto
 GchvLCWoIjdazvD0D7sQjhhmx7TIkvC6aK5+HagoDq4atRvuVghi5mMGL6Tm
X-Google-Smtp-Source: AGHT+IFvo7oOwuDmSurrtT5G/HJwiIcSWjslezbbQeIkVsdhV8wYif+bOOvtoCuDV8Xf5v/OxuOODw==
X-Received: by 2002:a25:aa86:0:b0:dc7:49ec:50d9 with SMTP id
 t6-20020a25aa86000000b00dc749ec50d9mr7732176ybi.42.1709581444731; 
 Mon, 04 Mar 2024 11:44:04 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:04 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 00/13] Enabling DCD emulation support in Qemu
Date: Mon,  4 Mar 2024 11:33:55 -0800
Message-ID: <20240304194331.1586191-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The code is rebased on mainstream QEMU with the following patch series:
hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
hw/cxl/mailbox: interface to add CCI commands to an existing CCI

v4->v5:
1. Did spell check for the patchset and fixed 2 typos;
2. Fixed a misuse of stq_le_p and replaced it with stl_le_p in
   cmd_dcd_get_dyn_cap_config;
3. Removed unnecessary switch case in patch 9;
4. Capitalized ""opcode" to "Opcode" in two code comments;
5. Updated one reference text to the spec;
6. Minor text change in qapi/cxl.json.
7. Removed the definition of CXL_SPEC_AFTER_R30
8. Removed the unnecessary input and output mailbox payload struct type
   definition;
9. set num_extents_supported and num_extents_avaible based on extents;
10. Renamed DCD_MAX_REGION_NUM to DCD_MAX_NUM_REGION;
11. Updated the commit log in Patch 4 to remove the unwanted text;
12. Fixed some indent issues;
13. Fail removal if it causes extents overflow after removal;
14. Capture cases when adding response causing the device to exceed its extent
    tracking ability;
15. Using memory_region_size instead of directly accessing the field in
    cxl_create_dc_regions;
16. Renamed DCDRegion as DCRegion;

Changes 1-5 are suggested by Wonjae Lee (wj28.lee@gmail.com), 
Changes 6-14 are suggested by Jonathan.
Changes 15-16 are suggested by Jorgen.

Thanks for the review of v4.

For this version, the main code changes (PATCH 11~12) extend DC extent
release processing, including mailbox command and QMP interface processing.

Based on Jonathan's suggestion, we updated the code, and now we can process
extent release request more flexible. We can now support superset release
(actually we can do even more, as long as the DPA range is covered by
accepted extents, we can release).

For superset extent release, the only requirement, if we find part of its DPA
range is still pending to add, while the other is accepted, we reject it
through QMP interface.

Last but not least, in the series, we introduced a new patch (PATCH 13),
which We introduce new QMP interfaces to print out accepted and
pending-to-add list in the device to a file.

The latest code branch is https://github.com/moking/qemu/tree/dcd-v5.

The code is tested with Ira's last kernel DCD patch set [2] with some minor
bug fixes[3]. Tested operations include:

Extra extent release test,
1. Add multiple extents, and removing them one by one, passed;
2. Superset release: add multiple extents with continuous DPA ranges, and
   Remove all of them with a single extent request with extent covering the
   whole DPA range, passed;
3. Partial extent release: add a large extent and release only part of it,
   passed;
4. Partial+superset release: add multiple extents,and release it with some
   leftover with one request with an extent. For example, add extents [0-128M]
   and [128-256], release [64M-256M], passed;
5. release extent not aligned to block size, failed as expected;
6. extents have overlaps, fail the request as expected;
7. extent has uncovered DPA range, skip the extent as expected; 
8. OS tries to release a non-exist extent, return invalid PA as expected;
 
[1] v4: https://lore.kernel.org/linux-cxl/20240221182020.1086096-1-nifan.cxl@gmail.com/T/#m580c59be5deca2639dd7158e57f4bc1141d1c885
[2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
[3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964

Fan Ni (13):
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
  hw/cxl/cxl-mailbox-utils: Add partial and superset extent release
    mailbox support
  hw/mem/cxl_type3: Allow to release partial extent and extent superset
    in QMP interface
  qapi/cxl.json: Add QMP interfaces to print out accepted and pending DC
    extents

 hw/cxl/cxl-mailbox-utils.c  | 682 ++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 724 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  26 ++
 include/hw/cxl/cxl_device.h |  61 ++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               |  93 ++++-
 6 files changed, 1558 insertions(+), 46 deletions(-)

-- 
2.43.0


