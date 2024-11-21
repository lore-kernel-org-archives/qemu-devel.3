Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0276D75BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0RB-0004Sz-21; Thu, 21 Nov 2024 01:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0R9-0004Se-Eo; Thu, 21 Nov 2024 01:13:07 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0R7-0006Ip-LD; Thu, 21 Nov 2024 01:13:07 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so386010e87.2; 
 Wed, 20 Nov 2024 22:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169583; x=1732774383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sl6AB6NJwRVgAE3ACTftf4/Bu6s+PK6tEgrppJnHgqk=;
 b=PsXqVlJz5m/VHTkGF2aTTMfEWeabnJvVRfWhy+uWXm5ZqTick0nK1FjAXYWnYKs+Ah
 m0gVAPoPGeB3MzsSkczVb9dczG/sKkqdIpC8J12HYxaw1f4CpVDowWKKtJGXPuJckM1T
 9so8VSj4BgCtgIGpi8gGRSQB3ucBAQ8SQWy2LG+w7JQ8ZilNcGArLjfYWgb7+LdfsSY8
 zDn2CW44gupMnfvrACrwq+qR3/eloNuaz/dNYsrLK4VyBB0vyitHRDF7a7cvKQLJvf3r
 FWWXZkShfn+D2SC7drylnTFGbvW1Jdy5NTwPOT1MP20m1LGXbPS6CMNx7WwaBryDWUau
 xfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169583; x=1732774383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sl6AB6NJwRVgAE3ACTftf4/Bu6s+PK6tEgrppJnHgqk=;
 b=sYSKLcKgj+8UAoaHqJUFOerrgAJZvaguPLw9LbEddVwL6Uy0jQus9ucJYWkZWfLiZL
 WyImhaKXmL3rHOgQxIzScKEWikEOGj7+TmuBAF5sOLqqEhrtvQOnlcNJewBUyZ07JrmJ
 LOU1P+h/AUTJDN8NgqYCqgXhhbi1zaT5dt56KtuCHHuOrz/pN09FmSjHTwzw5Eik2l/z
 xP+9VQo2clsNP8cbbuxNKhYh2/ogEhoPERXHf6PYRgL85yzqeXV/tKj5BifwU0Bzyw/X
 05CakjZAzxM1QHcj9ZMhbuqy+7MA5ptjuvPt7iVaQ/NCnWeeAe9LNdRTIqIQmZN1qow6
 4obw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZd9mCQ3K9aM0FEc1rOzRQf9ii6vw0GyCzZ67GdUux6kLLdyPOWtXgQWnJ3bLUGtuwk6+uF5k9M3YC@nongnu.org,
 AJvYcCW5PvCyNQYet2QX6I0Jja/8zrjhZKn8ZgAbX2lSFTfLj4zDrVbR38wE3xV1mEJETtea3bd2sZ9YbUC93w==@nongnu.org
X-Gm-Message-State: AOJu0Ywp31/CifigVTxWqwYgzr7vSNN7QBxWzhl8TEEa8sa4CB1prNbB
 9J8X5oIA9DaFb29FrBhZtS5CUqKcA3Emk+FGw2MRVxsFPpJmBxLw
X-Gm-Gg: ASbGncsVmJzd6GVCjBddOsrBzP6hBK4l6TX7HmUynT1z7WTPj4MBaByCLgQe7zkJJCR
 Ve3bEkoogfxDwI8qryzqgaJ77/Xpl6usFgycrTi0nL1NOogwqbwGfxAKtKkjT6ojPr3eISWc43D
 NbrQhxCsWss6b8EcbjRKE+2+HyEKLknIDaRpUgrTXNBD9qyp/uAEYwO41kaZ/ZKbqzpPbeva0Fu
 WFkB75JpLAVq3I9jZROyTdu7YlWA3wI28ov2zGoHpBkENbLmylxdYw=
X-Google-Smtp-Source: AGHT+IGuXKK+JXtIEXdPHJ48baJYISTunEiVxu4JsrNpKLZeucxS9YR2FBb2yY0msLLML8MxeMURnw==
X-Received: by 2002:a05:6512:b8a:b0:539:d10b:e389 with SMTP id
 2adb3069b0e04-53dc132f963mr2545250e87.13.1732169582522; 
 Wed, 20 Nov 2024 22:13:02 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:01 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 0/7] Pointer Masking update for Zjpm v1.0
Date: Thu, 21 Nov 2024 09:12:52 +0300
Message-Id: <20241121061259.4043177-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x133.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Hi,

I've rebased this patch series and addressed Richard's and Daniel's comments.
Thanks

*** BLURB HERE ***
[v0]:
As Pointer Masking is finally ratified, these patches intend to update the existing code to the final version.
These patches have been submitted previously and I tried to address all the suggestions, but I'd suggest to review them from the clean slate and then finally push them to the repo.
Thanks.

Alexey Baturo (7):
  target/riscv: Remove obsolete pointer masking extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v1.0
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Apply pointer masking for virtualized memory accesses
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c                      |  19 +-
 target/riscv/cpu.h                      |  51 ++--
 target/riscv/cpu_bits.h                 |  91 +-----
 target/riscv/cpu_cfg.h                  |   3 +
 target/riscv/cpu_helper.c               | 124 +++++---
 target/riscv/csr.c                      | 357 ++----------------------
 target/riscv/insn_trans/trans_rvh.c.inc |  11 +
 target/riscv/machine.c                  |  17 +-
 target/riscv/pmp.c                      |  14 +-
 target/riscv/pmp.h                      |   1 +
 target/riscv/tcg/tcg-cpu.c              |   5 +-
 target/riscv/translate.c                |  51 ++--
 target/riscv/vector_helper.c            |  18 +-
 13 files changed, 224 insertions(+), 538 deletions(-)

-- 
2.39.5


