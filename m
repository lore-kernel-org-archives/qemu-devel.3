Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ACCCD3446
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2PP-0000tB-Fk; Thu, 07 May 2026 13:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wL0Wq-0004Ad-C4
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:20:44 -0400
Received: from mail-106113.protonmail.ch ([79.135.106.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wL0Wm-00046A-HW
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1778167234; x=1778426434;
 bh=kI+rXLcmJE1sRrwYK9mQCcJt0sOyvaCCRme5UXRIwrs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MCL0hsFy/RDqnZPriqFfvi60YZ+BYzEZXEr/PyYOIhu8wHJrVQQef3YxI76D0aphz
 m9B/tEbX9vuYkksD0hCb0q4P531armNMxrs/IqH0fbEI82yM691twV/HyCyvTtSDVD
 bnbm9SqdYWMCPPWIBqLT4IfA0xvyX5AFNrSizhWJEAQnEzAfJ5j4ofSY+y1Mb9x+O2
 LJLcdmE6FuOPnBH7z3EfzOw997bVtNkvrKJqXm9iaAz/PyRTzKf799yMvVoFmARRhQ
 iuTFBSO5G26Ruquk5Hhk8R8FjP68pBybBSpy2UQVioiHzrgkA2t3Ffd/f3+j3hZ9iL
 gzVsEKags9x3A==
X-Pm-Submission-Id: 4gBGCj3fDfz1DFFm
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v2 0/2] hw/misc/applesmc: fix GET_KEY_BY_INDEX iteration and
 populate Apple SMC key set
Date: Thu,  7 May 2026 08:20:28 -0700
Message-ID: <20260507152030.48753-1-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507040153.14565-1-matthew@pq.io>
References: <20260507040153.14565-1-matthew@pq.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=79.135.106.113; envelope-from=matthew@pq.io;
 helo=mail-106113.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 May 2026 13:21:06 -0400
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

Changes in v2 (all in patch 2/2, applesmc_isa_realize() #KEY block):

  * Add braces around the QLIST_FOREACH() count loop body
    (qemu coding style: loops always need braces, even single-line).
    Reported-by: Peter Maydell <peter.maydell@linaro.org>

  * Replace the manual 4-byte big-endian byte-shift packing of
    `count` into `numkey_buf` with a single stl_be_p() call.
    Reported-by: Peter Maydell <peter.maydell@linaro.org>

Patch 1/2 is unchanged from v1.

Peter also noted that the static-buffer "must remain valid forever"
contract that applesmc_add_key() requires is awkward — fair, but
fixing it (e.g. switching the key table to a glib hashtable that
copies values) is independent from this series and not reported as
performance-noticeable in profiles. Happy to follow up with a
hashtable conversion as a separate series if the maintainers
think it's worth doing.

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

This two-patch series fixes the protocol-level bug and rounds out
the SMC key table to a complete iMac20,1 profile.

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

Tested against current master (post v11.0.0). Builds clean on
gcc-13 / clang-17 with --enable-werror. Sequoia 15.7.5 guest boots
to login screen with the SMC retry storm absent from the kernel
log; smoke test recipe in TESTING.md alongside the series.

Matthew Jackson (2):
  hw/misc/applesmc: fix GET_KEY_BY_INDEX to return real keys, accept
    WRITE/TYPE commands
  hw/misc/applesmc: populate Apple SMC key table

 hw/misc/applesmc.c | 346 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 338 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)


