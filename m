Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A703C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weELB-0000wo-9q; Mon, 29 Jun 2026 11:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1weEL7-0000uj-4M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:56:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1weEL3-0001VO-J9
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:56:03 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-472a14c9965so1382397f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782748558; cv=none;
 d=google.com; s=arc-20260327;
 b=Lmm5kyl0blSyUrhN6mi0gYDHJiYaC6ne5nyQvG8B0+0DfQ2+QtPFQoP151YPsL85lb
 zipi1hdtTC/IFZaDl70qCwHYe4f+uci6or8AAx8i/ibbO4v0ufhzxOWHEYqqmVyVmcDT
 JH/DN8mfKxMzA8Xz6P7MA9/7i/fESgbWikEE8R7gWxQTzVeiH7RksxSn54eAT/ASLrBv
 BlbdTUeK+fU7iz9KDnMbHXDeqUXgBjMzAcaW2hVXg2yzomQHnfpY9vAk9e7TQtB+2j39
 3lQElRISUrN2FpAP4cwR/Rei5af8hoBtwOSstqAqbeOMcRie46VfeFQ5qp9ZzSyLXnQt
 AxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S8TGHsifkdeY5GIszP4r+Vw927pPsHcm1fDJsZHVizI=;
 fh=uUCBWekSDVrYYWxjdpTxM1S3i9nbfYwKkNluXnWis1M=;
 b=hhk4ybyoOYswAMFIdmflW9FssMDrumyU5db2M0HHES6aJotdycv2ehkJ8nZLrJV+sO
 v104x/Nu0KoTbReWRH7A8BaUaErQ9rkxso5WkI+5Ll51rdkV/yK3h/IoG5Cq/czc+rIH
 irBgbJaDmSAB4INpuvncw7GTQ4N4gN0zRMo5ZiSoLs169bDDN3hw0xlhml4gIAo+xTgl
 P75et+nz7ylMZgjuIxNDlYdBYwyiywijZbe5giS9EZA/tWKEk14/8FOJXe66/xenRWnc
 H09UkxsN3qw7PhepnuWHTzu4lvbSpsI2jZDMAyD8cnKkVOEpWcwc0rdjV69IB60WPunC
 Xk1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782748558; x=1783353358; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S8TGHsifkdeY5GIszP4r+Vw927pPsHcm1fDJsZHVizI=;
 b=WwNb+UdKC2oeCHya/zzuTLT7H3hH5YPbcxNTGIDzg+u37WtKBEg9PkOYj9Lb6Lv832
 yDwmmFzdVbyXgyCz55NysukEvCy48RAOuS8+5DZxSQZpRqancht37DtyIxCnCyfHaKaK
 OlDcWW97zQjaZSd7PHvaSjibJClBT+PepYL6zUMyGZSCNlbGmMT+6/Pz9dt04CKpLG2T
 Zp0jdeIb0Vf2dkyLFT9cd+ctB4rzz1NPLauWaq6CwwgxH7b0TEiijFRxRjjN6HFCYgPP
 Gq1vVgAYi33ZxKttZXZgBRkQBtWmNO4s8w4njS6jYNDFbAwDV6FLkSGqzw0cBWeD2h3Y
 qwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748558; x=1783353358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8TGHsifkdeY5GIszP4r+Vw927pPsHcm1fDJsZHVizI=;
 b=r+lAe7R2Tld7t6GuoCTCF0zKoVQGm0MyXEqFhZgPYSS2HgvHOWENqcjIeUl03Bxq40
 EqL5tSPrrLHofPQUL30Lqgg5mX9lmA17XAMaVv7odrPdJo7BJ5bl2drejVyfiTm1CcZl
 YPy1IkbmqkUAlAN4w8dq2SqrGIKOaeCfXK7Tp70RBg96gSCYxsfIHAof8Z9mQ9JqLgVm
 afKmvUG3GLYNweTGMqeScCaj7+9ntjveKJmlDc7XDF30xSIqTXn4Guk62k03KefXvlRZ
 VNizx2MrBltJSQU6Adp835+qbQB+5LPxU+DX+q5M9ianhpC7/R8ELuTi9/tIIiYGBjO7
 l+lg==
X-Gm-Message-State: AOJu0YxIv8byGmer48AvrHkoDhx3fVsGRSCxx4eBoxLdtJEPuZxXx1xz
 hosIg8ZWuV1OoQcq27MAoenxzzsAhQYF4MyFhJI5Wk68YhFE9AV2+cjMb4uuJGmONOP6yAgiuBP
 BKguJnKqNVjBtiSIo26yC7kwjWVaX8YSpugbR+TAtdScEAd8ZboXvCu9EJhGcF7PALLjMs2k=
X-Gm-Gg: AfdE7cmZjVOZKlkbS8aThTdLpLlZJA+xUYTkluc19wLjymEc60tGVZBQhff+PHJX2Ps
 V6phq8edfDuc+wKTIwQYUWRL+nqMjgbsaMqQM25zRgXwyVNl7wCDZUUKDn/oOGXuSB677Zg3GVl
 CaGA5oypsVlQDRXK+KVhoL0SFaO202S0jjZuKFHvdHFWglbmtvUyrLvUuhUbd4SJHseUx6qw45M
 pN+VlKuS2VQbHbCjc+32Sn0wVlja2U6NZnhxRaB7+yW1EvmDu5L+PDxoivCrWI4pYJ8eiWr6+w=
