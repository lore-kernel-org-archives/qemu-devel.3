Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83516C27C43
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJ2-0000Y7-24; Tue, 28 May 2024 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByIz-0000X1-VK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:02 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByIx-0006ov-BU
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:01 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52965199234so1081600e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908396; x=1717513196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mTKuvHP1QSNGLlDZjOj7K/EbEPOmCMuDO5B33J0CCSg=;
 b=cNVaqva0huvawL8G6yI6cnGurgQglSqgYP6mIWvxwv1TSkyoIqtzX09JUhBSxaqdTh
 U6bwCl9zw2xnByCJJIByp95wOVx1FO0oriapocWNHFG+/1lb3Gz4t0174Cgh61EFEvGj
 Uj+XCwzO5RLM2M6BHBZHgIF6LtyaOyPxrgAFXn62IEsMFJL44AOVffyAGZYSsqUzjCFH
 azZXgklfxx6gpk4X3T7MPHb63D4jzo3+GKd3KeBfKM1MrT8xG6WWJNqsa5RHHcfwBV/D
 /oypzlxhL28VUJDWBzA15XQ+kAkF+1rMhDiKdqO/oR+03nZfa1TQVDztlIdPGibDXIlU
 TSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908396; x=1717513196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mTKuvHP1QSNGLlDZjOj7K/EbEPOmCMuDO5B33J0CCSg=;
 b=Qdw1LMxOmV2GfhacFPB57NEwIT3nZrq40SJzErpnVO1rnXVnuLaHxIweJO8Uwhwyxq
 Mf3zAt4dOD1M3xlDE47e+5i2ym8e0GDPYPBPbSOea+bidqz4Zx7olg5upcuRzX39+FbQ
 2aLZxzuMHYVZi1kQCrN5IywpL50y6z045emYDA/E9ne5OwdojtRq9t59li5kQkSM0cw+
 UMC653kkMp5zOCKoRSZLMo//+hE69iPSF4pZbIl+jmwSw9HO9qkGoeXBvOVwL66Oh4Wx
 mK+VdCwQFHKla8uhMRLNnsNiMZygVn6wU/wedw/u94m4SUdb5K5ILZBDNJA3gz8/xN0c
 ecpQ==
X-Gm-Message-State: AOJu0Yw9xFMqQfToazlbf3LpSMM1L9s+WQfSNKEddHxyMWioZyD0WXUU
 s3NbXJzZFDuBU1mgg4aMxfo/Lb6x9yvqAs1rXjD8J7BMSAqXY4VvDTapShNnyRYNGbhWpYg7a2X
 o
X-Google-Smtp-Source: AGHT+IF01p8a8gw+bDHhH0j3c6sqhu3FJ3KneeiSvPu0QMEp2sI2zaTwNsccJNzr8YAPgmbcCUK99Q==
X-Received: by 2002:a05:6512:1112:b0:529:b717:2a0e with SMTP id
 2adb3069b0e04-529b7172ce6mr2957608e87.18.1716908395810; 
 Tue, 28 May 2024 07:59:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579cd4c85c7sm3688721a12.20.2024.05.28.07.59.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 07:59:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] accel: Restrict TCG plugin (un)registration to TCG accel
Date: Tue, 28 May 2024 16:59:46 +0200
Message-ID: <20240528145953.65398-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

Hi,

TL;DR; this series remove TCG plugin code from generic accel code.

Since the introduction of the scoreboard in plugins, the INIT
hook use the vCPU index, which is only available somewhere
during the vCPU REALIZE() step (see below for call tree).

In order to clarify that, we split accel_cpu_common_[un]realize
as *unassigned and *assigned steps. This allow to remove the
plugin [un]registration code from common accel code.

Another approach suggested by rth is to add a PostRealize()
handler in DeviceClass. This was already experimented here:
https://lore.kernel.org/qemu-devel/20240209123226.32576-1-philmd@linaro.org/
Since it is a change harder to sell, I took this simplified
path which just make the vCPU REALIZE a bit more complex,
but not really an concern since the current call tree is
https://etherpad.opendev.org/p/QEMU_vCPU_life.

Philippe Mathieu-Daudé (6):
  system/runstate: Remove unused 'qemu/plugin.h' header
  accel/tcg: Move common declarations to 'internal-common.h'
  accel: Clarify accel_cpu_common_[un]realize() use unassigned vCPU
  accel: Introduce accel_cpu_common_[un]realize_assigned() handlers
  accel: Restrict TCG plugin (un)registration to TCG accel
  accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/

 accel/tcg/internal-common.h | 17 ++++++++++++++++
 accel/tcg/internal-target.h | 14 -------------
 include/qemu/accel.h        | 39 ++++++++++++++++++++++++++++++-------
 include/qemu/plugin.h       |  6 ------
 accel/accel-target.c        | 34 +++++++++++++++++++++++++++-----
 accel/tcg/cpu-exec-common.c | 20 +++++++++++++++++++
 accel/tcg/cpu-exec.c        |  4 ++--
 accel/tcg/tcg-all.c         |  8 +++++---
 cpu-target.c                | 10 ++++++++--
 hw/core/cpu-common.c        | 25 ------------------------
 plugins/core.c              |  8 +++++++-
 system/runstate.c           |  1 -
 12 files changed, 120 insertions(+), 66 deletions(-)

-- 
2.41.0


