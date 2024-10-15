Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D35D1D89A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 18:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0mcl-0007JN-FX; Tue, 15 Oct 2024 14:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t0mci-0007Ib-P5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 14:50:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t0mcf-00072h-Al
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 14:50:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so3752024f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729018219; x=1729623019;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqoMhv+wqccRmi9thJ2Qz70LvUW7LeXJYwHXf6qyITk=;
 b=SsvKMUZ3j3LhKdDtGMwsKGu+DMB/GAQONNH1WMj5xxEZRgn+vamYwi+UjTVJtSecL1
 dDPYTOaY6blDLpAM6avApT2QmIDzlUlwIaVUzHTKA3Wi39a9NcIwgXGFd/VjRgR2Gw4v
 kWPtLuDkG3PqWcSx3FrcPdpdxMm6djJQq9fQLd6ZXWu3ON7ouWPKM9jMRSdKC+RSsGW6
 5E6apCou36e4Tbpz8KrU95oHH4ilm0Ojj0Ui99vuBayNLj+YOgnttpwKJRs9sfgCDk1D
 w+PH312GHvl/XAH9/UORxF4rp1/hmZ58EtwdbCOKDwmuCY+/2SUuA9V/0EpkmvV7jqp+
 3mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729018219; x=1729623019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqoMhv+wqccRmi9thJ2Qz70LvUW7LeXJYwHXf6qyITk=;
 b=rY8hmR8zrZjKnxAZ9sbWgcsPxiRbU1GWh+xYUC/bBTrQOYv70/H7oCN1PMYlH13c0w
 LZm895d9kJLukHiBE7ERsHHcYg9BAuDS1c1Txd0zuV4iiyse9YO2Mk0N1cDlhssTG7t7
 YfIn7qWzVWl34eBpvFT2+zove0xZzwr3spDaaU43sZmNGXxviYixe8JYbY9//e1YSnmW
 XeynjwODF/hTWpx5MrRzienRzN+pzOyeOa5gFbQJfw/JA+NXtXUrZybJLt2ToelcJksF
 WIqmDbRzsz8XCXKMVmDbAMNxSl6HECf2yE1OwpjowXJwj3PtBt9mmVCtNJzCvcPbyGnM
 iikg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDBhuV+fliMLBxyBWFhNPKxG0+y5VhSh2gIL2VhLWJ2K9w//IO30LQ1P6wFpkCvx7aqYN1Tb+wMpjD@nongnu.org
X-Gm-Message-State: AOJu0YyTgqLB8F+8u6mBqavJboPiwh2/O8ye/g/cXAEOxOybeAqfD5Vt
 nn9yb0XghM5REvkIuHw+bPvshwV9ILHZsHJxw/b4nMK6sv9YZMnFYNKodw1TdvnbFA+UzQ5aGTH
 sUC9+tXXiObKvDaZ31KhEK0i3+pJ5Q26G8W4xKA==
X-Google-Smtp-Source: AGHT+IHN0CXV/DXhnA6pae9n5tXegyjrkTEV5q4FJO2GCnLDINcf5Hg6ANvpXmTvlk0oVB9VMEm/dsKPzpnsamVt/TI=
X-Received: by 2002:adf:f212:0:b0:37d:5113:cdef with SMTP id
 ffacd0b85a97d-37d86d5031emr1055250f8f.43.1729018218371; Tue, 15 Oct 2024
 11:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-5-rkanwal@rivosinc.com>
 <0eae6e8c-200e-419d-a3ce-e7c756c9bb85@sifive.com>
In-Reply-To: <0eae6e8c-200e-419d-a3ce-e7c756c9bb85@sifive.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Tue, 15 Oct 2024 19:50:07 +0100
Message-ID: <CAECbVCtetwK-GgML0VYegwwF87L2WftHXX2KGb7zw8GU6263Lw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] target/riscv: Add support to record CTR entries.
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Jason,

