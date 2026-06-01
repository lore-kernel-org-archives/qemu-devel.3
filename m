Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE72CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU4cY-0007pc-Da; Mon, 01 Jun 2026 11:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wU4Zc-00070y-0m
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:29:04 -0400
Received: from mail-106111.protonmail.ch ([79.135.106.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wU4ZZ-0000B0-Pj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1780327732; x=1780586932;
 bh=woyl9wcK3LCygh/uGRk/y0fax5SzGVIbSEKcIVU6Mow=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cCLW2XR5k47R5ptNTsC15OMT5Z/5L+HFXKtnKhHli0/xy9NpkC6a0rgLIWlWLquRG
 +YnS21e6t8nyR7MwC3YBTADCds0ttEJc5GkuuyeA9Oa+47Ztto1neeXhA0RkGEBaAI
 MS19x7A8W7v9FoJkGULHI62iAQwokiCF7r1KTEwpAF1jNHSQc3kRioVIJFeq92EZBf
 4r+i+lP8h5GwTgkT0P+tjdPh5+7Xr7jfZ62TqQllRUb80Q9013MrRF01jqPj8iVMhL
 GahzuP3lAtFSU2x8rkc28fW8Ok48sIbNktY0859bhnazPTSeVB4P5OiSqOupQk9s1y
 AOSct4A/wt6fQ==
X-Pm-Submission-Id: 4gTdCl1mZcz1DDLQ
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, thuth@redhat.com
Subject: [PATCH v3 0/3] hw/misc/applesmc: fix GET_KEY_BY_INDEX iteration and
 populate Apple SMC key set
Date: Mon,  1 Jun 2026 08:28:44 -0700
Message-ID: <20260601152847.26916-1-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507152030.48753-1-matthew@pq.io>
References: <20260507152030.48753-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=79.135.106.111; envelope-from=matthew@pq.io;
 helo=mail-106111.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Jun 2026 11:32:02 -0400
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

v1: https://lore.kernel.org/qemu-devel/20260507040153.14565-1-matthew@pq.io/
v2: https://lore.kernel.org/qemu-devel/20260507152030.48753-1-matthew@pq.io/

This is a rebase/respin of v2, which had no outstanding review
comments after Peter's two style nits were addressed. Resending on
current master with checkpatch cleared, plus a new patch 3/3 that
gives the file a MAINTAINERS entry.

Changes in v3:

  * New patch 3/3: add a MAINTAINERS entry for hw/misc/applesmc.c.
    The file currently has no entry, so get_maintainer.pl resolves
    only the open list and these patches had no designated reviewer.
    This is easy to drop if a maintainer would rather route it
    elsewhere; patches 1-2 do not depend on it.

  * Rebased on current master. hw/misc/applesmc.c is byte-identical
    upstream to the v2 base (blob fd96f5f), so the rebase is a clean
    no-op with no functional change to patches 1-2 from v2.

  * checkpatch cleanups in patches 1-2, no functional change:
      - patch 1/2: reformat the GET_KEY_TYPE 4th-byte block comment to
        the leading-/* and trailing-*/-on-their-own-line house style.
      - patch 2/2: shorten the F0Ac fan-key comment to stay under the
        80-column limit.
    Both were pre-existing checkpatch warnings; neither was raised in
    the v1/v2 review. The series is now checkpatch-clean.

Changes in v2 (carried into v3, all in patch 2/2, #KEY block):

  * Add braces around the QLIST_FOREACH() count loop body
    (qemu coding style: loops always need braces, even single-line).
    Reported-by: Peter Maydell <peter.maydell@linaro.org>

  * Replace the manual 4-byte big-endian byte-shift packing of
    `count` into `numkey_buf` with a single stl_be_p() call.
    Reported-by: Peter Maydell <peter.maydell@linaro.org>

Patch 1/2 is otherwise unchanged since v1.

On Peter's v2 remark that applesmc_add_key()'s "pointer must remain
valid forever" contract is awkward: agreed it's not ideal, but the
fix (e.g. converting the key table to a glib hashtable that copies
values) is orthogonal to this protocol bug fix and isn't reported as
noticeable in profiles. Happy to send that conversion as a separate
follow-up series if the maintainers think it's worth doing.

Original v1 cover letter follows below.

---

The QEMU applesmc device implements just enough of the Apple SMC PMIO
protocol to satisfy the OSK boot check on older macOS versions. On
modern macOS guests (x86 10.14+, all of the 15.x series) the real
AppleSMC kext enumerates the SMC key space at boot via
APPLESMC_GET_KEY_BY_INDEX_CMD (0x12). The current device only
acknowledges APPLESMC_READ_CMD (0x10) at the command port; every
other command falls through to the default arm of the switch and
sets ST_1E_BAD_CMD.

The macOS driver interprets the resulting 0x82 reply as "spurious
data" and enters a retry loop that floods the kernel log with
kSMCSpuriousData (0x81) / kSMCKeyNotFound errors at roughly 1800
events per second, pegging kernel_task at ~70% CPU and WindowServer
at ~509% CPU. This reproduces reliably on any recent macOS 15 guest
booted with -device isa-applesmc,osk=<valid-OSK>.

This series fixes the protocol-level bug and rounds out the SMC key
table to a complete iMac20,1 profile.

  Patch 1: protocol-level fix
    - Accept WRITE_CMD, GET_KEY_BY_INDEX_CMD, GET_KEY_TYPE_CMD at the
      command port (in addition to READ_CMD).
    - Implement the indexed-iteration walker (returns real key names
      from s->data_def, or APPLESMC_ST_1E_BAD_INDEX 0xb8 once the
      index is past the end so the guest stops iterating).
    - Implement GET_KEY_TYPE returning a 6-byte type/size/attr
      response matching VirtualSMC's kern_pmio.cpp behaviour.
    - Accept and log WRITE_CMD silently.
    - Replace the unknown-key NOEXIST (0x84) reply with a zeroed
      payload of the requested length, logged at LOG_UNIMP.
    - Route the BAD_CMD path through qemu_log_mask(LOG_GUEST_ERROR).
    - Fix MSSD initialiser typo ("\0x3" -> "\x03"). The original
      literal was three bytes ('\0', 'x', '3') truncated to one
      ('\0') by the size argument, so MSSD has been silently
      returning 0 since the device was introduced; the corrected
      value matches what a real iMac20,1 SMC reports.

  Patch 2: populate the key table
    - Add 94 keys covering the categories macOS queries on a Sequoia
      15.7.5 guest: 28 temperature sensors (sp78), 4 fan keys (fpe2),
      12 power-rail keys, 6 DIMM keys, 11 SMC-internal bookkeeping,
      13 motion-sensor / wireless, 3 write targets (HE0N/MSDW/NTOK),
      2 power-management gates (HE2N/WDTC), 8 platform-identity /
      probe keys, plus the Apple-canonical #KEY total-count.
    - Sensor values match a real iMac20,1 idle probe published at
      https://linux-hardware.org/?probe=999fc708a4&log=sensors:
      CPU 40-51 C, GPU 36-42 C, fan at 1200 RPM (= F0Mn idle), etc.

  Patch 3: MAINTAINERS entry for the device (see "Changes in v3").

Measured impact (macOS 15.7.5 guest, iMac20,1 profile):

   Metric           | Before   | After
   -----------------|---------:|------:
   SMC errors / 5s  |   9,225  |     2
   kernel_task CPU  |    70 %  |  ~2 %
   WindowServer CPU |   509 %  |  ~6 %

A note for review on the zero-valued keys in patch 2: the 26 keys
covering DIMM / SMC bookkeeping / motion-sensor / wireless rails are
registered with present-with-zero values rather than omitted. macOS
distinguishes "absent" (NOEXIST reply, retry-poll) from "broken"
(present, value 0, accepted-and-ignored). Registering these keys
present-with-zero stops the retry-poll behaviour without asserting
any specific value. If the maintainer prefers a tighter scope for
this series I am happy to drop any subset and follow up; the
present-with-zero approach was driven by which keys macOS observed
querying during boot.

Backwards compatibility: legacy macOS guests (10.11-10.13) which do
not iterate the key space via GET_KEY_BY_INDEX boot unchanged. The
original six keys (REV/OSK0/OSK1/NATJ/MSSP/MSSD) are still present
and respond with the same values, modulo the MSSD typo fix in patch
1 which corrects MSSD to the value a real iMac20,1 SMC reports.

Tested against current master. Builds clean on gcc-13 / clang-17
with --enable-werror. Sequoia 15.7.5 guest boots to login screen
with the SMC retry storm absent from the kernel log.

Matthew Jackson (3):
  hw/misc/applesmc: fix GET_KEY_BY_INDEX to return real keys, accept
    WRITE/TYPE commands
  hw/misc/applesmc: populate Apple SMC key table
  MAINTAINERS: adopt hw/misc/applesmc.c

 MAINTAINERS        |   5 +
 hw/misc/applesmc.c | 348 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 345 insertions(+), 8 deletions(-)

--
2.50.1 (Apple Git-155)

