Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E909BCCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 00:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9YkM-0001Vl-I0; Thu, 16 Oct 2025 20:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9YkH-0001Sq-UM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 20:55:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9YkD-0002kg-WD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 20:55:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63963066fb0so2813237a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760662495; x=1761267295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vqqychwgb2Pzx8ys2y2WWc8aF93FGZl0ENVVCYrMpFE=;
 b=Ze7+/eoteS7MZ+C2INaZv32res8IvDm2f29aXHga4BHdZwKXpMGWPG7sg/TMiRCFBD
 PnqEcjjfTV3Cnbj0VK126rZQ65e4ILW40Y9UQodTLv2DFs4NLSezhsGt38G0huu4ha/1
 qwYwmbE9XVQFnPPwSYhLx/O2TZY4M5PR6BpPTcr3qzxseGIeuOPr3akob0vl7mFTuhtT
 AbKYqj501dVlRupVYhE3qidYj/OzXaktmYd9Qyb1AtwqGQXSRlFm57ICzUqeamFK8zK7
 k0m3e5RWjXbN+Y0RIXAkNxHJ4trj7up37HINimLFPrP4fNsMpS/q5i5jRxZWTWxTHtkl
 Jbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760662495; x=1761267295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vqqychwgb2Pzx8ys2y2WWc8aF93FGZl0ENVVCYrMpFE=;
 b=vM7wHJZVJ/7GP12OTQaEPTwKFi+Hp5kwGnQOKQtqZHaughn/hsdhKzwG6s6mwYUtzO
 XlMgHh/fnNTeK+BtswAzPXyXeUayeDnlib7s/zyXVUryTNdiKBCTxD0EaijbKDry4U34
 2AA7HAVRJ3GCXfkFXblLyk8uW7mUSB2Ssz8fzSxypEBDGj8m/Wlra1ihH8KHl5u9J034
 0PXua3eG9cY3q1XX2brSOc1/7irIv1bhxaNH+E29XW6A+uHk9aANi4DTLgFSh7SdqOIs
 dfeXkxfDwRPnvU2FWpMqhc2TEn3D40h5ZY2TcKJ6oyH9cjThx/B/5IrsSe/V61ftI2hs
 RC8w==
X-Gm-Message-State: AOJu0YwnfH56IntaraKuItaNTAxwvpPzXPlqAuOFYRrOr3lJ8Btposjl
 H3HXXtkZu3DGMH5iwNWWZ8nmxev/qQmg7P7P8luOefNQy3LjgrjHeXGBYGzxFCXbtEfboRlx4Ez
 VUGUuI2EnhRVsIrqTSxLUNvozEI97v6s=
X-Gm-Gg: ASbGncvMSHAWhLC1gLSW4P79Aa4JUghthOcVE+rVJcOzYHwJqL+v0puYGVAR4fZWE6d
 MEt+U9V+xJE85huWG2tH8ap5wvR7U016Sc8t6MttYWwXHf65O7WKbwb9vNhr9t4PC+KLrrp03lC
 jsEUdWm/CP/GDQtLLt0pvAXyHuHyg1QPQdPqJlrapcMrAUzMkjP7/TjfGLpw/EddHujE6d3hb6U
 su7FVM4s+WEyI503h0FJIUQv7YLQRUIpJ0xxQDqoFVkezx2LxW5rK0h+VaD/TEFuYsFaBhpSwWp
 nZQwZEPuj8FcN0g=
X-Google-Smtp-Source: AGHT+IHqkCOI0Dzpboro1NXxyrBynEKVMiAHmMBnntjYx4ReCKPxwAJ1b1AAZ2Iu/Z4mXne+D/EZVUDnJEkBeXAGUQs=
X-Received: by 2002:a05:6402:5186:b0:634:5db4:8fab with SMTP id
 4fb4d7f45d1cf-63c1f628d92mr1676722a12.6.1760662495419; Thu, 16 Oct 2025
 17:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 10:54:29 +1000
