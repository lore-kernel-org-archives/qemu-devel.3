Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89998E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOVP-00022V-Ea; Wed, 11 Dec 2024 10:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tLOVL-00021a-Vi
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:20:00 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tLOVJ-0007qK-Gk
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:19:59 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53e3a90336eso4460968e87.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733930393; x=1734535193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL4gQ2fEGCLHdGfGn5WYkqO+iCyJSpSvK12PkwjzyPY=;
 b=eO/sb7Y9xogkmAA2ox/BDRZoFV9LdUj32UQxilubRUZIzVao1Ec8SS2j/IzB65CSba
 dEP/8XVkmkuxBo327VhUvjk378nVpsH8lacHCqiuWp0KrbS7tqb8MsAIrI/VykemFQzr
 CZJWga4Bdvop9CF4v8ZsxBKaSJagcwLWt9cnFHSYQegELkcfh+0iaYFhhZafbyFU+gAY
 MX6EBpDDa7NC4gww3RX4kr6sUwpxuTbYOGfCXAm2r0SeHXtBaUdroEUrdGGV4bBOBhC9
 G9KbKw3hb6WsXMu1BcVCTm0QbvM5zdN+Vtz6cRDo+ojuusJiIV6KJcRzf/DJKjgH0Jo4
 AfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930393; x=1734535193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL4gQ2fEGCLHdGfGn5WYkqO+iCyJSpSvK12PkwjzyPY=;
 b=p+gGuomvuXmvNYbqdsQRZFMhSgRla786F7MTuEkzrqpTrRoQ15cS1zF7LoKjzd/OT9
 Kvt3f+NrqHDgzpKWUGvPT41G9yieMOArb1inrtFgpdnNfdcwFRhmLTR6MOQJmnsCiJ6l
 oqiv+uzDzvPrCesG/v8LEjs5u48c7CAY7Lc1mDZ6XpHnIAhwHLGG0ORA5fYh0nIxtegs
 i41QpOwxcTfCGhIBL3iPLU/xP8lcj6YIdltXPTsbScmn2+joUZ0M0V9QxcJoTj/YELrT
 ZuDhjUq4y2mJ4uMxowSv0lt7LxXJ/oQVnvS5LNXzle7M46YDCCj/EPeCnhbWyCT+S0k+
 QY0Q==
X-Gm-Message-State: AOJu0YwIY4Cbm4GsYxTlYEdOWZewISSoKrNcSnSKkmsUJIrXMtJ5U89z
 v5mnJIBd8GDhbP+jYf231M2642ATQ25Y9I6oP8/DuudItcuFsFHLiIg4Vy4v5o1tS9aDYxSslwI
 B12hXyBPFQTuwbX25MAhdVy6G2wR0Im+IGJSxcUCAu/0JSWAJz52MbR0FRK/TGAAR8B4b3oke7j
 rXlqrR3SyXE9GKpZ/GKQRK+z5x0HMalliygM7C3TZcEkNvGb8=
X-Gm-Gg: ASbGncupBR9bJXx+FvDQLVltn7PDw8fUaJAa0OKr6qLiXi9YnRp1UMeBwZTNAqZmcUM
 f1ow5kyQkCYkB9ymGJkPJc0FADRRHbSRulNjlH+SGdh7euSAAGijZsXTyPqMD63ulA9BD9/lHDg
 TIrFBimPlsIJhrZQNVHBU4t7b8p7FPuPGBJDhCOo1y1lAPXp+rxDaDcHJkU/gf/0uhHbNKDisEp
 VJiPEmBidgjaoI3vRcQ0LKz0Cm6ui11bqjdabvN7SbeLAb4F2/Ak80jiUd1gBMc6hXOsOdDEkHK
 5SY3OKMSe8XcVJk3lvM=
X-Google-Smtp-Source: AGHT+IF4KARwDF54ch042fB8IxyidvlCD6qWOtZGaDv/mlevbKVZSD2+1m5+Mitn+678D4orEAyikA==
X-Received: by 2002:a05:6512:1095:b0:540:1b2d:8ef3 with SMTP id
 2adb3069b0e04-5402a609b7cmr1092783e87.52.1733930393131; 
 Wed, 11 Dec 2024 07:19:53 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54019e628a9sm1335617e87.106.2024.12.11.07.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:19:52 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-540218726d5so2963380e87.2; 
 Wed, 11 Dec 2024 07:19:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXVwR0CWqXcA7ZVYtk+j/vMJevQ92/yuarDpvGbQObGSPNHDsjdlJJR4Sn5UoHnO+et4VyjaSqV93Vs@nongnu.org
X-Received: by 2002:a05:6512:12c5:b0:540:1fcd:1d8d with SMTP id
 2adb3069b0e04-5402a60a1b0mr857674e87.57.1733930392090; Wed, 11 Dec 2024
 07:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20241122032217.3816540-1-frank.chang@sifive.com>
