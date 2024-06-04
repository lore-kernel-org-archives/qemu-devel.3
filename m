Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAB4C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZ8-00074k-4M; Tue, 04 Jun 2024 02:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZ6-00074S-OC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:36 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZ5-0006dE-0N
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:36 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c1b9152848so3511329a91.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717482153; x=1718086953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AYJOqluW9kRRjRspteLZ2Grfhfy2Xvd2NA37If9Xfwg=;
 b=BSIbkLxqzdeuDS8TcA7lw7QSUUgz6xJVwZ1YVwUJhWsaiX1GMZw8PT+tfakEr5/9Jl
 DsrbHkE0g/kt8MRvmRKEDzognRZYCIJKjCQbybD+Lmc0J83mxa3LhZzNwzBiUegshI6x
 inXwykhwj2j6aFUewfxbsOCh533MH7KQ0RJZKeNXTI/CY00lDmnIO+8eOQqaSn94PLgy
 yLT45pOAmLwDwxd2kwMqm1CqNHCajpQBz5S4Ylg00nSDgP8TrpfXc3kL9v32UMbfqKyz
 zwuk9D5biSkeGONGjPjivaOsP7cCa/azGh4vr/7qsAmOVcEw2S/V5j7JIPkoW0FNd9SI
 vLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482153; x=1718086953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYJOqluW9kRRjRspteLZ2Grfhfy2Xvd2NA37If9Xfwg=;
 b=TDDQHfMu5jh72sdpdCXVhnFvW67VF3XF8Se0RhmJN59ziKeBj1nr0kisuKY39WhcHN
 kGnHcfaoo0OFPipqOjJHvm50jqYPcW8scY3HQRIJ/iJIiAqbRVOYLeiMfGxTgFMvtKrh
 E7diCMHAeEzNSqZ5Im0MDW4tprj5OVAUjwizuReWIwdUKCCRxomhJvBwdt8HIHCuGuQ9
 pnRY65w2s0jpMoHnI6V/3GGUC4DF34DWUWI4crz0A5Zh9zp7Fulq/dBq8kdHi8WUDC7F
 adUZBlyEXZy//TNMbaW+Usc+Uyla6b2mcF/76jVNgMNGpOMqLhxivMJvQU0kHClM8IEj
 Qg+w==
X-Gm-Message-State: AOJu0YypxFN1/bDlKvjObkuHAL6nJu2AC4qHG0uVcZC3JmcXBJw1txZ3
 CyALFcNh9kyNc+90zuwQ30VYFvuAdXKmK/x2Dj2JAj14eOrBbkT+Gkjy1S4mUeieFjh7D0KyMmV
 HI0Zl+BIYdCIeZZ/pS/+2EAvj9RtmQCuWv0Qg/dwnYwi8a2ZwH+Cp2UWMhIUKgpykG1burIcgCI
 r4t1lLEsXS8XU0WflDQn+ygXKOrPH7Z9Y1fks=
X-Google-Smtp-Source: AGHT+IGM/ib7vD1G+8iv5tlP4FKHp7AJOuV2LNmSE3hPCDbrl0JXOrbjWol0FpBB8kTy9778BSzA7g==
X-Received: by 2002:a17:90b:30cb:b0:2bd:e806:49dd with SMTP id
 98e67ed59e1d1-2c1dc5608dbmr9220135a91.8.1717482152900; 
 Mon, 03 Jun 2024 23:22:32 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1dcb56014sm7115617a91.25.2024.06.03.23.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:22:32 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v3 0/6] target/riscv: Support RISC-V privilege 1.13 spec
Date: Tue,  4 Jun 2024 14:27:41 +0800
Message-Id: <20240604062747.9212-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=fea.wang@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Based on the change log for the RISC-V privilege 1.13 spec, add the
support for ss1p13.

base-commit: 915758c537b5fe09575291f4acd87e2d377a93de

* Correct the mstateen0 for P1P13 in commit message
* Refactor commit by splitting to two commits

[v2]
* Check HEDELEGH by hmode32 instead of any32
* Remove unnecessary code
* Refine calling functions

[v1]

Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72

Lists what to do without clarification or document format.
* Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, implementation ignored)
* Added the constraint that SXLEN≥UXLEN.(Skip, implementation ignored)
* Defined the misa.V field to reflect that the V extension has been implemented.(Skip, existed) 
* Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches)
* Defined the misaligned atomicity granule PMA, superseding the proposed Zam extension..(Skip, implementation ignored)
* Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed) 
* Defined hardware error and software check exception codes.(Done in these patches)
* Specified synchronization requirements when changing the PBMTE fields in menvcfg and henvcfg.(Skip, implementation ignored)
* Incorporated Svade and Svadu extension specifications.(Skip, existed) 


Fea.Wang (5):
  target/riscv: Define macros and variables for ss1p13
  target/riscv: Support the version for ss1p13
  target/riscv: Add 'P1P13' bit in SMSTATEEN0
  target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
  target/riscv: Reserve exception codes for sw-check and hw-err

Jim Shu (1):
  target/riscv: Reuse the conversion function of priv_spec

 target/riscv/cpu.c         |  8 ++++++--
 target/riscv/cpu.h         |  5 ++++-
 target/riscv/cpu_bits.h    |  5 +++++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/csr.c         | 39 ++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
 6 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.34.1


