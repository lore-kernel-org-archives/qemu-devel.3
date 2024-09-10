Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F94BEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzPJ-0003s5-Ru; Tue, 10 Sep 2024 07:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPH-0003qp-NM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:51:40 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPF-0006Vf-UJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:51:39 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53659867cbdso6787824e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969095; x=1726573895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o0EfI1A/UvauZ83BL14nXZ+tiWTTtTokFBoS4sXlOCg=;
 b=pDo4dfVMgt+TyC9nK3SdSA5Hv5C0qq8THwVq7G0S2x3icnQmGkfGOdZJVzsMxjR5UW
 8i8PjHwXonPqg5J6dQoPNPctvTXa0QHc6VPfrzbD7lilBHBUycz6yuWQujOsdYQrPXpv
 AMBoRZfJmrH0GI4OJNmPHeVrK8FQThNtnco54Y1GLqnLf8h7nKx4OxhNJn2sp/LbJryy
 LHYXWiAySZDnE1+Yy18VQqjIlFMUUrCsTB2EkGI5w/ulP7RhYX/YMSu0+/geq4ps3DPx
 IOO/GWOfPrgeZ+8hLcnJ6Ms47ogIkkKLAQjoS06iCZoZHiTDrl0lntD7qGqr6kuA8IXx
 xMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969095; x=1726573895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0EfI1A/UvauZ83BL14nXZ+tiWTTtTokFBoS4sXlOCg=;
 b=PbJ41khwPfxnfxcCqOd0cnMPOqowNPCd6UsWFnrD9wgV8MjxXEpyDD2Lj3vGEO3Z6Z
 c+6RSRVhzJSU25pBOqCikZE89f+8Y/iKvaW9uKGiqLs8+AxNmONYBwqi64E61OzfRA1A
 4Vg7c7efPP00tRFMwRCnVwHkoCG7gD0S+T08TIC61LoeLDWj4PQaZSyokk+I8o2hlbK0
 cjC7Uu99i5XEDErPhTOrjH8mSc1+PjOh3MoQcdcJVGNtnkrO6DUkTRi/5pdrpHJPoGC/
 tsnLpSr2ppoaOhY6nkKOCxTt7+vAu+Fs6QEkPwsZrSYYWiaXpLE7SHq5Od0hSYKpiIGy
 ljUg==
X-Gm-Message-State: AOJu0YxWpfyd94mxMeExJ5tHZroUVik4k6WhBTceUXa3p/6kbrz9biUU
 J80Yn6Fl5IvpkJSR33ul58W0auZ7P38NRS4JukO3cE3bFdlfsABvqbl3XM70UF1YTDyruLnN10X
 B
X-Google-Smtp-Source: AGHT+IHm1rGXb188G58Hp/pHYhQkmzhgHMYhdit50oVw56sXkxZvj4nku2LHy2pVyaxPFd0pC2usWw==
X-Received: by 2002:a05:6512:398c:b0:536:542e:ce1f with SMTP id
 2adb3069b0e04-536587ae0d6mr10797166e87.18.1725969095429; 
 Tue, 10 Sep 2024 04:51:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cefa24sm479414166b.178.2024.09.10.04.51.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 04:51:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] license: Fix typos and update deprecated SPDX tags
Date: Tue, 10 Sep 2024 13:51:26 +0200
Message-ID: <20240910115131.28766-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

- Fix a pair of typos

- Upgrade the deprecated GPL-2.0+/LGPL-2.0+ SPDX tags
  to GPL-2.0-only / GPL-2.0-or-later / LGPL-2.0-or-later.

Philippe Mathieu-Daudé (5):
  NSIS: Simplify license description
  tests/functional: Correct typo in test_netdev_ethtool.py SPDX tag
  license: Update deprecated SPDX tag LGPL-2.0+ to LGPL-2.0-or-later
  license: Update deprecated SPDX tag GPL-2.0+ to GPL-2.0-or-later
  license: Update deprecated SPDX tag GPL-2.0 to GPL-2.0-only

 include/gdbstub/syscalls.h              | 2 +-
 include/gdbstub/user.h                  | 2 +-
 include/qemu/crc-ccitt.h                | 2 +-
 target/alpha/cpu-param.h                | 2 +-
 target/arm/cpu-param.h                  | 2 +-
 target/cris/cpu-param.h                 | 2 +-
 target/hppa/cpu-param.h                 | 2 +-
 target/i386/cpu-param.h                 | 2 +-
 target/m68k/cpu-param.h                 | 2 +-
 target/microblaze/cpu-param.h           | 2 +-
 target/mips/cpu-param.h                 | 2 +-
 target/openrisc/cpu-param.h             | 2 +-
 target/ppc/cpu-param.h                  | 2 +-
 target/riscv/cpu-param.h                | 2 +-
 target/s390x/cpu-param.h                | 2 +-
 target/sh4/cpu-param.h                  | 2 +-
 target/sparc/cpu-param.h                | 2 +-
 target/sparc/insns.decode               | 2 +-
 gdbstub/gdbstub.c                       | 2 +-
 gdbstub/syscalls.c                      | 2 +-
 gdbstub/system.c                        | 2 +-
 gdbstub/user-target.c                   | 2 +-
 gdbstub/user.c                          | 2 +-
 hw/nvram/fw_cfg-acpi.c                  | 2 +-
 hw/virtio/virtio-acpi.c                 | 2 +-
 linux-user/alpha/syscallhdr.sh          | 2 +-
 linux-user/arm/syscallhdr.sh            | 2 +-
 linux-user/hppa/syscallhdr.sh           | 2 +-
 linux-user/i386/syscallhdr.sh           | 2 +-
 linux-user/m68k/syscallhdr.sh           | 2 +-
 linux-user/microblaze/syscallhdr.sh     | 2 +-
 linux-user/mips/syscallhdr.sh           | 2 +-
 linux-user/mips64/syscallhdr.sh         | 2 +-
 linux-user/ppc/syscallhdr.sh            | 2 +-
 linux-user/s390x/syscallhdr.sh          | 2 +-
 linux-user/sh4/syscallhdr.sh            | 2 +-
 linux-user/sparc/syscallhdr.sh          | 2 +-
 linux-user/x86_64/syscallhdr.sh         | 2 +-
 linux-user/xtensa/syscallhdr.sh         | 2 +-
 qemu.nsi                                | 4 +++-
 scripts/kernel-doc                      | 2 +-
 tests/functional/test_netdev_ethtool.py | 2 +-
 42 files changed, 44 insertions(+), 42 deletions(-)

-- 
2.45.2


