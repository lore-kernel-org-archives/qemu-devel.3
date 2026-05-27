Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348A2CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSCfX-0005IE-PN; Wed, 27 May 2026 07:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSCfW-0005Hg-IK
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:43:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSCfU-0008UA-O0
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:43:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso100163315e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779882202; x=1780487002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IDYcqy+lALeYVl8Mkv8O83zszmMK8AJuHWXrTl78/K0=;
 b=BHJiP8S2sPrw05u36vAC8Z1+gx6wjhtXrsx1ECjV8Q77LRuLK8J+wBdrVEaJlxXTlV
 JHkuTe+4N8G1IdxIiiGwA5MOwORXXMr7tYVbIwVDkPsE1lJhPPH/KhkOVyDfTve1Ymuo
 9fZMU2AIHX03p+l8ji4AyA02ekcmu7XVqhIFR5+q7300uhGjNSM49wBMDDDnTkox9YD6
 HJVHXGnUZ7wQpftQrm51AXrWH5FS4nQiHEMVVL2xkkSEDHIp3lIdlLmtVCcyXMqgy8E9
 tbpfqdt2G0D8u9R9wKcMs5wyGHfHMOysvmJa9kHAX/sSZmfuYJwqwMIPS3T2sCQanbxJ
 p33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779882202; x=1780487002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDYcqy+lALeYVl8Mkv8O83zszmMK8AJuHWXrTl78/K0=;
 b=fl6xFTAVbJPVAsp8j+c9dTBrub1pEq8L5x8EYWh20462CHh2W8hjwnhDTxEm4j336j
 M3nGC7XolGTQ7M21mYpWnw1Me2IV7HdtbsZZeFFPABMg8BIXZbBABb176dQcCrlKrwxa
 Wd5gcDYlW/DQUQfg5EraIEKc7rqFoKWoAxNv7C4kVfd+w8+LDrw9AjLSypH9TO0vb/QW
 /kgO3zKdXzhEuLHWUZH7nnZdgJLEZGdXz6cqYzQU59i/mDeQvWGIITChsw0MmtA3Z6Eu
 YNd7ZDbCITve0xJOGhyGkdpVLIjm1/ZqEL0Js+iuDFJo8pI9b/Ap8+j0JfXu13sG8PjD
 OyTA==
X-Gm-Message-State: AOJu0YzQj3U2mfTpGegNnHWZIPe0Ej3pzPngnINky0hgrsflxMLkL+QZ
 oFSg9n8NxAK73udJXrrSmCMd6RAVW7+QhTpvWCewSI7I6E88wAxGjWk0b0MxV/rucoo=
X-Gm-Gg: Acq92OGwNKpLQHhZuyrNQdtzGBfTJEeCXcFB1o/JKRVCEVcWtK2JJgFbirPLENcsrrL
 IDZ6rLVlpKt/v/ZJuDd/hzi3IiImwqxkdQ1ZCP56+wCkX+hY+vtPQaTiDqvrvtIGAReN7Unuy+M
 IRQbHJj8qZu3NgwkG9QIQ8X1eN25nzbnJcT9QxYtLaPOeuTqB/JugXMz63Tk2V4wQ7g0TyUCd5o
 G6vy41rJJYw83y8HaDAVhWSJGHdKy263wBVZbai8m5eGbk4plDG+XgA1VjRf6p0b4UcwM/sB2b5
 k0n2PEXZhNjkJL36QCS4cJTXzVHQxTeoIGnVAPZQYJRqqimCMa/lbHUWDhCCXWNhiX5huf+4GqK
 dzcQLvLwDOyT/FN5pjQVEH/BZNhg51QJNF8Xl42XoQDgBH66YXv/oWc0CgZe4sw6Kew3P3oM7qq
 rsPxiaU+fPyMe2RfpQbr27oro=
X-Received: by 2002:a05:600c:4f88:b0:490:50eb:b777 with SMTP id
 5b1f17b1804b1-49050ebb9e0mr346140385e9.5.1779882202494; 
 Wed, 27 May 2026 04:43:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454b1ab3sm441824325e9.14.2026.05.27.04.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 04:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C902E5F7F0;
 Wed, 27 May 2026 12:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 0/8] target/arm: fully model WFxT instructions for A-profile
Date: Wed, 27 May 2026 12:43:12 +0100
Message-ID: <20260527114320.1581552-1-alex.bennee@linaro.org>
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

Only the following patches still need review:

  target/arm: enable event stream on WFE instructions
  target/arm: fix WFET typo in syndrome

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


