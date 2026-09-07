Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91674C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XOm-0003p3-0p; Mon, 07 Sep 2026 07:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XOl-0003ot-3T
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XOj-0007SO-Fw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788780024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3NIhSTKPfEWvJxRqV9EsS2//wk0CP8JC0tAmROnzU0=;
 b=MoNfH+UID3EKf8YoNZZVUZg/fs2tdFCWaiaoVENzsdU3VIyA0NRqdeBEGiuzMXBV9VHp3S
 JTFM76IgMdOZ+vfN3nLRrpD/TnYHs4S5bEXRUjhe0HTrfaAEXk07bOGLwDiQ3noU05f23b
 ugGf0yTHi/poWNFjhJGfPNPNoT/06p8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-tdxRaK4RN6avaB699_hbYA-1; Mon, 07 Sep 2026 07:20:23 -0400
X-MC-Unique: tdxRaK4RN6avaB699_hbYA-1
X-Mimecast-MFC-AGG-ID: tdxRaK4RN6avaB699_hbYA_1788780023
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90e8341cfb4so25680816d6.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788780023; cv=none;
 d=google.com; s=arc-20260327;
 b=ESswOQTGvXPTzdjQE2SA/CzMS/jH8RTI/iUBz5Y3SFPsaaFgU9g15Xkji+bPWMPgHC
 BL9nh79fnBDm2trVerr1f+JJ2irFKUtiAXPMPuxR1NThCg/Aiwjf+RAPuQeCGufFXc0M
 jvYxBWzxnZbuW8FUtMu9OONvWo4NB6Gx1RD8d23e0BnJ0ysohBrmDXuFmd80mEkOQwDk
 OJsL/39NMppUvQl+gJeAHq6DYVwZsKfvRgL44oZuwBpwYv6W8C77hFu2SvjgUR/mRqcu
 PM70r+WGxBPnPf6ST5IHe/cZOY3avyC39eWWGLPigzy3L3AsTx9/kL1zOtYmhSywje47
 qgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L3NIhSTKPfEWvJxRqV9EsS2//wk0CP8JC0tAmROnzU0=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=LTBp9fSU4IlGEGubBdNjzHCkb3MTkApX5kJGG3vju1nxMbRiqH4tvCR66dN14U69WL
 F3RG8cJCYNEIz2m6i67BlJeZgjMwGOFh1HCxO6ADweICKaCaV3w55QKPds12edeUBL9V
 99XZN2nZWczFRo180Q3CD9FCon7dCtSDMeJNCcHHR5/IEyWmgNvNcg+DDLXGXgQQGeyi
 qMlFQ0a962eUISYA78MZMvAqPR5dhpuNCPXZNaMOwtq2COSHCDu7qMECXxi1XuHgZeb9
 0v5PMcAmFyptVM9yhsXwOOwhfS8wkKiztDYP9SP8qpVSvt5m15XRYdVFx5Id/q+bw27y
 pOjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788780023; x=1789384823; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L3NIhSTKPfEWvJxRqV9EsS2//wk0CP8JC0tAmROnzU0=;
 b=bAHX990T5sc+Gcg258IkezEWCBrTRbhppNCY48kA/MJTS3Fv7AIc7UYIjRc3lrorsA
 K12GWE2S9zEBLL3NwFyNsyBalqTGJqhv73uAyv4JjhQoPdXbohlBNM5MxODLUnwH8BlZ
 t7As6aaw1YX3bBTpIKqGV4plI5vbiZBW/BUes5m2Z42RQDMKGQ03F6Q1af7RwfE7fFnU
 6LLUUw/XEeQ8tAuZCiDD2VUMmv0VYh22+YDS3QdYlgBzpX3PG6P90S5hWcpt7+AAkLuX
 BnwdYlpQ77q5xua2jgnF2onyaUMqwtGBhksIDXjCgCjEMmS+NuFeUyxldoWMsZSZdjXh
 WHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788780023; x=1789384823;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L3NIhSTKPfEWvJxRqV9EsS2//wk0CP8JC0tAmROnzU0=;
 b=m4J/W7a5zMkWzHPrXMKAlJl+1awCCi0YRf65hH4R+SxMLI05uBX5BEtj0KELRDtaTR
 OgTK5dKMndCHga7vhScnpnyBDCAOyP+hfEk+3DqFnYnMfjohR/jkJe7QpXCm7KOVCOou
 M22dy7rWCmI/IzUsA5QmSrtRwGY3eeJAidSXtSH+VTfKznKc8ITE4Xi7fvPKxi0OkR/w
 qWJVaoLqfKtNz+VQq80pc4Ogqv3JuuBJpXUT1xhqJ2LXCVB2kWENjhay8c9SgpIh2Hra
 i/fJXCz9B9xsub8S9mjJUOAmRoiEvpg9ZYWun+Fwm5LuUlV/iI55UX3tJ+Nx136ehqA6
 wf1Q==
