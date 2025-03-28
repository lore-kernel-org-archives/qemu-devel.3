Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EB3C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFwx-0002qH-Vp; Fri, 28 Mar 2025 16:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFww-0002nM-0e
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:06 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwt-0007bq-Uc
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:05 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f8df49e75fso679099b6e.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192301; x=1743797101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BokeM+CWV1OZuSBS6Fb3zbsmKHp3Lt3H2t4ExWnYYWc=;
 b=Fqk9BNZ3Q6oFgWIZy7DXVNFr80sgjI0J+aoCfkMvAVtqx8woCfrvp9qu4m1AXGe/2x
 MTtY6ikD9NxDemXu+sCUBqhsQ1DOYj9trTW6kwCHhIattmFSE0cf2RAar58Cu0Dl0Pue
 1lgXNzLy4e4+7pG2zKUDks7CXwkNI7DIuDJtJA/nFN/bCTF76SwyTJNmwniRjoBSzWud
 CeE80BVr/dd3MbxJswfqfMGdW4yN4iKkrHHQGsVpswGmUhQzLnZhpqY42WY6VzoASfIS
 R88Gk4+Xi+HYzPp/3VLcvzhlzq5tStesd+iFzk7eve1W0o+ouDH39zXOWI2hQSkh97tw
 gcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192301; x=1743797101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BokeM+CWV1OZuSBS6Fb3zbsmKHp3Lt3H2t4ExWnYYWc=;
 b=nRvFXSgQbNTW2fln3O3ou3jIQNLrbFsSbULRBEwSl8ripMXXz1IzTZ+RA6CeajcDZ9
 erdr5S7e+vsOoh92+CKKfnwtpYe2g9Vrw1HYXi3e+Au/Znmx4vmf6qMaZ5vozBSEQpyU
 BG1uIvQ60i/cKc0mCHi/yDX6G3VRhYhAJ0+yDTeeZx1vBLWIZhbu3Y8Gi760Pr4sKFYp
 Dh5I3sMuurVZk/wOeguI19MsQIWcYrUrDoGIZ8AATfOrxsWpDg85+zKjdnfkfIZhR/wE
 Y9Nq8+ZD6lkQ3lAJQfVhihx2z1KDistwMnq5oaec5N5u+GkAY8P0iURCm8GyfH1eOqGS
 uDsA==
X-Gm-Message-State: AOJu0Yxfbs98JIDy9Sc7ikyhmuc5TgMFN94SsQKqGjkOAuTurKmTmBSV
 xRNdgxOvfMGcMlgRDkR/uODTt/am8h+rN2HQ67KDgovHASM6SibVr5ZKskueUiEF1SRbiBxFqYN
 X
X-Gm-Gg: ASbGncsGBf2RdYO8Ckxr/rdMh3Sue9N7A3ibWRAOS7tD87cnROAn9bN/KP4SmmpJdd5
 CpVRS61MRMkKUh29qwSYONbl0z2rbCFe3G3iOyFlALDYnOES2LVtRUEJjBLkzNCGdBjMjUczN69
 RzAn6m2iWBGoK8MDhagUEhLVg8haBGsmiGBF++7/YYwdY4BowIuDeGlI0BJz/bOoUSJjk+UfJ3h
 PsaNpnKsv74fzXpKK4lS7iAfcHPBKQUxYzSA8V9C1o9jpQbGADrFHQ4E6TehBzHZnud6Haf45Tm
 HWKEeMq55gYR24Bvt3/RIlPmWPm75RYR2uDvxWP9m6lfGeNzjplVpc6OgTTWPejL4psIBodqG87
 ce9ksNDinIWo=
X-Google-Smtp-Source: AGHT+IH2jESxULxLAqiz+tim+yaKOCL1oTViHdoMDG+K5CGYt0NR7MVLSVup0ncmDpO9ENS2sSWKQQ==
X-Received: by 2002:a05:6808:1921:b0:3fb:bc53:d292 with SMTP id
 5614622812f47-3ff0f5351fcmr429682b6e.19.1743192301236; 
 Fri, 28 Mar 2025 13:05:01 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 0/9] single-binary: Restrict scope of TARGET_PAGE_BITS_MIN
Date: Fri, 28 Mar 2025 15:04:50 -0500
Message-ID: <20250328200459.483089-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

With this, TARGET_PAGE_BITS_MIN no longer exists outside of
page-vary-target.c, as that's the only place that needs the
information.

Based-on: 20250318213209.2579218-1-richard.henderson@linaro.org
("[PATCH v2 00/42] accel/tcg, codebase: Build once patches")
Based-on: 20250325224403.4011975-1-richard.henderson@linaro.org
("[PATCH v2 00/11] target/avr: Increase page size")
Based-on: 20250328175526.368121-1-richard.henderson@linaro.org
("[PATCH 0/3] target/mips: Revert TARGET_PAGE_BITS_VARY and bug fixes")

Which is a lot, so for avoidance of doubt:
https://gitlab.com/rth7680/qemu/-/commit/c8b593f1a907794b5767274cb3f5c70985638397

r~

Richard Henderson (9):
  include/exec: Move tb_{,set_}page_addr[01] to translation-block.h
  accel/tcg: Move get_page_addr_code* declarations
  accel/tcg: Remove page_protect
  accel/tcg: Remove cpu-all.h, exec-all.h from tb-internal.h
  accel/tcg: Build translator.c twice
  accel/tcg: Split out tlb-bounds.h
  include/exec: Redefine tlb-flags with absolute values
  page-vary: Move and rename qemu_target_page_bits_min
  page-vary: Restrict scope of TARGET_PAGE_BITS_MIN

 accel/tcg/internal-common.h      | 34 +++++++++++++
 accel/tcg/tb-internal.h          | 38 +--------------
 accel/tcg/tlb-bounds.h           | 32 ++++++++++++
 include/exec/cpu-defs.h          | 10 +---
 include/exec/exec-all.h          | 83 --------------------------------
 include/exec/page-vary.h         |  9 ++++
 include/exec/poison.h            |  1 +
 include/exec/target_page.h       |  2 -
 include/exec/tlb-flags.h         | 68 ++++++++++++--------------
 include/exec/translation-block.h | 50 +++++++++++++++++++
 include/qemu/osdep.h             |  6 +++
 include/user/page-protection.h   |  1 -
 target/alpha/cpu-param.h         |  1 -
 target/arm/cpu-param.h           |  3 +-
 target/ppc/cpu-param.h           |  1 -
 accel/tcg/cputlb.c               |  2 +
 accel/tcg/tb-maint.c             |  1 +
 accel/tcg/translate-all.c        |  1 +
 accel/tcg/translator.c           | 15 +++---
 accel/tcg/user-exec.c            |  2 +-
 migration/savevm.c               |  6 +--
 page-target.c                    |  5 --
 page-vary-target.c               | 48 ++++++++++++++++--
 accel/tcg/meson.build            |  2 +-
 24 files changed, 230 insertions(+), 191 deletions(-)
 create mode 100644 accel/tcg/tlb-bounds.h

-- 
2.43.0


