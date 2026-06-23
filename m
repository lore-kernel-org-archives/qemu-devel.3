Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC10DCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4pX-0007yE-Fz; Tue, 23 Jun 2026 13:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wc4pT-0007xg-D7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:22:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wc4pR-0006Jq-0Z
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:22:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso131099a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235347; cv=none;
 d=google.com; s=arc-20240605;
 b=OiMLsBkvPCniV0IhmhafEXBK9MfYY9nIxAaauIi7W7v6u+SDOGtjH6Z7LFyshStJUe
 i12tkl/7DSzBneycXY1NFwH3QXHxMyEgbdS+kuhfcIzZiU+23IabX56onF8ltSGS+EVj
 4SN6VMOm+uvEGStjlJAS8cAJEQyKzoOF/z2HU+O9nucZSm4jrzDlt/qmTGkwo9golCTO
 eJyk+jPFD9UuauSEL3YjYfsoUtdA4uXVXBZoVAzSmBaazW79NTQmZd3n+tfmdoxLcr3Q
 D18/GIuvn9YmJeFdapOV1l4V4ZTUvkchJrJiAc+ww2sKrA52Gz+/Ghtk2lC/P0Z47We6
 47Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ljQpKTzqpJhc7uJsLD0cbr8JfxVlGc696DzgXbbabog=;
 fh=MRZUNMWuv1kFuqQ9+hXt1nBjxFVEdkK9q0n91tRksII=;
 b=dcA7Vbhox0t4uFXN+/CCdODQ5rEojIXEC0xzh5x27X23JIFB3qyYn1fItezEaDvPIX
 3WnbcmOyG7qCHSBDTPhLWS8BMQvep8qWMHuUbsLASotyJUJgfmycbnkf7hn05ezr2LX0
 yV5qTaPORSGiAW120dWzgyEV0X8o/rYE1dylmW4ewmn+XXo1wxBXRWmFrQJaK/nzFgDh
 cbBIe8RH6yqKllZjYYUSlMCulXfeAsucqa+/peawd2VEnEukpb+d/N1pHIVfhGjZs/3A
 i6+1sAcsQ7L0wbZsmtHIEaUUY6nSJhcXtBDZ58+4a1H3Qi6RhFG/sPSt5badNYZ+NtxB
 MEUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782235347; x=1782840147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljQpKTzqpJhc7uJsLD0cbr8JfxVlGc696DzgXbbabog=;
 b=Yy38udWRbbfT+U8yQxQJBuhFvjuaEMK1gWllGnnA/igg4c9+jqZ9ohrxtHH1O/e9yd
 MYUE0vCl0zEBKIx8VaTx2aXV6DLcjqJWCg0YQiby/xSh7VdrFZnGM50khbPjZdUDhXsL
 vCk5Reg4BkHRq93WkyyHwnmX6+hyFyfK50s1zyJ2CVOFeUSuPJLqdamiKkhTY61T4ROe
 +WhRPIX3bYknZAe+J0GxGGczYyo8qXOdreiSMBPwQecvnPgvfo+2GuSmZcngDNSidrPS
 /y2JaypFIBx60AEdnBsOvwwYAc4hXCWxkgNpsr9xHaWBpOjB/ATwtrH7gsUJwZnbEMLu
 iaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782235347; x=1782840147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ljQpKTzqpJhc7uJsLD0cbr8JfxVlGc696DzgXbbabog=;
 b=L2CkTh+BbsBVi+Wa2tgj2ck7H3ChPko9DP1OOJ7oCbWrRMP68XRVruCE+RH+96RyAU
 no3paw7xo15nSlHUCUERGMVTH+xfRgkXubUaHfPWx89/Z1KouCvIX6OpflIB4hHCt9Vk
 cvajjQAqMJqqkTg9EGxnns9ySzxOektP7G3Lz8a2IhHIFTzJd31aWc1354cekcVeq+t/
 bCmhqlOipShopJHsjRsYyCnaZKX0rD4SXjlPwhIZx1Y2cOuquHAeJ93ZpU0V6GrEcTEM
 PCEU1uuRwyTYmvj8NB/OhFPlq7tfH/DyRaYaA30bRu/lse6jU7bD8Et5PiDYJRDqU+Hv
 SkzQ==
