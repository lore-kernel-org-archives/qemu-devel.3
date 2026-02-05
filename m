Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A08CE9128E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnudJ-0005nO-0J; Thu, 05 Feb 2026 03:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnudH-0005mu-0k
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:22:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnudF-0004gh-8j
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770279751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBoxe1eJdZBQgmUbqxKrW8e4d3IkmSbvin1LAk2ynUo=;
 b=A01cWKY421dBHn5XAgeymYk2I6a/CZJGutTJSg0gTy+sFkUMSxZC/GHO9nTat37q7IyZ46
 bcMD9aPZoCCHrOo+rZ0C7JZNDE9hX8HV0kmsXOPlsAezz7mzOoZlKxHpqpWFB9N1SREihO
 xKfTBweqgxyspM4Zy6fiHSwoela0iTs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Ul3Abt90NACL8kkEm-1WGA-1; Thu, 05 Feb 2026 03:22:29 -0500
X-MC-Unique: Ul3Abt90NACL8kkEm-1WGA-1
X-Mimecast-MFC-AGG-ID: Ul3Abt90NACL8kkEm-1WGA_1770279749
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso548293f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279747; cv=none;
 d=google.com; s=arc-20240605;
 b=izaAXFaFrWkJBSuBxe3s6d9WkVMZ6SbchAIA41LoO+mjS+DmyMHBofr/w+tj4EXbhs
 SrINGXrac2bWg7KfxfWLC2hZFR93uqjY+qbQPtYWM/TufLxnBEMHb6paT4NvVbIuQN8E
 7XDthaMAq7UCyh/t2vCyyZqo9j9hCSj9NPUnCSVnGtGqY2gr2lV/h420pNrxn2pS6pb/
 /rxJn+ioCawSnSzbGQSY8XPKuDryabEPR/ZfOYfBkOS/6mxltld9A9H5qCj+tTrbl/IH
 d4/FTmdd917L5wH04bw3bYXNzlC09J75bzi24TaYReG/aliNiwFLESyrhLUhb5iWMpcy
 58ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZBoxe1eJdZBQgmUbqxKrW8e4d3IkmSbvin1LAk2ynUo=;
 fh=w72gMzNHx+rOQeSQN99Ghrv1qiAWz3alirFKmSMpZ9U=;
 b=UkYkAtcK3ifHQiIT77va/+EXdgvmE03mk9sOyONaMZe1br5OM/0ENSHvMGHwY2jqdL
 y8UZTjYhnV2TFlTIcHyfSkxem4ftR24HE/iCuFQVUhRDMOuLI3FdtwKT9jaNc2+ToroQ
 fzPaJ99YKQ1w3UwZGgAOomkiOVXTblV+wk0AhExViG4VbhpcgeSzAbGgw9iQl0y6S+uz
 74XrLDIo6s0sixgiFI3EDVjjk9u4a0sZvSocQ4IS3KEP/q4wX713dxH/Nh6DaW1N6xOV
 3uF+k4preZsMSce+I+hDbol7D+Pq9WgE0WAVDuGhbah4+Y9MyC15/aF50AVmPWWCb0Lh
 1Qcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770279747; x=1770884547; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBoxe1eJdZBQgmUbqxKrW8e4d3IkmSbvin1LAk2ynUo=;
 b=GhmfAvYpNVoYwZGvfExDrFaqc/Alv05fdChmRjm076WK+O2hTB6q+QenoBSD12HdbM
 fVqsJseazV8nuXDYlzCjDzcGL2XpbLRjuBS6YywrZIf8tbLwFozS3dEK6worQCFi+DOx
 bNKIUkObP6i6ijCXmNP1pVNk4XBZLwrPlEkrP0q/HFQI0whpjgq2q+KwhQz0OF7dyLlY
 F1quPXXWrg4wqgQ+pp767CrYRn94s4TIWw8UDiiLFtkr81uX1STtiu1PTVOoJoSUThu7
 JCx1mobwTuHfNVbDviKGc5TzSkuqit7C2WglOxrfIn0g9tDhwrjLzKBJ4A3SwHA58R7K
 BPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770279747; x=1770884547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBoxe1eJdZBQgmUbqxKrW8e4d3IkmSbvin1LAk2ynUo=;
 b=tiMqC64LBmXTFVrLJwwZ/p/ZyXHqaP2EiiN2EPm1o/GK5QBiF8EjEKdVliNwygomux
 OTLGQD7KRJwioaFTaALLM7nnsTKu2Ww55Wp0llh/PxoeOxfe9mlt9gxbGhtoDjYkToAf
 l/6OYRckRKqGFNdwCQ4CghQyeeWjUzwTUCHxd51XJCukOdPmYFV7HFQXDi2Qvjruwpua
 ZRWgakvquGkmiJgWfigWFKFeJNNLJwCNrR4y23ZPrbRfPBWMF4PQLd4EkXS8w84L/ulS
 hynbeEuM6MDSZSxXMjXkXNbC+x0H9QGJDvb/X7XbJuS/Orq1kHSpGxdG4nnmMKDsfgLQ
 dwPQ==
