Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855C8E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9wv-0008EN-W6; Thu, 05 Dec 2024 06:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9wu-0008E3-8a; Thu, 05 Dec 2024 06:23:12 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9ws-0005I4-Io; Thu, 05 Dec 2024 06:23:12 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53df1d1b6e8so776844e87.1; 
 Thu, 05 Dec 2024 03:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733397788; x=1734002588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JjwKlMh2gTRVzoRNqHZT6tEM5s16LpMHrxxFjkBkknc=;
 b=UA6OQmNWJXvkEekQYkMHge3e8b4ZbA/rSDlKU07H767DzGlhh8VocquYh4QIv9B2LX
 LODAM0LNSVfjlqQBy1X/UiOKFA+KupS/a2ov7kth24QptskiRyC9yFBs2lwff9p5egTN
 /ojxO1RucaO8zcQ6Fz1MqPWVUMAvNcqlYQ0rCO1sCrsaAarDk+4t0e/CeX06611UogJG
 waz0f/0YxOTlFZhvO1xKLOtIE+1+9JhrUFIj2ZLAVOC5fce8j535vNoapeKIGB70bXKO
 UlhyLb18mkq2EVpiJwJz4rtHGG8i7sTGEIq8uBzeGtdOHHzJI4dQNBNbHvdE3AGgG6Ml
 k6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733397788; x=1734002588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjwKlMh2gTRVzoRNqHZT6tEM5s16LpMHrxxFjkBkknc=;
 b=SaYTZ+wAEj26SnyTrxKpaw8js9euGG42uDOtDJ030pDLFvgeI/50DNjRuXX5R6EOpc
 I/b2gosDzHnlSaddYV9/XOzguAHpFf3XUn9bVNN6BXfMl2dAoGU8dr1DaUKWov+lvvwD
 TiI21uuhJDnS4a977yagdGG8keiUoXDET8wIpCA3XbXMJ/vj487Z7DMwbcuo+yGAB0MQ
 5FURjDFTmqm44RxhBsn/4r1V8t3Sx2GkYt/8UzyLkdgfiJG0VaUhLdOu9Mpsne4oGcIh
 qX0yFXPDpNGGvD+qTNxa81+m6dWms+jNU3qX3qi5LIpLpo/S+Q2YUwbZe9xNGzq/sti8
 v7YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+MBaxSuYP2iPsgvAmJco3+PIr5ykzxanPMvjyn42fnDBq9eQT5+yJwtCAU0hVCySr/+a4wVnhVMnB4Q==@nongnu.org,
 AJvYcCW2uh78SSknZYRkqgIaTasWG0M2dY944m6NNuhrLdS9GN1dNtkFuYAkcEpjdFtdIQ2QOCdJGrkMDys2@nongnu.org
X-Gm-Message-State: AOJu0Yw86iADzD0bHvzV0joPGXmKxRo+8LYhkUpuBZUcsW0OmYj58AjZ
 LSI+Sx/UhKlOFFEkNVaZuy/Sg6gVeyXRjVMMxC5O+xbks2U/4uFe
X-Gm-Gg: ASbGncsLZgA+icKFfjF3tDd6yK/IEN9dxlHoaSdeixHl5sV78yMB34cb6LCMmc7+RMG
 5oWbWVibPA1p0Qrt8Fgbzz65xkb1Id4A97keiZcdtsNK0ZhbJm5Rn1Arp4mn4V2VIg1fAk6rJ6q
 LELLD50bjpR8m96zjTS3UV/OGyr7TMCNZzZQGr2roS9+9uvFcBS4vv6M3aWEO8+gsQLYemybRRQ
 P1NLC9C4TvBBXZhY2yD5PbIbE0GOatN/OjKuKw3xaBAc8s96wvrGIQ=
X-Google-Smtp-Source: AGHT+IHSCRgXEWNGY+daMCS0udyZYBohjZsvuKNdRfhrRu6TMNQsXrX/k9GwwoocnVeM+5nK7Sy5vw==
X-Received: by 2002:a05:6512:3190:b0:53e:1c71:abaa with SMTP id
 2adb3069b0e04-53e1c71abb8mr1806951e87.14.1733397787516; 
 Thu, 05 Dec 2024 03:23:07 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229744efsm209942e87.102.2024.12.05.03.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:23:06 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v12 0/7] Pointer Masking update for Zjpm v1.0
Date: Thu,  5 Dec 2024 14:22:57 +0300
Message-Id: <20241205112304.593204-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12e.google.com
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
 target/riscv/cpu_helper.c    | 123 ++++++++----
 target/riscv/csr.c           | 357 +++--------------------------------
 target/riscv/internals.h     |  44 +++++
 target/riscv/machine.c       |  17 +-
 target/riscv/op_helper.c     |  16 +-
 target/riscv/pmp.c           |  14 +-
 target/riscv/pmp.h           |   1 +
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  47 ++---
 target/riscv/vector_helper.c |   5 -
 14 files changed, 242 insertions(+), 550 deletions(-)

-- 
2.39.5


