Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AF0C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 20:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s84Ef-0001oR-8f; Fri, 17 May 2024 16:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s84Eb-0001jK-67
 for qemu-devel@nongnu.org; Fri, 17 May 2024 16:31:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s84EK-0006CA-Hn
 for qemu-devel@nongnu.org; Fri, 17 May 2024 16:31:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1edc696df2bso23664485ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715977862; x=1716582662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/otRcnylFD4/SM0G7Gj1/b7/cCpabgU/G8YRbr4Vkyw=;
 b=MKSwnjcQkYj2A45vnNDwypCbN7q+oZpsVhyolx8X1QN8rnAkvuKDwewsQ13lyDxw6n
 2s2fDBNQNq40uVNxKEUCcM9P0vSGBh7ZCnI6iFQ0O5zISf7pbpPtlAwu4LGg+XIKQvso
 n1PjOxAU/W6VOzCy+1oY0cobT2DbckOAhe4j8/WL+wm0JklhWYaVl4mXfjXS0PDBbD/5
 JivdXkln8ew0e6hIF/MvtwSCWrl2qdtwRTQocijceMfaLggb1OFKH6hox+eWIVijRZ+4
 XQmCrperiLfKPXC+u9D8ma/cwCiztnujP2Kjj4Fra7mWdAEWg+cZuTfNY+ked23tvDvY
 cxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715977862; x=1716582662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/otRcnylFD4/SM0G7Gj1/b7/cCpabgU/G8YRbr4Vkyw=;
 b=iGYL0L8JxSmPP2e2kXuEjurKSFEasj0gx+ELQEEc1uIMOzfEA6uXc0CTSm3EXvfF5e
 rlwzXGPeTBrty0M4Wktklo83LpRjWEzS3Qm7kfONQjlQP5k1fJTh9ibocpRBybzOZnrd
 msJPGT7sEwZ9rW2YUklk6U5Pu0ZsldNq8eHqUjLYrWPLxm2lo34CMpazzsTAe6e++IJV
 hhb9BF5NL7F/dsfkA7gkT0FPnX1Bga9oLbJwBMuJmIcZfIp1DKQfljKAZIIj+b/TnzL3
 LWbWKaw59+3kfE+ZWiKquhefCjcoEMDGdIAE5L1ZAlb74INSfrNwuUaW0z76KjaGEpE8
 yOyQ==
X-Gm-Message-State: AOJu0YzTerym28jIlyUDyXku6oVQ15jbAzjigvyoFdlTohXV0JBZDhND
 b2xM4z88rM89HclCC9339mdHAe5U/lYyz6+FSOtAKEd6Ufp9uhnv4NLkwjcaQwqCD8H+cvugAx3
 K
X-Google-Smtp-Source: AGHT+IGaydUr2aCQn49lewBZuhptNFUOeOTPmON/msfNLr9ya83v2ruC/Js4vQUCP1bWEpmbNpXmDg==
X-Received: by 2002:a17:90b:2305:b0:2b1:782:8827 with SMTP id
 98e67ed59e1d1-2b6cc564325mr21263092a91.20.1715977861656; 
 Fri, 17 May 2024 13:31:01 -0700 (PDT)
Received: from grind.. ([177.94.42.57]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62863a126sm17979775a91.5.2024.05.17.13.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 13:31:01 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 alex.bennee@linaro.org, akihiko.odaki@daynix.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/1] riscv,
 gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
Date: Fri, 17 May 2024 17:30:53 -0300
Message-ID: <20240517203054.880861-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi,

In this v2 'reg_width' was renamed to 'bitsize' to provide a bit more
clarity about what's the value type of the variable. It is the same name
used by riscv_gen_dynamic_csr_feature() for a variable that has the same
purpose. The variable rename was suggested by Alex in v1.

Changes from v1:
- rename 'reg_width' to 'bitsize'
- v1 link: https://lore.kernel.org/qemu-riscv/20240516171010.639591-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (1):
  riscv, gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()

 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.44.0


