Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E0CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsbT-0001SU-Lj; Fri, 29 May 2026 04:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbK-0001OY-PP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbI-0005QZ-E5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4905529b933so52910045e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780043391; x=1780648191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PqBIIlOsJpFHNeGX5mY/Ufew+QU+w61wObkGDAw6TBw=;
 b=oSodMyX+nUNhuQxCvR6DrNc6o7RKhQaRuG7fvedk5eXxjbQ/7WeO8RNiA/JZdPy2mA
 SLjJxCM8AxgBMXkHOH/zwm6pCpiRcJqJ7/umhiinirjvyHWBi00XozGH+7kgt+fbiRUD
 kPIrD0DZocHzgahwcnUWpLeqMDEBCAtZhQEDlOib9Vmi22nbPBqkey84tMUEMVEQcyi9
 Fg+cdxrAIlc+3d95KPOGEylBRCoFouWcQvfwk8fVeYB8ySFZv5bDZP4ZYlccsfNY2AF9
 vZZlv9lVufNMOYUm8waho7nCf3XnnvV3fPqNpUcb8G7YFpgLCQV++e/JKt2/opq1JCwA
 DMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043391; x=1780648191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqBIIlOsJpFHNeGX5mY/Ufew+QU+w61wObkGDAw6TBw=;
 b=BdbMwSKUfEWcuLwRB0lvehklgC5XqmOh5OFN/GTYmRh/tC7gJ4cK3OLJ545Jn5eLZw
 Ju7Vb8tT4QjLdszkGZTnlhb4WTIGT5Hq3deiY7QshuNK4qGxquutuDaUxMphRNb3LQML
 xBOmW0DFqB4P6yIAiwZVEHX/G7ZH0lVJqzTcUqBTVbGDfxDZCwD1Mh3SLW5THvMkGacX
 6sQxATfUO0yBvLTrj3AMexqA/DA9jEDz4adxLh1W5PB+A6IS51Z3lz4IapAzsvpIVUPf
 RpT4+oopvj/x61AD2YJN/iQrkzyioa4GGPkK8fWaYDJ0tjTAXAeHnfQu8mu/zDCzBJQY
 hKhA==
X-Gm-Message-State: AOJu0YxSXNI48vLmTV6bbgQXfQTz2gEH+srpBSxZairzzfC34N2k10Mr
 5WoL9wXrDljVEiGqTMcfy9dEgJ+50PH7vE6PGX9y8SwT9Y+MKj4sdfl6atXTgGPilxc=
X-Gm-Gg: Acq92OHjTvvUZkAOB8WqLep8F9/RZprLFICBff3V5COUB7UJlOfuW14g2aFAq+Q7avp
 U4QxzjvJ6qyyvK+X3V/A3kotSBQae/UOBBGvwNg21avhPpi1ZBr+Goc/TWLsph5olyP3ktATw7e
 At9BpQ2vspYhLajG8wZ2J0lJc1poT6C/vHh0rDcs17MJAUj6sJk7yA0/yc7gPJrK8ENJI7Dh7Wm
 IJlRiCRkXYLoF/FzU28xZL+4kFbFdtWtoSxf9AEKNg4+3fF13q24FFfyZHRN18uPuFSy2xTpSGB
 Td+EzGYUKTA7o3rrhOWUhC8AvcH/QPG8CfDG57gfo075+ZV37FA98eDqmkluEidPbrwIytZqwZr
 hkW8F4N8eV+H1avN+XMpMnrLA+OuAyKpzZFUbF/+CCGNGpQKIIrifJMSOnFUFx4IAV0NkF6LVjO
 pgt1iYVzHKwvtRFDS06xMqxm1SX9YppvNsxQ==
X-Received: by 2002:a05:600c:48aa:b0:490:81cb:d7a with SMTP id
 5b1f17b1804b1-4909c0c6b91mr19611555e9.29.1780043390709; 
 Fri, 29 May 2026 01:29:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d5f2347sm24497485e9.0.2026.05.29.01.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2125F5FA53;
 Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v7 0/8] target/arm: fully model WFxT instructions for A-profile
Date: Fri, 29 May 2026 09:29:39 +0100
Message-ID: <20260529082948.363931-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

This series fully models the behaviour of WFxT instructions. We
already had support for WFE for M-profile but we left off A-profile as
it has more potential sources of wake-ups. The main one is the event
stream which includes events from significant bits of the timer
ticking over.

The refactoring from the previous iterations of the patch have now
been merged.

I've dropped trying to fully model the global monitor in favour of
taking advantage of the architectural flexibility to have an IMPDEF
event wake up for any reason. We treat the setting of exclusive_addr
as such a reason because it indicates the current vCPU is in a ldstx
exclusive region and we don't want the guest to deadlock. This does mean
the system won't sleep on WFE enabled locks but people shouldn't be
relying on QEMU to model real world sleep patterns anyway given the
efficiency of emulation compared to real HW.

I've written a test case using kvm-unit-tests:

  Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
  Date: Wed, 27 May 2026 12:18:21 +0100
  Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
  From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

All patches are now reviewed.

v7
  - more r-b's
  - extended comment for typo fix
v6
  - add typo fix
  - addressed rth's comments

v5
  - addressed rth's comments
  - all but one patch now reviewed

v4
  - precursor refactor patches now merged
  - dropped global monitor emulation
  - addressed other comments
  - tested with check-tcg and kvm-unit-test wfx tests

v3
  - fixed the WFE exception handling

v2
  - I've kept the tests separate, see:

    Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
    Date: Fri, 17 Apr 2026 17:43:20 +0100
    Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu tests
    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

  - tweaks to global monitor behaviour
  - STLR/STL will also trigger events to avoid deadlocks
  - see under the --- in the patches for details

Alex.

Alex Bennée (8):
  target/arm: fix WFET typo in syndrome
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  16 +++
 target/arm/internals.h         |  22 ++-
 target/arm/syndrome.h          |   2 +-
 target/arm/tcg/helper-defs.h   |   3 +-
 target/arm/tcg/translate.h     |  18 +++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   6 +-
 target/arm/cpu.c               |  53 +++++--
 target/arm/helper.c            |   8 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/op_helper.c     | 253 ++++++++++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c |  64 +++++----
 target/arm/tcg/translate.c     |  31 ++--
 17 files changed, 395 insertions(+), 106 deletions(-)

-- 
2.47.3


