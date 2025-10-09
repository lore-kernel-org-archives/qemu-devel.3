Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F9ACCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wgV-0007Ru-SN; Thu, 09 Oct 2025 15:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgT-0007RX-Ur
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgR-0004Ud-Eu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso10752035e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039532; x=1760644332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5wg90+1U8KYzadRoxkVAXZXW43I6y/3XukHm9OSjp8=;
 b=Q2gsKYBlsOfaG3SP77dy97bam0u/Q+fjcykyvRUiovOm8/BHSUxv/YIi5oB8DUFcmx
 BccHQKSZFYADA6JiPB3Xi76gjlZEHi40cReeS20G3ARZGXEfBXW232iJRiTIiz+KS4dB
 nu/sE562GV/E2hfelkZZgbq8HyG4PQ+YlxBWTr9dp3gCOqMN2jU/0BDwXRcAs9H5qvUG
 e1Pzj3mfrrNnbWRmpx2vKv5L+O9tRnYF7pxlA5EW+wN4yBFEzNNxgPjSv8F7ZnSA83R5
 M3evA7JTOmTKmxv4CLPUPSBvWZVvP4CGAR2wMaI9NJ4Y3RDg3W/OiFAI0vnwn9k526Os
 yzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039532; x=1760644332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5wg90+1U8KYzadRoxkVAXZXW43I6y/3XukHm9OSjp8=;
 b=XyEtJzjNun05NDYgFYBLaoxnRxuxxPFnAkzhSthUTKnkTrkhQAcMUxvMhZi+SEQE7/
 V3m557Oh8tAxJQOxywoNYavrQ8EoERuW7VYoeaxJXa6mnEvY8nEsRfcE10H7dPvpU0vm
 lFRlORaVluWPQq8uCU4ta3+OZHGDfTJYJHL83Bh9FrzvGO0AVhrgGvfoc9XQGNnq6AsP
 nmHizGASSUc/3ymZ2yL4yG2V4a+7XE8JprxkayGL54SWZpnUMocgi7Av/AttoBE33ixD
 odIe9EJLlza4McHhB/vL8e/HZ+TBS3kJp9DO4gIvqGPpvkIsW6mWYL+//TXQEYHz4mn+
 q/ZA==
X-Gm-Message-State: AOJu0Yw5YaIDPeILlIfRgRZ1AFMstuHMq7dDzwptS1FBb2geaE2OIst8
 goIgHMF+DFnL+Be14J+fofO9Vb7rTKHcjFvgJWtuseupffp+3I87evWHEZVkj4qHmTWo2QxfGFD
 WxL//zC/Now==
X-Gm-Gg: ASbGncvwGeVNtstSe8r30JEdotVL5/Y3XP3lCAIGj6bHQlEe7lNnUptY9sAG4MLZT2Q
 KvNr3yUDIb3JaRNM7U3fM8uTO98OSFWoM60tj3HarYvI+2ApN0aaW+2PFgNWSwf/71ezENBITYz
 RezsxopRi5bo9OfH4/OU1ifxogaeODxtylJS3/IMoJEwEbkSaIfHJBfONfJq+85atBZhosZ9e3G
 HeFaFqU9Rmgib0VrkzkEjJCQH21tfJDDwUb7cAT79xNRG5o8TKO+U+nNikn/S4grCEDr8dLykmZ
 zPxmDPpv0U6LeEFlG7+A3U9hdGpMapdk80ci6YG1sillagvV6V2bpVFoRtcvpGgnZcuK7RI/0PB
 fhwkKe7qLq4NS6DYmSpWFB9Asq2ZRXa8V2eTcABQO30Q4gUVlGcanH9LbeHlm2bV0JiujP9EHef
 3tjKHJMaHGo7rWgkUU/H0stFU+
X-Google-Smtp-Source: AGHT+IHsUKuF1q1BLjaT0ksgjeR/YwRRa9k7egrv+5bSEKG8zWjHD7ExWY+ZSCRQlpQZhEuPvsBxmQ==
X-Received: by 2002:a05:600c:5247:b0:46f:b340:75e7 with SMTP id
 5b1f17b1804b1-46fb34075efmr21416385e9.8.1760039532587; 
 Thu, 09 Oct 2025 12:52:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489ad27sm11936715e9.15.2025.10.09.12.52.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 0/7] tcg/mips: Remove support for 32-bit hosts
Date: Thu,  9 Oct 2025 21:52:03 +0200
Message-ID: <20251009195210.33161-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since v1:
- Removed N32/O32 ABIs (rth)
- Do not remove tgen_qemu_ld2/st2

32-bit hosts are deprecated since v10.0. 2 releases later (as
of v10.2) we can remove such code. Start with MIPS TCG backend.
Remove related buildsys and testing.

Philippe Mathieu-Daudé (7):
  docker: Remove 32-bit MIPS toolchain from debian-all-test image
  gitlab: Stop cross-testing for 32-bit MIPS hosts
  docker: Stop building 32-bit MIPS images
  tcg/mips: Remove support for O32 and N32 ABIs
  tcg/mips: Remove support for 32-bit hosts
  kvm/mips: Remove support for 32-bit hosts
  buildsys: Remove support for 32-bit MIPS hosts

 docs/about/deprecated.rst                     |  13 +-
 docs/about/removed-features.rst               |   6 +
 configure                                     |   9 -
 meson.build                                   |   2 -
 tcg/mips/tcg-target-has.h                     |   2 -
 tcg/mips/tcg-target-reg-bits.h                |   9 +-
 tcg/mips/tcg-target.c.inc                     | 292 +++---------------
 .gitlab-ci.d/container-cross.yml              |   6 -
 .gitlab-ci.d/crossbuilds.yml                  |  14 -
 common-user/host/mips/safe-syscall.inc.S      |  35 ---
 tests/docker/Makefile.include                 |   2 +-
 .../dockerfiles/debian-all-test-cross.docker  |   4 -
 .../dockerfiles/debian-mipsel-cross.docker    | 187 -----------
 tests/lcitool/refresh                         |   5 -
 14 files changed, 56 insertions(+), 530 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

-- 
2.51.0


