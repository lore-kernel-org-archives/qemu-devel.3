Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FD4C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes0y-0007qu-Tw; Wed, 01 Jul 2026 06:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes0x-0007qT-9D
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:17:55 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes0v-0004Kb-Rt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:17:55 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664d4478a64so490369d50.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782901072; cv=none;
 d=google.com; s=arc-20260327;
 b=nlu9R2t6dXnqTOWAS/vr5402rNSFBm3/dQTxPnd8AuIWkjiCk2OPpTtZQHlpVn7vr7
 rgRlO5quBmGaqnd7MDyqHAK5G38xadJwE2J09olm+LlTn/dWQtYwz9ksNHzjPxEZ9G0X
 +DTYKH/+H4Q/TyA3Nx7NWlHA07Ka7A2kcTFBY/N5Pp2T9fF6EjrrWuNgRcLRYMwPZaFr
 jQUJ6KbB+n1+aKdyJBiJsOt2N13Qah5PZrTrqxDXxVdWwlIQ5AQ661wiYpTSpp69/XfH
 galedMlDXwTgqDVszoN2yL9Mgrv1uuRybF0zJbcjqoe/FtlQmi8iUItQlmlc6RakyyET
 iWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yEmWzI0RVS/Bw1VF5wrn8kh2clwN3I0hVTTNgilHq/0=;
 fh=0dcqPTLPDt4LOpf4C0v2p5LqsmDysv9RNiX72DWZ7UI=;
 b=jDmgVkDEBltfL1D4QUWpQtCizcP4Mtc0nymYeebYyOQRzlmJDwFqOwOf7WTLg+RDnz
 8Pdv1I3CgH11MQhUGKtAXuq+MfvE0MF6fPpvJTIYFTuss48QAyLCcWLbS2zko0hG8255
 YKFpLBGhF+zjuMq4kM4Zcok/qQtropXNps0EtEYl3IyDGvFVQlOC9FhNVlnCTedwtEV7
 LqEWE+/vAFXH+QNOlO/N4SU5TaFCLr8a+6WTA88MzBaiZwHjTzI3+62fzGTo+sRZ3iU6
 HCbVAckpN91OT+Myo5puO4MTGnThQbLCZy1U+6aakaJbnodIqLV2Ts1hqdXwPofQ+jvg
 6mFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782901072; x=1783505872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yEmWzI0RVS/Bw1VF5wrn8kh2clwN3I0hVTTNgilHq/0=;
 b=QKPnfz5bCEqsXpuLPZNdyTDnhcaHDTrXUYgujnoHj6jEoFQb8bTwoMubAc13f/KEAh
 UrgdV7Oie+S1RVU46z8goxwPpiASVXFNMfLAgyia8YNpkhLrdlIo6AKuuQsSonO5IKNp
 5KOD1cijtRi0i/p2Wz9gbWN07thPGWUDbAqUkZJS7A+ZYIzaQTbeeems8EknT/Y+7nDJ
 x7s48YyI2HqPdp+emJvVXdKBOaxPQJuhWHKB+GI69KGlcHl/707Snz9WUPN2c54eTjoi
 +2yNukcI+DahrFzEVeVnRs8KJfBsdVkqnmCUlV0GrvSkMjH2VTR6J/b6L6YSFf1vYMeQ
 x8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901072; x=1783505872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEmWzI0RVS/Bw1VF5wrn8kh2clwN3I0hVTTNgilHq/0=;
 b=Nylxw8U/DQpzwNqlyxR7+MxlF8r1I0hEhl6N5wAWCWLPH2C1tnNOoJTBAjtlfUaBcm
 +2SKS6x3roEsNSwIyE9DnMdrvWXfYOisYJqahBP9n0X1/AhlIf72zfSidUBTzk9CYiit
 sN+qtY3q6O4yZwSwO0nw0fwvRCElYABkyzdPTTa91UsFnz2AKekBnimeeRgmUkCbQw9W
 dWs4NWO07/GtupBhnzwlyPx/W1P1F7z/1bJKiW5RjmxCcVHFE8FaeQgLS+QBnm+hjGed
 8PxfSB3/xo7IyfPnP1RU0rLmLfbO8Za4yOVJmHOwjGwQdikMNSvTkyIp2wMwOT6nrES8
 kUlA==
X-Gm-Message-State: AOJu0Yz4Wcb+XKa51za/tJSsrXnp+f76tYOM8cCWVBWmwmL4bnRDtXFq
 nuzcoNxHKoQy14j/RM1urm3aqQiqTo0Qfla7XJ+cuCyBFWbJUWTPa3U7vdTbjJVa+PLD0js+YGK
 52EmXVHvk4KOFdJogiFX7tCDbidUa8ysPnDE4Q7A6yA==
X-Gm-Gg: AfdE7cnR0tloPuKvMeCE4/TmVKqJyDTpPOeG2fXDThDwITqouihS3ERR/x2Om8mdvPH
 lwOUFrTiBwsQQC+W96I8DqFWQ+3A0Wg9cVfBcfYsIVdAgOJeheqTWfb/m6YBrGi+np4elnHUwaP
 llEYN/hjvbsh7vtQwVvE71hxYf50MheWWOHDuU70oD75cI/FrJcgIKh5YYZtsf3I/XKysbxsO+8
 cNl/x3ZvYXAsxZg23ojLB7NNb9DKbcnnhY0LkdvU0GMTQJdvTWnbpKs2GhFpnOBpiHkuBA8b8M/
 6aS1m5XLHwuI4lOKJhvpY9BdQPuvGXNchorzAwcCWJRRuGyD48yDMCrH
X-Received: by 2002:a05:690e:118b:b0:664:ae6d:ad33 with SMTP id
 956f58d0204a3-66521d69a4dmr881598d50.77.1782901072241; Wed, 01 Jul 2026
 03:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260701031803.1817812-1-keith@techtravels.org>
 <20260701031803.1817812-3-keith@techtravels.org>
In-Reply-To: <20260701031803.1817812-3-keith@techtravels.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2026 11:17:40 +0100
X-Gm-Features: AVVi8CdBds4w-sjht2Y0_VvUdKqiA2eDTM1DpeUoHrXH662n5xNjOQs9Ln57WUI
Message-ID: <CAFEAcA-nmkUPtJgb9---_6eBFNdU5_-EndQibQOXEBn_ifUSmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
To: Keith Monahan <keith@techtravels.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 1 Jul 2026 at 04:19, Keith Monahan <keith@techtravels.org> wrote:
>
> Rewrite the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
> LSI53C895A model (hw/scsi/lsi53c895a.c), an actively maintained sibling
> in the same NCR/LSI SCRIPTS family, adapted to the 53C710: its register
> map, single byte (DSTAT/SSTAT0) interrupt model, big endian SCRIPTS and
> table indirect fetch (the part sits on the big endian PA-RISC LASI bus),
> and 24 bit DMA counts.  Behaviour follows the NCR 53C710 Data Manual
> (Jun 1992) and Programmer's Guide (Oct 1990).


>  hw/scsi/lasi_ncr710.c |  120 +-
>  hw/scsi/lasi_ncr710.h |   28 +-
>  hw/scsi/ncr53c710.c   | 3062 +++++++++++++++++------------------------
>  hw/scsi/ncr53c710.h   |  295 ++--
>  hw/scsi/trace-events  |   31 +-
>  5 files changed, 1479 insertions(+), 2057 deletions(-)

This is way too much change to be reviewable as a single
patch, I'm afraid. Can you break it down into meaningful
pieces, please?

thanks
-- PMM

