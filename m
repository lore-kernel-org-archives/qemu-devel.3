Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CD3C624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Eeu-0001uR-CW; Mon, 31 Aug 2026 22:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1Ees-0001ts-KB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:55:34 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1Eeq-0005N0-W1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:55:34 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3a1981228f8so38067141fa.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 19:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788231331; cv=none;
 d=google.com; s=arc-20260327;
 b=D6Sy4xOUFypUOf8G0XWLkFK4LMxZvk3dATrKyWL6sGyHle4VsJEr7b7ZechdCCCyGs
 x9B8k86DmLq8P0rJP6lnmy2acpw0QgYsWwZfwnR4RslzyykY3OJ+NmTKDiSdM2FrSV9Y
 MUjx+HdqM8LVBHPbTDC/VZ8tMrUmyRfXpQ79jG99Ee+iBLel2p3hmKHnulfr0QhIt9Is
 /rsCH3JL502aWsTxbrwNhuyZ/CkPJ4mALZ3EIJDAlhFSfo6DfZLUyycAAOvjioPI1Iyt
 E9kjBNCA3oOTN/eoXcFmoyHQ9sP2gcK9kJacu5o0Q4AjV8xfbIvBubEynHzw6msRA8fG
 W/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J4hzdpcPvQ19JekSIhEi2Y4CpyK+88jHsfCTjIEeyxc=;
 fh=QVe/7zv5OrYmrprO28ljpRmhYeOlvvTBoRQtHWn+3sI=;
 b=FgfnxQwdJrVMO8D+UpYi+u1EARhpOUU2e0rWhVdkSazbFmkp0XKLfQIQ3l0t1REQ8Q
 y5c6vfpn07X0LWd+qQ44RuSZ+ld7y81xvYv2SA1njLHo5NvKyBMfzZKlolj1SiGCRrwd
 1xgP8i3MhKxatXnrAHew98nA7spN3us0+q3bfHUVUNmHJqIXHv9HffmaseQuyBh10bUq
 A9VqawQDBRyUmXip4J/LgPHna9rgBIrosmBRt6tRU4tUi4kS2ccs1oyLMidxfoyuSHA9
 jN+dEEhUdtXOR2pZ17aEI8rivMgN5kM222yHeRbJ4oE9hHXNpdteqUBEFERGp5dlTCXG
 nDNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788231331; x=1788836131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J4hzdpcPvQ19JekSIhEi2Y4CpyK+88jHsfCTjIEeyxc=;
 b=YWyJwCKbVC2/Gs7upWiTE9yZsTN8IcJ65Du8I7V3nIAez1ggqn1poQD8pn7H6bAZUW
 0y3Yb9vym1bPkEq3X+4Ydg6+OSGnScdSJwgEBlbiKdEQo40EHnii8JcM+DdcokWRnXrw
 5ejtFjv8oWM8biyOo6+oEUemDKkghij52SWNV+65sriNiTRhiKR41SQSsysvJMhuiWqN
 KmzVsaNhnHoNz2jqNy/C9FkAqgnJHxWSTygRh75k3HUgtffO430BdfUeHiFIYjqIKoix
 zcqUMpZXNiKsNLa/rIoYNK+s+FJqYvFoIbFgMNgBAVkKc/gmeZ+FdhjgbvONGeuDEqpn
 j4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788231331; x=1788836131;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4hzdpcPvQ19JekSIhEi2Y4CpyK+88jHsfCTjIEeyxc=;
 b=CYHw2TEAeDvmm8JYFa1Cp5sefhg4b+hV4Muu6MR/JNcqEr+gtzofPcwPKVg5XXMDNK
 FgVD/VuH7CsXVHRDGXF9vhroxNz0hwPN0L3pn+TV+dAnM/7gdeRHqMwcJ4nLyUJBQs6x
 EgdklNrPl7NGv+/0Z+VKpjF71Z9C/g/WPhAw8w0EkdgnAUqMCEFn3XQB+b9+i5PmXwpF
 vyiNYrjHFdSOMS4okXLn+H2lGyQyC/lRE9vrpvTy7a7qZrAhWcUkQzN7I/6rPUI/ltQA
 o5KogMcRe6HM91BwVaf675u7q0t1zHbUJhBQEXiUOMRuElqZZVvFSnk2OGiIiqdCbRVr
 tjFA==
X-Gm-Message-State: AFuF++mfuT72Tdg34UxuA4yOGDZUVKSzHSzpUB5RadhGhZJzeThKfxIp
 MSoL0Hb95J5i54KBD5fmEBEWj0WI7UcwcoUWxyp0y//88wWnug8mbflvwBejDTpUfxMbWKuIN8J
 vossBnF2m7GsgFEFDpafqKuevjFNR0LY=
X-Gm-Gg: AYBFou2B7efWllsDiw5aLdc6UA9i7y13KCI69vlBfb8He8h/G7wBTKcUhPYg5G688e1
 ZN3vMmpT3IpXIJpfB6oAOiVEhmQ/t5MilEBrAtvP191uiye2UUm0AY4SpAI+Chte2tY5M2zoInz
 HZ1jmWQug597hJ8X2Kk2+IWJGPHG934etInPCIVrAI+1qgJaPv6FOhMwVc4K++FLeGJECPjCYOp
 UckARlSe21tSPS9dpbCIgRAaRFn62/4RiGowfdmQB26fdq2GgMVbJdg26wX0rC1gQBlTbTrU2Tc
 tGDdaqy8LvTfcEkqCJj4o1ktRDFIzR8bmE6BOMN33AChAEc=
