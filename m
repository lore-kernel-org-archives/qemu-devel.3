Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56652C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZxl-0004ng-Nc; Wed, 23 Jul 2025 09:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZt5-0002nG-Ky
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZt3-0002oL-Eq
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso69540535e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753278719; x=1753883519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WzSVwRjlmLr6uY4Fxwa1RWwINPFTTiRXdeHymvaEdJs=;
 b=doVvQgxUA5EP5fW3U9XuygcdqOMdElXcXKPYHWrKSni46S2TW1qoolysg7vrBy8fv4
 qmEEWVH30jGpSjnysE0b17sOfgOo6aDuMDdSIe1UuXgLm2J7tnxcchGikq02nMGc6MP3
 05V9LyUhDL4/TkmK1x7JMsIMrroTj6Oc+A9sptBnK/LxAZnpdP//ZzD/K67206wrgOOM
 M75NroSrC3wMKy4FzPhxm7S4OD69345jEb8f863qtDHUqcDGGKxriyyz/jFk4Qefo2a6
 AHMK7LcqXX92x0cj6Yc280N2PEZnIO5wSw021hRCiceOOV0V6rCNMmkj2soUesyEsHSf
 tPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278719; x=1753883519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WzSVwRjlmLr6uY4Fxwa1RWwINPFTTiRXdeHymvaEdJs=;
 b=YQQ5q6kZB/mrRa40wQSf7E0OUHhxob5cCaZ/Wa7Gt1TfvVJ+OAH4vTKSsxPURe7zTp
 WLwysYOPDZzjW3cjcMrDie7tOMbWmxpKwYGut/dK9JmJ+cBUn6+BrxIVp6jKk5+6A4Fn
 suhV2w3xB0gJjrELkl9I3TmIcbvy9Fslw6ETlyszzz2tfPAE58DJYqDvFm3QgGzuf5l/
 qHP480DvvoORFUSuNZXLdV46IxhEslWudPTN9uPSTaOBTL/rWs1Ww8Wxv0boYmO5+/xJ
 yq0RmZCDdEUIhT4+XciAKxeXfLx83qmQ/c/Ydeikl1fBfFYVH5ARIxK7fdDykGQJtGt+
 cB+g==
X-Gm-Message-State: AOJu0YznRxs2Zp2UYiXS07NplGtJOkyJPzwqS65uo1CjJNsfAs7sQPal
 eoo0p433KywWC3/Latvv9XcbLEsq1gIGN0Jrl4er7Zd0cAiVf+DC6pv0M0zfl0bnC+q4hzVZEW7
 9RAda
X-Gm-Gg: ASbGnctAaa+LRnU1EEPHKWl34EBvbUTHa2GPXf7V4dpjIs4K3lwLxMu+kyNVEbKJzX3
 WdHuGLCMj5tGxeuPKOWV1im4B8B6xiIFNfzugp8Q3PqYWjO1JtB3UOxWj2w+vcI8vvZh9Xl1PN+
 /Ga9ip9PNJYiGZfpKnKdK901q4XiVnZV/URmUiBhr6tt3t6p9LTJTb32ZajhAxOPWTQwOteNWJ3
 qS29T+XGFglZ6jelMcBHCReybkudj/BcQcK3f/s/+GLOjpDcEMqbnZTGwq+52/lYY8/bGfz8Eoi
 HXloTHwwMrb52vmcxSb942DMEOIksyWoZ8nme78KuKrIhRw4BIWIlvYaUIgyRHqa5D2kM4KSykP
 gBNMqqOFvWBQw3D6mDV2WzPkRAOO5oOqYTvt6sPnSSSJGBRESl1SmSaYym1+uXbVqsPlFsr7QWZ
 qjVSuDKUw=
X-Google-Smtp-Source: AGHT+IEc93Ma6j0dB6V2FLi8g/Nh9GU0+I9wCbsnl2XWN0vm4qaw4eqC/NRvzL2FxnRDdEM9Mmq2Dw==
X-Received: by 2002:a05:600c:540e:b0:453:6b3a:6c06 with SMTP id
 5b1f17b1804b1-4586bddfd36mr17214885e9.29.1753278718833; 
 Wed, 23 Jul 2025 06:51:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca48a2esm16505085f8f.51.2025.07.23.06.51.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Jul 2025 06:51:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 0/4] target/arm/hvf: Correctly set Generic Timer
 frequency
Date: Wed, 23 Jul 2025 15:51:52 +0200
Message-ID: <20250723135156.85426-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

(Series fully reviewed)

When using HVF, the accelerator gets the host Generic Timer
frequency and update cpu->gt_cntfrq_hz; it is however too
late, as the timers have been created in arm_cpu_realizefn()
using the default frequency. Then guest virtualization code
depending on timers ends very slow (experienced on Silicon M1,
timer running at 24MHz but QEMU timer a 1GHz, ~70x slower).

This series fixes that by introducing a cpu_target_realize()
callback for accelerators, creating ARM timers *after* calling
this callback, and correctly setting the per-cpu timer freq
there.

Philippe Mathieu-Daudé (4):
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  target/arm: Create GTimers *after* features finalized / accel realized
  target/arm/hvf: Really set Generic Timer counter frequency

 include/accel/accel-cpu-ops.h |  1 +
 include/system/hvf_int.h      |  2 ++
 accel/accel-common.c          |  5 +++
 accel/hvf/hvf-accel-ops.c     |  2 ++
 target/arm/cpu.c              | 65 ++++++++++++++++++-----------------
 target/arm/hvf/hvf.c          | 20 ++++++++++-
 target/i386/hvf/hvf.c         |  5 +++
 7 files changed, 67 insertions(+), 33 deletions(-)

-- 
2.49.0


