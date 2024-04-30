Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6E9C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1o2b-0002YL-Di; Tue, 30 Apr 2024 10:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1o2H-0002W6-Rm
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1o2C-0002sx-Mp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34c90082dd7so2891541f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714485637; x=1715090437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4wO2taePM39TZMTxZs3nc+Rdb9ASnlYWd4vuIaOr/ws=;
 b=uBlcm1Xo68uho6bR3Ork6iV6Mv9wT9B3QX7VB5xYqrTPvV5RZSnr8nc5mrV75cKo4W
 3NUBTe8lh1+Aebzh14sVCulvldS1W2lhAAUGjWQLqLjjLUidG8YDhWDHSgYiFvGsfqHA
 iHtz+kKbSE6c7EvMk+HetRfPFTaLMJ9J+f6LdfkWp+C/I3Ozhdbui6KprbA2/ebEbB/8
 lQvl3dKTHUk3nJpWicHkWvrZJYQvQB82iyROc2SeT/ZLb+nvaKRTGbzv8U8F37wKOGMx
 iWGoXEs0f05m6L82x/NC3QiAAtdoUlxO5qeKXTghZZ+/aOUzZ3KiCH7ZsXSzhPbca+4+
 T79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714485637; x=1715090437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4wO2taePM39TZMTxZs3nc+Rdb9ASnlYWd4vuIaOr/ws=;
 b=Irm+v26T1wUrVN9cra/vDHmuYBtMXkppfRnDsLXtJ+3RYerOGi1LjQ9z/dpzUzEYjZ
 ys6TojGjgIlMxeUiWFnZe9W/IPRp4AnaLfFJVzJC/bopW/KQxJxl6hY6g0AsuLsYlg18
 sRpiIQYYe6LdeW1sl3TA9VVqMhDBr/POQfu8FY6V9JcdSwHofAQGLmUXvpC46G1oQ3+b
 apKIyggDf8Agcvb000WdX2CRNGpY2TrLDWT5iEtVKUrxcwHPSIBSa15adXaCgAKyeWeu
 9th2uTDFSRZOQvhXrGPvR6QsMLK9fuze9DROFv+Pb1XgShtfmCvmLK+syO3xeuzUJKNK
 +kNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXai6B2+2njENnzf5ZbTDUrBZdkf5e7josvrBZunMq2KbUlm1M1ktTRDXbTh9gf67Mrt/ovkf8tS89J4v1QPj2ZUPHFjQA=
X-Gm-Message-State: AOJu0YxOrvLnArpdS1pXTeChI/P/58SuqkFaIXaqn3IvTlUzLMoeswvs
 8hky6EDlmC+PcpglDbYenHvcuFIscrhqaL5a0Qj7FOgZfO9ELLVx1n4VPLP81YwS8/4eJpjjxcF
 S
X-Google-Smtp-Source: AGHT+IF+WjE48ro0UcCi0IGpblRRziS0JDviFmXK+otoGhYJawD3gJWfw3xaNVYr/U+ssdS3zrB7nw==
X-Received: by 2002:adf:f906:0:b0:34c:4b26:cf7f with SMTP id
 b6-20020adff906000000b0034c4b26cf7fmr10152242wrr.67.1714485637220; 
 Tue, 30 Apr 2024 07:00:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b0041bfa349cadsm11062705wmo.16.2024.04.30.07.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 07:00:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Implement FEAT_WFxT
Date: Tue, 30 Apr 2024 15:00:33 +0100
Message-Id: <20240430140035.3889879-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

FEAT_WFxT introduces new instructions WFIT and WFET, which are like
the existing WFI and WFE but allow the guest to pass a timeout value
in a register.  The instructions will wait for an interrupt/event as
usual, but will also stop waiting when the value of CNTVCT_EL0 is
greater than or equal to the specified timeout value.

This series implements this and enables it for '-cpu max'.
Patch 1 is a tweak to the TCGCPUOps::cpu_exec_halt method
so that we can use it in patch 2 for "do some work when we
are going to leave the halt state".

thanks
-- PMM

Peter Maydell (2):
  accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool for whether to
    halt
  target/arm: Implement FEAT WFxT and enable for '-cpu max'

 docs/system/arm/emulation.rst       |  1 +
 include/hw/core/tcg-cpu-ops.h       | 11 ++++--
 target/arm/cpu-features.h           |  5 +++
 target/arm/cpu.h                    |  3 ++
 target/arm/helper.h                 |  1 +
 target/arm/internals.h              |  8 +++++
 target/i386/tcg/helper-tcg.h        |  2 +-
 target/arm/tcg/a64.decode           |  4 +++
 accel/tcg/cpu-exec.c                |  7 ++--
 target/arm/cpu.c                    | 38 ++++++++++++++++++++
 target/arm/helper.c                 |  4 +--
 target/arm/machine.c                | 20 +++++++++++
 target/arm/tcg/cpu64.c              |  1 +
 target/arm/tcg/op_helper.c          | 54 +++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c      | 41 ++++++++++++++++++++++
 target/i386/tcg/sysemu/seg_helper.c |  3 +-
 16 files changed, 195 insertions(+), 8 deletions(-)

-- 
2.34.1


