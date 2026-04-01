Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B11076386
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7z0K-0000st-2V; Wed, 01 Apr 2026 13:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z0B-0000qJ-Mj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:13 -0400
Received: from v58.v5f06b487.use4.send.mailgun.net ([143.55.232.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z07-0007sn-A5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:09 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 5d20a6721737762833a40a9df825c1bee86552a784de2890dbfe1bc9d278649b with SMTP id
 69cd50393b2d605dcd0588d7; Wed, 01 Apr 2026 17:04:57 GMT
X-Mailgun-Sending-Ip: 143.55.232.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775063097;
 bh=OeuhLFtteNMRcBIXpROU188ni1FerINUPvDH+maOmp0=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=rLN1OckE8WB22RFntKqJYqwXfHWamXOoxG9VQD730JAZAIv55zIKTC2VzFv9NZHgu
 KzHM+YmNd/uoFhyX4BJ3pf6reaNZslZLE6hEj3WAmI7VcI9qDvNUI38H4zCnguXX85
 QIJdr1EeqxCJQNlZacuub735yPvwagkd4F3OMmpBaj+SPtibUmaCrYCF8u/Egpzdo6
 4cHcnEcaoFB18mJ+GG26NlpbWsD1jFNhr319kD3zNwnneS7Aa7xrjdfJGD8iQa0Ozk
 ZmsA+ibn6xj2NuKDtbkeD3pE/vNLvs6LuxnYedNYid0iMHXWRirQIwPhM7SVfW0RYN
 4COKiKKqqnScQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [RFC PATCH 0/4] alpha: Decouple the CPU and Typhoon
Date: Wed,  1 Apr 2026 12:04:50 -0500
Message-ID: <20260401170454.32045-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.8;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v58.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Hi,

This series is intended as a leg of a re-spin of the
"QOMify Clipper and Typhoon" series [1]. There, thanks to
a suggestion by Philippe, we decided to decouple the Alpha
CPU from the Typhoon chipset to improve the machine model.

Currently, the CPU owns a QEMUTimer and its state owns the
alarm expiration of that alarm timer. Modification of the
timer is triggered via a QEMU-specific synthetic processor
register in PALcode by changing the expiration value through
the side effect invocation of a TCG helper function,
helper_set_alarm(). Meanwhile, the timer alarm callback is
defined in the Typhoon chipset, so the creation of the timer
occurs during the realization of the chipset; thus, the
typhoon must have access to CPU internals in violation of
encapsulation and architectural accuracy. Instead, as
Philippe pointed out, the chipset should just communicate
with the CPU through an IRQ line wired by the board.

This series does that by removing the timer out of the CPU
and into the chipset. The alarm expiration now resides in
an QEMU-specific (non-standard) Cchip MMIO register at
offset 0x7c0 as implemented in the PALcode binary. The
logic as to what happens when alarm expiration is modified
remains the same as before, but now we don't need the TCG
helper function or the magic process register that triggers
its invocation.

I'm submitting this series primarily to get feedback on
the third and fourth patches, because it blurs the line
of a refactor and a functional change; moreover, it
necessitates a change in an external dependency
(qemu-palcode), so I'm particularly interested in Richard's
(its owner) opinion on the shift from a synthetic processor
register to a vendor-specific MMIO register.

If we agree to take this route, as mentioned earlier, this
series will be folded into the QOMification series that
motivated it.

Patch 4 contains the modified palcode-clipper binary so
that testers would not need to build it themselves, but
my intent is to submit a PR to the qemu-palcode repo. The
diff of the source changes to palcode-clipper are in the
notes of Patch 4.

Patch 3 depends on Patch 4, so they'd need to be squashed
together to avoid breaking bisect.

Patch 2 is much more straightforward: the Typhoon needs
access to the CPU index for its read of the Cchip's MISC
register; right now, we use current_cpu to get the index,
but this is an antipattern, because it violates
encapsulation. Instead, we designate the requester_id
attribute in MemTxAttrs for the CPU index.

Patch 1 defines the instance_init for the Typhoon, so that
we can instantiate the Typhoon in clipper_init() and
connect the IRQ lines between the CPU and Typhoon there in
Patch 3.

I look forward to your feedback.

Thanks,
Yodel

[1] https://lore.kernel.org/qemu-devel/20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev/

Yodel Eldar (4):
  alpha: Define Typhoon instance_init
  alpha: Propagate CPU index via MemTxAttrs
  alpha: Replace helper_set_alarm with Typhoon Cchip MMIO register
  pc-bios/palcode-clipper: Replace qemu_alarm with Cchip register

 hw/alpha/alpha_sys.h      |   4 ++-
 hw/alpha/dp264.c          |  12 ++++++-
 hw/alpha/typhoon.c        |  69 ++++++++++++++++++++++++++------------
 pc-bios/palcode-clipper   | Bin 153728 -> 154432 bytes
 target/alpha/cpu.c        |  17 ++++++++++
 target/alpha/cpu.h        |   6 ----
 target/alpha/helper.c     |  15 +++++++--
 target/alpha/helper.h     |   1 -
 target/alpha/sys_helper.c |  12 -------
 target/alpha/translate.c  |  11 ------
 10 files changed, 91 insertions(+), 56 deletions(-)

-- 
2.53.0