X-Gm-Features: AS18NWBXQeo_sOvHiiiDgzDYBELX14czc25-HmaorqgD8h8uA4UlJTCXCGj6ZWs
Message-ID: <CAKmqyKNCNhRqS+5=sZ0Cg7PcV-ciqxWD4OxJgq1M0RaX8zbgrQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] riscv: Add support for MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Oct 15, 2025 at 11:07=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> In this version I renamed:
>   tests/functional/riscv64/test_riscv64_boston.py
>   -->
>   tests/functional/riscv64/test_boston.py

I get an error when building:

../tests/functional/meson.build:102:45: ERROR: File
qemu/tests/functional/riscv64/test_riscv64_boston.py does not exist.

Alistair

>
> Djordje Todorovic (13):
>   hw/intc: Allow gaps in hartids for aclint and aplic
>   target/riscv: Add cpu_set_exception_base
>   target/riscv: Add MIPS P8700 CPU
>   target/riscv: Add MIPS P8700 CSRs
>   target/riscv: Add mips.ccmov instruction
>   target/riscv: Add mips.pref instruction
>   target/riscv: Add Xmipslsp instructions
>   hw/misc: Add RISC-V CMGCR device implementation
>   hw/misc: Add RISC-V CPC device implementation
>   hw/riscv: Add support for RISCV CPS
>   hw/riscv: Add support for MIPS Boston-aia board mode
>   riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
>   test/functional: Add test for boston-aia board
>
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  docs/system/riscv/mips.rst                  |  20 +
>  docs/system/target-riscv.rst                |   1 +
>  hw/intc/riscv_aclint.c                      |  18 +-
>  hw/intc/riscv_aplic.c                       |  13 +-
>  hw/misc/Kconfig                             |  17 +
>  hw/misc/meson.build                         |   3 +
>  hw/misc/riscv_cmgcr.c                       | 248 ++++++++++
>  hw/misc/riscv_cpc.c                         | 265 +++++++++++
>  hw/riscv/Kconfig                            |   6 +
>  hw/riscv/boston-aia.c                       | 476 ++++++++++++++++++++
>  hw/riscv/cps.c                              | 196 ++++++++
>  hw/riscv/meson.build                        |   3 +
>  include/hw/misc/riscv_cmgcr.h               |  50 ++
>  include/hw/misc/riscv_cpc.h                 |  64 +++
>  include/hw/riscv/cps.h                      |  66 +++
>  target/riscv/cpu-qom.h                      |   1 +
>  target/riscv/cpu.c                          |  44 ++
>  target/riscv/cpu.h                          |   7 +
>  target/riscv/cpu_cfg.h                      |   5 +
>  target/riscv/cpu_cfg_fields.h.inc           |   3 +
>  target/riscv/cpu_vendorid.h                 |   1 +
>  target/riscv/insn_trans/trans_xmips.c.inc   | 136 ++++++
>  target/riscv/meson.build                    |   2 +
>  target/riscv/mips_csr.c                     | 217 +++++++++
>  target/riscv/translate.c                    |   3 +
>  target/riscv/xmips.decode                   |  35 ++
>  tests/functional/riscv64/meson.build        |   2 +
>  tests/functional/riscv64/test_boston.py     | 123 +++++
>  29 files changed, 2021 insertions(+), 5 deletions(-)
>  create mode 100644 docs/system/riscv/mips.rst
>  create mode 100644 hw/misc/riscv_cmgcr.c
>  create mode 100644 hw/misc/riscv_cpc.c
>  create mode 100644 hw/riscv/boston-aia.c
>  create mode 100644 hw/riscv/cps.c
>  create mode 100644 include/hw/misc/riscv_cmgcr.h
>  create mode 100644 include/hw/misc/riscv_cpc.h
>  create mode 100644 include/hw/riscv/cps.h
>  create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>  create mode 100644 target/riscv/mips_csr.c
>  create mode 100644 target/riscv/xmips.decode
>  create mode 100755 tests/functional/riscv64/test_boston.py
>
> --
> 2.34.1

