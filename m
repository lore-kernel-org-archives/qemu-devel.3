Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C742DC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs9a-0005Wt-JG; Wed, 04 Jun 2025 13:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9P-0005Ug-JS
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9N-0004Ah-HU
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so155746b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749059020; x=1749663820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I1II+3YQnG90HksUR5dl1/2JKfZzGM6a2Go/eJtjLcU=;
 b=IJxBcksJFgCqbuIlHjMfFqrzOLXEFWWLkz89p9uV5DC9tSr8KodR+uPWxg/Yh1kfsM
 KtABKdd41LlClbdpqq6JBkoPtnqAxbPg6414lF+X93hCASvVamglwfX5nbwC8FRKGJwk
 byXuRtnwtOvYOTyIuZDem6/WT2EhlbhulZKM/z8UvV9OhNk4ZUkpEzrKxIRnc6qAH/s+
 iiW5yodgV6acznXw+OwRA32DIT5Hws/OKRJtYwNMqAFuqVpiyCGgToojrigFyp0le3a1
 /OhOmwYhS4at3FgA3Pm+uxiW4CiP0My5MuDYsPOre2cvz5qKNc1brjm5vW49fN3ZSN5L
 DgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749059020; x=1749663820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I1II+3YQnG90HksUR5dl1/2JKfZzGM6a2Go/eJtjLcU=;
 b=NJox0EUbwl9usTOA4T/BRqlL4pCXAJv1ysKzMYC0dbgPgGg62KfRNFsYyifV/iIHjG
 gKjFM6cQHo5pRGaF6pJvzlo0x++epoajnRYv5w2gtO7UINXbpdMQuknrmJHxIwgz305P
 zH7pM/8ZLCbN1QtamnSTQ3Q380fMhTP9uEIbQqbnXFoBlZPDV168BsxXV9mr9xJbgy28
 wPNyfHDSDD72LFZ5dRcjYRRbGISHlIrp+Q/2sPKz8uEPfICf4xdPJzgmf0E5K2/VW5qO
 aai1YGdgycOyqlIFgf7uEq3X+0Wb0ywwNs7M87KD5ZDVUoM6sqozINuWjjiWw7jwsc+T
 gUIg==
X-Gm-Message-State: AOJu0YzYTDfvAlbnUk9quhFPoE+4ySqFzhTMZwTcfrgublmF1DuMiv5b
 TazAa+VjMpNdZw8pcsrNofflx6q1rdsT5eVgBK/zSkZk/xXvqNltbltHixhy0qyAFbvWkhXCkNE
 UY60G6aZ6OA==
X-Gm-Gg: ASbGncv/y4XQ8iet4GXZv+LpOXuJph2DKhOj+gbkAdzu1FFegvjtcVJ6zyfPmDHn7P/
 l+JQKibg/uCgrt0jbRz8BHuvXZO+B2zP2nx8FSpQDXyDVIJ3aW8jmyjYRG1EGcGvPdNIHqDR0Bn
 D84BuOgIm5WTvoUwUCIU9NopUs+amsxIjxFZA1KQSAjcsH076nMd7lnhbM4RCKNaXXzgJD+gTZ/
 jeImUt0jdd0szfn3QgAPaGamq1WrXv0A4PJGib73t9StdXA4XFkdGruTVOUibqsHekwZZX2LQ5k
 +qaX4LX4NqYmvSiDerkKs3LoD2cU2CrvGBUMwmDJhLRQoDrtYOyMnlgnTHieCfB3bTwvyAoAoGy
 mwTZpBCEyDSBQswA=
X-Google-Smtp-Source: AGHT+IHqtgoICqVAuvq4Ca0rxlMh3OSJolAgEZpAIkxQFIzjMJ1H4ssElrc+LOrrNn4k5JHCxuOtuA==
X-Received: by 2002:a05:6a00:14ce:b0:747:ab61:e4fa with SMTP id
 d2e1a72fcca58-7480b4972bcmr5356255b3a.14.1749059019869; 
 Wed, 04 Jun 2025 10:43:39 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab109sm11418482b3a.40.2025.06.04.10.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:43:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v2 0/3] target/riscv: add missing named features
Date: Wed,  4 Jun 2025 14:43:26 -0300
Message-ID: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x443.google.com
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

Hi,

In this version I fixed the problems caused in bios-table-test qtest by
patches 1 and 2. 

A small change was also made in patch 1 to avoid spamming "Disabling
sdtrig due to priv spec version" warnings when running vendor CPUs
with priv spec < 1.12.

Patches based on alistair/riscv-to-apply.next. 


Changes from v1:
- patch 1:
  - skip the warning and disable of 'sdtrig' for CPUs that have priv
    version < 1.12
  - update bios-table-test
- patch 2:
  - update bios-table-test
- v1 link: https://lore.kernel.org/qemu-riscv/20250529202315.1684198-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (3):
  target/riscv/cpu.c: add 'sdtrig' in riscv,isa
  target/riscv/cpu.c: add 'ssstrict' to riscv,isa
  target/riscv/cpu.c: do better with 'named features' doc

 target/riscv/cpu.c                |  16 ++++++++++++++--
 target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
 tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 416 bytes
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.49.0


