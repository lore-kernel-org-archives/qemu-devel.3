Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99B3CD6E64
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULGz-0000g6-6X; Tue, 02 Jun 2026 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGV-0000Px-Ir
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:33 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGM-0007Um-BL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:22 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304cf518c9dso7484681eec.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780391894; x=1780996694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KOqPOR5PYlNFrQ/myC0caI5VhqPE+T4MVF8I72+cnOI=;
 b=n1vpBU1+BR4wNkGn9jVH0DDdP2mFREOvB/FgY1+0HPk67X57E6NXQnxwiVVzKJv/0o
 QBqizsKiP66Rbk71f6ylmQSKW5wXJTI+UsR/SSVtS5YK22z9Wd0Di7kOry3Yd1eYVVA6
 CG7XbgFHK1y0SCQtNgigi+/chHtV1CXnz+b/OS6L5W6IzWxLleaRE97NGVWiCuQ3B6vU
 k+NenbRbTTY/iQWClqV6hXPCYX7kbwsQTIQpFtkaraqq5kzTPUYdBOhRb0NZEYbj0Hg1
 4Eohol/AZtVxW9b34BmGaJ/ktFm5d5zZw9MzOJQZBFGlAqm6wS7KcascO98Y4Jl2qehu
 cLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391894; x=1780996694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOqPOR5PYlNFrQ/myC0caI5VhqPE+T4MVF8I72+cnOI=;
 b=MylWqj0HekA8+RgMChSwk4XsjqCAB+vD04NpyXFDULxgVcdrFD0t2gfN17b8WwjJGn
 PYILGEDLViV7EGFTEWoSfhIJjgV/dLGRfbccQ+m8g6COiUOaPQcUQIQ6gHEI1KDgy0s7
 Cy5TQk1L3mXiBOGtY1FUPfefaPN6IJ+Q26MF+X89Sf1XgTDKPJ3zmtCWDJd8uBIXnsZz
 sz9P9i+q/zuAaclpX4qxQIvZHz/JKefVPmAU1v4Bmv9vfgKp0InxIiSCyCRwU0Ada1Jo
 quex+GPD7IHSaKxPTpZaRnwHbIox7eo5c6N3sxqoFABhn5ytTy8VBOOZUzzH548I5cLe
 zVyw==
X-Gm-Message-State: AOJu0YyuUYfeStjYA8bgd1ZBaPe6u8rHBzbTt5TTSytHAOyIkiXwalFr
 L7XzuYPYTAZjgysV3rtYpXpUSWndR7tXnV7TmP5AHW15NgpLnbohIHJIUz9yXYzWnjNHFw==
X-Gm-Gg: Acq92OEdgacugJdqmC1v675AKROUqm2GO+peuC9wyu3jf5YqCm4DvA7EgxJn4mW83SN
 neGqIYrIL7njJ5v8e28zYFv9VShwjd0NxQndNwjjrdnmtnq/0l5caXbmd+lax20M1E3JpxDNrWq
 aOgxqvKyGjSgt6tJDszFOCaM1ooTB/sG8/nzxpvup6igE0TCo46n6dPPKkopERR10BF/vx1QYdX
 rPhpJwEJ8lM9GJ/6JxmsI2MMudUrFyF0FLlvBHv1I4LcIITbGnIAsoQDP3CXI1IXx5L5MIgFekz
 JwcgeIYDjlC7YzkVpzVpXDz49S6g0mhf8C+matc5GjR1WVPdFw5NJjqabkU0/ftHV3t0nNF+xqC
 xTfhjVS6A35AGqubl1qbRAfVnbrBdr0ON9i65C5p24JnqEshSELFny9Ls5n2wOa79u2ffCM87oG
 9s/6pTDSnXmcVol7P0tg2YJWuHq3H8jzd4WBJQzwP5hUu/0C6xslMlOYGa35tDZryxWWwKwR/it
 NwmUYh9M0iJ4xDo0nrEtEprXEc=
X-Received: by 2002:a05:693c:3006:b0:304:d388:c33e with SMTP id
 5a478bee46e88-304fa4a7fd1mr8704846eec.1.1780391893672; 
 Tue, 02 Jun 2026 02:18:13 -0700 (PDT)
Received: from openkylin..
 (ec2-54-176-108-193.us-west-1.compute.amazonaws.com. [54.176.108.193])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm11419146eec.5.2026.06.02.02.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:18:13 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@linaro.org, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v3 0/6] target/riscv: Fix no-TCG build
Date: Tue,  2 Jun 2026 17:17:47 +0800
Message-ID: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series fixes the riscv64-softmmu --disable-tcg build by keeping
TCG-only code out of no-TCG builds while preserving common RISC-V CPU
helpers for non-TCG configurations.

Compared with v2, this version replaces the no-TCG stub for
riscv_cpu_validate_set_extensions() with a common cpu-validate.c split.
The validator is used by common CSR code and should not live in TCG-only
code.

Changes in v3:
- Replace the no-TCG stub with a new cpu-validate.c common source file.
- Move common RISC-V extension validation and user-option tracking out of
  target/riscv/tcg/tcg-cpu.c.
- Move fflags and exception helpers out of TCG-only helper files.
- Reject x-misa-w outside TCG.
- Build RISC-V TCG-only sources only when CONFIG_TCG is enabled.
- Add GitLab CI coverage for riscv64 KVM-only --disable-tcg builds.

Testing:
- ../configure --target-list=riscv64-softmmu --enable-kvm --disable-tcg \
      --enable-debug
  ninja

- ../configure --target-list=riscv64-softmmu,riscv64-linux-user \
      --enable-debug
  ninja

- In the no-TCG build:
  qemu-system-riscv64 -M virt,accel=qtest -cpu rv64,x-misa-w=true \
      -nographic -S
  reports "x-misa-w requires TCG".

- In the TCG build:
  qemu-system-riscv64 -M virt -accel tcg -cpu rv64,x-misa-w=true \
      -nographic -S
  starts without reporting "x-misa-w requires TCG".

Zephyr Li (6):
  target/riscv: move extension validation out of TCG-only code
  target/riscv: move fflags helpers to common code
  target/riscv: move riscv_raise_exception() out of op_helper.c
  target/riscv: reject x-misa-w outside TCG
  target/riscv: build TCG-only sources only with TCG
  gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job

 .gitlab-ci.d/crossbuilds.yml |   8 +
 target/riscv/cpu-validate.c  | 630 ++++++++++++++++++++++++++++++++++
 target/riscv/cpu.c           |  13 +-
 target/riscv/cpu.h           |   7 -
 target/riscv/cpu_helper.c    |  53 +++
 target/riscv/csr.c           |  12 +-
 target/riscv/debug.c         |   1 +
 target/riscv/fpu_helper.c    |  27 --
 target/riscv/internals.h     |  26 ++
 target/riscv/meson.build     |  10 +-
 target/riscv/op_helper.c     |  15 -
 target/riscv/tcg/tcg-cpu.c   | 637 ++---------------------------------
 target/riscv/tcg/tcg-cpu.h   |   1 -
 target/riscv/zce_helper.c    |   1 +
 14 files changed, 769 insertions(+), 672 deletions(-)
 create mode 100644 target/riscv/cpu-validate.c


base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
-- 
2.43.0


