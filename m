Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0F0CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKz4O-0007o6-9q; Thu, 07 May 2026 09:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKz4M-0007nq-Ov
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:47:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKz4L-0004RV-9r
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:47:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso8994365e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778161631; x=1778766431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OYM0ceOmVLY8micd18GQNUk/LrS4y/oDCZHHn4KjKz8=;
 b=deyZQISmYG/MvfXpSsi32f5C6WjmufTID552UcZXp5cudykPK54HrNpz31+f31PoxL
 vagesHwM2EM4oOTwTJm07NXfzRS+o1MZqw/QnjIJP1RDx91CRBg/mT2Fp1eZGOV+L+Dj
 TRJqcaCSAkjrw9XRZPzXPt6EV4qwSz3jopbDfjcZsO3/NOeFTDK1NYi7Tb0ODYxstFQD
 WblKdibuyqolXXTaZ+empyiDqDX2CH9wRoDAR7asH3nm4B8joiMG2DxjihJsI2NNYtZL
 7q9ZNNHPpWdVUwXF0YTILAq2+F3W8kATx1d6xx5KvfxPjR1R1oKgpB80MC+pXXYSyZpb
 LwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778161631; x=1778766431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYM0ceOmVLY8micd18GQNUk/LrS4y/oDCZHHn4KjKz8=;
 b=A5mKTTIpwixFSqVhBooNYAkgqv2pYMxuXEe+SiJaS48yCOQTT//6kY7HHgYceDn1Mq
 c3/C36DCHm+yNu6NrXDZJ739r19D+G2Frx/dJesanuvUgOENDh+JUWd/17syXmuLGCOb
 C+QT2fLb2huI/3/oPSfd4EKGO/eyzz0SXAToOj/n7vUEuJUMBsrRpZ6eZY4HX6moyLr4
 w8wHejwh5JOJLB8a9Ef/QdmomYj5kBGXozgkg5sRwANfs3nhj0Dpt9tmO1itMTXM7doK
 9WFx7GLAkegWv31hck+zVD8FpcJHKYuPmR9ABw82yScfYO94X9SjCclKGzKSNpF92WXR
 SlJQ==
X-Gm-Message-State: AOJu0YxCe1aILAeyiqJdpO16nUliAdJ7XyJL/BngdXjeLDl2w79VnYre
 WLIhA2p+oibIPBz2/FOALs8YhC6lZvGnDYJOJxXGqy6HB+zqUJgUTzwuSFZkHwcjhJbsV6sxsRD
 MJxwBZtQ=
X-Gm-Gg: AeBDietWC+9ty3UpgdC820KEhwFQyHBobfixz14OxjIF06FtbiFBDsJBFpoiiKAR0Eo
 pVqPJ1faDcJlnPIaDuA550tfYylu37R3OuDXLhjTCta96OSnZJUQbB7fiAi/8kUl5jClIn9732G
 02C9h+T4IpvpIDjo9S9i2qSGslzuGbz2fRMkDyQyZnQ7C0zj4X/2S/m55REyWF/BLQS3MWcK48z
 eiiDPQMoVaA8qF+Bpnep3cq70lJIdV6s++NBMfZSRgeRQqe6AFyyECrRPWlXlJguR9wcNNsnM38
 rVAOQSMns24Fg74OkxDH2CsxbqWztl30kew2r5mG6zEaMmIQGfAHweo6VckuDJsgLQ3zWy4qbXB
 IzyI/ZMwWamsteJRvKXOi1hIIeCpORl1nwkgGaWWEKou+Xph0uSRqqYabBHsvohE32pFgTRxEYb
 sO5IVvazE8opeARCSkmZXzLJN0YDfG2aVYuoKYQntZHegabv4FHLEd3A/YaEVhmXPTdVl5dNK40
 T8NQ3QDNYk=
X-Received: by 2002:a05:600c:3f18:b0:48e:5990:9698 with SMTP id
 5b1f17b1804b1-48e5990978bmr88364155e9.24.1778161631254; 
 Thu, 07 May 2026 06:47:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538aaa0fsm153929075e9.7.2026.05.07.06.47.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 May 2026 06:47:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/arm: Extract IDAU interface to its own unit
Date: Thu,  7 May 2026 15:47:07 +0200
Message-ID: <20260507134709.70507-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Trivial series moving TYPE_IDAU_INTERFACE to its
own unit, and moving its header under the tcg/ namespace.

Philippe Mathieu-Daudé (2):
  target/arm: Rename Aarch64-specific methods
  target/arm: Extract IDAU interface to its own unit

 include/hw/arm/armv7m.h     |  2 +-
 include/hw/misc/tz-msc.h    |  2 +-
 target/arm/internals.h      |  8 ++++----
 target/arm/{ => tcg}/idau.h |  0
 hw/arm/armv7m.c             |  2 +-
 target/arm/cpu.c            | 10 +++++-----
 target/arm/cpu32-stubs.c    |  8 ++++----
 target/arm/cpu64.c          | 12 ++++++------
 target/arm/ptw.c            |  2 +-
 target/arm/tcg/cpu32.c      |  8 --------
 target/arm/tcg/idau.c       | 20 ++++++++++++++++++++
 target/arm/tcg/meson.build  |  1 +
 12 files changed, 44 insertions(+), 31 deletions(-)
 rename target/arm/{ => tcg}/idau.h (100%)
 create mode 100644 target/arm/tcg/idau.c

-- 
2.53.0


