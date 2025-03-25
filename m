Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813E7C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6TB-0001ta-S4; Tue, 25 Mar 2025 11:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6TA-0001tD-0z
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:45:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6T7-0004Yr-VE
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:45:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-391342fc148so4047848f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917531; x=1743522331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HL8EXz0VHV7BV56eQxmGC27uJFjwHTVLbnJ0RpyJFbA=;
 b=aXMgQLYoTAOUc7ADSBNQF1VKXCOBw3hFjkO42kz3npxehbQZfun2G8p8JPopA2OtEz
 6oI1LB5izsw7yrAzIWTjGWzmcg1ONWIwNkEhUytDiS8fQmTZkzdgMeTX+fXz8x252xVM
 nu6S2QH/ZgCaC7FfI6GjydwO0dVeuzndWUStoxso6zUER3ZCIOd021NXmbCx+W8YZXMd
 fW+oK9JcrDJ+vVorxQU9lXa4bWJwBvwf1n95u95lw/2UBKd6rjhYSDA0T+e9B0WyCRI6
 O1PyqRsY63IQAYU10FrM2k8B2iTWpWPNk36fCLHy3KesEIezCMdHjhW49U1Ne30kWhPl
 KU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917531; x=1743522331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HL8EXz0VHV7BV56eQxmGC27uJFjwHTVLbnJ0RpyJFbA=;
 b=YOCaf9X8TvnIaqzT/frUX7ud0Sw2JbiSAjcfm2Tf8VtGJuH2MRgz0kgZJzf/9eLb8P
 g7ZHNrXNDrOyTbb/+mwSXB0+eqH6LjuNp7hYjO0egCLF1uA2i3UGWGr3Ra7EivszlKPU
 oQZKOVGUJ9GchzOCKqniYxnmpxjsTPp1XK2+mMfLXcdztjDYMqm6OZtRzHVGg/LPpbmR
 VRqchh3Ks3uIDLyp0Xv6g6D+JZ4dbGsVlhVn427qPe+Hiduqu5upktmBFPd5IakkZqp7
 DV+iLfwByL7O1t4OAFfNHSbkZvgTcbZrvmL66MFx/VCJ6vKDE8ElSXzM8CZnUPOOx0Rb
 GCvQ==
X-Gm-Message-State: AOJu0YwJc4w1OsvBqWiZwN72BjDcZQLLNVdV5XvrjOfC2/S6jl+Ro5Ez
 /3mowDe5sH14ncM2UaZsEyDgqmpq4RB52tXyf24l3eelIgh4xZDeeb2OgHujwTcyEpVc+cm8PJG
 M
X-Gm-Gg: ASbGncttrCLnGhXT/SEesfNecz4SSmpiAuuKbV77+Rd8fAmKFwwNRwDNzpyxoMC4OGh
 MLNUgO9bYUd0qZZ8zu46U2P6yAgpH2bk//4JdqM3BKRN8jwqG5heMqb8yB/bKsLzzXCjjwRPJhZ
 ibApQZKd8wqm4egYdObo9V2mWBzp0/TxAGf4qRjSOKfT3GKCbAexFSS7Vnj2VkV6AvInvjnDlDG
 cLba1kosTGWSkDReexVis+J4+NMYw7Kx4srCe2c6RJcjKdKi6NXl6NE66GsbIwrh8TxjPrZmMX2
 mRFnRzkOYL2S7JHOmWsRsdJDv2cs86MkE3xgcTpUQvQljkHvJCd0hpIF9rGGIsw8LfFKjxUmpXr
 DBubDTIAZoQ3LYj8W8yA=
X-Google-Smtp-Source: AGHT+IFUbWgIeJUkmD78I/l5BcvbQju2UTwJI4qNbFJuWoHv6qm0mgSSfRchG+vTu7TqSKNiO4OgJA==
X-Received: by 2002:a05:6000:43d5:b0:391:454:5eb8 with SMTP id
 ffacd0b85a97d-3997f93c011mr11802837f8f.48.1742917530668; 
 Tue, 25 Mar 2025 08:45:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd18505sm152637485e9.11.2025.03.25.08.45.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:45:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1] target/i386/gdbstub: Replace ldtul_p() -> ldq_p()
Date: Tue, 25 Mar 2025 16:45:28 +0100
Message-ID: <20250325154528.93845-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

When TARGET_LONG_BITS == 64, ldtul_p() expand to ldq_p().
Directly use the expanded form for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 04c49e802d7..3dc022fccf7 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -287,9 +287,9 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < CPU_NB_REGS) {
         if (TARGET_LONG_BITS == 64) {
             if (env->hflags & HF_CS64_MASK) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+                env->regs[gpr_map[n]] = ldq_p(mem_buf);
             } else if (n < CPU_NB_REGS32) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf) & 0xffffffffUL;
+                env->regs[gpr_map[n]] = ldq_p(mem_buf) & 0xffffffffUL;
             }
             return sizeof(target_ulong);
         } else if (n < CPU_NB_REGS32) {
-- 
2.47.1


