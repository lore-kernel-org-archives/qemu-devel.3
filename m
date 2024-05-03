Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B215EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ryy-0006iq-De; Fri, 03 May 2024 08:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2ryp-0006hc-2T
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rym-0000mj-1M
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5724e69780bso100319a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739130; x=1715343930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+QGJqXeLI9zJ+dCJcjdAIgwiwSsVYyEzcO/p9kZSdPY=;
 b=ZnY588yneAvzsjAEzo9Se7UX8eP1pgTKMKjD2sInjC8uqw0zvB8fiCJYo6ta300Ozm
 ZiILfeSsG/ryBafOUNP1IWrCG+MvURXztBYVAdkJxhEdgWukyxlANfXOqx0FCKfb1VaN
 TY+8+ulY3PIVfnBUb0FUNoItDh/8Wy2kOAgadpVvbdAglqfvQX9a50fNleNbDwkJYl60
 mO+jYbEk3Sx0IYULHCvDsbCGTWu5K9AdBn4FbF64crjjJbMkkfNGPEWVoFKjKRmJG+EJ
 wAzxlTzJscNHXAyZpTw/SdSboEQx0gHVXBHKzq0TUjgVQ/yeHVhNYOJ+Hi6MfN4lSbED
 7HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739130; x=1715343930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+QGJqXeLI9zJ+dCJcjdAIgwiwSsVYyEzcO/p9kZSdPY=;
 b=K33iKH46s4CjDXKRuIt0G3RVP6fZexNA8Vq1eYasCOP6MAvwUnTtLETvTZjIh6iahX
 dDgsSo9FIhs6dohIsrWKaxfSixBGRDcCr7CwMJrPMsAGRGyDxfPBpM89LR5/pm7p029w
 DRC08l+YkfwORZAy6XMyyVoX+XYyBTrrV8TvLWhz3ZWe03QQb2JnRGD0yiMeM2IqkiLd
 Y+nyPpL3DoBrcDfABFTI6TUaqQwDct2ezmsDcNOPEaDi8Pqfj+HRqUUJM/S6Jp9Ql0ox
 nSOEBS8Qn9uZTITE0BhaZnzDjKUbLLUmX6Kyv5Mya+TMYiAGc6l3UcwfT1UHPInoN+1h
 8z3Q==
X-Gm-Message-State: AOJu0YyhXI8mVzlnNW3Uy4qJ2WYKbpYbJvw6ourWUMZO3W0qnkeTX4Es
 czNvau4x1lg+d1CNnCBPqpaSm/v3BRgxUbKZUtOSRiLRMbyFzwKFq6XaU2spiqYPQQEJGltl+R9
 N
X-Google-Smtp-Source: AGHT+IEJTOwJBu/n5yRGw1bD8h5jDnYzSQr/lmtGJQbHkt/eOwEcuJok9JAmKiQhC0eq+H2Br57gzQ==
X-Received: by 2002:a50:ab5e:0:b0:570:1de6:8a2d with SMTP id
 t30-20020a50ab5e000000b005701de68a2dmr1499368edc.10.1714739129513; 
 Fri, 03 May 2024 05:25:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05640203d100b00572c15aba54sm1615099edw.17.2024.05.03.05.25.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:25:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] accel/tcg: Call tcg_flush_jmp_cache() again when
 creating user-mode cpu
Date: Fri,  3 May 2024 14:25:22 +0200
Message-ID: <20240503122526.28312-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
- Dropped patch #1 (use meson subdir_done)

Fix a bug introduced during a refactor in commit bb6cf6f016
("accel/tcg: Factor tcg_cpu_reset_hold() out"), affecting
user emulation. (cpu_reset is called during thread creation,
after cpu_realize).

This issue was noticed by Ilya when running WASM:
https://lore.kernel.org/qemu-devel/20221027141856.w5umjgklawgu7pqv@heavy/

Philippe Mathieu-Daudé (4):
  accel/tcg: Move system emulation files under sysemu/ subdirectory
  accel/tcg: Do not define cpu_exec_reset_hold() as stub
  accel/tcg: Introduce common tcg_exec_cpu_reset_hold() method
  accel/tcg: Always call tcg_flush_jmp_cache() on reset

 accel/tcg/internal-common.h                   |  2 ++
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.h        |  0
 accel/tcg/cpu-exec.c                          |  6 ++++++
 accel/tcg/{ => sysemu}/icount-common.c        |  0
 accel/tcg/{ => sysemu}/monitor.c              |  4 ++--
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.c        |  5 ++---
 accel/tcg/translate-all.c                     |  5 -----
 accel/tcg/user-exec-stub.c                    |  4 ----
 accel/tcg/user-exec.c                         |  5 +++++
 accel/tcg/meson.build                         | 14 ++------------
 accel/tcg/sysemu/meson.build                  | 11 +++++++++++
 17 files changed, 30 insertions(+), 26 deletions(-)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.h (100%)
 rename accel/tcg/{ => sysemu}/icount-common.c (100%)
 rename accel/tcg/{ => sysemu}/monitor.c (99%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.c (99%)
 create mode 100644 accel/tcg/sysemu/meson.build

-- 
2.41.0