X-Gm-Message-State: AFuF++l2BBoLzrGVMcIJGypWd58lN9xmN2INZeHJ1NIjmvlfs8S898zs
 IaMv96hYXACFA+QKhb4746ZmeBBjffXQvKDi8IUbSOq0r9kFOs38oqDCAeiYhrRIyn1gN1l+U0n
 eq3/8zNi280E8XncFUTQw/siXuAa5u9UHry/yRriFsE89ryY565RFSx4JUEZB+kHAwfI9TSrwqW
 O96QohRwk94uabs2WpLLEBx9IqbTQrpjk=
X-Gm-Gg: AYBFou0R5+i50U1ZzhNfIGCv6BiKuFn0f+QWcaovXxKhSULf7DnMmxtb0isyMKinnV3
 Dwi4QzAx3QR2jsQoPli4SY9wk1CGrloPo3JeaqXMjUnBoeOCEQ+z+Ovgmx63Gu003h0oVJBnlFf
 L5lGcTkluriG3FxZc4nGFTz1dCIVpezZ6r9mT35phEDPWVyL5pwOU/v/f0MgI=
X-Received: by 2002:ad4:4ee4:0:b0:910:3453:d4a7 with SMTP id
 6a1803df08f44-9103f0365famr258665766d6.33.1788780022678; 
 Mon, 07 Sep 2026 04:20:22 -0700 (PDT)
X-Received: by 2002:ad4:4ee4:0:b0:910:3453:d4a7 with SMTP id
 6a1803df08f44-9103f0365famr258665016d6.33.1788780022137; Mon, 07 Sep 2026
 04:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-7-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-7-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:20:11 +0300
X-Gm-Features: AcwNN1WhBc3lM_50Yn5_SyKHa5HQUkxLxLPubfXueISuZx2SOt1fFMe8cWI8EFk
Message-ID: <CAPMcbCqh3a2XFDXgTFVBy1YQeKxCAV-Z-UF=i0VOzLqN3VKKKQ@mail.gmail.com>
Subject: Re: [PATCH 07/17] qga/vss-win32: allow pceltFetched==NULL in
 IEnumObject::Next
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000cd17b6065ae2cd46"
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

--000000000000cd17b6065ae2cd46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> The COM IEnumXxx/IEnumUnknown::Next API allows callers to pass NULL for
> pceltFetched when celt is 1. Guard the write to prevent crashing.
>
> Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as
> DLL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/provider.cpp | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index 79906dcc24ae..377571b94881 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -117,7 +117,9 @@ STDMETHODIMP_(ULONG) CQGAVSSEnumObject::Release()
>  STDMETHODIMP CQGAVSSEnumObject::Next(
>      ULONG celt, VSS_OBJECT_PROP *rgelt, ULONG *pceltFetched)
>  {
> -    *pceltFetched =3D 0;
> +    if (pceltFetched) {
> +        *pceltFetched =3D 0;
> +    }
>      return S_FALSE;
>  }
>
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000cd17b6065ae2cd46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">The COM IEnumXxx/IE=
numUnknown::Next API allows callers to pass NULL for<br>
pceltFetched when celt is 1. Guard the write to prevent crashing.<br>
<br>
Fixes: b39297aedfab (&quot;qemu-ga: Add Windows VSS provider and requester =
as DLL&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/provider.cpp | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index 79906dcc24ae..377571b94881 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -117,7 +117,9 @@ STDMETHODIMP_(ULONG) CQGAVSSEnumObject::Release()<br>
=C2=A0STDMETHODIMP CQGAVSSEnumObject::Next(<br>
=C2=A0 =C2=A0 =C2=A0ULONG celt, VSS_OBJECT_PROP *rgelt, ULONG *pceltFetched=
)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 *pceltFetched =3D 0;<br>
+=C2=A0 =C2=A0 if (pceltFetched) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pceltFetched =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return S_FALSE;<br>
=C2=A0}<br>
<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000cd17b6065ae2cd46--


