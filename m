Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D207E8B361
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 21:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNdT-0004sX-US; Tue, 03 Feb 2026 16:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnNdQ-0004rl-Cl
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnNdO-0005Fl-MM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770152908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZuhNpISDIBG+XigPnGHMcwBsZVISdhYXdPEl/9EbhEw=;
 b=L4r2nb0quwy3NMrS5lvm8mVxAANKOdbk4f0nA7ZAp9Ss0MqVq/Sd/6+JPZkVHZ0S7skqh/
 p5QyJnJUlQ76Xr/vLe7nNtHDzduqCdLHT5EoT2jCEPVMr3SBmXICiyYzUPFii85ayBZKTU
 DWGcYh1mJv1rWn/kx5Kz1GBLVofcl9Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-R9Y0ru_sMLaK7t-PDiTphA-1; Tue, 03 Feb 2026 16:08:27 -0500
X-MC-Unique: R9Y0ru_sMLaK7t-PDiTphA-1
X-Mimecast-MFC-AGG-ID: R9Y0ru_sMLaK7t-PDiTphA_1770152906
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806e7c4220so527585e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 13:08:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770152906; cv=none;
 d=google.com; s=arc-20240605;
 b=NxBMb57Qyo9ChVxa7rip6lKEQ6j1GDrpCE68epP6xUYnrsGZroIkxl8w2R0iBvsguV
 uA6iZ3UWAbnqiquC8aJWGKO2GiB7z9ZB1HxGXTStHU+58RoHhHR17PAT6CoHKiF74dwo
 T1LvzILiwqzFlq0p2ctg3UyTnaYjl4kZXgmjM3X0jdoV8U0TLXonMqBDrYrf2YellxIB
 5lYd8yPEqpmgofN60G+BmNDysnExjW/xFZkIA536HcriggCMIvL/31HPotcq6GxYWpsf
 LP25lj0ra0jU0EkckAyL9Fl1JYM4jlXnR4kuSQ1ytLC9srwiYeYKB5U5BZMnb9u4zCB7
 r/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZuhNpISDIBG+XigPnGHMcwBsZVISdhYXdPEl/9EbhEw=;
 fh=Aqbdj/jSz5Po3e1fl7F41zRPtpJ1ExtfkaWo4ELQX9M=;
 b=cMBUtAER3QJSK/iZtCqY3qJaUVFefd/Cc2qLoR5SqUBXe4AwFBWYL//WPSjWzAIRu4
 2E29kSYJso+qBgWCl1zHQLdgMzZEUIcvU3OPFPtd2kUCpWzVgGTCTWPfpnI61SGJI2MK
 5hnQvtPg5/+KTbEX/OJmtkwnbrOcGU2nk6IiMl0MrknrsBqVqfZBN8Wkogb1mf9/5Vkr
 sutMN1NxUrvASvuc8Ypx3hZ8M5uv+l+8QTy6+blqUQZ3BvvIHdrrMuIzcN6wwYCTpnbx
 5mZSI/+hztJus9XpqBTOkBYvINdfkiJpZ5kZvkNVhb0bPMJa7TCvPchqTVoB7OvS1Vjh
 lOdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770152906; x=1770757706; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuhNpISDIBG+XigPnGHMcwBsZVISdhYXdPEl/9EbhEw=;
 b=WP6H2m58q9SHBJSGBUKH635ovHiENNvr8t3Vj9LIKm2ysiBqOqYYzwlWFqFesqBC5B
 NnsqyLA5akP7C4UUUtvjMv+sOPnUyd1nTwaWoyEsActL4pX2E1WgTlZzChOY3rbMmG0i
 R+Mwk3/YLuzmfkDFM15bnoMWEil8VkWhGoUQu3jPWSynagpPbDDq9POZ+XSn4yhOavRC
 hUeiGi+ZxIRjNzgihldK+oMEht2GPs5UDZrBbkiEURZsWBfegMINsMQS392vkCiOKt2k
 uNObIzUKm6Gfr8iK3XeYozKU0fwEZWWm7QoBtw87cDl6c8U5evA++KNXekhtX2tW68kd
 oAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152906; x=1770757706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuhNpISDIBG+XigPnGHMcwBsZVISdhYXdPEl/9EbhEw=;
 b=axDDZpohwSLbijEnJtp8bpkbfncUI7C4flbtxspmJV5SCxIrIFGgBKteRAql2axNAy
 s+ThOJ8wwPFD77pU7JziV84rgZU1vJPANfcbDCCx0yEBL7oLkEPlmLBfn8ugO2JQ+Evn
 BuTk17toF7aqzDbV7/TP4RnMmapxLGHR7Y8v7J6Jwqz89D5To7bhKFE9BR+Z7yPeY7OM
 MXtzxlR7Ojjmcbf23gIHYyWAepNkkQLowjBZBKDK+is267MkDQPWZjanMyXQ4ZdBjNwn
 f2xnuWi53550/valFPbBxzciDa8fVObpLzgUZIkZxLwtF7e5/ftf0snO7YvRwgE5WvU8
 NxTQ==
