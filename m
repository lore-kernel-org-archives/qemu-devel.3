Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072C8FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57mb-0002VB-Vp; Tue, 24 Mar 2026 15:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57mW-0002UZ-Aj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:51:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57mU-0001OM-Oy
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:51:16 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-359fea895b5so1087147a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774381873; cv=none;
 d=google.com; s=arc-20240605;
 b=QqQtR+vy1BWSWc33zgBWcoi3mfCaa6l06PGLSHsBC22AYTN4mbl6DYbjFwvg9eTJFr
 +5pJcC0QI8IGrkKhrIrLLq1hc32QyAUTNzVjYZ/Oxi20Txik1ZF6p7xYSB0YNW9lBpuA
 pbm5oloYq1odqhH0np5gv16Sr+yOumWEAlAenmZEYeNvcx/fgKefSz83OsrSQB6wgNAD
 RTRnECwJ3Za1cpShX/A8/HG/71x9iAjvZw1WA2OjU5rYhdNtN5yPyuOrk8VlvFaXM2aQ
 kVW2pYAm6ZNSZ03mkb/llnnV0SpnW5YQ6igKTaaIuCRlPPDa8OjXYxBwRQg0mR26sR+F
 vlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=76u9O+Zg1LoNDj/nvPwB6ItugTUjIRjh7xrtgqgwd58=;
 fh=fJqGvtWqLDKIzOXW1wAsc3/gnAi5Otjc7uqp16gUscQ=;
 b=WrFFU70BmDn0ZSOEKV21TZVu264RuoqVOoLI50UQL3Oq1olk9JtvUcusRDDoAIpIa3
 +0Sr2T6Op5fV9upLuBvsYpPjSs53S/mNCqMsWa5sjbygXwY5aSQH1GQKFZuncyZ/FkFw
 b7qGXuPoigJxLT25GPGndDf8cG414iVZjtfMWdxBdfgzkuYtJSyCvdPeetsl8NkCARVi
 BN0ED8H5OUJv9WMAz30W/EIBLmE4+RZbJtENDs2bX13TGbsJVsHgApkFa+utqFiF4ErO
 aiwhB2NcwAKJXtxqxvDMjgiuCHpRcK1TbkD4bbtgG+QN4cf4RQInsrt+ncD2RhO8cx9Y
 eMpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774381873; x=1774986673; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=76u9O+Zg1LoNDj/nvPwB6ItugTUjIRjh7xrtgqgwd58=;
 b=bpin9OcMCnoW7/1ORIF4Tk3rWfo4tOolnxmesc1sKYdpf7VlJBHog/oqYqDYfF1H3x
 7Kf1WVZMUGnCtdfSdUCBPGzBH5tyYwqUfUuQoDRQT1yel/gcVDsK3VlTIc0AZtO2zWFC
 iuEjRGD3NMymM5AiU9rPpiiM7yDlxANfKdzfRrC0M696l9WDf2f+5eOtuDlN7cvP9Wf/
 05IbtFnURReuBG+P7krukRQ6D7C/O9n4hJHAv3arOGc3/2HszZSkpazB+M/EIXaM8wD3
 Of9r0gvFDOgx7X+OjVWmQ1j2gohYytVewW6tefKlCtpup0YJwUBftRU9XYOpQEgZjJJD
 syDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381873; x=1774986673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76u9O+Zg1LoNDj/nvPwB6ItugTUjIRjh7xrtgqgwd58=;
 b=bIypWy5qJbskt4a9pFueYhxTEYI4rQprMYHSBreiTwkDyGpJPq3MhkMuExlUInodbB
 A9exUd4zssWqEWXALQaRZ1uXQivMxTGnBX5XtIGuYbRRv5Jz5jkZRQMIvDTnNtf14Trb
 uvdQ0DsLy2gAfS/lI8EykHRCnnWDiuZet2YW98h0D8JC1edh5P81u9FjIizJuR//rwag
 X+0E3JEN2m7OcSne7h5JFIwYdnH+ixrxZHBgsA8VOUh5WSUh+VrY5v2QFBq+JfyEzBvL
 WXY1yjYu7dtNwPeP1ifAxeThE6ROBG2VjZ/Pp65KeN31try1SRcz1fTnuS/gHsoE4etW
 q5NA==
X-Gm-Message-State: AOJu0Yy6HW4MD5M21+g4tCRe5RP+D7nRbyISofqOEl34AYggjQj8UlKS
 YIE3K4eQQaz+itdCRPVDouMch+JujtA1ncwpX2VtPSrXD1w/OWOcS/SjJFHiSG5c0KVFiPNZxhf
 c3ENURPTrVxXFK/aEHNOSCP8bsTTlHjA=
