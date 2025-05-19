Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FC8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH4aL-0004Op-RO; Mon, 19 May 2025 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH4aD-0004Oe-K8
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH4aB-0005Fs-MG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747676841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPFAL57b34iCL42pakmdZlH9mVJL3DM235Fj+Jk7MA4=;
 b=Z5j9HAJ9PhKRgrUDyOPlBanNSGdGJn6cPGv8UDh9UugBPcP2YyFog93Xq5VRGQAtJfVU6k
 2PVJch3oKxBUdKvVaYlzqaPhFbnOZM1O/YFEKQRRDFqktYUTIPCi/FszsGZRp30JOjVH29
 u+BVMZwerY0iOdW6LjAWlEZjVfEXr3g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-qigfCddnOWKLNmG17NimmA-1; Mon, 19 May 2025 13:47:19 -0400
X-MC-Unique: qigfCddnOWKLNmG17NimmA-1
X-Mimecast-MFC-AGG-ID: qigfCddnOWKLNmG17NimmA_1747676839
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-232054aa634so17983375ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747676839; x=1748281639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPFAL57b34iCL42pakmdZlH9mVJL3DM235Fj+Jk7MA4=;
 b=xTfkXxXisH33GuCxVOBvdzavDNE2Io5IbeMfhmd5YKvSTRdYb+nWLPQrKwuTW3lSpo
 uwRxNVxicEyCDL0vGrdvWdIxYPSmOI2HYV+V9yI9sR+VR2U+dCbF1Wtwzssy+Vqa0TZc
 w+Av4inwkvcdXcPm4nTYCsS4uk36Sx89y+L36rhTv2FCKZH5k16gILOfkDIc2Pmcj+Hr
 DzEtI/DiUGySeidL4nD90VDCMx+ihQxDdOnotbsHnVhvdoN3YDGwpzRp4m+g/mXwc9Lm
 uMniXsDEXKYGBBXLvn8V5n9Y48kzZlzxE/130Tl7JbCLBJocg+OBEvTw6/CfLg03tTkR
 QynQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYA1nfDxGSHvACrDlfWOtxsVBDZJ+yqMI8Bbwz5PeFekdxJIuXw17uLIyzxB0VVG4vhP+yw+gqhl3i@nongnu.org
X-Gm-Message-State: AOJu0YwVwi5DVO+HV2cWwbFbsg576d7Ni9v5a+AYInTRmdN74EiXtJP+
 vyTldlR9egKqi2DPvum6XIUgfTzg0QCoZdCyGeCRv7+aH/CBInOYzBhKEVpsg3bRaEdQ+urwGp4
 CTRfig+Tfc04njxVUW+VyW/70xtGY5lge78QMReVxrYAao/8uKpcxk1hLBc5r/VxmX1QKLtvm9E
 +UgNL8n4jg84cRXc6YSsFPEKw9j/RPKh4=
X-Gm-Gg: ASbGnctmaILlc98DSXEgf4uc9tF/hClelXZZeybZ4u6M1+HKbhVqBH7I6PzG8IR9wJE
 Gd5r2bAZi6Xv4dIu7z88Sptr9syAP9K/uoy+p/tPUFwdhqdyvPNXLJQOEe81A7CTiBrwsvVgL8v
 LCjY/bKaUyZlrpRP78cCslgAsg
X-Received: by 2002:a17:903:11c6:b0:21f:7880:8472 with SMTP id
 d9443c01a7336-231de370156mr200466115ad.35.1747676838891; 
 Mon, 19 May 2025 10:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVH7WKUWvy/J+wj9tTEpF23SMhCh7jrPrGkIQ3L4StD8j0TIQ+GRuQy1Zh23V7pgM5OnGVnUvauuGccljp7k=
X-Received: by 2002:a17:903:11c6:b0:21f:7880:8472 with SMTP id
 d9443c01a7336-231de370156mr200465875ad.35.1747676838595; Mon, 19 May 2025
 10:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
