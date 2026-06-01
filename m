Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D97DCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTtB1-00018B-3x; Sun, 31 May 2026 23:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtAy-00017f-BD
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:18:52 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtAw-0008Qx-Ly
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:18:52 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so3431916a12.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283928; cv=none;
 d=google.com; s=arc-20240605;
 b=hnvsW0umbf06WGYhO/7UkGYpJWXEickiYTsITigfGZbIew5MhOjfZGDb5OzVnTcuUr
 yarmdpoM2Rx8DEVB2QM63VgAatKHFhnrAmtZkofmQMe+llzof6E7awiQa/+MsVvvyeKL
 SDrvOvvmcfyUQ8MlHUq+x8ava0KrmR31Nb9xLa61Cq6GFJl0qqdvfyI9AqWPqETtV7W0
 b0niK0aOm6IB3DbLhGu0Z/RY7rWDGXLBRrDhQe/gw8MJLrACnvmhANqzPjWYDI4QjuAM
 x8irDS0QTsd9ewB87uVjZzl271x1vM/TtBOlc1QD5lhXK10FTA8UMHZTYRii7bBjRXhT
 383g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZYbT2BfM+E2WrII7NZWnao+oh21andYNC8XR6r7/ckg=;
 fh=oW2qxBvETIKWy8k3OLD7/ksC+fNOktyr9NthcLPsMsY=;
 b=eSFVeiqyTZp6q638hJmZ7V19dmmll98DeOv+pfcXzCB189Sb1q/nbB5avdCoPwTRY4
 ODrrsqqEjiEFiJok5p42LxpfgwJLOJNFPOw/Ca6c1/66bo1vBU2cUiEHUfctpKtchLBH
 G7qEqtg0DLu3sbFPQIdxwkrcsb9DsJZGoKnlRxYnkUBSZ0YkC8y39SSu4aHSFFxR6MOe
 kVDg/z5hjc9D8TBB0RuKGFcJSFresUx2RSuiGkcbtoXbzsqmd2k+tZfA4yd/MxWzut8U
 Uxk2KOBoC81C9U14qSHxh7uclJKLcslmRazlWi4/jmPbpD1Vq6y5edzGzdCDMZZN3fPJ
 vb3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780283928; x=1780888728; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYbT2BfM+E2WrII7NZWnao+oh21andYNC8XR6r7/ckg=;
 b=d5QC7TGIHLycEBfbUmIdDcGPqXHLcSu1l4JRvzLvA0lSE2b0GJHuiauH6BHIyJxzNr
 DS2g+yR6OVrg8pVpatIk/A75Fuc8nUJcIDFWy0LLpU66nEMFZjt/9tLG+5n1wszUyiEd
 BHM+4ieEreThNXzus3P4t99+KC5u86BTXkCPzmUqi/uFvTtcCwa0dyKokzuzeQW2okfa
 aqnaTBMiKuBZKL+qggMHsFvuTlXnFfG0eQAu9PvUCFI+aJZNRAKa3uz75zGRGkKrMz07
 f6364oGBHTQLVd58xjtiu5ra0dpIZyq0mXOaj6HHOepAiGmgNDoeKrt9b7LlVb9Td08H
 P0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780283928; x=1780888728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYbT2BfM+E2WrII7NZWnao+oh21andYNC8XR6r7/ckg=;
 b=gA30tQYxfwjFIOacHqvjxj/TVtUB+9xlvOI+HtVUawM5cfb2+a7wGovSvIUcmOIs59
 hDLaLcBkDZxuEL42RhPQ5C7YwDagtFnXLwUbR70XJ2zODDrJUVBSGAhoHxuGqIQxG9Sh
 56vksYpJ9fAlDvtAgA5Mt6J5CCPsLlBm9xP5sKcdvZyRWvuEusmMoIy2ObivMnaY3c4M
 TA0cgYqP17Mp5tmVxchZima1pJsR3otV3JPOmCTdBkdN2b9+7ixmHFox7UtoGpEE8hN4
 mwI6deAz9m4td29lTK5obeHASvp2U07+oAewlUJWGq6BoNm/CoRqYb5Ml7gEZvhU8B/W
 I61A==
X-Gm-Message-State: AOJu0YzdL3Pm5JVr+NIrm/J40+nDyAEkcvr7I+vYIV95tvHOpvqqhnXp
 vNvUZ8Va2OJVApTop38/BQJDznPEwO4v04rZbKK2F9JN4VM3Gm9oSmEGxTa1hsh6eRjdhv6YiaI
 a4wU6A83Jwb/2/GWdHa9MoPYbY3RA5kJdLZtMmOI=
