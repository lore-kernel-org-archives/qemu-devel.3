Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEC3CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMR4T-0008Ni-AO; Mon, 11 May 2026 09:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMR4R-0008NV-10
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:53:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMR4O-0004Q6-NO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:53:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso38232675e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507594; x=1779112394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jBMomhWFmRpeSLerr/WefAmU3fBAtBexixf9t/WtOc4=;
 b=qDL4Z/ED93AdjrietuoL3mDnfkffbGCs2Ca/WvqZOaovUUERAcB8YugzyEwnc2WD1p
 ccr/AvXU8J0HlcRk5pZMb+XPn4hMMgNmOhlPs1u6b48TNJ6SF32588+S3FZ81i8NDhTf
 Kp83roNxo5WiIGBqDrY/Fdo7HtxU9iN/IsEDGmcvOJnzXtfyUdSEBQ13LOahvYyK7Egi
 MUy2qXKjKij8UOapMmn+x/+xqGlgb7kN9i97Vw+254jicVvQRcsxq38pktDUAXuPbkeN
 LFJGy2vx4El3h5UQI8hpuZGjWSNJmSYfoBQm37dALRIciBtX9q3YNykWcPlVVrbOPBDV
 zsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507594; x=1779112394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBMomhWFmRpeSLerr/WefAmU3fBAtBexixf9t/WtOc4=;
 b=eH2YcJggfNKdYQXwmswroe7BVWESAiskQ06CcQRFzcfUjk8ukA4ARsYbc7WeGjGdJN
 iVz+NIUkk26o6GV1l00wsP+IHYLteIgoGWBKLqk3c4AslQHJslgvI2KJog5TMtSg0Msl
 6hg6RvYpUg+5MU7WO6rC4Wjp+I6H8uBdM65SQPJoyfkfpQnP2FXp+dBv10lUXoedA1P+
 KDF1l35r9+6GEJboa1dxotd2Be9+0TQJFawAC8XViQ5Oai0RK8Y+6QSORslyNQMPypS4
 zqgeFnbtRrw+M9kzqwNQsIibpbNhvtZh+Rh2U4hKrGi2BrMKxea3EmdKOeXua09JNsrq
 8wwA==
X-Gm-Message-State: AOJu0YwtrCESu9msh2qh1D9nlJxFRoC/Fl9xvXR8+6bmztN3eyt/0QfO
 ky9kNMqtiq4PXBRvQ/h8xiBgeUxGPokhJnoFvfiVX9vqWH9jBBzxDqUtxonNylwo8wMwylJX7ML
 gR1X9ZT0=
X-Gm-Gg: Acq92OHg884D7uEAy8yzqYhwxRXDFeoHunV8OUzvNJdLKKuQwyVWH1Y7gzGKRyrW6iI
 cJSVSubBqKhrjDpTloPvIbcaOEfE0wnSvYzLU4rp49yiaD0bMatlKPuNfxRC+3UuzEp13GnIvAe
 E5KL4cfPfA7fmVL11+uoweSiuQG0tCAByYdAZZsGXt9QM3lc+WBqXatOCC2gj/bdUp852o9iwmL
 qM2WdxE40e5BzPZrG2yDTvUKKZrdoAsfwLwM8SQ90R2se8Rtgc+RImJVTOdC++0VwwODNBaKPWE
 cP7J2dzfimgy5RFQsIfh1NAfQ2nXKTWKWnN443ml01+rCoH3r7DdNdT9OJApXYBYytmNJ/GE8IF
 dNAqOjBubIKZuLcW83kKlm+JmofYAbRiw2UcTivjsHSPVIVezF0I62nRd+shdzJecI4SNz5EsUt
 L6qy6AxfXTDAxi4rZ4DsEsrkIRcrtWx1mfmLcj0DdJ0JgKoXHEhYxNvG6wsxn5EyrrGp5vNaqf
X-Received: by 2002:a05:600c:19c8:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-48e70687ed2mr165036545e9.5.1778507594166; 
 Mon, 11 May 2026 06:53:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6f9fc89asm198678605e9.0.2026.05.11.06.53.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 06:53:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 0/5] buildsys: Remove support for MIPS host
Date: Mon, 11 May 2026 15:53:06 +0200
Message-ID: <20260511135312.38705-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

During the v10.2 development cycle we deprecated MIPS host
support (mostly because Debian which we use to test in our
CI dropped the architecture when releasing Debian 13).

This series removes host support for MIPS.

Philippe Mathieu-Daudé (5):
  buildsys: Remove MIPS cross containers
  buildsys: Remove support for MIPS hosts
  hw/mips: Include missing 'cpu.h' header
  buildsys: Remove MIPS KVM
  buildsys: Remove MIPS TCG backend

 MAINTAINERS                                   |   15 -
 docs/about/deprecated.rst                     |    8 -
 docs/about/removed-features.rst               |    6 +
 docs/system/target-mips.rst                   |    2 -
 configure                                     |   20 -
 meson.build                                   |   12 +-
 include/qemu/timer.h                          |   30 -
 include/user/thunk.h                          |    2 +-
 linux-user/include/host/mips64/host-signal.h  |   75 -
 target/mips/kvm_mips.h                        |   28 -
 tcg/mips64/tcg-target-con-set.h               |   30 -
 tcg/mips64/tcg-target-con-str.h               |   20 -
 tcg/mips64/tcg-target-has.h                   |   69 -
 tcg/mips64/tcg-target-mo.h                    |   13 -
 tcg/mips64/tcg-target.h                       |   75 -
 tcg/mips64/tcg-target-opc.h.inc               |    1 -
 hw/intc/mips_gic.c                            |   11 +-
 hw/mips/loongson3_virt.c                      |   67 +-
 hw/mips/malta.c                               |    1 -
 hw/mips/mips_int.c                            |    7 +-
 linux-user/mmap.c                             |    2 +-
 target/mips/cpu.c                             |    5 -
 target/mips/kvm.c                             | 1283 --------
 target/mips/system/cp0_timer.c                |   12 +-
 target/mips/system/physaddr.c                 |    1 -
 util/cacheflush.c                             |   16 -
 tcg/mips64/tcg-target.c.inc                   | 2605 -----------------
 .gitlab-ci.d/container-cross.yml              |    6 -
 .gitlab-ci.d/containers.yml                   |    1 -
 .gitlab-ci.d/crossbuilds.yml                  |   22 -
 target/mips/meson.build                       |    6 +-
 tests/docker/Makefile.include                 |    1 -
 .../dockerfiles/debian-mips64el-cross.docker  |  187 --
 .../dockerfiles/debian-mipsel-cross.docker    |  187 --
 tests/lcitool/refresh                         |   12 -
 35 files changed, 32 insertions(+), 4806 deletions(-)
 delete mode 100644 linux-user/include/host/mips64/host-signal.h
 delete mode 100644 target/mips/kvm_mips.h
 delete mode 100644 tcg/mips64/tcg-target-con-set.h
 delete mode 100644 tcg/mips64/tcg-target-con-str.h
 delete mode 100644 tcg/mips64/tcg-target-has.h
 delete mode 100644 tcg/mips64/tcg-target-mo.h
 delete mode 100644 tcg/mips64/tcg-target.h
 delete mode 100644 tcg/mips64/tcg-target-opc.h.inc
 delete mode 100644 target/mips/kvm.c
 delete mode 100644 tcg/mips64/tcg-target.c.inc
 delete mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

-- 
2.53.0


