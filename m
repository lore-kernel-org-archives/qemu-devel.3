Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D67CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCR0-0007A7-Pv; Mon, 30 Sep 2024 05:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCQy-00072c-P7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCQv-0004Td-BR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37ce8458ae3so784889f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687465; x=1728292265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ihK9o5dHmtKhPgrnG29oGIU3kZSMmFzLphFn+0DByE=;
 b=L71YxnptPr54uFrX9MBVt3J3HWiALhZN8WZifaGPRVmE675J/KV0ZRbqywSyrzpUCi
 8DN7fuxVZQTcAlO+iPKyKmnuBqWUt4HQPtj1R0bJa/vNIrHzQyVlPG3hlVmgoMvXrpW6
 fPNGQb7K2WFH3RQyWSQ2YsmEi5XSPe1ge2AqbQDLHNtIzLQ6UpGwwyL5Gn0V/qzT+wFI
 QD1gDBOF9cQuE1cDiDii0AGwNur78GaZJeKrc3rQ/BvOPJq+fz6PH4fOXOMwJJBckdlM
 Kun37V9mOENaPmqAh/14WQKNuk+6PYaQzuZUmiei+aFlFZvZ1jsmQqStSBwswL9qhI3M
 kALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687465; x=1728292265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ihK9o5dHmtKhPgrnG29oGIU3kZSMmFzLphFn+0DByE=;
 b=iQ3Mudk4eTFTPfAG2OCMWylISHWY1lpBNRrL+4N5uy+bpHXnej0Khwv9lZHbG6I5nZ
 z8+WnQW3URgM+1twMmoYojKhWdaE5zG379fpVgSHEi37zqcoZnBmco4KG0oiwJ27Bmgg
 CTqAqvCvj6OuhrB2bLen2v+P8L9kIuICeIMGYWS6Y9ODqOngyjuJwtSdMJr0/Jp3YmCM
 gVjhZtWf+BdKpjdvcr9DBy3SYbFaPNxhYBSAXjl3SJ0DSrx1BTH5uGyF9JuoJr9/7jll
 uNEM3Idou4VFh3rdVVJt3AqOXM7ruUBlG5TP6ylzoxyrNJ7No+eFTjRKJi7unzh3Xyim
 ePnA==
X-Gm-Message-State: AOJu0YzNfZO32IqLb+09lei4tjdomf1muQzl+PR9Gs1TEUtruXKN5uF7
 8v2CPNcsjKNxgly9vNY7gZsm9FDe0rG4RQ7Q038F8f5+FyRvwsMvIdmbzA8TWfQFN0tCkCngCXW
 j
X-Google-Smtp-Source: AGHT+IHu1eXryV/Isywn6vAGs1g0F5qBPvQiNUxXWGyLCr2xT4deq+RgOzUEuGCFlA6qqms9orPoWg==
X-Received: by 2002:a5d:530c:0:b0:37c:d1fb:82f4 with SMTP id
 ffacd0b85a97d-37cd5b04d71mr10031316f8f.36.1727687465351; 
 Mon, 30 Sep 2024 02:11:05 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddb64sm144649535e9.8.2024.09.30.02.11.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 00/12] target/mips: Remove target-specific endianness knowledge
Date: Mon, 30 Sep 2024 11:10:49 +0200
Message-ID: <20240930091101.40591-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Get vCPU endianness from CP0::BE bit.
Propagate endianness at the board level, using QOM property.
Remove target-specific endianness knowledge from target/.

Philippe Mathieu-Daudé (12):
  target/mips: Declare cpu_is_bigendian_env() in 'internal.h'
  target/mips: Introduce mo_endian_env() helper
  target/mips: Replace MO_TE by  mo_endian_env() in get_pte()
  target/mips: Convert mips16e decr_and_load/store() macros to functions
  target/mips: Introduce mo_endian() helper
  target/mips: Explode MO_TExx -> MO_TE | MO_xx
  target/mips: Replace MO_TE by mo_endian()
  target/mips: Expose MIPSCPU::is_big_endian property
  hw/mips/cps: Set the vCPU 'cpu-big-endian' property
  hw/mips: Have mips_cpu_create_with_clock() take an endianness argument
  target/mips: Remove target-specific code in mips_cpu_reset_hold()
  hw/mips/malta: Remove TARGET_BIG_ENDIAN #ifdef'ry

 include/hw/mips/cps.h                     |   1 +
 target/mips/cpu.h                         |   7 +-
 target/mips/internal.h                    |  11 ++
 target/mips/tcg/translate.h               |   5 +
 hw/mips/cps.c                             |   4 +
 hw/mips/fuloong2e.c                       |   2 +-
 hw/mips/jazz.c                            |   2 +-
 hw/mips/loongson3_virt.c                  |   2 +-
 hw/mips/malta.c                           |   9 +-
 hw/mips/mipssim.c                         |   2 +-
 target/mips/cpu.c                         |  17 ++-
 target/mips/tcg/ldst_helper.c             |  15 +--
 target/mips/tcg/msa_helper.c              |   2 +-
 target/mips/tcg/mxu_translate.c           |  18 ++--
 target/mips/tcg/sysemu/tlb_helper.c       |   2 +-
 target/mips/tcg/translate.c               | 120 +++++++++++-----------
 target/mips/tcg/tx79_translate.c          |   8 +-
 target/mips/tcg/micromips_translate.c.inc |  22 ++--
 target/mips/tcg/mips16e_translate.c.inc   | 109 ++++++++++----------
 target/mips/tcg/nanomips_translate.c.inc  |  32 +++---
 20 files changed, 212 insertions(+), 178 deletions(-)

-- 
2.45.2


