Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D719CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojhF-00042d-Aa; Wed, 20 Aug 2025 10:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojh0-000425-Fp
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojgf-0006t3-Cr
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1149so4710258f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755699671; x=1756304471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bJyjq5AN4uZdrL2V3ky7FnPfnceDnCaVXQL/pvAZwcQ=;
 b=VhO3Kz1KXf0CAD+eM2yPqNFxkaDMUYgQFzoYXSi99QMplqPe8dXuquhGbBXqptIG7Y
 0yF9zuC1wfOmX9ZDAoqIT/kmWuFS3z14xlUGemOXqqNR17KrhwxK9Glyh6yrd3ZP4IA+
 Q1QonUBuRQ/0MiEc5E+3m0wlqLRq8C3/iY4fGxbLbCke2VSUpyo+Ik9zib1umvOfL8w+
 HaPL3sCLuZ0zmqeosCQx/fmhmgZ+nCRohmo/z44cFn6rH/0EjeSB3p8/XEKhcz1CbP+j
 FXqGS8CyxcaYxcDjUdHvSgTM3IWtI6Fu6aUmaGXytgzJHXX7IdykG4fQAzy6V/IdFkfA
 ASzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755699671; x=1756304471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJyjq5AN4uZdrL2V3ky7FnPfnceDnCaVXQL/pvAZwcQ=;
 b=h73Bg/WxztwY+DKwJhq7cHTdLAKaY0lxSdwiqUixXS+t6nAczbQML/AsqR/zqsHVsa
 nyEATyaDeHUcpnThXu9G4bVAxYZ+aGC300TkNWuT/An2X6WDfVstOSPKTkLJLNsrWnTd
 PnQOXRK+Z1Pm8rUPrkHYPMXJn9DWiopw0+dHi8ew5EFmKBEqdb89i9WcOvKpeMCQqkG0
 +rPmn/rAB1GMixNRkXEAiNBpdq7XX7LXoxCo0M/xeoUwyZu8fTOSZLROZdi+JGIaFRZz
 opSLq1FjyghZWXJqqGPA0EswEDuUPdsHJgdguXuh/dSqokBid33Kv07AKnR3PfcXCWJ3
 Ejhg==
X-Gm-Message-State: AOJu0YybOhoi5XiCK89DzjYa+H8edsNWBM1uHlfoeewB9tjo2WUoMPH1
 1OFT/ZS3JDzM4RHHNhSsEumU7Z7J+Dq8lY9ahokI9k8nfmRnuUWgjAnn3JCyeeQtP/8elaQ3o5E
 W7Hcv
X-Gm-Gg: ASbGncu6osTDZZunLQz9F6UFmGeMgk3VUdDUUNJdezUhLM0EvqZ0lbr29Hogw7d8TB8
 mR7+WjeE6VztwSyL3wo0rbRuVSnzqGXoE+dtEX8W2mldpuDMtK5SK9nsnmqSvoBgMCuLOXJwqVk
 RBCTRR3HQgqredyzMmINqJzgyf6E0I88xbrdtR4m4ZRk+AF9Ggfp4VcY3YpYm+npoUZCs7mO07p
 quRnubGxz9ueB/dIVvBgOo8KZCQuZwOyO7ROoj5yKjfs3MfYpEuvtpTfdV6vNB2FYmWTfyQkWj7
 vD2cygwtRfWC2rRDpwezUYKTLZ+OGEtbGJaxjrmvStfPQCLoHanRAGaJAE9DQ+02ViRQa30fBog
 5XDiXvSIomntUx+UbVaz550QbVdlu2XLRUQQuM82oBG1CvcSi/hiytH5g6xT3viVE/UcBP99yhR
 xoLA==
X-Google-Smtp-Source: AGHT+IHdS3ACqDuzHXnBgJIfgwPCulYYB0xm51YJRNGezyq6jOLd7dga0MjDiBcv2N4PcLIiXWq27w==
X-Received: by 2002:a05:6000:438a:b0:3b9:1dac:70e with SMTP id
 ffacd0b85a97d-3c32eccdbcdmr2116905f8f.55.1755699670588; 
 Wed, 20 Aug 2025 07:21:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47bb2431sm35298625e9.0.2025.08.20.07.21.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Aug 2025 07:21:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/5] tcg/mips: Remove support for 32-bit hosts
Date: Wed, 20 Aug 2025 16:21:03 +0200
Message-ID: <20250820142108.46639-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

32-bit hosts are deprecated since v10.0. 2 releases later (as
of v10.2) we can remove such code. Start with MIPS TCG backend.
Remove related buildsys and testing.

Based-on: <20250820134937.45077-1-philmd@linaro.org>

Philippe Mathieu-Daudé (5):
  docker: Remove 32-bit MIPS toolchain from debian-all-test image
  gitlab: Stop cross-testing for 32-bit MIPS hosts
  docker: Stop building 32-bit MIPS images
  tcg/mips: Check O32/N32/64 ABI definitions actually exist
  tcg/mips: Remove support for 32-bit hosts

 configure                                     |   2 -
 tcg/mips/tcg-target-has.h                     |   2 -
 tcg/mips/tcg-target-reg-bits.h                |   5 +-
 tcg/mips/tcg-target.c.inc                     | 282 +++---------------
 .gitlab-ci.d/container-cross.yml              |   6 -
 .gitlab-ci.d/crossbuilds.yml                  |  14 -
 common-user/host/mips/safe-syscall.inc.S      |   4 +-
 tests/docker/Makefile.include                 |   2 +-
 .../dockerfiles/debian-all-test-cross.docker  |   4 -
 .../dockerfiles/debian-mipsel-cross.docker    | 180 -----------
 tests/lcitool/refresh                         |   5 -
 11 files changed, 42 insertions(+), 464 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

-- 
2.51.0