In-Reply-To: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 19 May 2025 13:47:06 -0400
X-Gm-Features: AX0GCFs84wgR-c-nL0F45Mo3EINgmlIj2qEaFtDvrvimp74N9Rf9XT7MR4pLkUk
Message-ID: <CAFn=p-aL6OQKqq4nLp+LV2QxpRSo8yp3c0veT+DMG-Tt7aSYxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] docs: Bump sphinx to 6.2.1
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 devel@daynix.com
Content-Type: multipart/alternative; boundary="00000000000025b9e8063580b993"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000025b9e8063580b993
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 2:17=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> Supersedes: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
> ("[PATCH 0/2] docs: Bump sphinx to 8.2.3")
>
> sphinx 5.3.0 fails with Python 3.13.1:
>
> ../docs/meson.build:37: WARNING:
> /home/me/qemu/build/pyvenv/bin/sphinx-build:
> Extension error:
> Could not import extension sphinx.builders.epub3 (exception: No module
> named 'imghdr')
>
> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3
> version of python-sphinx and the readthedoc theme
>
> Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new
> sphinx version.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

I figure if this causes issues, this early in the development cycle we can
roll it back or pursue alternate solutions if necessary. I figure because
this touches so much stuff I wrote, it probably ought to go through my
tree, so I'll stage this tentatively.

(Paolo, Peter: But if you want to stage it instead, be my guest.)

---
> Akihiko Odaki (3):
>       docs: Bump sphinx to 6.2.1
>       docs: Require sphinx>=3D6.2
>       MAINTAINERS: Add docs/requirements.txt
>
>  MAINTAINERS                |   1 +
>  docs/requirements.txt      |   4 +-
>  docs/sphinx/compat.py      | 230
> ---------------------------------------------
>

Oh, thank you so much O:-) how beautiful...


>  docs/sphinx/qapi_domain.py |  33 +++----
>  pythondeps.toml            |   4 +-
>  5 files changed, 20 insertions(+), 252 deletions(-)
> ---
> base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
> change-id: 20250508-sphinx72-400c521af710
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>

--00000000000025b9e8063580b993
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 10,=
 2025 at 2:17=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@=
daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Supersedes: &lt;<a href=3D"mailto:20250=
505-sphinx82-v1-0-85f2418b33b1@daynix.com" target=3D"_blank">20250505-sphin=
x82-v1-0-85f2418b33b1@daynix.com</a>&gt;<br>
(&quot;[PATCH 0/2] docs: Bump sphinx to 8.2.3&quot;)<br>
<br>
sphinx 5.3.0 fails with Python 3.13.1:<br>
<br>
../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-buil=
d:<br>
Extension error:<br>
Could not import extension sphinx.builders.epub3 (exception: No module name=
d &#39;imghdr&#39;)<br>
<br>
../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 ve=
rsion of python-sphinx and the readthedoc theme<br>
<br>
Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new<br>
sphinx version.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com=
">jsnow@redhat.com</a>&gt;</div><div><br></div><div>I figure if this causes=
 issues, this early in the development cycle we can roll it back or pursue =
alternate solutions if necessary. I figure because this touches so much stu=
ff I wrote, it probably ought to go through my tree, so I&#39;ll stage this=
 tentatively.</div><div><br></div><div>(Paolo, Peter: But if you want to st=
age it instead, be my guest.)</div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
---<br>
Akihiko Odaki (3):<br>
=C2=A0 =C2=A0 =C2=A0 docs: Bump sphinx to 6.2.1<br>
=C2=A0 =C2=A0 =C2=A0 docs: Require sphinx&gt;=3D6.2<br>
=C2=A0 =C2=A0 =C2=A0 MAINTAINERS: Add docs/requirements.txt<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0docs/requirements.txt=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0docs/sphinx/compat.py=C2=A0 =C2=A0 =C2=A0 | 230 ---------------------=
------------------------<br></blockquote><div><br></div><div>Oh, thank you =
so much O:-) how beautiful...</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
=C2=A0docs/sphinx/qapi_domain.py |=C2=A0 33 +++----<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +-<br>
=C2=A05 files changed, 20 insertions(+), 252 deletions(-)<br>
---<br>
base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e<br>
change-id: 20250508-sphinx72-400c521af710<br>
<br>
Best regards,<br>
-- <br>
Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_bl=
ank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
</blockquote></div></div>

--00000000000025b9e8063580b993--


