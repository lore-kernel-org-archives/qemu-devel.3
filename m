Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKkv-0002Vu-Kx; Fri, 29 Mar 2024 18:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkq-0002VN-42
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkn-0003UY-5f
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1df01161b39so20864175ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751475; x=1712356275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j7zaeXkIZWEmPyNLu5W9bXadTAjJptrRhq+TMb6bXGY=;
 b=a2ugDSX0J3OpLP7b38MGjoWs3IoW4TAcd1HLPKICQ64ZuVssrbtjVlzu8hcp6b30m6
 CafJTjSRVFxzdF5h3mMK/XovFSfcDE1/YaKLRL0SuimErQnRNm4DCHt77ZGRErplh1it
 fPUQzR7MnAH7GV0qIELRVmvWh80VA6tpfvZ3VLDDfc5nDHsciaSnKQLwft0SGGRIj5PP
 ZvAxVPW5s+dJamB9l+mrpKkE7Qx1LCSKAkQF9Uk3Dx2CkJexYIP6A4jkWj/90OosYbSz
 FVXRou9YAH+ivri1oSmREp5P+fBs4KCmiBfaH/yoQ3JbKfC5RnuKscimeMzXiJIcmIeL
 8nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751475; x=1712356275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7zaeXkIZWEmPyNLu5W9bXadTAjJptrRhq+TMb6bXGY=;
 b=wesADCDCaYVmDrhCj8nWGSka4kbG1/5UPT3bLlcw7wT5xL71eQmkRiiwE0lwJwpxXv
 hltGNkMg9GrIIs0l0K0soO79KrqnuwmCTYQlXg4DII2s7imgntvpQkFbgQdpKwDDR8rc
 4rQq3BK5FHyu1Ut16NK+5sz6LJM1xG2OiMFI/2+/F93hjAl8V+s+0u+4KpuG+p5f/RNo
 jfszNZ05kgg2xDkJGkgRa6WO0MaM+mj48gS0Y4egLnHrN+paWUCYvdsoQqEyADA2M/zW
 ya0Y8jrKEvqHaUJyspLPzYYrOQSdqQ2yckwa/YFNGy5P7LDT4RSA7OMhZ/NYdIiAiaWX
 v17Q==
X-Gm-Message-State: AOJu0Yy+mG6T1bZORKojrd6deHVIvsT4kiJVRYs2kSd8H59y5tbK5mGV
 Zqd48Br36riUmrWnJJRy1hxCNoNf45IJZtzcOqQQY04ipap0x1hWDz4YqPyqgQ7IjYJNRiS4rMw
 W
X-Google-Smtp-Source: AGHT+IFN/3JuTCnYBeknl54HD48IzZOAqyIS2AlyLV9wPkUvRZbH2nmiVr8uiCwvt6bEmKxUxSBkxw==
X-Received: by 2002:a17:902:fc8f:b0:1e0:a7ed:750c with SMTP id
 mf15-20020a170902fc8f00b001e0a7ed750cmr4212160plb.1.1711751475153; 
 Fri, 29 Mar 2024 15:31:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] target/hppa patch queue
Date: Fri, 29 Mar 2024 12:30:53 -1000
Message-Id: <20240329223111.1735826-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:

  Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-pa-20240329

for you to fetch changes up to 4a3aa11e1fb25c28c24a43fd2835c429b00a463d:

  target/hppa: Clear psw_n for BE on use_nullify_skip path (2024-03-29 08:15:01 -1000)

----------------------------------------------------------------
target/hppa: Fix BE,L set of sr0
target/hppa: Fix B,GATE for wide mode
target/hppa: Mark interval timer write as io
target/hppa: Fix EIRR, EIEM versus icount
target/hppa: Fix DCOR reconstruction of carry bits
target/hppa: Fix unit carry conditions
target/hppa: Fix overflow computation for shladd
target/hppa: Add diag instructions to set/restore shadow registers
target/hppa: Clear psw_n for BE on use_nullify_skip path

----------------------------------------------------------------
Helge Deller (1):
      target/hppa: Add diag instructions to set/restore shadow registers

Richard Henderson (14):
      target/hppa: Fix BE,L set of sr0
      target/hppa: Fix B,GATE for wide mode
      target/hppa: Mark interval timer write as io
      target/hppa: Tidy read of interval timer
      target/hppa: Fix EIRR, EIEM versus icount
      target/hppa: Fix DCOR reconstruction of carry bits
      target/hppa: Optimize UADDCM with no condition
      target/hppa: Fix unit carry conditions
      target/hppa: Squash d for pa1.x during decode
      target/hppa: Replace c with uv in do_cond
      target/hppa: Fix overflow computation for shladd
      target/hppa: Generate getshadowregs inline
      target/hppa: Move diag argument handling to decodetree
      target/hppa: Clear psw_n for BE on use_nullify_skip path

Sven Schnelle (3):
      target/hppa: Handle unit conditions for wide mode
      target/hppa: Fix ADD/SUB trap on overflow for narrow mode
      target/hppa: Use gva_offset_mask() everywhere

 target/hppa/cpu.h        |  10 +-
 target/hppa/helper.h     |   2 -
 target/hppa/insns.decode |  38 +++-
 target/hppa/int_helper.c |  14 +-
 target/hppa/sys_helper.c |   4 +-
 target/hppa/translate.c  | 488 +++++++++++++++++++++++++++++++----------------
 6 files changed, 364 insertions(+), 192 deletions(-)

