Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAFBC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9V7G-0007Ro-O1; Wed, 23 Sep 2026 18:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7E-0007Qm-CS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:00 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7C-0005n2-SF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:00 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so829073a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790201217; x=1790806017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QkBAKee2nD0WSOYQ5toltyB4oGViiXvUZONSqN9WusM=;
 b=IZ8O7SZRYXbzKjWhUe3abnnW9f+Lxe4eHKTuKrkAsQ0Vvc5I6p+oLbWDnGzMDqY0la
 5Zaacmeo3DuTT3tliGUzxarUWm3DNjo6LyJ1eCDyXsjc/Mf/o7Brrhh7Tp94JRcGguQr
 uApQabHTlfWCJsLBjm2zOuf3GwUcOh/eQTlc6mJmuoKp1j+7uAL1jg5YtvwgONzA9irx
 hA7PcLECnweRFkb6EDF5ErA4cUHWTEJzzv0uyqdHgaUBmv1t5XrxrtaD2aSDfjrDWRQA
 n8YxoqLOzvCHEdGQdG2JBUMSWRpp7XggWMSVAmMrk5IBjtMUp8G0te8FK6WsbT9pU0yz
 XDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790201217; x=1790806017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QkBAKee2nD0WSOYQ5toltyB4oGViiXvUZONSqN9WusM=;
 b=ahcf0TNX1v1/V/GVWoO8zDwnhzKw0JagVoBAuqiQBLyNigMAzLtQ3/Nnl+W+br+sxl
 HwVm2yoqd3LDc4WU18s9rrmooR+g5VVhKRqVKq5+8nLbOGlUALoirP6Ocx53wx1HWAQb
 4FYzv7gIatkv+r+Hcl4CQeCAjbjn0GdTba7h8mtl7mdoKr1CEDx9a1WW4E4PS40S2rMG
 5dm2RU1Zy05nlmo1Fs9bafh7PTW/qUo3+m++En8WuupV8xk3WK6IvwVWLcCcyOqWhREH
 uV6ioxhGYRkUVZKiIp0NCI+gHj7jLji3eC47aAz4CDLFXSiJIFWMPujdsRjZsIIPCwQP
 jx2g==
X-Gm-Message-State: AFuF++knw0SK+8YlfN5CgrkTxiFdInwodTyDBmWWThg/ZeqaSj0VqutF
 Lytcv21FW49V4NbZLqvIYAyPqRg6lfrvlarwicPkKzYel5x/o49eM/Z+0vo/f0N7ufRP9Xp6v0u
 fmSjq
X-Gm-Gg: AYBFou0919u/EovApROMCH9lcFGNScAyidbmtm1H02uWvWLI+S4hVWUvqSNTZnn1jOS
 VXwi5e7gjY3ZH7Z9DB8B7LB/fRniv8BR+OO4egL/6Pcvrs0JA9yvSoJaCkxVqHT1pyqfd/eMfnZ
 +3Pm5E+TyVSKPDCCZeosYsBlpLhzxp2x70CX3SR/408zbU7MKovPBFI6mNZ/PEvKYcQZs8cyvzA
 IxlkPcfFi2yS/KEJ3aBOs/fOoWgNEAl6BRUViC8Ru+ilQxsGDqLtbJo8xk7NElJU42FexAtRAcI
 ZXafhTvW9dsDd9PaPDCPBJ8wGSUJe3lWg4DpXgX6e7k27C/h2PRGquSmSFAQb50dZoX0Fv/r7Cx
 2cuwrfZZzc5W3IgRLEnAS3Fjxryqb9FanyNDaqMCdD0TWecccQi1sVWh165+FuatY4TLne9omOc
 zQrCP66+8IYS+OnfVbGFVUZvGZqKChjq8K8XbAKOufLwowES/dlM04QUI9zg5JaUXa+823sJKP9
 3nA0iLnCXzNHDzNRMg+BUOSefsjPA==
X-Received: by 2002:a17:90b:5404:b0:3a0:8050:2ec9 with SMTP id
 98e67ed59e1d1-3a09875d75emr336964a91.16.1790201216496; 
 Wed, 23 Sep 2026 15:06:56 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976ca5f9sm998322a91.14.2026.09.23.15.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mpatocka@redhat.com
Subject: [PATCH v4 0/3] linux-user/sh4: fix race in atomic variables
Date: Wed, 23 Sep 2026 15:06:51 -0700
Message-ID: <20260923220654.127167-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix the race detailed in patch 2 in a more generic fashion.

Squash the silly loop that was part of the problem by suppressing
interrupts within cpu_exec_step_atomic.


r~


Richard Henderson (3):
  accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
  target/sh4: Replace TB_FLAG_GUSA_EXCLUSIVE with CF_STEP_ATOMIC
  target/sh4: Drop use_exit_tb

 include/exec/translation-block.h |  1 +
 target/sh4/cpu.h                 |  6 ++--
 accel/tcg/cpu-exec.c             |  4 ++-
 target/sh4/translate.c           | 48 +++++++++++++++-----------------
 4 files changed, 28 insertions(+), 31 deletions(-)

-- 
2.53.0


