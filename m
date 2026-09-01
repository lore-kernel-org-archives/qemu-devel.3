Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20951C61DFD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ef0-0001vK-Pm; Mon, 31 Aug 2026 22:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1Eey-0001up-RH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:55:40 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1Eew-0005NS-Ui
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:55:40 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5b4ab40d839so4094247e87.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 19:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788231336; cv=none;
 d=google.com; s=arc-20260327;
 b=S2u09PHG6r7sFPfoRATUE9XIw4Oa2dE3DR/LJC9fOSMOF82Qo2ARLMGdmJ13mPtqh1
 d70GQqSmfVAHE7iRHf6MmUOhc9voDsc7AGFrKlGR1iSyLnvO8FLf5oEIWTnTZc9RpIMC
 njPqxHYnLDo1cAFK2oQC+9az/2cNm32Ds+enjL2AzoELXI62gjqehxriSwlKUXtPOLPE
 pzaaYYDNdOFbJY9/0CkebVyVQnsTSz9EHgpKbiD99wUntWS7CremYqX5y5FKdD0WPyGy
 WqVIhhAcpbww7ikoGJLUUwR7+ZmBqB5LGW+v8cFzgWZsP4rAtFfu1np/1Acf7RhztFuU
 mTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=judF+7VNBVLISGbwC+C3z7r96CarS5b5R5YR9O8GCGc=;
 fh=QVe/7zv5OrYmrprO28ljpRmhYeOlvvTBoRQtHWn+3sI=;
 b=n7h77WxTwCNNWQqM9uqJTduT4bPx3AUHWuF11NYx1jEomx6HC/XJYvKTQx/s3i9bxG
 KMm2NmvvbHORMUNb0c1fdp6qFGdl2i1Lwz9DAeDrRnYepFI8Bgsxn8zbz8GRuFjV2mVE
 JuK1laqob+Cb0YqdylYpCN5cx2IgPV7TBGTS7VbMpDzAlWo97GYWjuRCREmjtVzq/FCm
 m/JQcaFBZjPcH76Dh3F+Lc+UOx14LP+faXz0Nh9LLb64NXRKwC2OxfftSepNhQT4NEO0
 1yWlqbgQEIv3B8u6cNssa8tRBNPbHBxLx45YVB9Hwa0fBBwZLykw3C9DFkRTIM5UVH6e
 EdVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788231336; x=1788836136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=judF+7VNBVLISGbwC+C3z7r96CarS5b5R5YR9O8GCGc=;
 b=SgXcqKkTeUqxbGIdOI/XWwAjXpwh1Ev1pR+H9OzJy8eSkB5RiQdhgCE+BLe29M1vBP
 yYvPTGQXu64/1GXKPtcTdPcvyrGWaqV+nYfh2aN8T65kckxs1ny0nZnA8Jz/JabrECW7
 FK9HEfSFaSUqfpagt6BMQfrrwRHaP7XAZSZhztCUDBVgwxGFbmtTJM1lWwFmfkQkeuZo
 AtCkgjuMCF2hJSIPBWt2Og4j4cLsO5dE7aRXKV76KI0FvOMOVpT8hMNZBkPcME3mSIeP
 MyTJvxgBE7YpBNEdUkvLcM4WFnZCTxI2oyn9zYJ74dl/3kkduOf4bf+/gUgnBGQk9smd
 s23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788231336; x=1788836136;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=judF+7VNBVLISGbwC+C3z7r96CarS5b5R5YR9O8GCGc=;
 b=D5VYieTcqXWLhSmdUqSN1docQUTny1eXn4Jpn2p5cOWQYdODVcJ535pRsUuFkcSgY8
 F9q8LcvPkSPEregrm7VY1QJowtaYxqHeuxHgDTzK64bLae/GxfDvHcV8UiEoD8K3wDbv
 YEV0HG8hs4EDxBvmP35VbJ4kkAD0bh8HeN//h0JOVquYD0rOF5OUZUeqmiPevG0+w4m2
 nBlvEHZgWUwKr0IJeoUm2MhRyZUtm1+2iar/i2QmoYJDguo4uN1pHUAfWK3O5SU0ARBg
 ulyodhqxqcArJ2aCJuLAMwYVBtTxQM/1SvAtEdLuxa/Vhi+IpZPh5P0i7P+4oLJENupv
 4lGA==
