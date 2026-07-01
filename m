Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A735C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf2Zd-0007uB-Ls; Wed, 01 Jul 2026 17:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.4ijdd3qenjsu6n5=tukaubulnpa5=zye27th3k3x07p@em1175899.techtravels.org>)
 id 1wf2Zb-0007tm-BG
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:34:23 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.4ijdd3qenjsu6n5=tukaubulnpa5=zye27th3k3x07p@em1175899.techtravels.org>)
 id 1wf2ZZ-00089C-Ow
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782941650; h=from :
 subject : to : message-id : date;
 bh=loUvFRcKc/2Ppn91bp6AtFPfYk5qkHlMIFia9txb9d0=;
 b=Ib+KqtJvUSRKxf+uGFTafCXo8Kv5Mtyx1WYE/mhhp5qvF8XUrtWrXkhwRzVOqYWNvOTqo
 Kdyk7QGQXNtVU5xiY1cH5U1a9ai7xFCFLlP4mIQNCM6ZpmAB7/3oMNYoP91sBu0UjBYRA7k
 j+fI9r77BfvX9gbvuuOx4EbkJYdZbWjlnIDEe+BpCnTBnl/3VD8qJmguXBVRNT7s7XWFMQ+
 oa8l2Pb3tV1PoIScOJ43A3hkIvEYoF47wWftD5kc1KHc5qImlOu0nbeTvd97X2hjQm/TWDh
 7U0nWfzRmLDPZg7YNsapEASS2j7m4FqkmJT7/6n+36m5i8pJwKH5Ni9zk9AA==
Received: from [10.91.249.253] (helo=antecquad..) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wf2ZE-FnQW0hPscrZ-KKaz; Wed, 01 Jul 2026 21:34:00 +0000
From: Keith Monahan <keith@techtravels.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
Subject: [PATCH v2 0/4] hw/scsi/ncr53c710: rewrite to support HP-UX,
 Linux and NetBSD
Date: Wed,  1 Jul 2026 17:33:55 -0400
Message-ID: <20260701213359.1855870-1-keith@techtravels.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aL0uvZj:1175899sz_Vqlbc_-
X-smtpcorp-track: dEWXH48TutMI.kP53q71FjMXh.z-f2CgAxAhH
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.4ijdd3qenjsu6n5=tukaubulnpa5=zye27th3k3x07p@em1175899.techtravels.org;
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
Ignite/16700A media) installs and boots on the HP 715 (-M 715), while
keeping the Linux lasi700 and NetBSD osiop drivers working.

I first tried to fix the existing model, but it took about a dozen fixes
just to get the kernel's own driver to negotiate its first command, and
the real problems were structural. It's connected-only and runs SCRIPTS
synchronously inside the guest register write, so it can't do the
disconnect/reselect or async completion HP-UX needs. Fixing that meant
rewriting the interpreter, so the new engine is derived from lsi53c895a.c
and adapted to the 710: big-endian SCRIPTS and table-indirect fetch,
24-bit DMA, the 710 register map, and the single-byte interrupt model.

v1 was one big rewrite patch; v2 splits it:

  1  hw/misc/lasi: independent LASI IRR fix (unchanged from v1).
  2  hw/scsi/lasi_ncr710: drop dead defines from the glue (no behaviour change).
  3  hw/scsi/ncr53c710: the base engine, enough to install and boot Debian
     (53c700) and boot NetBSD (osiop).
  4  hw/scsi/ncr53c710: the HP-UX bits on top (overlapped tagged
     disconnect/reselect, async completion, and the ATN message-reject tail).

Patch 3 is still the large one. It's a from-scratch rewrite on lsi53c895a.c
rather than an edit of the old model, so it doesn't diff usefully against
it, and splitting the engine itself would leave non-building intermediate
states.

On factoring a shared core out of lsi53c895a.c (raised in review of v1):
only ~14% of the 710 is shared code, and the interrupt model and
reselection differ in the interpreter's hot path, so the win is small
while the regression and testing risk lands on lsi53c895a.c and its
guests. I've kept them as sibling models.

Tested on -M 715: HP-UX 10.20 install and reboot (Ignite and an
overlapping tagged software install), Debian install and boot, NetBSD 9.4
and 10.1 boot and device enumeration.

v1 -> v2: split the rewrite into reviewable pieces; no functional change.

Keith Monahan (4):
  hw/misc/lasi: derive IRR from pending and unmasked requests
  hw/scsi/lasi_ncr710: remove dead and shadowing defines
  hw/scsi/ncr53c710: rewrite the SCRIPTS engine
  hw/scsi/ncr53c710: support HP-UX overlapped tagged commands

 hw/misc/lasi.c        |   25 +-
 hw/scsi/lasi_ncr710.c |  118 +-
 hw/scsi/lasi_ncr710.h |   28 +-
 hw/scsi/ncr53c710.c   | 3042 +++++++++++++++++------------------------
 hw/scsi/ncr53c710.h   |  295 ++--
 hw/scsi/trace-events  |   43 +-
 6 files changed, 1481 insertions(+), 2070 deletions(-)

-- 
2.43.0