X-Gm-Message-State: AOJu0YxM8BGw/xWCaaUbuKexpT9FjJwzFksPpdEzhUdEpEmuRx2aoIUq
 iBlmNUHAuVHJf2sMF++X+e/rOsGvBiZvbJdLpE/tpIbUga1MNa4ikyzmX6BerRydgzJrEh9aZST
 I0YA90qVQz5K2MDZWM3RYtn6b5xrtdgBqftfjcG5wkdewwUa1JN5j8wYeZsD6L9G2AAUSNhubt2
 /V3pAjnT3NfT8E+1z8obqh44KqHepr1VEczPEIH1k=
X-Gm-Gg: AZuq6aLG9k1CgPmC/xBKdrmx5EPblXARgqDWQ5U4ZW0kW7oiDrCKGTRVFvhUz/FdS57
 udkGUjloQI1G9wMj9bP9THHV/K4AF04BaUM2YAVNva+ZapvHPUJrh4PeQGS7D6VXcQ/vYutKciZ
 7rucPpdq1cuZL/D7IhVPHkGmbby+R7vzWkkVbXToT2ABHiA3FCT6lrsYerTVIEvUZBpab5ZGOE/
 Op7ogeRdFyU6upL3mVntCjM8cLp2kKr5Zgipeakj5eDRGgH4l0eOoJT5UObODZIwtTOXA==
X-Received: by 2002:a05:6000:1885:b0:435:a815:dd86 with SMTP id
 ffacd0b85a97d-4361806142emr8478820f8f.62.1770279747293; 
 Thu, 05 Feb 2026 00:22:27 -0800 (PST)
X-Received: by 2002:a05:6000:1885:b0:435:a815:dd86 with SMTP id
 ffacd0b85a97d-4361806142emr8478787f8f.62.1770279746900; Thu, 05 Feb 2026
 00:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
 <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
 <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
 <5c46d3a3-e046-46a1-ac5c-5588a2179441@linaro.org>
In-Reply-To: <5c46d3a3-e046-46a1-ac5c-5588a2179441@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Feb 2026 09:22:15 +0100
X-Gm-Features: AZwV_QgKIhqbJMUP-Zr_AfCvhAJ8QaEe3xrRWjkqDtGqiXP37o9An8u-vH6RwXQ
Message-ID: <CABgObfZArFHKHjwbWBmWP09OegtfiCpAQuQLtSrWax0tzc_hSA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000077ae2d064a0f5f22"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000077ae2d064a0f5f22
Content-Type: text/plain; charset="UTF-8"

Il mer 4 feb 2026, 21:46 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 2/4/26 20:41, Paolo Bonzini wrote:
> >     This is primarily for x86.
> >
> >     (1) movz is 2 operand, so that may avoid clobbering an input,
> >     (2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.
> >
> >     Because of these, there's a comment somewhere that says we'll prefer
> extract over and
> >     (perhaps in tcg_gen_andi_* or fold_and).  IIRC this also happens to
> simplify ppc and
> >     s390x
> >     insn selection (and vs rotate and mask).  AFAIK, no other hosts are
> penalized.
> >
> >
> > I think it would be better to pick a canonical form for AND with 2^n-1
> and handle
> > conversion to extract (like PPC rotates or movz) in the backend.
> >
> > Picking AND as the canonical form also avoids makes the macros for
> extract validity
> > simpler too; adding an extra constraint for immediate 2^n-1 is easier
> and it generalizes
> > to other PPC rotate and mask cases.
>
> Picking AND means we have to use "r,0,ri" for x86, losing register
> allocation flexibility.
>

Then could you wrap the target specific extract_valid with one that allows
ofs == 0 if AND allows the immediate 2^len-1? That would also simplify this
series.

Paolo


>
> r~
>
>

--00000000000077ae2d064a0f5f22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 4 feb 2026, 21:46 Richard=
 Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hend=
erson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On 2/4/26 20:41, Paolo Bonzini wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0This is primarily for x86.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0(1) movz is 2 operand, so that may avoid clobbering=
 an input,<br>
&gt;=C2=A0 =C2=A0 =C2=A0(2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Because of these, there&#39;s a comment somewhere t=
hat says we&#39;ll prefer extract over and<br>
&gt;=C2=A0 =C2=A0 =C2=A0(perhaps in tcg_gen_andi_* or fold_and).=C2=A0 IIRC=
 this also happens to simplify ppc and<br>
&gt;=C2=A0 =C2=A0 =C2=A0s390x<br>
&gt;=C2=A0 =C2=A0 =C2=A0insn selection (and vs rotate and mask).=C2=A0 AFAI=
K, no other hosts are penalized.<br>
&gt; <br>
&gt; <br>
&gt; I think it would be better to pick a canonical form for AND with 2^n-1=
 and handle <br>
&gt; conversion to extract (like PPC rotates or movz) in the backend.<br>
&gt; <br>
&gt; Picking AND as the canonical form also avoids makes the macros for ext=
ract validity <br>
&gt; simpler too; adding an extra constraint for immediate 2^n-1 is easier =
and it generalizes <br>
&gt; to other PPC rotate and mask cases.<br>
<br>
Picking AND means we have to use &quot;r,0,ri&quot; for x86, losing registe=
r allocation flexibility.<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Then could you wrap the target specific extract_va=
lid with one that allows ofs =3D=3D 0 if AND allows the immediate 2^len-1? =
That would also simplify this series.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000077ae2d064a0f5f22--