On Wed, Jun 26, 2024 at 4:49=E2=80=AFAM Jason Chien <jason.chien@sifive.com=
> wrote:
>
> Hi Rajnesh,
>
> On 2024/6/19 =E4=B8=8B=E5=8D=88 11:27, Rajnesh Kanwal wrote:
> > This commit adds logic to records CTR entries of different types
> > and adds required hooks in TCG and interrupt/Exception logic to
> > record events.
> >
> > This commit also adds support to invoke freeze CTR logic for breakpoint
> > exceptions and counter overflow interrupts.
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >   target/riscv/cpu.h                            |   8 +
> >   target/riscv/cpu_helper.c                     | 258 +++++++++++++++++=
+
> >   target/riscv/helper.h                         |   8 +-
> >   .../riscv/insn_trans/trans_privileged.c.inc   |   6 +-
> >   target/riscv/insn_trans/trans_rvi.c.inc       |  31 +++
> >   target/riscv/insn_trans/trans_rvzce.c.inc     |  20 ++
> >   target/riscv/op_helper.c                      | 126 ++++++++-
> >   target/riscv/translate.c                      |  10 +
> >   8 files changed, 461 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 3d4d5172b8..e32f5ab146 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -268,6 +268,10 @@ struct CPUArchState {
> >       uint32_t sctrstatus;
> >       uint64_t vsctrctl;
> >
> > +    uint64_t ctr_src[16 << SCTRDEPTH_MAX];
> > +    uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
> > +    uint64_t ctr_data[16 << SCTRDEPTH_MAX];
> > +
> >       /* Machine and Supervisor interrupt priorities */
> >       uint8_t miprio[64];
> >       uint8_t siprio[64];
> > @@ -565,6 +569,10 @@ RISCVException smstateen_acc_ok(CPURISCVState *env=
, int index, uint64_t bit);
> >   #endif
> >   void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, boo=
l virt_en);
> >
> > +void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask, bool v=
irt);
> It looks like riscv_ctr_freeze() is only used in
> target/riscv/cpu_helper.c. We can make it a static function.

Thanks. I will fix this in v3.

> > +void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_l=
ong dst,
> > +                         uint64_t type, target_ulong prev_priv, bool p=
rev_virt);
> > +
> >   void riscv_translate_init(void);
> >   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> >                                         uint32_t exception, uintptr_t p=
c);
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index a441a03ef4..1537602e1b 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -691,6 +691,246 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState =
*env, uint32_t priv,
> >       }
> >   }
> >
> > +void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask, bool v=
irt)
> > +{
> > +    uint64_t ctl =3D virt ? env->mctrctl : env->vsctrctl;
> > +
> > +    assert((freeze_mask & (~(MCTRCTL_BPFRZ | MCTRCTL_LCOFIFRZ))) =3D=
=3D 0);
> > +
> > +    if (ctl & freeze_mask) {
> > +        env->sctrstatus |=3D SCTRSTATUS_FROZEN;
> > +    }
> > +}
> > +
> > +static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
> > +{
> > +    switch (priv) {
> > +    case PRV_M:
> > +        return MCTRCTL_M_ENABLE;
> > +    case PRV_S:
> > +        if (virt) {
> > +            return VSCTRCTL_VS_ENABLE;
> > +        }
> > +        return MCTRCTL_S_ENABLE;
> > +    case PRV_U:
> > +        if (virt) {
> > +            return VSCTRCTL_VU_ENABLE;
> > +        }
> > +        return MCTRCTL_U_ENABLE;
> > +    }
> > +
> > +    g_assert_not_reached();
> > +}
> > +
> > +static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long =
priv,
> > +                                      bool virt)
> > +{
> > +    switch (priv) {
> > +    case PRV_M:
> > +        return env->mctrctl;
> > +    case PRV_S:
> > +    case PRV_U:
> > +        if (virt) {
> > +            return env->vsctrctl;
> > +        }
> > +        return env->mctrctl;
> > +    }
> > +
> > +    g_assert_not_reached();
> > +}
> > +
> > +/*
> > + * This function assumes that src privilege and target privilege are n=
ot same
> > + * and src privilege is less than target privilege. This includes the =
virtual
> > + * state as well.
> > + */
> > +static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_pr=
v,
> > +                                bool src_virt)
> This function is problematic. Suppose an external trap traps from U mode
> to M mode. We need to check both sctrctl.STE and mctrctl.MTE, but this
> function only checks sctrctl.STE.

I think it does check both MTE and STE. Switch case doesn't break and
falls through to check for MTE bit. Correct me if I am missing something.

