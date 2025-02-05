Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F14C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWdh-0008Gq-Fq; Tue, 04 Feb 2025 23:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdf-0008GZ-OK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:47 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWde-00077c-8F
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:47 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9e037ee4cso567822a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728223; x=1739333023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PmIqzMr/fPB/LfqYEoYZXkeTJCx/pmM2PE3Rl6UkLfM=;
 b=DXIjwWiUwUIusMw4yxlDIApC2oZYftboERiD+FWwbgl9paHqBKIakCCwY+UhufVZc8
 chmfTfmejtA96/jrN5IwC7yzr7LjBQpCjkDJ1IqF2DSA/iLkf/UxLXsBGIRsc/8d1enW
 WvPomzE1iiFX5cwy5cYEwZf4BlULEf5nXKUwWXEyPQ/zhlWVtLk3GPxlbQxH3SP0KNIW
 LPSccMAo74hlo4hMoB+xQYUxQ+04UNpobKnmxqVPEtGk2K4mR9H5ujXUb9IQ0fVE8qOk
 G7MHyZr+VYyJN/QGm0U/QAGT9SEaAQBRf56XsflWy5ia5C3ZMtduYstLTRzJPus2ySZD
 uHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728223; x=1739333023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmIqzMr/fPB/LfqYEoYZXkeTJCx/pmM2PE3Rl6UkLfM=;
 b=cVd+djmg4Qr2j2e94WlMg3RsC6RXi4aBVi3bA9KoXzf3W45P+5LFV9icibdafs60CT
 JbAjmZ2+LdKzu1rIo8OY41OQQi0IKok+W2IPQb/gK2HLYNVUN1hl7qLa5Fx1SkCpx0ob
 fO5K0yEam0MdN1Y1egSgkI5mVgVdpG+I2dwj1J1er2b9vSnNdu9MJGWhtpQPdwcEU819
 32XAlEyMc2f869OKTjfNazbSU1LPxfI1nA6nlxglNEIzbL2vcc52IZl/JTH/NqKKoyxj
 F58BYRav4pwjZvmW82lFY49JtRebqcRLY+whvTTkO8Npu3LLkveU/QsCULIiIrZRWaKY
 MntA==
X-Gm-Message-State: AOJu0Yz1/RhCx3ldBFbRmYON4Y8Uv2ffNfuf67P0lhZrgvJ5j/fG/HoH
 LmpY09CnMX7Ik05K0U+x+j7yC0Ql/Swbovj7DEvIa9EwNloldTfdT38TJ0ddiPVXIhdE/9SThc2
 V
X-Gm-Gg: ASbGncuIXsYFPFmVaQlaxtPnhOj94uxxqfl8e4W5Ri+z6Er6aFzMew9qK8yHS9/WuVt
 eaDFnigy+zhrci3QeA6rBBMGOAYUVsiphX5tvHw4D1xi2gBHfCFiQytBKTTApnQ7zUJ7n+E+xcy
 48bB2kzMt1cELlXsggShvliL6kwYMfgCcQXv8cYmucGtpzapcqk8iaTG9WwGO0wFkMUMVkRdUyv
 C7YIklt/JFaVb2h0yvPzTOjRuQkGnUfZBFM3B1brHHLENzXhpJm5JuZX8fsS4ko4zRD7Zi9Cs0j
 n39CrziGqhuFcco0qrfGoC5bmsFkZzGWguTbP5LHbvlTfmI=
X-Google-Smtp-Source: AGHT+IFZZB9jndi2Z9g0QOeayawPigxmU+FhI8kIwmo8L7M3Gx43q8QbYdjkU9p06OyH6eD11HrkWA==
X-Received: by 2002:a17:90b:268b:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2f9e075e29cmr2126801a91.8.1738728223487; 
 Tue, 04 Feb 2025 20:03:43 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] tcg: Cleanups after disallowing 64-on-32
Date: Tue,  4 Feb 2025 20:03:30 -0800
Message-ID: <20250205040341.2056361-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This is not complete by any means, but it's a start.


r~


Based-on: 20250204215359.1238808-1-richard.henderson@linaro.org
("[PATCH v3 00/12] meson: Deprecate 32-bit host support")


Richard Henderson (11):
  tcg: Drop support for two address registers in gen_ldst
  tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
  tcg/arm: Drop addrhi from prepare_host_addr
  tcg/i386: Drop addrhi from prepare_host_addr
  tcg/mips: Drop addrhi from prepare_host_addr
  tcg/ppc: Drop addrhi from prepare_host_addr
  tcg: Replace addr{lo,hi}_reg with addr_reg in TCGLabelQemuLdst
  plugins: Fix qemu_plugin_read_memory_vaddr parameters
  accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
  include/exec: Change vaddr to uintptr_t
  include/exec: Use uintptr_t in CPUTLBEntry

 include/exec/tlb-common.h        |  10 +-
 include/exec/vaddr.h             |  16 +--
 include/tcg/tcg-opc.h            |  28 ++----
 accel/tcg/cputlb.c               |  25 ++---
 plugins/api.c                    |   2 +-
 tcg/optimize.c                   |  21 ++--
 tcg/tcg-op-ldst.c                | 104 +++++---------------
 tcg/tcg.c                        |  60 +++++------
 tcg/tci.c                        | 119 ++++------------------
 tcg/aarch64/tcg-target.c.inc     |  40 +++-----
 tcg/arm/tcg-target.c.inc         | 104 ++++++--------------
 tcg/i386/tcg-target.c.inc        | 125 +++++++----------------
 tcg/loongarch64/tcg-target.c.inc |  40 +++-----
 tcg/mips/tcg-target.c.inc        | 122 ++++++-----------------
 tcg/ppc/tcg-target.c.inc         | 164 ++++++++-----------------------
 tcg/riscv/tcg-target.c.inc       |  29 ++----
 tcg/s390x/tcg-target.c.inc       |  40 +++-----
 tcg/sparc64/tcg-target.c.inc     |  28 ++----
 tcg/tci/tcg-target.c.inc         |  60 +++--------
 19 files changed, 314 insertions(+), 823 deletions(-)

-- 
2.43.0


