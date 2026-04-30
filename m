Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBC9CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOt3-0008KA-JD; Thu, 30 Apr 2026 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsy-0008Gf-90
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsu-0005K2-6y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-449e96a8a80so88758f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545877; x=1778150677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uQCxK/7ijLL/t42TsiFPAMhWhZ6B9omgDsTqwxgSxOA=;
 b=NO/zv52GjCHnQ2fvgUOYOlAWJ9eRkP9d1G17dLUZ+RdGujyFCHAxmMwwuZWUjipWJT
 KrwfuoGvU6T2R2TCd7h8fjgAKgscK7O7xqf+I0IojdumyJcqRyigfBkmx904nl41/cUX
 pVDx1IPdIg1bFcZYXwhFd6xrfgWBWfzpj7viqMblJNRtbBz2z6qpUel/kKUslEK72W35
 scX+X1etHCPoGwZ8EZSD+ODQsyZOABjAIXGseXLBc0WB0uMnS5l+p4CyP/npvey3Bwzp
 DzuwSA3VmGksLrCE61kHz+8MdyauMsCWtDUSOWOaCuJsRFVkUT4QyZpBIEw1YYoj0Mg5
 hQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545877; x=1778150677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQCxK/7ijLL/t42TsiFPAMhWhZ6B9omgDsTqwxgSxOA=;
 b=gwXFbZ6FTjhTG0F4rNlKIAVS38UKHVaFXQLmNQLfbFcM74JGfqSkO0BdQOWUpr/G3i
 NnTZG9SO7C5kW1wTgotTW5lI3gfTvTAL3Fy8sbC3czi750JnmCzZr7tp3E2ZfThvEu7t
 YdNsTZCwSbsLDhttmoSFI5iRNSk3EN9tLm9y6WQ9i1PidGlH/9yZyEbm6nWIjugdUcUV
 Db5RKittQwstabtYUiLW58nHBJBOfPWyAOt3QpkEzCtMUrgnVyrDEDbJj5K6RLL3gTzb
 rYhgXkCJ6GOEZx0NGuwcA7JtJPV2m3XIjCb9BNk27CBPVRyJ9iLjYVbw1/6dF6GfokiA
 o40Q==
X-Gm-Message-State: AOJu0YzDvfahNJfHIen+qkyGxFP/9MChvLhC//Mg9nHqcoN7wlAvtUzm
 GMkSYJA3u1QjDlN89eLreQBYfSMs96DzrZf2h6sCKbT6bSBzUVNgRcuy8xwDLJp4u18=
X-Gm-Gg: AeBDievYl+TzTlg9hVK7u5Fq3/k3c6fvz9qTGquImEjMzlaoYEL9xu4tTLId0XWSuIp
 XRPDLNcbrvakWXGeyWzSzu3CNQojWoUGGQsDzXDNgwpYGC39z6NWka5yRHRDPxmxEWoe1kaNyBJ
 RU2nmcCWPL/1jVsXKczAmqz3xwn0mqxsXDuS9GrGlgt1xs47TkyioDuvOvuYNKYBYcpOXUIsxrC
 dpxFn5T9Ikkzd2rEbGmOeFCMmvx/G3hED51Vl371fEeXDEy7GppZPGrSavRJlxIKLwpcumwHcTj
 izYw3LNV+oILjV9WQwFvSi5vMnBVPZqmoSLVx/lcucGHSlk1P+zLqLjgbGZc1Z4n+zQYr5ISf2r
 VPKFtRHzDmJq87nSbl33ST0xrNYUJC5wo9oqt/6S67ww5GgeLr6j/1VQVugeyXNFaeO2kOyI7W3
 aLQZRSooA28S5BipuJ7itJhDZl0vUHx8b+Kg==
X-Received: by 2002:a05:6000:2303:b0:43d:7940:f143 with SMTP id
 ffacd0b85a97d-4493d7f8a6dmr3627316f8f.1.1777545877332; 
 Thu, 30 Apr 2026 03:44:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm1716971f8f.31.2026.04.30.03.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:44:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF26E5F810;
 Thu, 30 Apr 2026 11:44:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Thu, 30 Apr 2026 11:44:27 +0100
Message-ID: <20260430104434.1482407-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

The following patches still need review:

  target/arm: implement WFET
  target/arm: handle the WFE trap case
  target/arm: enable event stream on WFE instructions
  target/arm: implements SEV/SEVL for all modes
  target/arm: teach arm_cpu_has_work about halting reasons

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

Alex Bennée (7):
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  16 +++
 target/arm/internals.h         |  22 ++-
 target/arm/tcg/helper-defs.h   |   3 +-
 target/arm/tcg/translate.h     |  18 +++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   4 +-
 target/arm/cpu.c               |  53 +++++--
 target/arm/helper.c            |   8 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/op_helper.c     | 254 ++++++++++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c |  64 +++++----
 target/arm/tcg/translate.c     |  31 ++--
 16 files changed, 395 insertions(+), 103 deletions(-)

-- 
2.47.3


