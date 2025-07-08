Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B276BC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDs-000510-9m; Tue, 08 Jul 2025 16:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDqf-0006z3-23
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:32 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDqV-00085t-0l
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:18 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6facf4d8ea8so39734166d6.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002351; x=1752607151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Iog2nVQpBw7PFq7mrKKwTZuIXqsUwu2tqK359EKUuhE=;
 b=qtbzeG9kVRQxwuJZDRjCX++aCsiCdhTF2H+h4R1mhAhNUTAyANfJ5K12PSjxE5FXA1
 q8dwt2SJufhZkC/zqf1HfF/sbjRcJWKVXICGO2CT4E8r3/776ikRKhPmOD78rLfL6mYt
 k3GTaG66cPMUVvQEbfTx4Y24o4OmwGXYdAtaG9fmsaQaqS6Ez+ubIUcH4Q+KGp042NAP
 76QK9q72vQInemWKS+HnK9ZagSI9RQblGrFDqLj+rpK9Aerh2qKbSItVpLTdP5c2/J0Y
 fEy9XGYcUpSy98ucW/ViDsq9mKbkDdIsWnn+5Mfcqc8C7RwAKO+NkUkk59nCtgZfRYwg
 X6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002351; x=1752607151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iog2nVQpBw7PFq7mrKKwTZuIXqsUwu2tqK359EKUuhE=;
 b=a5V6vm3Fve9x0Z6twXrq6C9QM0Ubm6D9zS43x4DFbomkffM/MO5m9V1nmdGF/ef3Fh
 tmClE5qFvlGj3/9AN14VqWWYIFuq+5vTq/SyxgPERCpB9SAmcKfELl96HwDSJkzip/hW
 bbywVJx4G2NnFQ1ggMLtzaVuqHuH17YakQ5iYI0MzNoWIsIlbPHkyD270Jp0zNByRwZw
 AP2dLCsv3wW09p2/GG97j0SmqWJNFLXu+CYOw/TF6Yz8QnzeATFpMyUixYB8UhY7tIrQ
 FS0+vtlPI3LNrg9ckmaZp9vwYOuWEvIwFv04bkY/AY0YXaDHrjpQEkWKQhpruccerr6U
 QVVw==
X-Gm-Message-State: AOJu0YxveOqvbdpJgtCnYC/tgDqivDnsz8dUelrcx8OBb+ShfAWbkx0a
 g9sd56j3/begWTjFUrpTMNY2P2U4ftAhhc5uGPhJ+kKCTJlJ0KE5abL1Z3A8BAndHBk=
X-Gm-Gg: ASbGncsq7J+UZwiqFtuLyBxo8AQ74yBAVZp9wj+1PMgzeauirh6b6UM+JCnQOm52N+M
 DDPMTyVbIDQZjyBIOaindJ1K62tAXxermMWkA6Sa0Vy1iglPN6JbHsMMm7n8cFZj1BNINnJg3ya
 0Bmw30H34dr52tWPiajgpOIxWATXAh2z74WYzbPS8w+BrudI3iH4tRqr3rXuTkTiuaBKyqAhzjs
 RhA7L1Gb/m/VSc2kDp0ssT7PoWt7Xc8ujET83J3ZkCjqRfHJDQuudRx32ydSaTnhZw/y4KLSJXz
 1TrQYkDaNFmOMu9FucnDDtGhHkLrbhrroo2CDtAxfBYldGkSXWQUQlc6py1Dh7jW4kg=
X-Google-Smtp-Source: AGHT+IHxpoD0LXr571Bfzf1m0/g2v7YaYXcdnr48tz/6VTLQcTkF6K3IaDGn4TrvMd1516NrrzpJqQ==
X-Received: by 2002:a05:6214:4009:b0:702:b28b:d4c2 with SMTP id
 6a1803df08f44-7047d970358mr65298616d6.17.1752002351291; 
 Tue, 08 Jul 2025 12:19:11 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702d638846asm56289096d6.22.2025.07.08.12.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 12:19:10 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [RFC PATCH-for-10.1 v3 0/5] target/arm: Add FEAT_MEC to max cpu
Date: Tue,  8 Jul 2025 19:16:59 +0000
Message-Id: <20250708191704.1068604-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf36.google.com
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

This series adds support for all FEAT_MEC registers to the arm64 max CPU.

It includes the FEAT_MEC registers but does not modify the translation regimes
to support the MECIDs. It also does not implement the two cache management yet.

I'm currently exploring possibilities to support FEAT_MEC encryption (or
obfuscation, for testing purposes) in QEMU for the various translation regimes
used on arm64.


Cheers,
Gustavo

Gustavo Romero (5):
  target/arm: Add the MECEn SCR_EL3 bit
  target/arm: Add FEAT_MEC registers
  target/arm: Add FEAT_SCTLR2
  target/arm: Add FEAT_TCR2
  target/arm: Advertise FEAT_MEC in cpu max

 docs/system/arm/emulation.rst |   3 +
 target/arm/cpu-features.h     |  15 +++
 target/arm/cpu.h              |  29 +++++
 target/arm/helper.c           | 208 ++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |  20 ++++
 target/arm/tcg/cpu64.c        |   3 +
 6 files changed, 278 insertions(+)

-- 
2.34.1


