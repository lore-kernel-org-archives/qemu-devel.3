Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE14C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 07:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirbD-00062N-2b; Sat, 09 Mar 2024 02:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbB-000629-Gw
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:29 -0500
Received: from out-178.mta1.migadu.com ([95.215.58.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirb9-00010t-26
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:29 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tkFURI+9WbM7xcZNS/blKbhZxIHQ2PVPE5ykWi/iotM=;
 b=CsTHlOlngzzzB850uDoHP6WKpF3snenRPV6RZlARjAp9oPXcvF6Cf2K2219zohdr67w0kk
 BJMmQcvr4FWihk5iaBbdRtgyDiPrz6GEMqrWM28YTj881Z6OV0u5SqtgSstMGMPgFekSDi
 VP9FXnbdDC+Maco5lvZkHcInNGB2gbE=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v5 0/7] Introduce multifd zero page checking.
Date: Sat,  9 Mar 2024 07:57:21 +0000
Message-Id: <20240309075728.1487211-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.178; envelope-from=hao.xiang@linux.dev;
 helo=out-178.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Hao Xiang <hao.xiang@bytedance.com>

v5 update:
* Move QEMU9.0 -> QEMU8.2 migration backward compatibility handling into
the patch where "multifd" zero page checking becomes the default option.
* A few function renaming according to feedback.
* Fix bug in multifd_send_zero_page_detect.
* Rebase on the new mapped-ram feature.
* Pulled in 2 commits from Fabiano.

v4 update:
* Fix documentation for interface ZeroPageDetection.
* Fix implementation in multifd_send_zero_page_check.
* Rebase on top of c0c6a0e3528b88aaad0b9d333e295707a195587b.

v3 update:
* Change "zero" to "zero-pages" and use type size for "zero-bytes".
* Fixed ZeroPageDetection interface description.
* Move zero page unit tests to its own path.
* Removed some asserts.
* Added backward compatibility support for migration 9.0 -> 8.2.
* Removed fields "zero" and "normal" page address arrays from v2. Now
multifd_zero_page_check_send sorts normal/zero pages in the "offset" array.

v2 update:
* Implement zero-page-detection switch with enumeration "legacy",
"none" and "multifd".
* Move normal/zero pages from MultiFDSendParams to MultiFDPages_t.
* Add zeros and zero_bytes accounting.

This patchset is based on Juan Quintela's old series here
https://lore.kernel.org/all/20220802063907.18882-1-quintela@redhat.com/

In the multifd live migration model, there is a single migration main
thread scanning the page map, queuing the pages to multiple multifd
sender threads. The migration main thread runs zero page checking on
every page before queuing the page to the sender threads. Zero page
checking is a CPU intensive task and hence having a single thread doing
all that doesn't scale well. This change introduces a new function
to run the zero page checking on the multifd sender threads. This
patchset also lays the ground work for future changes to offload zero
page checking task to accelerator hardwares.

Use two Intel 4th generation Xeon servers for testing.

Architecture:        x86_64
CPU(s):              192
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               143
Model name:          Intel(R) Xeon(R) Platinum 8457C
Stepping:            8
CPU MHz:             2538.624
CPU max MHz:         3800.0000
CPU min MHz:         800.0000

Perform multifd live migration with below setup:
1. VM has 100GB memory. All pages in the VM are zero pages.
2. Use tcp socket for live migration.
3. Use 4 multifd channels and zero page checking on migration main thread.
4. Use 1/2/4 multifd channels and zero page checking on multifd sender
threads.
5. Record migration total time from sender QEMU console's "info migrate"
command.

+------------------------------------+
|zero-page-checking | total-time(ms) |
+------------------------------------+
|main-thread        | 9629           |
+------------------------------------+
|multifd-1-threads  | 6182           |
+------------------------------------+
|multifd-2-threads  | 4643           |
+------------------------------------+
|multifd-4-threads  | 4143           |
+------------------------------------+

Apply this patchset on top of commit
cbccded4a2b5d685a426a437e25f67d3a375b292

Fabiano Rosas (2):
  migration/multifd: Allow zero pages in file migration
  migration/multifd: Allow clearing of the file_bmap from multifd

Hao Xiang (5):
  migration/multifd: Add new migration option zero-page-detection.
  migration/multifd: Implement zero page transmission on the multifd
    thread.
  migration/multifd: Implement ram_save_target_page_multifd to handle
    multifd version of MigrationOps::ram_save_target_page.
  migration/multifd: Enable multifd zero page checking by default.
  migration/multifd: Add new migration test cases for legacy zero page
    checking.

 hw/core/machine.c                   |  4 +-
 hw/core/qdev-properties-system.c    | 10 ++++
 include/hw/qdev-properties-system.h |  4 ++
 migration/file.c                    |  2 +-
 migration/meson.build               |  1 +
 migration/migration-hmp-cmds.c      |  9 +++
 migration/multifd-zero-page.c       | 87 +++++++++++++++++++++++++++
 migration/multifd-zlib.c            | 21 +++++--
 migration/multifd-zstd.c            | 20 +++++--
 migration/multifd.c                 | 92 ++++++++++++++++++++++++-----
 migration/multifd.h                 | 23 +++++++-
 migration/options.c                 | 21 +++++++
 migration/options.h                 |  1 +
 migration/ram.c                     | 47 +++++++++++----
 migration/ram.h                     |  3 +-
 migration/trace-events              |  8 +--
 qapi/migration.json                 | 38 +++++++++++-
 tests/qtest/migration-test.c        | 52 ++++++++++++++++
 18 files changed, 395 insertions(+), 48 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

-- 
2.30.2


