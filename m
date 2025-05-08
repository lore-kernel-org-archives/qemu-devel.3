Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C7BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyB-0005vO-4l; Wed, 07 May 2025 20:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoy8-0005vC-8W
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoy6-0006tw-6l
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso562964b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663507; x=1747268307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1DUUdafSg3gAWNrrjVpbMbgAbVF/N0VART/pBT07PSM=;
 b=PTijOaeWpDJ3EPFtRLaW546cfjuthNr+nSDkIPAE7ohrZvcr4YQwSnBmkezQX1aXjf
 rkrXdtG3sv0aTIx+MzRe1Nk5+TK1JKV2hYGZD5fvmowbvvM3hG383pXtwYdpGuth0e1e
 jUJ8gC10WHvhU7t2IT1jeDm+JAOdJwYno53RHiicj5I8FgYy86KXKVX+1XC9iUjiZ9rO
 IYLSOOMbKk9zpe5rxXC7PdcguUPp7hAilW++BQWi/ZxqFY5dtS/nMVITYVfy0uL2k9b8
 V3/XVQFUuFDy9sLkyLZ8wgW5dZhKPpeeMfu1/QCra66u9op/whth6ZokoLnV8A0sAZkt
 N/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663507; x=1747268307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1DUUdafSg3gAWNrrjVpbMbgAbVF/N0VART/pBT07PSM=;
 b=LF/Z+AS2u0pZMX65IL7YP8w2qVzwapr9cMuFnd+yJmLOaDacuZdxRyz8AHB5LNGAz0
 phivv5hI5hNk9sLUHtYaccVzVEj5CrL2BelbL8xqZ/jmscOTEoorXXnIwrFp8//K/DcN
 wB47Or6tuQxOi1FD49AOFVwUImH5Jn9m+rTUFb67GGduy1I+3CN7POws3s8OZ6GNJTMX
 PgrWvwm7uXoCdZSkR3deCUaBpqBQRkd5lPd2Lj9sOjjNmbG4jz/RUYAE1qX36x00E2tS
 lfYLwHucCINPgBIOW5SgI9k+LSBIT81IN1qb7fZO10arDpqGYoiMD5qUt+VQBg28sEl5
 sX+g==
X-Gm-Message-State: AOJu0YzmsVjI/kShgkuZ0SyJCoG4Xgmc+Pn8/lJtXNwM+oFDOs9yQgK7
 uGzAZue/GyZKfEgOhsFpJCx13z032H8N7R1lQBn/x51fdsFVmMn2RJYrYw==
X-Gm-Gg: ASbGncvNjtRA4ELcNv5DOIyH4EGCUInpSORNzJxhtNSXK0MFL65NDPTLLi4mxF/XTdP
 Xgg60Cb+47JVAD7t/0o4wiqkb5AvXMxyozkZq+BfB3LbmJLZHYT4zIMXReNMpDHpGb46kURPIDH
 RdbC2lvW5pYV9/apDdUGzhjcx+OaJoRsmVlWrutCakPO+U2j8OvOKtDf5m+M0OkiOAnlR5jFIzs
 zKfFwXO1C2c6Mp/KuvR9iKReFQfhPINqYFv+4tHAwCJpF6Lth26Y1Qv0TwPpWg1sYzUfNDUKXaj
 2K+lL9jeyGEI+dfFjhO7aoTqmPL4oh2ji7TfngBcRkQM2o/S/mLpY+DwfX5AJA==
X-Google-Smtp-Source: AGHT+IEB0JXt6z8w2I6N2UYJl/ixcQnuaXs/9O6VqQ8Uf85PMo1g4X9kfpaFz6eYJTPAnFwaeV4U5Q==
X-Received: by 2002:a05:6a20:12d4:b0:204:4573:d854 with SMTP id
 adf61e73a8af0-2159af312d9mr1699263637.9.1746663506886; 
 Wed, 07 May 2025 17:18:26 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:26 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Thu,  8 May 2025 00:00:56 +0000
