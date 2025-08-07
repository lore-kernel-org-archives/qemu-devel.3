Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C8BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 18:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk5Sh-0000tV-NN; Thu, 07 Aug 2025 14:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uk5Sf-0000lL-Bn
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 14:35:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uk5Sc-0006DU-7Q
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 14:35:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24031a3e05cso9835395ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754591728; x=1755196528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08xo9BsKaNqnXduZM0h/ZvRtNXdesc62tf2XRbRyNg8=;
 b=kqDttEqiR8sO3qZHj763Z8kIfCHdY5yMx3byjuZrv0UFUd2+K9h4dnE71eCGF3zEZh
 oO3gkEBGwrnKuTh5aevQPn87Dy11oXGDyBCbRc9R1vAMOOIVdN3Gs9q930r5CZ3nhTGD
 fj2pX/M7CSUKerHEbZGTgZc1wbWoJWwI+2Bxe23fMEbK7HxPfSEgtiPwK75bQzgCGK5V
 V+VQPoutFQzljibe2sFoYP5VwYqFc483RJBudNfleGi9wgkvVmtgp/2WrHnqA2k5fXpv
 I0Mf++dOzRnsVi4OZX9jo0iPdUg7BqZqlHXhs4Rm2AM5Q7Cl5KIfGl0GuJcn8KOuISst
 Tx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754591728; x=1755196528;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08xo9BsKaNqnXduZM0h/ZvRtNXdesc62tf2XRbRyNg8=;
 b=KaEqdAErTkkXHlnfk752Gthr0n1f4bTXNfEx5+LkgTz1q1usTLVbXM3J5GB3Yn0zZQ
 n4QlH3s+sPr1RJZZWkIuYAhRosW7bdUFfKighpCRFA7RXiQTl2cv0pvG/30I7DaxTfX3
 /IzUNIXE7nNAw+CQvjs21wnOqa0/B4T1lfM5McmwJuHrdmaTftHgQ9JhC16hCHeVNXfP
 1UX2fUgc/MKu2ndO+dgta3WtI5nBKIiuqF9UBr1jkd4xA5MQLzJ7SOL+4jBo9c1BN128
 KWK6EUnA1DPoULpRU2v0KitUqTv7n7T1JSjnwrCiNxNVx/rMzHEBFwJoj1cvxIVxSA7t
 76eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSceLK62E6QT9v1dGzh0mY1bRjQTadaOGXCjYTprBk2y4SJHT07dnj/nR5QmScJSMq93wAMu9+GqEA@nongnu.org
X-Gm-Message-State: AOJu0YyXwI5mzzTcaVrxwilui310axaMA+l7qpnXw5J7z2EW4TFRjCBx
 NPbYjOafWiQHrXbQsjX49VCSPhK8Ghu+rUqUurH2d82C2/BoUd2qQBlSpivhVsnOGkE=
X-Gm-Gg: ASbGncvb5tXT9TFOA48si/XEHQcwc+sADBw42DhBCAe+iqW7kyqSQlCYQbrvqtvNfzZ
 CYOLzEkgu4ojQN4MJI6b/SaXZHZUIZfG6G9E4TF9rv4wwA3FO3y46PP9Pjz30Bf5UP6IlDQGaHl
 DSc2dREOiEkXVNCwLwYRyf+aavyQW64Nhu9LBIQeUtfvAG9Rr/gyLIy5NPUt+9Vj3tQ8rMISYAc
 toSPtbjkgS5F5iox+7OnAc5TIC+5nxKQ+MGfmLmIPZJk67ZK4UoetJenw9I+RqmnD/ICNzUnp61
 F1QkdBGqhNa/r7u1hVLEqW0gvDmuvMCn+XlUXstfKNhkTZtKcwdsxmNrF+w7+24quDC1sSDRPye
 aveFzp5JPPVBMhNY/0H5yvpVjzaBZMz3LNcnCsw==
X-Google-Smtp-Source: AGHT+IFydHUWH43fj+2wUYLa3I+9L14ZPgfbTIvdz+GZMaVnhXY0NIwlBi+4Fsoo4hm1zQG2ULrqgw==
X-Received: by 2002:a17:903:198c:b0:240:b630:e600 with SMTP id
 d9443c01a7336-242b06624f8mr64149965ad.11.1754591727840; 
 Thu, 07 Aug 2025 11:35:27 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89768a7sm191381895ad.83.2025.08.07.11.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 11:35:27 -0700 (PDT)
Message-ID: <9a305b9e-98b6-4693-84c9-b506bd2b830d@ventanamicro.com>
Date: Thu, 7 Aug 2025 15:35:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

