Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57726C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XI3-0001rk-Sm; Mon, 07 Sep 2026 07:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XI0-0001rQ-Rn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XHz-0005EH-5s
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9FUJcgOQ2LHHp0ShqGP5U+oYo53OmImLRCNlt4qxAw=;
 b=W+vQE9s10l6XrY+hdE+NCXkZUtm4CCiV+qbSOpQa27nR3TCdqJkAIMcg330N6++ZlxEGrq
 DZwd6Necsmz9cYk1G6sP8X/sA4vHwvaCBU6BEINLT5RCfbELbF9mBHt+5ZP12oGFCABIv6
 /oek8rpHH56LdKrHCHQKjgEKNNsJv3c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-hZLR_NqFOgaELR-0ytC9nQ-1; Mon, 07 Sep 2026 07:13:25 -0400
X-MC-Unique: hZLR_NqFOgaELR-0ytC9nQ-1
X-Mimecast-MFC-AGG-ID: hZLR_NqFOgaELR-0ytC9nQ_1788779605
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9103c9c0b34so77097176d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779605; cv=none;
 d=google.com; s=arc-20260327;
 b=PL9McNh1igTGSuyNYW6W0n+mti+NO2dHyKrp54jjoz0jp3Gs9zAt8tgreoez0hQawq
 Oe9BQzwlNX4lXTTDxaMtOTOoPEsgtMdvCV7XWn/uk8oKsWmTBsdNYWe416tVI0izN4Nd
 crtBjZ9BvJzCNvcp09MQiGSb2knyBhJUO5b32pqu3NFjKK7T+X3mwpW7Ugj+BJKyECr3
 UsHnpjSl0aDNlFCaUBbruLH9Q7IYAlSinQ35N6nnfVPIi/G/Wf8vYNgGu2PEa86VVRJG
 yiorWalIQyQlMN5tyqHsv+odg34F++3K4m+6xm9f4vw7CuidSWen0fkSIl1xI5Ly71E3
 Njrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C9FUJcgOQ2LHHp0ShqGP5U+oYo53OmImLRCNlt4qxAw=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=TD3LlTgsniuZbE2R6D4qU74bM1UEfz0yHob/j8O9w18t6AVg4ly+MfTquOOBbR2eem
 GWxI/0hPVy3UZ+y9SS1vRqE0dhoy4n/HDQh3WRjRVmQzosY/KdZj5P+g873RqOlF1SiC
 RNqXJTXDEaD0oDB6ox+hYK0NAII26uJi31I7IknzIS7L46H1NxDylFbIlbs93nyV2GHX
 5Xzu032GL59N/D5ZgkOMUUa4RVnN0IPDl08v3C3i/xrLGnI8er24RQZZYgLyb2uCD/Pm
 6bilK4P4p0ZQ8EFTLdU98daZfgh3LMH0L5No1NKKeBPN+JAXdzZ6PCLGxGeJS4ddbQ5Q
 VO+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779605; x=1789384405; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C9FUJcgOQ2LHHp0ShqGP5U+oYo53OmImLRCNlt4qxAw=;
 b=nCBm/N/uhubTm21xY3r0bobp+zlcfnbE3Zm12qfRGIjLB0VHh+606C17axyLmaTITk
 iaS2GukUSMThfhJ9SjqZDyGCAe9rzFHiizp0KWQGuyWu/oyxNWQkAHqENBwAduI70TbS
 +qifjolO+8y4yRwdKQzQkD6N1RiiIvnkX3k9LvYP/xt/5Ll9uAjyyAUnIvhj2jjIlVbV
 tjInH4aDy89YtYvwPYBZV2Xy4xzeD3JnUwSfkHiJMchBSbc8rMpGQyLKS8rR7tqUDzle
 Wgf9r8nhjKEC9Xz9d9EhGAcdrPGOnfUkb8a49EnYDsNDqlODRoTaO/F8S4hzY5djPaHJ
 oLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779605; x=1789384405;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C9FUJcgOQ2LHHp0ShqGP5U+oYo53OmImLRCNlt4qxAw=;
 b=iX3MIb7MamujewQcF2GLWmfXf6WLZG8x+uCXAc8l+le2JegP4Wn9HAjJ0TPDgI2fvK
 nb3GGs0e8ZzS6EtkLV7gVc1ZkImVVuAUMyrSHf6rnTU/+8zNKAN/sCr5mJxATVOw3pJf
 6/oGHE1UxN5QsJi6LnejFu7r9f3CxURYeU2kD9mqMEnMJ6ue6+SeRIQuYOl5Ar3KkJo4
 BpplaBhUoNBmunqte/EjsP4VvQ4CwDw+K/dJlFQHQ49bnGLPRi9lF5Mcwmuo4KSDZOFQ
 6nd1aZOJFRf7fdo11dbdA1fzIGmc2q5Mvt1+Rhn42BaAA0q/IB4CQH3Qf6RJVpIFWgBb
 Z7YA==
