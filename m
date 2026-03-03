Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80223EDEBEB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVa7-0004uK-Kh; Tue, 03 Mar 2026 14:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVa5-0004tX-3b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:38:57 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVa3-0006oY-CI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:38:56 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-359863611faso1179536a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772566734; cv=none;
 d=google.com; s=arc-20240605;
 b=E0bJ1APQsQW6YOBabDxneeiWjtxmfQv5xcmcvH9BhtP4Si7ekfzQGEV3KGgDWgQ5y7
 q6sPlI8SLeq0wPVZBqrhT46YHYkNrA11zcOcsuOpVLvAKjYfwuOf4GO8At5LhL5ajejX
 NNMvf1Jp8vMBzqim91FPkNPW7wzmq9PjWO9SBnWm4QvgDri1QysTs2TDwMWbzJSl5BJD
 lMYyo7+rJ2Z6+LF7fu9hmxh3bQ2eGLyEy52Jk9X2YWCpolkWsh8oO3znUfKGmU0IFxjp
 TxShWqAoIVdnhAoRklYMwBz6A9i/BO9DKPF0SjdfLAy+il2VTrwlhXurUYOxxSqAK5AM
 Lexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tYfrlsoLARHD09g/rFplP306y8iSsRyfa5cOcjK6+W0=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=D8GTkpY4mAGSH2a1vV0SCauCNEuHXG/erTil/RC2XxWRTkebwDsQw35O0PGM4dvI6k
 ruqLhUZUWBzNRtInx9FAJCK+3VROo74P9rRyP98aipnSLhyXhp+M+mQ3lDvVhGpI6Cw4
 dDnyhdizLROL/uXWI71R//+LbZh6/6o9WhF1SxN8J1OXQaJK8xBsu9eBer3KWvHHGa2J
 jjXal3XrkK8ujVJ1ANHj0VZASfp0jlSaiy5+tx+cfVv0Pdf5rSUeT2Vggrt7p22Qwyk4
 REsNRePaPRT6uI2Cn4gFJNkAfF9OF+ZvmRGrRAGM0LSFzW3QiWdf58Lhbn44eKJNqW1n
 CIWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772566734; x=1773171534; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tYfrlsoLARHD09g/rFplP306y8iSsRyfa5cOcjK6+W0=;
 b=bmDFVio5UTssWPMkGcIMWoez7QGiFtaTDsElUvIr1Xc3IT3jDlc6j7mhavwLcs+Zav
 QK5Y9i9+7pOE2NnyP6eFCH7IJWDjJ80+LSRvMvcjmdT3OQ+vsPzcywULEz5xUnF128CW
 CbHyE6eQQzx0sHr5ZRef+vLXRKXt7RRPE+ZYFdpfdR1WgVpeloh3zTrVZn+feW547ay4
 GRD8E2ENC2mECPA3V4f9t4Si7dLKNYAC3mqnz7gr0biZs5hI1k8PX1YIX8IZe4Cv53Wu
 NDHTs9eLMiCF7QmlXWhRUlKQbvpV+ncsqXM2VWpTnuQ+ebpZ8/6xRArr8v9gduJrmkuv
 UO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772566734; x=1773171534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYfrlsoLARHD09g/rFplP306y8iSsRyfa5cOcjK6+W0=;
 b=ZKaR4FEFtNm2VvuNNdcivmk7AyeFbRBsORbK9nZlZRbZdXrtCkdSohu24DzBVqMZgd
 LN3oKfANPwQoRxsxBRL0hyaQ1dYVnDPuTOoiuTiCsD7Fbpft3fSDU8Cq/1C8ivxNB4p8
 8s+vs3RzUpBthcy0/01nquKfMMZmTJCYyYb9d84FoAZ0ivE970Omtt5DkfqcCrcm3l1N
 i/sR240YWIcGMJqczsR1aROXmuT7OezXNiHpddMUQPIFcQISsSXLKdLKg4J9jOdJZrjm
 M+v8MhWQ4PfBoh56lfw4AhGSPO6bzTkIAZSb8XcAsGjQergExc0um8sWx4prT+lfjBUb
 FoGQ==
X-Gm-Message-State: AOJu0Yw1XNqvxF7IkrDkVlhv3QRxGCe6r6iQEi6PkR/TVhUc9mv3gBUS
 9APyu5pjasvNyCfDjeL7yRqdzQylMZzQe3IyYuBsBKAm6q/8R0IFzTn4JhY5mPpM/AEA9QrnOSf
 4F+OTFgm7zUT/rSqB6SgrbchoC8Gutnk=