I have provided reviews and acks on the v4 review:

https://lore.kernel.org/qemu-riscv/20250625141732.59084-1-djordje.todorovic@htecgroup.com/

I also gave one additional ack/review in patch 8 in v5:

https://lore.kernel.org/qemu-riscv/20250703104925.112688-1-djordje.todorovic@htecgroup.com/

I see no acks in any patches in this version.

The common practice is to include any reviewed-by/acked-by tags received in the commit
msg of each patch when submitting a new version, letting other ppl know that the patch
was already looked at once. Unless you make changes in the patch and the review gave
before is now invalid - then in this case you drop the tag and a new review is
required.

Unless you completely changed all the patches and all the reviews doesn't apply
anymore, please re-send this series with the acks/reviewed-by tags in the patches.
 From my estimation this series is supposed to have 2-3 patches missing review only.


Thanks,

Daniel




On 7/17/25 6:38 AM, Djordje Todorovic wrote:
> I addressed several comments in this version, major ones:
>    - split CPC / CMGCR into separated changes
>    - split CPS into a separated change
>    - added functional tests for boston-aia board
> 
> Djordje Todorovic (14):
>    hw/intc: Allow gaps in hartids for aclint and aplic
>    target/riscv: Add cpu_set_exception_base
>    target/riscv: Add MIPS P8700 CPU
>    target/riscv: Add MIPS P8700 CSRs
>    target/riscv: Add mips.ccmov instruction
>    target/riscv: Add mips.pref instruction
>    target/riscv: Add Xmipslsp instructions
>    hw/misc: Add RISC-V CMGCR device implementation
>    hw/misc: Add RISC-V CPC device implementation
>    hw/riscv: Add support for RISCV CPS
>    hw/riscv: Add support for MIPS Boston-aia board mode
>    hw/pci: Allow explicit function numbers in pci
>    riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
>    test/functional: Add test for boston-aia board
> 
>   configs/devices/riscv64-softmmu/default.mak |   1 +
>   docs/system/riscv/mips.rst                  |  20 +
>   docs/system/target-riscv.rst                |   1 +
>   hw/intc/riscv_aclint.c                      |  21 +-
>   hw/intc/riscv_aplic.c                       |  11 +-
>   hw/misc/Kconfig                             |  20 +
>   hw/misc/meson.build                         |   3 +
>   hw/misc/riscv_cmgcr.c                       | 234 ++++++++++
>   hw/misc/riscv_cpc.c                         | 239 ++++++++++
>   hw/pci/pci.c                                |  15 +-
>   hw/riscv/Kconfig                            |   6 +
>   hw/riscv/boston-aia.c                       | 489 ++++++++++++++++++++
>   hw/riscv/cps.c                              | 197 ++++++++
>   hw/riscv/meson.build                        |   3 +
>   include/hw/misc/riscv_cmgcr.h               |  49 ++
>   include/hw/misc/riscv_cpc.h                 |  73 +++
>   include/hw/riscv/cps.h                      |  76 +++
>   target/riscv/cpu-qom.h                      |   1 +
>   target/riscv/cpu.c                          |  40 ++
>   target/riscv/cpu.h                          |   7 +
>   target/riscv/cpu_cfg.h                      |   6 +
>   target/riscv/cpu_cfg_fields.h.inc           |   3 +
>   target/riscv/cpu_vendorid.h                 |   1 +
>   target/riscv/insn_trans/trans_xmips.c.inc   | 142 ++++++
>   target/riscv/meson.build                    |   2 +
>   target/riscv/mips_csr.c                     | 228 +++++++++
>   target/riscv/translate.c                    |   3 +
>   target/riscv/xmips.decode                   |  35 ++
>   tests/functional/meson.build                |   1 +
>   tests/functional/test_riscv64_boston.py     |  78 ++++
>   30 files changed, 1994 insertions(+), 11 deletions(-)
>   create mode 100644 docs/system/riscv/mips.rst
>   create mode 100644 hw/misc/riscv_cmgcr.c
>   create mode 100644 hw/misc/riscv_cpc.c
>   create mode 100644 hw/riscv/boston-aia.c
>   create mode 100644 hw/riscv/cps.c
>   create mode 100644 include/hw/misc/riscv_cmgcr.h
>   create mode 100644 include/hw/misc/riscv_cpc.h
>   create mode 100644 include/hw/riscv/cps.h
>   create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>   create mode 100644 target/riscv/mips_csr.c
>   create mode 100644 target/riscv/xmips.decode
>   create mode 100755 tests/functional/test_riscv64_boston.py
> 


