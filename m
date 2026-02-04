Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65FEE95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaKE-00050h-UC; Wed, 04 Feb 2026 05:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnaK5-0004zk-G3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:41:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnaK2-00065M-Na
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZp/YGfjML84bExHlNpBprmVjNhzoO33xRVdNT7W/e4=;
 b=R4+RRTL2MREIKJ7WAuD2s/ftyx6Rgp7ANruNuq922T8gFsv+GLFQNedtPVny5fmzqNoA76
 ETlFNbW7DquCchbwUh4LlhlM/PL6ufXZNAYA04UE85hF12/tkrEK3R+P/AA11Lb4ZciCIm
 y8pcU6Hxg3fZXBz6I2A1YHEeEBmFmEs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-bz7e1sWKMNaTI8scp_neow-1; Wed, 04 Feb 2026 05:41:19 -0500
X-MC-Unique: bz7e1sWKMNaTI8scp_neow-1
X-Mimecast-MFC-AGG-ID: bz7e1sWKMNaTI8scp_neow_1770201678
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4cdso5623450f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 02:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201678; cv=none;
 d=google.com; s=arc-20240605;
 b=exbMCKdd6px80aUyf2dmveyCrog6bsXTXizrIh+TFEamjAv1/wec4SSRyzlKtWOOfB
 kDW0zZHTdXGjQ4fRM8gNjl7T0TENed4k9N7DHTNiZmy8FkWUs/rbgzyCcPMmhTKPdduv
 rghTcLJ7HKWGmyC4CjPxrTotEN2AI3xUb+tOd9740NwHjhU1Ve6Iocmq0kP/TKc+bnqc
 jFW8RXVjN0UHgu3loaD15h4SKKUXuBlYK53prAdCX6J3HyTuicb0nXKYDbfVLXKlppP1
 vZzVUHgpJQLaTH60gPrWlYD1efKnSCxB2GdL1XJEZC06jlGPcSy/SEtnkG8NcdARypH1
 16Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hZp/YGfjML84bExHlNpBprmVjNhzoO33xRVdNT7W/e4=;
 fh=w72gMzNHx+rOQeSQN99Ghrv1qiAWz3alirFKmSMpZ9U=;
 b=fCzYMJHECEsNhyen7wh6RkZD/2ctbsV71r86fa4fY6YgEcfREH2JdU6F/sox+p1WSQ
 cby8qEsUAP7wqxQJD06v9ehWWO8leRlXjq9xB4mxlAcfYq13yADXoH5+mK2bc1UprJQ/
 ny70jCFwk+DRosUIsYMG5cpbJBrdMbpkp5J7w2KWUieJrE3uaRrQ08kIKXXlhD/0vDdH
 iJwqlBr78dy+hqETQ7FC2P47v8e1leh6tqIKmeVEuakhSBq2MyJ4cV6y7aGHl3+f2Go3
 ZrjWUDz97sNEJuIU/Ubc1yDABuSnbNQkPePP7ONqQ+oXsNvM9D3AtzPpU/wfFN8uSbS7
 sFGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770201678; x=1770806478; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hZp/YGfjML84bExHlNpBprmVjNhzoO33xRVdNT7W/e4=;
 b=e8nwDn53PCKstJ3XI4TZpLDgRERyzvZTjy1wWRmxuhECuvUiNyyWRXk+38WNNrm01I
 YoHLI52R39WD+eCHx0KM2Hc+T0o4iPlKTWRf6ZbM4Bvxj/qY9e9SKhgXAz16nx0R2z4c
 ydcj+xckvmGuKTueXapmmuOjO62b2xqGLNyLCpLdviJVNrEsdkSJfU+EmxcG6Tv57t9h
 LBLg2GlL20iwPJVoAjMOBqNfoAG01CQRZB9v6BJ1z1EaRbZvFfWK4TUjx341YgkkbCUU
 idKAt9ptwkYKwOby2MyqqIRNkSiYj4RHRRS2WRD1CsgZYyiK1CNlQ/UuTNvKa2ScshH4
 1ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770201678; x=1770806478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZp/YGfjML84bExHlNpBprmVjNhzoO33xRVdNT7W/e4=;
 b=UcfQbSlkCWjA/pnc1UsskHJQKZEVYY4WYD6GpBHj7eXy1okNEgd1G0xWdDC9FYuclI
 ENkGje/8RhTorcb+hirlKIb+N+Puej2z058DmauczRt0jzhTpttjM/01W5GhcWqZC5f+
 7WfxMm4JzKtUA8M3lZdm90RzFOlBg78M4ifyid92wd7kDRkbwm4JRtD1ge1I1ZPN4Q8p
 QzuYbLfxWWX2iRn+gs1XAa8EftfgPAr89UuYmDeoxw63erOPT/3uDFgP9tYJdwLv5Twi
 J30mgEd3zu+dlYLy/lYw3eWcyy7ag4Y6TYOUAefwZwibGLBabhqGm8wBwboawDNPa3go
 rCmA==
