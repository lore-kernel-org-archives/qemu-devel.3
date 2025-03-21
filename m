Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9471BC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvguc-00086b-El; Fri, 21 Mar 2025 14:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguT-00085U-8d
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguR-00087q-Da
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:15:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso22669375e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580952; x=1743185752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FrLr9SWwVEgbNSSFy6zcLxFZvhfX2JuachjKG//abUc=;
 b=iLrL0StF8jMAr8du3jN0OOeq2AAHv4Y5iAxHX27YJfg6/zCMx3815j+7UwJKPHcHm7
 mIlhZ3Llj2g35M4plcXTuNiBTQ/CL5WczZTfaDGu0Bhqjx1vk0xwvlb1XEgiIDJaY+x5
 vQlsQE50FSZDf8OAkhtWpvT+FF9HWnVBhvl9TfHRfPxjFUMtG3WRoK5x2E+22mGYoGx1
 EAFj7YXuB0PxTXemIdzkD7ljwpathG3KaBuucFjhFEzQZpUOH7SS9Iy6irqWKT4SZM+D
 3coaxmTNTTz5P3wPBlm62UVwt6DIEjX7z66O6vIT6yUtQxFM+7+iFFUnAO30R6VCx4A+
 GD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580952; x=1743185752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrLr9SWwVEgbNSSFy6zcLxFZvhfX2JuachjKG//abUc=;
 b=QEu+gsYSyIavr+CVGgHjgT+ojFmYGl7ZSuYUaKIYz3RMDgNAozu9E/CFVzCyBjcB1Y
 HhbWhD9VzwRfWW4WLSfYeC8Yjn9Ceo86rgcWftOv/4cV8AC+ErW1RCOzmwlN97bdLVjn
 LeASY0ArxNgd7bo2PRFLS7upZhbg/+K8r0iRZ7mziNZgvJVPg3NpzQDCALjtkgxHd0Xd
 GEMyKvYJEVm/moz37mYeWbNfq7REUXFxR4t6LAmshMIaC0TQiRvgjelG7Y/ktx9PcF89
 XDjB9PYdpfD5XlvchVnMhTBkArEa5HPlWMz7Ebg4FcuxQq/vCAyKR/nzQ0cdoRCNpH2f
 JtxA==
X-Gm-Message-State: AOJu0YxUFzhsBYFTyMBaod0UBxkEObuohXEh4/ieUNzKJ+0RksKj9J3g
 EqfhTgpEtYS1WzjsE97iugwso1igFjBkl+FIAnAEGbNHW0f7WsEH9kdfzqUefqwf35M7ql1P70c
 G
X-Gm-Gg: ASbGncsJhs4zUn9V2fBMIZbsPT1wVjDnSwou9o3sBKz6JH1kr90dcpvm4WNYSOZ13BJ
 VkA7bVdrymShCbSLss1rRRRhQVOK6qKJZR+Wcdu58wWsP6Ay4qq7TJk4elRs6Dsd41GRiDHT3KA
 ceTcUAEhxxIw83VK36lN4iw+iY681pGbuGmVit2efIQssN7cC5MELLyOtmmcMI95BiHthm8GbSs
 AgkzrXRtYeso5e5+s/mIHnPUv6PeLs5e9V2WGsDzKnvC2LdzOceBRqsP4oouFnlWHN9vr5LMPxc
 byYqiYYM2dsC+GnPL3O7+gu/jUam7tkjA7cWb36UnRHqp3VACoRutk80VTt0Og9DMhBuOEFHqsF
 fM7WsMzxIcNN9iyMYKpM=
X-Google-Smtp-Source: AGHT+IHxhwW2oi2ezLVz+AIwqTVvi/+8JXDZLRbpOIO6+2qLrtLdJoVzNLSORauFZLMKxIHhpGq+qQ==
X-Received: by 2002:a05:600c:1d9f:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d50a201a9mr43532035e9.20.1742580952503; 
 Fri, 21 Mar 2025 11:15:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f332adsm85179625e9.3.2025.03.21.11.15.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:15:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 v2 0/7] tcg: Move TCG_GUEST_DEFAULT_MO ->
 TCGCPUOps::guest_default_memory_order
Date: Fri, 21 Mar 2025 19:15:42 +0100
Message-ID: <20250321181549.3331-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Since v1:
- Do not use tcg_ctx in tcg_req_mo (rth)

Hi,

In this series we replace the TCG_GUEST_DEFAULT_MO definition
from "cpu-param.h" by a 'guest_default_memory_order' field in
TCGCPUOps.

Since tcg_req_mo() now accesses tcg_ctx, this impact the
cpu_req_mo() calls in accel/tcg/{cputlb,user-exec}.c.

The long term goal is to be able to use targets with distinct
guest memory order restrictions.

Philippe Mathieu-Daudé (7):
  tcg: Always define TCG_GUEST_DEFAULT_MO
  tcg: Simplify tcg_req_mo() macro
  tcg: Define guest_default_memory_order in TCGCPUOps
  tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
  tcg: Propagate CPUState argument to cpu_req_mo()
  tcg: Have tcg_req_mo() use TCGCPUOps::guest_default_memory_order
  tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally

 docs/devel/multi-thread-tcg.rst |  4 ++--
 accel/tcg/internal-target.h     | 19 ++++++-------------
 include/accel/tcg/cpu-ops.h     |  8 ++++++++
 target/alpha/cpu-param.h        |  3 ---
 target/arm/cpu-param.h          |  3 ---
 target/avr/cpu-param.h          |  2 --
 target/hppa/cpu-param.h         |  8 --------
 target/i386/cpu-param.h         |  3 ---
 target/loongarch/cpu-param.h    |  2 --
 target/microblaze/cpu-param.h   |  3 ---
 target/mips/cpu-param.h         |  2 --
 target/openrisc/cpu-param.h     |  2 --
 target/ppc/cpu-param.h          |  2 --
 target/riscv/cpu-param.h        |  2 --
 target/s390x/cpu-param.h        |  6 ------
 target/sparc/cpu-param.h        | 23 -----------------------
 target/xtensa/cpu-param.h       |  3 ---
 accel/tcg/cputlb.c              | 20 ++++++++++----------
 accel/tcg/tcg-all.c             |  3 ---
 accel/tcg/translate-all.c       |  6 +-----
 accel/tcg/user-exec.c           | 20 ++++++++++----------
 target/alpha/cpu.c              |  3 +++
 target/arm/cpu.c                |  3 +++
 target/arm/tcg/cpu-v7m.c        |  3 +++
 target/avr/cpu.c                |  1 +
 target/hexagon/cpu.c            |  2 ++
 target/hppa/cpu.c               |  8 ++++++++
 target/i386/tcg/tcg-cpu.c       |  5 +++++
 target/loongarch/cpu.c          |  2 ++
 target/m68k/cpu.c               |  3 +++
 target/microblaze/cpu.c         |  3 +++
 target/mips/cpu.c               |  2 ++
 target/openrisc/cpu.c           |  2 ++
 target/ppc/cpu_init.c           |  2 ++
 target/riscv/tcg/tcg-cpu.c      |  2 ++
 target/rx/cpu.c                 |  3 +++
 target/s390x/cpu.c              |  6 ++++++
 target/sh4/cpu.c                |  3 +++
 target/sparc/cpu.c              | 23 +++++++++++++++++++++++
 target/tricore/cpu.c            |  2 ++
 target/xtensa/cpu.c             |  3 +++
 41 files changed, 118 insertions(+), 107 deletions(-)

-- 
2.47.1


