Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40325CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ4V-0007lF-Rk; Mon, 10 Nov 2025 06:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnS-0004tW-QD
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:54 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnR-0004K9-2f
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:54 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-656de56ce7aso200411eaf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762773052; x=1763377852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=d6f6vIf9x5ugrnKGZo2KdESg6EcdQ+cDF8KF7uQmoqs=;
 b=BiMOEVQcxwcLhyBHUsHUS8YamQTntI9G0qIHVjkRxCDZ5Ep0SEq9hAlyla/Ql9hwnl
 0VpH+8l3o1Js0u3aYFqrTWyVm9xBWwfU57B8OdTBoxmT4wHCybSXq4pDGxtNfEJfsXUR
 f8kleAZm/xchUoEx7+TXW3VWjGP6WX6/PfXU1+t+ID+Zm9UdAGzN+YFEeU7Ol3lvTOUt
 PcE53oyXsBlyBSKRVLmj3KktKOiPYAzbA0IzVeKBYhnH2+54cQ9CMoegy2E5rqeDXzPi
 HmdYJuWYIFmHYjWjwrefrsMicH3xSkDG+cgsONLln/QBMDnwLPr0RpiTsJgahB2XBrfk
 0Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773052; x=1763377852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d6f6vIf9x5ugrnKGZo2KdESg6EcdQ+cDF8KF7uQmoqs=;
 b=D40FKq405xiEIFem8idukmjbQCXUU77dkf0QWz2Z5CPaol1TNXiKmr4RszLjdxavzI
 a4/KzYpVfHv0j5Ryai2aXKsvcNz/ugXb9pMII7GRFxZotEtfMmWezmda9aq5zNtW/BZL
 kekBRYFtS1H9+YCRC/nFQ1seoHKyOlFyyDBPnr0FfHB3AJKY13ba85RFQ2Kv1xX1T2wg
 6C2UpvF1A1ayZDlo4KCU77+RSJZpYo8ZVycsvcKPzOyQgQFcLX6+EW+Tt6H1VDJtn0Iv
 aLx5mnxCjcA3Cxqw2Z2aTlMUFrRdSWBxjBYgtSAvBsySk7GTEoSLO+JcX/J+5g75Gctj
 ulDg==
X-Gm-Message-State: AOJu0Yy3JL6NMjxeEmQE8nU3VCwBSXBkUxGMA8CY2yEiRHjHk4NtovFI
 NrFeDiyM0Faa7HHCPwpS6Oq3PuIHIoYSjVNUBI1qCDLFYOT5QT4Z8ti3OC8XQzKc9UmLpo6Y/Gm
 SjAW2
X-Gm-Gg: ASbGncs7EIJy/zCaoIIPebeTrkhFOTBb4DKkwwag3hmAUNxp8h51sDZzwJVPS3tsYy9
 isuY2gYrRlWMuGdwoLkoQPa0lYsbyKc8qMwA4eMWREcQHVxPLGu1AYrmSGOUmeMIH6HdCuUm2YT
 b/PtEB51S1ZFJOIXNCCrUjfJ84PonXAgt0LqSnRSZok9JOZvZwhadypfzhc9e+ZWvwx9u9UCnpX
 4Oy/POmKj1E2uZDGNL+vLqluazsReO6ticIzNa5WwRFEGpRkF9IrtPJpzyGXytwYsNcXaHgkk35
 CRg3jP5Ieo70pZmNxcBMIqWWlyzOMWCP5hT/OJZea2SOhB+rmTwPvo0GCTUjoBnUM4oC05DGjfz
 yYO2IJ4obxYr60KnyVIDI/9QBvy0bkDUzInqoqAQIvnZAbjpGCspcAvspZzFK+rPcIxuTRaVA/r
 J76rRwNF6IgIUu+71uqjAzTsGKMm8WBx/w+oYNiQHD
X-Google-Smtp-Source: AGHT+IFuAl05HjkdaiUOmDnfDoGAXrQ2PcUMg1DOkFlVcoiE/Iunv2P22D/PLeB2WIvmNaH+3vmyyA==
X-Received: by 2002:a05:6808:6903:b0:43d:25a2:e28c with SMTP id
 5614622812f47-4502a3eda35mr3827910b6e.49.1762773051747; 
 Mon, 10 Nov 2025 03:10:51 -0800 (PST)
Received: from stoup.. ([172.58.183.226]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1603412b6e.18.2025.11.10.03.10.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:10:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] misc patch queue
Date: Mon, 10 Nov 2025 12:10:40 +0100
Message-ID: <20251110111046.33990-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20251110

for you to fetch changes up to 4f503afc7eb503997fedad84f24e2cdf696a7a0e:

  target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns (2025-11-10 12:02:45 +0100)

----------------------------------------------------------------
accel/tcg: Trace tb_flush() calls
accel/tcg: Trace tb_gen_code() buffer overflow
qapi/parser: Mollify mypy
tests/functional: Mark another MIPS replay test as flaky
target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns

----------------------------------------------------------------
Markus Armbruster (1):
      qapi/parser: Mollify mypy

Peter Maydell (1):
      target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns

Philippe Mathieu-Daudé (3):
      accel/tcg: Trace tb_flush() calls
      accel/tcg: Trace tb_gen_code() buffer overflow
      tests/functional: Mark another MIPS replay test as flaky

 accel/tcg/tb-maint.c                     | 3 ++-
 accel/tcg/translate-all.c                | 3 +++
 accel/tcg/trace-events                   | 4 ++++
 scripts/qapi/parser.py                   | 2 +-
 target/i386/tcg/decode-new.c.inc         | 2 ++
 tests/functional/mips64el/test_replay.py | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

