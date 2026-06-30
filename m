Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9745BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYLI-0007aa-1E; Tue, 30 Jun 2026 09:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1weYLG-0007ZR-IL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:17:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1weYLE-0005rd-9b
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:17:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1276b8c7e2so192329966b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782825451; x=1783430251; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LmjGxbpym5XIZMSyalVLiPcfIxliJbJ2fqI/f39NIrY=;
 b=e2/Ydl7948tJw0NLw0zZ8s6Qlrqo8RrQUHn/SXg5uANgPe0NAhGbdVYgE66JG9z9Kf
 IIZiw6J42Eg62pN3Gj5RPrhZSeq6Vs8Y0quTC9AZuRfBfFynGNoBttFiV5XW3zFFP8W1
 AOX9WHQ5oLAiK4igd4ykIwiLskU8sNvYQ479ULRlLaK/f0ZbqZUmXY2BRryFeQqhKBOz
 8v0JKkLTRD/9BotCdLjZtIhLtw5eH/mzdB3v4Pm3ThYhUYRzoiyXpfvcGU94H1NLR1gT
 gZoDhsYNQwNsUreAvsUsns+/dEzUYMQEy4rERncl90p/p3CDP9By+A78Yl/4flhButqa
 64nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782825451; x=1783430251;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmjGxbpym5XIZMSyalVLiPcfIxliJbJ2fqI/f39NIrY=;
 b=MEuRN7X2S9kuB0+VPgoejpcOtzlIwEME6BHQaPVLV5BfPAByN10QU1OIHdf2EbrLCg
 m3Go/V17QpB2k+ZJAho9rDwgz8urRM30HBUnsoc5vDP65bbIaY8xvbbtamm/sRuRsnNl
 0Wo91SI9tWwAJha9lSp4iJIi9l/BDHfbiBFD/TUL8AmF53ZdqTkKC3Pc5/8t/G6C9nRJ
 JVtwJMZ77xazZwO23JTYb2rUAR13HjYfjNI2k6UiNvDqt8Ff2eV17X7p0YcwZeV48SZh
 vFXjeWVPRBCrfDzo3camiZ7zGjNkwUu2qusGxWgO+zHT6GhFoC2lHghnGyyr17WTCo2K
 Hz2g==
X-Gm-Message-State: AOJu0Yz4NE6pE9DlVvHCHRbfgPdHafQAocHNtsm1oFWu1JnMIHcX/Yzr
 c6K1U15ZZHyKUB4TJZWFTyozn7YrFtmNH10us/GALAy2i7PLLzLB7BLnLjKJqDggh0Y=
X-Gm-Gg: AfdE7cm1v4kx9KkuTG0TPLWgOVx6lEgwtVXQwTOgkToPsI4dXc7xQ7cLQVaGJ5YKm/7
 mN3MY56ej9zUEZNnZXnKd4yecEoBYl6/llc/p8LVF3/Y2chzTi2iC8kLgfCXVqkv7s6ymc7W9QA
 JVGqihefdZMD35DUFLtwv1iKt4maxy/kANoX17mYxulFkYcQJjiasxUifhlQooiR07+hiZTq/Z9
 yNo4dYZoD7yTOv3YEyOqUkVC4myEsS3gc7zQIxZCCLOJYRdlVjvMYte1nSYW5B6muYMLylsQXBI
 r78m/1b4lZQ+HSb7MjSIUHLJYla1jMq+CW7j1f4NIdN3LelZI3ynAjwhET2KqoAaCDtdC5VfuWC
 cV0AW77IdVar1Oh3GZ81ckbpg+As+j3HxdXuwrGnGMV/FL9Gn7/BXw6iqjpwOx6teB17UNLak2u
 CkG5+z0+cpGtQ79Ngq4j8DbwQhJg==
X-Received: by 2002:a17:907:971e:b0:c12:2114:becd with SMTP id
 a640c23a62f3a-c12872b3871mr146074966b.46.1782825450634; 
 Tue, 30 Jun 2026 06:17:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:a648:9a45:1aff:ca47])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c3a42f6sm1201535a12.6.2026.06.30.06.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:17:30 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v3 0/6] Implement FEAT_FPRCVT in cpu_max
Date: Tue, 30 Jun 2026 14:16:31 +0100
Message-Id: <20260630-jmac-fprcvt-v3-0-f4840d5e0a7f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/BQ2oC/23MQQ7CIBRF0a00jMUAAhJH7sM4gF9oMVqaT0M0T
 fcu7cgmDt9Lzp1J9hh9JpdmJuhLzDENdZwODYHeDp2nsa2bCCY009zQx8sCDSNCmShXSrYSDHN
 gSBUj+hDfW+12r7uPeUr42eKFr+//TuGUUe6kPCtnISh+fcbBYjom7MgaKuIHC7nHouIWNATjF
 RdO7/CyLF9KmC1j5AAAAA==
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Bennee <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This introduces new forms of FCVTXX instructions which convert floating
point to integer but place the results in SIMD & FP registers, and
forms of the [SU]CVTF instructions which convert from integer to FP
with a source in SIMD & FP registers. The logic for conversion and test
values are otherwise the same as the versions which use general-purpose
registers.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v3:
- do_fcvt_simd rolled into do_fcvt_f.
- Test assembler rewriten to avoid unintended clobber
- Link to v2: https://lore.kernel.org/qemu-devel/20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org

Changes in v2:
- New instructions are gated on FPRCVT flag
- do_cvtf_simd removed; changes folded into do_cvtf_f
- Some vector forms of instructions are now allowed in streaming mode (new patch)
- Tests restructured to avoid the duplication of fcvt.ref
- docs/system/arm/emulation.rst updated to indicate FPRCVT support
- linux-user/aarch64/elfload.c now reports FPRCVT
- Link to v1: https://lore.kernel.org/qemu-devel/20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org

---
Jim MacArthur (6):
      target/arm/tcg: Implement new instructions for FPRCVT
      target/arm/tcg: Allow vector FP conversions with FPRCVT
      target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
      linux-user/aarch64/elfload.c: Add FPRCVT
      docs/system/arm: Add FEAT_FPRCVT to A-profile support
      tests/tcg/arm: Tests for new FPRCVT instructions

 docs/system/arm/emulation.rst     |   1 +
 linux-user/aarch64/elfload.c      |   1 +
 target/arm/cpu-features.h         |   5 ++
 target/arm/tcg/a64.decode         |  15 ++++++
 target/arm/tcg/cpu64.c            |   1 +
 target/arm/tcg/translate-a64.c    | 101 +++++++++++++++++++++++++++-----------
 tests/tcg/aarch64/Makefile.target |  14 +++++-
 tests/tcg/arm/fcvt.c              |   7 +++
 8 files changed, 115 insertions(+), 30 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260618-jmac-fprcvt-1554d4c80bc8

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


