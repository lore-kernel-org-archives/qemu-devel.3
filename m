Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66DBE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jS-0000o1-CT; Tue, 10 Dec 2024 11:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jO-0000nM-Cj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jK-0004M3-Tu
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:01 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283d48so4338125e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846697; x=1734451497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FoswyhGfKme1kpeEV97ZDIIbmDczfqis10Qe9ki5BgU=;
 b=SoUKW+VH1z5Cku/Qn2WCKEXnYk6n86LWogY+XplQs5ftHmLYKUDijiQaRqGVZyxDZ4
 9grgUxAc2m1Leo5GyqnKx28BjDycfyREEUd6nwt8l+0woBosen/JDQ2yVOoKwnnebtRQ
 4GgklA+6yp3KeaZR+27t/9AaT/CgghF+HB5FUG86lyhZXMBwe2zCliZkJfEiFOXpezWj
 3tzuW705aofQJlUvJjWMW+3mh2BFSoxLKsHFi3BwOSPKWamb13MhEHsE+CI9Nh4SVB4g
 d5ptmmLYVXIauWXH32oRK68Elu/pBZuoN2gWg0kfq3v8RDqALfYOIJbEBndeJ7m8Ezwa
 0R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846697; x=1734451497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FoswyhGfKme1kpeEV97ZDIIbmDczfqis10Qe9ki5BgU=;
 b=CaGl2BKIhd3kF/q7X3275N6PeE6Z2+eOiaSmYo/MVjj1OTqzJJ/OK4J4ww8wMKYqxO
 VCrRS+EgsamgkfJ8uC/mF/1uVw/JHjm/Ka7zwdb78Cs498PhW5B4tSaKHx5Vi71mgKzi
 c8s7P36u9s9heTrRnyEhJEl7pia77Z/+eBszINEe7psyERlVnPljECi4kSdkQMB5UQ5w
 xEC6NNG/6Ap6RuMmnReXLORXgb7T+ddAiei1XJ00vqVNkgvmkqoRphSjVvnrz1l8ihBp
 tyIQ7ShdXawo/3pJdz8nVMkfsu8O7P4qWeCTVdvujajKMXIOdLnY+PkFO2NQ8b6zv2iO
 VSXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURgB763EVabicVQ42xrhfM6IMER2or8ZjoggOvAtVt/gp4aMCAb88yYM1PG1bvLsCesWKQ5hLaMUHl@nongnu.org
X-Gm-Message-State: AOJu0Yy7kqHrnv6yFAnAgakZwb+NOlvw7rFq5dUScS7hvLUPmzfbdhMR
 uPbAD/41ZUL7GRj0Q774fyyr076aPY8caG6qhQswl3yky3Or8ZkzBsEO8pen858=
X-Gm-Gg: ASbGnctahMdzMRjL/4pffGjTSgXoDB8jdbEXwk4ksM/2pN5jEPW7Vj/Im67CRS3sR/f
 bHY8A9aArlNi59VDNh8MN+vL8DtnEoa3RGid9UqpEh7BwJD7wBHLe800r7vG1HieWanj2+llM0U
 QVanUxQPf7whL0yg/py+iy+cBtRNl4r/0GjlFW/3PDz5b+4rXwleRn9+ZmuoMasrrED8K6J7P4W
 SvaG0kWtENw/XQIr0puhdjjJBKS60AZwC1SSGXL6XrCbFtoZTMmKMNLECTt
X-Google-Smtp-Source: AGHT+IEqYhXWjdXnoBZuIFBOs67H4HIchS/oB3307O37Rv0BZ0qpCEDQKKnofG1vbW03+WG029xQqw==
X-Received: by 2002:a05:600c:470b:b0:434:f767:68ea with SMTP id
 5b1f17b1804b1-434f7676e9dmr68077905e9.5.1733846694173; 
 Tue, 10 Dec 2024 08:04:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:04:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/10] target/arm: Pull TLBI insns out to their own source file
Date: Tue, 10 Dec 2024 16:04:42 +0000
Message-Id: <20241210160452.2427965-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

target/arm/helper.c is very large and unwieldy at nearly 13,000 lines.
One subset of code that we can pull out into its own file is the cpreg
arrays and corresponding functions for the TLBI instructions: these
mostly stand separately from the other code in the file and have few
shared functions or other interactions with it. They make up about
10% of the existing helper.c code.

Because these are instructions they are only relevant for TCG and we
can make the new file only be built for CONFIG_TCG.
        
I split the move up into multiple pieces in the hope of making
it easier to review that way; but in the end the code should
all have wound up in the new file in the same order it was
in helper.c. (Hopefully this will make any backporting of patches
to stable branches smoother; it does mean that in some cases the
order of functions remains slightly odd.)

This is hardly the most urgent cleanup in the codebase;
and there are other parts that could probably be pulled out
(maybe the PMU emulation, and the timer/counter emulation?).
But I did the TLBI stuff because FEAT_XS is about to add more
TLB ops, so it felt worthwhile to move the code out to a
new file first.

thanks
-- PMM

Peter Maydell (10):
  target/arm: Move some TLBI insns to their own source file
  target/arm: Move TLBI insns for AArch32 EL2 to tlbi_insn_helper.c
  target/arm: Move AArch64 TLBI insns from v8_cp_reginfo[]
  target/arm: Move the AArch64 EL2 TLBI insns
  target/arm: Move AArch64 EL3 TLBI insns
  target/arm: Move TLBI range insns
  target/arm: Move the TLBI OS insns to tlb-insns.c.
  target/arm: Move small helper functions to tlb-insns.c
  target/arm: Move RME TLB insns to tlb-insns.c
  target/arm: Simplify condition for tlbi_el2_cp_reginfo[]

 target/arm/internals.h     |    9 +
 target/arm/helper.c        | 1208 +---------------------------------
 target/arm/tcg-stubs.c     |    5 +
 target/arm/tcg/tlb-insns.c | 1266 ++++++++++++++++++++++++++++++++++++
 target/arm/tcg/meson.build |    1 +
 5 files changed, 1284 insertions(+), 1205 deletions(-)
 create mode 100644 target/arm/tcg/tlb-insns.c

-- 
2.34.1