X-Gm-Message-State: AOJu0YxP2A885AAz/x2i1YT3HoN+wxTmHD0DntHIqvb2uVouwiQsW16N
 fC4IS/bAUDZxweL6nFJTnUIWeDqHri2mca3IpBF6Ddt/5OfRC930+8fD4udFfHI2EblwW+8oNDZ
 OTGwjR8AXaXymC1rN3/YVBf+RZhTgFcQL7bHNupbf4uaCiEymx5eIopxKgGRS4MtCX7IPctQ5aV
 xns3yJr8fuKRSiz4e+EYEQEuH8hJSwujA=
X-Gm-Gg: AZuq6aIBaeqnUsN4yN9bvx90rUqB3CheS4jUtyhRwrM3uO1bAsVl8QgK5EAeCtFmdMv
 l0Q1pEhnYQXfi1bJuyvBQ7EPdFwm9HxPcYTAbooJgNwtd93KdfzjBdCf2f0W52mXESGFK+GTbYv
 VZDwve37w1O0ry+IAxxL/8pdKzLowp7bVCqRPSIEF1sh2QsTDivHGFFyuk8nNZOAf6Z2YRwKmit
 1b+soQD+nzbPKbaOUJT4/IcPHrvStJk2NlHH8OGMyNjyv1xNuNE8rYBMj/ylWYl2tObWQ==
X-Received: by 2002:a5d:64e6:0:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-43618053b98mr3131828f8f.34.1770201678325; 
 Wed, 04 Feb 2026 02:41:18 -0800 (PST)
X-Received: by 2002:a5d:64e6:0:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-43618053b98mr3131800f8f.34.1770201677915; Wed, 04 Feb 2026
 02:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
 <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
In-Reply-To: <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Feb 2026 11:41:04 +0100
X-Gm-Features: AZwV_QgR0s-nSQn7Jk8Wrj9Ou0LjJig4_Y0yTqEeV0iQ3W3uhYa_xiEJZXzqrRY
Message-ID: <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000317c680649fd3230"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

--000000000000317c680649fd3230
Content-Type: text/plain; charset="UTF-8"

