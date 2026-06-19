Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25611CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJA-0006K2-I5; Fri, 19 Jun 2026 06:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ8-0006IH-9E
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:42 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ5-0000ey-EB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=Mm/znqLMjbKJQBKADZsQW4DEKGoSk2pjV2IwdgPHUis=; b=Fin5O+srtWYd
 u2NFFYp4ozMjv1DXH2LiQf+IWxCD+mJvSDWTW+/0jXTFlotb+6fix/v7i3nI9bssiDGGLIqyk+9/A
 RaC9FRjva0YdSi/A65oF6eq+0nDq5AVPLZqFzF+vAh96KffQdtIBb4nsb4lAtwONnBTmfsYRcN5CB
 pF++mBxzwwiop7m28jwZ3ppM3Cu6PTR5KLGsokTOr6I5XwZz4f8RYVUjcRboYVKxuYUt+SlIP/5Lx
 wjW9Ezok72V5SA+S3W6gnOD2x1UCqpuGtgo2dKw/1dW2GBIMrsAaRHkfkAXwTZ3j7O0m/L9LOubRm
 +Mw4NiWHUVhQ4zokb2mW1A==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIS-006QLJ-1D;
 Fri, 19 Jun 2026 12:18:32 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 0/7] dump: report win-dmp via vmcoreinfo,
 guard guest-RAM reads during migration
Date: Fri, 19 Jun 2026 12:18:27 +0200
Message-ID: <20260619101834.228432-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series fixes Windows-dump (win-dmp) availability reporting and closes
a related hole found while doing so: several commands read guest RAM and
must not run while a migration destination is still receiving it.

dump-guest-memory, memsave and pmemsave all read guest RAM on the main
thread with the BQL held. On a migration destination that RAM is either
still being loaded (precopy) or pulled from the source on demand
(postcopy, where the guest already runs). During precopy the read returns
incomplete data; during postcopy it deadlocks, as the read faults on a
not-yet-received page while the postcopy incoming path needs the BQL the
reader holds to install it. dump-guest-memory only guarded the precopy
phase and memsave/pmemsave had no guard at all, so a new
migration_guest_ram_loading() predicate captures both phases and all
three commands now use it.

query-dump-guest-memory-capability also advertised win-dmp for every x86
VM, and dump-guest-memory accepted it unconditionally; win-dmp only works
when the guest has published a Windows dump header through vmcoreinfo.
win_dump_available() now reads that note back from the vmcoreinfo device
and validates it, keeping its original signature, so the dump.c call sites
are unchanged.

The series also adds the first qtest coverage for dump-guest-memory:
capability list, ELF and kdump output, protocol errors, and win-dmp
reporting in both directions (the positive case forges a vmcoreinfo note,
so no Windows guest is needed).

Tested:
 - Linux guest: win-dmp not advertised; an explicit win-dmp request is
   rejected without stopping the guest; elf/kdump dumps work.
 - Windows Server 2022 guest: win-dmp advertised once vmcoreinfo is
   populated; dump-guest-memory format=win-dmp produces a valid (PAGEDU64)
   crashdump.
 - Live postcopy migration: on the destination, dump-guest-memory, memsave
   and pmemsave are all refused immediately, without faulting a page.

This supersedes the earlier "dump: enhance win_dump_available to report
properly" series, which obtained the note by reusing the dump setup path
(splitting dump_init() and stopping the vCPUs). Reading vmcoreinfo
directly is much smaller.

Changes since v4:
 - Refuse guest-RAM reads (dump-guest-memory, memsave, pmemsave) while a
   migration destination is still receiving RAM, via a shared
   migration_guest_ram_loading() helper.
 - Decide win-dmp availability by reading vmcoreinfo directly instead of
   splitting dump_init()/dump_preinit() and stopping the vCPUs.
 - Add dump-guest-memory qtests.

Denis V. Lunev (7):
  migration: add migration_guest_ram_loading() helper
  dump: refuse dump-guest-memory while guest RAM is being migrated
  system/cpus: refuse memsave/pmemsave while guest RAM is being migrated
  dump: make win_dump_available() check vmcoreinfo for a Windows dump
    header
  tests/qtest: add dump-guest-memory test
  tests/qtest/dump: reject win-dmp without vmcoreinfo
  tests/qtest/dump: cover win-dmp availability via vmcoreinfo

 MAINTAINERS              |   1 +
 dump/dump.c              |   5 +-
 dump/win_dump-x86.c      |  42 +++++
 include/migration/misc.h |   3 +
 migration/migration.c    |   6 +
 system/cpus.c            |  11 ++
 tests/qtest/dump-test.c  | 331 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build  |   1 +
 8 files changed, 398 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/dump-test.c


base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
-- 
2.53.0


