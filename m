Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A6AE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTOL-00065e-2G; Tue, 17 Dec 2024 03:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOI-00065G-PJ; Tue, 17 Dec 2024 03:57:19 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOH-00005e-1i; Tue, 17 Dec 2024 03:57:18 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53e3778bffdso5265054e87.0; 
 Tue, 17 Dec 2024 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734425834; x=1735030634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mabpfnLg/kj7MAn3K2Vt5Anh/wyNP/Rjk30c6RwnMZ8=;
 b=My1InxPtZdNQJvT9JlMyPs9ao2BSQ2EGpIzyfwR0xCcjSy13303rAi4GZNF9AcsfOF
 VpmC2j1BycJYfYod+t+TQNg4mCGab7nrcDj1xIp+fpj+XicKbNv96G5qIofWCyNwyBze
 GsOkMvu1PdUJlDJv1OAv/R5tTi2iDhU0M1PgT+t86Wx6daoSKKFnjZCZ0YzNVYDvez1G
 lXMlMQETm9GycBvKU+Sa1b8wRylrVMyCDp8w3kZURUJgejqHZRgxzo3Kgy7sgn9vINaa
 Ad6Keu7GrtP7bHAk31IuWx4J4vByFpB2h5qowIZdmvUfcm0gmT/1XqKizp1gQ2ak9sgH
 Zzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734425834; x=1735030634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mabpfnLg/kj7MAn3K2Vt5Anh/wyNP/Rjk30c6RwnMZ8=;
 b=u2KSYQUOWP+5EqFVOauKTmOdmhW2Dqfj+SsEnpHznJ3cDGQUaNJJWz3xCVeIr5Cus9
 LBja3r8jJngPGXZzIYYFpHCavCH5ywIQPxEbZTx/02wfCa9YmazqngiOgjKav9hSAEs6
 Z+wfqBt0VX6nSVVnTdct2VM6hmeCA98PrmKmoXjxNckBWXB7nKc9JScZQFxYsv1/qYDA
 R/XGqdMFVJoF7qgtrX1HPgRkyO4L8Sf4Jfig1t7fZaLXoN19ye9UMNPciSq3g2gHeD71
 OiOXPWqn8xUKwLzZuWlhTXhEQDGmOtqOFWN44li6HT50PrYbybzBM4MIlqT4RRy5nMow
 34pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7SAbZVKJKFvc1qYOlo3FJw4KelDUDjdP/xT09KKPWS06M4BIvdlEsfaBECOwTXGqlELs97lLxKAVzmA==@nongnu.org,
 AJvYcCUsktLUfIlrE2Crec8admtP9+XR2snpRwm8HhRlD1Q9rT99xoya3cAqdQHpqSg5Xp7qt41EBGELf04F@nongnu.org
X-Gm-Message-State: AOJu0Yz9xi0aLTjKe/hz9qJ2Lndy/U8MSLQnsB+iAZNDAK2/WwhO1U5Y
 eZ5d6S+ctwYlEDieOsuXkx5Y/lYAwNEHSyVXk2sbvPI61hKyZLDO
X-Gm-Gg: ASbGnctDpoV+KN0MEWCxe7sI+2IrC/TXB94vF5UKY/zM1X6AtANoyzZrO+a2fIT0oET
 yEDV+2xhTbDtFjey7zUiJ+4v4IcSv8x7g3mOqDf2FXYYG8mW8h3+ApZeMQsA32X4LmaqcfgwXL1
 bpBGyqlrGPStX0KyzENPQ8Djibh7MiOC2dKNiuJ0myg6LnWujFn/QGASE3atck41t5sFg2sJz/q
 oJhwYhTAjNPXU4qkH+ngwBnQ/Rt5VUu47H18DonTn1nDrtfS2erqgVnCsSV
X-Google-Smtp-Source: AGHT+IFAF95xfZTOLCglpLuWXH9a1uwEMAsYEMiB6teoYLeRxX500j8orQLvn0eP7HrR680Enaa/4g==
X-Received: by 2002:a05:6512:39c8:b0:540:1b7e:7b4a with SMTP id
 2adb3069b0e04-540905955d7mr5257793e87.36.1734425834122; 
 Tue, 17 Dec 2024 00:57:14 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13c24sm1092499e87.197.2024.12.17.00.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 00:57:12 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v14 0/7] Pointer Masking update for Zjpm v1.0
Date: Tue, 17 Dec 2024 11:57:02 +0300
Message-Id: <20241217085709.679823-1-baturo.alexey@gmail.com>
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

Rebased and addressed Alistair's comments on code style.

Thanks

[v13]:
Rebased and addressed Daniel's comments about the return type of the helper.

Thanks

[v12]:
Rebased and addressed Richard's comments about proper masking virtualized accesses.

Thanks

[v11]:
As suggested on the mailing list by Daniel, I'm resubmitting this series and keeping the original versioning number.
So that makes this one v11 and previous - v10.
Also I applied previously issues reviewed-by tags on some of the patches that were present in v9 series, but only for the code, that didn't change much.
For the others I'd really like to have them reviewed as there were a lot of comments on v9 series.
Also rebased on the current upstream.

Thanks

[v10]:
I've rebased this patch series and addressed Richard's and Daniel's comments.
Thanks

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

 target/riscv/cpu.c           |  19 +-
 target/riscv/cpu.h           |  50 ++---
 target/riscv/cpu_bits.h      |  91 +--------
 target/riscv/cpu_cfg.h       |   3 +
 target/riscv/cpu_helper.c    | 128 +++++++++----
 target/riscv/csr.c           | 357 +++--------------------------------
 target/riscv/internals.h     |  54 ++++++
 target/riscv/machine.c       |  17 +-
 target/riscv/op_helper.c     |  16 +-
 target/riscv/pmp.c           |  14 +-
 target/riscv/pmp.h           |   1 +
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  47 ++---
 target/riscv/vector_helper.c |   5 -
 14 files changed, 257 insertions(+), 550 deletions(-)

-- 
2.39.5