X-Gm-Message-State: AOJu0YzPGL8JwUgLIcz4g2h3RrT7rmW1u+1/fFUO5UuhjZJVyYC2zRL4
 DTZCfjUiDHVfrrJ2Z+j79yp0om9+8MgVe6PBdEglKkkYstCZCjhBIBEB0S808uqUlFeKPdFN3GM
 yB3FxtxNfrBk/VoUiJPyqUcwh6wvm3+I=
X-Gm-Gg: AfdE7cnh/UStuj8AHVKC/aGXozFrmRb41YaUTA7Uz1DOrC/L1dYsH+bKzLz6QEjKrFJ
 JIpRLVyPtjd8tzZUAfkUkFluWeBwHnXXHaO9F1Nq9QBtHa3vZ+XHPn4iueM2sJEYS1Q0w0nB8Fe
 OYymjoU/LM6eqmwdbfwjMJB72GQsfGUKTz+f6VPwKNCKEPnsx/IYE7IfXUfFcfMO3X0RrGkj51t
 8yJP/RpI3SMz2H27DL6xeFb+zblL3JDo9dabeG6ZDkeFQgYuKBrPrHxfPZNBwIrb+II9TNx4gN+
 G7TcVTFkhmUgEgMONnKMfkf3HA7a7o8=
X-Received: by 2002:a05:6402:35d4:b0:697:de91:1de9 with SMTP id
 4fb4d7f45d1cf-697de912372mr2086945a12.26.1782235346525; Tue, 23 Jun 2026
 10:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 23 Jun 2026 13:22:13 -0400
X-Gm-Features: AVVi8Cfj7BWd_2sVzhJS8jEfYBMGcmre7NNU3Ce5xYG6WspBevquivtnml_5K6Y
Message-ID: <CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com>
Subject: Re: [PULL v2 00/75] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 22, 2026 at 6:33=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5=
fb:
>
>   Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qe=
mu into staging (2026-06-19 15:00:01 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/qualcomm/qemu tags/pull-hex-20260622
>
> for you to fetch changes up to 4f876e63daaa40bea293c2eeced2ac6418b3d13a:
>
>   target/hexagon/idef-parser: open input file in binary mode (2026-06-22 =
14:30:23 -0700)
>
> ----------------------------------------------------------------
> hex queue - sysemu
>
> v2 PR: Fix for wasm build error in `target/hexagon/meson.build`:
>
>     ../target/hexagon/meson.build:285:47: ERROR: Program 'emscripten' not
>     found or not executable

Hi Brian,
There is a wasm build failure:

Run-time dependency libffi found: YES 3.5.2
Program scripts/decodetree.py found: YES
(/builds/qemu-project/qemu/build/pyvenv/bin/python3
/builds/qemu-project/qemu/scripts/decodetree.py)
Program ../scripts/feature_to_c.py found: YES
(/builds/qemu-project/qemu/build/pyvenv/bin/python3
/builds/qemu-project/qemu/gdbstub/../scripts/feature_to_c.py)
Program flex found: NO
../target/hexagon/meson.build:294:8: ERROR: Program 'flex' not found
or not executable

https://gitlab.com/qemu-project/qemu/-/jobs/14996902150

See `make docker-help` for how to run test-build locally in a
emsdk-wasm64-cross container. The ./configure arguments are  "--static
--cpu=3Dwasm64 --wasm64-32bit-address-limit --disable-tools
--enable-debug --enable-tcg-interpreter" (I got this from
.gitlab-ci.d/buildtest.yml).

Thanks,
Stefan

