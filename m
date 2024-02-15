Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D4C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWu6-0007XZ-TG; Thu, 15 Feb 2024 03:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtT-000713-Ad
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:14:56 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtR-0001Mz-HG
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:14:55 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso553440a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984892; x=1708589692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=51w7WqLtSA4pKO1dAYkg1D5uAKjDUngSsDP3jJjdJ5o=;
 b=XIbleCR3LjMIcntmpa97OekoB/hwiQYBFQRcaC57PrlVxacza0Y0eAAUPLyakZIaO7
 QhDGlsr9X608zvzOPzmqhIgileVMhPlMY0Dv2rdVTExpgIRUuaPWWBRCAsy7ec4JAvf4
 xM7ET8CIe+Zhq3EbZPtU66KBQkyCMcC92YoxXgP/4fzVoC7TnDcle56JaIjjntJEo+Gd
 o/S6BZgOcIKnGTG6JlyPWedcfmfvZwlXr7BU7itEzxwNhYywH5ymiUzBCair8LqXdpO4
 7W2BbF9Bc1jMqaNx/9PZ4RzCzxKAI/PR/uwAUw8QFJm9wnK57gmRM56x4I2YmUmMocsx
 nwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984892; x=1708589692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=51w7WqLtSA4pKO1dAYkg1D5uAKjDUngSsDP3jJjdJ5o=;
 b=IgrIR9UVspI4V/xr5YDS6GL5Or+Z6p+4WhmT3MVW97dIw0HkoJkdPIXK03gIc7f0v/
 FMG4GO8AYp7ikUF2RGNxj5tGzpOxVFC640lwuET8sxc4fbdMbKjQRyyaJu3pyWjheVre
 P5vz8teP2sYzC5Tz38omTixH/W3DqY5zovbBtdkc5dTa+ZItetmon3SsDYCnvhq7hk59
 Zn5nyXMP4idPNzB1hwEZzsBfqFpHhOkKrIs419881gblDc+8RCgV3eErRt6syjuUav/f
 zGdh80sI6nk8Ra9Ao37sE2sla1IfywrUVnQ/t8eaicmt3gLk444loZaJWKxI+SDW7fJp
 aQPQ==
X-Gm-Message-State: AOJu0Yy+3++XkNp98Uf5pWXjIIXMMsfAgZkiUrWkmOi9vgnC6dtbYE1T
 vHVLbXtfY5I+lTkNuMvMjqE8lLaabAjrfCfXHV9FrFRRN6hOi8lvTgRK/kvGVp2/obJTlijJyDf
 C
X-Google-Smtp-Source: AGHT+IEzSMGfPj1KIPDpERUNWll8HLCDwRjmLz6tfFtuza1zhAjx+5Wu3czqrqIPBAjJoRnCWBagnA==
X-Received: by 2002:a05:6a21:3a44:b0:19e:3b15:2176 with SMTP id
 zu4-20020a056a213a4400b0019e3b152176mr1572430pzb.38.1707984891857; 
 Thu, 15 Feb 2024 00:14:51 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:14:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 00/10] Optimize buffer_is_zero
Date: Wed, 14 Feb 2024 22:14:39 -1000
Message-Id: <20240215081449.848220-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/

Changes for v4:
  - Keep separate >= 256 entry point, but only keep constant length
    check inline.  This allows the indirect function call to be hidden
    and optimized away when the pointer is constant.
  - Split out a >= 256 integer routine.
  - Simplify acceleration selection for testing.
  - Add function pointer typedef.
  - Implement new aarch64 accelerations.


r~


Alexander Monakov (5):
  util/bufferiszero: Remove SSE4.1 variant
  util/bufferiszero: Remove AVX512 variant
  util/bufferiszero: Reorganize for early test for acceleration
  util/bufferiszero: Remove useless prefetches
  util/bufferiszero: Optimize SSE2 and AVX2 variants

Richard Henderson (5):
  util/bufferiszero: Improve scalar variant
  util/bufferiszero: Introduce biz_accel_fn typedef
  util/bufferiszero: Simplify test_buffer_is_zero_next_accel
  util/bufferiszero: Add simd acceleration for aarch64
  util/bufferiszero: Add sve acceleration for aarch64

 host/include/aarch64/host/cpuinfo.h |   1 +
 include/qemu/cutils.h               |  15 +-
 util/bufferiszero.c                 | 500 ++++++++++++++++------------
 util/cpuinfo-aarch64.c              |   1 +
 meson.build                         |  13 +
 5 files changed, 323 insertions(+), 207 deletions(-)

-- 
2.34.1


