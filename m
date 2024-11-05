Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C988D2C11E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L6N-0000rY-EC; Tue, 05 Nov 2024 10:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L65-0000qK-JY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:04:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L63-0000s0-9I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:03:57 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431688d5127so44173625e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730819033; x=1731423833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fr8JSjUR0Ji31zxPhKxMjPDmK3OctYTUrg0Kr6+wxVU=;
 b=wI3v+xD29ZKux3JzCrw6YpFDzkLwrc74b5SBiloMIpnCJX7CQtP2zyghYprw1iBUSS
 FxqFvOu2YrPeLCHzTVvOSM+te+El2pAJRG8BB7jNBzl/+wIVRm9oKCc7ilDmuApPDWoZ
 ywHeEGc5/7BTu8kbxSKAmgZ6ImnIqY1NMDn6hUKbZ8eZHvIB0HjAZptsZH2pWOjsJIgr
 W3DKIewiIrQw4tWz4HF/BvWLNDGAzjPxydfMX1dUl0u9I+SgjV1FHarpUoDLlWaSEpwN
 7vc0DJY6Zg4sGD4g8+a824rjgMOph43wr2RMbKize42bcX6IAY5hO0kFieS8YZWV70mQ
 PtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819033; x=1731423833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fr8JSjUR0Ji31zxPhKxMjPDmK3OctYTUrg0Kr6+wxVU=;
 b=rFJ/HWrJqXsSVYsXhhjVlgDWfnauYfujkHUXoWm8cwJaViF/OAJOusYcwn+dytXOZw
 iNACGKY1dVZVf4Pu2dbVAUSQca6UOTL7FrChWHgg4SIEf52LUJRPxgJat5A9I8/nefJP
 LBhKPWvO41u2AU40Q0JAW7vNXlPBgY8aSbytNBX+nS1kq1+powN+54yWqtKCaS3zq/50
 PZd0tJBcnUKwEdCkmn1cT0nRvTv90GUk9SErLb3RQ33kYwswO4Hs7Bk1rOSwGHOVpJ0J
 1bTIZQelxSG/IbqXn2cdVWY1KZyIQ4oZrWGm932CvR/3URMfnQv9BFpu9O5qV+Wve5n7
 ubuQ==
X-Gm-Message-State: AOJu0Yy7e33iA/fbDiwJEoC2Fu0C60RvFQBvLbR4+vF++gHL3Ljb+QdC
 KlZD7g8g92I+BM15/XkLJDU0Q6D5kEEgTDkpeGbGGHmNNuvySKX1PrEpR9UXeUmpQ3dg7W5gj81
 l6k4=
X-Google-Smtp-Source: AGHT+IE8eGnseX6XGUVaDrYpWM7HyfuNeUeFAqPWzACtXWae0eDiSd0c9S4c90IPUb/OXU1f4Dz3iw==
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr338947385e9.25.1730819030801; 
 Tue, 05 Nov 2024 07:03:50 -0800 (PST)
Received: from stoup.. ([154.14.63.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca6f8sm221301855e9.39.2024.11.05.07.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:03:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] linux-user patch queue
Date: Tue,  5 Nov 2024 15:03:44 +0000
Message-ID: <20241105150348.446982-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit 11b8920ed2093848f79f93d106afe8a69a61a523:

  Merge tag 'pull-request-2024-11-04' of https://gitlab.com/thuth/qemu into staging (2024-11-04 17:37:59 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20241105

for you to fetch changes up to 6f58b090328f5b47ee688c77542bf20d521239a2:

  tests/tcg: Add SIGRTMIN/SIGRTMAX test (2024-11-05 10:36:08 +0000)

----------------------------------------------------------------
tests/tcg: Replace -mpower8-vector with -mcpu=power8
linux-user: Fix GDB complaining about system-supplied DSO string table index
linux-user: Allow custom rt signal mappings

----------------------------------------------------------------
Ilya Leoshkevich (4):
      tests/tcg: Replace -mpower8-vector with -mcpu=power8
      linux-user: Fix GDB complaining about system-supplied DSO string table index
      linux-user: Allow custom rt signal mappings
      tests/tcg: Add SIGRTMIN/SIGRTMAX test

 linux-user/signal-common.h                    |   2 +-
 linux-user/gen-vdso.c                         |  40 +++++-----
 linux-user/main.c                             |  12 ++-
 linux-user/signal.c                           | 108 +++++++++++++++++++++-----
 tests/tcg/multiarch/linux/linux-sigrtminmax.c |  74 ++++++++++++++++++
 linux-user/gen-vdso-elfn.c.inc                |  98 +++++++++++++++--------
 meson.build                                   |   3 +-
 meson_options.txt                             |   2 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/tcg/Makefile.target                     |   4 +-
 tests/tcg/ppc64/Makefile.target               |  10 +--
 11 files changed, 274 insertions(+), 81 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-sigrtminmax.c