> > +{
> > +    target_long tgt_prv =3D env->priv;
> > +    bool res =3D true;
> > +
> > +    /*
> > +     * VS and U mode are same in terms of xTE bits required to record =
an
> > +     * external trap. See 6.1.2. External Traps, table 8 External Trap=
 Enable
> > +     * Requirements. This changes VS to U to simplify the logic a bit.
> > +     */
> > +    if (src_virt && src_prv =3D=3D PRV_S) {
> > +        src_prv =3D PRV_U;
> > +    } else if (env->virt_enabled && tgt_prv =3D=3D PRV_S) {
> > +        tgt_prv =3D PRV_U;
> > +    }
> > +
> > +    /* VU mode is an outlier here. */
> > +    if (src_virt && src_prv =3D=3D PRV_U) {
> > +        res &=3D !!(env->vsctrctl & VSCTRCTL_VSTE);
> > +    }
> > +
> > +    switch (src_prv) {
> > +    case PRV_U:
> > +        if (tgt_prv =3D=3D PRV_U) {
> > +            break;
> > +        }
> > +        res &=3D !!(env->mctrctl & SCTRCTL_STE);
> > +        /* fall-through */
> > +    case PRV_S:
> > +        if (tgt_prv =3D=3D PRV_S) {
> > +            break;
> > +        }
> > +        res &=3D !!(env->mctrctl & MCTRCTL_MTE);
> > +        /* fall-through */
> > +    case PRV_M:
> > +        break;
> > +    }
> > +
> > +    return res;
> > +}
> > +
> > +/*
> > + * Special cases for traps and trap returns:
> > + *
> > + * 1- Traps, and trap returns, between enabled modes are recorded as n=
ormal.
> > + * 2- Traps from an inhibited mode to an enabled mode, and trap return=
s from an
> > + * enabled mode back to an inhibited mode, are partially recorded.  In=
 such
> > + * cases, the PC from the inhibited mode (source PC for traps, and tar=
get PC
> > + * for trap returns) is 0.
> > + *
> > + * 3- Trap returns from an inhibited mode to an enabled mode are not r=
ecorded.
> > + * Traps from an enabled mode to an inhibited mode, known as external =
traps,
> > + * receive special handling.
> > + * By default external traps are not recorded, but a handshake mechani=
sm exists
> > + * to allow partial recording.  Software running in the target mode of=
 the trap
> > + * can opt-in to allowing CTR to record traps into that mode even when=
 the mode
> > + * is inhibited.  The MTE, STE, and VSTE bits allow M-mode, S-mode, an=
d VS-mode,
> > + * respectively, to opt-in. When an External Trap occurs, and xTE=3D1,=
 such that
> > + * x is the target privilege mode of the trap, will CTR record the tra=
p. In such
> > + * cases, the target PC is 0.
> > + */
> > +/*
> > + * CTR arrays are implemented as circular buffers and new entry is sto=
red at
> > + * sctrstatus.WRPTR, but they are presented to software as moving circ=
ular
> > + * buffers. Which means, software get's the illusion that whenever a n=
ew entry
> > + * is added the whole buffer is moved by one place and the new entry i=
s added at
> > + * the start keeping new entry at idx 0 and older ones follow.
> > + *
> > + * Depth =3D 16.
> > + *
> > + * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] =
[F]
> > + * WRPTR                                   W
> > + * entry   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9  =
 8
> > + *
> > + * When a new entry is added:
> > + * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] =
[F]
> > + * WRPTR                                       W
> > + * entry   8   7   6   5   4   3   2   1   0   F   E   D   C   B   A  =
 9
> > + *
> > + * entry here denotes the logical entry number that software can acces=
s
> > + * using ctrsource, ctrtarget and ctrdata registers. So xiselect 0x200
> > + * will return entry 0 i-e buffer[8] and 0x201 will return entry 1 i-e
> > + * buffer[7]. Here is how we convert entry to buffer idx.
> > + *
> > + *    entry =3D isel - CTR_ENTRIES_FIRST;
> > + *    idx =3D (sctrstatus.WRPTR - entry - 1) & (depth - 1);
> > + */
> > +void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_l=
ong dst,
> > +                         uint64_t type, target_ulong src_priv, bool sr=
c_virt)
> > +{
> > +    bool tgt_virt =3D env->virt_enabled;
> > +    uint64_t src_mask =3D riscv_ctr_priv_to_mask(src_priv, src_virt);
> > +    uint64_t tgt_mask =3D riscv_ctr_priv_to_mask(env->priv, tgt_virt);
> > +    uint64_t src_ctrl =3D riscv_ctr_get_control(env, src_priv, src_vir=
t);
> > +    uint64_t tgt_ctrl =3D riscv_ctr_get_control(env, env->priv, tgt_vi=
rt);
> > +    uint64_t depth, head;
> > +    bool ext_trap =3D false;
> > +
> > +    /*
> > +     * Return immediately if both target and src recording is disabled=
 or if
> > +     * CTR is in frozen state.
> > +     */
> > +    if ((!(src_ctrl & src_mask) && !(tgt_ctrl & tgt_mask)) ||
> > +        env->sctrstatus & SCTRSTATUS_FROZEN) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * With RAS Emul enabled, only allow Indirect, direct calls, Funct=
ion
> > +     * returns and Co-routine swap types.
> > +     */
> > +    if (env->mctrctl & MCTRCTL_RASEMU &&
> I think we should check vsctrctl.RASEMU for VS and VU mode.
> You can consider defining a variable here as it will be used multiple
> times below.
> bool rasemu =3D MCTRCTL_RASEMU & ((env->virt_enabled) ? env->vsctrctl :
> env->mctrctl);

Sorry my bad. I understand what you are saying but I think just replacing
env->mctrctl with tgt_ctl should fix this. We have a similar RASEMU check i=
n
this same function.

> > +        type !=3D CTRDATA_TYPE_INDIRECT_CALL &&
> > +        type !=3D CTRDATA_TYPE_DIRECT_CALL &&
> > +        type !=3D CTRDATA_TYPE_RETURN &&
> > +        type !=3D CTRDATA_TYPE_CO_ROUTINE_SWAP) {
> > +        return;
> > +    }
> > +
> > +    if (type =3D=3D CTRDATA_TYPE_EXCEPTION || type =3D=3D CTRDATA_TYPE=
_INTERRUPT) {
> > +        /* Case 2 for traps. */
> > +        if (!(src_ctrl & src_mask)) {
> > +            src =3D 0;
> > +        } else if (!(tgt_ctrl & tgt_mask)) {
> > +            /* Check if target priv-mode has allowed external trap rec=
ording. */
> > +            if (!riscv_ctr_check_xte(env, src_priv, src_virt)) {
> > +                return;
> > +            }
> > +
> > +            ext_trap =3D true;
> > +            dst =3D 0;
> > +        }
> > +    } else if (type =3D=3D CTRDATA_TYPE_EXCEP_INT_RET) {
> > +        /*
> > +         * Case 3 for trap returns.  Trap returns from inhibited mode =
are not
> > +         * recorded.
> > +         */
> > +        if (!(src_ctrl & src_mask)) {
> > +            return;
> > +        }
> > +
> > +        /* Case 2 for trap returns. */
> > +        if (!(tgt_ctrl & tgt_mask)) {
> > +            dst =3D 0;
> > +        }
> > +    }
> > +
> > +    /* Ignore filters in case of RASEMU mode or External trap. */
> > +    if (!(tgt_ctrl & MCTRCTL_RASEMU) && !ext_trap) {
> > +        /*
> > +         * Check if the specific type is inhibited. Not taken branch f=
ilter is
> > +         * an enable bit and needs to be checked separatly.
> > +         */
> > +        bool check =3D tgt_ctrl & BIT_ULL(type + MCTRCTL_INH_START);
> > +        if ((type =3D=3D CTRDATA_TYPE_NONTAKEN_BRANCH && !check) ||
> > +            (type !=3D CTRDATA_TYPE_NONTAKEN_BRANCH && check)) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    head =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> > +
> > +    depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> > +    if (tgt_ctrl & MCTRCTL_RASEMU && type =3D=3D CTRDATA_TYPE_RETURN) =
{
> > +        head =3D (head - 1) & (depth - 1);
> > +
> > +        env->ctr_src[head] &=3D ~CTRSOURCE_VALID;
> > +        env->sctrstatus =3D
> > +            set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
> > +        return;
> > +    }
> > +
> > +    /* In case of Co-routine SWAP we overwrite latest entry. */
> > +    if (tgt_ctrl & MCTRCTL_RASEMU && type =3D=3D CTRDATA_TYPE_CO_ROUTI=
NE_SWAP) {
> > +        head =3D (head - 1) & (depth - 1);
> > +    }
>
> The code can be reduced here.
>
> if (rasemu) {
>      head =3D (head - 1) & (depth - 1);
>      if (CTRDATA_TYPE_CO_ROUTINE_SWAP) { ... }
>      else if (CTRDATA_TYPE_CO_ROUTINE_SWAP) { ... }
> }
>
> > +
> > +    env->ctr_src[head] =3D src | CTRSOURCE_VALID;
> > +    env->ctr_dst[head] =3D dst & ~CTRTARGET_MISP;
> > +    env->ctr_data[head] =3D set_field(0, CTRDATA_TYPE_MASK, type);
> > +
> > +    head =3D (head + 1) & (depth - 1);
> > +
> > +    env->sctrstatus =3D set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MA=
SK, head);
> > +}
> > +
> >   void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, boo=
l virt_en)
> >   {
> >       g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
> > @@ -1669,10 +1909,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >           !(env->mip & (1 << cause));
> >       bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
> >           !(env->mip & (1 << cause));
> > +    const bool prev_virt =3D env->virt_enabled;
> > +    const target_ulong prev_priv =3D env->priv;
> >       target_ulong tval =3D 0;
> >       target_ulong tinst =3D 0;
> >       target_ulong htval =3D 0;
> >       target_ulong mtval2 =3D 0;
> > +    target_ulong src;
> >
> >       if (!async) {
> >           /* set tval to badaddr for traps with address information */
> > @@ -1807,6 +2050,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >           env->pc =3D (env->stvec >> 2 << 2) +
> >                     ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 :=
 0);
> >           riscv_cpu_set_mode(env, PRV_S, virt);
> > +
> > +        src =3D env->sepc;
> >       } else {
> >           /* handle the trap in M-mode */
> >           if (riscv_has_ext(env, RVH)) {
> > @@ -1838,6 +2083,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >           env->pc =3D (env->mtvec >> 2 << 2) +
> >                     ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 :=
 0);
> >           riscv_cpu_set_mode(env, PRV_M, virt);
> > +        src =3D env->mepc;
> > +    }
> > +
> > +    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr=
) {
> > +        if (async && cause =3D=3D IRQ_PMU_OVF) {
> > +            riscv_ctr_freeze(env, MCTRCTL_LCOFIFRZ, virt);
> > +        } else if (!async && cause =3D=3D RISCV_EXCP_BREAKPOINT) {
> > +            riscv_ctr_freeze(env, MCTRCTL_BPFRZ, virt);
> > +        }
> > +
> > +        riscv_ctr_add_entry(env, src, env->pc,
> > +                        async ? CTRDATA_TYPE_INTERRUPT : CTRDATA_TYPE_=
EXCEPTION,
> > +                        prev_priv, prev_virt);
> >       }
> >
> >       /*
> > diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> > index 451261ce5a..b8fb7c8734 100644
> > --- a/target/riscv/helper.h
> > +++ b/target/riscv/helper.h
> > @@ -129,12 +129,16 @@ DEF_HELPER_2(csrr_i128, tl, env, int)
> >   DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
> >   DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
> >   #ifndef CONFIG_USER_ONLY
> > -DEF_HELPER_1(sret, tl, env)
> > -DEF_HELPER_1(mret, tl, env)
> > +DEF_HELPER_2(sret, tl, env, tl)
> > +DEF_HELPER_2(mret, tl, env, tl)
> >   DEF_HELPER_1(wfi, void, env)
> >   DEF_HELPER_1(wrs_nto, void, env)
> >   DEF_HELPER_1(tlb_flush, void, env)
> >   DEF_HELPER_1(tlb_flush_all, void, env)
> > +DEF_HELPER_4(ctr_branch, void, env, tl, tl, tl)
> > +DEF_HELPER_4(ctr_jal, void, env, tl, tl, tl)
> > +DEF_HELPER_5(ctr_jalr, void, env, tl, tl, tl, tl)
> > +DEF_HELPER_3(ctr_popret, void, env, tl, tl)
> >   /* Native Debug */
> >   DEF_HELPER_1(itrigger_match, void, env)
> >   #endif
> > diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/ri=
scv/insn_trans/trans_privileged.c.inc
> > index 4eccdddeaa..339d659151 100644
> > --- a/target/riscv/insn_trans/trans_privileged.c.inc
> > +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> > @@ -78,9 +78,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *=
a)
> >   {
> >   #ifndef CONFIG_USER_ONLY
> >       if (has_ext(ctx, RVS)) {
> > +        TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> >           decode_save_opc(ctx);
> >           translator_io_start(&ctx->base);
> > -        gen_helper_sret(cpu_pc, tcg_env);
> > +        gen_helper_sret(cpu_pc, tcg_env, src);
> >           exit_tb(ctx); /* no chaining */
> >           ctx->base.is_jmp =3D DISAS_NORETURN;
> >       } else {
> > @@ -95,9 +96,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *=
a)
> >   static bool trans_mret(DisasContext *ctx, arg_mret *a)
> >   {
> >   #ifndef CONFIG_USER_ONLY
> > +    TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> >       decode_save_opc(ctx);
> >       translator_io_start(&ctx->base);
> > -    gen_helper_mret(cpu_pc, tcg_env);
> > +    gen_helper_mret(cpu_pc, tcg_env, src);
> >       exit_tb(ctx); /* no chaining */
> >       ctx->base.is_jmp =3D DISAS_NORETURN;
> >       return true;
> > diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/ins=
n_trans/trans_rvi.c.inc
> > index ad40d3e87f..26633569a8 100644
> > --- a/target/riscv/insn_trans/trans_rvi.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> > @@ -75,6 +75,14 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *=
a)
> >       gen_set_gpr(ctx, a->rd, succ_pc);
> >
> >       tcg_gen_mov_tl(cpu_pc, target_pc);
> > +#ifndef CONFIG_USER_ONLY
> > +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +        TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> > +        TCGv rs1 =3D tcg_constant_tl(a->rs1);
> > +        TCGv rd =3D tcg_constant_tl(a->rd);
> > +        gen_helper_ctr_jalr(tcg_env, src, cpu_pc, rd, rs1);
> > +    }
> > +#endif
> >       lookup_and_goto_ptr(ctx);
> >
> >       if (misaligned) {
> > @@ -164,6 +172,11 @@ static bool gen_branch(DisasContext *ctx, arg_b *a=
, TCGCond cond)
> >       TCGv src1 =3D get_gpr(ctx, a->rs1, EXT_SIGN);
> >       TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_SIGN);
> >       target_ulong orig_pc_save =3D ctx->pc_save;
> > +#ifndef CONFIG_USER_ONLY
> > +    TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> > +    TCGv taken;
> > +    TCGv dest;
> > +#endif
> >
> >       if (get_xl(ctx) =3D=3D MXL_RV128) {
> >           TCGv src1h =3D get_gprh(ctx, a->rs1);
> > @@ -176,6 +189,16 @@ static bool gen_branch(DisasContext *ctx, arg_b *a=
, TCGCond cond)
> >       } else {
> >           tcg_gen_brcond_tl(cond, src1, src2, l);
> >       }
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +        dest =3D tcg_constant_tl(ctx->base.pc_next + ctx->cur_insn_len=
);
> > +        taken =3D tcg_constant_tl(0);
> > +
> > +        gen_helper_ctr_branch(tcg_env, src, dest, taken);
> > +    }
> > +#endif
> > +
> >       gen_goto_tb(ctx, 1, ctx->cur_insn_len);
> >       ctx->pc_save =3D orig_pc_save;
> >
> > @@ -188,6 +211,14 @@ static bool gen_branch(DisasContext *ctx, arg_b *a=
, TCGCond cond)
> >           gen_pc_plus_diff(target_pc, ctx, a->imm);
> >           gen_exception_inst_addr_mis(ctx, target_pc);
> >       } else {
> > +#ifndef CONFIG_USER_ONLY
> > +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +            dest =3D tcg_constant_tl(ctx->base.pc_next + a->imm);
> > +            taken =3D tcg_constant_tl(1);
> > +
> > +            gen_helper_ctr_branch(tcg_env, src, dest, taken);
> > +        }
> > +#endif
> >           gen_goto_tb(ctx, 0, a->imm);
> >       }
> >       ctx->pc_save =3D -1;
> > diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/i=
nsn_trans/trans_rvzce.c.inc
> > index cd234ad960..377d3fff70 100644
> > --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> > @@ -204,6 +204,12 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a=
, bool ret, bool ret_val)
> >       if (ret) {
> >           TCGv ret_addr =3D get_gpr(ctx, xRA, EXT_SIGN);
> >           tcg_gen_mov_tl(cpu_pc, ret_addr);
> > +#ifndef CONFIG_USER_ONLY
> > +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +            TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> > +            gen_helper_ctr_popret(tcg_env, src, cpu_pc);
> > +        }
> > +#endif
> >           tcg_gen_lookup_and_goto_ptr();
> >           ctx->base.is_jmp =3D DISAS_NORETURN;
> >       }
> > @@ -309,6 +315,20 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_c=
m_jalt *a)
> >           gen_set_gpr(ctx, xRA, succ_pc);
> >       }
> >
> > +#ifndef CONFIG_USER_ONLY
> > +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +        /*
> > +         * We are reusing helper_ctr_jal() here. If rd is x1 or x5,
> > +         * this will record a direct call (cm.jalt) and if it's x0
> > +         * then this will record a direct jump (cm.jt).
> > +         */
> > +        TCGv rd =3D tcg_constant_tl(a->index >=3D 32 ? 1 : 0);
> > +        TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> > +        gen_helper_ctr_jal(tcg_env, src, addr, rd);
> > +    }
> > +#endif
> > +
> > +
> >       tcg_gen_mov_tl(cpu_pc, addr);
> >
> >       tcg_gen_lookup_and_goto_ptr();
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index 25a5263573..5a1e92c45e 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -259,10 +259,12 @@ void helper_cbo_inval(CPURISCVState *env, target_=
ulong address)
> >
> >   #ifndef CONFIG_USER_ONLY
> >
> > -target_ulong helper_sret(CPURISCVState *env)
> > +target_ulong helper_sret(CPURISCVState *env, target_ulong curr_pc)
> >   {
> >       uint64_t mstatus;
> >       target_ulong prev_priv, prev_virt =3D env->virt_enabled;
> > +    const target_ulong src_priv =3D env->priv;
> > +    const bool src_virt =3D env->virt_enabled;
> >
> >       if (!(env->priv >=3D PRV_S)) {
> >           riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> > @@ -309,10 +311,15 @@ target_ulong helper_sret(CPURISCVState *env)
> >
> >       riscv_cpu_set_mode(env, prev_priv, prev_virt);
> >
> > +    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr=
) {
> > +        riscv_ctr_add_entry(env, curr_pc, retpc, CTRDATA_TYPE_EXCEP_IN=
T_RET,
> > +                            src_priv, src_virt);
> > +    }
> > +
> >       return retpc;
> >   }
> >
> > -target_ulong helper_mret(CPURISCVState *env)
> > +target_ulong helper_mret(CPURISCVState *env, target_ulong curr_pc)
> >   {
> >       if (!(env->priv >=3D PRV_M)) {
> >           riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> > @@ -350,9 +357,124 @@ target_ulong helper_mret(CPURISCVState *env)
> >
> >       riscv_cpu_set_mode(env, prev_priv, prev_virt);
> >
> > +    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr=
) {
> > +        riscv_ctr_add_entry(env, curr_pc, retpc, CTRDATA_TYPE_EXCEP_IN=
T_RET,
> > +                            PRV_M, false);
> > +    }
> > +
> >       return retpc;
> >   }
> >
> > +/*
> > + * Indirect calls
> > + * - jalr x1, rs where rs !=3D x5;
> > + * - jalr x5, rs where rs !=3D x1;
> > + * - c.jalr rs1 where rs1 !=3D x5;
> > + *
> > + * Indirect jumps
> > + * - jalr x0, rs where rs !=3D x1 and rs !=3D x5;
> > + * - c.jr rs1 where rs1 !=3D x1 and rs1 !=3D x5.
> > + *
> > + * Returns
> > + * - jalr rd, rs where (rs =3D=3D x1 or rs =3D=3D x5) and rd !=3D x1 a=
nd rd !=3D x5;
> > + * - c.jr rs1 where rs1 =3D=3D x1 or rs1 =3D=3D x5.
> > + *
> > + * Co-routine swap
> > + * - jalr x1, x5;
> > + * - jalr x5, x1;
> > + * - c.jalr x5.
> > + *
> > + * Other indirect jumps
> > + * - jalr rd, rs where rs !=3D x1, rs !=3D x5, rd !=3D x0, rd !=3D x1 =
and rd !=3D x5.
> > + */
> > +void helper_ctr_jalr(CPURISCVState *env, target_ulong src, target_ulon=
g dest,
> > +                     target_ulong rd, target_ulong rs1)
> > +{
> > +    target_ulong curr_priv =3D env->priv;
> > +    bool curr_virt =3D env->virt_enabled;
> > +
> > +    if ((rd =3D=3D 1 && rs1 !=3D 5) || (rd =3D=3D 5 && rs1 !=3D 1)) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_INDIRECT_CALL=
,
> > +                            curr_priv, curr_virt);
> > +    } else if (rd =3D=3D 0 && rs1 !=3D 1 && rs1 !=3D 5) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_INDIRECT_JUMP=
,
> > +                            curr_priv, curr_virt);
> > +    } else if ((rs1 =3D=3D 1 || rs1 =3D=3D 5) && (rd !=3D 1 && rd !=3D=
 5)) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_RETURN,
