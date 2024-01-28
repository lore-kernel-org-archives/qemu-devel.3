Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E27C47DDF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 08:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU0W6-0004SB-47; Sun, 28 Jan 2024 03:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU0W4-0004S0-G3
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 03:27:48 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU0W2-00079O-AE
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 03:27:48 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3be4cf37c14so38539b6e.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 00:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706430464; x=1707035264;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MJ/JtCayd5oT7ympEH9TIQ53/Lmd99ySh4obNvOPLBo=;
 b=UTl3fNCArmbf0bIK+w24lOMPnmkAB3dQqqKVEyeFQbebozEzN8Re/CQI0gg7OVersw
 NfKAImFzVW7n+hi6oxTqRj7GvEAqKwATXP81G6Nw66MiIHBh/9NfoNr3FlQdEfnYnhG1
 Q2wPjeDYNhoocut0J6zkxnK5ghjLH9EesWdUeMDGOwHDhcRU+dCbEuOAaapwRYKT3wyP
 QnxG1W+b5U6eMZWUsLn1Wfr6dtMBwAEZ0tDnKgj/aBBuwDHfXogTG1dUwzdQMDPFkpKv
 jpxH4QvRWBG+k8VXZcygS4Uy1j12OQORnqVJO9sitwIfE3XOwOl8Mzrkyt3YK2vygHia
 W8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706430464; x=1707035264;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJ/JtCayd5oT7ympEH9TIQ53/Lmd99ySh4obNvOPLBo=;
 b=dg2dCPlf7wc9b0+LhMHi4ahiPxIHIWugSS14/kGtW3eDh5cgnq0RvisTWAeoPlVFYS
 RjuI2tuBLGdauXGipdFljUC+QF1KfHE5+/uysPwqsrn/JNtdldxu10NrpSXKBgRuztBl
 EVA7F43n/HM+IMZtOEkS+EFnA5KB8Gx99RXYssJoUQI8Nek3djDLxPTbKiGY4uokMnd7
 0mX/9wgNXtf5Ox6an6SsjkxLzxVIzPZSRxFtmTT0eobZmY40wF7pt6on3goe7MJbSU83
 yecXreECkebkC+bW1sflKZfAbS6TN5zr44S6Zw7sZP/+AruBhZh4Z+xOZYSRFGgXkQsI
 zhrw==
X-Gm-Message-State: AOJu0Ywrm7qf6GLFC3RPvqkDO2KP1H0S/zJ0QPe0CCsZqrBmtAR+8q1b
 wafFNfiCopaxC0x2ivfwNHTWwL6w5jFKfpALIKPv7rRygHIGRjTzXwi2hvDuMoY=
X-Google-Smtp-Source: AGHT+IFL/Ja0ymH8koosqEl18njhnl9BB51Q+tRqFFEvlFUsF+xaQ5iGbnP2IkmRpwKV0ItzaCLYWA==
X-Received: by 2002:a05:6808:1314:b0:3be:174c:1888 with SMTP id
 y20-20020a056808131400b003be174c1888mr3512996oiv.44.1706430464626; 
 Sun, 28 Jan 2024 00:27:44 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 p51-20020a056a0026f300b006dde10a12b6sm3754204pfw.211.2024.01.28.00.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 00:27:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v10 0/3] gdbstub and TCG plugin improvements
Date: Sun, 28 Jan 2024 17:27:38 +0900
Message-Id: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPoPtmUC/2XMTQ6DIBCG4as0rEvDgAp01Xs0XeAAlUW1gYZoj
 Hcvmpj0Zzlf5nlnklwMLpHzYSbR5ZDC0JcD2PFAsDP93dFgy0A44wI4CBpDwkw9om4qplWDnpT
 fZ3Q+jFvoeit3F9JriNPWzXJdfwtZUkaNbBjUjRFC+os1Ux/GEw4Psiay+mRqZ6ow1K3nLdSKW
 /nH9M4qBlDvTBfmPUhwYJxF9cWWZXkDCLriaQoBAAA=
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series extracts fixes and refactorings that can be applied
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

V6 -> V7:
  Rebased.

V5 -> V6:
  Added patch "default-configs: Add TARGET_XML_FILES definition".
  Rebased.

V4 -> V5:
  Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".

V3 -> V4:
  Added patch "gdbstub: Check if gdb_regs is NULL".

V2 -> V3:
  Restored patch sets from the previous version.
  Rebased to commit 800485762e6564e04e2ab315132d477069562d91.

V1 -> V2:
  Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
  Added patch "target/riscv: Initialize gdb_core_xml_file only once".
  Dropped patch "target/riscv: Remove misa_mxl validation".
  Dropped patch "target/riscv: Move misa_mxl_max to class".
  Dropped patch "target/riscv: Validate misa_mxl_max only once".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v10:
- Dropped patch "hw/riscv: Use misa_mxl instead of misa_mxl_max" due to
  invalid assumption that the relevant code is only used for kernel
  loading.
- Link to v9: https://lore.kernel.org/r/20240115-riscv-v9-0-ff171e1aedc8@daynix.com

Changes in v9:
- Rebased to commit 977542ded7e6b28d2bc077bcda24568c716e393c.
- Link to v8: https://lore.kernel.org/r/20231218-riscv-v8-0-c9bf2b1582d7@daynix.com

Changes in v8:
- Added a more detailed explanation for patch "hw/riscv: Use misa_mxl
  instead of misa_mxl_max". (Alistair Francis)
- Link to v7: https://lore.kernel.org/r/20231213-riscv-v7-0-a760156a337f@daynix.com

---
Akihiko Odaki (3):
      target/riscv: Remove misa_mxl validation
      target/riscv: Move misa_mxl_max to class
      target/riscv: Validate misa_mxl_max only once

 target/riscv/cpu.h         |   4 +-
 hw/riscv/boot.c            |   3 +-
 target/riscv/cpu.c         | 183 ++++++++++++++++++++++++++-------------------
 target/riscv/gdbstub.c     |  12 ++-
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  44 ++---------
 target/riscv/translate.c   |   3 +-
 8 files changed, 135 insertions(+), 131 deletions(-)
---
base-commit: 977542ded7e6b28d2bc077bcda24568c716e393c
change-id: 20231213-riscv-fcc9640986cf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