X-Gm-Message-State: AOJu0YyE6AFO1YBPSyiO3t9tbX3zZWEycK7G31RaoBojikB25kUB2097
 QcCGEeu61A3mBRch1J9B14768yFi/C4H1FrBSqFGXNMcVfY6VcIsDEW1hQhwFzFGfLIrMfZKRl4
 1+NhpO1MppD4ITEvgCtHJ0HvSordAvu+pSktTrNixxN05j/IxaunIsoNERzI3B6Tdjuu+NF4yH8
 DdImZc3HokTaUl251rgMyD38RGbKpz3R4=
X-Gm-Gg: AZuq6aJmNxVbxgV1gu/yKgBOk5Rcjm4SlA3L0/Qq9DsfTDH9lv+O/uNHoPBfXQq/Yqk
 JbniHg46uiZ1JiEMCKSKfcGkmSZc3cweXf6Y76IN+MxX3WUXeoeaKWd+RVqTNknqsHTO9udEcGd
 1Scy0HcLhGdYoNvgVbew8mz5bfHl6tr7dPliZIeKqM1481U0BshDdoPwCAKOOkRXd+LcwpD9qkT
 Kx8+kFyHgrH0mfWVh0+JliugbmudNoTy1QUGpvLyd9xvhR1r/JxJKV0mNjY6U47EhSCug==
X-Received: by 2002:a5d:5f88:0:b0:435:8fd6:5949 with SMTP id
 ffacd0b85a97d-43618059744mr1112134f8f.46.1770152905900; 
 Tue, 03 Feb 2026 13:08:25 -0800 (PST)
X-Received: by 2002:a5d:5f88:0:b0:435:8fd6:5949 with SMTP id
 ffacd0b85a97d-43618059744mr1112106f8f.46.1770152905486; Tue, 03 Feb 2026
 13:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
In-Reply-To: <20260203203512.672552-12-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Feb 2026 22:08:12 +0100
X-Gm-Features: AZwV_Qh4yO5H3NEbHqnSU3ijloyAr0GGK4jTeRIkVML7M0TpZk0LqhuXl4bXoac
Message-ID: <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000214b140649f1d75c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000214b140649f1d75c
Content-Type: text/plain; charset="UTF-8"

Il mar 3 feb 2026, 21:36 John Snow <jsnow@redhat.com> ha scritto:

> Add the local python package group into pythondeps.toml for the
> tooling This makes qemu.qmp, qemu.machine and qemu.utils
> packages unconditionally available for tests and scripts.
>

Out of curiosity why not add setuptools and wheel to the group, at this
point? Can be done on top of course.

Paolo


> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  pythondeps.toml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 743e2a8848c..89256132fee 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -37,6 +37,7 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed =
> "1.2.2" }
>  # system packages, or python packages we vendor.
>  [tooling]
>  "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
> +"qemu" = { path = "python/" }
>
>  # This test group is for functional tests, and can include dependencies
>  # fetched from PyPI.
> --
> 2.52.0
>
>

--000000000000214b140649f1d75c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 3 feb 2026, 21:36 John Sn=
ow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scri=
tto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add the loc=
al python package group into pythondeps.toml for the<br>
tooling This makes qemu.qmp, qemu.machine and qemu.utils<br>
packages unconditionally available for tests and scripts.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Out of curiosity w=
hy not add setuptools and wheel to the group, at this point? Can be done on=
 top of course.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
---<br>
=C2=A0pythondeps.toml | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/pythondeps.toml b/pythondeps.toml<br>
index 743e2a8848c..89256132fee 100644<br>
--- a/pythondeps.toml<br>
+++ b/pythondeps.toml<br>
@@ -37,6 +37,7 @@ sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot=
;, installed =3D &quot;1.2.2&quot; }<br>
=C2=A0# system packages, or python packages we vendor.<br>
=C2=A0[tooling]<br>
=C2=A0&quot;qemu.qmp&quot; =3D { accepted =3D &quot;&gt;=3D0.0.5&quot;, ins=
talled =3D &quot;0.0.5&quot; }<br>
+&quot;qemu&quot; =3D { path =3D &quot;python/&quot; }<br>
<br>
=C2=A0# This test group is for functional tests, and can include dependenci=
es<br>
=C2=A0# fetched from PyPI.<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--000000000000214b140649f1d75c--