X-Gm-Message-State: AFuF++nihzJqMfEznAeYeJxD7YrexwT13xliOQdXW2raqRp9peM96O2p
 wY8JAJ35FUhKXsYJC3DmjD5JO9WmX92qnZF1Ul5Ku3uKpvUYvG+3Kc17H1Sj0QBYYm/XI61HpAU
 p65VPXSmL8+Ew0RHxmUCzdhF5X7oObwA=
X-Gm-Gg: AYBFou2us03fblpz80Tm9ySWmhcJ9iC6Kenj0irxE94nz5RMIAKBnKc0lFtuSS1lqfb
 1LgNdOAdFOqRKoD5Qy7vgAiAyFlFGgTZqx07bEHUPDCoYCExtUr+9nHLCtWt76MDJB+zayDmd5N
 iB0kZ31e73vJd6BQTlse7qMG6M6n8o4h+HrqAals2F6y/FfgQD+dMtlitHZ/DrFNw0XfKGp1/sI
 a1k8nX2/7HPIWoNW1A2u4t/22Y+KfE4yFiKHvSE1HLrUjewLNDc43MF1SLojfZHpcFJn9V/7/pf
 SWT+uc4abvHnoElPgz7ff4z/krYeDBYdUwQAbl7nI3XmVPRaoV0Dg55+gQ==
X-Received: by 2002:a05:6512:3b85:b0:5b5:e29b:a1df with SMTP id
 2adb3069b0e04-5b5fe0b39d5mr1567802e87.8.1788231335723; Mon, 31 Aug 2026
 19:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-5-mattst88@gmail.com>
 <dcd678bb-83ca-4a41-8230-66fd72278bde@linaro.org>
In-Reply-To: <dcd678bb-83ca-4a41-8230-66fd72278bde@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 31 Aug 2026 22:55:20 -0400
X-Gm-Features: AcwNN1WmfdlDhxd_iafuGEwYr58IaVNgs11QF4JYXNzXEc0fNZ--7ku76tuGPXU
Message-ID: <CAEdQ38F3PRUpOuUqJwtCPJeZ=mLVE2rz6tqD2zDB=FcthuxNJA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] tcg: pass the destination to
 tcg_gen_lookup_and_goto_ptr()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com, 
 alex.bennee@linaro.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x133.google.com
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

On Thu, Aug 27, 2026 at 7:13=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/26/26 22:02, Matt Turner wrote:
> > tcg_gen_lookup_and_goto_ptr() takes no arguments and emits a call to
> > helper_lookup_tb_ptr(), which recovers the destination PC from env by
> > calling back into the target through TCGCPUOps::get_tb_cpu_state(). At
> > translation time the caller already has the destination PC in a temp, a=
nd
> > knows the flags, cflags and cs_base any destination it may reach has to
> > match, because they are the ones the block being generated was translat=
ed
> > with.
> >
> > Pass both, so that a later patch can use them to look the destination u=
p
> > inline. Nothing reads them yet and the generated code does not change.
> >
> > The contract on @pc is the whole of the interface: it must hold exactly
> > what get_tb_cpu_state() reports as the pc for the destination block. Fi=
ve
> > targets keep their PC in a temp whose value is that pc by construction =
and
> > so can pass it: alpha, loongarch, mips, ppc and s390x. Everything else
> > passes NULL and keeps today's behavior.
> >
> > For six of those the TB pc is derived and passing the PC temp would be
> > wrong: avr's TB pc is the word address doubled, i386's is eip before
> > segmentation, riscv masks it to 32 bits when xl is MXL_RV32, hppa deriv=
es
> > it from the IAQ, hexagon adjusts it inside a hardware loop, and sparc p=
uts
> > npc in cs_base. The remaining seven -- arm, m68k, microblaze, or1k, rx,=
 sh4
