Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CA91099B35
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eb2-0001bj-QH; Fri, 20 Mar 2026 14:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eaq-0001aG-Va
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eap-0005QG-2n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774031344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xaUYVokvd3twZDiMkuZAkSQsDI6o1mzDua/c14Nmco=;
 b=cg63PqLS+p/cnDANtvL0hS+sB/xvaG0KizOgD+rzBP2x3dB3u8EfXLP99OKy+Mtte52VcV
 40YKQRch8XI2dK4kk0fXia4Jchi8NHW953iOMhVNkclAWEb7hRWQ4HHl9eq7uA5Utkmi9X
 BWmH+FMvmIqBVYpbfUR1tkJtSzHK1PE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-5XtO8iwgPPy-_nTcRB7f4g-1; Fri, 20 Mar 2026 14:29:03 -0400
X-MC-Unique: 5XtO8iwgPPy-_nTcRB7f4g-1
X-Mimecast-MFC-AGG-ID: 5XtO8iwgPPy-_nTcRB7f4g_1774031343
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b389f2560so64652101cf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774031343; cv=none;
 d=google.com; s=arc-20240605;
 b=BLm5aPicrYjyx1+eju5UCnGllkp2+TjPxKzx22Of27HeqZ58iFiI+ZGzUXUqKyYQ4Q
 2YxbDQlP8Xpyg7efMJPYzc2eXfZoNoAURhs4WfKvEwxriqX513rWY21fl7Vp7tdipg+b
 S/McB52+uj54vjX26JQk5s9eH9Q0p13hHUuacsjhRDnsPO+cu10Y5a2geuLCTga/Wcgb
 1eGNEyOMLz6gZOaWXtKhT3NK03dRc4k7xt9MQ9kG3GYi6mkgIASK+eC6z1HC307IIUyl
 ibfzrIM4shWrQzoMSuTNR06HDf7r+CIxlzaUVeS5k8asITZ+OIyrkQhkjkXlZM0nzr/V
 y+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7xaUYVokvd3twZDiMkuZAkSQsDI6o1mzDua/c14Nmco=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=W10tbhM9dBuPJX37Ei2Egb7Scdc5Zo7q6INHNb/0wzOZqs1r0+Jwr0J6Itux1nWQx3
 SSSjdV9EZB4ve/JInAw3mJppHVf/vhirWuLreuOinlrOKIpA8QFZCVXysGI9O9h2aJLL
 xGDXaBewcjfXDi7HiBjgEn6GDvOwqDP7DAx2OxZRq7TRskrjR/cd3ILglTjiMrUQLC1D
 TqAlK+YE0k3aMxiy38Ko1axx41xH8K9YwPrGc06NbhEFipb8J4GUsMZfVYhVNWwUiKaF
 exaHG7rDjRkMqfqW/DmOTZ+UM0OC3AcFovfeHSAef30Et1WSWc//j25/1eSHMg4U7ibw
 uhmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774031343; x=1774636143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7xaUYVokvd3twZDiMkuZAkSQsDI6o1mzDua/c14Nmco=;
 b=TjpWAFXt9vRRQMuYYIELSTqUk44MjAPHilDihw/veRxnUVkAbskqFBS5GC5MyEhwpY
 rp2qu8PVYSqYcNybFhz+S5lkta/vtJ3NQ0A9mzOw2hEQfRXzyLafxnhcIZGoCARBJyAz
 O7UVOll3jnOen2cD0oT4VNO5WSA8qVJjNQEK071K5WnjjT/MgxjvRnTAA2VPmRqaWuqb
 ooKm8L8TqqRTqcv5jfTNQYELxKhKLO5opQ9cbNU1jJ4U/nT+61mtRXnNuq8MymiB9GuT
 CC+o8O/Hl6BgERiuXMpM45q8z5KvOkkS0+jAur4ZbMECRTboYy5jpbKNwxGqaxQEipHf
 rCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774031343; x=1774636143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xaUYVokvd3twZDiMkuZAkSQsDI6o1mzDua/c14Nmco=;
 b=D7j3B68jfxOKmfR3jzZ41ImuW2GSZ2yS0y8IFrB0oZtryAefSI5T1o7Fod7mm221m+
 IaH+YT66PbmZUZaJiDVyqenIPHfxmhhUdOX0YaltBzHdKhIntZGaZgTDotQWz2lTS9lY
 wkAcShojU1aQyggdknBWjYu4fNa+3v0ebU+B76iMn3p/S8vSAzvlXQ7nSIMs43yTqeQr
 fi3t0PkINi9tAGseVKVMQVcnvETWDKit3IMu6usEYvptpgChxkjTmn5Mb26XmOhUtfBE
 6qoc+Q/dfQUb/L4hC8Tbs2yHRlepVdO7d4Dw007jIHlx8ZVbN/DbneXuqjloF32NJjGR
 Ls4Q==
