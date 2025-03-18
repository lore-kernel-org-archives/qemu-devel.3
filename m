Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D21C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOvg-0001EQ-7G; Tue, 18 Mar 2025 00:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvR-0001Db-Ob
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvP-0008Rm-LL
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so122474085ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273493; x=1742878293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zu9103r8oTjAUXk/0jU4XMC8f8kUJ8IRY2kEKbMxwAQ=;
 b=APNLkjxLrdhIxjQDZfwAeh7HB8BfLbGM/9OlP2H4rey7vv5ZRfVHEFn5tCGRcJJfdi
 d9zhl26GzaSm4hB3Gr3ExSrmH76BPkbTt1ZGWyxSERTb9RETyrA/1DUtt8/d1StzC9Ra
 NH4VZ2axmpn5Aye4p2EYpS/a9XcZT5NZrnrQwblnUcZv7wwdM8Ub9GUHwxU8cgoiClAM
 Cpa3djDuIyypHMKyWXYeNtVW4B++BxMCnSHQYWVSVClDtmhcL8q8SXDtsPrInVV+tzHP
 EgN865UNuz2ZsWIsKZKmNFFLJ1PlSsG0jig0Mbbi32Zn6EgcuoVIm1cx/CSrwK7sfGyq
 kXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273493; x=1742878293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zu9103r8oTjAUXk/0jU4XMC8f8kUJ8IRY2kEKbMxwAQ=;
 b=hMoLn1jJdVSJ/G6aYR5MrPGwyuA6mNoXJ5WatZonqTPRgbw4fuPfS8DQJfwbKnGcfS
 PZ5sRyo8ycXvhDJxOjoZIjaXfmHeasmqyODHYeB/djeUgt8j2Yli2VvXFVcZfGLtxr1h
 8vG9ShUf8XoNj7L3tH0/Z9j3ordiC8JDqN+yzP5gEd9eF2uzHA3JX26mAco2mJj69fgS
 PLxhqzwcbNxZAeskFL+UQHUZgshaV9VzucaFDW+AebMkG4Zr3UzMWi+972QUaN30K+N6
 M9aQA3ZsXfQaERnUJS0UkSWxiLvgPkc5GH8xld37wwVRnJyrY59P39SWOPecLBoa8LaU
 XDSA==
X-Gm-Message-State: AOJu0YwLVQwa+512ZqSmRafOMEhUOZhT7s52xgp6JqIPBfmsmg3SXuDn
 BBaa5AEzqY4Ms7zB+piIxWUbLfxMNaBG7B2Wou4eY9Kfa7fQz7Cfzvr7sqaef4iPvqCtacOArFF
 7
X-Gm-Gg: ASbGnctl7jPA47gy5eKFZhTwmz+dF85/RG5pSZE7j/p8iLJWwB/ejg8dxDQAa0CMxxm
 3ZlSa1tCDn3uuvULNF/NHxBklvyhNZVLC25oHeK/h14fM0ngytNQxtWSBb0kdVq3wpWJoxLvuz2
 jjkDuWZDJReo+I6NpCwuaq5qeWIkJBaE7IxDq7F65CkJ611n7tXNuHrzzBGEz6t/fCIWeU1JzYJ
 qn2aGnKTlUYEahzJM5p+c+Bxz9eaAWGPU9B9ff6ITP1kTIEuFdeiksVm3OzHd07EvbyTlITGBhJ
 +YwVjmXxqPHZImZlwMyM/Ef/Yu9aGynOR4DalpuN4sFCgC9w/I3os7Y=
X-Google-Smtp-Source: AGHT+IGjVevdOxVZtllqsOzTh2kSPli9+2FoEMdQ20zfQwf4sZc4Mag5ZWZo6Cn4913jSf5K9IBO+g==
X-Received: by 2002:a17:903:2b0f:b0:224:194c:6942 with SMTP id
 d9443c01a7336-225e0aee904mr229423185ad.34.1742273493096; 
 Mon, 17 Mar 2025 21:51:33 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/13] single-binary: start make hw/arm/ common (boot.c)
Date: Mon, 17 Mar 2025 21:51:12 -0700
Message-Id: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

This series focuses on removing compilation units duplication in hw/arm. We
start with this architecture because it should not be too hard to transform it,
and should give us some good hints on the difficulties we'll meet later.

We first start by making changes in global headers to be able to not rely on
specific target defines. We then focus on removing those defines from
target/arm/cpu.h.

From there, we modify build system to create a new hw common library (per base
architecture, "arm" in this case), instead of compiling the same files for every
target.

Finally, we can declare hw/arm/boot.c common as a first step for this subsystem.

This series needs to be applied on top of
https://lore.kernel.org/qemu-devel/20250317183417.285700-19-pierrick.bouvier@linaro.org/
to compile.

Pierrick Bouvier (13):
  exec/cpu-all: restrict BSWAP_NEEDED to target specific code
  exec/cpu-all: restrict compile time assert to target specific code
  exec/target_page: runtime defintion for TARGET_PAGE_BITS_MIN
  exec/cpu-all: allow to include specific cpu
  target/arm/cpu: move KVM_HAVE_MCE_INJECTION to kvm-all.c file directly
  exec/poison: KVM_HAVE_MCE_INJECTION can now be poisoned
  target/arm/cpu: always define kvm related registers
  target/arm/cpu: flags2 is always uint64_t
  target/arm/cpu: define ARM_MAX_VQ once for aarch32 and aarch64
  target/arm/cpu: define same set of registers for aarch32 and aarch64
  target/arm/cpu: remove inline stubs for aarch32 emulation
  meson: add common hw files
  hw/arm/boot: make compilation unit hw common

 meson.build                | 36 +++++++++++++++++++++++++++++++++++-
 include/exec/cpu-all.h     | 12 ++++++++++--
 include/exec/poison.h      |  2 ++
 include/exec/target_page.h |  3 +++
 include/system/kvm.h       |  2 --
 target/arm/cpu.h           | 28 +++-------------------------
 accel/kvm/kvm-all.c        |  4 ++++
 hw/arm/boot.c              |  1 +
 target/arm/helper.c        |  6 ++++++
 target/arm/tcg/hflags.c    |  4 ++--
 hw/arm/meson.build         |  5 ++++-
 11 files changed, 70 insertions(+), 33 deletions(-)

-- 
2.39.5