X-Gm-Gg: ATEYQzyLHCyLHekxwPZvz38lTK51Qb0hDS7sCVh0DHTnzsaajfs+NEG57wILOytq484
 iEgBJxT2P6H5oXY5R8l6ie57saIDYQdnRjY0hcBxScfKj13UfAhzO7YapT99IMnRESnTvUve4co
 hAoUEjnGpPwDf5H6X5M0pgkkFYz463xZBhTNoutfuPB9osjsVH7KXDUuNL7PTR5J4Ojsx3mBWMc
 8/j1xsTDCzh0UzrdqatOq+sh6FvQcEyCRWaQXqG9ocDZrCW3aPoVL/p8RxnDNGC48iWAmJS1VPH
 FVkjYY7JB9TZQYo8IpgMecXHp8HfZWljQVDB8Cw=
X-Received: by 2002:a17:90b:1f8a:b0:354:bda7:8827 with SMTP id
 98e67ed59e1d1-35965c23f6cmr14425571a91.2.1772566733901; Tue, 03 Mar 2026
 11:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-6-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 12:38:42 -0700
X-Gm-Features: AaiRm50L38u0H9ySeCHS7h0iMxaBSHCpi5VYF-EmY_ofG2Lu3SJkbKFL7QYHqCo
Message-ID: <CAATN3NouNHQS+5KfTfFeNZhK=F2pLg6bpFchAOLFdouhNHoxbw@mail.gmail.com>
Subject: Re: [PATCH v3 05/37] target/hexagon: Handle system/guest registers in
 gen_analyze_funcs.py and hex_common.py
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="00000000000083d4b7064c23dafc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102c.google.com
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

--00000000000083d4b7064c23dafc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:36=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_analyze_funcs.py |  21 +++-
>  target/hexagon/hex_common.py        | 161 ++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 3 deletions(-)
>
> diff --git a/target/hexagon/gen_analyze_funcs.py
> b/target/hexagon/gen_analyze_funcs.py
> index fdefd5b4b36..985386c1309 100755
> --- a/target/hexagon/gen_analyze_funcs.py
> +++ b/target/hexagon/gen_analyze_funcs.py
> @@ -22,6 +22,8 @@
>  import string
>  import hex_common
>
> +def has_analyze_func(reg, mode):
> +    return callable(getattr(reg, f"analyze_{mode}", None))
>

Is this check needed?  Why not make sure every reg has the needed analyze
function?


>
>
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 63f83a8de2a..b5ab2efa5a5 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> +class GuestRegister(Register):
> +    def gen_check_impl(self, f, regno):
> +        if self.is_written():
> +            f.write(code_fmt(f"""\
> +                if (!greg_writable(insn->regno[{regno}],
> +                    {str(self.is_pair()).lower()})) {{
> +                    return;
> +                }}
> +            """))
> +        else:
> +            f.write(code_fmt(f"""\
> +                check_greg_impl(insn->regno[{regno}],
> +                                {str(self.is_pair()).lower()});
> +            """))
>

What is gen_check_impl used for?

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000083d4b7064c23dafc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:36=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_analyze_funcs.py |=C2=A0 21 +++-<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 161 +++++++=
+++++++++++++++++++++<br>
=C2=A02 files changed, 179 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analy=
ze_funcs.py<br>
index fdefd5b4b36..985386c1309 100755<br>
--- a/target/hexagon/gen_analyze_funcs.py<br>
+++ b/target/hexagon/gen_analyze_funcs.py<br>
@@ -22,6 +22,8 @@<br>
=C2=A0import string<br>
=C2=A0import hex_common<br>
<br>
+def has_analyze_func(reg, mode):<br>
+=C2=A0 =C2=A0 return callable(getattr(reg, f&quot;analyze_{mode}&quot;, No=
ne))<br></blockquote><div><br></div><div>Is this check needed?=C2=A0 Why no=
t make sure every reg has the needed analyze function?</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br><br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index 63f83a8de2a..b5ab2efa5a5 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>+class GuestRegister(Register):<br>
+=C2=A0 =C2=A0 def gen_check_impl(self, f, regno):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.is_written():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&q=
uot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!greg_writable=
(insn-&gt;regno[{regno}],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {str=
(self.is_pair()).lower()})) {{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&q=
uot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check_greg_impl(in=
sn-&gt;regno[{regno}],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {str(self.is_pair()).lower()});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br></blockq=
uote><div><br></div><div>What is gen_check_impl used for?</div><div>=C2=A0<=
/div><div>Otherwise</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"ma=
ilto:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><=
br></div></div></div>

--00000000000083d4b7064c23dafc--

