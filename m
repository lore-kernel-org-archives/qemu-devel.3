Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3DEC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyf8-0000Ki-Rc; Thu, 06 Feb 2025 04:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tfyf5-00008a-Uw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:59:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tfyf3-0006Ji-Hz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:59:07 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f0c4275a1so10482305ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738835944; x=1739440744;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JcH4F+LnQtE4KW/dTgSs8FJ54przEBLLbwEc7DxuhW8=;
 b=E2fD2/wGS6AHxWe3I5Z0OgeVFP3UTPAtlUwRqrMxtQjjSCgX0DZti7hzrc3vjaTCUa
 WvX10XvIlHIzDL8rE2jcu/Fgc+RwpdStIdOPhS7pJpxLlAYtkL9eNSRAdxWyUBNgQ3T7
 ZKMMbEamua9t8/raMe3cHekL0TBDt/Kxru6cF1wO5ZNKjiaRPxeU2Tasl2OCJj7g5k+i
 UA2wCPvoDupHLcKVqhfCrbkT2VlIaiNsxfuuIVHgQatbYT3KA3L4ZG4Y/+fj+Fdb1ZSc
 5QloerUoo+JgYhygPuD5nXhqYK3gRh6RGqFxUserN5gP2P+uaIQqVOtYugt2qXtg2Vv6
 kwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738835944; x=1739440744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcH4F+LnQtE4KW/dTgSs8FJ54przEBLLbwEc7DxuhW8=;
 b=RIuYMgL2hGY9q1cS9ym21wB5E+gsggjgA/Y4E9Wc89tnTS1xQo1bozobi7QXjCZfH2
 jFKw1Gt3umNiLh53rTZqp+pgKDSPPn98DQGJxFqXLiSGoZO23AIPvG3CR/7i9oFr3yEW
 fa0Zyci+jLGTQccALj008NKDgZgE2rKrwfxDAUWeaYt3n2nWEKDDE31R7v3lE3ZKFyt+
 Fh7iIUumBkjfnMPpwCtlzPX31kwaC7aQjE8qiaWL5Jn8J702wMl//Ce7ZaMyn8VmdtER
 8BPs3LCzSMkiAGU7midONSeXZ3bPHWvml9+kkINARCtxcN040hKbCUxIY9iNeQndAkei
 F9Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbhOghr0K/uZsz/Ppw5ePZtMjzeSSR58E7ZkWpJKfBg4rdxhiXnY27ZZ9+bNYR283o0wtC0m5cE6lk@nongnu.org
X-Gm-Message-State: AOJu0YxKlXqePuhSjrq4ICin3/7OZLzjN9KF14StKtZD+rL/y7FG1D1x
 gWhXm/asVBdxBcwyjyVBGhHKavmmDFaORjtWkdkzhq3hvuFqyqkUOCuCFl2L8Wk=
X-Gm-Gg: ASbGnculF62uo2Colnx/RXMZK+dWwHDKgk8vUNP1K1UR4TRjNlTHU5vytppyyveyRF/
 vOMRcAZgDaCyRpj5oHvHOj6QEAKD/6VYJTcXvvF8WMzs1jrnxCDVgeW52fgD3r91FuoRUCtL4qd
 xEQNWQT16CTK2q0ybA8+KE8yMaOLkzAzthhdp0eZnxGvMtDX7jlDiX3DMc/z3IsVmdWluoBvQhf
 h0i2ohV5+kw1uwIgmudLb9zKcGLNSlSVCQ43kD3QKb/4npkyfTo0ztuu7aPhtuy3RpLt85ycRtC
 XsU5vheX0NUE0ytvwNcFuyIf+52u
X-Google-Smtp-Source: AGHT+IHCuhzYGqjM7OMTve90iR1j8XFebNBtkTkIKGYjS/wsA5tL1AQ8GBbxxbXPCSDChA0ruh8bkA==
X-Received: by 2002:a17:902:e886:b0:216:7d22:f69 with SMTP id
 d9443c01a7336-21f17f06218mr86822985ad.50.1738835943892; 
 Thu, 06 Feb 2025 01:59:03 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f365616ecsm8768815ad.100.2025.02.06.01.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 01:59:03 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 06 Feb 2025 01:58:47 -0800
Subject: [PATCH v2 2/2] target/riscv: Mask out upper sscofpmf bits during
 validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pmu_minor_fixes-v2-2-1bb0f4aeb8b4@rivosinc.com>
References: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
In-Reply-To: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As per the ISA definition, the upper 8 bits in hpmevent are defined
by Sscofpmf for privilege mode filtering and overflow bits while the
lower 56 bits are desginated for platform specific hpmevent values.
For the reset case, mhpmevent value should have zero in lower 56 bits.
Software may set the OF bit to indicate disable interrupt.

Ensure that correct value is checked after masking while clearing the
event encodings.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index cf713663ee56..0408f96e6af8 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -390,7 +390,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
      * Expected mhpmevent value is zero for reset case. Remove the current
      * mapping.
      */
-    if (!value) {
+    if (!(value & MHPMEVENT_IDX_MASK)) {
         g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
                                     pmu_remove_event_map,
                                     GUINT_TO_POINTER(ctr_idx));

-- 
2.43.0


