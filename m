Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442DDC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuJ-0003RN-0j; Tue, 21 May 2024 23:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuG-0003Q0-T7
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:48 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuD-00049v-7t
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:46 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c9b94951d5so2175894b6e.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349483; x=1716954283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6zSkJG7nKsHBtTYvGdZTECmZuy3enyoH2D9upv5b20=;
 b=NJNlG2L/Mu3kcYB64sSXZMoVbNsi54Mx3SXxpjPJyXolPHZjt0GUI2BrzpAQaeBYdU
 ziKfEcmrl0DDlR/AVfGCnmXLAv+ulNNKH8CsYrZC0hi4q+MJKTlLRiksQOmSZkqeroUf
 4nSNNd/g4wfi+LkRj10shxDtv2YnZCdkmK2MIjBNxde7stJue121e6o3iuI6k6EftZU0
 0gja4kIsxGTSVj+ArYzJoPOByyM9GmgGqyP4YvHpwQBKUoFKIKCMNMKwvgreibWMNang
 1vRJ3HHwtwttqswuzk83v2GpEwNkeCdn4oKpkzHrx16btmCqroUpmRFv9ZUXT5VVkH0n
 aGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349483; x=1716954283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z6zSkJG7nKsHBtTYvGdZTECmZuy3enyoH2D9upv5b20=;
 b=MKmsFelbfAgzzUDdD4oKimThhvWcPDwXS1mz4BGGDSk87aNukxo/zUZLSK/ELS3NJi
 99DqRdyAHCJD1gFE2Ti2yiu1vwSBiNj80xtKsPxeN5GqhoFKN4c/dhfPIBz4S/lDzp4M
 x7Qu48o1OXZbDFdcV6hw2J60sFpjD4nv4/gx/OyhKIWtd0ECuJqf1SlETjiXlaLWRtz4
 xVu1ZJkxuZXZxUo/V3Ov8QIcLr0sArLfNEniVQuO8MLBafumaj5zGNFQIGdE1OYieaKV
 DEjNYf6zWNsi7XmHmJOhI7/jLRHUFJ91vqoyxU9yt6vO/wUIvE1bwm08aEkcdXsPMx9d
 lhXQ==
X-Gm-Message-State: AOJu0Yx9lrY4QZnwLyp6T/opgmmWlbRHwmvZDEhWAKtmQctdJ3mwlD2l
 JEaQzDSuFJI7e6sb6w6W/saPoqMErjijtvchORpmCFsHg9/S2nJc9UnoRs4dmQmmfr8YCflSN/i
 t
X-Google-Smtp-Source: AGHT+IH1z6Nz4YpgEw1edJCzxQgD7ieNOm07U9s04r6m3RoYd8HbTWyL4So2E/xU5FPB6gBnsclkqQ==
X-Received: by 2002:aca:1b05:0:b0:3c7:4976:7953 with SMTP id
 5614622812f47-3cdb32e46b6mr911554b6e.3.1716349483407; 
 Tue, 21 May 2024 20:44:43 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 0/8] ELF and Sparc64 support
Date: Tue, 21 May 2024 20:44:34 -0700
Message-Id: <20240522034442.140293-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Let risu accept elf test files, adjusted from v1.
Adjust risugen to invoke the assembler and linker,
with a cross-compiler prefix if needed.
Add some sparc64 testing which utilizes this.

r~

Richard Henderson (8):
  risu: Allow use of ELF test files
  Build elf test cases instead of raw binaries
  Introduce host_context_t
  risu: Add initial sparc64 support
  risugen: Be explicit about print destinations
  risugen: Add sparc64 support
  sparc64: Add a few logical insns
  sparc64: Add VIS1 instructions

 Makefile                   |  22 ++-
 risu.h                     |  16 +-
 risu_reginfo_aarch64.h     |   2 +
 risu_reginfo_arm.h         |   2 +
 risu_reginfo_i386.h        |   2 +
 risu_reginfo_loongarch64.h |   3 +
 risu_reginfo_m68k.h        |   2 +
 risu_reginfo_ppc64.h       |   2 +
 risu_reginfo_s390x.h       |   2 +
 risu_reginfo_sparc64.h     |  36 ++++
 risu.c                     |  59 +++++-
 risu_aarch64.c             |   6 +-
 risu_arm.c                 |   7 +-
 risu_i386.c                |   7 +-
 risu_loongarch64.c         |   6 +-
 risu_m68k.c                |   6 +-
 risu_ppc64.c               |   6 +-
 risu_reginfo_loongarch64.c |   3 +-
 risu_reginfo_sparc64.c     | 186 ++++++++++++++++++
 risu_s390x.c               |   5 +-
 risu_sparc64.c             |  52 +++++
 configure                  |   2 +
 risugen                    |  10 +-
 risugen_common.pm          |  68 ++++++-
 risugen_sparc64.pm         | 385 +++++++++++++++++++++++++++++++++++++
 sparc64.risu               | 121 ++++++++++++
 test.ld                    |  12 ++
 test_aarch64.s             |   4 +-
 test_arm.s                 |  16 +-
 test_i386.S                |   4 +-
 test_sparc64.s             | 137 +++++++++++++
 31 files changed, 1119 insertions(+), 72 deletions(-)
 create mode 100644 risu_reginfo_sparc64.h
 create mode 100644 risu_reginfo_sparc64.c
 create mode 100644 risu_sparc64.c
 create mode 100644 risugen_sparc64.pm
 create mode 100644 sparc64.risu
 create mode 100644 test.ld
 create mode 100644 test_sparc64.s

-- 
2.34.1


