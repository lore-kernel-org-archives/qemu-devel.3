Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D3FC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgOr-0008Mz-L4; Sun, 04 May 2025 16:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOl-0008Kx-7n
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOj-0006vo-Bz
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22928d629faso34754075ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392235; x=1746997035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HD+imtZlzHGDOgF1Aio82lZgJj3Y9FMrRVGZbJJ31CM=;
 b=M1XQ//+SCPN413TrWuLt1eBBbtc1ObLQ6MnHkrgY0p17NVORsjJj7ynYDLXItMt73z
 MhmNmrK4FnVuAGsbMScUlOzZkKFEC2nZetBsVpXixSTa/u+h+E1PZWwDK9al/hdGi3AM
 vQOFpHLA2bMqx70V9dEk8OFV/BdacS8anlAZODh9dx0ciWKUI40LOz8piEqIxhQfErVj
 +MscB6GPFmVfpbeuh0vpaXzdFPrZzUC1ly/BnoIXDvm7saUeQ9pqQ5adoAqY04Ncuy8L
 y0MpFE3u41dplzOWF0bwYGdqTeZVrzx8l3wLJI8BenoBbxV+UypvsUieNW9weV+h10JT
 WWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392235; x=1746997035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HD+imtZlzHGDOgF1Aio82lZgJj3Y9FMrRVGZbJJ31CM=;
 b=rTjOmL65e+a2oOosI8b4RVlMyaIGNIncWZvlUF205u4exINjBqrLzQn+L0lEdXVVO7
 Lr0G2AeKwvQSAdpW41NkkuYjg6GL+7opEDqXFQdMadgStqIRo2OJ7hoFPMFq+e99ub4K
 SO73PgcgG+8Sc0+UADrCbnzRrVs2g0q+5WjPqrbCkvJC/YuYOLeUN2v1XkHjws8o+8+x
 /l8ihD2l0t8GerNJI8xCC5govsdbJVhQ6D3iM6zMKSsfr3SDNsqjx5nk6XfB50iiIFh0
 Mf4CU6GTLDRQwG3szv5lllyj9Q8yEsEZg1YKmwWtDFwOYHf8xthUUWVIueh07NNP7kwr
 8ZcA==
X-Gm-Message-State: AOJu0Yw5MTverlf6d4rYtQ37QB+auEJL4TSz6Z0p7BAdobTrh+8iSYOG
 cvYAHB8TisivoZPBE6yXJhvCf/04LZDHeoaZO8P8LoDBnOTd5EtcN4+xFUw/P9tVD7ZX0kRR1us
 j
X-Gm-Gg: ASbGncuPoIOHp3fzcA4mSNnCgewDlnPjDPa8UnkGqYBYvslGjjTQWDqBcQ//5HqJL1z
 kYrAJNobq5cEz1Y4BEQGsNHj18Wbci78Ua+SmxBo5VqLt/TJXmqO7PX/iQanKfi5QGeUfhtvNCQ
 ZkyoZ/vm/uHFTP0ATXfeDa/G5jziDkn97eKlGDFSbe92D4qFuBlTlQl/IndnjTEXMLX/dQC/wO/
 cODiQHnKFXJR2H1Tu5QZz0o1HHnFwBXeDrhnMkhMbwNxH5fTFnWINI+bqXaY115/TPJzZ9pOUgz
 kozTB5oGmpffnj/SFlS3QiqPKPJN/wKzBxotB63GOVZEC4E1ncdrLC8+QMPnDJJ1sXE/eI6DTXK
 6uhKozXupUw==
X-Google-Smtp-Source: AGHT+IEJRPPx1t7sQfQkaHKwDtwXU9RMS6U7H3RrJWUd6onfWc1kP82ICfmTGrLN8uRzxmNtXapoVA==
X-Received: by 2002:a17:902:ce89:b0:224:826:277f with SMTP id
 d9443c01a7336-22e1ea61bddmr65100935ad.33.1746392235393; 
 Sun, 04 May 2025 13:57:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com
Subject: [PATCH 00/12] accel/tcg: Fix cross-page pointer wrapping issue
Date: Sun,  4 May 2025 13:57:01 -0700
Message-ID: <20250504205714.3432096-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

As detailed in

https://lore.kernel.org/qemu-devel/174595764300.3422.13156465553505851834-0@git.sr.ht/

there's an issue with an unaligned access that falls off
the end of the last page.  To solve this, we need to know
about the state of the cpu, so add a new target hook.

There are arguments to the hook that are currently unused,
but would appear to come in handy for AArch64 v9.5 FEAT_CPA2,
which we do not yet implement.


r~


Richard Henderson (12):
  accel/tcg: Add TCGCPUOps.pointer_wrap
  target: Use cpu_pointer_wrap_notreached for strict align targets
  target: Use cpu_pointer_wrap_uint32 for 32-bit targets
  target/arm: Fill in TCGCPUOps.pointer_wrap
  target/i386: Fill in TCGCPUOps.pointer_wrap
  target/loongarch: Fill in TCGCPUOps.pointer_wrap
  target/mips: Fill in TCGCPUOps.pointer_wrap
  target/ppc: Fill in TCGCPUOps.pointer_wrap
  target/riscv: Fill in TCGCPUOps.pointer_wrap
  target/s390x: Fill in TCGCPUOps.pointer_wrap
  target/sparc: Fill in TCGCPUOps.pointer_wrap
  accel/tcg: Assert TCGCPUOps.pointer_wrap is set

 include/accel/tcg/cpu-ops.h | 13 +++++++++++++
 accel/tcg/cpu-exec.c        |  1 +
 accel/tcg/cputlb.c          | 22 ++++++++++++++++++++++
 target/alpha/cpu.c          |  1 +
 target/arm/cpu.c            | 24 ++++++++++++++++++++++++
 target/arm/tcg/cpu-v7m.c    |  1 +
 target/avr/cpu.c            |  6 ++++++
 target/hppa/cpu.c           |  1 +
 target/i386/tcg/tcg-cpu.c   |  7 +++++++
 target/loongarch/cpu.c      |  7 +++++++
 target/m68k/cpu.c           |  1 +
 target/microblaze/cpu.c     |  1 +
 target/mips/cpu.c           |  9 +++++++++
 target/openrisc/cpu.c       |  1 +
 target/ppc/cpu_init.c       |  7 +++++++
 target/riscv/tcg/tcg-cpu.c  | 26 ++++++++++++++++++++++++++
 target/rx/cpu.c             |  1 +
 target/s390x/cpu.c          |  9 +++++++++
 target/sh4/cpu.c            |  1 +
 target/sparc/cpu.c          | 13 +++++++++++++
 target/tricore/cpu.c        |  1 +
 target/xtensa/cpu.c         |  1 +
 22 files changed, 154 insertions(+)

-- 
2.43.0


