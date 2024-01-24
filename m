Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDBCC47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaJM-00036s-JK; Wed, 24 Jan 2024 05:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJK-00036K-Mf
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:16:46 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJI-0003mR-Ur
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:16:46 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so6327906a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091403; x=1706696203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QsMxRF0CFPEEOHUzu32CYiZcfWVxxK2j9lUe/1YJuqc=;
 b=w73dlsA40P1BUl/qXhnga1NDU66O2fJaFEeiYTOyO8JVL1tnLkcJat/cIRwzSt8RjB
 22TVMXN5xmStBdnZVUdT3IcW66LBarA67Ipi7JDV4l2OFJnoAa7E8gUW4QrHeOO5N5Ya
 QPO4ndfnlkKX1ZBI+UXh5Y8rjioVSL1MbdKgYPtbJP+IiBj/OasDkuD+YAD82FMioJ7c
 uSBLEC7RkENTutL749FYlKh+88z5xfuD4BNmj6bgER+5W59HrABIor54qwxO9ZhiqJF7
 3V+oRqCrl65RddW9lboWbhGEB+G7CXpc+SnPym1XKx7G3TUrR2Omga8CmyrJvnpvhyGX
 vBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091403; x=1706696203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsMxRF0CFPEEOHUzu32CYiZcfWVxxK2j9lUe/1YJuqc=;
 b=Uk5EFaQhuWDGZ8FhDCUixG9nujkyOwLp2zzDyTwOGgsNIHwyYNfDwzhTqY1XrYf7oi
 vFm8+JF3zNbW4+dzC269wBm7h8JTTJ8EPv+/J8aCoRzdGpY1EdLtfspZOP8iO3dyd+MY
 jsSoNzcKRYZnMvjpYowSvHwupANaJVKI/6ej5GP69JVXESzjfYBQJjskihL2FvN0PcEW
 Zk4SjqXpiuIvyYW1mz+vnp3FwLreg94MusiYkc0pixSHIRwcG+lE+sYhiUlQ3mYlxU9W
 4Te4ujr8nQagKKOKlzjy5Ck+fLTDXQUnN4UOYxf/KYfQfKV/r/LAXpmtWEqP0VbSOMhM
 3wmA==
X-Gm-Message-State: AOJu0YxnlQDiHmhXoQ53Cc4ntdX7RDdMjy44X/c89cWdcpvRW/i2FfmF
 +0G7QIqam8pIXv7emzcTVU13UnT3SLB2klVSffTt5pWKEzM8SFxrr9IF+QzB650=
X-Google-Smtp-Source: AGHT+IHNvZh3ODkgIM3WQgfssAGYGHB11cYmtcRsdLkJNsAcxQHc2QtFZSsOBg4KqX0gE24Q+//gxw==
X-Received: by 2002:a17:907:a807:b0:a31:2249:ae4a with SMTP id
 vo7-20020a170907a80700b00a312249ae4amr355087ejc.120.1706091402778; 
 Wed, 24 Jan 2024 02:16:42 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 vb5-20020a170907d04500b00a313b27f6d5sm144254ejc.147.2024.01.24.02.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:16:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] accel/tcg: Extract some x86-specific code
Date: Wed, 24 Jan 2024 11:16:30 +0100
Message-ID: <20240124101639.30056-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

accel/tcg/ ought to be target agnostic. This series remove
some x86 code, addressing part of "Work still remains" from
Anjo's series:
https://lore.kernel.org/qemu-devel/20240119144024.14289-1-anjo@rev.ng/

Based-on: <20240124075609.14756-1-philmd@linaro.org>
          "Move perf and debuginfo support to tcg"

Philippe Mathieu-Daudé (9):
  accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
  accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
  accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
  accel/tcg: Un-inline icount_exit_request() for clarity
  accel/tcg: Hoist CPUClass arg to functions with external linkage
  accel/tcg: Introduce TCGCPUOps::need_replay_interrupt() handler
  target/i386: Extract x86_need_replay_interrupt() from accel/tcg/
  accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
  target/i386: Extract x86_cpu_exec_halt() from accel/tcg/

 accel/tcg/tcg-accel-ops.h           |   4 +-
 include/hw/core/tcg-cpu-ops.h       |   7 ++
 target/i386/tcg/helper-tcg.h        |   2 +
 accel/tcg/cpu-exec.c                | 125 ++++++++++++----------------
 accel/tcg/tcg-accel-ops-mttcg.c     |   4 +-
 accel/tcg/tcg-accel-ops-rr.c        |   4 +-
 accel/tcg/tcg-accel-ops.c           |   4 +-
 target/i386/tcg/sysemu/seg_helper.c |  23 +++++
 target/i386/tcg/tcg-cpu.c           |   2 +
 accel/tcg/meson.build               |  12 +--
 10 files changed, 103 insertions(+), 84 deletions(-)

-- 
2.41.0


