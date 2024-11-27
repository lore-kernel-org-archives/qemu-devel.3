Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A33D609A1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAiA-00066q-SG; Wed, 27 Nov 2024 00:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAi7-00066T-K5; Wed, 27 Nov 2024 00:35:36 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAi5-0000iu-UD; Wed, 27 Nov 2024 00:35:35 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53de84e4005so2393999e87.0; 
 Tue, 26 Nov 2024 21:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685730; x=1733290530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QytoZ0TK5U4qN9PucTCqslMUpou6AOWFOTy698mfJmk=;
 b=Idk/6+7v5VQy2Shjb/9iZlTR1B+CeVpUe0SrHbqnCOl3DbFpy6TrBZVNlgT6Y48brm
 qTKm0C711GXmf5skDx+VKZpJkGc8cxVVnJOo3SjLCknpD9yHWD8vlORZWl22mFoh2uJM
 F4mwtYSDJSH/CrximNjU0cXmK88tBxANkWegxTgFuYgk3+fKEfH+ox8VIVmyEo/sPIuH
 vQiKbKReLRoEPkNNY+4ojzCRdhmBKAYmE3cjwXO8d3Wsea49AFDkcloIvpjQ4r5pG0Gg
 PcjnhG3N1+xL261ZznaEQZ396KGLn/N7gr9+keSOGtcOXdOfaoQmQGfK5iR28LXEwqxy
 Y3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685730; x=1733290530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QytoZ0TK5U4qN9PucTCqslMUpou6AOWFOTy698mfJmk=;
 b=xPnEMQdMpFURMYXAq8o7mL4TMTAdwBpxcsyRff6AHUxpRj1ZxJq3nCZNhS3fDm//4O
 NjuGznDs034MPaKxhgKH2KAAOmP4K1JmO5SppdYhnxv1hDTg8Ooz77YN4EmRyc2F1yPg
 psPCP+5e/7z4SGodD5igbLxUQvcsjlM8tgDAK1hDnDjGS48eQN1MmJqNXH2BskVtsA6s
 0RFiydDv6L3ahR91Nde5s049bhSL7uHG5jtrSearM9EVYdQhPeHwy+8hyygX/oWvJXD1
 FuHVAYfeMLjKpaxtv6FQVuKQ6S4rkS0m11LAE9PaNwAcsENRbvwYjY/qICzV+A2XNi6y
 0Uyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Krl3dUlXO/kBcoJCOTJWEiaIrVPxmgWxKhx27bmkoqMklW4rSVeq50EXYjXJDJ5G2h/dw8XHPBQl4g==@nongnu.org,
 AJvYcCXens+uOwZ/SvSmcFvMDiymkCEK6XjZhJLFM565jlTsC0Un1qZBuanqc39BiyAByhhzprzDlYVqmCJs@nongnu.org
X-Gm-Message-State: AOJu0YxCM+XmIxWTpDbuJZxyvxX7lXo5RaW9bKHKSBn00BC5QnMppVP3
 pdal/5D7FzODG6f9e9rfrs30ysHNGo4qDDm3nc82TpEEP9vVRVhO
X-Gm-Gg: ASbGncvUwFjaCI9bO/mMsWaKtZQWUZQbbNoxlyhippYSssDJSbQ97tDfl1LNdIt8wIk
 qymzIKx+m/AdzMjzhoIJx0PVJ66FuBatHrCgyKSpcvfUJNGVKBwPDtKBeOM3QsReJh0u9G8Q38M
 xBER7Slhr5Y/yttTDGzUdAKTZWsN1/+6XXY66DXXLelCDAUwPCN8043DcWP7iulQ53gmY16RuT0
 NqHbzzrCW+aMCL7ugIDEwvFu7H24ef8MzlKN6hKme+tEPun2nnRTUM=
X-Google-Smtp-Source: AGHT+IHuCq/pEdpPvEgLdQS+TxLu9+k9ppiPE4Gb4ebYzD7TcukxSQiJsSk3u+XK91P6rZURgo/myg==
X-Received: by 2002:a05:6512:3d26:b0:53d:a556:52a7 with SMTP id
 2adb3069b0e04-53df00de5c6mr784698e87.34.1732685730247; 
 Tue, 26 Nov 2024 21:35:30 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53de0c3ce8bsm1211799e87.116.2024.11.26.21.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 21:35:29 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v11 0/7] Pointer Masking update for Zjpm v1.0
Date: Wed, 27 Nov 2024 08:35:16 +0300
Message-Id: <20241127053523.397378-1-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12d.google.com
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