> > +                            curr_priv, curr_virt);
> > +    } else if ((rs1 =3D=3D 1 && rd =3D=3D 5) || (rs1 =3D=3D 5 && rd =
=3D=3D 1)) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_CO_ROUTINE_SW=
AP,
> > +                            curr_priv, curr_virt);
> > +    } else {
> > +        riscv_ctr_add_entry(env, src, dest,
> > +                            CTRDATA_TYPE_OTHER_INDIRECT_JUMP, curr_pri=
v,
> > +                            curr_virt);
> > +    }
> > +}
> > +
> > +/*
> > + * Direct calls
> > + * - jal x1;
> > + * - jal x5;
> > + * - c.jal.
> > + * - cm.jalt.
> > + *
> > + * Direct jumps
> > + * - jal x0;
> > + * - c.j;
> > + * - cm.jt.
> > + *
> > + * Other direct jumps
> > + * - jal rd where rd !=3D x1 and rd !=3D x5 and rd !=3D x0;
> > + */
> > +void helper_ctr_jal(CPURISCVState *env, target_ulong src, target_ulong=
 dest,
> > +                    target_ulong rd)
> > +{
> > +    target_ulong priv =3D env->priv;
> > +    bool virt =3D env->virt_enabled;
> > +
> > +    /*
> > +     * If rd is x1 or x5 link registers, treat this as direct call oth=
erwise
> > +     * its a direct jump.
> > +     */
> > +    if (rd =3D=3D 1 || rd =3D=3D 5) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_DIRECT_CALL, =
priv,
> > +                            virt);
> > +    } else if (rd =3D=3D 0) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_DIRECT_JUMP, =
priv,
> > +                            virt);
> > +    } else {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_OTHER_DIRECT_=
JUMP,
> > +                            priv, virt);
> > +    }
> > +}
> > +
> > +/*
> > + * Returns
> > + * - cm.popret
> > + * - cm.popretz
> > + */
> > +void helper_ctr_popret(CPURISCVState *env, target_ulong src, target_ul=
ong dest)
> > +{
> > +    riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_RETURN,
> > +                            env->priv, env->virt_enabled);
> > +}
> > +
> > +void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ul=
ong dest,
> > +                       target_ulong branch_taken)
> > +{
> > +    target_ulong curr_priv =3D env->priv;
> > +    bool curr_virt =3D env->virt_enabled;
> > +
> > +    if (branch_taken) {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_TAKEN_BRANCH,
> > +                            curr_priv, curr_virt);
> > +    } else {
> > +        riscv_ctr_add_entry(env, src, dest, CTRDATA_TYPE_NONTAKEN_BRAN=
CH,
> > +                            curr_priv, curr_virt);
> > +    }
> > +}
> > +
> >   void helper_wfi(CPURISCVState *env)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index 15e7123a68..07391297e8 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -572,6 +572,16 @@ static void gen_jal(DisasContext *ctx, int rd, tar=
get_ulong imm)
> >           }
> >       }
> >
> > +#ifndef CONFIG_USER_ONLY
> > +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +        TCGv dest =3D tcg_constant_tl(ctx->base.pc_next + imm);
> > +        TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> > +        TCGv tcg_rd =3D tcg_constant_tl((target_ulong)rd);
> > +
> > +        gen_helper_ctr_jal(tcg_env, src, dest, tcg_rd);
> > +    }
> > +#endif
> > +
> >       gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
> >       gen_set_gpr(ctx, rd, succ_pc);
> >

