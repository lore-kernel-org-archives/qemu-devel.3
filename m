Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8058C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 17:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryxFU-00080H-Lm; Mon, 22 Apr 2024 13:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryxFT-0007zq-7O
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:14:35 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryxFR-0006C0-Iq
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:14:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso38642675ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713806071; x=1714410871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OwefXEFArCHKLkFVa0n5v/m51eouslASReGnJ0FiABo=;
 b=jM4pi/BwDiy+tlbmbR0TMiJ6U7sS7GBvmGzIXBkZLbVapMqmScfAH1yuY3JhkWVoZS
 lb/6WkUWUes0yFX8vxAiL1h8iDR1mY+aMVWo3ixgG5FcJlvY7C1ETEGYSMkeS5i5cC6H
 ms5/tYT17JOkBL0BF2AJ8TimBHuKQUWnv3cHWtoYx++QcbSb7PuhQteGFGdT4PFUnqdU
 BuB3eo6MiHQvi8qmieF8qjRiSfdP7Yr9RyPP3wAppFN6owoX3X529HSYH/qbr+Jzsz2B
 7a0cUVYy8M+Xs3HRE30b58AMZUjdId6eb+SWkcNS+r2IASHkLyX1uTeNvf8tzv9efsKw
 TAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713806071; x=1714410871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwefXEFArCHKLkFVa0n5v/m51eouslASReGnJ0FiABo=;
 b=KAw4jg3kk0G4xYFJ7PMGKLICRG7J1YAeazCTPkSryDhe66ZAGetewGfeSUT1xB8AlX
 24Xp/KbMNTnOVb7d5SmLgjFA/Hbg4HQC2T942EJoIf5hdWIeSI1xhdTNcW8Q45yEz8Zb
 gnK+76dvieJ+L24cOru6ALDdd+RFPBhJ6Yl8boGJ3ha7PwtqUQnJJ6x74txq9jE0aQbV
 uT6rJn0XBxm2ezVUq1x3NsGRlSZBLKpPLkj1LlYfZwnys0Vk0UT9Ou90QauAgIwcfgLi
 GYYis3qUkpOpO5mVBCoIBEuB7ycaCeN26s47+WohxJs48NDxmzJVPwwK1LijWozya8SL
 7vfw==
X-Gm-Message-State: AOJu0YxhKAagM4Zd0aUchZHhopdORA7O+LmX0XCVmtMhbjRQAN74tIWS
 pwxi9SaKeNvdIk2pNlCMK8K1+gtAAyk+ay99/adzXcGnn0K5zcE9QyCIyZZBXW3I0dcPowcTgb8
 5
X-Google-Smtp-Source: AGHT+IHiTxRVGRD0cYyPFqh+0eLV7z3Lx1jmCy/UnkuOOfaBk3NPOpSBdr7Vd2o4vH+cW9CMrHjyhA==
X-Received: by 2002:a17:903:228e:b0:1e3:ca5a:2d9a with SMTP id
 b14-20020a170903228e00b001e3ca5a2d9amr14335988plh.53.1713806071415; 
 Mon, 22 Apr 2024 10:14:31 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 i16-20020a17090332d000b001e0c568ae8fsm8326613plr.192.2024.04.22.10.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 10:14:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/1] target/riscv/kvm: tolerate KVM disable ext errors
Date: Mon, 22 Apr 2024 14:14:24 -0300
Message-ID: <20240422171425.333037-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In this new version we changed the commit message a bit and we're now
only handling the case for EINVAL. Both were suggested by Drew in v1.

Changes from v1:
- added an extra paragraph explaining why we're throwing an warning
- changed the warning string
- warning is now being thrown only if EINVAL is returned. We'll keep
  erroring out otherwise.
- v1 link: https://lore.kernel.org/qemu-riscv/20240422131253.313869-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (1):
  target/riscv/kvm: tolerate KVM disable ext errors

 target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.44.0