X-Received: by 2002:a5d:4649:0:b0:46d:d5da:f0ac with SMTP id
 ffacd0b85a97d-475017f69afmr1487913f8f.47.1782748558107; Mon, 29 Jun 2026
 08:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260625192121.1887-1-linisha232@gmail.com>
 <20260626181118.1136-1-linisha232@gmail.com>
 <882ff78f-f927-4ff0-8c40-7b9f00c063a6@oss.qualcomm.com>
In-Reply-To: <882ff78f-f927-4ff0-8c40-7b9f00c063a6@oss.qualcomm.com>
From: linisha <linisha232@gmail.com>
Date: Mon, 29 Jun 2026 21:25:44 +0530
X-Gm-Features: AVVi8CeE0YKlCVXRwQICS_KqfM1zAyZa4xPwWubm70wnsBI-JDgjpRe2x2xHZBI
Message-ID: <CAGKMO+Vh2Hb_Ue1=MF1+WDcN98DDUgRxgEGFdgZgUjP1N+fuSw@mail.gmail.com>
Subject: Re: [PATCH v3] docs/system: add general note about architecture and
 machine differences
To: pierrick.bouvier@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com, berrange@redhat.com
Content-Type: multipart/alternative; boundary="00000000000087a8e00655667e7d"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=linisha232@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=no autolearn_force=no
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

--00000000000087a8e00655667e7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=98=8A

linisha reacted via Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>

On Mon, 29 Jun, 2026, 9:22=E2=80=AFpm Pierrick Bouvier, <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 6/26/2026 11:11 AM, Linisha wrote:
> > Add a note near the start of the introduction explaining that QEMU
> > options, properties, and command lines may differ between target
> > architectures and machine types. This helps prevent confusion when
> > examples shown for one architecture do not work for another, such as
> > the pflash0/pflash1 options visible in -machine help on some machines
> > but not others.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> > Signed-off-by: Linisha <linisha232@gmail.com>
> > ---
> >
> > v3:
> > - Wrap commit message body at 76 characters (Daniel P. Berrang=C3=A9)
> > - Add Reviewed-by: Daniel P. Berrang=C3=A9
> >
> > v2: Take a different approach based on review feedback from Daniel
> >     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly claiming
> >     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
> >     machines too), add a general note near the start of the introductio=
n
> >     about how options, properties, and command lines may differ between
> >     target architectures and machine types.
> >
> >  docs/system/introduction.rst | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
>
> This was merged into master (20553466cc47af6a8c95f665b601fce3c852e503).
> Thank you for your contribution!
>
> Regards,
> Pierrick
>

--00000000000087a8e00655667e7d
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=98=8A",
  "version": 1
}
--00000000000087a8e00655667e7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=98=8A<=
/p><p style=3D"margin-top:10px;margin-bottom:0">linisha reacted via <a styl=
e=3D"color:unset;text-decoration:underline" href=3D"https://www.google.com/=
gmail/about/?utm_source=3Dgmail-in-product&amp;utm_medium=3Det&amp;utm_camp=
aign=3Demojireactionemail#app">Gmail</a></p></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 2=
9 Jun, 2026, 9:22=E2=80=AFpm Pierrick Bouvier, &lt;<a href=3D"mailto:pierri=
ck.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On 6/26/2026 11:11 AM, Linisha w=
rote:<br>
&gt; Add a note near the start of the introduction explaining that QEMU<br>
&gt; options, properties, and command lines may differ between target<br>
&gt; architectures and machine types. This helps prevent confusion when<br>
&gt; examples shown for one architecture do not work for another, such as<b=
r>
&gt; the pflash0/pflash1 options visible in -machine help on some machines<=
br>
&gt; but not others.<br>
&gt; <br>
&gt; Suggested-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro=
.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;=
<br>
&gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<=
br>
&gt; Buglink: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3254=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-p=
roject/qemu/-/issues/3254</a><br>
&gt; Signed-off-by: Linisha &lt;<a href=3D"mailto:linisha232@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">linisha232@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; v3:<br>
&gt; - Wrap commit message body at 76 characters (Daniel P. Berrang=C3=A9)<=
br>
&gt; - Add Reviewed-by: Daniel P. Berrang=C3=A9<br>
&gt; <br>
&gt; v2: Take a different approach based on review feedback from Daniel<br>
&gt;=C2=A0 =C2=A0 =C2=A0Berrang=C3=A9 and Peter Maydell. Instead of incorre=
ctly claiming<br>
&gt;=C2=A0 =C2=A0 =C2=A0pflash0/pflash1 are virt-only (they actually work o=
n x86 pc/q35<br>
&gt;=C2=A0 =C2=A0 =C2=A0machines too), add a general note near the start of=
 the introduction<br>
&gt;=C2=A0 =C2=A0 =C2=A0about how options, properties, and command lines ma=
y differ between<br>
&gt;=C2=A0 =C2=A0 =C2=A0target architectures and machine types.<br>
&gt; <br>
&gt;=C2=A0 docs/system/introduction.rst | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt; <br>
<br>
This was merged into master (20553466cc47af6a8c95f665b601fce3c852e503).<br>
Thank you for your contribution!<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote></div>

--00000000000087a8e00655667e7d--

