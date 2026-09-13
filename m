Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F66C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5nxX-0003bW-Cs; Sun, 13 Sep 2026 13:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x5nwl-0003Ir-EX
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 13:24:55 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x5nwi-0005Cn-Jz
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 13:24:54 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so960245a12.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789320291; cv=none;
 d=google.com; s=arc-20260327;
 b=juM8HcuGWe9M8+4QGdM/ojxx7Ni4bm0dkhC0yTuz/pPiMVGUru3aCWl6tfFvJ953XL
 aLi8qw/HMX8JUFdaAVdcMNFL3DN53vml9iQ8ZKzj9cqErVVOz8UHIFaW/b5KylNVuEAH
 NshPmfasxU9p9Gl40ku4stZmMGnAFvo0B4ikvg4Mxa7nWM1fSgfTDX5RWYee5aNioERH
 HhspWSZIO6lFsrvGm+UMV8uKoanRZmR2pZyS037ra9gc/PxgBhDDCut59kL9vC/pLqIV
 JZ/4WDzjA+FaFMHJU5y+1XpPP85C+nxwwOzZI4vlp3TlAd+Im59noWVQD9pr8J0RLiFP
 W8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OQ6266xTa5PQXBOEFMOEyawcoTVMB1a86G7pG8JagOU=;
 fh=YojO/rUrd9bEiBBeCSQ5G4JUS14mZG7zALMDwLLdQFc=;
 b=qfPx9KfExsMBH3mbsLeXTCy5cAna+6fI7GCREL/fwxJPBGSD25Jcrs2rYEPoNvkS9S
 ADM7MY4yLmT4ha3bS7BAs5ob0MLK+D1f3S30gkAdne97hLs+VL7Ma4nVYfJU7aRz9BLg
 sMjRDF4B+jE8X51C5q0Mlb1wD/4XCxxRnOvhtsCiZD4dz9+lYf4XwKUTtQ/Teg0xLo/m
 +k8VgOBmW70Kikm/32vCDewQspHjCVNLYguShW9S8R2YiPWwKREQl8c6W3fjQCd5Max5
 gIOQZbvBNDPWc6doBtixEBrp0VFrzJTfW+a2BP6JI+YM3cTEM4WS/cCV4P0qPgP+lf9d
 Zxgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789320291; x=1789925091; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OQ6266xTa5PQXBOEFMOEyawcoTVMB1a86G7pG8JagOU=;
 b=LEyZcwj6LJkflB/gEHvfGYw1uhguDHiYnHsPa0XEkcULYM/Wv8Pw9COTLBtVf3hBWE
 23VfDQWjSeiADwSm/wYuInlmfyOqEMao175KZN82Ap4oLM5lVjS3vnC+iVRRpJzsj0pO
 WyRZbYkzWhMWlaa6BNF4gTYVS1PaM5EQWX4L+IFcNom6kUFCmOBtkgCfXpmrgIzQbWt9
 IGD8GSzLFQfMykxqCvqXgTg94dIYgcplPRhRENeeeDbK22qG5xjcTBbWAVKZWL9uklNl
 oldFntcr+8ES2c3OsUo3hs9PlZodPIETU6F2QRCgglujjcHMIJnuLmV+6OsHJvg2FfRg
 jpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789320291; x=1789925091;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OQ6266xTa5PQXBOEFMOEyawcoTVMB1a86G7pG8JagOU=;
 b=AbCa2VYjfxWJpzwx/HzkEOfmoTd2JMCr/ifInTs3wX1KCyj0bvyoduP85F75YiE+ZJ
 Wt4zXuSJ0xMU9iF5ATbeVLSyynUEdEWuuKi6jvfkOjVPezkvkDAQHSbeOZeHMO44NL8Z
 uSjmNoyCFpRxB2/gstr27jpznh5UqCV39Kysp9dptdYerXjkCzKIttuMKa11u053iUcm
 1aRXFOjWrUr9yNAxnP7p7OgBtE81V+igFYjUWcquGk/xGYJ3fW49Alx1mrnGmrrSiXJH
 Uzf2JOTQq1v7a2/TERcetOpwBu0jJwJYvYrN6Irq3iFicOtfbiF5StYEKc7aiZDamBTp
 rAFg==
X-Gm-Message-State: AFuF++nOTV3tLt6K8TUVwtSO/v6c94iMAPVP6h1Qv0d10fz0hG08OcCl
 WukriNwyKLAMJiJgvOJx0EI/DJhP9DxMvhE4o9SfD0/xGxEsvvavbRjmz+KRehpdd/83vOq2cvs
 RCo0J8LscuUalms8Oo7Ct++lcWfVnGfg=