Message-ID: <20250508001754.122180-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
according to the CXL r3.2 Spec. It is based on the following branch:
https://gitlab.com/jic23/qemu/-/tree/cxl-2025-02-20.

The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
commands to the device (QEMU emulated) through MCTP messages over I2C
bus. To perform end-to-end tests, both MCTP and DCD support are needed
for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.

For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
The libcxlmi test program is used to send the command to the device and results
are collected and verified.

For command 0x5602 (Set DC Region Config): device creates an event record with type
DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
if the configuration changes as a result of the command. Currently, the kernel
version used to test this only supports Add/Release type events. Thus, this
request essentially gets ignored but did not cause problems besides the host
not knowing about the configuration change when tested.

For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
tests involve libcxlmi test program (acting as the FM), kernel DCD
code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps,
1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
2. Load the CXL related drivers in the VM;
3. Create a DC region for the DCD device attached.
4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
the out-of-tree libcxlmi test program
(https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

Changes
================================================================================
v1 -> v2:
1. Feedback from Jonathan Cameron on v1
Addressed general style concerns (newlines/spacing, minor refactoring, etc.)
1.1. Changes Related to 0x5600 - FMAPI Get DCD Info
    - Squashed prepatory patch adding supported_blk_sizes_bitmask
    - Added new prepatory patch moving opcodes enum from cxl-mailbox-utils.c to
    new header file opcodes.h
    Needed for the check in i2c_mctp_cxl.c to ensure the FMAPI Commands
    (0x51 - 0x59) are bound with MCTP_MT_CXL_FMAPI. By moving the enum,
    the hardcoded values (0x51, 0x59) can be replaced with their
    enumerators.
    - Bug fix to return Add/Release Extent Selection Policy bitmasks
      correctly
1.2. Changes Related to 0x5601 - FMAPI Get Host Region Config
    - Prepatory patch to add dsmas_flags to CXLDCRegion struct was modified to
    store the booleans dsmas_flags is made up of instead of copying it from the
    CDAT for that region. Values hardcoded for unsupported flags.
    - Build the returned dsmas_flags from the new booleans.
1.3. Changes Related to 0x5602 - FMAPI Set DC Region Config
    - Added locking for CXLDCRegion bitmap for the case that extents are being
    added/released via a different CCI than that of the FM-enabled CCI.
    - Prepatory patch created for the above (quite short, can be squashed if
    preferred)
    - Added a check to verify that the requested block_size is supported by the
    region by looking at region->supported_blk_sizes_bitmask
    - Instead of event_record validity flag being cleared, set to 1
    - Fixed bug of forgetting to update region->block_size
1.4. Changes Related to 0x5603 - FMAPI Get DC Region Extents
    - Minor refactoring of loop filling in response payload extents

2. Feedback from Fan Ni and Jonathan Cameron on v1
2.1. Changes Related to 0x5604 - FMAPI Initiate DC Add
    - Remove redundant storage of extents in event_rec_exts
    - Refactor event record creation into helper function for re-use by release
    - Return event_record.available_extents
    (total_extents_available - num_pending - num_accepted) instead of
    leaving it blank
2.2. Changes Related to 0x5605 - FMAPI Initiate DC Release
    - Remove redundant storage of extents in event_rec_exts/redundant 2nd loop
    - Add #define for removal_policy_bitmask instead of hardcoding 0x7

Anisa Su (10):
  cxl-mailbox-utils: Move opcodes enum to new header file
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
    DC event types
  hw/cxl_type3: Add DC Region bitmap lock
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
 hw/cxl/i2c_mctp_cxl.c        |   6 +-
 hw/mem/cxl_type3.c           |  41 ++-
 include/hw/cxl/cxl_device.h  |  24 ++
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 include/hw/cxl/cxl_opcodes.h |  72 ++++
 7 files changed, 724 insertions(+), 89 deletions(-)
 create mode 100644 include/hw/cxl/cxl_opcodes.h

-- 
2.47.2


