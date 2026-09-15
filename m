Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C26C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QuZ-0007mm-Bg; Tue, 15 Sep 2026 07:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QuJ-0007hC-Jc
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QuI-0004xa-2Z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iWasyoka0YvY3UgIkaHUPnePfcJkz7F8rCVzauXG/k=;
 b=RqW3kCr8CYuQUXBr0N/VSW3+JBGgia+CohRErl7Ej7lHIL9hHoqmKP4wXiMuwvNfnboRB5
 wTwUeRsqwt7iRiopwqqtN4Hs3F/vBLoWjIUz5PDBcFDIPktxpArPXc8ptZX2DuEDE09dQ2
 EKwcKyKI9L7iSY/+m9B2CU+GE1UG8+E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-3RYxs2GWOjiveBW9JlmpQQ-1; Tue, 15 Sep 2026 07:00:50 -0400
X-MC-Unique: 3RYxs2GWOjiveBW9JlmpQQ-1
X-Mimecast-MFC-AGG-ID: 3RYxs2GWOjiveBW9JlmpQQ_1789470050
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91043af01d9so86403316d6.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470050; cv=none;
 d=google.com; s=arc-20260327;
 b=BlC2lD+Dbk/70g9PmpgH80fMhqPUtDoIqn4X0hc2Wkl11/iuYtDUVQ+wiplniZF1Bp
 gRYYaAMUuJpnDwvEsIGI2fvJ7a8oH9aUT8r6z8Ps6bqSxfh9IOUx1O15zjL9pWbIlst9
 I0wjtBMG7yMjEhx911DMY8sjcEu4YG9+3xPbWDSBwWex+kwgUjvblRkFR0Bqmk2BetE6
 7iwOn4RLsGbSsNN/bvaTeJVtJBDmPMG50zPV6f6kj3UUj4HrIqKIVckTw43f0PecWhpZ
 kOw8YodUaUbAwBEPJ9P9V/72UlPNZSmlBorfRdQPPypHA+zRq0dnG4S+5NFhWjk4/j+H
 uKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+iWasyoka0YvY3UgIkaHUPnePfcJkz7F8rCVzauXG/k=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=Adcq7aZGk7gbxGiiYScDp9tSTfE0dKvZ2W656dwpHWgyrEoiNO6fFn6Yr2PYx7hu28
 a7odDrE+fwGiODlB66N96lLPQTZtujaABNutWOS1LzG4AYWaDWOsQIyv62YGpi1rfrtJ
 FwZLvoecZGFw6zW6ambBkeQ+vaNWwORH6ohIki8AaBTgakABvw0h5ht0ijBs/SxhJKgX
 xPEhIoXqYd+qm/0CegkWQvsekkDzL1M7+F2mRcPxtpSPzLmcquwrHqqKv7wlz7cnuVEM
 DnmWFr6Bae8rqC/cHGGY1ne+kS9GyR0m2MfuhAmKR6MuojqvX4r4Iuvlp1Is9J+bnJcG
 0cow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470050; x=1790074850; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+iWasyoka0YvY3UgIkaHUPnePfcJkz7F8rCVzauXG/k=;
 b=nxqIcXcK6L/Gvheo9WtXGLxUWjO9BxfhcNHZbFerbOlH6ZYXyJXotE7dDIwqB71dYz
 X4AZ8IHiHg0rFDq7ECyGKcbvdq+3G2+zKshX4WGToF00e4YbV5YEXq1Sfjg1EqHRgkTx
 iai5Iqfu1JiLNCvKhlfok2VcW3tOrPuKma/tf/69yihhx0kBkdjvGlfqyFru2X3yuJ1Z
 UsvRcy2mBgH1a0HfZdrj1qIBZ2xyUFW3BwaiHolCEE5ixi5ikH8YH/rFgXIyB8lUfO1/
 S62A3fBSlgASYjn/2WueL0LroFk+G9OK8FaNBjHGwu4b80Spjw2JRHPNzVQkiU1Rliba
 v0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470050; x=1790074850;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+iWasyoka0YvY3UgIkaHUPnePfcJkz7F8rCVzauXG/k=;
 b=JszemTRAkjtu1LOgbKnsR4uNHj25RVhc1gEnWXpWxAKdEjZP1xbr4Q/NR6i7ciEef0
 iihvIoZsDc6L5OJ+W5vn1sXlfRKW0Xre87Vfhr+/Gqwn310GbJHqbyQojdNKKcwByxa8
 sDKPY2FHNwkSQMwSJmxdRF6WZSg9ldqr0wYHxybPugMndl20+TcSXxCgtlH4D/k8XxoQ
 rzvRFa8E9qj8wi5aCCVAieJmGizSB1O7f+3/gQULgocoel549eVBDSqrRvq03X8E01uD
 rtLVzUvNg7EtvoXvDTKsCS/Hi8cHKCt271oMIbZmTRnm4Sd6E4jKvHaEbtFiY8I6C8GP
 iUIQ==