X-Gm-Gg: AYBFou2IiqYCnaE27WHWrivZXJuAYIXgxY6HlFYYrh2uyrSbskqrQPVPYdwXGJjBPEr
 EBiRQWtSrHzlntYDULUU8H7xhhoKbaCGlBSkHraOBwH0m1yT+gs4NgDXMI9n7/SsbUipKS0URsq
 7rLUqDqL6a6GCsP4V0ivwGHeejNjMPxV9PEV+WzNB5MlU2tLXkE/ua6gl+NBj96SKvz0xBabBga
 ieINRifd0tITnvUDTPVBF5QxwmIW9CKbk8wPzrie4VpzjSaYQ0IuSshl0FUP7IXkEQS32xWokAV
 FTstdoj7Xzo8XHRVVmx8AHA8MQAmBNcpOKuLvP5C5AkcupcT5ynyYBmQN7e+5QB5BCD540OvDY5
 PmFumHFcqjVI=
X-Received: by 2002:a17:902:e74d:b0:2d6:fec3:bd57 with SMTP id
 d9443c01a7336-2dd2a34b154mr247008735ad.14.1789320290591; Sun, 13 Sep 2026
 10:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-2-ltaylorsimpson@gmail.com>
 <2b1ac378-da03-492c-8886-282ecaa88404@oss.qualcomm.com>
In-Reply-To: <2b1ac378-da03-492c-8886-282ecaa88404@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sun, 13 Sep 2026 11:24:38 -0600
X-Gm-Features: AcwNN1Uob3xrylS49uuzyM9HUr9nD25Yw5pZlUkLBFBMabYFKh6rnyAISPSPK7g
Message-ID: <CAATN3NqdRMprWLM=kFtOD8TitwcH08x_SoceHUVRUq03pudzBA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Hexagon (target/hexagon) Move code out of
 gen_start_packet
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000004f647f065b6098b3"
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pz2-x10.google.com
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

--0000000000004f647f065b6098b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:41=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

>
> On 9/11/2026 5:08 PM, Taylor Simpson wrote:
> > Move clear_pkt_ctx and analyze_packet out of gen_start_packet
> > Precursor to adding packet validity checks to analyze_packet
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
>
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
>
> Aside: I notice that you are touching "next_PC" here and it occurs to me
> that I have local follow-up patches from your previous suggestion on how
> to remove it.  I'm prioritizing closing functionality gaps over
> translation performance/codegen improvements for the time being, so it's
> somewhat deep in the queue.  I suppose I should bump it up a notch.
>

FWIW, the changes to next_PC are de minimis.

The original gen_start_packet had
    target_ulong next_PC =3D ...
    ...
    ctx->next_PC =3D next_PC;
    ...
    if (...) {
        tcg_gen_movi_tl(hex_next_PC, next_PC);
    }

When I split that function in two, the local variable and assignment to
ctx->next_PC ended up in clear_pkt_ctx.  So, I changed the third snippet to
    if (...) {
        tcg_gen_movi_tl(hex_next_PC, ctx->next_PC);
    }


Thanks,
Taylor

--0000000000004f647f065b6098b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11,=
 2026 at 10:41=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br>
On 9/11/2026 5:08 PM, Taylor Simpson wrote:<br>
&gt; Move clear_pkt_ctx and analyze_packet out of gen_start_packet<br>
&gt; Precursor to adding packet validity checks to analyze_packet<br>
&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
Reviewed-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com" =
target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
<br>
<br>
Aside: I notice that you are touching &quot;next_PC&quot; here and it occur=
s to me <br>
that I have local follow-up patches from your previous suggestion on how <b=
r>
to remove it.=C2=A0 I&#39;m prioritizing closing functionality gaps over <b=
r>
translation performance/codegen improvements for the time being, so it&#39;=
s <br>
somewhat deep in the queue.=C2=A0 I suppose I should bump it up a notch.<br=
></blockquote><div><br></div><div>FWIW, the changes to next_PC are de minim=
is.</div><div><br></div><div>The original gen_start_packet had</div><div>=
=C2=A0 =C2=A0 target_ulong next_PC =3D ...</div><div>=C2=A0 =C2=A0 ...</div=
><div>=C2=A0 =C2=A0 ctx-&gt;next_PC =3D next_PC;</div><div>=C2=A0 =C2=A0 ..=
.</div><div>=C2=A0 =C2=A0 if (...) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
tcg_gen_movi_tl(hex_next_PC, next_PC);</div><div>=C2=A0 =C2=A0 }</div><div>=
<br></div><div>When I split that function in two, the local variable and as=
signment to ctx-&gt;next_PC ended up in clear_pkt_ctx.=C2=A0 So, I changed =
the third snippet to</div><div>=C2=A0 =C2=A0 if (...) {</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(hex_next_PC, ctx-&gt;next_PC);</div><d=
iv>=C2=A0 =C2=A0 }</div><div><br></div><div><br></div><div>Thanks,</div><di=
v>Taylor</div><div><br></div></div></div>

--0000000000004f647f065b6098b3--

