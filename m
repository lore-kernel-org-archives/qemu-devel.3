Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E288D3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLWb-0007I1-NT; Wed, 10 Dec 2025 09:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWG-0007DW-8h
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWD-0003CR-3B
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so45424435e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765378213; x=1765983013; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dGrwiIAtkyLyG5A3/buOqE/Y7JVV5zMf/mdPWC30jdA=;
 b=zSaeDSrpPTSPPnczTA8ty8D7K1wJ6XuqiuyxFu16Xwp2uZiUH6F/9iwMqoajp7Qxq7
 YSVjud98xt1pqVE/YTBPY3hpqLlTMjILb4F3YKimJoie1BAuJr1L57uLIcvIhyblZNCQ
 Q3DDbsR1e0gxMgTbZTzM0NDC8kDMXnm9LgZ1FyfB7u3mfvnjmQQ2t4txD7tcdrOvsAvQ
 pDrZUDjKMyeE9vd2biM+7IstvzVc74XnGGY8flm634iXTONFZuqs4ZpLvrsq/6O6RA7w
 FOdURnBRflxbW0M1MBjhSFrr1JLNklvre9pToUiseIsosDoZVg056nOSWc6zKmLjkohN
 Alqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765378213; x=1765983013;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGrwiIAtkyLyG5A3/buOqE/Y7JVV5zMf/mdPWC30jdA=;
 b=G9MMDY3/qOwYrBECtSMQAvx+d/sDTVRdeirmHoaCe0Mf6lsQiAdvJzUt/WZE0vuuMs
 MuIjRLWQkp4JW6vmorvwp8go/GeuGW1U8+NpKZZ5OAQT5nz+MkdEBgj2ffjkbxAsew5q
 u0y+f5YHwqOPXOZqJGfhQtnmN7N9zKuMn1oy0IU6E69UXLaUIaqEemhxII/YX5vftSmE
 75qCWD1AMOFDS3eh6AYFNbFDgVMUvzeFFTHYvj8qOpySEUFPU79f/ep0da6QAfaVs1V0
 dquFUCRGBQzmFbPCdmNX8SYUMMQxmVfkyguk/hWl8AGaNyflfpvwJoJE2OH7XGTgUvJv
 5HjA==
X-Gm-Message-State: AOJu0Yw9o2qyJBH2qHrif1nROUQIjZMilu+0xZCtjtRh+1Cv+itnxRHe
 SbJgAwTXSG4mG3/zmSfziFn83Y5gN+NNrCN5lJWVX7jgZVdAZm1Fd+aUdcYJC+Xnduo=
X-Gm-Gg: ASbGncs1JLGtx4dJrO97mw4WP1wIC0iWJRI8VSZNaIvq1YbF8U5VSxPfQbWBONfqMYT
 +6DfGXe+Io6FHVwHvuBgtpiPfJ1k0x7d0912K+FLQcGOrni1pYeRwkoEE2wuR5KQ6ijtl1OhpRp
 kPOhZbKu49b6d4MF2pxtJWMdKS+mToDxafCX+FOGvNIID/BfsTaJd5ox0aExuUVhkkq7ZiIBNr9
 Ea55BJV+XPq2YUpClsWYS87OmSIf5bdBDBae3/ofTtLgpmJA2W7syFhbbJz0A3AmM1RAU2/fER7
 vm4PRc/f5uGK6uB42cCw18mrclm76JtUwYVrsjxtgjrFnPmjjGzgQdL9TkMqK9eQq/AuiTTkojz
 BjT/R6jE1Q+IKIDP/7ApzaHSA/d6uk53/mdGpUcKyelC/lTk2VOi1nlZmz90fMLv7aKMI8806ZF
 axnM3UmR0OJGOB2gy1e7lUsRf5
X-Google-Smtp-Source: AGHT+IEn1zWVDBvQR6bK3YpLDmETNGa+K7kIJ1bceZ1eVLhPpcsNvwXlws+cI9VAE1QhJ1g4S4vccw==
X-Received: by 2002:a05:600c:8010:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47a83811428mr29753825e9.30.1765378212678; 
 Wed, 10 Dec 2025 06:50:12 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:62e8:705f:f7a:c7b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7f778sm56595235e9.11.2025.12.10.06.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:50:12 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v6 0/4] Basic ASID2 support
Date: Wed, 10 Dec 2025 14:50:10 +0000
Message-Id: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKIOWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDI1NDI0MD3azcxGTdxOLMFCPdRAujpERjU0MTc4sUJaCGgqLUtMwKsGHRsbW
 1AA7tFXNcAAAA
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

Enable the ID_AA64MMFR4_EL1 register, add the ASID2 field for cpu_max,
then enable writes to FNG1, FNG0, and A2 bits of TCR2_EL1. Any change
of ASID still causes a TLB flush.

Changes since V5:

- Patch 2:
  - More specific TLB flush. Now only flushes the TLBs relevant to the
    written register, and then only if A2 changes.

Thanks to Richard Henderson for advice on TLB flushing.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Jim MacArthur (4):
      target/arm: Enable ID_AA64MMFR4_EL1 register
      target/arm: Allow writes to FNG1, FNG0, A2
      target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
      tests: Add test for ASID2 and write/read of feature bits

 docs/system/arm/emulation.rst    |  1 +
 target/arm/cpu-features.h        |  7 ++++
 target/arm/cpu-sysregs.h.inc     |  1 +
 target/arm/helper.c              | 32 ++++++++++++-----
 target/arm/internals.h           |  5 +++
 target/arm/tcg/cpu64.c           |  4 +++
 tests/tcg/aarch64/system/asid2.c | 76 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 118 insertions(+), 8 deletions(-)
---
base-commit: 9c23f2a7b0b45277693a14074b1aaa827eecdb92
change-id: 20251210-jmac-asid2-a82ba351478d

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


