Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6174BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQgu-0000tY-NA; Tue, 20 May 2025 13:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHQgt-0000sq-6F
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:23:47 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHQgr-000598-4E
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:23:46 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-87bfc9ff795so874241241.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747761822; x=1748366622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=73dnwvJmpiXV1HjI7uGxuEtw4e2T+HxBZsmOkSYPJOM=;
 b=BI2CaL8sYX6d+U5cwNulcIUbnEKe2hSwHyDp8XgGiBsk3BJYFshQhlJBEXFpRI1IZn
 oVIQa0Bw5Lm4i3boJifegkrx054y32KOADcwC39Zqh0Q6k0ZHMoeVpgHeuFoZ9H339b5
 nz6eMtb9uOoxT7J9O0SIM0DX3989unQkBfMp/DKyR92qwaBf+/8HSi59lT1nFNADnYLf
 g6MQHjnw0/c9ZITyn0WgQb40Yh/j4BDltv+hE1Iwa0sQBWzwEnmCwZ1mczXiqlomLwst
 q53aucMHFKx59mu5iqlfYL2paeQsltr+hV9bSBtTZQr2ajyrp101bsxRkPTffBpFWl7Q
 WO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761822; x=1748366622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73dnwvJmpiXV1HjI7uGxuEtw4e2T+HxBZsmOkSYPJOM=;
 b=G4aY2HP3wrIn6woYE1hnrjhlndWCuyevQWEiV47lxsjFRASIgZD+Z6WqDOVV3a7OQr
 3o2q5R/gkLlyOx4JGSxKuTM4RlNZN9YLfgmGpmjENzFcc/puZOCuZyUJRXcWHop/WFSj
 Dg0bcAWwDAyAV9fADxjxYTTzPypQEyz152KAyXkp9hbfDrv4WojjTXM8eq3M/nHKn34e
 67lcvyFJH9V7ebL5nyeCQR6tHMJWU6Z5qds/X2/kF6OKemsLeAeUDH/Q0ISRb7CiadIR
 wW7ckgKqeV2dCXTg4nUbeZ0682Dvkhj4m6sgVpBJ4vkC1GqBqzR97psEH1LGFS8apu7m
 M9xQ==
X-Gm-Message-State: AOJu0YymTOZMN2ZJSqCVZNUlOeHAexZuCR5KgFogXxOq82Qx21Vo7YzL
 xBRGlX3jXrRD/gH+XrgCN+kRPPHsCufAagFOmsmShjyKYzOyGrYDBLG/vJKsjYLworA62SvBkoF
 5PqTY
X-Gm-Gg: ASbGncsmw8HCWdGJEHTJikuasnUlcA1Lm9MuLkBPXBnTwe163NFz2iNnQ7ug6I/qT/H
 ROJodddoujcamApZ4/0TOeTpY+CLblwjKkExa6hheyFPdqozSUd1/p+ryzDI7OMmin5JrsTJfDv
 XbYXafS54tgBAXSecO2p13tkGU1l2S0i9KKIP+iVbbeoFV9aWLp65gvbRysSrrVkYMWE1mJClRV
 Im7B/XxjbSxXbBEBkfrlMg9K0kxnG1cmq9CjPeQC/wgXFqyj/UG5Kmdp1qZplwECEyKrOrM8Wf9
 8WMjXCoGFi5o4XXsA02BOeZL5+YnPbASmnbaf/4+o9xQOworfL0YznFeJ5/gTHKWDeF1Rhtg3O4
 0eRaU
X-Google-Smtp-Source: AGHT+IEL6mMxC+l95+/5BY8TzFsAAROkiu/bNfufQsQzMxc5QaamORT6q8iPCjjdI/1sy3eXSH4hVg==
X-Received: by 2002:a05:6102:e06:b0:4e2:a29d:ecb6 with SMTP id
 ada2fe7eead31-4e2a29ded6bmr6280497137.1.1747761822549; 
 Tue, 20 May 2025 10:23:42 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec155e21sm7698107241.17.2025.05.20.10.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:23:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 bjorn@kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/3] target/riscv: profile handling fixes
Date: Tue, 20 May 2025 14:23:33 -0300
Message-ID: <20250520172336.759708-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x930.google.com
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

The motivation of this short series is to fix a reported in [1]. A
couple of bugs were fixed along the way.

Björn, these patches should remediate the situation you're experiencing.

Patches based on master.

[1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.belong.to.us/

Daniel Henrique Barboza (3):
  target/riscv/tcg: restrict satp_mode changes in cpu_set_profile
  target/riscv/tcg: decouple profile enablement from user prop
  target/riscv: add profile->present flag

 target/riscv/cpu.h            |  15 ++++
 target/riscv/riscv-qmp-cmds.c |   2 +-
 target/riscv/tcg/tcg-cpu.c    | 138 +++++++++++++++++-----------------
 3 files changed, 86 insertions(+), 69 deletions(-)

-- 
2.49.0


