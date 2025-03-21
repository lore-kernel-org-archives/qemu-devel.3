Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16252C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbwX-0007hX-I2; Fri, 21 Mar 2025 08:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwW-0007gz-6A
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwU-0002zj-CZ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-394780e98easo1204705f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742561860; x=1743166660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r31x35p8ltAnwsmr7YiPke9x3zOvdyh82uVgAn6Y+5Q=;
 b=y8xNHXPYikcnEph8Bpt0g3yKSGiqVs6OR3WR+AuxTsRa3/Bsohn4oWxyB8FTQR0lfN
 Zmg9cGokJo7dO9LV9DNuTCWVRlOKRwv4Y213X6gC2S8YR4ZAGbJafOz0crTHqyN4Po2y
 WlH2GBFtSZoBRB/fxR9XBA9rDTYf4muO6QSsE6ntjCIhxxbEeQuBgKxk5SQ5KkSYLAOv
 lZCQ40zDqIyIocx8SP8GlK2oogQv4SpIS+25LXQvo68OqRfivxX7V4HiHiYmSNssvYjx
 A/ect0hz4R/8THFQOkJN4PaK+gsrgZ/SxegSE6K/f9ly2UenStb2CfCjXave3ZlXmy+g
 k2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561860; x=1743166660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r31x35p8ltAnwsmr7YiPke9x3zOvdyh82uVgAn6Y+5Q=;
 b=Ts0n7heMBrjkmDP8jeLCneUdYLz91PmLpW5B99Z0TPrPqv7qrjpaaqCbUSDxT6OsC0
 EHyo6mc9XPNx/4OZGM4VNX19ibzGELtk/zJ/bkG3ppif++r6EeWacL1reMM1lA3drWcs
 IH+yl+NXIRv7fSSW7076jkoz9KcuMPNpu+7WUC89hfICx5n8M/tg1zty1f9eq0VVnLQu
 XIyMOU0paPzMw7ukTsvuflIstDmma20QDi+r+66tCNTgyrEy3CR6Azg2OYWNOcPrKQYv
 k+n/zHAAuVPOow4lwu11j+XMw7+2MrNDz4oKS8yyDXypbiCDIbK41FeH4P2tDa2rOhFw
 bfSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4QhB4J8Ijtw9Bwbnf+Bi3XkP8SKI7sgY9ElrRgOcW9pa29aQcevH2WC1BF2ayBr/dZcT5WqXD+zVJ@nongnu.org
X-Gm-Message-State: AOJu0YxpfJ8xG3K+1BG99+kkrOeYJx8bglPp4p2aw8ZsZbWdcjlRpJNN
 gotw3S9wsz5UDPSf1omr6ym5VshRMJs6piFDdHJseMKoarl3b415rSMJs0Pve7o=
X-Gm-Gg: ASbGncvV+9OjlaDFsZjUTuDwoRZfGssNaPjzNc+Y2cXEppJuMAWgxLz+SICSgSSW6h7
 wr6a8I92EnULOssg3qq4aD1mH+hKk6RElRWdu5NuoOAo/UdPg9UcKUJ4PFwVxS3qSJRoCoDZk5p
 ibFQ2GxXCa8YwxctkRLGQRVOBneOBogIuLjeD6d/nDm676L68ojGKpd6dNQxqwZIO5PcDhd4U1E
 jmIscpKaHwaENVofkQUPS72OH/Xxp/XKj6+vqymNouOjRKAV5QUSwU1OVCcgNcyNpDlLEFWK77I
 b/3zeqlch3p9hKkqEB+vCvRJ9HELN/7XANgF2HFwWrUvIns527B1/6iQ2a7zPu3dcNfeFCFq07Z
 tsu6rhImI5HdqkA7bQR0=
X-Google-Smtp-Source: AGHT+IEfd3pIfvxRmgYqF3aZWO+3NGRX4y/I3jtWMST4gsan+oO/j8avUWjGn2/D7OHdCjHtwz180Q==
X-Received: by 2002:a05:6000:18a2:b0:391:952:c728 with SMTP id
 ffacd0b85a97d-3997f8ede02mr3157655f8f.4.1742561859608; 
 Fri, 21 Mar 2025 05:57:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9f0107sm2347793f8f.99.2025.03.21.05.57.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 05:57:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 0/4] tcg: Move TCG_GUEST_DEFAULT_MO ->
 TCGCPUOps::guest_default_memory_order
Date: Fri, 21 Mar 2025 13:57:33 +0100
Message-ID: <20250321125737.72839-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi,

In this series we replace the TCG_GUEST_DEFAULT_MO definition
from "cpu-param.h" by a 'guest_default_memory_order' field in
TCGCPUOps.

Since tcg_req_mo() now accesses tcg_ctx, this impact the
cpu_req_mo() calls in accel/tcg/{cputlb,user-exec}.c.

The long term goal is to be able to use targets with distinct
guest memory order restrictions.

Philippe Mathieu-Daudé (4):
  tcg: Always define TCG_GUEST_DEFAULT_MO
  tcg: Simplify tcg_req_mo() macro
  tcg: Have tcg_req_mo() use runtime TCGContext::guest_mo
  tcg: Define guest_default_memory_order in TCGCPUOps

 accel/tcg/internal-target.h   | 13 ++-----------
 include/accel/tcg/cpu-ops.h   |  8 ++++++++
 target/alpha/cpu-param.h      |  3 ---
 target/arm/cpu-param.h        |  3 ---
 target/avr/cpu-param.h        |  2 --
 target/hppa/cpu-param.h       |  8 --------
 target/i386/cpu-param.h       |  3 ---
 target/loongarch/cpu-param.h  |  2 --
 target/microblaze/cpu-param.h |  3 ---
 target/mips/cpu-param.h       |  2 --
 target/openrisc/cpu-param.h   |  2 --
 target/ppc/cpu-param.h        |  2 --
 target/riscv/cpu-param.h      |  2 --
 target/s390x/cpu-param.h      |  6 ------
 target/sparc/cpu-param.h      | 23 -----------------------
 target/xtensa/cpu-param.h     |  3 ---
 accel/tcg/tcg-all.c           |  3 ---
 accel/tcg/translate-all.c     |  6 +-----
 target/alpha/cpu.c            |  3 +++
 target/arm/cpu.c              |  3 +++
 target/arm/tcg/cpu-v7m.c      |  3 +++
 target/avr/cpu.c              |  1 +
 target/hexagon/cpu.c          |  2 ++
 target/hppa/cpu.c             |  8 ++++++++
 target/i386/tcg/tcg-cpu.c     |  5 +++++
 target/loongarch/cpu.c        |  2 ++
 target/m68k/cpu.c             |  3 +++
 target/microblaze/cpu.c       |  3 +++
 target/mips/cpu.c             |  2 ++
 target/openrisc/cpu.c         |  2 ++
 target/ppc/cpu_init.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c    |  2 ++
 target/rx/cpu.c               |  3 +++
 target/s390x/cpu.c            |  6 ++++++
 target/sh4/cpu.c              |  3 +++
 target/sparc/cpu.c            | 23 +++++++++++++++++++++++
 target/tricore/cpu.c          |  2 ++
 target/xtensa/cpu.c           |  3 +++
 38 files changed, 92 insertions(+), 83 deletions(-)

-- 
2.47.1


