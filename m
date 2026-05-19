Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE9BCD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMRw-00005Z-L1; Tue, 19 May 2026 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wPMRc-0008OC-HW; Tue, 19 May 2026 11:33:25 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wPMRY-0002dP-LT; Tue, 19 May 2026 11:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779204784; x=1779463984;
 bh=TLUSb75E2+Mi79iYObYCFOnCZjCa+60+qqKR++qsirk=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZQV2+zPSmg3AEZhc8ZfGYEfOW9lHkYfAuj+43J2wBIspKVq2favGoykwTZllR8DkU
 aB/5Q6lRKCp26+Oo6llNBMQC4acJ1Om4rzRRYAVC3tssluY+JjZAapP27GiHXbbeJG
 +DEgGWIffLHUNj6JyOtCvY62gVZZN87T98iwOTHnTev7+2urSvbBH3NVsp9K/jUVFK
 bUNKwTS/KD6/I4aKAfXGA9L8XyvEiuM1g6hJnSowdbUvmLs8sbk7nYNLii1PHqmcKU
 kVzUnSYDmon0Au69j0AtXWqE73NBSddyToUK+Lz842Y5fgXX74orPdjuco1Mke/4gl
 aVqRu9xnj3swg==
Date: Tue, 19 May 2026 15:32:58 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: implement FEAT_RNG_TRAP
Message-ID: <20260519153249.31100-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: f768763d4384a97b5c460f34371a91a2ee85066e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249; envelope-from=wrigjl@proton.me;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series implements FEAT_RNG_TRAP in QEMU's AArch64 emulation and
enables it on the cortex-max CPU.

FEAT_RNG_TRAP lets EL3 firmware trap MRS reads of RNDR and RNDRRS by settin=
g
SCR_EL3.TRNDR=3D1. When that bit is set, every read is delivered to EL3 as
sysreg trap, from any EL (including EL3).

SCR_TRNDR and ID_AA64PFR1_EL1.RNDR_TRAP are already defined, but
had no readers and no CPU advertising the feature. With these two
patches, EL3 firmware that detects FEAT_RNG_TRAP via
ID_AA64PFR1_EL1 and sets SCR_EL3.TRNDR receives the architected trap.

Patch 1 adds the implementation: an .accessfn on the RNDR/RNDRRS
ARMCPRegInfo entries that returns CP_ACCESS_TRAP_EL3 whenever
SCR_EL3.TRNDR is set, plus a one-line addition to scr_write()'s valid_mask
to keep the bit writable when the CPU advertises the feature. It is a no-op
on its own because no CPU model yet advertises FEAT_RNG_TRAP.

Patch 2 enables FEAT_RNG_TRAP on cortex-max by setting
ID_AA64PFR1_EL1.RNDR_trap=3D1.

Jason Wright (2):
  target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
  target/arm: advertise FEAT_RNG_TRAP on cortex-max

 target/arm/cpu-features.h |  5 +++++
 target/arm/helper.c       | 16 ++++++++++++++--
 target/arm/tcg/cpu64.c    |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

--=20
2.50.1 (Apple Git-155)