In-Reply-To: <20241122032217.3816540-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 11 Dec 2024 23:19:40 +0800
X-Gmail-Original-Message-ID: <CANzO1D0aoM3YH-2FFzs4N7_C7Ev-1WxAqeUgjjYV7=ztdMsBug@mail.gmail.com>
Message-ID: <CANzO1D0aoM3YH-2FFzs4N7_C7Ev-1WxAqeUgjjYV7=ztdMsBug@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Add Smrnmi support
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12a.google.com
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

A gentle ping on this.

Regards,
Frank Chang

<frank.chang@sifive.com> =E6=96=BC 2024=E5=B9=B411=E6=9C=8822=E6=97=A5 =E9=
=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:23=E5=AF=AB=E9=81=93=EF=BC=9A

>
> From: Frank Chang <frank.chang@sifive.com>
>
> This patchset added support for Smrnmi Extension in RISC-V.
>
> There are four new CSRs and one new instruction added to allow NMI to be
> resumable in RISC-V, which are:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   * mnscratch (0x740)
>   * mnepc     (0x741)
>   * mncause   (0x742)
>   * mnstatus  (0x744)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   * mnret: To return from RNMI interrupt/exception handler.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> RNMI also has higher priority than any other interrupts or exceptions
> and cannot be disabled by software.
>
> RNMI may be used to route to other devices such as Bus Error Unit or
> Watchdog Timer in the future.
>
> The interrupt/exception trap handler addresses of RNMI are
> implementation defined.
>
> If anyone wants to test the patches, we can use the customized OpenSBI[1]=
,
> and the customized QEMU[2].
>
> We implemented a PoC RNMI trap handler in the customized OpenSBI.
> In the customized QEMU, we use the Smrnmi patches and the patch from
> Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> the RNMI signal with the qmp command.
>
> [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> [2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v8
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
>
> Test commands :
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> -qmp unix:/tmp/qmp-sock,server,wait=3Doff
>
> Use qmp command to inject the RNMI.
>
> Assert RNMI:
> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi numbe=
r=3D0 value=3Dtrue
>
> De-assert RNMI:
> (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi numbe=
r=3D0 value=3Dfalse
>
> Changelog:
>
> v9
>   * Add Zicfilp support for Smrnmi.
>   * Change the existence checks for 'rnmi-interrupt-vector' and
>     'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpve=
c'.
>   * Add warn_once messages for cases where the user sets
>     'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
>     enabling Smrnmi.
>
> v8
>   * Set virt to false when trapping to M-mode by RNMI.
>   (Thanks to Cl=C3=A9ment for the suggestions.)
>
> v7
>   * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
>     checking codes.
>   (Thanks to Cl=C3=A9ment for the suggestions.)
>   * Add the missing REQUIRE_SMRNMI() check and remove the redundant
>     check in 'helper_mnret'.
>   * Rebase to riscv-to-apply.next.
>   (Thanks to Alistair for the suggestions.)
>
> v6
>   * Delete the redundant code in 'riscv_cpu_do_interrupt'.
>   (Thank Alvin for the suggestion.)
>   * Split the shared code in 'helper_mret' and 'helper_mnret' into a
>     helper function 'check_ret_from_m_mode'.
>   (Thank Alistair for the suggestion.)
>
> v5
>   * Move the patch that adds the Smrnmi extension to the last patch.
>   (Thank Alistair for the suggestion.)
>   * Implement an M-mode software PoC for this with implemented handlers.
>   (Thank Andrew Jones for the suggestion.)
>   * Add a commit message to all patches of the series.
>   (Thank Andrew Jones for the suggestion.)
>
> v4
>   * Fix some coding style issues.
>   (Thank Daniel for the suggestions.)
>
> v3
>   * Update to the newest version of Smrnmi extension specification.
>
> v2
>   * split up the series into more commits for convenience of review.
>   * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
>
> Frank Chang (1):
>   target/riscv: Add Zicfilp support for Smrnmi
>
> Tommy Wu (5):
>   target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
>   target/riscv: Add Smrnmi CSRs
>   target/riscv: Handle Smrnmi interrupt and exception
>   target/riscv: Add Smrnmi mnret instruction
>   target/riscv: Add Smrnmi cpu extension
>
>  hw/riscv/riscv_hart.c                         | 40 ++++++++
>  include/hw/riscv/riscv_hart.h                 |  4 +
>  target/riscv/cpu.c                            | 18 ++++
>  target/riscv/cpu.h                            | 10 ++
>  target/riscv/cpu_bits.h                       | 24 +++++
>  target/riscv/cpu_cfg.h                        |  1 +
>  target/riscv/cpu_helper.c                     | 96 +++++++++++++++++--
>  target/riscv/csr.c                            | 82 ++++++++++++++++
>  target/riscv/helper.h                         |  1 +
>  target/riscv/insn32.decode                    |  3 +
>  .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
>  target/riscv/op_helper.c                      | 54 ++++++++++-
>  12 files changed, 342 insertions(+), 11 deletions(-)
>
> --
> 2.34.1
>
>