X-Gm-Gg: Acq92OFwD2m/kr18OJfoRqjs4fc8USnAle8wJ40JUmo0cAcBAYz6DbVXrOFEaFEXQT1
 jO2j2OkSUF994xvPL3KhOZcBnYUPmudReBnOhd7qZIM4fm8HjAuUV1l+MAWvHyRyX6tTbPaPqV9
 Irp0zhuliLtHW5FLOhHzoaB0iiuOR77FFepPC2OWFDl3C/mnjjNLtb4VXxtk3YvPJmlSa2zLXjt
 PVoTVWVwhPylNV3tiaJhwfdhL03j2sG2dSM8z4YeJXpeeENSRUxoFZ/ITLfcoj1OVgYL6phakKr
 PJK/Wr+PPh8ZBqNPSaISNGHs/U9kpzk3HaMZc/InnEv95l9O
X-Received: by 2002:a17:907:d9e:b0:bce:80db:77ef with SMTP id
 a640c23a62f3a-beab3852a00mr466063466b.43.1780283927934; Sun, 31 May 2026
 20:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-3-frank.chang@sifive.com>
 <CAKmqyKNvZQ2XEAgwCDpOHVfV_NPnmMBD+ZV2q5dRAhoaKcpvug@mail.gmail.com>
 <CAE_xrPh=Bcq8f3Jho0tcZWzJ4zxrNuKPtONW7fgKAvKKadOzCg@mail.gmail.com>
In-Reply-To: <CAE_xrPh=Bcq8f3Jho0tcZWzJ4zxrNuKPtONW7fgKAvKKadOzCg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:18:21 +1000
X-Gm-Features: AVHnY4JSwS-sxDAPxTIVn-HbPl8nQo4mTv5CDW05WTTloJ0GCSCKdF-Eh5jLHng
Message-ID: <CAKmqyKNsiNr8rdrOr4c0n64p+k8GR-8mjdhm3vBredWknOERUw@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] target/riscv: Add Smrnmi CSRs
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, May 27, 2026 at 6:23=E2=80=AFPM Frank Chang <frank.chang@sifive.com=
> wrote:
>
> Hi Alistair,
>
> On Wed, May 27, 2026 at 8:57=E2=80=AFAM Alistair Francis <alistair23@gmai=
l.com> wrote:
>>
>> On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
>> >
>> > From: Tommy Wu <tommy.wu@sifive.com>
>> >
>> > The Smrnmi extension adds the 'mnscratch', 'mnepc', 'mncause',
>> > 'mnstatus' CSRs.
>> >
>> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
>> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
>> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  target/riscv/cpu.c      |  5 +++
>> >  target/riscv/cpu.h      |  7 ++++
>> >  target/riscv/cpu_bits.h | 11 ++++++
>> >  target/riscv/csr.c      | 82 ++++++++++++++++++++++++++++++++++++++++=
+
>> >  4 files changed, 105 insertions(+)
>> >
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > index 58bb5196a8..c5d5c2f7df 100644
>> > --- a/target/riscv/cpu.c
>> > +++ b/target/riscv/cpu.c
>> > @@ -1127,6 +1127,11 @@ static void riscv_cpu_reset_hold(Object *obj, R=
esetType type)
>> >          riscv_trigger_reset_hold(env);
>> >      }
>> >
>> > +    if (cpu->cfg.ext_smrnmi) {
>> > +        env->rnmip =3D 0;
>> > +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, fal=
se);
>> > +    }
>> > +
>> >      if (kvm_enabled()) {
>> >          kvm_riscv_reset_vcpu(cpu);
>> >      }
>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > index 284b112821..a2cb471b3c 100644
>> > --- a/target/riscv/cpu.h
>> > +++ b/target/riscv/cpu.h
>> > @@ -486,6 +486,13 @@ struct CPUArchState {
>> >      uint64_t kvm_timer_state;
>> >      uint64_t kvm_timer_frequency;
>> >  #endif /* CONFIG_KVM */
>> > +
>> > +    /* RNMI */
>> > +    target_ulong mnscratch;
>> > +    target_ulong mnepc;
>> > +    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
>> > +    target_ulong mnstatus;
>> > +    target_ulong rnmip;
>>
>> These have been added to the wrong part of the struct, they should be
>> above the comment
>>
>> /* Fields from here on are preserved across CPU reset. */
>>
>> Can you fix this up please?
>
>
> Sure, I can submit a patchset to move these fields above this line.
>
> BTW, do we have a plan to support resetting the registers on CPU reset, s=
imilar to other architectures?
> E.g., For ARM, it has struct {} end_reset_fields, and the registers are r=
eset to 0 on CPU reset:
> https://github.com/qemu/qemu/blob/master/target/arm/cpu.c#L320

I don't have plans, but that is a good idea. Patches welcome :)

Alistair