>
> ----------------------------------------------------------------
> Brian Cain (72):
>       target/hexagon: use cmd_array() instead of get_id()
>       docs: Add hexagon sysemu docs
>       docs/system: Add hexagon CPU emulation
>       target/hexagon: Fix badva reference, delete CAUSE
>       target/hexagon: Add missing A_CALL attr, hintjumpr to multi_cof
>       target/hexagon: Handle system/guest registers in gen_analyze_funcs.=
py and hex_common.py
>       target/hexagon: Suppress unused-variable warnings for sysemu source=
 regs
>       target/hexagon: Switch to tag_ignore(), generate via get_{user,sys}=
_tags()
>       target/hexagon: Add privilege check, use tag_ignore()
>       target/hexagon: Add a placeholder fp exception
>       target/hexagon: Add guest, system reg number defs
>       target/hexagon: Add guest, system reg number state
>       target/hexagon: Add TCG values for sreg, greg
>       target/hexagon: Add guest/sys reg writes to DisasContext
>       target/hexagon: Add imported macro, attr defs for sysemu
>       target/hexagon: Add new macro definitions for sysemu
>       target/hexagon: Add handlers for guest/sysreg r/w
>       target/hexagon: Add placeholder greg/sreg r/w helpers
>       target/hexagon: Add vmstate representation
>       target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
>       target/hexagon: Define register fields for system regs
>       target/hexagon: Implement do_raise_exception()
>       target/hexagon: Add system reg insns
>       target/hexagon: Add sysemu TCG overrides
>       target/hexagon: Add implicit attributes to sysemu macros
>       target/hexagon: Add TCG overrides for int handler insts
>       target/hexagon: Add TCG overrides for thread ctl
>       target/hexagon: Add TCG overrides for rte, nmi
>       target/hexagon: Add sreg_{read,write} helpers
>       target/hexagon: Add representation to count cycles
>       target/hexagon: Add implementation of cycle counters
>       target/hexagon: Add pcycle setting functionality
>       target/hexagon: Add cpu modes, mmu indices, next_PC to state
>       hw/hexagon: Declare hexagon TLB device interface
>       target/hexagon: Update TARGET_PAGE_BITS, stubs for modify_ssr/get_e=
xe_mode
>       target/hexagon: Define f{S,G}ET_FIELD macros
>       target/hexagon: Add hex_interrupts support
>       target/hexagon: Implement {c,}swi helpers
>       target/hexagon: Implement iassign{r,w} helpers
>       target/hexagon: Implement start/stop helpers, soft reset
>       target/hexagon: Implement {g,s}etimask helpers
>       target/hexagon: Implement wait helper
>       target/hexagon: Implement get_exe_mode()
>       target/hexagon: Implement hex_tlb_entry_get_perm()
>       target/hexagon: Implement software interrupt
>       target/hexagon: Implement stack overflow exception
>       target/hexagon: Implement exec_interrupt, set_irq
>       target/hexagon: Implement hexagon_tlb_fill()
>       target/hexagon: Implement siad inst
>       target/hexagon: Implement hexagon_resume_threads()
>       target/hexagon: Implement setprio, resched
>       target/hexagon: Add sysemu_ops, cpu_get_phys_page_debug()
>       target/hexagon: extend hexagon_cpu_mmu_index() for sysemu
>       target/hexagon: Decode trap1, rte as COF
>       target/hexagon: Implement modify_ssr, resched, pending_interrupt
>       target/hexagon: Add pkt_ends_tb to translation
>       target/hexagon: Add next_PC, {s,g}reg writes
>       target/hexagon: Add implicit sysreg writes
>       target/hexagon: Define system, guest reg names
>       target/hexagon: Add k0 {un,}lock
>       target/hexagon: Add PC to raise_exception, use fTRAP() helper
>       target/hexagon: Add TCG overrides for transfer insts
>       target/hexagon: Add support for loadw_phys
>       hw/hexagon: Add globalreg model
>       hw/hexagon: Add global register tracing
>       hw/hexagon: Add hexagon TLB device implementation
>       hw/hexagon: Add machine configs for sysemu
>       hw/hexagon: Add v68, sa8775-cdsp0 defs
>       target/hexagon: add build config for softmmu
>       hw/hexagon: Define hexagon "virt" machine
>       tests/qtest: Add hexagon boot-serial-test
>       target/hexagon/idef-parser: open input file in binary mode
>
> Matheus Tavares Bernardino (2):
>       target/hexagon: add simple cpu_exec_reset and pointer_wrap
>       target/hexagon: Add guest reg reading functionality
>
> Sid Manning (1):
>       hw/hexagon: Add support for cfgbase
>
>  MAINTAINERS                                 |  16 +
>  docs/devel/hexagon-sys.rst                  | 112 ++++++
>  docs/devel/index-internals.rst              |   1 +
>  docs/system/hexagon/cdsp.rst                |  12 +
>  docs/system/hexagon/emulation.rst           |  15 +
>  docs/system/target-hexagon.rst              | 103 +++++
>  docs/system/targets.rst                     |   1 +
>  configs/devices/hexagon-softmmu/default.mak |   7 +
>  configs/targets/hexagon-softmmu.mak         |   8 +
>  meson.build                                 |   1 +
>  hw/hexagon/trace.h                          |   2 +
>  include/hw/hexagon/hexagon.h                | 161 ++++++++
>  include/hw/hexagon/hexagon_globalreg.h      |  55 +++
>  include/hw/hexagon/hexagon_tlb.h            |  46 +++
>  include/hw/hexagon/virt.h                   |  30 ++
>  target/hexagon/cpu-param.h                  |   2 +-
>  target/hexagon/cpu.h                        |  89 ++++-
>  target/hexagon/cpu_bits.h                   |  75 +++-
>  target/hexagon/cpu_helper.h                 |  26 ++
>  target/hexagon/gen_tcg.h                    |  16 +-
>  target/hexagon/gen_tcg_sys.h                | 139 +++++++
>  target/hexagon/helper.h                     |  27 +-
>  target/hexagon/hex_interrupts.h             |  15 +
>  target/hexagon/hex_mmu.h                    |  26 ++
>  target/hexagon/hex_regs.h                   | 117 ++++++
>  target/hexagon/hexswi.h                     |  17 +
>  target/hexagon/idef-parser/parser-helpers.h |   2 +
>  target/hexagon/internal.h                   |  22 ++
>  target/hexagon/macros.h                     |  38 +-
>  target/hexagon/sys_macros.h                 | 252 ++++++++++++
>  target/hexagon/translate.h                  |  47 +++
>  hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc   |  64 ++++
>  hw/hexagon/machine_cfg_v66g_1024.h.inc      |  64 ++++
>  hw/hexagon/machine_cfg_v68n_1024.h.inc      |  65 ++++
>  target/hexagon/attribs_def.h.inc            |  35 +-
>  target/hexagon/reg_fields_def.h.inc         | 107 ++++++
>  hw/hexagon/hexagon_dsp.c                    | 225 +++++++++++
>  hw/hexagon/hexagon_globalreg.c              | 316 +++++++++++++++
>  hw/hexagon/hexagon_tlb.c                    | 467 ++++++++++++++++++++++
>  hw/hexagon/virt.c                           | 347 +++++++++++++++++
>  linux-user/hexagon/cpu_loop.c               |  23 ++
>  system/qdev-monitor.c                       |   2 +-
>  target/hexagon/arch.c                       |   5 +
>  target/hexagon/cpu.c                        | 422 +++++++++++++++++++-
>  target/hexagon/cpu_helper.c                 | 399 +++++++++++++++++++
>  target/hexagon/decode.c                     |  14 +
>  target/hexagon/genptr.c                     | 173 ++++++++-
>  target/hexagon/hex_interrupts.c             | 371 ++++++++++++++++++
>  target/hexagon/hex_mmu.c                    | 270 +++++++++++++
>  target/hexagon/hexswi.c                     | 271 +++++++++++++
>  target/hexagon/idef-parser/parser-helpers.c |   9 +
>  target/hexagon/machine.c                    |  32 ++
>  target/hexagon/op_helper.c                  | 576 ++++++++++++++++++++++=
+++++-
>  target/hexagon/translate.c                  | 265 ++++++++++++-
>  tests/qtest/boot-serial-test.c              |   8 +
>  hw/Kconfig                                  |   1 +
>  hw/hexagon/Kconfig                          |  14 +
>  hw/hexagon/meson.build                      |   7 +
>  hw/hexagon/trace-events                     |   3 +
>  hw/meson.build                              |   1 +
>  target/Kconfig                              |   1 +
>  target/hexagon/Kconfig                      |   2 +
>  target/hexagon/gen_analyze_funcs.py         |  14 +-
>  target/hexagon/gen_helper_funcs.py          |  26 +-
>  target/hexagon/gen_helper_protos.py         |  23 +-
>  target/hexagon/gen_idef_parser_funcs.py     |   2 +
>  target/hexagon/gen_op_attribs.py            |   2 +-
>  target/hexagon/gen_opcodes_def.py           |   5 +-
>  target/hexagon/gen_tcg_funcs.py             |  35 +-
>  target/hexagon/hex_common.py                | 184 ++++++++-
>  target/hexagon/idef-parser/idef-parser.y    |   5 +-
>  target/hexagon/imported/encode_pp.def       | 129 ++++++-
>  target/hexagon/imported/ldst.idef           |   3 +
>  target/hexagon/imported/macros.def          | 482 ++++++++++++++++++++++=
-
>  target/hexagon/imported/system.idef         | 244 +++++++++++-
>  target/hexagon/meson.build                  |  30 +-
>  tests/qemu-iotests/testenv.py               |   1 +
>  tests/qtest/meson.build                     |   2 +
>  78 files changed, 7076 insertions(+), 150 deletions(-)
>  create mode 100644 docs/devel/hexagon-sys.rst
>  create mode 100644 docs/system/hexagon/cdsp.rst
>  create mode 100644 docs/system/hexagon/emulation.rst
>  create mode 100644 docs/system/target-hexagon.rst
>  create mode 100644 configs/devices/hexagon-softmmu/default.mak
>  create mode 100644 configs/targets/hexagon-softmmu.mak
>  create mode 100644 hw/hexagon/trace.h
>  create mode 100644 include/hw/hexagon/hexagon.h
>  create mode 100644 include/hw/hexagon/hexagon_globalreg.h
>  create mode 100644 include/hw/hexagon/hexagon_tlb.h
>  create mode 100644 include/hw/hexagon/virt.h
>  create mode 100644 target/hexagon/cpu_helper.h
>  create mode 100644 target/hexagon/gen_tcg_sys.h
>  create mode 100644 target/hexagon/hex_interrupts.h
>  create mode 100644 target/hexagon/hex_mmu.h
>  create mode 100644 target/hexagon/hexswi.h
>  create mode 100644 target/hexagon/sys_macros.h
>  create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc
>  create mode 100644 hw/hexagon/hexagon_dsp.c
>  create mode 100644 hw/hexagon/hexagon_globalreg.c
>  create mode 100644 hw/hexagon/hexagon_tlb.c
>  create mode 100644 hw/hexagon/virt.c
>  create mode 100644 target/hexagon/cpu_helper.c
>  create mode 100644 target/hexagon/hex_interrupts.c
>  create mode 100644 target/hexagon/hex_mmu.c
>  create mode 100644 target/hexagon/hexswi.c
>  create mode 100644 target/hexagon/machine.c
>  create mode 100644 hw/hexagon/Kconfig
>  create mode 100644 hw/hexagon/meson.build
>  create mode 100644 hw/hexagon/trace-events
>  create mode 100644 target/hexagon/Kconfig
>  mode change 100755 =3D> 100644 target/hexagon/imported/macros.def

