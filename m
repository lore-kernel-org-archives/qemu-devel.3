Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC13C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1px-0000Rl-At; Mon, 19 May 2025 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pv-0000QI-3X
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pq-000122-Oy
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so36676795e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666277; x=1748271077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jtg/jEBAtu1i0RRW3h2MCs8Jb3XCAZL1GO9RwE/duZU=;
 b=Thwxd/FWTOqjuYPNTOC5WM9JifNEXYvOu/rw/QEMcj+EC52WtoYy30htYE3LLRTnh+
 ovbyF1lE1y4zvi2HKUnunS9aC47ZIGn+QyZEEhpZe840vohOQa7SmzChBkcm7uWRsg0t
 d2t4nTvDgzRnHNfM8zlRyg7YId0AlMmB1ZxG0DhVdKQwBD3ne0ZPlE7ZA+8nS+khqKVh
 VzLv9T5hb5JN+YFGqfItPNcRTEV2523AkDvniC3VKcpcjIJV++KGeAYT0O2nxxEGh4z0
 bxLiz+Vt1whSKnpXK7bBqGzjCvO/9E95oNS1SUYzm5gwli3hSYzSIcFfRbdsD7meUcAP
 L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666277; x=1748271077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtg/jEBAtu1i0RRW3h2MCs8Jb3XCAZL1GO9RwE/duZU=;
 b=TCPTQpEtDDBXdkBXO6ewMjhhbC2Hg2jGJnbqOdaZK1dtKiQqTHrghCwrMJyyJXs1zx
 gcahQPd5HSi+JSfh54lleXUoAN2XrFwy7nT5Qf22wSoOhycc78G/7xo0GI9sWtYxgtCG
 mIP38z9Mu/iGC042Fy1aRQZvOZWMSTHzp4ykGzEJZ2QtT5fyEQityRSiv+TXDQn2HEmh
 QF2urpO1ceCGXviKAKCFhhQVEn+Bed+cT7vsOlDHJ5A5Xg2bfyReBFQpg9mQMlL+NXS3
 GTeXqTOcV6CDabmnubU70najMFsXjEjUKrMrS0rNszvY52cBoMAUcBzWWm9sGF11H2yh
 4xcQ==
X-Gm-Message-State: AOJu0YwCtjl1L3Zyzt2Yv/kCqvsj6f4JPTW8RH20shEUWKNphy1sH9+I
 Cf1GPoUqVlje7kaMxngHzufRL4Wi2eP8j9tLe/iwX1+j23Yq5BGdfFM/ptG+cf6QkTFH/HzORP8
 PEnm5
X-Gm-Gg: ASbGncsixntc7r0rsKp4cMdoaqv50gdrkbeG2h6a+amrj4j0+mFE0XLw+7TJxwgsniZ
 xSNQOGh75VQap9OpV+FVtMT6+FnaU4AArJM+qs1v/cH5CcoYtgSBkQnSEbn0JdO3SAuNk5/ExbB
 6qfwsrIUqheQofydzWrRaxAkAQUlY1PJukdkJOG5/nbmPKOCBv6SHvqYS4XKPoDAG6n2Qrw0FSF
 cqKr/p7RBozLntq7cXPKJUwcFrap7qopUk82TgOdUMXleJZyTkXaMo/NWjZStAgm3Kx0XPTKqQC
 8uRp82a+abeJhdrrwT1Nvfo1qoTxjflVXzdfawTry0VYi+1loHuJ7VyOVg==
X-Google-Smtp-Source: AGHT+IGZopYSu11+YzRxPB93zDc17/+FPYgZiR+DeC8aij/epEGMlhQTfQ1QLi0V7qHrjY5JYG/Tow==
X-Received: by 2002:a05:600c:3e88:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-442fd627303mr122837935e9.13.1747666276851; 
 Mon, 19 May 2025 07:51:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd50b9b2sm145672035e9.12.2025.05.19.07.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:51:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 0/4] target/i386: Emulate ftz and denormal flag bits
 correctly
Date: Mon, 19 May 2025 15:51:10 +0100
Message-ID: <20250519145114.2786534-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

This is a set of four patches to target/i386 which use the core
fpu functionality we just landed for Arm FEAT_AFP to correct
the emulation of some corner cases of x86 floating point:
 * when we are flushing denormal outputs to zero, this should
   be done after rounding, not before
 * the MXCSR.DE and FPUS.DE bits indicate when a denormal input
   was not flushed and was used in an fp operation; we previously
   weren't implementing these semantics

All four patches have been reviewed.  Testing is a bit light (make
check-tcg and make check-functional), because AFAIK there is no
freely available comprehensive FP testsuite for x86, and risu doesn't
support x86 currently so I can't do the same kind of
random-instruction-testing I could for Arm.

Changes v1->v2: just a rebase to apply on current head of git.

thanks
-- PMM

Peter Maydell (4):
  target/i386: Detect flush-to-zero after rounding
  target/i386: Use correct type for get_float_exception_flags() values
  target/i386: Wire up MXCSR.DE and FPUS.DE correctly
  tests/tcg/x86_64/fma: add test for exact-denormal output

 target/i386/ops_sse.h        |  16 +++---
 target/i386/tcg/fpu_helper.c | 101 +++++++++++++++++------------------
 tests/tcg/x86_64/fma.c       |  17 ++++--
 3 files changed, 68 insertions(+), 66 deletions(-)

-- 
2.43.0


