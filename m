Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867ACC79F82
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x47JL-0003Jh-2a; Tue, 08 Sep 2026 21:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x47JJ-0003J4-4z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 21:41:13 -0400
Received: from mail-lr2-x0a.google.com ([2a00:1450:4864:38::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x47JG-0002rb-3k
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 21:41:12 -0400
Received: by mail-lr2-x0a.google.com with SMTP id
 38308e7fff4ca-39c7d28f438so29218041fa.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 18:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788918068; cv=none;
 d=google.com; s=arc-20260327;
 b=Vc9TCpBl94Gea27zLlUCbRan79sVxs2hpCdf4uMaBNpAumLjPN/pVsWgXptagsaAAK
 Z3OeOWplAeLa3DGfrfjiif612lVlUwQbCthhsX2y2GzErdLrocyfKwnECZa237xqtbzX
 F93w4vgXv3XqRj3ki2fBjePYTZHM4f/+MV+zwQwmGYyd9YoxEPfxuB1OXIsnv7LuOJdp
 Aw270pU/XxaHBXi7+kHFrIY95LH+KBvrb1JfcRghAmAIOHdIfD1BlpIMLA65g0V55Zdc
 HtXaMY6WMZ41z1NY0OYrBKwHNjyNw22Y3DL0jeN87wgFyRs66jIjJhEatLGUuMB6hsQ0
 J31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IKn8L3KkicG7wF1yJmnsDl4yk8ny66Q1m2qa04R4Zx4=;
 fh=pFsgHbrA9XZUxjTl2xiot6f6z6CIHHgMCC6pVt5iyIo=;
 b=dUPmx7Hq7YzhgVKpjtC74iwHejN6eXvxopMX3OAvKD/PC6qJTcysPsctG+oh3dHQrl
 sRH06VVbkz7LDdPcliyf0lMCQ37KN6kaKOHsETcxoc3dnDGtmwK+OZQu4/w7LdW6IXQy
 U6YZg64TSFmAW+xvgw/WOoMS5Fnm0nD4rb9Ad3tnq4XMJ5IBCQlbCHpxLqZDiNyzp5NC
 h78nBNgX7N/3H55Hgzrfi0Jm0oyaFjCmR+x4f+jkKLq6cwhrJqoSjAXyFXDhlqd9o3br
 gnagEcVLLBSFzZkZOw+SwNIEDQ4UmaQtzlJ5mzkMAosH57gXkpX3wENbmw3uYDm3R+cx
 IgAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788918068; x=1789522868; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IKn8L3KkicG7wF1yJmnsDl4yk8ny66Q1m2qa04R4Zx4=;
 b=JRj8BvVQmD4CB624Oh6YV+12HyCAsUbHABOs8vxRqMxXpgtM5mjxzAs7EA7LqYtRqH
 59FWSu2g3K2LMXQWxMGRuniDfwVZq0Lg+xFU3+jdxHBxPqRpOrNve9x1Un1CiYFzmgF3
 vqCp2trz9VdAuJS/b7oW1pI6clEqQxD33NnG0O739pFL4/ouKnVKXETZSi+Re49b0SBO
 7Fs81eAxp1ALjUqSBs2aay+qV7K96tXOKJk4J+vhW3fW+9ycIoinm4Z8iYeTRtwfbhtb
 z20Hv1/UiKq4qeVMnuSelLGts4N2HN8rhMWHjvK0LzmTiHAgWz9/RCu94wKUHu/XVTh1
 B2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788918068; x=1789522868;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IKn8L3KkicG7wF1yJmnsDl4yk8ny66Q1m2qa04R4Zx4=;
 b=ECkd0+zGOZr5NxJVkGzrZzrk9FugCGKWeZctPV/x7UEDQV1AJg/XaKljO5ACnYZ7lu
 xxwqfvFWHVyXESDBSdICUOvE3yp77psu6L41up2rYd94tEEBD21fSHUf+BZGDrY8LqyB
 I1jE2p0C/ttKfTnckuS7r0o+PeYR4ACrNWVgqXNhtWyhtdQCzIewz7n0Q9Ng3xgIeJ4t
 f4eicCoULlN+Dk9vrVJWK5mpZeUvoaSUyMqO5TF0M55hoNnWJlgCQRRu6Ff/+ZfVSM//
 23n3X7zorm39znC4FnteGAlVsOUyqgfD9Odv8hbr+8AHYHwPWwjuS+ZJlxtD5p+r6RaI
 i0vA==
X-Gm-Message-State: AFuF++nufVuoMqkSS9ZezuAm7Q07B2MAO1fMF+ja7aVIN33MO0asG12H
 lvdlbAQKlTDa7FKj2ANvCJeYD7v0+rbtlRUjsPe+V4eEY5QLMuKR0VSWdOPu6THMbPCDXc3oR20
 Ob5gwEyexf5v3x6rfgWp03oLr7Zdfup4=
X-Gm-Gg: AYBFou2HKKvXVd6+fgu9HUdRSj2HYy7Z8xyXA2WfhKlWdcX0ouyW6GUovIm2IpeUE5m
 t+WjRjTMBUDF4XE5yxRHpxxnPMXzDCLZdFUjDwbfVl/nb9TWFDsR5EirBXzvqrNvbvk4vRupw5w
 gffx/UATH1gi8V1Q2r6m4Y9oRc9YFm1rUIjzO1dWowFA/Em8VbTbJiWqPAAzF5pKJFP3cTUZra5
 R8GhosxxRLTS6Lf394FwSZPtqCBY2EBPMTVgg9MjaIcHyZIowSGHzxUE45+ImAPMJ0qXgTMt+1V
 QeGLnlKySCUbnAkY9NKXmadm0Za5JsL+AcEHO9zJti7b4hF4dQ1Dy3isEHP9kU0OSAuyA/E1hrL
 HzOr3nYs43NTGmw==
X-Received: by 2002:a05:6512:3503:b0:5b0:c96:cc8c with SMTP id
 2adb3069b0e04-5b616f17fd6mr5328604e87.12.1788918067519; Tue, 08 Sep 2026
 18:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260905092810.660-1-fritchleybohrer@gmail.com>
 <61be29dd-2aab-4d7e-b199-10aa49b82418@oss.qualcomm.com>
 <fe6bccf3-f845-4bcb-89a5-119ac95c3773@oss.qualcomm.com>
In-Reply-To: <fe6bccf3-f845-4bcb-89a5-119ac95c3773@oss.qualcomm.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Wed, 9 Sep 2026 09:40:55 +0800
X-Gm-Features: AcwNN1UY1yP0d_HNFeSw6pUIdsD53IMH7-0O4lYiDTCHvhUu4c13hjnsoxaQcBU
Message-ID: <CAN4PorXfJiB-wkcpKbS=H+M1C_7PccScyYUpsFfxDQg6gHsfkw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix RV32 fixed counter accesses
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: multipart/alternative; boundary="000000000000f26695065b02f107"
Received-SPF: pass client-ip=2a00:1450:4864:38::a;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lr2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000f26695065b02f107
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion. I'll move the test to tests/tcg/riscv32/ in v2.

Thanks,
Zephyr

On Wed, Sep 9, 2026 at 12:00=E2=80=AFAM Daniel Henrique Barboza <
daniel.barboza@oss.qualcomm.com> wrote:

>
>
> On 9/8/2026 8:17 AM, Daniel Henrique Barboza wrote:
> >
> >
> > On 9/5/2026 6:28 AM, Zephyr Li wrote:
> >> Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()
> >> returns the complete 64-bit fixed-counter value. The RV32 counter
> >> access paths, however, still perform parts of the offset calculation
> >> on separately extracted 32-bit halves.
> >>
> >> In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of the
> >> complete fixed-counter value into the high half of mhpmcounter_prev.
> >> riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous valu=
e
> >> from the complete 64-bit fixed-counter value. Consequently, writes to
> >> mcycleh can be lost and carries between the low and high halves are no=
t
> >> handled correctly.
> >>
> >> Keep the fixed-counter offset calculation entirely in 64 bits. Before
> >> a running counter is partially written, materialize its current
> >> architectural value and reset the fixed-counter baseline. On reads,
> >> calculate the complete 64-bit counter value before extracting the half
> >> requested by RV32.
> >>
> >> Add an RV32 system TCG test for high-half writes, low-to-high carry, a=
nd
> >> preserving the carried high half across a subsequent low-half write.
> >>
> >> Fixes: cfc96df65e01 ("target/riscv: Remove upper_half from
> riscv_pmu_ctr_get_fixed_counters_val")
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4219
> >> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> >> ---
> >
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
> Actually there's a test related change I would like to suggest:
>
>
>
> >
> >>   target/riscv/tcg/csr.c                    | 32 ++++++++--------
> >>   tests/tcg/riscv64/Makefile.softmmu-target | 12 ++++++
> >>   tests/tcg/riscv64/test-mcycle-rv32.S      | 45 +++++++++++++++++++++=
++
> >>   3 files changed, 74 insertions(+), 15 deletions(-)
> >>   create mode 100644 tests/tcg/riscv64/test-mcycle-rv32.S
> >>
> >> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> >> index 002f7e69c1..ffdd5c4aa6 100644
> >> --- a/target/riscv/tcg/csr.c
> >> +++ b/target/riscv/tcg/csr.c
> >> @@ -1337,23 +1337,23 @@ static RISCVException
> riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
> >>       int deposit_size =3D rv32 ? 32 : 64;
> >>       uint64_t ctr;
> >> -    counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_val,
> >> -                                         0, deposit_size, val);
> >> -
> >>       if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
> >>           (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> >>           ctr =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> >> -        counter->mhpmcounter_prev =3D
> deposit64(counter->mhpmcounter_prev,
> >> -                                              0, deposit_size, ctr);
> >> +        counter->mhpmcounter_val +=3D ctr - counter->mhpmcounter_prev=
;
> >> +        counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_v=
al,
> >> +                                             0, deposit_size, val);
> >> +        counter->mhpmcounter_prev =3D ctr;
> >>           if (ctr_idx > 2) {
> >>               riscv_pmu_setup_timer(env, counter->mhpmcounter_val,
> ctr_idx);
> >>           }
> >>        } else {
> >> +        counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_v=
al,
> >> +                                             0, deposit_size, val);
> >>           /* Other counters can keep incrementing from the given value
> */
> >>           counter->mhpmcounter_prev =3D
> deposit64(counter->mhpmcounter_prev,
> >>                                                 0, deposit_size, val);
> >> -
> >>       }
> >>       return RISCV_EXCP_NONE;
> >> @@ -1363,20 +1363,22 @@ static RISCVException
> riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
> >>                                             uint32_t ctr_idx)
> >>   {
> >>       PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> >> -    uint64_t ctrh;
> >> +    uint64_t ctr;
> >> -    counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_val,
> >> -                                         32, 32, val);
> >>       if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
> >>           (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> >> -        ctrh =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> >> -        counter->mhpmcounter_prev =3D
> deposit64(counter->mhpmcounter_prev,
> >> -                                              32, 32, ctrh);
> >> +        ctr =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> >> +        counter->mhpmcounter_val +=3D ctr - counter->mhpmcounter_prev=
;
> >> +        counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_v=
al,
> >> +                                             32, 32, val);
> >> +        counter->mhpmcounter_prev =3D ctr;
> >>           if (ctr_idx > 2) {
> >>               riscv_pmu_setup_timer(env, counter->mhpmcounter_val,
> ctr_idx);
> >>           }
> >>       } else {
> >> +        counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_v=
al,
> >> +                                             32, 32, val);
> >>           counter->mhpmcounter_prev =3D
> deposit64(counter->mhpmcounter_prev,
> >>                                                 32, 32, val);
> >>       }
> >> @@ -1407,12 +1409,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVStat=
e
> *env, target_ulong *val,
> >>       bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> >>       int start =3D upper_half ? 32 : 0;
> >>       int length =3D rv32 ? 32 : 64;
> >> -    uint64_t ctr_prev, ctr_val;
> >> +    uint64_t ctr_val;
> >>       /* Ensure upper_half is only set for XLEN =3D=3D 32 */
> >>       g_assert(rv32 || !upper_half);
> >> -    ctr_prev =3D extract64(counter->mhpmcounter_prev, start, length);
> >>       ctr_val  =3D extract64(counter->mhpmcounter_val, start, length);
> >>       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
> >> @@ -1431,7 +1432,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState
> *env, target_ulong *val,
> >>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> >>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> >>           uint64_t cntr =3D riscv_pmu_ctr_get_fixed_counters_val(env,
> ctr_idx) -
> >> -                                                             ctr_prev
> + ctr_val;
> >> +                        counter->mhpmcounter_prev +
> >> +                        counter->mhpmcounter_val;
> >>           *val =3D extract64(cntr, start, length);
> >>       } else {
> >>           *val =3D ctr_val;
> >> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target
> b/tests/tcg/riscv64/Makefile.softmmu-target
> >> index 6a219c306c..15c7371acd 100644
> >> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> >> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> >> @@ -28,6 +28,18 @@ EXTRA_RUNS +=3D run-test-minstret-ecall
> >>   run-test-minstret-ecall: test-minstret-ecall
> >>       $(call run-test, $<, $(QEMU) -icount shift=3D1 $(QEMU_OPTS)$<)
> >> +RV32_CFLAGS =3D -march=3Drv32im_zicsr -mabi=3Dilp32
> >> +CLEANFILES +=3D test-mcycle-rv32
>
> Note that you're adding specific rv32 tests in
> tests/tcg/riscv64/Makefile.softmmu-target.
> A better place is the tests/tcg/riscv32/ dir - we want to avoid mixing
> rv32 stuff in
> rv64 makefiles and vice-versa.
>
> I suggest keeping tests/tcg/riscv64/Makefile.softmmu-target untouched and
> use tests/tcg/riscv32/ for this new test.
>
>
> Thanks,
> Daniel
>
> >> +
> >> +test-mcycle-rv32: test-mcycle-rv32.S $(LINK_SCRIPT)
> >> +    $(CC) $(CFLAGS) $(RV32_CFLAGS) $< -Wa,--noexecstack -c -o $@.o
> >> +    $(LD) -m elf32lriscv $(LDFLAGS) $@.o -o $@
> >> +
> >> +EXTRA_RUNS +=3D run-test-mcycle-rv32
> >> +run-test-mcycle-rv32: test-mcycle-rv32
> >> +    $(call run-test, $<, \
> >> +      $(QEMU) -cpu rv32 -icount shift=3D1 $(QEMU_OPTS)$<)
> >> +
> >>   EXTRA_RUNS +=3D run-plugin-doubletrap
> >>   run-plugin-doubletrap: doubletrap
> >>       $(call run-test, $<, \
> >> diff --git a/tests/tcg/riscv64/test-mcycle-rv32.S
> b/tests/tcg/riscv64/test-mcycle-rv32.S
> >> new file mode 100644
> >> index 0000000000..189d1e13a2
> >> --- /dev/null
> >> +++ b/tests/tcg/riscv64/test-mcycle-rv32.S
> >> @@ -0,0 +1,45 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +
> >> +    .option    norvc
> >> +
> >> +    .text
> >> +    .global    _start
> >> +_start:
> >> +    /* Exercise writes while mcycle is running. */
> >> +    csrw    mcountinhibit, zero
> >> +    csrw    mcycle, zero
> >> +
> >> +    /* A write to the high half must be immediately observable. */
> >> +    li    s0, 0x1234ffff
> >> +    csrw    mcycleh, s0
> >> +    csrr    t0, mcycleh
> >> +    bne    t0, s0, fail
> >> +
> >> +    /* Check carry from the low half into the high half. */
> >> +    li    s0, 0x12345678
> >> +    csrw    mcycleh, s0
> >> +    li    t0, 0xfffffff0
> >> +    csrw    mcycle, t0
> >> +    .rept    32
> >> +    nop
> >> +    .endr
> >> +    csrr    t0, mcycleh
> >> +    addi    s0, s0, 1
> >> +    bne    t0, s0, fail
> >> +
> >> +    /* A low-half write must preserve the carried high half. */
> >> +    li    t0, 0x22222222
> >> +    csrw    mcycle, t0
> >> +    csrr    t0, mcycleh
> >> +    bne    t0, s0, fail
> >> +
> >> +    li    t0, 0x100000
> >> +    li    t1, 0x5555    /* FINISHER_PASS */
> >> +    sw    t1, 0(t0)
> >> +    j    .
> >> +
> >> +fail:
> >> +    li    t0, 0x100000
> >> +    li    t1, 0x13333    /* status =3D FINISHER_FAIL, code =3D 1 */
> >> +    sw    t1, 0(t0)
> >> +    j    .
> >
>
>

--000000000000f26695065b02f107
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-PDq2pG_selectionAnchorContainer">Thanks =
for the suggestion. I&#39;ll move the test to <code>tests/tcg/riscv32/</cod=
e> in v2.<span aria-hidden=3D"true" class=3D"gmail-PDq2pG_selectionAnchor">=
</span></p>
<p>Thanks,<br>
Zephyr</p></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2026 at 12:00=E2=80=AFAM Dan=
iel Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza@oss.qualcomm.com"=
>daniel.barboza@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
<br>
On 9/8/2026 8:17 AM, Daniel Henrique Barboza wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 9/5/2026 6:28 AM, Zephyr Li wrote:<br>
&gt;&gt; Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()<=
br>
&gt;&gt; returns the complete 64-bit fixed-counter value. The RV32 counter<=
br>
&gt;&gt; access paths, however, still perform parts of the offset calculati=
on<br>
&gt;&gt; on separately extracted 32-bit halves.<br>
&gt;&gt;<br>
&gt;&gt; In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of =
the<br>
&gt;&gt; complete fixed-counter value into the high half of mhpmcounter_pre=
v.<br>
&gt;&gt; riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous =
value<br>
&gt;&gt; from the complete 64-bit fixed-counter value. Consequently, writes=
 to<br>
&gt;&gt; mcycleh can be lost and carries between the low and high halves ar=
e not<br>
&gt;&gt; handled correctly.<br>
&gt;&gt;<br>
&gt;&gt; Keep the fixed-counter offset calculation entirely in 64 bits. Bef=
ore<br>
&gt;&gt; a running counter is partially written, materialize its current<br=
>
&gt;&gt; architectural value and reset the fixed-counter baseline. On reads=
,<br>
&gt;&gt; calculate the complete 64-bit counter value before extracting the =
half<br>
&gt;&gt; requested by RV32.<br>
&gt;&gt;<br>
&gt;&gt; Add an RV32 system TCG test for high-half writes, low-to-high carr=
y, and<br>
&gt;&gt; preserving the carried high half across a subsequent low-half writ=
e.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: cfc96df65e01 (&quot;target/riscv: Remove upper_half from ri=
scv_pmu_ctr_get_fixed_counters_val&quot;)<br>
&gt;&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_i=
tems/4219" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/work_items/4219</a><br>
&gt;&gt; Signed-off-by: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gma=
il.com" target=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt; <br>
&gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barb=
oza@oss.qualcomm.com" target=3D"_blank">daniel.barboza@oss.qualcomm.com</a>=
&gt;<br>
<br>
Actually there&#39;s a test related change I would like to suggest:<br>
<br>
<br>
<br>
&gt; <br>
&gt;&gt; =C2=A0 target/riscv/tcg/csr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 32 ++++++++--------<br>
&gt;&gt; =C2=A0 tests/tcg/riscv64/Makefile.softmmu-target | 12 ++++++<br>
&gt;&gt; =C2=A0 tests/tcg/riscv64/test-mcycle-rv32.S=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 45 +++++++++++++++++++++++<br>
&gt;&gt; =C2=A0 3 files changed, 74 insertions(+), 15 deletions(-)<br>
&gt;&gt; =C2=A0 create mode 100644 tests/tcg/riscv64/test-mcycle-rv32.S<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c<br>
&gt;&gt; index 002f7e69c1..ffdd5c4aa6 100644<br>
&gt;&gt; --- a/target/riscv/tcg/csr.c<br>
&gt;&gt; +++ b/target/riscv/tcg/csr.c<br>
&gt;&gt; @@ -1337,23 +1337,23 @@ static RISCVException riscv_pmu_write_ctr(=
CPURISCVState *env, target_ulong val,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int deposit_size =3D rv32 ? 32 : 64=
;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ctr;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounter_val =3D deposit64(coun=
ter-&gt;mhpmcounter_val,<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, deposit_size, val);<br>
&gt;&gt; -<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_field(env-&gt;mcountinhibi=
t, BIT(ctr_idx)) &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (riscv_pmu_=
ctr_monitor_cycles(env, ctr_idx) ||<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv=
_pmu_ctr_monitor_instructions(env, ctr_idx))) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctr =3D ris=
cv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_prev =3D deposit64(counter-&gt;mhpmcounter_prev,<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, deposit_size, =
ctr);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_val +=3D ctr - counter-&gt;mhpmcounter_prev;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_val =3D deposit64(counter-&gt;mhpmcounter_val,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, deposit_size, val);<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_prev =3D ctr;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ctr_idx=
 &gt; 2) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 riscv_pmu_setup_timer(env, counter-&gt;mhpmcounter_val, ctr_id=
x);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_val =3D deposit64(counter-&gt;mhpmcounter_val,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, deposit_size, val);<=
br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Other co=
unters can keep incrementing from the given value */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt=
;mhpmcounter_prev =3D deposit64(counter-&gt;mhpmcounter_prev,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, depos=
it_size, val);<br>
&gt;&gt; -<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;<br>
&gt;&gt; @@ -1363,20 +1363,22 @@ static RISCVException riscv_pmu_write_ctrh=
(CPURISCVState *env, target_ulong val,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ctr_idx)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMUCTRState *counter =3D &amp;env-&=
gt;pmu_ctrs[ctr_idx];<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 uint64_t ctrh;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t ctr;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounter_val =3D deposit64(coun=
ter-&gt;mhpmcounter_val,<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 32, 32, val);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_field(env-&gt;mcountinhibi=
t, BIT(ctr_idx)) &amp;&amp;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (riscv_pmu_=
ctr_monitor_cycles(env, ctr_idx) ||<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv=
_pmu_ctr_monitor_instructions(env, ctr_idx))) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrh =3D riscv_pmu_ctr=
_get_fixed_counters_val(env, ctr_idx);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_prev =3D deposit64(counter-&gt;mhpmcounter_prev,<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32, 32, ctrh);<br=
>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctr =3D riscv_pmu_ctr_=
get_fixed_counters_val(env, ctr_idx);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_val +=3D ctr - counter-&gt;mhpmcounter_prev;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_val =3D deposit64(counter-&gt;mhpmcounter_val,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32, 32, val);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_prev =3D ctr;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ctr_idx=
 &gt; 2) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 riscv_pmu_setup_timer(env, counter-&gt;mhpmcounter_val, ctr_id=
x);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt;mhpmcounte=
r_val =3D deposit64(counter-&gt;mhpmcounter_val,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32, 32, val);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter-&gt=
;mhpmcounter_prev =3D deposit64(counter-&gt;mhpmcounter_prev,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32, 32, =
val);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; @@ -1407,12 +1409,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCV=
State *env, target_ulong *val,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool rv32 =3D riscv_cpu_mxl(env) =
=3D=3D MXL_RV32;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int start =3D upper_half ? 32 : 0;<=
br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int length =3D rv32 ? 32 : 64;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 uint64_t ctr_prev, ctr_val;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t ctr_val;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ensure upper_half is only set fo=
r XLEN =3D=3D 32 */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(rv32 || !upper_half);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 ctr_prev =3D extract64(counter-&gt;mhpmcounter=
_prev, start, length);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctr_val=C2=A0 =3D extract64(counter=
-&gt;mhpmcounter_val, start, length);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (get_field(env-&gt;mcountinhibit=
, BIT(ctr_idx))) {<br>
&gt;&gt; @@ -1431,7 +1432,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVSt=
ate *env, target_ulong *val,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (riscv_pmu_ctr_monitor_cycles(en=
v, ctr_idx) ||<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_pmu_c=
tr_monitor_instructions(env, ctr_idx)) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t cn=
tr =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ct=
r_prev + ctr_val;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 counter-&gt;mhpmcounter_prev +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 counter-&gt;mhpmcounter_val;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D ex=
tract64(cntr, start, length);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D ct=
r_val;<br>
&gt;&gt; diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg=
/riscv64/Makefile.softmmu-target<br>
&gt;&gt; index 6a219c306c..15c7371acd 100644<br>
&gt;&gt; --- a/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt;&gt; +++ b/tests/tcg/riscv64/Makefile.softmmu-target<br>
&gt;&gt; @@ -28,6 +28,18 @@ EXTRA_RUNS +=3D run-test-minstret-ecall<br>
&gt;&gt; =C2=A0 run-test-minstret-ecall: test-minstret-ecall<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call run-test, $&lt;, $(QEMU) -ic=
ount shift=3D1 $(QEMU_OPTS)$&lt;)<br>
&gt;&gt; +RV32_CFLAGS =3D -march=3Drv32im_zicsr -mabi=3Dilp32<br>
&gt;&gt; +CLEANFILES +=3D test-mcycle-rv32<br>
<br>
Note that you&#39;re adding specific rv32 tests in tests/tcg/riscv64/Makefi=
le.softmmu-target.<br>
A better place is the tests/tcg/riscv32/ dir - we want to avoid mixing rv32=
 stuff in<br>