X-Gm-Message-State: AFuF++nuF6B0ubl198gM8M7XX0jySRCAI+zfHBmYl5TyS2F9ZTpA/TXi
 l0eg24914bRsrvAm7jmwdih6ZBdpHpkUzsQzVkcy4VYLM3LAvvAbI6XY0nbxQNdIY9qaoOjHiQ1
 mXsjVKPU41JCfRyItbmQ+bbryG16aG2jQG8+tkuEK8BErrQBAIAoCfWzbzlVLHW4SyJP8gZGMe2
 sgUJNWvQIVoQq33puJLPVluhn340/e3+U=
X-Gm-Gg: AYBFou2r1wsbTbUWzL1HvAWGCW2bbhFlVBtXwXjBUd8PQqD9MLiILp5mPYuna3cFM3U
 80srXIZVHDUQOfIbjyGAEvN414IQFCoFY9o6YoJ5LEJ+J2/LnbDm6LqE8ComAJTPk+QT0fjKPeC
 LI58aP8TPMvoFJlaROP3efmdxIAbOIkaRbqp4B0wrvK8iZ/XpYaKk89hoaEKI=
X-Received: by 2002:a05:6214:21e1:b0:910:391e:9e01 with SMTP id
 6a1803df08f44-9103efa2176mr256078526d6.13.1788779599792; 
 Mon, 07 Sep 2026 04:13:19 -0700 (PDT)
X-Received: by 2002:a05:6214:21e1:b0:910:391e:9e01 with SMTP id
 6a1803df08f44-9103efa2176mr256077936d6.13.1788779599293; Mon, 07 Sep 2026
 04:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-4-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-4-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:13:08 +0300
X-Gm-Features: AcwNN1XN84pulMIFFbyCWxV3u-f7IhvvPx3kmqeFY9tRL9GBPfgR3jU6ioLVjGk
Message-ID: <CAPMcbCpyKV4AOtXsxi_Yg=mJ0uhw6AGG603o7j68gWFP2FBySA@mail.gmail.com>
Subject: Re: [PATCH 04/17] qga/vss-win32: explicit NULL/zero initialization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000990d9f065ae2b486"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000990d9f065ae2b486
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> We use -ftrivial-auto-var-init=3Dzero, but static analyzers don't..
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/install.cpp   | 2 +-
>  qga/vss-win32/requester.cpp | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index f89658d277e9..12b045e2074f 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -61,7 +61,7 @@ static void errmsg(DWORD err, const char *text)
>
>  static void errmsg_dialog(DWORD err, const char *text, const char *opt =
=3D
> "")
>  {
> -    char *msg, buf[512];
> +    char *msg =3D NULL, buf[512] =3D "";
>
>      FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
>                    FORMAT_MESSAGE_FROM_SYSTEM |
> FORMAT_MESSAGE_IGNORE_INSERTS,
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 493ecd57172a..52176d751274 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -170,7 +170,7 @@ static void AddComponents(ErrorSet *errset)
>      unsigned int cComponents, c1, c2, j;
>      COMPointer<IVssExamineWriterMetadata> pMetadata;
>      COMPointer<IVssWMComponent> pComponent;
> -    PVSSCOMPONENTINFO info;
> +    PVSSCOMPONENTINFO info =3D NULL;
>      HRESULT hr;
>
>      hr =3D vss_ctx.pVssbc->GetWriterMetadataCount(&cWriters);
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000990d9f065ae2b486
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">We use -ftrivial-au=
to-var-init=3Dzero, but static analyzers don&#39;t..<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0| 2 +-<br>
=C2=A0qga/vss-win32/requester.cpp | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index f89658d277e9..12b045e2074f 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -61,7 +61,7 @@ static void errmsg(DWORD err, const char *text)<br>
<br>
=C2=A0static void errmsg_dialog(DWORD err, const char *text, const char *op=
t =3D &quot;&quot;)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 char *msg, buf[512];<br>
+=C2=A0 =C2=A0 char *msg =3D NULL, buf[512] =3D &quot;&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FORMAT=
_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 493ecd57172a..52176d751274 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -170,7 +170,7 @@ static void AddComponents(ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0unsigned int cComponents, c1, c2, j;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IVssExamineWriterMetadata&gt; pMetadata;<=
br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IVssWMComponent&gt; pComponent;<br>
-=C2=A0 =C2=A0 PVSSCOMPONENTINFO info;<br>
+=C2=A0 =C2=A0 PVSSCOMPONENTINFO info =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0hr =3D vss_ctx.pVssbc-&gt;GetWriterMetadataCount(&amp;c=
Writers);<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000990d9f065ae2b486--


