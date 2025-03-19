Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD438C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuz8M-0004Ue-TQ; Wed, 19 Mar 2025 15:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuz8L-0004UK-Ir
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:31:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuz8F-0005OV-LX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:31:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so859305f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742412674; x=1743017474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S/wfhBIu9lXn5l5lkjHux+TggfIePCVAh+mYui/7+3Q=;
 b=vCUH6sJwGzqP51+X/rHyBnAGi01mKAm2Ja5u9dmiGIWJU1FwvgPGBHIEUkiw52r1OT
 BfOnhV2VZUUVc+5rui/p5XCyNZ5WyisF8rjROHARJJmvfN9TvDgZB407VMqNdm/gNwTZ
 SEltCZMPPXfsmMQCinUDZOd3DkO8dr3EAmLz616zyNdKKXVCTwhFVqO2nnN5ddbtPq0X
 6wnzR+l4HqMcH+QsuHlghsNZKblPxGJsg8z8Bqh6/x7EIiJFdiVlgwBvLOCkspOEUsIU
 9LWdM5TnFUtu8EbvXF73sH3Z+NyvmrsM8yNPCRkrXzylgYMpC02s2lsYiW9gidY7DtcU
 Xamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412674; x=1743017474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/wfhBIu9lXn5l5lkjHux+TggfIePCVAh+mYui/7+3Q=;
 b=UO12t1cCI5Bm2wtqoTUszkGiepj8UU6a/iKGjZ+ejqndRsalvk0JPomZRbpRt2rXG1
 dre3EOzprlksdcbVM1WBbc/Ga7YJZn+Jkur6Fd086d5y38UGAUzrtJLMWjHyguATH2EU
 pe1onXzxRzK6oxaaNJWmBmLttQyv26QawmHR5WH/1Hfr8Ren1Kw8JRRGXN3SVit7S3nK
 eIVkHXqh7LRz1xyDRCKhqpFF4EToJMeAT03YEAcW8HCLJk0ztNzTuwfEbRkoxdcfGU/l
 MmbwRPhA148pWBIEBO+KwPxdVq5q/GzJ3OQn8gjNLxySCj/tPwZWPNbwvCV2+lzXU0Gp
 oEow==
X-Gm-Message-State: AOJu0Yz28gtirgrXldfaJNdFsbVBMHIvGDsvk25RtV49NDTVVrgTsswW
 SQpdKCRSsY3XoKRhU9n3aJcqfBTWeF9HmK5k60vIl6vpdLggmCOt94qhcSomIEjiix2L/akDXmZ
 p
X-Gm-Gg: ASbGnctENIu0td7b4UqL3xWUCnzTCioULix5udpUpQGgZvzja2oDhXw5vItLwuiSJwe
 sqCUC36jnGYpTtWmoWoBJBbzXVW6nJxVhjGMKzSMj5nngLpcMs3kl6rWeCJ3TMkTZhKryhi6kXB
 xb1lpllheE4YEZxP32taF7Zl5w76rqyR+N6U3zeI/S5paMwch9ZoT29jwvFgJwAn1A7WdEXfFw6
 JFaue2bmbmw1t5nI/KM0DU7vLfsGGOmdVAb1l/bfo4HnG3lbCZIIdErAx+zwPndZzDAoM0EFBhR
 C76ld2nvBbCMuDqeZ493PhPAKIcLnqkjJlD6Lq/2sjE/Qe1+3PY=
X-Google-Smtp-Source: AGHT+IG25yxS/Ktv+VOl9w0rYr45RYr9A4ZX2d6JO+jSFn0sEy3dVs5EyaRoWqjKC/rb30R2vkYBVA==
X-Received: by 2002:a5d:47a8:0:b0:391:43ff:8ca8 with SMTP id
 ffacd0b85a97d-399739c8e78mr3356984f8f.26.1742412673716; 
 Wed, 19 Mar 2025 12:31:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47196sm26790495e9.16.2025.03.19.12.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:31:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 0/2] rust: Kconfig: factor out Rust vs C impl choice
Date: Wed, 19 Mar 2025 19:31:08 +0000
Message-ID: <20250319193110.1565578-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

This patchset fixes a compilation failure if CONFIG_VMAPPLE is
enabled in a Rust build, which happens because hw/vmapple/Kconfig
didn't have the "pick the Rust PL011 if Rust is enabled" logic in it.
Rather than just adding that to yet another PL011-using board
model, this patchset refactors how we handle devices which have
both a Rust and C implementation in Kconfig:
 * CONFIG_PL011 is "do we have/want a PL011 of some kind"
 * CONFIG_PL011_C is the C impl
 * CONFIG_X_PL011_RUST is the rust impl
 * selecting CONFIG_PL011 pulls in one impl or the other
   depending on whether the build has Rust enabled or not

For the PL011, this lets us drop a lot of duplicate logic
in Kconfig files for boards; for HPET this simplifies
places in code that have ifdefs for "do we have an HPET?".

NB: I think this should be OK but haven't been able to do
complete testing because currently in head-of-git
"make check-functional" doesn't pass for arm with Rust
enabled due to a different issue.

thanks
-- PMM

Peter Maydell (2):
  rust: Kconfig: Factor out whether PL011 is Rust or C
  rust: Kconfig: Factor out whether HPET is Rust or C

 configs/devices/i386-softmmu/default.mak |  1 -
 hw/i386/fw_cfg.c                         |  2 +-
 hw/i386/pc.c                             |  2 +-
 hw/arm/Kconfig                           | 30 ++++++++----------------
 hw/char/Kconfig                          |  6 +++++
 hw/char/meson.build                      |  2 +-
 hw/timer/Kconfig                         |  8 ++++++-
 hw/timer/meson.build                     |  2 +-
 rust/hw/timer/Kconfig                    |  1 -
 tests/qtest/meson.build                  |  3 +--
 10 files changed, 28 insertions(+), 29 deletions(-)

-- 
2.43.0