X-Gm-Message-State: AOJu0Yy8G4277vuYoUNiwAxsDkVEaOfliCC+dRyYar7BD3KqC9e7PQ1E
 qk5uf1cu++UxflvkIicJ4J/rU+sHIYPyjHHqp2TDgyKrsz544n5KM0iAOs+N7sWtZofSWMWingy
 0FApNYNsuRJI1/sQQQpqmjatoRJ5aMoMQ8HzqfJG/2yA1zfbYnLkI7XLMPLEeedmlt/Xzv5GGqX
 T3mqQSzSDx0IAN8cnCvBVJDZ/x+W595umb/w9knV8=
X-Gm-Gg: ATEYQzyOzGLt5e0CvVUxbu+YvvbJhJElQb3H3LqQvEjxOd//PAS+1VoZpqepeUmcJIP
 zUgkr2FD0ySQLULg3BcDTS34UYCPuHyrLltOls02b8IZ1S3A4v8QjTP5taIv8Ezx1hGW6mV4J/M
 UfSKoaV2rMrXoqZSxatNhmy0Kfhs1TBZXgIqoBn2B8HllXpInrD/ypgOvZTwf28JLpaL7kDDlJ6
 MYG1JqYxKRWgNTmMXsa6KZc24BGvRdVfn5Ikw==
X-Received: by 2002:a05:6214:3104:b0:89c:4e50:1921 with SMTP id
 6a1803df08f44-89c859fa733mr60054336d6.26.1774031343010; 
 Fri, 20 Mar 2026 11:29:03 -0700 (PDT)
X-Received: by 2002:a05:6214:3104:b0:89c:4e50:1921 with SMTP id
 6a1803df08f44-89c859fa733mr60053636d6.26.1774031342420; Fri, 20 Mar 2026
 11:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-7-jsnow@redhat.com>
 <874ima613c.fsf@pond.sub.org>
In-Reply-To: <874ima613c.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 14:28:51 -0400
X-Gm-Features: AaiRm53zC7lXcib3f4sWaGKDPuAAT0ej2VbO396o59xY1Ys45dfKTRM4dL3fvAU
Message-ID: <CAFn=p-Zp47T=iWRAT=zRD1ZOqGBP8fpYi0D1awbQ7qU=Oz7VLA@mail.gmail.com>
Subject: Re: [PATCH 6/8] qapi: enforce doc block section ordering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fc5c3f064d78dbe4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

--000000000000fc5c3f064d78dbe4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 10:13=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Ugly hack, gets the job done. Likely many simplifications can be made a=
s
> > a result, but I didn't make any of them. There are some inconsistencies
> > with human-readable vs ENUM_NAMES in error messages in this patch, but
> > it appears to work anyway.
> >
> > Consider this patch more of a rough idea and not anything approximating
> > the kind of code you'd want to see from an Enterprise Linux Senior
> > Software Engineer.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 39 +++++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
>
> Missing: update to docs/devel/qapi-code-gen.rst.  Suggest to put in a
> FIXME, so we don't forget.
>

ACK


> Missing: test coverage.
>

Do we need to test every possible sequence, or just some characteristic
examples...?

>

--000000000000fc5c3f064d78dbe4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 10:13=E2=
=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Sno=
w &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferr=
er">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Ugly hack, gets the job done. Likely many simplifications can be made =
as<br>
&gt; a result, but I didn&#39;t make any of them. There are some inconsiste=
ncies<br>
&gt; with human-readable vs ENUM_NAMES in error messages in this patch, but=
<br>
&gt; it appears to work anyway.<br>
&gt;<br>
&gt; Consider this patch more of a rough idea and not anything approximatin=
g<br>
&gt; the kind of code you&#39;d want to see from an Enterprise Linux Senior=
<br>
&gt; Software Engineer.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 39 +++++++++++++++++++++++-------------=
---<br>
&gt;=C2=A0 1 file changed, 23 insertions(+), 16 deletions(-)<br>
<br>
Missing: update to docs/devel/qapi-code-gen.rst.=C2=A0 Suggest to put in a<=
br>
FIXME, so we don&#39;t forget.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">ACK</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
Missing: test coverage.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Do we need to test every possible sequence, or just =
some characteristic examples...?</div><div dir=3D"auto"><div class=3D"gmail=
_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000fc5c3f064d78dbe4--