X-Gm-Message-State: AFuF++lFwWI9+1HUEwWHI4vmPSHe17QVxgdOaPt2OjaEUyJQWcIrtTDw
 Xq3GUXCqzbFRTxogg/mUbNXl6s3pjyKo9vHeN8s2VCpXBNV+E1qEK4OD3rHeZq13HG8S9Us2HJf
 4HVso763HxNFBX7CpvqPRgvi49J/w0Wyx1tCxZ+aK49Q5uwjFWJWa/C+leK24SvdJ3o3JPXoD5h
 8w4J62inAOgzQTYO6iXFDjgthmb2UHewk=
X-Gm-Gg: AYBFou0Qr6TnBuYu+NX6Gv/+MRLve23ysR/kBN89kdLiW+SbeBnErgzCbP8l86gGgCA
 JDtRwNxbSkXA75eEay83ThWrI772F6DjzeeZFREQkgy27AvuDCifo/QZiPl0K9MwyvYHXEDfpjQ
 Vw+scnBtUU/Hm+XgjedQ34A9cD35eyO7pqUoK11P7y+4YoYCaKacLbVgJrZbg=
X-Received: by 2002:a05:6214:588f:b0:8fd:d5a7:f970 with SMTP id
 6a1803df08f44-9123a46b389mr6275456d6.11.1789470050203; 
 Tue, 15 Sep 2026 04:00:50 -0700 (PDT)
X-Received: by 2002:a05:6214:588f:b0:8fd:d5a7:f970 with SMTP id
 6a1803df08f44-9123a46b389mr6265596d6.11.1789470044832; Tue, 15 Sep 2026
 04:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-11-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-11-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:00:33 +0300
X-Gm-Features: AcwNN1WUpzod6Mmg2iZ-6euBX_uhg0T5vD2ePl760Ry4p9CY9d0286xeFmiHCo4
Message-ID: <CAPMcbCrtU=BBGnvdjwsT7JrXQjKd5d_CD1-sj5MKLBYwsgYJog@mail.gmail.com>
Subject: Re: [PATCH 11/17] qga/vss-win32: avoid CRT calls in DllMain debug
 logging
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000005be501065b837607"
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

--0000000000005be501065b837607
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> qga_debug() uses vsnprintf, snprintf and fputs while DllMain holds the
> loader lock. CRT I/O can deadlock under the loader lock. Replace with
> direct OutputDebugStringA calls, which are safe to call from DllMain.
>
> Fixes: 61df91b33caf ("QGA VSS: Add log in functions begin/end")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/provider.cpp | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index 44c3c74bd2f2..1c8eb236e57f 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -536,11 +536,11 @@ BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD
> dwReason, LPVOID lpReserved);
>  EXTERN_C
>  BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserve=
d)
>  {
> -    qga_debug("begin, reason =3D %lu", dwReason);
> +    OutputDebugStringA(QGA_PROVIDER_NAME ": DllMain begin\n");
>      if (dwReason =3D=3D DLL_PROCESS_ATTACH) {
>          g_hinstDll =3D hinstDll;
>          DisableThreadLibraryCalls(hinstDll);
>      }
> -    qga_debug_end;
> +    OutputDebugStringA(QGA_PROVIDER_NAME ": DllMain end\n");
>      return TRUE;
>  }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--0000000000005be501065b837607
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">q=
ga_debug() uses vsnprintf, snprintf and fputs while DllMain holds the<br>
loader lock. CRT I/O can deadlock under the loader lock. Replace with<br>
direct OutputDebugStringA calls, which are safe to call from DllMain.<br>
<br>
Fixes: 61df91b33caf (&quot;QGA VSS: Add log in functions begin/end&quot;)<b=
r>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/provider.cpp | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index 44c3c74bd2f2..1c8eb236e57f 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -536,11 +536,11 @@ BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReaso=
n, LPVOID lpReserved);<br>
=C2=A0EXTERN_C<br>
=C2=A0BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpRese=
rved)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 qga_debug(&quot;begin, reason =3D %lu&quot;, dwReason);<br>
+=C2=A0 =C2=A0 OutputDebugStringA(QGA_PROVIDER_NAME &quot;: DllMain begin\n=
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (dwReason =3D=3D DLL_PROCESS_ATTACH) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_hinstDll =3D hinstDll;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DisableThreadLibraryCalls(hinstDll);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 qga_debug_end;<br>
+=C2=A0 =C2=A0 OutputDebugStringA(QGA_PROVIDER_NAME &quot;: DllMain end\n&q=
uot;);<br>
=C2=A0 =C2=A0 =C2=A0return TRUE;<br>
=C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--0000000000005be501065b837607--


