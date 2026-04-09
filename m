Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CC9E98FA6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgPT-0000bd-Uq; Wed, 08 Apr 2026 23:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPS-0000bM-CT
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPQ-0003rc-FO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b2503753efso3938615ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775706622; x=1776311422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G00wOYvj65EA1zo/B3ngd917DbHwZK5hc75QqbKtctI=;
 b=jyFsVy/VLQtvLXS0prljD36xO4Bwh9GkZdQHQzm1uweVCNMKPOtFP77YrPoBp7D1gH
 iaB8QMqAekY+IMD3GhZzIeHQDCTkEzlPznyy+/k19yrwZ9T9Y7hmTZFPIJGUXLFmGgFf
 /Lzf+SCyPzdQzrVS575z33viodbiYbPy+hSf5iMQtlKx9g90iw1IAWpyeFDYEVu6pJhE
 5WY96eN4E6sdB5G0rhNPdIGs5LToVOdyN0H7yG5sRrZWU4Hq7JduBKKrdWPehxYLn5uQ
 AGfQ3ViLf4rdUUPoC1XwhfYz8yVzBj0S41N/2m1HC6+3RJ/FHgV1G1/aIV5d8NXuTECy
 dFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706622; x=1776311422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G00wOYvj65EA1zo/B3ngd917DbHwZK5hc75QqbKtctI=;
 b=jSfLXN/M26xTc7SdiY8qZqVfox9uwqoDXzZJOkGUY7UXD2VykUzEm/rzgyF0HQX398
 PPpLd2WBsgzYId5UjXtj2Axa05IBSADKt7rHI4XGL6QZQdBN7t//oGx1Euqpf38ITdUZ
 3/vocyb5F5Ww2sKGlHLAxDI0PUe91P/VzMCmGfG0OuP5Y5NQlCs8kcrWUhLtjV4CEqN5
 TXGUVGV1mu0LDWSNRLR2RUrmA257/1pgLkbtWWSfdPeTIvqkL/cofY5EefvaTWyRTNOr
 Pp8BAGPNlaffzC7yuvbyBVa2bqhCrLy0asXs6OEyL0w/3KGuhP821JSqtH7Pf1RWrQuW
 AY7Q==
X-Gm-Message-State: AOJu0YzAK9hbRFczgpg7S6w8FZRnpiau5oadGyzRVQOmC/7DIZycpLFh
 pdsDMEI08+mYmZjeTwrniVC9sNvdSdTS+F8+cB6Y/fcYqBf50ZMVPEPf2yBuuO8FqopclBvSHE6
 PgyeXLbs=
X-Gm-Gg: AeBDievBUXjRk0+jjC2+YM/JM1BlJpslnBJkyq5VAqHKJKCCKnGho5HJaFS9qM0UXus
 n0HZAs24Jg7Nxt3xLP4dpoOev8UN34wPl24jktrdlAi3AQ3jhTnDlaakNX0vKi9qvEfwjtFHxKF
 Q85GLVjHrPQ8eztTZ7xHRi8YLKHHCAYLwkgwQxopLdPFEDXsEhZTWuuSivb7vz/FZj8FzOSd8mz
 7+bh/krLCfF3qV5Qb2Hx98m90Eydyy65KI4zjwAx9T74r3OHzPjDuM5H5qEzCdPF6g+P9EI0ve1
 +/IO1h3hRr4RsSvTn48t37zxuSyfFezDlhIM01aHyJyk/uYgA/HKfazyONPoayoijgaoGYmFcl8
 JJe3X75SD5OS0h4hQqmdhI8wTrI7LGcO8N7m9GFE9v7zKvrMxXU0oU5/T0iyKtcnHXgTSHj5Cwm
 8wNThgap8IqH2JeRytBBUq37mpBkJ7YbdedbmuCbcGShXkxTKAq/Mwgvde
X-Received: by 2002:a17:903:3586:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2b28194ec0fmr241096465ad.39.1775706622076; 
 Wed, 08 Apr 2026 20:50:22 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm277830605ad.0.2026.04.08.20.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 20:50:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH v2 0/7] target/arm: Remove bswap_code
Date: Thu,  9 Apr 2026 13:50:08 +1000
Message-ID: <20260409035015.132370-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Based-on: 20260407222208.271838-1-pierrick.bouvier@linaro.org
("[PATCH v11 00/21] target/arm: single-binary")

Version 2 here should probably be RFC.  This time around, all
instruction loading, and more decode, is done by translate.
A new CPUARMState field is added for passing data to EXCP_SWI
and EXCP_NWFPE.


r~


Richard Henderson (7):
  linux-user/arm: Restrict regpairs_aligned
  target/arm: Only define aarch64_untagged_addr for aarch64
  target/arm: Segregate target-specific user-only fields
  target/arm: Store SVC immediate for user-only
  target/arm: Recognize linux faux BPKT
  target/arm: Introduce EXCP_NWFPE
  target/arm: Remove bswap_code

 linux-user/user-internals.h |  2 +-
 target/arm/cpu.h            | 27 ++++---------
 linux-user/arm/cpu_loop.c   | 75 +++++--------------------------------
 target/arm/cpu.c            | 28 +++++++-------
 target/arm/tcg/translate.c  | 63 ++++++++++++++++++++++++++++++-
 target/arm/tcg/a32.decode   |  5 ++-
 target/arm/tcg/t16.decode   |  1 +
 target/arm/tcg/t32.decode   |  5 ++-
 8 files changed, 103 insertions(+), 103 deletions(-)

-- 
2.43.0