X-Gm-Gg: ATEYQzwJ0zUOrkkzkP10WlcT8G/zWjjoLmZjX/Kg4DkYH70cu5ZgeFIR6EA9BzHJpdM
 lAJRuqvVEQjBRTqY5bQfyNvxwXKAaJBo2RkJMFHc7gzjFBsw9qrCfpXIMt4NZ3apudZowAxVoeX
 F1OCdLx4gx7GnD6to8NPyeUgY/8uRtOaVqSXmU1t6woq8rvYl3PsXsiEMcZQCYQE9zmeIhlSiUk
 gp37LIFJd/kIujjVWmb/O9kguuaSN0LGZL0sNEhxOZwhpyXZCw5yD789Hl9Y3L+XHEiGvgMmNR9
 HL/O5k4UgjfXOT/d72w31IZD2rZv+kmBXXkPpSA=
X-Received: by 2002:a17:90a:fc45:b0:354:a284:3fff with SMTP id
 98e67ed59e1d1-35c0ddcadacmr520031a91.25.1774381873173; Tue, 24 Mar 2026
 12:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrZVn6W0pAyshZ7mhYVcY+gtRk9tJwz5WLLzxoPTDupwA@mail.gmail.com>
 <CABrGZ+GmYG2tg0pWDoBuydWG3abTmMT2wxCu=06fXLQJQCS1YQ@mail.gmail.com>
In-Reply-To: <CABrGZ+GmYG2tg0pWDoBuydWG3abTmMT2wxCu=06fXLQJQCS1YQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 13:51:01 -0600
X-Gm-Features: AaiRm51g6xrOylGZJ1sGKHD6mqk5bXaFnrkheFw7BpB3anKutITFI9infFR4DJI
Message-ID: <CAATN3NpNvqBLdsz7euvuUGTMYxCusQ+MYSyo0GHgFrvZHTBs7A@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
To: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000003f1843064dca7928"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003f1843064dca7928
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:30=E2=80=AFPM Matheus Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> On Mon, Mar 23, 2026 at 5:29=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >> +/*
> >> + * IEEE - FP Reduce instructions
> >> + */
> >> +uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
> >> +                  float_status *fp_status);
> >> +uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_=
t
> a3,
> >> +                      uint16_t a4, float_status *fp_status);
> >> +
> >
> >
> > Consider using macros similar to the ones in the .c file to create thes=
e
> protos.
>
> Hmm, I think in this case, the boilerplate size will outweight the
> benefit of the macros.
>

OK


> >
> > Do these instructions interact with the FP bits in USR (e.g., rounding
> mode, FP exceptions)?
>
> They do not. I'll add a new env->hvx_fp_status and use that for the
> default nan. This way we can avoid messing up with the scalar
> fp_status.
>

That will work for the nan.  Is there any programmer-visible state for
rounding mode or FP exceptions?

Thanks,
Taylor

--0000000000003f1843064dca7928
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 1:30=E2=80=AFPM Matheus Bernardino &lt;<a href=3D"mailto:matheus.b=
ernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar =
23, 2026 at 5:29=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<b=
r>&gt;&gt; +/*<br>
&gt;&gt; + * IEEE - FP Reduce instructions<br>
&gt;&gt; + */<br>
&gt;&gt; +uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t=
 a4,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fl=
oat_status *fp_status);<br>
&gt;&gt; +uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uin=
t16_t a3,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint16_t a4, float_status *fp_status);<br>
&gt;&gt; +<br>
&gt;<br>
&gt;<br>
&gt; Consider using macros similar to the ones in the .c file to create the=
se protos.<br>
<br>
Hmm, I think in this case, the boilerplate size will outweight the<br>
benefit of the macros.<br></blockquote><div><br></div><div>OK</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;<br>
&gt; Do these instructions interact with the FP bits in USR (e.g., rounding=
 mode, FP exceptions)?<br>
<br>
They do not. I&#39;ll add a new env-&gt;hvx_fp_status and use that for the<=
br>
default nan. This way we can avoid messing up with the scalar<br>
fp_status.<br></blockquote><div><br></div><div>That will work for the nan.=
=C2=A0 Is there any programmer-visible state for rounding mode or FP except=
ions?</div><div><br></div><div>Thanks,</div><div>Taylor</div><div><br></div=
></div></div>

--0000000000003f1843064dca7928--