> > and tricore -- look like they could pass it, but I have not convinced
> > myself of the contract for them and have nothing to test them with. Eac=
h is
> > a one-line change for whoever wants it.
> >
> > The common entry point takes a TCGTemp rather than a TCGv and reads the
> > width from it, because the translators that are built for both values o=
f
> > TARGET_LONG_BITS -- arm, s390x, microblaze -- cannot include tcg-op.h.
> > tcg-op.h wraps it for everyone else. This is the same split as
> > tcg_gen_qemu_ld_*_chk().
> >
> > v4: Split out of "tcg: probe the TB jump cache inline instead of callin=
g a
> >      helper", which did the API change and the inline probe in one patc=
h.
> >      Requested by Richard Henderson.
> >
> > Signed-off-by: Matt Turner<mattst88@gmail.com>
> > ---
>
> Ok, I was a bit surprised at your claim that only 5 targets qualify, as
> there are plenty that have a simple PC.
>
> However! The subtlety of the interface, that we are asserting that the
> current TranslationBlock flags are still valid, now leads me to think
> that it's a mistake to adjust the current interface.
>
> We need to introduce a new interface to which targets may be migrated.
> This won't be difficult, but it's not entirely trivial.
>
> For instance, target/arm/ has
>
>          case DISAS_UPDATE_NOCHAIN:
>              gen_update_pc(dc, curr_insn_len(dc));
>              /* fall through */
>          case DISAS_JUMP:
>              gen_goto_ptr();
>              break;
>
> where DISAS_UPDATE_NOCHAIN requires the helper because of state change
> and DISAS_JUMP does not.
>
> This is subtle enough that we probably want to verify that the flags are
> unchanged with --enable-debug-tcg.

Agreed, and done.  tcg_gen_lookup_and_goto_ptr(void) is unchanged in
v5. Nothing that isn't migrated sees any difference.

> Perhaps tcg_gen_goto_jc_{i32,i64,tl)?

Sounds good. Done.

Replying to bits out of order:

> The simplest solution, IMO is to define functions for _i32 and _i64, as
> for most everything else, and to have a _tl alias in tcg-op.h.

Also done -- the _tmp()/TCGTemp form is gone.  tcg_gen_goto_jc_i32()
and tcg_gen_goto_jc_i64() are declared in tcg-op-common.h, and
tcg-op.h has the _tl alias in each TARGET_LONG_BITS arm alongside the
qemu_ld/st ones. The _i32 entry point zero-extends into a temp and
shares the body, so there is one implementation.

s390x is the one migrated target that cannot include tcg-op.h, so it
calls tcg_gen_goto_jc_i64(psw_addr) directly; that reads fine.

> the subtlety is asserting that the current TB flags are still valid ...
> target/arm: DISAS_UPDATE_NOCHAIN requires the helper because of the
> state change, DISAS_JUMP does not.

Right, and that distinction is exactly what the new interface makes
the caller state.  The contract is now written dow the goto_jc runs,
the CPU state must already be the destination's -- @pc must be what
get_tb_cpu_state() would report, it would report must be the ones this
block was translated with.  A translator that hasn't finished updating
state lookup key (avr's word address, i386's eip before segmentation),
keeps using tcg_gen_lookup_and_goto_ptr().

> we probably want to verify that the flags ar
> --enable-debug-tcg

Done.  Under CONFIG_DEBUG_TCG the goto_jc emits a call to a new
helper_goto_jc_check(env, pc, flags, cs_base), get_tb_cpu_state() and
asserts all three against what the block was translated with.  It
costs nothing in a normal contract being stated rather than assumed
while I migrated the targets.

Five targets are migrated in v5: alpha, loongarch, mips, ppc and s390x
-- the ones whose lookup_and_goto_ptr sites are u already the
destination's, and the pc register is the key".  arm, i386 and the
rest are untouched and can be migrated point of it being a separate
interface.

All five build and run their indirect-dispatch paths (computed goto,
function pointers, returns, and a longjmp out completion under
--enable-debug-tcg, so the assert has actually been exercised on each.