rv64 makefiles and vice-versa.<br>
<br>
I suggest keeping tests/tcg/riscv64/Makefile.softmmu-target untouched and<b=
r>
use tests/tcg/riscv32/ for this new test.<br>
<br>
<br>
Thanks,<br>
Daniel<br>
<br>
&gt;&gt; +<br>
&gt;&gt; +test-mcycle-rv32: test-mcycle-rv32.S $(LINK_SCRIPT)<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 $(CC) $(CFLAGS) $(RV32_CFLAGS) $&lt; -Wa,--noe=
xecstack -c -o $@.o<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 $(LD) -m elf32lriscv $(LDFLAGS) $@.o -o $@<br>
&gt;&gt; +<br>
&gt;&gt; +EXTRA_RUNS +=3D run-test-mcycle-rv32<br>
&gt;&gt; +run-test-mcycle-rv32: test-mcycle-rv32<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 $(call run-test, $&lt;, \<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(QEMU) -cpu rv32 -icount shift=3D=
1 $(QEMU_OPTS)$&lt;)<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 EXTRA_RUNS +=3D run-plugin-doubletrap<br>
&gt;&gt; =C2=A0 run-plugin-doubletrap: doubletrap<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call run-test, $&lt;, \<br>
&gt;&gt; diff --git a/tests/tcg/riscv64/test-mcycle-rv32.S b/tests/tcg/risc=
v64/test-mcycle-rv32.S<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000000..189d1e13a2<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/tests/tcg/riscv64/test-mcycle-rv32.S<br>
&gt;&gt; @@ -0,0 +1,45 @@<br>
&gt;&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .option=C2=A0=C2=A0=C2=A0 norvc<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .text<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .global=C2=A0=C2=A0=C2=A0 _start<br>
&gt;&gt; +_start:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Exercise writes while mcycle is running. */=
<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrw=C2=A0=C2=A0=C2=A0 mcountinhibit, zero<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrw=C2=A0=C2=A0=C2=A0 mcycle, zero<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* A write to the high half must be immediatel=
y observable. */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 s0, 0x1234ffff<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrw=C2=A0=C2=A0=C2=A0 mcycleh, s0<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrr=C2=A0=C2=A0=C2=A0 t0, mcycleh<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0 t0, s0, fail<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* Check carry from the low half into the high=
 half. */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 s0, 0x12345678<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrw=C2=A0=C2=A0=C2=A0 mcycleh, s0<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 t0, 0xfffffff0<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrw=C2=A0=C2=A0=C2=A0 mcycle, t0<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .rept=C2=A0=C2=A0=C2=A0 32<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 nop<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 .endr<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrr=C2=A0=C2=A0=C2=A0 t0, mcycleh<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 s0, s0, 1<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0 t0, s0, fail<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 /* A low-half write must preserve the carried =
high half. */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 t0, 0x22222222<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrw=C2=A0=C2=A0=C2=A0 mcycle, t0<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 csrr=C2=A0=C2=A0=C2=A0 t0, mcycleh<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0 t0, s0, fail<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 t0, 0x100000<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 t1, 0x5555=C2=A0=C2=A0=C2=
=A0 /* FINISHER_PASS */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sw=C2=A0=C2=A0=C2=A0 t1, 0(t0)<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 j=C2=A0=C2=A0=C2=A0 .<br>
&gt;&gt; +<br>
&gt;&gt; +fail:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 t0, 0x100000<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0 t1, 0x13333=C2=A0=C2=A0=
=C2=A0 /* status =3D FINISHER_FAIL, code =3D 1 */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 sw=C2=A0=C2=A0=C2=A0 t1, 0(t0)<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 j=C2=A0=C2=A0=C2=A0 .<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000f26695065b02f107--