Il mer 4 feb 2026, 10:06 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 2/4/26 18:05, Paolo Bonzini wrote:
> > On 2/4/26 06:24, Richard Henderson wrote:
> >> Use tcg_op_imm_match to choose between expanding with AND+SHL vs
> SHL+SHR.
> >>
> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   tcg/optimize.c | 40 +++++++++++++++++++++++++++++++---------
> >>   1 file changed, 31 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/tcg/optimize.c b/tcg/optimize.c
> >> index e6a16921c9..2944c5a748 100644
> >> --- a/tcg/optimize.c
> >> +++ b/tcg/optimize.c
> >> @@ -1743,10 +1743,17 @@ static bool fold_deposit(OptContext *ctx, TCGOp
> *op)
> >>               goto done;
> >>           }
> >> -        /* Lower invalid deposit into zero as AND + SHL or SHL + AND.
> */
> >> +        /* Lower invalid deposit into zero. */
> >>           if (!valid) {
> >> -            if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len) &&
> >> -                !TCG_TARGET_extract_valid(ctx->type, 0, len)) {
> >> +            if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
> >> +                /* EXTRACT (at 0) + SHL */
> >> +                op2 = opt_insert_before(ctx, op, INDEX_op_extract, 4);
> >> +                op2->args[0] = ret;
> >> +                op2->args[1] = arg2;
> >> +                op2->args[2] = 0;
> >> +                op2->args[3] = len;
> >> +            } else if (TCG_TARGET_extract_valid(ctx->type, 0, ofs +
> len)) {
> >> +                /* SHL + EXTRACT (at 0) */
> >>                   op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
> >>                   op2->args[0] = ret;
> >>                   op2->args[1] = arg2;
> >> @@ -1757,14 +1764,29 @@ static bool fold_deposit(OptContext *ctx, TCGOp
> *op)
> >>                   op->args[2] = 0;
> >>                   op->args[3] = ofs + len;
> >>                   goto done;
> >> +            } else if (tcg_op_imm_match(INDEX_op_and, ctx->type,
> len_mask)) {
> >> +                /* AND + SHL */
> >
> > Even if these extracts are valid, can they really be cheaper then an AND
> with immediate
> > argument, or back to back shifts?
>
> This is primarily for x86.
>
> (1) movz is 2 operand, so that may avoid clobbering an input,
> (2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.
>
> Because of these, there's a comment somewhere that says we'll prefer
> extract over and
> (perhaps in tcg_gen_andi_* or fold_and).  IIRC this also happens to
> simplify ppc and s390x
> insn selection (and vs rotate and mask).  AFAIK, no other hosts are
> penalized.
>

I think it would be better to pick a canonical form for AND with 2^n-1 and
handle conversion to extract (like PPC rotates or movz) in the backend.

Picking AND as the canonical form also avoids makes the macros for extract
validity simpler too; adding an extra constraint for immediate 2^n-1 is
easier and it generalizes to other PPC rotate and mask cases.

Paolo

>
>
>
> r~
>
>

--000000000000317c680649fd3230
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 4 feb 2026, 10:06 Richard=
 Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hend=
erson@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On 2/4/26 18:05, Paolo Bonzini wrote:<br>
&gt; On 2/4/26 06:24, Richard Henderson wrote:<br>
&gt;&gt; Use tcg_op_imm_match to choose between expanding with AND+SHL vs S=
HL+SHR.<br>
&gt;&gt;<br>
&gt;&gt; Suggested-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@l=
inaro.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 tcg/optimize.c | 40 +++++++++++++++++++++++++++++++--------=
-<br>
&gt;&gt; =C2=A0 1 file changed, 31 insertions(+), 9 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tcg/optimize.c b/tcg/optimize.c<br>
&gt;&gt; index e6a16921c9..2944c5a748 100644<br>
&gt;&gt; --- a/tcg/optimize.c<br>
&gt;&gt; +++ b/tcg/optimize.c<br>
&gt;&gt; @@ -1743,10 +1743,17 @@ static bool fold_deposit(OptContext *ctx, =
TCGOp *op)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto done;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Lower invalid depos=
it into zero as AND + SHL or SHL + AND. */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Lower invalid depos=
it into zero. */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!valid)=
 {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (TCG_TARGET_extract_valid(ctx-&gt;type, 0, ofs + len) &amp;&amp;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 !TCG_TARGET_extract_valid(ctx-&gt;type, 0, len)=
) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (TCG_TARGET_extract_valid(ctx-&gt;type, 0, len)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* EXTRACT (at 0) + SHL */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2 =3D opt_insert_before(ctx, op, INDEX_op_ext=
ract, 4);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2-&gt;args[0] =3D ret;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2-&gt;args[1] =3D arg2;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2-&gt;args[2] =3D 0;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2-&gt;args[3] =3D len;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else if (TCG_TARGET_extract_valid(ctx-&gt;type, 0, ofs + len)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SHL + EXTRACT (at 0) */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2 =3D opt_insert_before(ctx, op, IND=
EX_op_shl, 3);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2-&gt;args[0] =3D ret;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op2-&gt;args[1] =3D arg2;<br>
&gt;&gt; @@ -1757,14 +1764,29 @@ static bool fold_deposit(OptContext *ctx, =
TCGOp *op)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op-&gt;args[2] =3D 0;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op-&gt;args[3] =3D ofs + len;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else if (tcg_op_imm_match(INDEX_op_and, ctx-&gt;type, len_mask)) {<br=
>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* AND + SHL */<br>
&gt; <br>
&gt; Even if these extracts are valid, can they really be cheaper then an A=
ND with immediate <br>
&gt; argument, or back to back shifts?<br>
<br>
This is primarily for x86.<br>
<br>
(1) movz is 2 operand, so that may avoid clobbering an input,<br>
(2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.<br>
<br>
Because of these, there&#39;s a comment somewhere that says we&#39;ll prefe=
r extract over and <br>
(perhaps in tcg_gen_andi_* or fold_and).=C2=A0 IIRC this also happens to si=
mplify ppc and s390x <br>
insn selection (and vs rotate and mask).=C2=A0 AFAIK, no other hosts are pe=
nalized.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I think it would be better to pick a canonical form for AND with =
2^n-1 and handle conversion to extract (like PPC rotates or movz) in the ba=
ckend.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Picking AND as th=
e canonical form also avoids makes the macros for extract validity simpler =
too; adding an extra constraint for immediate 2^n-1 is easier and it genera=
lizes to other PPC rotate and mask cases.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000317c680649fd3230--


