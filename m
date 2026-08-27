Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E63FC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSBz-0003Ww-VS; Thu, 27 Aug 2026 00:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBy-0003V7-JV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:58:22 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBw-0000xW-Pf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:58:22 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39f20d19895so13871891fa.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787806699; cv=none;
 d=google.com; s=arc-20260327;
 b=ISTsrIEaIwlDRzGVJcSjgm7LVCO3333mPp70sORxwUbQmziH2qdZvUjzRKU6E4IJxK
 YZwL+LjP7cwZpSdevp/leVAq0c0B4hilpI4JLgWXsTMKJNWiEdzQHOJcSctQu3sobh5u
 AcLPVrQfY/1X45h77MH2VgNy+ZfS7ycSqKP5Lmn98yoqJ09b4cxIdhoADi/m/DNkI5cI
 ISjaFbzarORJqjJOM5aW0ujFZQAnlXP5rVuPH0XUy2JeoQmPNiEpLb3uYEVvaBpQ9a2k
 G1w133p/nk2kArCNEP02S6UCp7/6lihRA2UfSn7x697NG3pO4ihRPQCXtPkURxeCwv7W
 LFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LrZxT18D2451JlJlmox0DJE83batWQGKJmS6PBE8pd4=;
 fh=QVe/7zv5OrYmrprO28ljpRmhYeOlvvTBoRQtHWn+3sI=;
 b=aaVGoqD12BL1rjODUMUeTwWB2iq1SJJ2/UT9KbmmYkv18HwkgV3J+UdFGFd5iupQVH
 a+V0UsAq6qAWgcrCajJ2k0unuV7eKp0RjjDcsWImWsXTLb67rpo0IlPrgYDqVeMSzWjr
 TiDbWI1omUES/Dp9AFO4DwppCz7wigem1ryiyVuMRNnN8cdHaK9ARhhnKdui4QfBoPTu
 0NrGuGcqu6/2WzZTFNlmY0TA76t/jcIWm9ephntoLXkA8LyoKe5CMyxm1jkaOdyzTQkj
 ZzI9GaM5oA2oJRNV2KZ6MMIQru/FIZYqzeMDqRYjG0QzBdq/89tGT/m8879Nn0kKaKo0
 F+MA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806699; x=1788411499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LrZxT18D2451JlJlmox0DJE83batWQGKJmS6PBE8pd4=;
 b=TUrKyziyInP9bzVTk7cKEpRqZaDL24VI2xsaEj2hpOAbBELvmwUInTtNzNb86Aj+7c
 CT4PCPXiw4UGcN9Gbas5nmDmIzgboICbegWBcssK+StAKlF+vX+TzdUghYxJ5ZS2rMiL
 g/QGDzOW49PkoQpo2g7207VfqD1+3qG6xdGI9EkfD7XLoCYHgyCqNoy794U//nUxlksv
 mrOLk4NyEUkIGDS+VAnX2kNVLTOI0p3hkZgm2pWvDNYrwvc4hV9GztGeG9egmIwQT+v/
 ViGeS15hnWdGZyLpK9Zhm1nuW1Aw8P0qxZKAzmzZ8nG8mGumbQwx2FSa626KZsDtH3UV
 +8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806699; x=1788411499;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LrZxT18D2451JlJlmox0DJE83batWQGKJmS6PBE8pd4=;
 b=AIX4Q3s5Kt2RlKSQu9ol3gc1Dpqm66g2vBz1LYAc+NFqAye8sVkIglf0MqgbkzdmHJ
 NTxWhAxLclotpXYcT4HJxWNWeM+MBPMe5Q6prDHqvKWuleMlrE8oseyTUkvpMAkfuMby
 iroveBlTflMySEpCgwel4xnfEFx2vpHgNA0grO7Kqk53K18LKRx02nccin3QeXleEYPM
 XZa8RMnNkaXaZmJDH8Rc3PCVDYge+2yrHsbeMDWOfbTOAAGi4Rn0EOotTpUzaUGd0lSJ
 GY4Uu3/wTAqL+IPJjcPW+1NNvGEsryooh8aFdEeNugmaptj1LJ/IaZ8H7FSCLxjD9zBM
 HcEw==
X-Gm-Message-State: AFuF++mE4ZDi8knT1T8SEl4lsy8sPf+RerPNLRPhbCYt18mHhbAHLFIE
 ppOZAawpDt+BEmVqyhv6YMJ7rsMfS+OLGJVckldn70euonqSfqA6Ky89ZkrKfl3BDlQkM+WCOoT
 9fAnnb5CzSV1Q76BFx5n6w9rJ1cCUTrw=
X-Gm-Gg: AR+sD11qwy9j8gWhTHdsUKLjCEusJOvxotEqOL9FFya8c+xptSPhoGRtf5/yq31BChU
 LKzfmcnh9KkIJtrPGHTkINHKJuWojY4VVUGs2wLcAxrQd5FkCw/21mRTWbyBa8gGtLwFN/kKsIy
 2DU2cem3NPBgsM5cl3T7LMnCyxjE/kiHCX86wQ4IiKVEaEUBObA1zBazH2PUCDCUC4PKUb861VO
 csrUsN524vy4q0DJ6x3QwtOomjiDpgLktymnIQ+NMlyizt43E9xGLohCNgKz4CYQBZdp3+yC6Ay
 ikR8/1ZA5bfUlQ8pgUEnj0I9wD0pQ003nJ+idOqYRdR1C+W8zo8eR1hf3g==
