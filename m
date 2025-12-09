Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770D2D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Zt-00064v-JO; Tue, 09 Dec 2025 11:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zp-00063J-5C
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zl-0001qK-Or
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so50341815e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765297711; x=1765902511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WYIwjNICeO5eYyjomc+i5c7B05XWP1P9S9NqjvOkAq4=;
 b=dhPhlt3RB2yj5xBNi/TZw8yRRWV9AhwILvLUHCek9zpEGGsw1ZlMyZvgmRnNiRNd9b
 Mfy6/TeFnOLCHMUF6AB6KrsdOReHZaixtPADERldVdizsc92/6AKcR7dEIIUq5xFuzfh
 8SRJ3s0QSEBYbgU6yNfdELFb/AFK6XwCHj7m3sr9QCZXD7S8cSbWBIO/dd2HXIlwp/rN
 aNuvsC+m4EHVX8XL9+6RBUmNKf8I04fapwyXoVEtYuUAX7YV3P53aC5BP4g7OdCMKOkr
 YkHNHUARMItYMDAzNL3xJIXJd1LamnSK0oXSriiQyV7syqWPDhn6TEmVGZSN+zSDyDOZ
 lQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297711; x=1765902511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYIwjNICeO5eYyjomc+i5c7B05XWP1P9S9NqjvOkAq4=;
 b=DV8Xl/3iFjBU2xjdus23YUfgaIyZTLzpQwbFuT2sZ+ZZRrsK+WP1yStkMmeDGaG0K5
 sBd9UJnBVv936E04BbZT3vIBLTH0xuGmQAw342ZI8Y92qqz5WjT9AweeC4HfShm4FKUu
 x86jhuBVpbA9ZSUdLl+pEUBTrKhrt/0kccR3lt0xmoC/xKGEnH9pUfTd9i4U+L5Ryeou
 VIbP1rXmfwjV1rNX7R0wfqcTyEWtI7vtXy+ZIDve5rzCdiA5msjcaU0MQ91jFtyJ9Lj8
 ngsMlLf5KNwRX4iD99a6sXvMSAg/255zejzEG7OYJCaBoJga+ZgMwBdHVS2+XVimcdGk
 C9/w==
X-Gm-Message-State: AOJu0Yxrg6eycVoikig1tc/MkDexCh+PkflazmdFpgidmhAPLckohkWT
 uOHMzCj1m2uN7zTidmRxHv1gi5BYdkHJ+VvEL4CrqHH/PkuBn7hXpsJOpVaNG1ArzGo/DMvsYyp
 oFuLB
X-Gm-Gg: ASbGncuUU5xIMMZ8klRiVdr6kQQaCrAqVkJ+EOHyWCG3wNwgcMvakubbTEg47JnCFcw
 fXwp5mX9b+pN3USX3cCsYHWI4LnOiQExViudzeTkMxISAlncIfkRDkeP0UBQIbjMTz3XIGlDERQ
 GNAnRkESzJu+wqmFRCjqIA3US8OBOKNgE4lUw8HshmX7AzkN/OEBVyalCuplkKpmVH/lyzN7+LE
 0tWj6rt94vm5xTmKwGVVMXNMGhAXwd+Cqx21hqXVnbo5SPyXAf8A6ck/9iHrjvuYMwBnqVFoFVC
 73afMfevGiENkO0iIqx6BUkkhN2Ci/TsbX7T8iqGZUiZuW00gxBl53zgAFve4R14FPdNJQHGrro
 OoWQM22Ab31844ay9HeUH6GDRlaCVHvf475/mkgolE/cL6b9+jq+cwFYatNmbh8uib5W98C/D3J
 GCjfZV5FQxUsA=
X-Google-Smtp-Source: AGHT+IG48OKRREAZiDOyV4+ArjoPI5EGkUlFmT/QSJKdeZrhbcsmLpHDMwNh6EGm30XgOut/3AvIPw==
X-Received: by 2002:a05:600c:530e:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47939e20181mr120224225e9.19.1765297711280; 
 Tue, 09 Dec 2025 08:28:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6fa0f6sm46904675e9.4.2025.12.09.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:28:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C87465F818;
 Tue, 09 Dec 2025 16:28:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 10.2 0/4] a few Arm HVF and TCG bug fixes
Date: Tue,  9 Dec 2025 16:28:25 +0000
Message-ID: <20251209162829.1328559-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

The following changes since commit 2257f52a97f28ce3be4366817ea8817ad866562b:

  Merge tag 'pull-10.2-final-fixes-051225-2' of https://gitlab.com/stsquad/qemu into staging (2025-12-05 12:38:37 -0600)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-more-final-fixes-091225-1

for you to fetch changes up to dd77ef99aa0280c467fe8442b4238122899ae6cf:

  target/arm: handle unaligned PC during tlb probe (2025-12-09 16:21:56 +0000)

----------------------------------------------------------------
a few Arm HVF and TCG bug fixes:

  - don't re-use TCG only PSCI code in HVF
  - fix deadlock in HVF when shutting down (#3228)
  - fix corruption of register state from PSCI (#3228)
  - properly prioritise PC alignment faults (#3233)

----------------------------------------------------------------
Alex Bennée (4):
      Revert "target/arm: Re-use arm_is_psci_call() in HVF"
      target/arm: ensure PSCI register updates are flushed
      target/arm: make HV_EXIT_REASON_CANCELED leave hvf_arch_vcpu_exec
      target/arm: handle unaligned PC during tlb probe

 target/arm/hvf/hvf.c        | 11 ++++++++---
 target/arm/tcg/tlb_helper.c | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.47.3


