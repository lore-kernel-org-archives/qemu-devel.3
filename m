Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DF5C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1sF-0001US-PA; Thu, 06 Aug 2026 13:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sB-0001Te-3G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:15 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1s9-0000c6-DE
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:14 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso1860170a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037232; x=1786642032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WqajPQTG7itpX0uialCEvblZ720tl5DXhZwKWpR7UXE=;
 b=aSPkYcrZ0q4l/vuIe3gIbV4+VlYrmNfQC0EXyL07s75+yegKFxvOArczyRIqkrib0X
 MskB+CWLJQO1wycTbIEb3wrcZkv6eTDYqWOz5hMPquYyqKZG2HY1OQXzLxeUznCCaTeS
 YDYu795KY7FBRWe9bg1wy7kLMUOoG/3IKw7uQfGMuQ0vbzZX6TAu2izcbZb1hqNKEM38
 zczrUDtOzO/1vcShbN3TXgLCzyN48qEvAbJDZKz/4n7KBqXFdB2pIWhmtgwVKPTYe2q5
 Sb6UsdON899kghEheIgzMPJpQLsuH2ucdEiNvX5GxEvtH8RZZHrfHOFyyTv7c3NL+nS6
 BrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037232; x=1786642032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqajPQTG7itpX0uialCEvblZ720tl5DXhZwKWpR7UXE=;
 b=MzOkhb5MpiFHGHdm7Vum1U3/DeStsdEUsHZFfuuMRb7G6FLGu6KeE3M92GM0aD3nT0
 M4XKYkb7h6avlPoRvkGI0pFSrF1KlCdgMIi2PC/zungR6LFZdV9By53gYn/V5W4WTFD5
 B1luOiDkdrqwFhtstbzffW+vaI85g5fTO2zEIYxLnTh7MiXe9j8DF/HeaWeYJ2TcQdZa
 uoaWRsDeQJxLI8aiZ7f/igvXkCsNKXxRFaArQ4CpJoYRjj0NwmShxLLT2ae2rirY/uNc
 yrMyUd9FlJHUMeiTBiE4Pxe6esmm5McorvbDbDGUj3/D6Blw1JUD51xEmtTzOpAnn5Ny
 sUng==
X-Gm-Message-State: AOJu0YyuBl4i7oEdgnGDZ5ZZVRjl4IT7Gqe7FxVoZhXEKATqyD3jtlH0
 AgRaJaMIuvi20FBXaxzdBrgo2LmSpTLDdwuA0ryXTCSUbswMNzYptd2dAWXXhuQLqzPRRiyh+aJ
 bturd
X-Gm-Gg: AR+sD116DqHY2Op5m5AN0ouEQ5b67Adn/hdDdqIrPXaWq6kvDBQeJsOXKPGMbH6z1vu
 NzZnnsKjxi6+k5PMHVMx2WDP9KAYSUC2XvPNtPlBreM2TPXJlbtzUJz4el9GGSw8jOgfHpzW6G6
 8KK+LcQ2CX62QEz67mIV18iP0iK0HsOO5rCw9FZfd6DzUoBKjqrGlDWJu/9O5uyntQh7ec/J/Ns
 EJUA48CDSX89wLc47OReUKlEWLPLJkLjRSvOdlFxKyC809iUhcVQOZ+oiVTSYSR6QRetsK00NnJ
 k1gX7Sl8m8MFZdSSJAcEtUN0IXQVCkZ2y3oW2KTV9W4pv2szogIn2D9ObSR2pffvJDrk1HVe1yX
 t6X9elNZSjFEnmYDEorndW1CTGLnyaS0lcCzzEcLhhQkp865L0N7pi8KHHZNuy5trU7tcbQ2k6U
 guYpTr0Fd3DP9F3Ruaknvs5uQcQdfnSN2YN35R2mJ0KGpYq6byqhpf2IF4Vc9WxavJMnlD0J9PB
 3VsMkkM39f6GlETCKXn
X-Received: by 2002:a05:6a00:2406:b0:847:712d:19ac with SMTP id
 d2e1a72fcca58-84f2e0226demr17579056b3a.8.1786037231751; 
 Thu, 06 Aug 2026 10:27:11 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45389e68sm1803272b3a.4.2026.08.06.10.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:27:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/6] target/arm: Implement FEAT_FGWTE3
Date: Thu,  6 Aug 2026 10:27:03 -0700
Message-ID: <20260806172709.333300-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Based-on: 20260806163939.328201-1-richard.henderson@linaro.org
("[PATCH 0/7] target/arm: Introduce cpu types max-v8 and max-v9")

Changes for v2:
  - Rebase on the max-v9 split.
  - Review comment fixups.
  - Set fgt for MECID_RL_A_EL3.

r~

Richard Henderson (6):
  target/arm: Add FGWTE3_EL3
  target/arm: Add FGWTE3_EL3 bit definitions
  target/arm: Add FGWTE3 FGT bit definitions
  target/arm: Implement FGWTE3 traps
  target/arm: Set fgt in cpregs for FGWTE3
  target/arm: Enable FEAT_FGWTE3 for -cpu max

 target/arm/cpregs.h            | 56 +++++++++++++++++++++++++++
 target/arm/cpu-features.h      |  5 +++
 target/arm/cpu.h               |  2 +-
 target/arm/cpregs-gcs.c        |  5 ++-
 target/arm/helper.c            | 69 ++++++++++++++++++++++------------
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/op_helper.c     | 40 +++++++++++++-------
 target/arm/tcg/translate-a64.c | 16 +++++++-
 docs/system/arm/emulation.rst  |  1 +
 9 files changed, 155 insertions(+), 40 deletions(-)

-- 
2.43.0