X-Received: by 2002:a05:651c:f16:b0:39c:920f:c486 with SMTP id
 38308e7fff4ca-3a1fd490e8fmr29377521fa.6.1787806698869; Wed, 26 Aug 2026
 21:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-8-mattst88@gmail.com>
 <4645e775-b0c9-45a2-a064-17fabc3db431@linaro.org>
In-Reply-To: <4645e775-b0c9-45a2-a064-17fabc3db431@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 27 Aug 2026 00:57:58 -0400
X-Gm-Features: AcwNN1UpVEM3MjBU7oLqnF71TwhmHT1dKMtDUJkiqcNF8TfgCCit3r0_BgAKXwM
Message-ID: <CAEdQ38FPhP9Fmnj2cqzPqRt8MMEjKju0xihLYfwhW72x-jT19Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] RFC: tcg: fold a guest displacement into the host
 addressing mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com, 
 alex.bennee@linaro.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x235.google.com
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

On Tue, Aug 25, 2026 at 6:52=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/22/26 12:08, Matt Turner wrote:
> > RFC because:
> >
> > - Only wired up for x86_64, and only for qemu_ld and qemu_st; the i128
> >    qemu_ld2 and qemu_st2 pairs are left alone.
> > - Requiring that no slow path exists is stricter than necessary. Record=
ing
> >    the displacement in TCGLabelQemuLdst and emitting one lea on the slo=
w
> >    path would cover alignment-checked accesses too, at no fast path cos=
t.
> > - Softmmu wants the displacement folded into the TLB comparison as well=
,
> >    which is a bigger change than this one.
> > - A one op window catches everything the frontends emit today but is
> >    trivially defeated by anything scheduled in between.
>
> Plausible.  Several times I've considered exposing complex addressing
> modes to the translators so that things that do LEA are kept intact for
> awhile.  There are plenty of host-specific code sequences for x << s + y
> + c, even before we fold that into the memory access.  Then expose the
> host memory path to tcg ops, somehow, and finally implement a simple CSE
> pass.  But yeah, hand waving is as far as I've ever gone.

That's the shape I kept wanting. A one-op peephole is a poor
substitute, and it loses the moment anything is scheduled between the
add and the access. I went this way because it needed no frontend
changes; happy to look at the op instead if you'd rather.

> On the second point, I guess you also assuming the offset is also
> aligned?  I.e. for X + 8*N, you can test X for 8-byte alignment without
> constructing the complete address.

Right, and that's what makes the second bullet worth doing. If disp is
a multiple of the required alignment, X + disp is aligned exactly when
X is, so the fast path test can stay on the base and never needs the
full address. That covers every displacement a frontend emits for a
struct or stack access.

What's left is the slow path, which hands addr_reg to the helper --
and addr_reg is now the base. Recording the displacement in
TCGLabelQemuLdst and emitting one lea there fixes it at no fast path
cost. v4 spells that out in the bullet but still refuses any access
needing a test.

> > +static bool tcg_target_ldst_disp_ok(TCGContext *s, MemOpIdx oi, int64_=
t disp)
> > +{
> > +#ifdef CONFIG_USER_ONLY
> > +    MemOp opc =3D get_memop(oi);
> > +    TCGAtomAlign aa;
> > +    int64_t ofs;
> > +
> > +    if (tcg_use_softmmu || s->addr_type !=3D TCG_TYPE_I64) {
> > +        return false;
> > +    }
> > +    aa =3D atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16,
> > +                                (opc & MO_SIZE) =3D=3D MO_128);
> > +    if (aa.align) {
> > +        return false;
> > +    }
> > +    ofs =3D (int64_t)x86_guest_base.ofs + disp;
> > +    return ofs =3D=3D (int32_t)ofs;
> > +#else
> > +    return false;
> > +#endif
> > +}
> These compilation mode tests belong...
>
> > +static void __attribute__((noinline))
> > +fold_ldst_disp(TCGContext *s)
> > +{
> > +    TCGOp *op;
> > +
> > +    if (!TCG_TARGET_HAS_ldst_disp) {
> > +        return;
> > +    }
> ... here, before we step over the loop.  You might as well pass MemOp to
> the target function and not MemOpIdx -- nothing about the mmu_idx is
> relevant.
>
> Ideally, the atom_and_align test would also be done generically, not
> requiring each target to replicate that boilerplate.

All three done. x86_64 is now just:

    ofs =3D (int64_t)x86_guest_base.ofs + disp;
    return ofs =3D=3D (int32_t)ofs;

The alignment one needed a compromise. atom_and_align_for_opc() takes
host_atom and allow_two_ops and both feed aa.align, so a generic
caller either gets them from the target -- the same boilerplate, moved
to tcg-target.h -- or answers without them. I answered without them: a
small ldst_disp_needs_align() that gives the answer for the most
restrictive
host.

Exact for MO_ATOM_NONE and the IFALIGN cases, i.e. everything
frontends emit by default, so the alpha numbers don't move.
Conservative for MO_ATOM_WITHIN16 and MO_ATOM_SUBALIGN: x86 could take
those folds and no longer does. One #define of the host atomicity next
to TCG_TARGET_HAS_ldst_disp gets that back if you'd rather have it
exact.

