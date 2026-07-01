Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7FAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welT1-0007RT-RO; Tue, 30 Jun 2026 23:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.wmjdb0t1h3dkll7=4ilyz5s0i13d=tzqe5lfhikhpbv@em1175899.techtravels.org>)
 id 1welSz-0007QS-8H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:18:25 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.wmjdb0t1h3dkll7=4ilyz5s0i13d=tzqe5lfhikhpbv@em1175899.techtravels.org>)
 id 1welSx-0007cR-6q
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782875890; h=from :
 subject : to : message-id : date;
 bh=edhgovhNDa3mmGa8ji+/2ZgMQi4UdURDnJZZ9lPLU98=;
 b=QVtaIyXBU4CYmzs5CI8L/7Gn9QgLVS+UAlvnR1by2BlUPVs/a53pMgUhWbsCuWj22yFRC
 sQ4RE7tyH9/pjgMLx4Q4Ov+IKIAc6Jz/ZJjuHzoMblj1DCzk1iEK6ftkET9ooBu61SlUwoB
 iH2jhUHmKlOj5UZEyo34uXOTGzagnciEJc5itTsFD62yWP7mY6RiQwbqVl2PcrgPxKQusUk
 sNz2Z7zEew7a0FmDzk2KpPUMOUPdfK3cBxhN0Cx3wq5f9aK/a3JoOwFb4nav7Oj5t0aMhgk
 kr4bHd0sLpBxHHUaCFDetH0G/5dogTE31x4rY7vSmhsS1dGGjfwWt/zq27ZA==
Received: from [10.91.249.253] (helo=antecquad..) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1welSg-AIkwcC8jwR2-4BMk; Wed, 01 Jul 2026 03:18:07 +0000
From: Keith Monahan <keith@techtravels.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH 0/2] hw/scsi/ncr53c710: rewrite to support HP-UX,
 Linux and NetBSD
Date: Tue, 30 Jun 2026 23:18:01 -0400
Message-ID: <20260701031803.1817812-1-keith@techtravels.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aL0uvZj:1175899sSo8-tQnzw
X-smtpcorp-track: qqS1pWLeRDN2.2HZjcu5Flei-.974-zg3LElP
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.wmjdb0t1h3dkll7=4ilyz5s0i13d=tzqe5lfhikhpbv@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series replaces the NCR 53C710 model so HP-UX 10.20 (including the
Ignite/16700A install media) installs and boots on the HP 715 (-M 715),
while keeping the in tree Linux lasi700 and NetBSD osiop drivers working.

I first tried to fix the existing model.  It took about a dozen fixes
just to get the kernel's own 53c710 driver to negotiate its first
command, and even then HP-UX would not boot reliably.  Two of the faults
are in the core interpreter itself.  The model is connected only: no
target initiated disconnect/reselect, which HP-UX needs (and so does any
tagged, overlapped I/O).  And it runs SCRIPTS synchronously inside the
guest register write, so completion interrupts come back reentrantly
instead of the way the real chip delivers them.  Fixing either one meant
rewriting the interpreter, so I rewrote it.

The new model is derived from lsi53c895a.c, the maintained sibling in the
same NCR/LSI SCRIPTS family.  Its disconnect/reselect, asynchronous
completion and DMA paths already work across many guests.  I adapted it
to the 710: big endian SCRIPTS and table indirect fetch, 24 bit DMA byte
counts, the 710 register map, and the single byte interrupt model.  The
two LSI models share structure now, so a fix to one can carry to the
other.

Patch 1 is an independent LASI interrupt controller fix (a latched
request register that floods the installed HP-UX boot with "unexpected
core I/O interrupt").  Patch 2 is the rewrite, which depends on it.

Tested: HP-UX 10.20 install + reboot (Ignite 16700A and an overlapping
tagged software install); Debian install + boot (Linux 53c700);
NetBSD/hppa 9.4 and 10.1 boot + device enumeration (osiop).

Keith Monahan (2):
  hw/misc/lasi: derive IRR from pending and unmasked sources
  hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine

 hw/misc/lasi.c        |   27 +-
 hw/scsi/lasi_ncr710.c |  120 +-
 hw/scsi/lasi_ncr710.h |   28 +-
 hw/scsi/ncr53c710.c   | 3062 +++++++++++++++++------------------------
 hw/scsi/ncr53c710.h   |  295 ++--
 hw/scsi/trace-events  |   31 +-
 6 files changed, 1500 insertions(+), 2063 deletions(-)


base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
-- 
2.43.0