X-Received: by 2002:a2e:a985:0:b0:3a1:b1e4:419c with SMTP id
 38308e7fff4ca-3a301b12edfmr63831081fa.10.1788231330817; Mon, 31 Aug 2026
 19:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-7-mattst88@gmail.com>
 <b6265b43-8f26-4703-9ca1-88214c06905a@linaro.org>
In-Reply-To: <b6265b43-8f26-4703-9ca1-88214c06905a@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 31 Aug 2026 22:55:16 -0400
X-Gm-Features: AcwNN1XktwDIwbPf-ykUVNXaeFKsy8HIFk3e5sF9biUztopIxEImgmP0uP07BBI
Message-ID: <CAEdQ38FjS+GWYVR2UEApMSE7pJaTBYQrXbArHaBa3+epHTuHaQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] RFC: tcg: probe the TB jump cache inline instead
 of calling a helper
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com, 
 alex.bennee@linaro.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 27, 2026 at 7:34=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/26/26 22:02, Matt Turner wrote:
> > +static void gen_jmp_cache_probe(TCGv_i64 pc, const TranslationBlock *t=
b)
> > +{
> > +    TCGv_ptr jc, ent, tbp, ptr;
> > +    TCGv_i64 h, tmp;
> > +    TCGLabel *slow;
> > +    uint64_t fpair;
> > +
> > +    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) !=3D 16);
> > +    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 !=3D 0);
> > +    /* One 64-bit load has to cover both, so they must be adjacent... =
*/
> > +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=3D
> > +                      offsetof(TranslationBlock, flags) + 4);
> > +    /* ...and aligned, which nothing else currently relies on. */
> > +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) % 8 !=3D 0);
> > +
> > +    jc =3D tcg_temp_ebb_new_ptr();
> > +    ent =3D tcg_temp_ebb_new_ptr();
> > +    tbp =3D tcg_temp_ebb_new_ptr();
> > +    ptr =3D tcg_temp_ebb_new_ptr();
> > +    h =3D tcg_temp_ebb_new_i64();
> > +    tmp =3D tcg_temp_ebb_new_i64();
> > +    slow =3D gen_new_label();
> > +
> > +    /* ent =3D &jc->array[tb_jmp_cache_hash_func(pc)] */
> > +    gen_jmp_cache_hash(h, pc);
> > +    tcg_gen_shli_i64(h, h, 4);
> > +
> > +    /*
> > +     * Not cpu->tb_jmp_cache: the probe reads its own base so that the=
 main
> > +     * loop can poison it, which is how conditions the probe cannot te=
st for
> > +     * itself force every dispatch back into the helper.  See
> > +     * tcg_cpu_sync_jmp_cache().
> > +     */
> > +    tcg_gen_ld_ptr(jc, tcg_env,
> > +                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPU=
State));
> > +    tcg_gen_trunc_i64_ptr(ent, h);
> > +    tcg_gen_add_ptr(ent, jc, ent);
> > +
> > +    /*
> > +     * The pc first: on a hash miss it is the field most likely to dif=
fer,
> > +     * and an entry whose tb is NULL has a zero pc that only pc 0 matc=
hes.
> > +     */
> > +    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
> > +    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
> > +
> > +    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
> > +    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
> > +
> > +    /*
> > +     * flags and cflags are adjacent uint32_t, so one aligned 64-bit l=
oad
> > +     * and compare covers both.
> > +     */
> > +#if HOST_BIG_ENDIAN
> > +    fpair =3D ((uint64_t)tb->flags << 32) | tb->cflags;
> > +#else
> > +    fpair =3D ((uint64_t)tb->cflags << 32) | tb->flags;
> > +#endif
>
> I'd use
>
>      fpair =3D (HOST_BIG_ENDIAN
>               ? deposit64(tb->cflags, 32, 32, tb->flags)
>               : deposit64(tb->flags, 32, 32, tb->cflags));
>
> Whenever possible, avoid ifdefs to make sure all paths compile on every
> host.

Good call. Fixed.

> > +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
> > +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
> > +
> > +    /*
> > +     * cs_base is a second word of target-specific flags despite the n=
ame,
> > +     * and the pc alone does not imply it on a target that uses it.
> > +     */
> > +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, cs_base));
> > +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, tb->cs_base, slow);
> > +
> > +    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
> > +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> > +
> > +    /*
> > +     * Emit a second goto_ptr rather than branching to a shared one: a=
 temp
> > +     * live across the label would be spilled and reloaded on every di=
spatch.
> > +     */
> > +    gen_set_label(slow);
> > +    ptr =3D tcg_temp_ebb_new_ptr();
> > +    gen_helper_lookup_tb_ptr(ptr, tcg_env);
> > +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> > +}
> This is pretty good.  As a follow-up I suspect we'll want a tcg backend
> expansion of this.  For instance:
>
>    - x86_64 and s390x can use memory-operand comparisons.
>
>    - aarch64
>      - use shift-add insn for env_plus_off + h * 16.
>      - use ldp to load (tb, pc) and (cs_base, flags) in one insn.
>      - use ccmp to halve the number of branches.
>
> etc.

Yeah, that sounds good. I'd like to look into that.

